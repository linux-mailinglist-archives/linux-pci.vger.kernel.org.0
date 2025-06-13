Return-Path: <linux-pci+bounces-29793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C36DAD97EB
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 00:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA8A1BC0A51
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFFD244676;
	Fri, 13 Jun 2025 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOEU3psk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097DD1547E7;
	Fri, 13 Jun 2025 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852068; cv=none; b=QxcdSqa6OMTMtHduqpb2IDoygeH2wC1vB3tGo0fzpmn/Z6JrW9fZHGUz0q+5lnUQKyVciej1gfeSWIPo863IGMiF/k8zu1CRbYhDQbp1fMYBgWp9qLxQPBlgS6KKMLBmRjHuDVOMIg4kgBxT//XzmjetS7Vx9t2jomSCC0elKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852068; c=relaxed/simple;
	bh=Q4i3PDbu1STbHbbwGxaxWMYZqyXSfts65HVlG376auM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TmG/I93zNRYRlAPhAH5PstWwZS4z1oCnOrn+GxqbrItIICDZVWImO8pSUDCOfPvdVAFRXV8kYamqsceJA8L7KAkCYxJSDuk1iOL0NUsVzgcvRt5fbTLQ8T1JPdhfFuyX7UEWTEt3FHY8BAOG19kiWdz75ZNDwWGNBYbiuTPcENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOEU3psk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E85EC4CEE3;
	Fri, 13 Jun 2025 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749852066;
	bh=Q4i3PDbu1STbHbbwGxaxWMYZqyXSfts65HVlG376auM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rOEU3pskrhCUXIC9exM3DbnLO6Z58LFRstZMwm8FRcCm0ZE3V/XyBigJUPeR1L7LT
	 H4Mv+8zYRbncG5Bz5Fa0BQYBdWY4TEB1xwBQxxGYK2t5w+/lgDSau+Ep34MGIuxF0f
	 kebzay7p4cr0MApOqLaU+vvhAE+vjdFVIILnJevr9V6cm9/ByzXzBut0B+RIvYRF86
	 w1ex6y4ew3wA8G3wuk0lqj803k4XuH1x+qx6wzWmjYASinLYCySaA5198ruiFBCMhx
	 blCti/bipt1jx9/Scmwffs/CYkkqlMSap2iR5cA4Z1qQ7IlHE1CMvonlmUE02m6ooG
	 7GwhfZIl2MAbw==
Date: Fri, 13 Jun 2025 17:01:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Anand Moon <linux.amoon@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI/pwrctrl: Add optional slot clock to pwrctrl
 driver for PCI slots
Message-ID: <20250613220104.GA986309@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW_89naftFMo881zp=7QGJDznFzzqLQ-kLEuyJ=KJWQnA@mail.gmail.com>

On Thu, Jun 12, 2025 at 03:16:45PM +0200, Geert Uytterhoeven wrote:
> On Sat, 7 Jun 2025 at 21:46, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
> > Add the ability to enable optional slot clock into the pwrctrl driver.
> > This is used to enable slot clock in split-clock topologies, where the
> > PCIe host/controller supply and PCIe slot supply are not provided by
> > the same clock. The PCIe host/controller clock should be described in
> > the controller node as the controller clock, while the slot clock should
> > be described in controller bridge/slot subnode.
> >
> > Example DT snippet:
> > &pcicontroller {
> >     clocks = <&clk_dif 0>;             /* PCIe controller clock */
> >
> >     pci@0,0 {
> >         #address-cells = <3>;
> >         #size-cells = <2>;
> >         reg = <0x0 0x0 0x0 0x0 0x0>;
> >         compatible = "pciclass,0604";
> >         device_type = "pci";
> >         clocks = <&clk_dif 1>;         /* PCIe slot clock */
> >         vpcie3v3-supply = <&reg_3p3v>;
> >         ranges;
> >     };
> > };
> >
> > Example clock topology:
> >  ____________                    ____________
> > |  PCIe host |                  | PCIe slot  |
> > |            |                  |            |
> > |    PCIe RX<|==================|>PCIe TX    |
> > |    PCIe TX<|==================|>PCIe RX    |
> > |            |                  |            |
> > |   PCIe CLK<|======..  ..======|>PCIe CLK   |
> > '------------'      ||  ||      '------------'
> >                     ||  ||
> >  ____________       ||  ||
> > |  9FGV0441  |      ||  ||
> > |            |      ||  ||
> > |   CLK DIF0<|======''  ||
> > |   CLK DIF1<|==========''
> > |   CLK DIF2<|
> > |   CLK DIF3<|
> > '------------'
> >
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Bartosz: Any chance you can apply this patch to an immutable branch,
> so I can merge that before taking the other two patches?
> The alternative is to postpone the DTS patches for one cycle.

I applied this patch only to pci/pwrctrl for v6.17 and made a note
that the commit should be immutable:

  66db1d3cbdb0 ("PCI/pwrctrl: Add optional slot clock for PCI slots")

We will likely add other pwrctrl patches to this branch during this
cycle; I assume that will be OK as long as 66db1d3cbdb0 remains
untouched, right?

Bjorn

