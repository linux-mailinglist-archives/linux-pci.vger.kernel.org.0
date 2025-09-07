Return-Path: <linux-pci+bounces-35621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A3AB4815D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 01:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3983BCD98
	for <lists+linux-pci@lfdr.de>; Sun,  7 Sep 2025 23:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0811F1B4223;
	Sun,  7 Sep 2025 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jL7sh5LD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D3g56fzT"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE988BEC;
	Sun,  7 Sep 2025 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757288538; cv=none; b=VR7rjxi3GBrsduNJ06kvCYbjdbUFPoC7/+/P3BYWiOBEHk2xhd/5ZUy7J/gUDwlWDDI6y7XfmUiGDB/tYTQyjxBLekghR4KXaqEZTWkg0lrJ+jN33yrLbZTuZaFP30aMGuUjxUUVVNgoLfIIN5QxDobKPh9+dq+rhSkp7XPcqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757288538; c=relaxed/simple;
	bh=Ex7/F7mpRMFYZI7W6EB9K9UlYbHimMiEy6LJYbKvHtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAZT7x2KLEzHsr2zPjee9YxPf0wEu7YvnWlu+c1F8zFKP8sOkUxozoyqnvI1pwwOLu/aTVAlNXT7xjpZbnMiFVPwAREDRNkw5tJC8jrPgo1so7mhJhbuJ2yYHGtwPYM2dXaQn2JCVpWETlBerPvdxybEWPP1+l6yriZg4aTxX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jL7sh5LD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D3g56fzT; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4347C7A00C1;
	Sun,  7 Sep 2025 19:42:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 07 Sep 2025 19:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757288535; x=1757374935; bh=pqxpKSfebg
	bBa55W3rhbKU/fUlCUpBftXlmjKWLMLwo=; b=jL7sh5LDo4TPZZAt4Pu8dW1faQ
	aCPqJ6GPQjCmRINb5YkHyasLTB9LG8lZV9CABq2ekjUIkUqwCoQLB9MKd2CYd1yJ
	n9MoOJHY2sknClyIRfyUmddzKqQwHDGaX+3GjI1z4h1xOk+lQXjCIsaenipsW9AW
	qZQ4f7nGa5ZcIu+Ms0V+pAhehYNv1UQuNmgU+cXwPLGgXzxtJ/HOpxrcPPcDIaJ1
	3qvH8nb41g093dzY3eQhwMgf8PccniFAnx7xKmUakBDH7OXwPb0Ur/It2Wla4SfG
	G9y8S10jTwgTQ7IDQ57Tq1Fiv866mD7UaGe0QAadMlDhSNt6yTH1cTQQIdsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757288535; x=1757374935; bh=pqxpKSfebgbBa55W3rhbKU/fUlCUpBftXlm
	jKWLMLwo=; b=D3g56fzTANzz1wRrsM6DReE69uPV+7qmMZgp7guCfgkrtkoXPcR
	3l2xRNMA5IaCRO7Z5Q0YkRtf1oYfv5euT42jAFDZTK6+RAAOiN8JgFLI7ImcugFt
	VP1RJW5e9fWERb4ya3lTUo6F00mlQK56gubYozdNPHOniQFOTyCsXDDpn6K/mV4r
	Oo0JMObIQgahzvwK5OXEzVv8bM/DDDaqQQ4mnyRsE5uAWkDpNXB9KCGZ0Yh6OE4d
	jHWuF6Kv1d5xMxPa+96dzCQPRXEtRxgIYTfw8k2aXf1/I5BUCg3gLXnVp+RV/sPw
	IHIBqZLXHdUfv9+cWfV/SggF0EwWWaBoWmA==
X-ME-Sender: <xms:Vhi-aHCnNPUpZTsSKzlieV08iAU7Y6TUxwtYybMfpuihX3QpxYmPpg>
    <xme:Vhi-aH_4svpa2nZPYpoNwYZ0NjRIPIXIQgxRPYNe1iXTqyFGy_h9UOkkED1bZKA2J
    wbIM0cwgBEwBE5U5w>
X-ME-Received: <xmr:Vhi-aKFm9BILwKYl2Pc8xPDBauUIM7bMjfrqGSY9ao_-x7B4kglVGGPbBDY9Yr1Bmp6mfGOOouquoliffliaI7USRpJv3jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjfgesthdtsfdttderjeenucfhrhhomheplfgrnhcurfgr
    lhhushcuoehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeevhedvhfekhfeuiedttdfggfefteejgffgteeluddvgefghfeuheeghfekkeekffen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhprghluhhssehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehklh
    gruhhsrdhkuhguihgvlhhkrgesghhmrghilhdrtghomhdprhgtphhtthhopehthhhomhgr
    shdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehprghlih
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhpihgvrhgrlhhishhisehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkfihilhgtiiihnhhskhhisehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehmrghniheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghh
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:Vhi-aBR6oF1dLVRLKdFfxmAR1i4_LuEf-0MDSE66pt0j2qcFw3alUA>
    <xmx:Vhi-aBSS31L_RWWIQJNWNB1jJeHU1N2bGx5YlH8DhjK9DF0bnOB1Jw>
    <xmx:Vhi-aE01ycGRLnq1GnhI9pAQahTZ9blCWv6bwApV0HMJkrgu8zcg9Q>
    <xmx:Vhi-aLwrNT_29rfWpxTWH4dkSrWhpTYwoLD3VY_K95hGaHv1T8vHzA>
    <xmx:Vxi-aO8qqNu1Y_Rf-shXDxDMk7bQzVE_BFnavsZ3PwbDZLLuEIi-dm-T>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 19:42:14 -0400 (EDT)
Date: Mon, 8 Sep 2025 01:42:12 +0200
From: Jan Palus <jpalus@fastmail.com>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI: mvebu: Fix use of for_each_of_range() iterator
Message-ID: <to2mscnfphhypr3ml7hnkvedpw45fqoj4rnrmch2zfjre5i3qi@asawccwf2lgz>
References: <20250907102303.29735-1-klaus.kudielka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250907102303.29735-1-klaus.kudielka@gmail.com>
User-Agent: NeoMutt/20250905

On 07.09.2025 12:21, Klaus Kudielka wrote:
> The blamed commit simplifies code, by using the for_each_of_range()
> iterator. But it results in no pci devices being detected anymore on
> Turris Omnia (and probably other mvebu targets).
> 
> Issue #1:
> 
> To determine range.flags, of_pci_range_parser_one() uses bus->get_flags(),
> which resolves to of_bus_pci_get_flags(). That function already returns an
> IORESOURCE bit field, and NOT the original flags from the "ranges"
> resource.
> 
> Then mvebu_get_tgt_attr() attempts the very same conversion again.
> But this is a misinterpretation of range.flags.
> 
> Remove the misinterpretation of range.flags in mvebu_get_tgt_attr(),
> to restore the intended behavior.
> 
> Issue #2:
> 
> The driver needs target and attributes, which are encoded in the raw
> address values of the "/soc/pcie/ranges" resource. According to
> of_pci_range_parser_one(), the raw values are stored in range.bus_addr
> and range.parent_bus_addr, respectively. range.cpu_addr is a translated
> version of range.parent_bus_addr, and not relevant here.
> 
> Use the correct range structure member, to extract target and attributes.
> This restores the intended behavior.
> 
> Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> Fixes: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/r/20250820184603.GA633069@bhelgaas/
> Reported-by: Jan Palus <jpalus@fastmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220479
> ---
> v2: Fix issue #2, as well.
> 
>  drivers/pci/controller/pci-mvebu.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)

Confirmed the patch applied on top of 6.16.5 fixes all the issues
introduced with 5da3d94a23c6.

Tested-by: Jan Palus <jpalus@fastmail.com>

