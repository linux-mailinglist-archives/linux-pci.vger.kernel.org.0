Return-Path: <linux-pci+bounces-24399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134DDA6C373
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 20:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865AE3B7D51
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 19:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9259B22E414;
	Fri, 21 Mar 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wouterbijlsma.nl header.i=@wouterbijlsma.nl header.b="Fgq9ewxG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G1EMFh1E"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF8B22D781
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586099; cv=none; b=LTr5eYlrOKkN3lA0MnUThVio8Wtlfdq2KGJP9P4fd/sEBLMiZKZM0WJXlWojtqdS22YAB3Y86WSNPth2YxEc5cTu8MSzTv0XXGJidPTfrq1umf9wyMSTCQQSCJoqP/5ar2hX7ci8Jy5X8FTRcV6O9AdrlPCnzjAJswu/6rwMxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586099; c=relaxed/simple;
	bh=Q0DaybA4oKVStvJUy43IZuC1ME6SCkKbay5WMQ04cdI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=NoXgJLC6tH57YlWS8paQlMQgG/wQjdkapkubqUu3XdMkDF+GRomwQTFQs3Of+Zql4SbSdPe8348OCDOzhHnu8IGAamM+k7GlTKl5m38BkxYhn6PoVbiGSLX9NSwWOUTbJYAGVTv4uyRL/EV6VkAKSQJ0Mndged+xIS6g0jKByIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wouterbijlsma.nl; spf=pass smtp.mailfrom=wouterbijlsma.nl; dkim=pass (2048-bit key) header.d=wouterbijlsma.nl header.i=@wouterbijlsma.nl header.b=Fgq9ewxG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G1EMFh1E; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wouterbijlsma.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wouterbijlsma.nl
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A20B138277C;
	Fri, 21 Mar 2025 15:41:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 21 Mar 2025 15:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wouterbijlsma.nl; h=cc:cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1742586096; x=1742672496; bh=vWb7UdsHne7XmMwfTr1VX
	mAKloCvQyj8Cca8cX2+VUU=; b=Fgq9ewxGvGfa3zCOyGWhQ1RzfuzC6AcRsrd0o
	nB9awsJurASVuUgmREW4Oulakq/CxpfzeRt5XV/0+WSDWeHopQ/Y/070hGLsvoMx
	LPlQLXjEII/Dxg3PIJJdajQLs6WkLJ22NpdyCJO6xysm6fa2RNJ+QLyr37IVieUI
	bxTiKbKvCOcROFP+v2fa4RaiQuvkgg2gAZtRfdns2Hs8feAu7PiTR5GlM6dyS6V4
	/wTtNvGBSSVvkyekI8LrPdKuVkrwdGBoz2HnCnhJJkXeV/8xxYwbC32kXPdvvaiq
	IVLI7ZKFhR3hXzrIe1jo145tfIib1l2Fp5bgDRPY9kq/4k8lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742586096; x=
	1742672496; bh=vWb7UdsHne7XmMwfTr1VXmAKloCvQyj8Cca8cX2+VUU=; b=G
	1EMFh1EGweCJzNjS/Zr3kSUZLdVdFlXUqqnYYn/7VJLKMTQBrL/NsfiEMjzwG+ge
	VskWp1tWelc5sKNGD7kNz1LLamqNUE2JduBfLOaLBlDoA8+aaNhSHPHr6SueiAbX
	wHTAa6TtHP07JSjRL3oeQGG4Ct/ZCLCkUwDSDPheSDQzdD5SyZWdcTsDzalyK6K5
	rdi1tb9PIh4MguZumQ/oo39rSD1U73ecyNGiqms6aqb/DmDDd+ffMcOgZVq0Vcmm
	Mah5zeOXuJZffx2mrpNYNIScmmnYZJPi8iJEmnbybdy3m6EBSjpBCLpgU+4Zvwno
	NkXO+ndTBWdelPJoJXIhQ==
X-ME-Sender: <xms:78DdZ22Dd3THPG_VUFFqw53xSy6ZOTXjPff11e2F8fgxfyzNjobpEg>
    <xme:78DdZ5H_aO0ygALkM2X1Sn8U_it2C-LyPSubI0YiOEWm2qqd1NbWES3p4cIe3XGob
    _qMf6yvm7yPiacwvSA>
X-ME-Received: <xmr:78DdZ-5uXbr-6oNcemmMRS7iCKveETkbMnV196Qe58P-iSPSVjyUniMf3XVHRHieMyo2tb2rDpGqWCf9PsoNV9ZW1_Mkdw-Ds5xv-BMi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurheptgfghfggufffkfhfvegjvffosehtqhhmtdhh
    tdejnecuhfhrohhmpeghohhuthgvrhcuuehijhhlshhmrgcuoeifohhuthgvrhesfihouh
    htvghrsghijhhlshhmrgdrnhhlqeenucggtffrrghtthgvrhhnpeeigfdvffegueekieei
    gfehhffggefhfefhlefhueevfeffffegvdduleekffejueenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepfihouhhtvghrseifohhuthgvrhgsihhjlhhsmhgrrdhnlhdpnhgspghrtghpth
    htohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhukhgrshesfihunhhn
    vghrrdguvgdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:78DdZ317vTdSlwreAR2zSewXyNVlKnfDufm9aq4AQu_wMp1jixfARg>
    <xmx:78DdZ5GmH3I25c_UWJrlkQhZ8DTZB1W6b_dy_dXAorFc9o1zXxc_uQ>
    <xmx:78DdZw_OstP1blTcCOGxdxVquNDWPtoLrGMPQE8WGGbpcU69CzUvEg>
    <xmx:78DdZ-nHtDLdAn_YZhwkI_zT7N_E-33CgOI-qvcyUVkB0mah7nVDBw>
    <xmx:8MDdZ9gKFsJ4KKA55l-CVXYw16cjsSo-o7T_sR1B8DAVIf__OIkc7uP2>
Feedback-ID: ib07144fb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 15:41:35 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Wouter Bijlsma <wouter@wouterbijlsma.nl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [Bug 219906] New: Kernel Oops in pcie_update_link_speed when hotplugging TB4 dock on x870e / kernel 6.14.0-rc7
Date: Fri, 21 Mar 2025 20:41:23 +0100
Message-Id: <4928CE1C-6F6C-49BA-B403-3EF7E311CC73@wouterbijlsma.nl>
References: <20250321191504.GA1139362@bhelgaas>
Cc: linux-pci@vger.kernel.org,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>
In-Reply-To: <20250321191504.GA1139362@bhelgaas>
To: Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: iPhone Mail (22D82)

I don=E2=80=99t know if this is a kernel regression, the only kernel I have t=
ried before 6.14.0-rc7 was the latest stable kernel (6.13.7) which had the s=
ame problem.

There might some interaction with the system BIOS though, which may also be b=
ugged. On an earlier BIOS version I could at least get output on displays co=
nnected to the dock, despite getting similar kernel crashes and hanging udev=
_worker processes. With the new bios I cannot get any display output at all,=
 not even for the UEFI boot screens or the Linux text console.

The dmesg output I posted is when plugging in the dock without any displays c=
onnected to it though, so something is already failing independent of any po=
tential other issues related to displays.

-Wouter


> On 21 Mar 2025, at 20:15, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> =EF=BB=BFOn Fri, Mar 21, 2025 at 06:30:40PM +0000, bugzilla-daemon@kernel.=
org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D219906
>>=20
>>            Bug ID: 219906
>>           Summary: Kernel Oops in pcie_update_link_speed when hotplugging=

>>                    TB4 dock on x870e / kernel 6.14.0-rc7
>=20
>> Created attachment 307878
>>  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307878&action=3Dedit=

>> dmesg output hotplugging dock
>>=20
>> When connecting a Lenovo TB4 dock (40B0) using the USB4 port of an ASRock=
 x870E
>> Nova motherboard, Linux kernel 6.14.0-rc7 will Oops with a NULL pointer
>> dereference.
>>=20
>> This is 100% reproducible on my system and happens immediately when plugg=
ing
>> the USB4 cable into the docking station. Interestingly, USB devices conne=
cted
>> to the docking station still work, but displays connected to it will not.=
 Also,
>> after the kernel Oops the system is in some corrupted state, as things li=
ke
>> mkinitcpio will hang at the autodetect hook when enumerating udev devices=
, and
>> when shutting down the system will get stuck indefinitely on hanging
>> udev_worker processes.
>>=20
>> When booting the machine while the dock is already attached, the kernel b=
oots
>> without any apparent problems, but displays connected to the dock will st=
ill
>> not show any image.
>>=20
>> This dock has been working without any issue in combination with a differ=
ent
>> Linux laptop with USB4 and an AMD780M, a MacBook Pro, and a Windows 11 la=
ptop.
>>=20
>> Attached is the dmesg output after hot-plugging the dock.
>=20
> Do you know whether this is a regression?  Does any kernel work
> correctly on the system in question?


