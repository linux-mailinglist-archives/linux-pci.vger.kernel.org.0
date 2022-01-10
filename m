Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E166488EA0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 03:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiAJCVh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 21:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiAJCVg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 21:21:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BF7C06173F
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 18:21:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C5ED61126
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 02:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B29C36AEB;
        Mon, 10 Jan 2022 02:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641781294;
        bh=fwMzkUGrOc9jyiZkpGZAtpxJf9LJXqEcnc+KKGBFvf8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ar30fuVGg1V2g41ZPuij/58aOVQyg3aKxP8VS1YkTIb0ovXVH4rsRFKXIS0o1wuy3
         o1zTCUgYsF5Tos8BP1/kqYV+UlWK2niqJwEEkynEBGo7TLLekRAbJjD+ZDt4eQVfWg
         opAQapfVoSySv0pw29DPXfppBn6sU1ybkPtaelnOz4XgJ947fs51xHn9mWg7jrZgfE
         tI9DA5+B1q3YfX5W7E6e1weTNk/hmU8ZrVFmRYrEL5VVdjkxxvrR3tBYfX6QeatE2W
         bLgjHSQjWtzT0/KYga4o1j/a+DxEY4zavfNPeNNsWgBlF+U4kS8qb/Z/On9v7peWLt
         tFRUU6mkpAEiQ==
Date:   Mon, 10 Jan 2022 03:21:27 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
        Zachary Zhang <zhangzg@marvell.com>,
        Wilson Ding <dingwei@marvell.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] PCI: aardvark: Implement emulated root PCI bridge
Message-ID: <20220110032127.4ea60dc9@thinkpad>
In-Reply-To: <20220107212736.GA404447@bhelgaas>
References: <20180629092231.32207-4-thomas.petazzoni@bootlin.com>
        <20220107212736.GA404447@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 7 Jan 2022 15:27:36 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Jun 29, 2018 at 11:22:31AM +0200, Thomas Petazzoni wrote:
> 
> > +static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> > +{
> > +	struct pci_sw_bridge *bridge = &pcie->bridge;  
> 
> > +	/* Support interrupt A for MSI feature */
> > +	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;  
> 
> Only 3.5 years later, IIUC, this is the value you get when you read
> PCI_INTERRUPT_PIN, so I think this should be PCI_INTERRUPT_INTA, not
> PCIE_CORE_INT_A_ASSERT_ENABLE.
> 
> Readers expect to get the values defined in the PCI spec, i.e.,
> 
>   PCI_INTERRUPT_UNKNOWN
>   PCI_INTERRUPT_INTA
>   PCI_INTERRUPT_INTB
>   PCI_INTERRUPT_INTC
>   PCI_INTERRUPT_INTD

Hello Bjorn,

now sent v2 of batch 4 of fixes for pci-aardvark, where this is fixed
in the first patch.
  https://lore.kernel.org/linux-pci/20220110015018.26359-1-kabel@kernel.org/
Could you find time to review the series? :-)

Marek
