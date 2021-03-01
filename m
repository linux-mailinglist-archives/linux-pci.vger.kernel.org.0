Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EB7327964
	for <lists+linux-pci@lfdr.de>; Mon,  1 Mar 2021 09:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhCAIig (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Mar 2021 03:38:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233238AbhCAIiB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Mar 2021 03:38:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DBA964DDE;
        Mon,  1 Mar 2021 08:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614587840;
        bh=39SZ+cRVJGb8U+36jOtlXcTS2tWwiKMV8cQJIULK9N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCG0cye0Prf2J275bxYdmbft6xehryqOiTEBl0OPE0X02ttpDSN37S6tgHa4LAtB1
         AxLNs2nFogehzGovMMBXVEKDlCR8WB5VgMZCSlX0HIs/bR/uJkZv4crDLSlq7H0sUL
         frRoPiMPR8+zXjbJ5w1cFa6IN8syOV7T6P2izlKk=
Date:   Mon, 1 Mar 2021 09:37:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        Don Dutile <ddutile@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH mlx5-next v7 1/4] PCI: Add a sysfs file to change the
 MSI-X table size of SR-IOV VFs
Message-ID: <YDynvUsEGQ6bQGep@kroah.com>
References: <20210301075524.441609-1-leon@kernel.org>
 <20210301075524.441609-2-leon@kernel.org>
 <YDyicnnKPhy5LMJy@kroah.com>
 <YDymifxqjvnaW3nw@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDymifxqjvnaW3nw@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 01, 2021 at 10:32:09AM +0200, Leon Romanovsky wrote:
> On Mon, Mar 01, 2021 at 09:14:42AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Mar 01, 2021 at 09:55:21AM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > >
> > > A typical cloud provider SR-IOV use case is to create many VFs for use by
> > > guest VMs. The VFs may not be assigned to a VM until a customer requests a
> > > VM of a certain size, e.g., number of CPUs. A VF may need MSI-X vectors
> > > proportional to the number of CPUs in the VM, but there is no standard way
> > > to change the number of MSI-X vectors supported by a VF.
> > >
> > > Some Mellanox ConnectX devices support dynamic assignment of MSI-X vectors
> > > to SR-IOV VFs. This can be done by the PF driver after VFs are enabled,
> > > and it can be done without affecting VFs that are already in use. The
> > > hardware supports a limited pool of MSI-X vectors that can be assigned to
> > > the PF or to individual VFs.  This is device-specific behavior that
> > > requires support in the PF driver.
> > >
> > > Add a read-only "sriov_vf_total_msix" sysfs file for the PF and a writable
> > > "sriov_vf_msix_count" file for each VF. Management software may use these
> > > to learn how many MSI-X vectors are available and to dynamically assign
> > > them to VFs before the VFs are passed through to a VM.
> > >
> > > If the PF driver implements the ->sriov_get_vf_total_msix() callback,
> > > "sriov_vf_total_msix" contains the total number of MSI-X vectors available
> > > for distribution among VFs.
> > >
> > > If no driver is bound to the VF, writing "N" to "sriov_vf_msix_count" uses
> > > the PF driver ->sriov_set_msix_vec_count() callback to assign "N" MSI-X
> > > vectors to the VF.  When a VF driver subsequently reads the MSI-X Message
> > > Control register, it will see the new Table Size "N".
> > >
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-pci |  29 +++++++
> > >  drivers/pci/iov.c                       | 102 ++++++++++++++++++++++--
> > >  drivers/pci/pci-sysfs.c                 |   3 +-
> > >  drivers/pci/pci.h                       |   3 +-
> > >  include/linux/pci.h                     |   8 ++
> > >  5 files changed, 137 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > > index 25c9c39770c6..ebabd0d2ae88 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > > @@ -375,3 +375,32 @@ Description:
> > >  		The value comes from the PCI kernel device state and can be one
> > >  		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
> > >  		The file is read only.
> > > +
> > > +What:		/sys/bus/pci/devices/.../sriov_vf_total_msix
> > > +Date:		January 2021
> > > +Contact:	Leon Romanovsky <leonro@nvidia.com>
> > > +Description:
> > > +		This file is associated with a SR-IOV PF.  It contains the
> > > +		total number of MSI-X vectors available for assignment to
> > > +		all VFs associated with PF.  It will zero if the device
> >
> > "The value will be zero if the device..."
> 
> Thanks, will fix when apply or resend if more fixes will be needed.
> 
> >
> > And definition of "VF" and PF" are where in this file?
> 
> They come from the PCI spec. It is part of SR-IOV lingo.

Yes, and the world does not have access to the PCI spec, so please
provide a hint as to what they are for those of us without access to
such things.

thanks,

greg k-h
