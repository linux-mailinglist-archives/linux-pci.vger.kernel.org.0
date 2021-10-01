Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCAB41E856
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 09:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhJAHbc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 03:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231431AbhJAHbb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 03:31:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C2E861A51;
        Fri,  1 Oct 2021 07:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633073388;
        bh=6ZrgR9l0FJZySMqf3l7bNeL0L7lIFADsOxvQCQs3h6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hVvERRioo1zewV9pxBkLVVH/zGi2gt/e4e5utnqjxS8xqMh3CwTYLbEo64kGaNIqC
         LunCtGlNHJct0eyKQLLxTBtd3exVs6PUmTrJwps8962fg94M0+u5P22+hdrtdSTBJk
         svh6HKuj0dO2zp/tXQrY+wty2V+MtStOZcuVsxxQ=
Date:   Fri, 1 Oct 2021 09:29:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YVa46eU1VX7CM+Xd@kroah.com>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
 <20211001012815.1999501-6-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001012815.1999501-6-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 06:28:15PM -0700, David E. Box wrote:
> +static long sdsi_device_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct miscdevice *miscdev = file->private_data;
> +	struct sdsi_priv *priv = to_sdsi_priv(miscdev);
> +	void __user *argp = (void __user *)arg;
> +	long ret = -EINVAL;
> +
> +	if (!priv->dev_present)
> +		return -ENODEV;
> +
> +	if (!priv->sdsi_enabled)
> +		return -EPERM;
> +
> +	if (cmd == SDSI_IF_READ_STATE)
> +		return sdsi_if_read_state_cert(priv, argp);
> +
> +	mutex_lock(&priv->akc_lock);
> +	switch (cmd) {
> +	case SDSI_IF_PROVISION_AKC:
> +		/*
> +		 * While writing an authentication certificate disallow other openers
> +		 * from using AKC or CAP.
> +		 */
> +		if (!priv->akc_owner)
> +			priv->akc_owner = file;
> +
> +		if (priv->akc_owner != file) {

Please explain how this test would ever trigger and how you tested it?

What exactly are you trying to protect from here?  If userspace has your
file descriptor, it can do whatever it wants, don't try to be smarter
than it as you will never win.

And why are you using ioctls at all here?  As you are just
reading/writing to the hardware directly, why not just use a binary
sysfs file to be that pipe?  What requires an ioctl at all?

thanks,

greg k-h
