Return-Path: <linux-pci+bounces-25005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4474A764F4
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 13:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBD21888B87
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AECE1E0E0B;
	Mon, 31 Mar 2025 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="yg4B3urw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWIRKvXT"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9761DE4DB;
	Mon, 31 Mar 2025 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743420526; cv=none; b=dtj0nauO0O6fzdawXF0J3GIutyMGVpI+1pTh+vYx98/p8dqlpPjRU23JJIKw6gT6eDiIrZB8Qa1vYXlnnExToS+GsL55dPUaekQOa4N/2hUVQzmfpns1JJzdDr1cudZGGVUcwQKoayCw22QYU57344oaN5X5vTVk4V2xngbihNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743420526; c=relaxed/simple;
	bh=D7x353QDKvTqsO0klPni1BKRbEzeNAwfYB/SF8bzz0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAAoJ6uL2fdkv4VB0VSmmxlu059mk4Dex9eERNUvljIS5B2/WubmS2gC557mgRAq2CL6rgwj9mBlIIFINwhSe32bM3XsPBgHMYb7ocjjaU5NFeRRyxF/CJJLd9U9V0uAbwtIail11MPLxIryHQomMO/tEi9fr5HEP3zM6Nt1Ilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=yg4B3urw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWIRKvXT; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A226D138441D;
	Mon, 31 Mar 2025 07:28:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 31 Mar 2025 07:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1743420523; x=1743506923; bh=R1fvNUJM+1
	07giQNxDtASFpEZ6IxMM9QfRNpZfhOjos=; b=yg4B3urwknbAULMsaA5bZ4IPUf
	gAjFsQe/RePHsI7+kgiJUQT6MdAmvc7iRMQY6ERi0rKkpd3cAUxByDOrq/bSFP2T
	qTHeBro9f4HsdZ1XtyGNOHxP2D5DA1cRrSPgktTj48J/8ojuitjY6k7MHKezq36X
	eH5bqg4le7WaCIyxCj5dvwbOpM1wfQlRGvMz8bWk3gk8X0MV2TEb+n4BXlyEBB8t
	jY8FqCzoRBph37/VRAHMdDM40wl4SWHPbnWdIRih6kvMDFl9t7GBmFkuUSStTrde
	snAHjwIG9FAZVAiwA1xcx1zZlbL2fscmubnCucJXH7QOVKg2uL7Lx86CXaoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743420523; x=1743506923; bh=R1fvNUJM+107giQNxDtASFpEZ6IxMM9QfRN
	pZfhOjos=; b=OWIRKvXTZ2yKPtYThutu5NLArnMgCvUKSuevNZ4JJqmmJpwG9jO
	cPo3Adu78HTleVeiMMSbsdsg7JZ98fSYO6BAGkBjdWfHnMjKjiR5tVlQssgLK5Ff
	VqumalrBGOpw+9y6dBGrt2+PjhcRGptLitimuNX1d+N9qoNQ0qtWtMFrw2u76oHs
	A0Mu1Lcdjotob5NOOH4p11eU0b8hgNJXO1wbITfmjU66sbtg0frsO4rNbI8zdNl9
	t9lwlTM5RhCIC9Y+9jsoMlfNsXUApoDy0Ahuw39nyOpa7w9gQQ0vRCXGSnZgj8Ot
	We9+m34LkwDxB77dLWGvlbf67ovPS7GkbKQ==
X-ME-Sender: <xms:anzqZzd-qCZE0w9Wy64ClmOY0eIN4MMvmGg2rtzv45Hiw20HROJ5Kw>
    <xme:anzqZ5NDzSt9jFp-tb2xWDX47cNngT_7fbJj2yrvHqc9U-uZTPxWjjEShhAqJxtin
    9lazJj-qVJeDyaWHWA>
X-ME-Received: <xmr:anzqZ8gvAM76vioAaZTQamMO-hWgbuk6PKDD-5uQZ64yt9pqqx0Fk9Nq2a0SaC2O0u9mcofh2cUQ71E3zEJFK7QYaGtuohWP3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqe
    enucggtffrrghtthgvrhhnpefgudeuffelfeekgeeukedtheekjeettdfftddujefhvdeh
    tefgiefgledtueefjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhn
    vghtpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhgriieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgv
    rhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinh
    hugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgt
    vghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshgrhhhi
    sehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprghlhihsshgrsehrohhsvg
    hniiifvghighdrihhopdhrtghpthhtohepmhgrrhgtrghnsehmrghrtggrnhdrshhtpdhr
    tghpthhtohepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:anzqZ090RaJB0KMMXF6aBKMES2LBwgMbJdMsY1dWT5npQOfjTCZ1tg>
    <xmx:anzqZ_tDKXVnKqYlOPo1yb0tDMevULx8eeul9ci0UDMw6ecVEcCMoA>
    <xmx:anzqZzEQ8MtXMAAAsJ16bqb7kD2mN6Z7El9ch70--5pDorzPx6LlMA>
    <xmx:anzqZ2N8jGFQqhwox4Bsl57H3wd7xqdYwnqYWcUR_ow1a1qrrBpaWA>
    <xmx:a3zqZ3PHDwJ0q8FmW-ovuhKONEvhW69bqgxEgulDoTgHzPkkRHGcfgJZ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 07:28:41 -0400 (EDT)
Date: Mon, 31 Mar 2025 13:28:38 +0200
From: Janne Grunau <j@jannau.net>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 00/13] PCI: apple: Add support for t6020
Message-ID: <20250331112838.GA246397@robin.jannau.net>
References: <20250325102610.2073863-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325102610.2073863-1-maz@kernel.org>

On Tue, Mar 25, 2025 at 10:25:57AM +0000, Marc Zyngier wrote:
> As Alyssa didn't have the bandwidth to deal with this series, I have
> taken it over. All bugs are therefore mine.
> 
> The initial series [1] stated:
> 
> "This series adds T6020 support to the Apple PCIe controller. Mostly
>  Apple shuffled registers around (presumably to accommodate the larger
>  configurations on those machines). So there's a bit of churn here but
>  not too much in the way of functional changes."
> 
> The biggest change is affecting the ECAM layer, allowing an ECAM
> driver to provide its own probe function instead of relying on the
> .init() callback to do the work. The ECAM layer can therefore be used
> as a library instead of a convoluted driver.
> 
> The rest is a mix of bug fixes, cleanups, and required abstraction.
> 
> This has been tested on T6020 (M2-Pro mini) and T8102 (M1 mini).
> 
> * From v1[1]:
> 
>   - Described the PHY registers in the DT binding
> 
>   - Extracted a ecam bridge creation helper from the host-common layer
> 
>   - Moved probing into its own function instead of pci_host_common_probe()
>     
>   - Moved host-specific data to the of_device_id[] table
> 
>   - Added dynamic allocation of the RID/SID bitmap
> 
>   - Fixed latent bug in RC-generated interrupts
> 
>   - Renamed reg_info to hw_info
> 
>   - Dropped useless max_msimap
> 
>   - Dropped code being moved around without justification
> 
>   - Re-split some of the patches to follow a more logical progression
> 
>   - General cleanup to fit my own taste
> 
> [1] https://lore.kernel.org/r/20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io
> 
> Alyssa Rosenzweig (1):
>   dt-bindings: pci: apple,pcie: Add t6020 compatible string
> 
> Hector Martin (6):
>   PCI: apple: Fix missing OF node reference in apple_pcie_setup_port
>   PCI: apple: Move port PHY registers to their own reg items
>   PCI: apple: Drop poll for CORE_RC_PHYIF_STAT_REFCLK
>   PCI: apple: Use gpiod_set_value_cansleep in probe flow
>   PCI: apple: Abstract register offsets via a SoC-specific structure
>   PCI: apple: Add T602x PCIe support
> 
> Janne Grunau (1):
>   PCI: apple: Set only available ports up
> 
> Marc Zyngier (5):
>   PCI: host-generic: Extract an ecam bridge creation helper from
>     pci_host_common_probe()
>   PCI: ecam: Allow cfg->priv to be pre-populated from the root port
>     device
>   PCI: apple: Move over to standalone probing
>   PCI: apple: Dynamically allocate RID-to_SID bitmap
>   PCI: apple: Move away from INTMSK{SET,CLR} for INTx and private
>     interrupts
> 
>  .../devicetree/bindings/pci/apple,pcie.yaml   |  11 +-
>  drivers/pci/controller/pci-host-common.c      |  24 +-
>  drivers/pci/controller/pcie-apple.c           | 241 +++++++++++++-----
>  drivers/pci/ecam.c                            |   2 +
>  include/linux/pci-ecam.h                      |   2 +
>  5 files changed, 204 insertions(+), 76 deletions(-)

Whole series is
Tested-by: Janne Grunau <j@jannau.net>
on t6020 and t8103 based Apple silicon devices.

ciao
Janne

