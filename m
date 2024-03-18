Return-Path: <linux-pci+bounces-4877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C7C87EC95
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 16:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29CE9B20D4C
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C3C524BD;
	Mon, 18 Mar 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Nji2MOg6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VrZpeOV9"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5D4F61C
	for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776972; cv=none; b=m7ocfsEla5/Q3+20uK5Oe8VlPc7Lpql6Lcd8ImcG0I2xYdQr0werv0TT/HoClk0FnNmx0Jox0DxJ+Hxi67ZHfZ9L+u7/pRYewT7nQOUTMfikQfn2vLiG03oKpN6fCX+f//lD1gqCXcgPQnHwuIVdiNs0MCu5oraFwWHiw9vHf4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776972; c=relaxed/simple;
	bh=ivsEuVMh66zSKPWOulaAXzO+mkYI1ub3u8DSvlqi6rk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GnYLRn8zf1ZpWBRC2PX4czq2hDV9h/Rq1sbFBqByNAkWL/AJ7V+utAKTdH0p7oKRwb+2a67d4VLn+P/490GyDZ6U80b3T5gCdpbzOTUYSCOtIWeA4uKEbXdhTIqviLvuDZEOp07FuRgQDdrQkwgDqjQnv04MPQJs+0KvraWri0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Nji2MOg6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VrZpeOV9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 901F0138011E;
	Mon, 18 Mar 2024 11:49:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Mar 2024 11:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710776969; x=1710863369; bh=sEjh3K9W/i
	plthe38RtGHq0sYYG7nvBGM1SOY87wvXY=; b=Nji2MOg6K3lICHNn8+UXySUG5Y
	xNf+Rerp8kozbkA6CNMbBDpy9UmE1S7XQcwsqnvoIfJ+aru9kAj0Kh0fO4VJJIHL
	8HYqswiXG1eRjiwtwHKtR9C2ff7Nbpi0S41fLxaKeVWmuHoYOMAud7Lj7QsoPvMv
	lKc+id7cGomDJbpvzyVIB68f2LVcnW4sVNJYUahSLj8GMv/BHdddte9kTkO0YhfE
	Rk5TxmtM5do81CNtm5+NVwAWSCzohY8ZBTE5ojdJrUdhUdXiNthO2F53Ar+POQmp
	5qfUiKFdgluP+AAy0hJEbCKx1i4SfI40nGE1592ebxaPn9maWqX8ZPvE/vfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710776969; x=1710863369; bh=sEjh3K9W/iplthe38RtGHq0sYYG7
	nvBGM1SOY87wvXY=; b=VrZpeOV9rzTAjy9iIc/ndtIiGuOAV+jYQNjIGhJ2p8E6
	UequaWmPr3UCbADt5V9LAc96aC/SdzIMrVt2QaOglK7s7OT9RB/LzGYOQifuYeKN
	N16saKccmLNLWJFKgsAfu4NnMh7REnt4QHxfDfjNv1Wy3dFX4XugRtEbP4b3oWFR
	MZwQuRWCqcVFNaLpcEhrigVzUlBoZP6HCMg+uKnWRz+sudniai2qyiH66QrACrzf
	w6hPweaZwu+g8KduCYJL4EDf6SRuC+W1eYZ0DbofO0GERE4YhcQdSUW6zBeAnYDn
	S0IN1WPgdrEQ+pQRAgGHYC+DPSemw5FP74JQnCfV0Q==
X-ME-Sender: <xms:iGL4ZSpJrk6830cH-7SSbJks582-f2i5lifpwKi5y6U5Jtrk-be8Cg>
    <xme:iGL4ZQr_njyajkM8TEkIUlPAJQfd-N1QVk7LT26ts0w7xSp4NWNViRWSdv7FxB2e4
    7IVr4DrVf_O5OZzVoM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeejvddvvdduleduheejiedtheehiedvjefgleelffeigfevhffhueduhfegfeef
    heenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:iGL4ZXPrbWneF5XhI7w-chd8OzztdOlwuUiu-P6pdfqkhT_gYJjiXg>
    <xmx:iGL4ZR7-PbLNflDy5Qnr-kdSGEri3tHXjLVsqUns8Xv-PsxInZkVIw>
    <xmx:iGL4ZR7rnxriFKcrfeqKMH63sUahcwl2azi9CdlESPv9oZuzs2taKw>
    <xmx:iGL4ZRis4kdU7ar63YJef70OiKJ4RFhnU776OEsjd6hhSXB2Rza5hg>
    <xmx:iWL4ZeyAb1zgwCJYAV6WwrrWb94UOv1lOwzqBFyQPKr5ho65xwpvFQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B9C95B6008D; Mon, 18 Mar 2024 11:49:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7cd98e59-07ce-489a-992d-bd9c52b83ef5@app.fastmail.com>
In-Reply-To: <ZfhaIbTcy0vgdT1A@ryzen>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-10-cassel@kernel.org> <20240315064408.GI3375@thinkpad>
 <9173aa22-4c15-40ec-bf70-39d25eebe4c2@app.fastmail.com>
 <ZfbZ45-ZWZG6Wkcv@ryzen>
 <7003f4e3-fe3c-43d7-8562-efaacc3d65d3@app.fastmail.com>
 <ZfhaIbTcy0vgdT1A@ryzen>
Date: Mon, 18 Mar 2024 16:49:07 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niklas Cassel" <cassel@kernel.org>
Cc: "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Shradha Todi" <shradha.t@samsung.com>,
 "Damien Le Moal" <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
 "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH v3 9/9] PCI: endpoint: Set prefetch when allocating memory for
 64-bit BARs
Content-Type: text/plain

On Mon, Mar 18, 2024, at 16:13, Niklas Cassel wrote:
> On Mon, Mar 18, 2024 at 08:25:36AM +0100, Arnd Bergmann wrote:
>
> I personally just care about pci-epf-test, but obviously I don't
> want to regress any other user of pci_epf_alloc_space().
>
> Looking at the endpoint side driver:
> drivers/pci/endpoint/functions/pci-epf-test.c
> and the host side driver:
> drivers/misc/pci_endpoint_test.c
>
> On the RC side, allocating buffers that the EP will DMA to is
> done using: kzalloc() + dma_map_single().
>
> On EP side:
> drivers/pci/endpoint/functions/pci-epf-test.c
> uses dma_map_single() when using DMA, and signals completion using MSI.
>
> On EP side:
> When reading/writing to the BARs, it simply does:
> READ_ONCE()/WRITE_ONCE():
> https://github.com/torvalds/linux/blob/v6.8/drivers/pci/endpoint/functions/pci-epf-test.c#L643-L648
>
> There is no dma_sync(), so the pci-test-epf driver currently seems to
> depend on the backing memory being allocated by dma_alloc_coherent().

From my reading of that function, this is really some kind
of command buffer that implements individual structured
registers and can be accessed from both sides at the same
time, so it would not actually make sense with the streaming
interface and wc/prefetchable access in place of explicit
READ_ONCE/WRITE_ONCE and readl/writel accesses.

>> If you don't care about ordering on that level, I would use
>> dma_map_sg() on the endpoint side and prefetchable mapping on
>> the host side, with the endpoint using dma_sync_*() to pass
>> buffer ownership between the two sides, as controlled by some
>> other communication method (non-prefetchable BAR, MSI, ...).
>
> I don't think that there is no big reason why pci-epf-test is
> implemented using dma_alloc_coherent() rather than dma_sync()
> for the memory backing the BARs, but that is the way it is.
>
> Since I don't feel like totally rewriting pci-epf-test, and since
> you say that we shouldn't use dma_alloc_coherent() for the memory
> backing the BARs together with exporting the BAR as prefetchable,
> I will drop this patch from the series in the next revision.

Ok. It might still be useful to extend the driver to also
allow transferring streaming data through a BAR on the
endpoint side. From what I can tell, it currently supports
using either slave DMA or a RC side buffer that ioremapped
into the endpoint, but that uses a regular ioremap() as well.
Mapping the RC side buffer as WC should make it possible to
transfer data from EP to RC more efficiently, but for the RC
to EP transfers you really want the buffer to be allocated on
the EP, so you can ioremap_wc() it to the RC for a memcpy_toio,
or cacheable read from the EP.

      Arnd

