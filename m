Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E18487E40
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 22:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiAGV1j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 16:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiAGV1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 16:27:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA365C061574
        for <linux-pci@vger.kernel.org>; Fri,  7 Jan 2022 13:27:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8979462019
        for <linux-pci@vger.kernel.org>; Fri,  7 Jan 2022 21:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F23C36AE5;
        Fri,  7 Jan 2022 21:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641590858;
        bh=O8L8frEPR6ADTtnoidH4cv+S5JH+gvpt/0dLHTkTmqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=g8SKATUWnc60ODX1UIYn0yCqsB8WLouAN2c7XfsLrpLnokNgCMnVb7SPCnJ4xcwpA
         tbTxEhUuv3j5pZr8e/UTKx2t5sosuaPakdRcir6cyUZ7jOiOimmyCJx9yaBFtw3FA2
         i8dMRMFw2LrblkHqBg/KyyjQkvcf6saQ4RJ8b5EufY14y/Fh+Ov0dR9Ad3805IegAN
         EbEryUqSJWAJC0gEU4Ki/Y7/hNfsOeJePrVGm3xhMpr/wbmSs+nR3oSCgvhWCIca7v
         29hTSiHnx5yrFe99mPEWyY1kuXpRJATzHHQmRYx0BzWsXvscJkfQDISIzwQQcIoh5u
         HgzNc9NhhQDEQ==
Date:   Fri, 7 Jan 2022 15:27:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Zachary Zhang <zhangzg@marvell.com>,
        Wilson Ding <dingwei@marvell.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] PCI: aardvark: Implement emulated root PCI bridge
Message-ID: <20220107212736.GA404447@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629092231.32207-4-thomas.petazzoni@bootlin.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 29, 2018 at 11:22:31AM +0200, Thomas Petazzoni wrote:

> +static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> +{
> +	struct pci_sw_bridge *bridge = &pcie->bridge;

> +	/* Support interrupt A for MSI feature */
> +	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;

Only 3.5 years later, IIUC, this is the value you get when you read
PCI_INTERRUPT_PIN, so I think this should be PCI_INTERRUPT_INTA, not
PCIE_CORE_INT_A_ASSERT_ENABLE.

Readers expect to get the values defined in the PCI spec, i.e.,

  PCI_INTERRUPT_UNKNOWN
  PCI_INTERRUPT_INTA
  PCI_INTERRUPT_INTB
  PCI_INTERRUPT_INTC
  PCI_INTERRUPT_INTD

Bjorn
