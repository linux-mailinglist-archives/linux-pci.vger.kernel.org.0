Return-Path: <linux-pci+bounces-4855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E914987D2CD
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 18:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184251C20F61
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 17:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74764482EB;
	Fri, 15 Mar 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LKIo/pnU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dDRc8Et6"
X-Original-To: linux-pci@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA71240BE6
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523818; cv=none; b=m1CBkGmWMJRjlDsrMQ8taeLNfVYatijdOKIV7mDeIEPQQZdxx8AflQ0vJMF4SdelM5IUVRb42ZuzRey6tII35/57bTJhTOFX6PR/h67aJrEdZch3G5Aw/T5UDsLXuP8L/0fcVByp/xoyR/0gMg0UIPvygd+0ItCD8x0pqNr3tTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523818; c=relaxed/simple;
	bh=6oHBmFj8FEya/elBwYh5rLURdDkfyCdz8ShKk/U6fH8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=JwIDPdpe2YEEJ7gn1Yq9Aofe8fgFN0YlY0TJZptU/aS/JJkvz4IVKZTXUghsqLZjaQttg11Oh1f7zHoJFAcDKu+slwpNRlM/StqEB3NU2EouFe+Hp4nP8IG/8ha2ZrJtQvwGamy8bz9zPUXnt5qJoNr1j2xbfb0NrAyeEuiRpaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LKIo/pnU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dDRc8Et6; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 51B521C000AA;
	Fri, 15 Mar 2024 13:30:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 15 Mar 2024 13:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710523813; x=1710610213; bh=Lm1801ZnRj
	fZ8By/DeYb3lPFjmsUP5AOGpUDyJ/wm7Y=; b=LKIo/pnUI4S1x3Ol6g1EuVkqS2
	c+kVsUJfu8nvKnHavpl0EdkHDaBRVJsOqA7ohSHQuyYoj82/QiAx+W885KUD8ut3
	+KSdNhBhQfEZAmu4hd4qKTgZq7c7FhcniU152hKuMQGQIrFuM0xtA4dbxszPrU2M
	aMrceb537ATpqW9VhhJJieWthB6drM1If1q+EE5/HyeVSoYMMHMSQbSjcOK3ikVK
	rWKzdTO97DHVv6z/inzQ8Jlz8CI8srASkyVWkNrDJIZ/uZwdb5j8t9Ijo1Ibdc7y
	Dg9Gejuc7qZZHysCe8kPLVB7puSF6yIepSRk43Vvk39ho1aWQyIg7tbcpVIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710523813; x=1710610213; bh=Lm1801ZnRjfZ8By/DeYb3lPFjmsU
	P5AOGpUDyJ/wm7Y=; b=dDRc8Et6HbD4XE+YlAhjEUx/vs8TbSCQv9VWcgKtsOYe
	MmktaDKxZxl8f+ruvVRS2zVegsY+x2ZN6Rf64tfpxwcTHWA7dITalX4GwtZQ3Hy4
	PamTBMs+Xipye1Y0NubtNdEHZbc2TUeU3dGzeUVALfOK/I8oIS6gddVWw9K7GvoG
	ir4OpvoFt26jZqj6C1T2RiohpJGAQ08iEixkhFCZHmVacu1gcrCI5fW3iIza5E2d
	9hT9xgwG0QUtPTZk0mHa1nPppx6PkBatrxmZz7anMmpRHsL1iVm1U7FySHfNn7R/
	UVLOewosERNdO7ia/ycAW0dv4SnO6AMJf5ocrCSvlw==
X-ME-Sender: <xms:pYX0ZfVPGJ5sK0vpZajXHila-RkA8HJkeDDGxfs_Ap-T8BNtZme8dg>
    <xme:pYX0ZXlFApxAVo5pe70QPWNA-LgXn412tXP2kUGdjBKrcITt4lgtxCJnI4zvadLt5
    2o0uSEOYuglUXAL7qk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:pYX0ZbaiTmjWE2fFBOZWMfLzuG41cAHAIqttlSsfZBfHoWOVAogPWg>
    <xmx:pYX0ZaU3Vig6-LO9M1qh3WuNBJVPrestmWwDHwG-Yr7Oatko23pZBg>
    <xmx:pYX0ZZmzE0H3iYPqZHZoVnJGkamBMVS0vXYun_PYOurwejcRiWyBKw>
    <xmx:pYX0ZXeKsSj30gIk91M3JIRhMTpIDzxf-I-lEnr1H9-mt9ed4w4CWg>
    <xmx:pYX0ZaiLLB4lawYdvB4mEgy58gwGAfcz3ZGKmgZa9ySic1uEckar8s5_n_8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2BBF4B6008D; Fri, 15 Mar 2024 13:30:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9173aa22-4c15-40ec-bf70-39d25eebe4c2@app.fastmail.com>
In-Reply-To: <20240315064408.GI3375@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-10-cassel@kernel.org> <20240315064408.GI3375@thinkpad>
Date: Fri, 15 Mar 2024 18:29:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Niklas Cassel" <cassel@kernel.org>
Cc: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Shradha Todi" <shradha.t@samsung.com>,
 "Damien Le Moal" <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 9/9] PCI: endpoint: Set prefetch when allocating memory for
 64-bit BARs
Content-Type: text/plain

On Fri, Mar 15, 2024, at 07:44, Manivannan Sadhasivam wrote:
> On Wed, Mar 13, 2024 at 11:58:01AM +0100, Niklas Cassel wrote:
>> "Generally only 64-bit BARs are good candidates, since only Legacy
>> Endpoints are permitted to set the Prefetchable bit in 32-bit BARs,
>> and most scalable platforms map all 32-bit Memory BARs into
>> non-prefetchable Memory Space regardless of the Prefetchable bit value."
>> 
>> "For a PCI Express Endpoint, 64-bit addressing must be supported for all
>> BARs that have the Prefetchable bit Set. 32-bit addressing is permitted
>> for all BARs that do not have the Prefetchable bit Set."
>> 
>> "Any device that has a range that behaves like normal memory should mark
>> the range as prefetchable. A linear frame buffer in a graphics device is
>> an example of a range that should be marked prefetchable."
>> 
>> The PCIe spec tells us that we should have the prefetchable bit set for
>> 64-bit BARs backed by "normal memory". The backing memory that we allocate
>> for a 64-bit BAR using pci_epf_alloc_space() (which calls
>> dma_alloc_coherent()) is obviously "normal memory".
>> 
>
> I'm not sure this is correct. Memory returned by 'dma_alloc_coherent' is not the
> 'normal memory' but rather 'consistent/coherent memory'. Here the question is,
> can the memory returned by dma_alloc_coherent() be prefetched or write-combined
> on all architectures.
>
> I hope Arnd can answer this question.

I think there are three separate questions here when talking about
a scenario where a PCI master accesses memory behind a PCI endpoint:

- The CPU on the host side ususally uses ioremap() for mapping
  the PCI BAR of the device. If the BAR is marked as prefetchable,
  we usually allow mapping it using ioremap_wc() for write-combining
  or ioremap_wt() for a write-through mappings that allow both
  write-combining and prefetching. On some architectures, these
  all fall back to normal register mappings which do none of these.
  If it uses write-combining or prefetching, the host side driver
  will need to manually serialize against concurrent access from
  the endpoint side.

- The endpoint device accessing a buffer in memory is controlled
  by the endpoint driver and may decide to prefetch data into a
  local cache independent of the other two. I don't know if any
  of the suppored endpoint devices actually do that. A prefetch
  from the PCI host side would appear as a normal transaction here.

- The local CPU on the endpoint side may access the same buffer as
  the endpoint device. On low-end SoCs the DMA from the PCI
  endpoint is not coherent with the CPU caches, so the CPU may
  need to map it as uncacheable to allow data consistency with
  a the CPU on the PCI host side. On higher-end SoCs (e.g. most
  non-ARM ones) DMA is coherent with the caches, so the CPU
  on the endpoint side may map the buffer as cached and
  still be coherent with a CPU on the PCI host side that has
  mapped it with ioremap().

       Arnd

