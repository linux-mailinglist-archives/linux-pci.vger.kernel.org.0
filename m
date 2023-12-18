Return-Path: <linux-pci+bounces-1144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAB1817662
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 16:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810321F272A2
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380883A1B6;
	Mon, 18 Dec 2023 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFPbmX03"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C13D576
	for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2023 15:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8944FC433C7;
	Mon, 18 Dec 2023 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702914851;
	bh=KMCGFZvJcuAP2d8/FORmzZAUOpBam7T89deeuQiMCZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFPbmX035ZOO2r+jcJiIborgkM/hR3dTiZCn3UaKAkfTJlONGu5RtN8OdFw5UPfcV
	 U70Iid9LRdi8yQJC9CXhoQEPtojLUn8MYBKAkVlhwrk5j08P5Uy6jcfyhf8tdClEeB
	 6cpfHLPI7gVQP52ze4ZgJctJR5F8EYpzS+t9dJmBQ/wSXk1gvZwIy/hZq+CDS1Y+Wg
	 vST4m8EbGKHIpIdokHVMCc3FHnzKUqk5CW56F+x1OYWFycc0nAJYXELQUYoCq3iP3J
	 c3Zb1cz3GKnTe3LjDxDKvciOBRtwr4bmgKtgXDST23lj3AFfDUlsouK28bVmVODYxU
	 gPrmTa6JE6Tfg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v4 00/16] Cleanup IRQ type definitions
Date: Mon, 18 Dec 2023 16:54:03 +0100
Message-Id: <170291475061.36287.10534285499931556427.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 22 Nov 2023 15:03:50 +0900, Damien Le Moal wrote:
> The first patch renames PCI_IRQ_LEGACY to PCI_IRQ_INTX as suggested by
> Bjorn (hence the patch authorship is given to him). The second patch
> removes the redundant IRQ type definitions PCI_EPC_IRQ_XXX and replace
> these with a direct use of the PCI_IRQ_XXX definitions. These 2 patches
> have been sent and reviewed previously but were never applied. Hence the
> resend with this new series version.
> 
> [...]

Applied to irq-clean-up, thanks! It might take a while before
we merge it into -next but it is targeting v6.8 anyway.

[01/16] PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
        https://git.kernel.org/pci/pci/c/58ff9c5acb4a
[02/16] PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions
        https://git.kernel.org/pci/pci/c/74955cb8ccc3
[03/16] PCI: endpoint: Use INTX instead of legacy
        https://git.kernel.org/pci/pci/c/8a608dac4bf6
[04/16] PCI: endpoint: Rename LEGACY to INTX in test function driver
        https://git.kernel.org/pci/pci/c/5b0fbadc0f87
[05/16] misc: pci_endpoint_test: Use INTX instead of LEGACY
        https://git.kernel.org/pci/pci/c/acd288666979
[06/16] PCI: portdrv: Use PCI_IRQ_INTX
        https://git.kernel.org/pci/pci/c/0e9149d9b864
[07/16] PCI: dra7xx: Rename dra7xx_pcie_raise_legacy_irq()
        https://git.kernel.org/pci/pci/c/a963ce0a542c
[08/16] PCI: cadence: Use INTX instead of legacy
        https://git.kernel.org/pci/pci/c/29e3e6620ab1
[09/16] PCI: dwc: Rename dw_pcie_ep_raise_legacy_irq()
        https://git.kernel.org/pci/pci/c/6847fc7fa27d
[10/16] PCI: keystone: Use INTX instead of legacy
        https://git.kernel.org/pci/pci/c/45b27ac543c0
[11/16] PCI: dw-rockchip: Rename rockchip_pcie_legacy_int_handler()
        https://git.kernel.org/pci/pci/c/50bdb9ef1dd1
[12/16] PCI: tegra194: Use INTX instead of legacy
        https://git.kernel.org/pci/pci/c/08fc17974dec
[13/16] PCI: uniphier: Use INTX instead of legacy
        https://git.kernel.org/pci/pci/c/b0908aed6eca
[14/16] PCI: rockchip-ep: Use INTX instead of legacy
        https://git.kernel.org/pci/pci/c/8072efc6bbe1
[15/16] PCI: rockchip-host: Rename rockchip_pcie_legacy_int_handler()
        https://git.kernel.org/pci/pci/c/a00e643ea9ed
[16/16] PCI: xilinx-nwl: Use INTX instead of legacy
        https://git.kernel.org/pci/pci/c/07e681ce7bdb

Thanks,
Lorenzo

