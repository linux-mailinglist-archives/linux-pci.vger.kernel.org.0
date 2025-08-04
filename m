Return-Path: <linux-pci+bounces-33349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15444B19D43
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 10:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072AA189214D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 08:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9E623AB8D;
	Mon,  4 Aug 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntIloNWl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C8230BD2;
	Mon,  4 Aug 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294665; cv=none; b=DEeEW4xyrJo8YqS0XGH1qogHBPbc4KGYWPDI/QI+R9hJ4QxzUMTmDujarqrndjBmEOePoEcClvTIDdpPOexgHLs82RXL5DqeqqbYk4Zdb5XJ7X386z+QCOgvoHc2SwXUHXwWRXMMWyJUfM0x1IRsAMZrDFh30oCsF5hw/pVexks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294665; c=relaxed/simple;
	bh=RKECXLolZ0+Hcz5RAIsl9N60kpDeOYEqxiBHrrjYHco=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VnG9hUzvTISnZVUHz6dIyY+DQH1sKNoxaIaNyzQAtm1Re2//Y2wWZfssPgKXedXac48VU9f04kl69HsmV7Z2Dcp6RTjDMzqYVIc/fMJ24qG4OPpSNWvhkmLVyttVxy+L7C3yAldDdywQnFXGf3hu7MBiCvcMjR9URlaRb6E/yDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntIloNWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D359CC4AF0B;
	Mon,  4 Aug 2025 08:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754294665;
	bh=RKECXLolZ0+Hcz5RAIsl9N60kpDeOYEqxiBHrrjYHco=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ntIloNWl7dkUnA4Ud+WOESb+RaoQQ2dR5bm9FGDhn5ciK3RJJyMAjXjrx1vHHvMPM
	 M2igx1ffKbH7yH0zcxq7TUWxp6Ba1cHkGzTTj5ucJVSwaG5vqyrjSZu1V0bLCIurh4
	 srMH/SJTozryxgsT7eP/BzFAXr2g/YsSQ3Ml5a5gp13dpfqvjxtA1Vu/xQj1i51Ojz
	 n0lbw9Oo2dbLPEyQwOcrP/nEWPd/D1bj2K3uj1CY+MAVqbEoDYxO3IPFCHDTXrnsrN
	 PhxqZJoCnC9hlA5kirTsfzVsit0ZKyjKGeUOiwrWNAj7p55hcFWs6OG6gzsDvjiQv5
	 dwfAr6v6QMVmw==
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id DEE52F40066;
	Mon,  4 Aug 2025 04:04:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 04 Aug 2025 04:04:23 -0400
X-ME-Sender: <xms:h2mQaOTvDGl2k3J9v9cSKPnak2UIF77Lx8E02Vnu7KRqqNt9ZJkqPg>
    <xme:h2mQaDwYL4BsiFCdjGVDjyt8YjfmxjfKAQ_gmgUoZ6npolQqU5lXmv4l8N4Mj4HEx
    uz9uDU8roPztJ3svSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepjeejffetteefteekieejudeguedvgfeffeeitdduieekgeegfeekhfduhfel
    hfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdeg
    qddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
    dpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopedu
    kedvheehuddujeduheelseduieefrdgtohhmpdhrtghpthhtohephhgrnhhsrdiihhgrnh
    hgsegtihigthgvtghhrdgtohhmpdhrtghpthhtohepjhhinhhgohhohhgrnhdusehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkfihi
    lhgtiiihnhhskhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlphhivghrrghlih
    hsiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:h2mQaFu7LhuyRrCKWhVwBTFKZTy29wc0MNFkqT6qbXBuqu7n9fT67Q>
    <xmx:h2mQaHSV16-CTyAh22EXVWSltH71ro2e80F6WNAkqDuefzyQ6pJ6Sw>
    <xmx:h2mQaKGL0ovkpIZnJ3tp8_ETHmsv9mhFdALfraI-euVJwXNXOapq2Q>
    <xmx:h2mQaBces6M1nvOF6jd5Rr51louf-pmXq0oy6IhxkJz2wY5zQC6_5w>
    <xmx:h2mQaJshPPqjSUIluVDY9rFZ3XsSShNj4P2CCMSyTl4P_ckuQRyQ413e>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B3B7E700065; Mon,  4 Aug 2025 04:04:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tea76caf5b1f73f76
Date: Mon, 04 Aug 2025 10:03:43 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Hans Zhang" <18255117159@163.com>, "Gerd Bayer" <gbayer@linux.ibm.com>,
 "Manivannan Sadhasivam" <mani@kernel.org>,
 "Hans Zhang" <hans.zhang@cixtech.com>
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, bhelgaas@google.com,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jingoohan1@gmail.com,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-next <linux-next@vger.kernel.org>, linux-pci@vger.kernel.org,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Message-Id: <74c17623-f1b5-4b28-a118-4e828e1e711a@app.fastmail.com>
In-Reply-To: <06012cc6-824d-4a7d-85c9-9995ec915382@163.com>
References: <20250731183944.GA3424583@bhelgaas>
 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
 <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
 <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
 <c8ffdd21-9000-40c2-9f4d-4d6318e730b5@cixtech.com>
 <cu7qdbwmnixqjce4aetr5ldwe3sqoixgq4fuzmzajzphjdywqq@yw6ojbgeqktm>
 <06f16b1a55eede3dc3e0bf31ff14eca89ab6f009.camel@linux.ibm.com>
 <06012cc6-824d-4a7d-85c9-9995ec915382@163.com>
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Aug 4, 2025, at 05:06, Hans Zhang wrote:
> On 2025/8/1 19:30, Gerd Bayer wrote:
>> On Fri, 2025-08-01 at 16:24 +0530, Manivannan Sadhasivam wrote:
>   }
>
> +#define CDNS_PCI_OP_READ(size, type, len)		\
> +static inline int cdns_pcie_read_cfg_##size		\
> +	(struct cdns_pcie *pcie, int where, type *val)	\
> +{							\
> +	if (len == 4)					\
> +		*val = cdns_pcie_readl(pcie, where);	\
> +	else if (len == 2)				\
> +		*val = cdns_pcie_readw(pcie, where);	\
> +	else if (len == 1)				\
> +		*val = cdns_pcie_readb(pcie, where);	\
> +	else						\
> +		return PCIBIOS_BAD_REGISTER_NUMBER;	\
> +							\
> +	return PCIBIOS_SUCCESSFUL;			\
> +}
> +
> +CDNS_PCI_OP_READ(byte, u8, 1)
> +CDNS_PCI_OP_READ(word, u16, 2)
> +CDNS_PCI_OP_READ(dword, u32, 4)
> +

This is fine for the calling conventions, but the use of a macro
doesn't really help readability, so I'd suggest just having
separate inline functions if they are even needed.

> @@ -112,17 +110,17 @@ int pci_bus_read_config(void *priv, unsigned int 
> devfn, int where, u32 size,
>   ({									\
>   	int __ttl = PCI_FIND_CAP_TTL;					\
>   	u8 __id, __found_pos = 0;					\
> -	u32 __pos = (start);						\
> -	u32 __ent;							\
> +	u8 __pos = (start);						\
> +	u16 __ent;							\
>   									\
> -	read_cfg(args, __pos, 1, &__pos);				\
> +	read_cfg##_byte(args, __pos, &__pos);				\
>   									\
>   	while (__ttl--) {						\
>   		if (__pos < PCI_STD_HEADER_SIZEOF)			\
>   			break;						\
>   									\
>   		__pos = ALIGN_DOWN(__pos, 4);				\
> -		read_cfg(args, __pos, 2, &__ent);			\
> +		read_cfg##_word(args, __pos, &__ent);			\
>   									\
>   		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
>   		if (__id == 0xff)					\

I still don't feel great about this macro either, and suspect
we should have a better abstraction with fixed types and a
global function to do it, but I don't see anything obviously
wrong here either.

     Arnd

