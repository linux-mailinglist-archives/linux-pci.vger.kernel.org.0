Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F073F6939
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 20:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhHXSsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 14:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhHXSsw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 14:48:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 478566135F;
        Tue, 24 Aug 2021 18:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629830887;
        bh=gCQ6CbEXwJN2QzEUHSSzmSFWnGGlEMHGERjS9vU6QvA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ApHpmxZAg2VDJEaVx4bWOe7fN/RWsLnxLnxCgpfHfVGrS3LuQgtLh8lz1j5yiMfnl
         JC8/4P8+wVnlQs7vXOUOLN2zU/2C7aC7BXQcXxmX5e2YO8/IOo7hZwRkrSXgu54Lzy
         MekxReZxSkHwZGpfYAP7floYuqqpohcIppThac3LoyXJRzRtZmc7pHpDUjkyC8nAOs
         W1Uapu58t302FJb6lXkt503mJ9n8vE9Pm9t/0BTnCLFabRavewu10Rt5C+URMqrAnL
         XnN9FGA5gj7V0yAv4mbuPTVnw/pYhX5R7ymftgQRUd/BALv9YG92q0a574/lIEyc/O
         wa2qwkdq1g9AQ==
Date:   Tue, 24 Aug 2021 13:48:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        Michael Chan <michael.chan@broadcom.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 00/12] PCI/VPD: Convert more users to the new VPD API
 functions
Message-ID: <20210824184806.GA3485298@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca29408-7bc7-4da5-59c7-87893c9e0442@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 22, 2021 at 03:46:20PM +0200, Heiner Kallweit wrote:
> This series converts more users to the new VPD API functions.
> 
> bnx2 patches have been tested with a BCM5709 card.
> The other patches are compile-tested, except cxlflash.
> 
> Heiner Kallweit (12):
>   sfc: falcon: Read VPD with pci_vpd_alloc()
>   sfc: falcon: Search VPD with pci_vpd_find_ro_info_keyword()
>   bnx2: Search VPD with pci_vpd_find_ro_info_keyword()
>   bnx2: Replace open-coded version with swab32s()
>   bnx2x: Read VPD with pci_vpd_alloc()
>   bnx2x: Search VPD with pci_vpd_find_ro_info_keyword()
>   bnxt: Read VPD with pci_vpd_alloc()
>   bnxt: Search VPD with pci_vpd_find_ro_info_keyword()
>   cxgb4: Validate VPD checksum with pci_vpd_check_csum()
>   cxgb4: Remove unused vpd_param member ec
>   cxgb4: Search VPD with pci_vpd_find_ro_info_keyword()
>   scsi: cxlflash: Search VPD with pci_vpd_find_ro_info_keyword()
> 
>  drivers/net/ethernet/broadcom/bnx2.c          | 46 +++-------
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x.h   |  1 -
>  .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 91 ++++---------------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 49 +++-------
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  2 -
>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    | 76 ++++++----------
>  drivers/net/ethernet/sfc/falcon/efx.c         | 79 ++++------------
>  drivers/scsi/cxlflash/main.c                  | 34 ++-----
>  8 files changed, 98 insertions(+), 280 deletions(-)

I added these to pci/vpd for v5.15, thanks!
