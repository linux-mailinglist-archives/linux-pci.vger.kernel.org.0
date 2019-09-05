Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E09AAAFC
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 20:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbfIES3l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 14:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbfIES3l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 14:29:41 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0A920825;
        Thu,  5 Sep 2019 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567708181;
        bh=T0ll8J6r0R1Visw0vbgL4AIx3iScvCP1sF/nv3g3ZCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Py/zzvOgfmDbynLZ9gYju9DVSSesq1A4AfxzrmxTBSYpwD+XvDSPH9gJhaRfIYfXU
         UrboWcXDkqHBYkltpkcFFLa179lH9nqe1bqg/0mdC4M3iryPuJfXAuwo4MSLbRRMDe
         qM5Qap7bztJQ6dCTRpIm2xOA6LL4rZSVUr4kNH2Q=
Date:   Thu, 5 Sep 2019 13:29:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, berrange@redhat.com,
        ddutile@redhat.com, bodong@mellanox.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Eli Cohen <eli@mellanox.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] PCI/IOV: Make SR-IOV attributes
 with mode 0664 use 0644
Message-ID: <20190905182938.GD103977@google.com>
References: <20190905063226.43269-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905063226.43269-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Bodong, Eli: just FYI since this affects sriov_drivers_autoprobe,
which you added with 0e7df22401a3]

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

Applied with Greg's Reviewed-by and Don's Acked-by to pci/misc for
v5.4, thanks!

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
> -- 
> 2.20.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
