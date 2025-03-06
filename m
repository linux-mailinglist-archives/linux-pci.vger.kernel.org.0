Return-Path: <linux-pci+bounces-23079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96565A55AF1
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 00:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1ADE17777E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 23:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4275527C177;
	Thu,  6 Mar 2025 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="eXcAe49G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RVCtFLRU"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC82054FD
	for <linux-pci@vger.kernel.org>; Thu,  6 Mar 2025 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304228; cv=none; b=C/fN8r3mEqnZRbIbcROCbCdUOLTrCwkvjpd6rKztQp+bg9E0OlhrC2DRiJ31bNo6lhwI45oaQ6eM13kHwzWrea2qYnCibOWg/ezjk9DkbrH0wBl2URuvjkOChte92MdMssIaefMHFTw0l8A6lqDd0Zs3xwhT+RuSazb8qz+ZU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304228; c=relaxed/simple;
	bh=QMgl9zHf+/32yxyFuFOrNtJ4HL3aqMBzmXoqgD6v5nM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=egGUqowVD/sRTkymd4YLSDpQLuWLgaiHHZZtSfNI2k66CZdNOyt+LzOMzTzvw+pHGwJoKHDoFrbyvURIdlQMJIrlhSr3Db/KnPQC7kTXJPbjwjo1xH4UafYpTyfvd3GDa0THWqfif4CYO6ZFL0kwtncQQ7K5VLGE8S2gMN8tUzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=eXcAe49G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RVCtFLRU; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 28EDD25401E4;
	Thu,  6 Mar 2025 18:37:05 -0500 (EST)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-12.internal (MEProxy); Thu, 06 Mar 2025 18:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1741304225; x=1741390625; bh=5RNry++BGi21d1o2Vq6cx8uy78YgbYXr
	KcOwsPVqi+Q=; b=eXcAe49G1UU95FAEck3GjLoplyEnTN4m6rKl0hLrQZy6LWYT
	d9nqhCuD4oCtofPbcezNuhtNGHiTipfZPpO7gt8vSR9yCUSKQTaxoBVK0zO/w+35
	FYWjjQo/5xgIdI5qHNlCa0RYBLF/8gfv9T7z2O9I2jHqVI3X/bcteL6vakzQy9jm
	H7FpI9xipG60/aUQ7CMCD+Ra4di3aTC5eN9ucTfqCP5VrUHXeATEH2rRLT7FRYax
	RSyr7eui6bvaJNs3Npt1x85+Z1C11ehvSKMBn2KxIY8IEcNI0l6LuIcGlUDo6HxA
	KP+GKPuXmLH9mMlLf4qj11LNxAaSan/B16GXXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741304225; x=
	1741390625; bh=5RNry++BGi21d1o2Vq6cx8uy78YgbYXrKcOwsPVqi+Q=; b=R
	VCtFLRUQZ97yxLmxiJjcoNj13GVhy7NMxS4/YIK9vkAqVqYPvXglbdeT76t5s/bX
	Ow1oj1kEIz+ww9dMYPSQEWeyJA+d8yvA2F99zkHgnJSrppjcqtIXui2gU47HaNEu
	Ob02T3IEjoYka3ZKqQOzQQ2bHbV/vZqy+UxU4pTvQonXn7cXpU5deWgAp3nT/BMs
	xt5Jr17NlDDwCN3+dgzgfB9al71Ah+3aVX9qkHXbYmgSFsU4sxXkIxccyki74gea
	bQi+G+u4ItXvjsj9g6Nq9RJ4Cl+ayq2ND9KliRJR1yFLoDoYm86MMSOXXVeDOzYO
	BqIItk3XKeoLpA7HBaQ0w==
X-ME-Sender: <xms:oDHKZ3hYShEWclgcoCUOG9zhg--XvfTLMeKz_cwM60MGaNuUHizieg>
    <xme:oDHKZ0CXuQ7rNScLdxzh1HqM1DoFCBkA4svPlaayjvbzDQkiBZh8Zmx9QBylXI3kX
    mGxLh0aR7QaN3KmnDc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeltdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpeetlhhishhtrghirhcuoegrlhhishhtrghirhesrghlihhsthgrih
    hrvdefrdhmvgeqnecuggftrfgrthhtvghrnhephfeiffekuedtgffgheeifffgiefgtedu
    tedutdejvedvgeegjeeiudfgffegheegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    dptddurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvpdhnsggprhgtphhtth
    hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghthhgrnhdrtggr
    mhgvrhhonheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtg
    homhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehovgdqkhgsuhhilhguqdgrlhhlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpth
    htoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oDHKZ3E-Semm8f2gPYhYh3IkTig0BUlO0fOnLp3coE085Qu2_x9Vuw>
    <xmx:oDHKZ0SIWPW6wdSC4hEVN0LcnFw4Pjewg6CptOv27JojTOWuLa5RnQ>
    <xmx:oDHKZ0zhEtRoV4zQ9BNqpA7i0C4TUxaSC27kyKaGJaSilDGyijmkTA>
    <xmx:oDHKZ67Ral28On052LwljxG9_MYmaKsxweHRVJXudsPPAsD5wrBisQ>
    <xmx:oDHKZ-sye2JlHQDoGb5eicdHhr9WKHPZGLUBp2nzMG4ve_XXUDUiKG_h>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6FCF117E006E; Thu,  6 Mar 2025 18:37:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 07 Mar 2025 09:36:44 +1000
From: Alistair <alistair@alistair23.me>
To: "Bjorn Helgaas" <helgaas@kernel.org>, "kernel test robot" <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Message-Id: <2f09e8c5-c2d0-42bd-ad6f-18372a1128d5@app.fastmail.com>
In-Reply-To: <20250306231159.GA381539@bhelgaas>
References: <20250306231159.GA381539@bhelgaas>
Subject: Re: [pci:doe 3/4] drivers/pci/pci.h:464:70: error: 'return' with a value, in
 function returning void
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025, at 9:11 AM, Bjorn Helgaas wrote:
> On Fri, Mar 07, 2025 at 06:33:08AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git doe
> > head:   d7706150d71eca96b6eb8865152bb9fd9830e9fc
> > commit: c4cef7f8f8202238f89668e1c0d013a94c0069fd [3/4] PCI/DOE: Expose DOE features via sysfs
> > config: riscv-randconfig-001-20250307 (https://download.01.org/0day-ci/archive/20250307/202503070631.aZNf56QY-lkp@intel.com/config)
> > compiler: riscv64-linux-gcc (GCC) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503070631.aZNf56QY-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202503070631.aZNf56QY-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from drivers/pci/quirks.c:37:
> >    drivers/pci/pci.h: In function 'pci_doe_sysfs_init':
> > >> drivers/pci/pci.h:464:70: error: 'return' with a value, in function returning void [-Wreturn-mismatch]
> >      464 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
> >          |                                                                      ^
> 
> I dropped this "return 0;"
> 
> See https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=87f7d1a95d2f

Thank you!

Alistair

> 

