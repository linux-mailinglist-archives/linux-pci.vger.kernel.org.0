Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68388494A3C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 10:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiATJBY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 04:01:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54362 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiATJBW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 04:01:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72D8A617A3;
        Thu, 20 Jan 2022 09:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B19C340E0;
        Thu, 20 Jan 2022 09:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642669281;
        bh=EUYYyJZvsDHtXEUDBb0y8fad6mgH8XQAdDK9Q3inYaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gb5aX/6GI4Qa/6JtH600/Ufmmw83oIV9SabZj8BpkL9PwHMCTugLorZztF9ndIJS+
         oYTx4CrCOzAWSzho9feXudrCCig6G8CZsbDYYRiwVlu5EKFEdtcrHV1adrytofzLS6
         e7Zg5I/PxJPyHZ/44ug53aagYj5ZfaUrNlH8/zSlNEmBspOHRV6v9H1GpU/oILlNnZ
         8Q3A1N7wdPOcC0nRxnpbdjLvARV2vWSiGuAkoD6e2MeO1SB60KgHlaeAhiYtIvK11J
         p4s/AiL2Sb/1V0YAJHZGEg6hRMTk+GxYklV2vGV9szw+jfPu3MwtszKSs1i8ZK+XI9
         8tOfsTqVDUrEw==
Received: by pali.im (Postfix)
        id ABC2E791; Thu, 20 Jan 2022 10:01:18 +0100 (CET)
Date:   Thu, 20 Jan 2022 10:01:18 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] PCI: Small improvements for pci-bridge-emul and
 mvebu
Message-ID: <20220120090118.3f3ioi7wqvrl5usu@pali>
References: <20211221141455.30011-1-pali@kernel.org>
 <20220104153529.31647-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220104153529.31647-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo, could you please review these patches? There are here
without any new comments for month.

On Tuesday 04 January 2022 16:35:18 Pali Rohár wrote:
> This patch series contains small improvements for pci-bridge-emul and
> mvebu drivers. This patch series is based on top of the patches:
> https://lore.kernel.org/linux-pci/20211125124605.25915-1-pali@kernel.org/
> (which are now in pci/mvebu branch)
> 
> In V2 was added comment into code explaining PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
> and PCI_BRIDGE_EMUL_NO_IO_FORWARD flags.
> 
> Pali Rohár (11):
>   MAINTAINERS: Add Pali Rohár as pci-mvebu.c maintainer
>   PCI: pci-bridge-emul: Make struct pci_bridge_emul_ops as const
>   PCI: pci-bridge-emul: Rename PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR to
>     PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
>   PCI: pci-bridge-emul: Add support for new flag
>     PCI_BRIDGE_EMUL_NO_IO_FORWARD
>   PCI: mvebu: Add help string for CONFIG_PCI_MVEBU option
>   PCI: mvebu: Remove duplicate nports assignment
>   PCI: mvebu: Set PCI_BRIDGE_EMUL_NO_IO_FORWARD when IO is unsupported
>   PCI: mvebu: Properly initialize vendor, device and revision of
>     emulated bridge
>   PCI: mvebu: Update comment for PCI_EXP_LNKCAP register on emulated
>     bridge
>   PCI: mvebu: Update comment for PCI_EXP_LNKCTL register on emulated
>     bridge
>   PCI: mvebu: Fix reporting Data Link Layer Link Active on emulated
>     bridge
> 
>  MAINTAINERS                           |  1 +
>  drivers/pci/controller/Kconfig        |  4 ++
>  drivers/pci/controller/pci-aardvark.c |  2 +-
>  drivers/pci/controller/pci-mvebu.c    | 64 ++++++++++++---------------
>  drivers/pci/pci-bridge-emul.c         | 11 ++++-
>  drivers/pci/pci-bridge-emul.h         | 14 +++++-
>  6 files changed, 57 insertions(+), 39 deletions(-)
> 
> -- 
> 2.20.1
> 
