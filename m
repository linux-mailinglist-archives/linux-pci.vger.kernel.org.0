Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADCDA9BEF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 09:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbfIEHeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 03:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731476AbfIEHeT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 03:34:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 383DF20828;
        Thu,  5 Sep 2019 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567668858;
        bh=JyKjIUt2nlf6YhRXvLFSLhZ5RiYcJdGMf3i+c+LHOyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hILCyJtfJoxzeUKKtq2YIyKtBjRhelF7MHD+I4Igc4EqLvqKPJg4gdPrGT68kKM/k
         D+lpZJ75X4dh0ucyS5F+2NaKgabPDOYV4C2XT+Hepz5ALgh7iGN/bxbHFZX5H6aWWF
         7hVsBL7qlwVqTEGmiP588utsIMSqSJptHmZnfekU=
Date:   Thu, 5 Sep 2019 09:34:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bodong@mellanox.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ddutile@redhat.com, berrange@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH] PCI/IOV: Make SR-IOV attributes with mode 0664 use 0644
Message-ID: <20190905073416.GC29933@kroah.com>
References: <20190905063226.43269-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905063226.43269-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 12:32:26AM -0600, Kelsey Skunberg wrote:
> sriov_numvfs and sriov_drivers_autoprobe have "unusual" permissions (0664)
> with no reported or found reason for allowing group write permissions.
> libvirt runs as root when dealing with PCI, and chowns files for qemu
> needs. There is not a need for the "0664" permissions.
> 
> sriov_numvfs was introduced in:
> 	commit 1789382a72a5 ("PCI: SRIOV control and status via sysfs")
> 
> sriov_drivers_autoprobe was introduced in:
> 	commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to
> 			      control VF driver binding")
> 
> Change sriov_numvfs and sriov_drivers_autoprobe from "0664" permissions to
> "0644" permissions.
> 
> Exchange DEVICE_ATTR() with DEVICE_ATTR_RW() which sets the mode to "0644".
> DEVICE_ATTR() should only be used for "unusual" permissions.
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
>  drivers/pci/iov.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index b335db21c85e..b3f972e8cfed 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -375,12 +375,11 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
>  }
>  
>  static DEVICE_ATTR_RO(sriov_totalvfs);
> -static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
> +static DEVICE_ATTR_RW(sriov_numvfs);
>  static DEVICE_ATTR_RO(sriov_offset);
>  static DEVICE_ATTR_RO(sriov_stride);
>  static DEVICE_ATTR_RO(sriov_vf_device);
> -static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
> -		   sriov_drivers_autoprobe_store);
> +static DEVICE_ATTR_RW(sriov_drivers_autoprobe);
>  
>  static struct attribute *sriov_dev_attrs[] = {
>  	&dev_attr_sriov_totalvfs.attr,


Nice!!!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
