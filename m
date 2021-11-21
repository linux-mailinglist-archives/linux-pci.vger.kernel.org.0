Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB26E458361
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 13:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbhKUMed (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Nov 2021 07:34:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237951AbhKUMed (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 21 Nov 2021 07:34:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24A4E60E54;
        Sun, 21 Nov 2021 12:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637497888;
        bh=EoeQm9C3wSEDl8ywX9BTGB6uTnymAI7q/suW4MEAlRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GG3syEThaDdxM4aL1G60Xv5AWV8SrObra35Lnv4WnFDaiM9Ol3idIiutqkuucv7+5
         BtEh9hNuLyWBJW/ItyIMM6dkEzdSmkmVFZ9ICTxJ8Drf07bnhRVE+3sDmiviRl55fl
         pHfpzPWJNcvT+D1qCqkCwnG+A5AGB4ZqzmWXDLEg=
Date:   Sun, 21 Nov 2021 13:31:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YZo8HUxx8LNgOMeK@kroah.com>
References: <20211120231705.189969-1-david.e.box@linux.intel.com>
 <20211120231705.189969-5-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120231705.189969-5-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 20, 2021 at 03:17:05PM -0800, David E. Box wrote:
> +static ssize_t registers_read(struct file *filp, struct kobject *kobj,
> +			      struct bin_attribute *attr, char *buf, loff_t off,
> +			      size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct sdsi_priv *priv = dev_get_drvdata(dev);
> +	void __iomem *addr = priv->regs_addr;
> +
> +	memcpy_fromio(buf, addr + off, count);

Oh nice, this will be fun if I provide "interesting" values for off to
the function right?

Remember:
	All input is evil.

> +
> +	return count;
> +}
> +static BIN_ATTR(registers, 0400, registers_read, NULL, SDSI_SIZE_REGS);
> +
> +static struct bin_attribute *sdsi_bin_attrs[] = {
> +	&bin_attr_registers,
> +	&bin_attr_state_certificate,
> +	&bin_attr_provision_akc,
> +	&bin_attr_provision_cap,
> +	NULL
> +};
> +
> +static ssize_t guid_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct sdsi_priv *priv = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "0x%x\n", priv->guid);

sysfs_emit() please.

These sysfs attributes are crazy.  Who has audited them to be correct
and work properly?  It feels like there are just buffer overflows
waiting to be exploited in them due to the reading/writing of raw memory
buffers all over the place.

Where is the userspace tool that uses these files?

thanks,

greg k-h
