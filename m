Return-Path: <linux-pci+bounces-43711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E90CACDDA12
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 10:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 641A2301F4F3
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 09:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C439238C3B;
	Thu, 25 Dec 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vortan.dev header.i=@vortan.dev header.b="hJBYY57H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tPqNC3QY"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD741E572F
	for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766656653; cv=none; b=l32KnNdY2WQiHj++Hq+HTJkZqVOw2uOgU4KWDEtZqjzLhnb5B/8Cy330nE9sQiu3WvoeSPc8VHYVxmBgb3b7pJTScGFqwOHfS8/4LtUvmwboDUg+l9hqeuFBFL9G+l/7wliHEgCXn/yEO7KdtqYYrDWE++f4x1usy136ojKma/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766656653; c=relaxed/simple;
	bh=GgNc3Zo28GTYkoEZos5akQl9BwxBFlx97GgFTfHB10s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ivuH5XC9DuJhsg1Sh6f/+BdDVaw8s0ZpBPzoaZZfa/iuqMR/XMTl/ri3AUJ+0g1TOGEb2ENms4310Qt2n4qmA45ELxZRrhF6h1q79Vivg+iMEEuMcB4RD5Ie2lUp8ncOkjoU/D1cKEF/L9ALE3uODN78t6EYqZY/4Vhq3VrmAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vortan.dev; spf=pass smtp.mailfrom=vortan.dev; dkim=pass (2048-bit key) header.d=vortan.dev header.i=@vortan.dev header.b=hJBYY57H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tPqNC3QY; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vortan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vortan.dev
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9030614000BD
	for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 04:57:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 25 Dec 2025 04:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vortan.dev; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1766656649; x=1766743049; bh=x0CxR6nsS8
	uYNVMmgflei2AYL7ZQvEXRYjzJJ4NEmng=; b=hJBYY57HfXZMlDNEtnBXz/USXc
	bK2cjc5pwMMaahcY4Lwea4LIcQKj2FKVt6s8BKAwjEHPDlfnjQICzwu/HuxP/6cA
	AbLjjN0bbkhoy2DsXODjeStyLngyOnGclIXvKqUpqaXscSbWIoWPMyvtyCVEPkWN
	bNFWqIzOkO0CPuPxt5db+9I4FIydX8JVbQTW+AOvoT1jPOZeT4AEcIJqFefjgrn9
	xS11577DYK8T5hgbZp5TV9vXH13w4Bjn3Q1E5uuWkwOeR8MUhwiJHBcQKsIYj3pA
	jjoR62oJubzINNyh10OYxjV1JSURbublaM8QnroWYWYYJOu8y0htxjV6OQFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766656649; x=1766743049; bh=x0CxR6nsS8uYNVMmgflei2AYL7ZQvEXRYjz
	JJ4NEmng=; b=tPqNC3QYsrqoaPPGoGT4FakiVgghQPFR21oxuaC0O6hSC/an4fU
	BWp4pMItnUAoHft71irYEPVEsv64+fWgZ3/rTWboXratJCj7y9cZWoDWX/KsqUuT
	vZ4bz8IHp8uApkqZDfXY6RRHfvYDJnA8FPPIcSJFaF7fmSpfiLVylF6tzxgriWvH
	7qevABTBdzk4u44jX8aocStJjQT6/prs1LQ26YiQwPtA6fdGvr6JQIWW15NRPpNv
	xqbmiFaeEKW9NX/JudIixTqvQ0U1cy3EHLdchbkL6pBwTB44vpRVnM7DHr73dLKi
	F6j/aWRO/cIXfKphgb6mHS1LesQGqgLdSWw==
X-ME-Sender: <xms:iQpNaYS4PWJNtBJru3yv_Stl4lac0jxdgn1nE3qDL2BvYY0QLT4lGg>
    <xme:iQpNacs8XoDYRalGj9SqpeplvLmziPuKhdyY53h3ysC5tL-9bBTfn7muUb3-yIZ38
    lqdZpDOMswE0tAvArFpHioXsH9vBJblfg0ktJEV0XkOcjlYqladBME>
X-ME-Received: <xmr:iQpNabevBORsh42VQmOGwUqE5jeywdwv6ySJJEiGnow-6i3OChzv953OGJFQP6l13DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeihedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkfffgggfvffhufgtgfesthekredttddvje
    enucfhrhhomhepffgrvhhiugcutfhusghinhcuoegurghvihgusehvohhrthgrnhdruggv
    vheqnecuggftrfgrthhtvghrnhepgeeljeffgfdtudeuheduueeljeejleeileffhedvve
    egiefgleehudekveegvdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepuggrvhhiugesvhhorhhtrghnrdguvghvpdhnsggprhgtphhtthhope
    dupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhptghisehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iQpNaRK8BmNPG8B_uzqpnb9C7dnGSeuTFT_yZUCqmAANFrs2Famf0g>
    <xmx:iQpNaRY1k9Rg6KYTxk0ysKZp5yzrQTKEAjLp9CtGh87glUHuutR0uQ>
    <xmx:iQpNaUtLUoqY4iFAH8khnVMweZNzm-S1X4N1CAgnS_G_bOXCf5K47Q>
    <xmx:iQpNaWt60lZkVIuqCRZV2cKYUxVUlMpCui9w6AwGsia-3VhItNmHbw>
    <xmx:iQpNaQQ0SoyBi-TKaj0CQI969WDGq01eKecn5ADO6kcTNYW-vWzBZBsZ>
Feedback-ID: i64c648fd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 04:57:28 -0500 (EST)
Message-ID: <dd24b51d-9add-4ea1-b8db-05d856222f7f@vortan.dev>
Date: Thu, 25 Dec 2025 01:57:28 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-pci@vger.kernel.org
From: David Rubin <david@vortan.dev>
Subject: Question about ARI + SR-VIO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I had a question about ARI and SR-VIO interactions, and I hope this is the
right place to ask.

As I understand it, when ARI is disabled it is impossible to address a 
function
number larger than 7 (since the function takes up 3 bits in the ID).

Currently, when creating VF through SR-VIO and sysfs in an environment
where the first VFis placed at function number 8+ (such as when we have
a vf offset of 8, and a stride of 1), there is no check in place for 
ensuring
that ARI is enabled.

The kernel will go and ask the device to create this VF, and I believe the
devfn will just be garbage (although I haven't checked this). The device
comes back to the kernel with an "OK, everything is good", however when the
kernel then asks for the config on that VF, it gets complete garbage
and fails after trying to interpret the header type. Doing the
`early_dump_pci_device` just shows all 0xFF.

Example:
[   45.017386] ice 0000:01:00.0: Enabling 1 VFs
[   45.121403] pci 0000:01:01.0: config space:
[   45.121499] 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   45.121501] 00000010: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
... (cut for brevity)
    45.121508] 000000e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   45.121509] 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   45.122040] pci 0000:01:01.0: [8086:1889] type 7f class 0xffffff 
conventional PCI
[   45.122049] pci 0000:01:01.0: unknown header type 7f, ignoring device
[   46.169410] ice 0000:01:00.0: Failed to enable SR-IOV: -5

I had a rough time debugging this issue, since I am not very familiar 
with how
PCI works in general, although I've been learning a lot recently. I finally
did figure out that enabling ARI solves it!

I would like to propose we add a check in `pci_enable_sriov`, that if the
"effective" vf function is larger than or equal to 8, we produce an "early"
error and a more helpful pci error message to dmesg. This may be a naive 
idea,
and I'd like to hear some feedback on it.

I would also love to understand the process of submitting patches to the
Linux kernel better and if possible write this patch myself.

Below is an explanatory patch on what I'm trying to propose. Please 
understand
that it is merely trying to demonstrate my idea; we would come up with 
better
wording and fix issues that I likely don't see.

Thank you and happy holidays,
David Rubin

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 77dee43b7..e9ff5e892 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -672,6 +672,13 @@ static int sriov_enable(struct pci_dev *dev, int 
nr_virtfn)
             (!(iov->cap & PCI_SRIOV_CAP_VFM) && (nr_virtfn > initial)))
                 return -EINVAL;

+       int effective_virtfn = dev->devfn + dev->sriov->offset +
+                                       dev->sriov->stride * (nr_virtfn 
- 1);
+       if (effective_virtfn >= 8 && !pci_ari_enabled(dev->bus)) {
+               pci_err(dev, "cannot enable %d VF without ARI enabled", 
nr_virtfn);
+               return -EINVAL;
+       }
+
         nres = 0;
         for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
                 int idx = pci_resource_num_from_vf_bar(i);

