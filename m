Return-Path: <linux-pci+bounces-25004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7ACA763CD
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 12:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4172B1886625
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83BD1DE4D8;
	Mon, 31 Mar 2025 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="L8c4RwBW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GdC/BMez"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093391531DB;
	Mon, 31 Mar 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415560; cv=none; b=ia1tNb6LzV7ky/8WzUJfFXT6XjS3u77c6Cq7hU1ryMcvjZtZHt3EXDA2JWgNq5EcY8bzCYEX1FPHhUMQYd1F/vZZlQhw8/mThUFp+JaAhoZH8Op8DnU71YgQJSeahEIYH3DZRe1OegqcPiNP1PSeaWKxh+VpqHdDMk+87vq/KIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415560; c=relaxed/simple;
	bh=AsDgzAUT8sMUKV7TwxR7XvfZ619TcnK+8Y0nOvvr09k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpcb22jjP3EA2yVonfyemUA74Y2DhuPNtdx/11E+0p3b0hn4YrgOLVoHO3LON4G6odtBSa5eJdUjz+xSLANTZ0Htw7xphLaYNAl2yO8ln/OzeU1uum74ZSBZnQzjlzXTzC70fWmJVpU42VoztcTEOpQOFv4rgtuLq2Ut9RSmZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=L8c4RwBW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GdC/BMez; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DC2561384409;
	Mon, 31 Mar 2025 06:05:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 31 Mar 2025 06:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743415556;
	 x=1743501956; bh=nchhUVuAAorL0EgxuZL9IZu5rkzQ0M46OJLLbl4XGVw=; b=
	L8c4RwBW7/oqaiqL+U6FvAV9TP70RZmpwsABCfNCAkXlgnWljqr0XkFJ4U5cSxca
	0XYAE0oqR/IrFbmA7U3he1jIahWPPPMFGPvN62bqbZ27x5pG102866Ca1t+1jIS1
	SsUmJW2+NuE8Vnlpjgn22Kg9SixBIZEJxucmdxaAEsm5eCgfYf5uQMRBCIh6yqvo
	Wv50T/bDdPou/ETRrzCrcB14HIVsnSzz3l9UP3U9iGwmy7InPjhpfQ0BOmYfjxrS
	EwpyJ6fhQzV76PMtE3qeSNJQGUnQN6Y6J2rJLKSTLH9c33cTNRGmnTtMWeuAqYxt
	k16WGQ8oBmRAuWlYhMNqNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743415556; x=
	1743501956; bh=nchhUVuAAorL0EgxuZL9IZu5rkzQ0M46OJLLbl4XGVw=; b=G
	dC/BMezhE+nwSTfFWtYwXcCkrexLE6O42p9w+cI6Fben4D9l2S1FvXGfiuYXAUwp
	gc+rIqFLDANbIQ99Au39fgRN9WMKi2Iv+cXHUKyPjUFagRkOOSEz2i0RwZhuMtUE
	WBuxyLAkxvYjZD0E2s8YYs3AeMmCQaE0GcHEoplKTrolIPnq8PF8Z/z6FckXrKGn
	I65iD2B7DQ+Bl7U11jlbHugHMyxbzMW7fLZFGmJj5yJbWckWlqctMZMb+qEBMdur
	cqWUPyGBEhmkgBhhMWD92RU8bPAu2aGIHMMR6YOgAW7yKMtVDy0GvbKG+ooTi9jr
	kfO2pRlAsE8hFPYnKl5jg==
X-ME-Sender: <xms:AmnqZ2n7pqDbpJL1RHdxJzCsqtl-oEtJHh-wrefGoP2f4p_wLqb6Tg>
    <xme:AmnqZ919u4d4_awZxE4oG8RPS75WqZGuchUYpzDFFOFPZXIEz72mO4XqKEAYdVOwz
    Bc4AS2VAaOdpA0VP4g>
X-ME-Received: <xmr:AmnqZ0p9BeNKZ7v8rPx7msDXjnRg53CYH3X2ivfk30vzmxtfb3I95PBLZNE3mHRN1JtWqVLM3syGgTTiZ26fykCSartG20KYWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefpihhklhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrsh
    houggvrhhluhhnugesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeev
    teegtddvvdfhtdekgefhfeefheetheekkeegfeejudeiudeuleegtdehkeekteenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdr
    shhouggvrhhluhhnugesrhgrghhnrghtvggthhdrshgvpdhnsggprhgtphhtthhopedvfe
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgvkhdrvhgrshhuthdorhgv
    nhgvshgrshesmhgrihhlsghogidrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqd
    hkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehk
    fieslhhinhhugidrtghomhdprhgtphhtthhopehrrghfrghlsehmihhlvggtkhhirdhplh
    dprhgtphhtthhopegrqdgshhgrthhirgdusehtihdrtghomhdprhgtphhtthhopegshhgv
    lhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptghonhhorhdoughtsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggv
    rhdrsggvpdhrtghpthhtohephhgvihhkohesshhnthgvtghhrdguvg
X-ME-Proxy: <xmx:AmnqZ6lAAolEv1lvwEz_JB_6KLN_eRAvAmSnu5EmxUtpG4O-ZNqTpg>
    <xmx:AmnqZ00iHcKdzkrwMjLJw8URFY2SBJWHPwr84_gtoJGGSuPg5JCoMA>
    <xmx:AmnqZxtlG7mWiNymiwke6d86mwSCcge3sM6lDmzPbMdagVDvudWMPA>
    <xmx:AmnqZwXgAX-oQNc3hcAmTVsasfhFkPNzH-ndN9CV1pwDC79cDHhzDw>
    <xmx:BGnqZ1WgrfeLKtJmIWlaD2RGmCaO_7r4vmu3jTbEb4sm6R9dCZ7I2asu>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 06:05:54 -0400 (EDT)
Date: Mon, 31 Mar 2025 12:05:52 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>,
	Kever Yang <kever.yang@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: renesas: r8a779g3: Add Renesas R-Car V4H
 Sparrow Hawk board support
Message-ID: <20250331100552.GC233273@ragnatech.se>
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>

Hi Marek,

Thanks for your work.

On 2025-03-30 21:56:08 +0200, Marek Vasut wrote:
> Add Renesas R-Car V4H Sparrow Hawk board based on R-Car V4H ES3.0 (R8A779G3)
> SoC. This is a single-board computer with single gigabit ethernet, DSI-to-eDP
> bridge, DSI and two CSI2 interfaces, audio codec, two CANFD ports, micro SD
> card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe SSD, debug
> UART and JTAG.
> 
> The board uses split clock for PCIe controller and device, which requires
> slight extension of rcar-gen4-pci-host.yaml DT schema, to cover this kind
> of description. The DWC PCIe controller driver already supports this mode
> of clock operation, hence no driver change is needed.

For the whole series,

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
> Marek Vasut (4):
>   dt-bindings: PCI: rcar-gen4-pci-host: Document optional aux clock
>   dt-bindings: vendor-prefixes: Add Retronix Technology Inc.
>   dt-bindings: soc: renesas: Document Renesas R-Car V4H Sparrow Hawk
>     board support
>   arm64: dts: renesas: r8a779g3: Add Renesas R-Car V4H Sparrow Hawk
>     board support
> 
>  .../bindings/pci/rcar-gen4-pci-host.yaml      |   8 +-
>  .../bindings/soc/renesas/renesas.yaml         |   7 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/renesas/Makefile          |   2 +
>  .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 671 ++++++++++++++++++
>  5 files changed, 687 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
> 
> ---
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: "Rafał Miłecki" <rafal@milecki.pl>
> Cc: Aradhya Bhatia <a-bhatia1@ti.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Junhao Xie <bigfoot@classfun.cn>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> 
> -- 
> 2.47.2
> 
> 

-- 
Kind Regards,
Niklas Söderlund

