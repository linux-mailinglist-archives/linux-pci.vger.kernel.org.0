Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC9630E61B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 23:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhBCWeJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 17:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232679AbhBCWeE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 17:34:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDF9164F60;
        Wed,  3 Feb 2021 22:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612391603;
        bh=SU93X/dLj/O4dxzL3tZabdkks0gkHS7Hl/zs63xxgoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CytkYwap+IhyrXIUEDb8dD+v96QlEtYPxdQBuKIJziszhiAFt6Gn7qFSKDSYRatxZ
         PLYzHpuHA4OgBZshJ1bU2yqbDkUnM7DKvbibTZrvynkt3I4CMKC3RU1eCchwYGzCgw
         CgimbjuNBn+CB3bjX7CXgjbMT4aD8F13FVDD7fj8=
Date:   Wed, 3 Feb 2021 23:33:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RESEND v4 1/6] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <YBsksQC980VNVPqd@kroah.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
 <bba090c3d9d3d90fb2dfe5f2aaa52c155d87958f.1612390291.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bba090c3d9d3d90fb2dfe5f2aaa52c155d87958f.1612390291.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 03, 2021 at 11:12:46PM +0100, Gustavo Pimentel wrote:
> +	/* Sysfs */
> +	err = sysfs_create_group(&pdev->dev.kobj, &xdata_attr_group);
> +	if (err)
> +		return err;
> +
> +	err = sysfs_create_link(kernel_kobj, &pdev->dev.kobj,
> +				DW_XDATA_DRIVER_NAME);
> +	if (err)
> +		return err;

Huge hint, if you EVER call sysfs_* in a driver, you are doing something
wrong.

You just raced userspace and lost, use the default attribute group for
your driver so that the driver core can automatically create the needed
sysfs files.

And drop the symlink, that's just crazy, never do that, I don't think
it's doing what you think it is doing, not to mention you did not
document it...

thanks,

greg k-h
