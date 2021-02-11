Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B25A31872E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 10:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhBKJeY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 04:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhBKJbG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 04:31:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DC4164DD7;
        Thu, 11 Feb 2021 09:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613035820;
        bh=owwOwMiQhlPcn1c+6oHqr0dP+lwt7+MoKjG7O+8g430=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNDDhWYMIpQyU5enIIFHGRnhi2bmoNUpo2RVDVBhhU15tkx23KF63HJKvPwfk6/o2
         NjCNSFutAyw2wXBycpnJFDbl581eNmjXVlSn0eIEJXkpK3/ckagPoo0VBgixiRvhZ7
         Nu0BcdOLfEVgSIy0X2lI4TU6hSL99Jp9HvFvd6ZQ=
Date:   Thu, 11 Feb 2021 10:30:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 1/6] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <YCT5KDnAWex8fvbz@kroah.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 10:08:38AM +0100, Gustavo Pimentel wrote:
> +static ssize_t write_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct dw_xdata *dw = pci_get_drvdata(pdev);
> +	u64 rate;
> +
> +	mutex_lock(&dw->mutex);
> +	dw_xdata_perf(dw, &rate, true);
> +	mutex_unlock(&dw->mutex);
> +
> +	return sysfs_emit(buf, "%llu MB/s\n", rate);

Do not put units in a sysfs file, that should be in the documentation,
otherwise this forces userspace to "parse" the units which is a mess.

Same for the other sysfs file.

And why do you need a lock for this show function?

thanks,

greg k-h
