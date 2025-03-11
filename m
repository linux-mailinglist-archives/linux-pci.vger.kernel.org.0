Return-Path: <linux-pci+bounces-23437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC75A5C61C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 16:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807B2166501
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B526125EFBB;
	Tue, 11 Mar 2025 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfqmSQj6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F525EFB3;
	Tue, 11 Mar 2025 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706371; cv=none; b=UAdAzMWLcCJlAzF2iwKHxTvrsA5kDQPJbO+CQ877ib7iDVAPwdJtiYem72ZLIwKCryOdjtY77PDJHrDe3256p36vZ1M+WYe9/NFpVgIYq0rEfgQbPhZT577fiTYAfgWR5uUbDD0DKURf9S9ZGue0J5WD8Zdv+iQSjGxsbibClFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706371; c=relaxed/simple;
	bh=kEz7CxS008YfwVhh4yUlV3vqB8axwYnYnPqCS7q2/Hc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=S2xSYzahwIQzLvPZ1K4E/w+qHepH5PN/1o+AYKHGAhv5nVz4X1caOazg+3DSmVQg42MCvrmJmt8IGavRo4emDCArJIWf6PQsK9jsESXCVLPyk96/4RIbtoOskO7I/gv/YAuwD7QL1XpenNFTxtunawGCjT+GoW5/zfYbUl01FKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfqmSQj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26528C4CEED;
	Tue, 11 Mar 2025 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741706371;
	bh=kEz7CxS008YfwVhh4yUlV3vqB8axwYnYnPqCS7q2/Hc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=qfqmSQj6eyHYXgCkKovEaUCj5JIrjOFNzn2Pvvx8/22cmvpo7DRyJ7Dr50gV6fJ6Y
	 J4/Rm8N4Xa2hSFPI1MBEfAFRDZtZXaBKjXTfhh9u1ntBl7dSa8umeu5JgGG+zjsWaU
	 pV6NDoSa2vWwtVJUI6Ew7W2wjKsXIL2p77SGoFaDIblxqUcHGtk62jWN2qC5lUkiuG
	 pBhsPDVFOcWabgvfeX6z98AkEuaGN/R0Q9ZULlKehy8lsr+rpSS6GOReCWv2sceXQI
	 MXMQ4ZcuUJkHZJKGmWLS/02XRso4UGyOQKR8ol9EEo2AfPUOc40TULIc6OeG7duKr6
	 kATP3MtjEWyiw==
Date: Tue, 11 Mar 2025 10:19:30 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@axis.com, linux-kernel@vger.kernel.org, 
 Lars Persson <lars.persson@axis.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>
In-Reply-To: <Z8huvkENIBxyPKJv@axis.com>
References: <20250304-axis-v1-0-ed475ab3a3ed@nxp.com>
 <Z8huvkENIBxyPKJv@axis.com>
Message-Id: <174170613961.3566466.13045709851799071104.robh@kernel.org>
Subject: Re: [PATCH RFC NOT TESTED 0/2] PCI: artpec6: Try to clean up
 artpec6_pcie_cpu_addr_fixup()


On Wed, 05 Mar 2025 16:33:18 +0100, Jesper Nilsson wrote:
> Hi Frank,
> 
> I'm the current maintainer of this driver. As Niklas Cassel wrote in
> another email, artpec-7 was supposed to be upstreamed, as it is in most
> parts identical to the artpec-6, but reality got in the way. I don't
> think there is very much left to support it at the same level as artpec-6,
> but give me some time to see if the best thing is to drop the artpec-7
> support as Niklas suggested.
> 
> Unfortunately, I'm travelling right now and don't have access to any
> of my boards. I'll perform some testing next week when I'm back and
> help to clean this up.
> 
> Best regards,
> 
> /Jesper
> 
> 
> On Tue, Mar 04, 2025 at 12:49:34PM -0500, Frank Li wrote:
> > This patches basic on
> > https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/
> >
> > I have not hardware to test and there are not axis,artpec7-pcie in kernel
> > tree.
> >
> > Look for driver owner, who help test this and start move forward to remove
> > cpu_addr_fixup() work.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Frank Li (2):
> >       ARM: dts: artpec6: Move PCIe nodes under bus@c0000000
> >       PCI: artpec6: Use use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()
> >
> >  arch/arm/boot/dts/axis/artpec6.dtsi       | 92 +++++++++++++++++--------------
> >  drivers/pci/controller/dwc/pcie-artpec6.c | 20 +------
> >  2 files changed, 52 insertions(+), 60 deletions(-)
> > ---
> > base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
> > change-id: 20250304-axis-6d12970976b4
> >
> > Best regards,
> > ---
> > Frank Li <Frank.Li@nxp.com>
> 
> /^JN - Jesper Nilsson
> --
>                Jesper Nilsson -- jesper.nilsson@axis.com
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/axis/' for Z8huvkENIBxyPKJv@axis.com:

arch/arm/boot/dts/axis/artpec6-devboard.dtb: /bus@c0000000/pcie@f8050000: failed to match any schema with compatible: ['axis,artpec6-pcie', 'snps,dw-pcie']
arch/arm/boot/dts/axis/artpec6-devboard.dtb: /bus@c0000000/pcie_ep@f8050000: failed to match any schema with compatible: ['axis,artpec6-pcie-ep', 'snps,dw-pcie']






