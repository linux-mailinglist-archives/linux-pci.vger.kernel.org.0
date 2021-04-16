Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6A36286E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 21:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbhDPTOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 15:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235122AbhDPTOj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Apr 2021 15:14:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CF28613C1;
        Fri, 16 Apr 2021 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618600454;
        bh=5dm5KVnxFRJembB/VgI1Ppzv+0z4eLutOSiQBVqI5nA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L6VFLa+SCvdq8xYh5DAdY02Tnk5GMz+YOK+CjU4yOZsYfb1mtYxURNq7piu/yiRSp
         a9YCjPHZhNFuEnvtBVufENE+PxU33xleSYQgfhs350+3Uu5h6UxwmqXeJ7gFSlLhLU
         s0ONkpOfJm+0/tkRYYzxR810Km60eY9UAqX5ekHGxEp6bATFVD5azNJg4HTYIqFREg
         c+nDPMRmXSVb2//Vu3YcMERpDXoStOeZgjT67Nh/XV1YYHCKJn26EpeOxrabg/pHTL
         wg0uxxIK8OaidA9CfdCeSNLKwlA+/PvDeWlash2vid/hN5QBsxPqcl7a9I6eDuru3d
         boYGquYltb1EQ==
Date:   Fri, 16 Apr 2021 14:14:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/3] PCI/VPD: Some improvements
Message-ID: <20210416191413.GA2744655@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a0155ce-6c20-b653-d319-58e6505a1a40@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 01, 2021 at 06:35:23PM +0200, Heiner Kallweit wrote:
> This series includes some improvements. No functional change intended.
> 
> Heiner Kallweit (3):
>   PCI/VPD: Change pci_vpd_init return type to void
>   PCI/VPD: Remove argument off from pci_vpd_find_tag
>   PCI/VPD: Improve and simplify pci_vpd_find_tag
> 
>  drivers/net/ethernet/broadcom/bnx2.c          |  2 +-
>  .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  3 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
>  drivers/net/ethernet/broadcom/tg3.c           |  4 +-
>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    |  2 +-
>  drivers/net/ethernet/sfc/efx.c                |  2 +-
>  drivers/net/ethernet/sfc/falcon/efx.c         |  2 +-
>  drivers/pci/pci.h                             |  2 +-
>  drivers/pci/vpd.c                             | 40 +++++--------------
>  drivers/scsi/cxlflash/main.c                  |  3 +-
>  include/linux/pci.h                           |  3 +-
>  11 files changed, 21 insertions(+), 44 deletions(-)

Applied to pci/vpd for v5.13, thanks!
