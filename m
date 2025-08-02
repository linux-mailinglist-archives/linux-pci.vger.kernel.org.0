Return-Path: <linux-pci+bounces-33335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA3B18F3C
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 17:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D522BAA10B0
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8841ACEDC;
	Sat,  2 Aug 2025 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvw+/6xR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF91A5BBE;
	Sat,  2 Aug 2025 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754149271; cv=none; b=i5sXdnx0C+ePSW3tmHpsZ5Ebg8/3pDQ676nbMYHwUmNg0aOugSvyHxcX8NzpemEpO20bhNsKj4a3AhapTfwXNFBE+LZe6kljYtrzfriTuhaQQ2MfEAhTQ98WpfA1AZ+VoEplmvpOkyYB/LETevsQh5AcPUyJ2tBCHUq3Q/85weU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754149271; c=relaxed/simple;
	bh=Y6YAQtLntvTlOEW+/be99fXZeJ/UoP5+1aG+orwrsxU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Cq4a8bU9a0DRrhlKNO2Eq6FLZX2DufofmFiDK4h5W/Ixa6UdZoSMJPIomramvZiUy4jizJgrfxyrBwW811nbrUMnu2PG2ONtplp0vLyjdseGx2RnVGMXU8RxNXTXwof88QLUZLyJ1KCU2Zk+3jstFbeZi+zFX4TJD2Fosrt24fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvw+/6xR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764B8C4CEEF;
	Sat,  2 Aug 2025 15:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754149271;
	bh=Y6YAQtLntvTlOEW+/be99fXZeJ/UoP5+1aG+orwrsxU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hvw+/6xR83WKTCHsOvvN8oU9MCS8cE1YHzb0k4qrITLley6T4I32jTBBX+qUt/fom
	 XpoxSxIt0u2VLnw8n8Op7bGYv7FrVjTdIYcjdzdf3xiNT7wP8erbfsLjbnvWmg8MnD
	 VzVc+rok24tglZVLDMjWGg3lO/ouNXbHhCqIdl4tCIx4NXw1Wnrye7AWHbryIib312
	 bVf/FmggVyQ1sFP8G1L2vuyb19QiZHh40e0AaY/1jdp3fMrKWXmsPXgUkZaoWw4FQA
	 tg0qRxlngk2RJf9sXyk807cUBqMHBrkUAjgKkR/pkF+kIx+0U3NTrd3sRmwSFvru7k
	 fJQtEqEjFBW3A==
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7EA9CF40066;
	Sat,  2 Aug 2025 11:41:09 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 02 Aug 2025 11:41:09 -0400
X-ME-Sender: <xms:lTGOaFnxO6zGR-02SXy5y_K6L2AR-xsQbj7PKcgwK69w9AzOdTfjiA>
    <xme:lTGOaA3VXSSrjtx_QU_FeNp0-beF0HZW9Fj2b14cJmzVYCFdoTrgoJTsLvN1FGzTF
    jZ38iWUG1MBQlpyQJY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdeileeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepjeejffetteefteekieejudeguedvgfeffeeitdduieekgeegfeekhfduhfel
    hfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdeg
    qddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
    dpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopedu
    kedvheehuddujeduheelseduieefrdgtohhmpdhrtghpthhtohephhgrnhhsrdiihhgrnh
    hgsegtihigthgvtghhrdgtohhmpdhrtghpthhtohepjhhinhhgohhohhgrnhdusehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehksghu
    shgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhifihhltgiihihnshhkiheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhpihgvrhgrlhhishhisehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmrghniheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lTGOaD-rPMyo0QjsQ2Jsx7KBLa1zkO1rgl-ASN-p4TIojJhsUUvThA>
    <xmx:lTGOaGDHgcwiXpIFvc_YrLvA33cqumGwX0wbmy-ghhzuhYXZQOMW-A>
    <xmx:lTGOaNt6Gs-9PAlOuzdoROiR3z2dUBMq6CnThjoLNWje4hZRbtTkVg>
    <xmx:lTGOaOGJQhwMn1vyXAdNnS6dlv5nD12BpZasv7IKzb-F7Tj7D1hIzw>
    <xmx:lTGOaA_iaR9QTsCx-qO_Gt6n5-LKs6Kl-ITUtr_DdBb2nZPiplQN-S-V>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4B0EE700069; Sat,  2 Aug 2025 11:41:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tea76caf5b1f73f76
Date: Sat, 02 Aug 2025 17:40:28 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Hans Zhang" <18255117159@163.com>, "Keith Busch" <kbusch@kernel.org>
Cc: "Gerd Bayer" <gbayer@linux.ibm.com>,
 "Manivannan Sadhasivam" <mani@kernel.org>,
 "Hans Zhang" <hans.zhang@cixtech.com>, "Bjorn Helgaas" <helgaas@kernel.org>,
 bhelgaas@google.com, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jingoohan1@gmail.com,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-next <linux-next@vger.kernel.org>, linux-pci@vger.kernel.org,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Message-Id: <07739ab9-4e34-430c-ac1d-d1f370baccea@app.fastmail.com>
In-Reply-To: <d2240ab0-5d91-4b41-945f-e29b40f7b7f4@163.com>
References: <20250731183944.GA3424583@bhelgaas>
 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
 <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
 <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
 <c8ffdd21-9000-40c2-9f4d-4d6318e730b5@cixtech.com>
 <cu7qdbwmnixqjce4aetr5ldwe3sqoixgq4fuzmzajzphjdywqq@yw6ojbgeqktm>
 <06f16b1a55eede3dc3e0bf31ff14eca89ab6f009.camel@linux.ibm.com>
 <659b8389-16a7-423b-a231-5489c7cc0da9@163.com> <aI0CupiFvyOvgNQY@kbusch-mbp>
 <d2240ab0-5d91-4b41-945f-e29b40f7b7f4@163.com>
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Aug 2, 2025, at 17:23, Hans Zhang wrote:
> On 2025/8/2 02:08, Keith Busch wrote:
>> On Sat, Aug 02, 2025 at 12:54:27AM +0800, Hans Zhang wrote:
>>>
>>> 		*value = (type)data;					\
>>>
>>> And this function. Could it be that I misunderstood something?
>> 
>> The above macro retains the caller's type for "value". If the caller
>> passes a "u8 *", the value is deferenced as a u8.
>
> In this macro definition, bus->ops->read needs to ensure the byte order 
> of the read, as Lukas mentioned; otherwise, there is also a big-endian 
> issue at this location.

No, there is no endianness problem here, the problem with casting
the pointer type like

      u32 *value;
      *(type *)value = data;

or any variation of that is is that it only writes to the first
few bytes of *value, and that introduces both the observed endianess
problem and possibly worse uninitialized data usage or out-of-bounds
stack access.

      Arnd

