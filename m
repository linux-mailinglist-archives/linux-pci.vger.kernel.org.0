Return-Path: <linux-pci+bounces-37689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D91BC2DE3
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 00:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AAC74E702D
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 22:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FB9258CFA;
	Tue,  7 Oct 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tcj5x2B/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF0258CE1;
	Tue,  7 Oct 2025 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876138; cv=none; b=ScNum9+EfUkWHwFMlxrqYGt8VKT7ciHX8PCUticpcm318L3xfhJNoKZSah8x3wKNQ3mk2zlSFm0pVCLKzNrZC0BppV/RResmKGHZYdstxKfzGrwxtXgo5HPgFnOdrJOdOd9MImOcsbmqNSeV45aZq3KUZqm8cipDIbvoD/LoQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876138; c=relaxed/simple;
	bh=q1NIQivGIY3SwfX/q3BZNviiHdj8erzIHuByXvDQcxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQsRFXicC6m++D4bLMz6mNAlT1NeVc8c1QcP1LlZBP90LJ5rRse2dwuhYBBiRWZtex0+rUCiD4HTDo/YMaVO+XONA0UvGWu0Ji6I3GafXleytTEZ1dhSr0mGlHQc/vzgR3NnYlEJH1S6Q4SP+9VVb5Q57OywwXZbXsvpN5tczcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tcj5x2B/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885F6C4CEF1;
	Tue,  7 Oct 2025 22:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759876137;
	bh=q1NIQivGIY3SwfX/q3BZNviiHdj8erzIHuByXvDQcxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tcj5x2B/WgedHtt3nyUyH4Doenm+E7lYh81J/79yRQtF52tjsLI1brjh9hvm+TIOl
	 0ofyzdNfsh9AUnaS70qo1L+zvh8Sc3nbaxV3HhK3Db/mk2CAn28YmrYBFC3q8oN+Ex
	 clhRc2P16NBdgSSOPkq6LkjCpQtGtiYvdojGmd/Ttk/4q5I4agQoJIspfyjv0a7LTY
	 7wqwXcuLC/Gcghq19fSsZK6hhcI7CXyluaX829jCBemyfRJuK9Cbl98sHQW3Cbu1cx
	 Kl1NsE8ti526a87BptJsImMbdCBlJoxPT5NASfwALNCgMYsmUX31/vAutU6msKhAA8
	 Va4a5Zoac1amg==
Date: Tue, 7 Oct 2025 15:28:55 -0700
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, chester62515@gmail.com, 
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, 
	bhelgaas@google.com, jingoohan1@gmail.com, kwilczynski@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com, 
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, 
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, cassel@kernel.org
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <4rghtk5qv4u7vx4nogctquu3skvxis4npxfukgtqeilbofyclr@nhkrkojv3syh>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org>
 <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
 <aOU0w5Brp6uxjZDr@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOU0w5Brp6uxjZDr@lpieralisi>

On Tue, Oct 07, 2025 at 05:41:55PM +0200, Lorenzo Pieralisi wrote:
> On Mon, Sep 22, 2025 at 11:51:07AM +0530, Manivannan Sadhasivam wrote:
> 
> [...]
> 
> > > +                  /*
> > > +                   * non-prefetchable memory, with best case size and
> > > +                   * alignment
> > > +                   */
> > > +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> > 
> > s/0x82000000/0x02000000
> > 
> > And the PCI address really starts from 0x00000000? I don't think so.
> 
> Isn't the DWC ATU programmed to make sure that the PCI memory window DT
> provides _is_ the PCI "bus" memory base address ?
> 
> It is a question, I don't know the DWC inner details fully.
> 
> I don't get what you mean by "I don't think so". Either the host controller
> AXI<->PCI translation is programmable, then the PCI base address is what
> we decide it is or it isn't.
> 

As per the binding, I/O PCI address already starts from 0x0. How can you have
two OB mappings with same PCI address?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

