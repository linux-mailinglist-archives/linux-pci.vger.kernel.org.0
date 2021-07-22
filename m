Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4B53D2CFE
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 21:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhGVTKb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 15:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhGVTKb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 15:10:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A479F60E0C;
        Thu, 22 Jul 2021 19:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626983466;
        bh=qmh/XfiasDTjNxr5oY9wV0+zREgS9vDDrruaVzmUdSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bJ5OrINsRYn2tg/gAdhEQI5SoF14V9HHqbdb0B7YEoi6iix0pPG/BG6uLziX9VVBo
         k/S3PNWBIx31Y2PmCZ/ygTVpWWdOtASZF1RivL0QmO7d0NsN2jLE6/EppO4jQtDnYv
         iXKNnBkVrrWymJaKgIhtPZJkCorF0pVXQ/JlUtmRwuKLwHORGX8/QpvWpBUAMyzDTn
         7Le9RZ0w67TlrjufrdBUklypQFyx+5hKcmphsQAqGBHtzFMTLT259Mf5/VcAzjOBPW
         YVwFc5Sde090KYfwqZs7WjJzSmtsqvS5AwO7AfndyOspGtYBLoP4/5s7GaHGvsluBB
         nnBdya5LVeEfQ==
Date:   Thu, 22 Jul 2021 14:51:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [pci:review/vga] BUILD SUCCESS WITH WARNING
 b6f0a577c4fbcc4f1e7eaf0e9a30bcfd20002b44
Message-ID: <20210722195104.GA336804@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722193529.GA333109@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22, 2021 at 02:35:29PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 22, 2021 at 02:06:19PM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git review/vga
> > branch HEAD: b6f0a577c4fbcc4f1e7eaf0e9a30bcfd20002b44  FIXME PCI/VGA: Rework default VGA device selection
> > 
> > possible Warning in current branch:
> > 
> > drivers/pci/vgaarb.c:1045:8: warning: %d in format string (no. 6) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
> 
> At b6f0a577c4fb ("FIXME PCI/VGA: Rework default VGA device
> selection"), line 1045 in vgaarb.c does not contain a format string:
> 
>   1042  #define PCI_INVALID_CARD       ((struct pci_dev *)-1UL)
>   1043
>   1044  /*
>   1045   * Each user has an array of these, tracking which cards have locks
>   1046   */
>   1047  struct vga_arb_user_card {
>   1048          struct pci_dev *pdev;
> 
> Where's the info so I can reproduce this?  Compiler version and
> options, .config file, etc?

Never mind, I think I found it manually.  At 4e5cfb7f1564 ("PCI/VGA:
Move vgaarb to drivers/pci"), line 1045 *was* an snprintf that used %d
for unsigned values.

> > Warning ids grouped by kconfigs:
> > 
> > gcc_recent_errors
> > `-- arm-randconfig-p001-20210720
> >     `-- drivers-pci-vgaarb.c:warning:d-in-format-string-(no.-)-requires-int-but-the-argument-type-is-unsigned-int-.-invalidPrintfArgType_sint
