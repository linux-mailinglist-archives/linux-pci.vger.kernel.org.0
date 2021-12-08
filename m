Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20546CDB1
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 07:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbhLHGZp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 01:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbhLHGZo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 01:25:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2DBC061574
        for <linux-pci@vger.kernel.org>; Tue,  7 Dec 2021 22:22:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A0D8FCE19BA
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 06:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7203AC00446;
        Wed,  8 Dec 2021 06:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638944529;
        bh=eiPxxP16JDkon4m/LlRix4vyXMIa2XyaUi9rZA8k5Q8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u9amCIpiFWBZJokN1iHSKlQnfVXVeYvJ8wbin2V9huz7IfOO2NHfdoWqAmDtKuM0D
         svKmChV32n1weOl3eU+qXXVrqY/2IYnKnDjI6R4A40pT9zQA0SS1JEkIwrW4Ag65qB
         k5iH/vf7ByJZptSxyn2n6XarwZEtIrfx7cbMXr8IbEK7ZUEPDNQaE8p0b4amFZcd95
         /7PHiSj/BilDDbatPdg0F8XJLauCJViVbkQEX31+RYZNaC7mYrq8NB5H9O+XR1NOKy
         GSbGPkSy31gHdKBa8F0AEKGrRoLCExk4ArFBtA1B8il/li5tFT/14FVKScI4F/FddK
         dC6BYhFXjSkSg==
Date:   Wed, 8 Dec 2021 07:22:05 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 00/17] PCI: aardvark controller fixes BATCH 4
Message-ID: <20211208072205.47134b27@thinkpad>
In-Reply-To: <20211208061851.31867-1-kabel@kernel.org>
References: <20211208061851.31867-1-kabel@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Marc,

sorry about this, I wanted to send this series also to you, but
I accidentally sent it to your @arm.com e-mail address.
Does that address still work? Should I resend to your @kernel.org
address?

Marek

On Wed,  8 Dec 2021 07:18:34 +0100
Marek Beh=C3=BAn <kabel@kernel.org> wrote:

> Hello Lorenzo, Marc,
>=20
> this is batch 4 of patches for Aardvark PCIe controller driver.
>=20
> This series mainly fixes and adds support for stuff around interrupts.
> (All but the first one.)
>=20
> I have rebased it sot that first come patches that change the API to the
> new one, as Marc requested. Marc, could you find time to review these?
>=20
> Marek
>=20
> Marek Beh=C3=BAn (1):
>   PCI: aardvark: Drop __maybe_unused from advk_pcie_disable_phy()
>=20
> Pali Roh=C3=A1r (16):
>   PCI: aardvark: Rewrite IRQ code to chained IRQ handler
>   PCI: aardvark: Fix support for MSI interrupts
>   PCI: aardvark: Fix reading MSI interrupt number
>   PCI: aardvark: Refactor unmasking summary MSI interrupt
>   PCI: aardvark: Add support for masking MSI interrupts
>   PCI: aardvark: Fix setting MSI address
>   PCI: aardvark: Enable MSI-X support
>   PCI: aardvark: Add support for ERR interrupt on emulated bridge
>   PCI: aardvark: Fix reading PCI_EXP_RTSTA_PME bit on emulated bridge
>   PCI: aardvark: Optimize writing PCI_EXP_RTCTL_PMEIE and
>     PCI_EXP_RTSTA_PME on emulated bridge
>   PCI: aardvark: Add support for PME interrupts
>   PCI: aardvark: Fix support for PME requester on emulated bridge
>   PCI: aardvark: Use separate INTA interrupt for emulated root bridge
>   PCI: aardvark: Check return value of generic_handle_domain_irq() when
>     processing INTx IRQ
>   PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
>   PCI: aardvark: Don't mask irq when mapping
>=20
>  drivers/pci/controller/pci-aardvark.c | 332 +++++++++++++++++++-------
>  1 file changed, 245 insertions(+), 87 deletions(-)
>=20

