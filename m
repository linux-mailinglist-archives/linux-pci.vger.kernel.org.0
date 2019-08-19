Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A25C0950FF
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 00:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfHSWmL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 18:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbfHSWmG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Aug 2019 18:42:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C32D22070B;
        Mon, 19 Aug 2019 22:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566254525;
        bh=FWUSRBqWIkXVrpG41Z3Z/YIYiHI8sow/YeEcRJR6Vcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gs1FfhBRXaBHyr57o9oATABoRJjx1zQt3RdMVp1wffmp7eJ9+lY1UBssWFYNeLE7Z
         /VIS4QU4IxKu3956s1N4Eduku3jyrDEnnb3TgkoiIgNCknepDu5BWsp7R/3w9g+xyF
         6uWvM3VFvizuyJ+CSQ7L4RdZtk+lNHLg+wv1Mw8w=
Date:   Mon, 19 Aug 2019 17:42:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ddutile@redhat.com, bodong@mellanox.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v3 0/4] PCI: Clean up pci-sysfs.c
Message-ID: <20190819224203.GV253360@google.com>
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190815153352.86143-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815153352.86143-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 15, 2019 at 09:33:49AM -0600, Kelsey Skunberg wrote:
> This series is designed to clean up device attributes and permissions in
> pci-sysfs.c. Then move the sysfs SR-IOV functions from pci-sysfs.c to
> iov.c for better organization.
> 
> Patch 1: Define device attributes with DEVICE_ATTR* instead of __ATTR*.
> 
> Patch 2: Change permissions from symbolic to the preferred octal.
> 
> Patch 3: Change DEVICE_ATTR() with 0220 permissions to DEVICE_ATTR_WO().
> 
> Patch 4: Move sysfs SR-IOV functions to iov.c to keep the feature's code
> together.
> 
> 
> Patch 1, 2, and 4 will report unusual permissions '0664' used from the
> following:
> 
>   static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show,
>                      sriov_numvfs_store);
> 
>   static DEVICE_ATTR(sriov_drivers_autoprobe, 0664,
>                      sriov_drivers_autoprobe_show,
>                      sriov_drivers_autoprobe_store);
> 
> This series preserves the existing permissions set in:
> 
> 
>   commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control
>                         VF driver binding")
> 
>   commit 1789382a72a5 ("PCI: SRIOV control and status via sysfs")
> 
> Either adding a comment verifying permissions are okay or changing the
> permissions is to be completed with a new patch.
> 
> Changes since v1:
>         Add patch 1 and 2 to fix the way device attributes are defined
>         and change permissions from symbolic to octal. Patch 4 which moves
>         sysfs SR-IOV functions to iov.c will then apply cleaner.
> 
> Changes since v2:
> 
>         Patch 1: Commit log updated. Example shows DEVICE_ATTR_RO()
>         example instead of DEVICE_ATTR(). DEVICE_ATTR() should be avoided
>         unless the files have unusual permissions. Changed to reflect a
>         more encouraged usage.  Also updated regex to be accurate.
> 
>         Patch 3: [NEW] Add patch to change DEVICE_ATTR() with 0220
>         permissions to DEVICE_ATTR_WO().
> 
>         Updated series log to reflect new patch and unusual permissions
>         information.
> 
> 
> Kelsey Skunberg (4):
>   PCI: sysfs: Define device attributes with DEVICE_ATTR*
>   PCI: sysfs: Change permissions from symbolic to octal
>   PCI: sysfs: Change DEVICE_ATTR() to DEVICE_ATTR_WO()
>   PCI/IOV: Move sysfs SR-IOV functions to iov.c
> 
>  drivers/pci/iov.c       | 168 ++++++++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c | 223 ++++------------------------------------
>  drivers/pci/pci.h       |   2 +-
>  3 files changed, 191 insertions(+), 202 deletions(-)

Thanks, I applied the new DEVICE_ATTR_WO() patch as the *second* patch
so the two DEVICE_ATTR patches were together.  I added Greg and Don's
Reviewed-by to all and Kuppuswamy's to the last.  This is all on
pci/virtualization for v5.4.

Bjorn
