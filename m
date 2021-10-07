Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C20425467
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241882AbhJGNks (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 09:40:48 -0400
Received: from foss.arm.com ([217.140.110.172]:54798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241743AbhJGNk1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 09:40:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08B606D;
        Thu,  7 Oct 2021 06:38:34 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.53.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C69933F66F;
        Thu,  7 Oct 2021 06:38:32 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, pali@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 00/13] PCI: aardvark controller fixes
Date:   Thu,  7 Oct 2021 14:38:25 +0100
Message-Id: <163361366612.462.10245349222624047259.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211005180952.6812-1-kabel@kernel.org>
References: <20211005180952.6812-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 5 Oct 2021 20:09:39 +0200, Marek Behún wrote:
> as requested I am sending v2 of this series.
> 
> Changes since v1:
> - updated commit message in patch 6 as suggested by Mark
> - updated patch 6 to also drop the early return
> - changed the LTSSM definitions to enum in patch 12
> - dropped the Fixes tags for those patches where it was inappropriate
> 
> [...]

I rewrote some logs, dropped some stable tags. This series raised
a couple of interesting questions that may be relevant for PCI core
as well, it'd be great if those won't be lost but I feel it is time
to merge this series to help Marek/Pali cut the patch delta and
give this code wider testing.

I have applied it to pci/aardvark, please _do_ have a look and
report back any issue with it.

[01/13] PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
        https://git.kernel.org/lpieralisi/pci/c/460275f124
[02/13] PCI: aardvark: Fix PCIe Max Payload Size setting
        https://git.kernel.org/lpieralisi/pci/c/a4e17d65da
[03/13] PCI: aardvark: Don't spam about PIO Response Status
        https://git.kernel.org/lpieralisi/pci/c/464de7e7ff
[04/13] PCI: aardvark: Fix preserving PCI_EXP_RTCTL_CRSSVE flag on emulated bridge
        https://git.kernel.org/lpieralisi/pci/c/d419052bc6
[05/13] PCI: aardvark: Fix configuring Reference clock
        https://git.kernel.org/lpieralisi/pci/c/46ef6090db
[06/13] PCI: aardvark: Do not clear status bits of masked interrupts
        https://git.kernel.org/lpieralisi/pci/c/a7ca6d7fa3
[07/13] PCI: aardvark: Do not unmask unused interrupts
        https://git.kernel.org/lpieralisi/pci/c/1fb95d7d3c
[08/13] PCI: aardvark: Deduplicate code in advk_pcie_rd_conf()
        https://git.kernel.org/lpieralisi/pci/c/67cb2a4c93
[09/13] PCI: aardvark: Implement re-issuing config requests on CRS response
        https://git.kernel.org/lpieralisi/pci/c/223dec14a0
[10/13] PCI: aardvark: Simplify initialization of rootcap on virtual bridge
        https://git.kernel.org/lpieralisi/pci/c/454c53271f
[11/13] PCI: aardvark: Fix link training
        https://git.kernel.org/lpieralisi/pci/c/f76b36d40b
[12/13] PCI: aardvark: Fix checking for link up via LTSSM state
        https://git.kernel.org/lpieralisi/pci/c/661c399a65
[13/13] PCI: aardvark: Fix reporting Data Link Layer Link Active
        https://git.kernel.org/lpieralisi/pci/c/2b650b7ff2

Thanks,
Lorenzo
