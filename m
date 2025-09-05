Return-Path: <linux-pci+bounces-35518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 492D1B4514D
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 10:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32671C2013D
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEA03002C4;
	Fri,  5 Sep 2025 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VJ4n1zk4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FYDfoGiZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652A2EBDC7;
	Fri,  5 Sep 2025 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060773; cv=none; b=C8DzpCFKbbxlCHxAMuDIP11tLfA3/HeVQr+9ebBOpM7+PxdO0R8GalnbVYPxn3OV3waN9r1EhJMYz5a2TYxj1Uwh4wOZBM3r2N+DMCL3mD2eD8EZJGebp6IrXQbWlCQ1ZnoCRzyOUHDlnSpLRCbz8xvlr3CqYB4V7bcDo6RwVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060773; c=relaxed/simple;
	bh=3/EUyVSXw7ZBzcFANZXOOB2TNuayGC6MtQRvvDpVK7I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fnIYjxmdhpKlGO5hkO0tslagdjY/fahOO3qt5IfNE62gs/GsH7udoOUUGeWOUcrD/FFa2X00NzdmzWpwhx2hVjJyBD+bIphH9cOlnszhNyvlPhKHROTpXF6R0BuBsuDEW+6MWQIjCdHdW/AjsOWnJdUS4KJlOUYpS0tBE7QltFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VJ4n1zk4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FYDfoGiZ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 93A09EC03E5;
	Fri,  5 Sep 2025 04:26:10 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 05 Sep 2025 04:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757060770;
	 x=1757147170; bh=46Gf8YV7inpP79cT31JMwJ9zdtW7od2OINqJDqlzb0Y=; b=
	VJ4n1zk4hXV58Qsiz7ZHwS+VtME25cWGVlG5GfvcxTEzgVcJ/lm2lwj+PX5gj/34
	JfdJeXeaQL7yx9nwT+x8gi7qxA0c4K4fDtG/FkCZCFzN1CUTQHgVCL6Z/Gf6eRkd
	RfgHGBpSUn8pCdMv3RIE3YAZwX0gRXHLRxz3yZNfE4G7NfvO0doYqsL9e3/kVKSq
	nTdfKyHy4uz5XYDG+DB0g8SBu+Y5qa8qMKcwR+/625hkTKcuohzgq67bJA8I13s/
	zDsUyuSaYY2XZiUwcnB6vE0rHEqSPE1BrHE2ipPOI08pRVahSpuoJv2wGLxANRe1
	WXkIKgbm1luXp16ZZ9vf9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757060770; x=
	1757147170; bh=46Gf8YV7inpP79cT31JMwJ9zdtW7od2OINqJDqlzb0Y=; b=F
	YDfoGiZXEFyTPFB2CGXAhT4i7V836VnksZorSOjm8v2363Mo6NJpoSsBAMiyuvk9
	qXqcIF6NEaRhI9kPfxdYrQEqYOID3RsAVgN2ONhOjqCipCDGWPRxQQpwG40P4+1i
	2MrmzEDLhNg+GeiVYi5uSMQDOMWySmt1YSd5I4kcLJNj4D7XI25J7AipmOivIqLT
	W7VapMInyPo6MWUMlsZn8TFnCIduPCk5b9RmALgSxGi50ASPi/eCkMzmjr4FAMjS
	5SJm0G/Rq10R9luYnKJJL0Gbkd8eHKwkXdZI1BWOf4UBphLo1phQ0WxK5w7tubPA
	1NXu0Af+Xwq9KynkGOSCw==
X-ME-Sender: <xms:op66aGQ-RsuVUFNkZr4UFTFwQxLNAVaKnIvpZkIuE_ezbYJWoQXAyw>
    <xme:op66aLyEHC2ljzxZ-CmN5GQ1rl3dOr0D2ci7KdUCYUPoLxoX6a8kXXRwnduM5ZqeA
    mHeX-7lQ5fH1Wc5NoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefhnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphht
    thhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghhvghlghgrrghsse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hnuggvrhhsrdhrohigvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsggvnhhj
    rghmihhnrdgtohhpvghlrghnugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggrnh
    drtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhkfhhtsehl
    ihhnrghrohdrohhrghdprhgtphhtthhopehnrghrvghshhdrkhgrmhgsohhjuheslhhinh
    grrhhordhorhhgpdhrtghpthhtoheplhhkfhhtqdhtrhhirghgvgeslhhishhtshdrlhhi
    nhgrrhhordhorhhg
X-ME-Proxy: <xmx:op66aCbnxvvIFpBFKThejSSZRVGNvGdPZSuVSQxB-6IHC-JVhvB42g>
    <xmx:op66aJ8i4NRTjbFcyuMWPI6ML38DE854QfiSO1QC8wqr9k00SE3j7A>
    <xmx:op66aKEX_g-E95x55WeQ-QGpIGU06uk0K5XUGZdrbDl1SI_qM4BZ_Q>
    <xmx:op66aLdGksGkDFFlf6_CozAODynMQ_ZpZYJnrEtuKAZx9-MtW4sd1Q>
    <xmx:op66aDHxl1tQ3z5cm0pz_IyQiihs7DyiYW6v36RjOIb6ZMngPUrWDAXp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 05BD2700065; Fri,  5 Sep 2025 04:26:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABrrY9NwCfcB
Date: Fri, 05 Sep 2025 10:25:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Linaro Kernel Functional Testing" <lkft@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Benjamin Copeland" <benjamin.copeland@linaro.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Peter Zijlstra" <peterz@infradead.org>, linux-hardening@vger.kernel.org
Message-Id: <d430f9ac-153c-41da-9cbe-53aa2f9d0fc3@app.fastmail.com>
In-Reply-To: <20250905052836.work.425-kees@kernel.org>
References: <20250905052836.work.425-kees@kernel.org>
Subject: Re: [PATCH] PCI: Test for bit underflow in pcie_set_readrq()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 5, 2025, at 07:28, Kees Cook wrote:
> After commit cbc654d18d37 ("bitops: Add __attribute_const__ to generic
> ffs()-family implementations"), which allows GCC's value range tracker
> to see past ffs(), GCC 8 on ARM thinks that it might be possible that
> "ffs(rq) - 8" used here:
>
> 	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
>
> could wrap below 0, leading to a very large value, which would be out of
> range for the FIELD_PREP() usage:
>
> drivers/pci/pci.c: In function 'pcie_set_readrq':
> include/linux/compiler_types.h:572:38: error: call to 
> '__compiletime_assert_471' declared with attribute error: FIELD_PREP: 
> value too large for the field
> ...
> drivers/pci/pci.c:5896:6: note: in expansion of macro 'FIELD_PREP'
>   v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
>       ^~~~~~~~~~
>
> If the result of the ffs() is bounds checked before being used in
> FIELD_PREP(), the value tracker seems happy again. :)
>
> Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic 
> ffs()-family implementations")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: 
> https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

This looks good to me individually, however I have now tried to
do more randconfig tests with the __attribute_const change
and gcc-8.5.0, and so far found two other files with the
same issue:

In file included from <command-line>:
In function 'mtk_dai_etdm_out_configure.constprop',
    inlined from 'mtk_dai_etdm_configure' at sound/soc/mediatek/mt8188/mt8188-dai-etdm.c:2168:3:
include/linux/compiler_types.h:575:38: error: call to '__compiletime_assert_416' declared with attribute error: FIELD_PREP: value too large for the field
sound/soc/mediatek/mt8188/mt8188-dai-etdm.c:2065:10: note: in expansion of macro 'FIELD_PREP'
   val |= FIELD_PREP(ETDM_OUT_CON4_FS_MASK, get_etdm_fs_timing(rate));
sound/soc/mediatek/mt8188/mt8188-dai-etdm.c:1971:10: note: in expansion of macro 'FIELD_PREP'
   val |= FIELD_PREP(ETDM_IN_CON3_FS_MASK, get_etdm_fs_timing(rate));

drivers/mmc/host/meson-gx-mmc.c: In function 'meson_mmc_start_cmd':
drivers/mmc/host/meson-gx-mmc.c:811:14: note: in expansion of macro 'FIELD_PREP'
   cmd_cfg |= FIELD_PREP(CMD_CFG_TIMEOUT_MASK,

This is fairly rare, but over time there are likely going to be
others like them. I see three possible ways forward here:

a) fix them individually as we run into them, hoping for the best
b) skip that one compile time check on older compilers, like Anders'
   new patch
c) try to come up with a more robust FIELD_PREP() implementation

I already tried hacking on FIELD_PREP(), but my feeling is that it
is already getting out of hand with its complexity, and needs to
become simpler instead. The root cause for the warning here is
apparently the way it evaluates the macro arguments multiple times,
and that causes both extra compile-time complexity and extra code
paths where part of the invocation goes through an inline function
and another path that does not. It may be possible to change this
in a way that moves the BUILD_BUG_ON() portions into an __always_inline
function, and only uses the macro to deal with the type differences.

     Arnd

