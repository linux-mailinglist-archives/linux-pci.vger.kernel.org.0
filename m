Return-Path: <linux-pci+bounces-27257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B560FAABB0F
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 09:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622091C43A77
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8837283121;
	Tue,  6 May 2025 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="oZb4xkNc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="poOJhYdY"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7227F175;
	Tue,  6 May 2025 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746510257; cv=none; b=qK98HW7Q5JdgoiE2aJVE86R60M3+IQPrumpYdoUptS64QzW1P5fVFlz9zhDx2QmEInM1OJK7EKUHXdsOOAfh7AigJc3oETU3JiKKedxpYPlxXqwmNoRfy09qy1j7OoA7YcZERjVnojj+lBc4mJUw9G4iAfFErL/2AwDl2vODboE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746510257; c=relaxed/simple;
	bh=PklZNGPBZjjHzvg6EAwF9mW/Uy4ADfje5UdUQmm30Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mU+FJS7Tchlr1Kj7Ol7Zvvj7+IlKz+Wv7pdv/uXISEKr6A9oaLm/flk6YXY7b2ngwB6LOD2octIwO1ZaGd8/ZTKcOqNjA5DXSd8k7BXOXKbtyqYKGJtyaOidIomfHUBhVX5hx5mglhtlcQsN00hRCYmF0qxz87Za1Sr1DwA+NjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=oZb4xkNc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=poOJhYdY; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A56D025401F1;
	Tue,  6 May 2025 01:44:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 01:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746510253;
	 x=1746596653; bh=bCKUsyhTOsmEswgyeQLPOiTcdJnFTI3fddDDTGxV5hA=; b=
	oZb4xkNcRZUJnUOGWPVm26kj6OUcFyvmTHSYjXdeli3uAdT22Qypd1fr6akdNkyj
	6Iu8YqPaaln0wqNHaTVcddc/C79VLhv2jNPXopgylEGtwsHKiKJfgKRqZyUBJXOU
	gfQYVPXzQeRJxAvzRrGLW4Av+olIhfXh53gCpjaTk5rqhyN48AQN3/dijpBa8fWC
	Y8ZkUfA/PB3KBinTIYtAvTXwRiw966J/Yhwy3nBJhzJSA/ObJw8DVSbpdPkMhTUg
	FxUYwyKjYbLoAvPX58SjSl4QzWRmJuPP4/YBpMqQLWUAzu5zoDWTvLKXJBhsw7bY
	/r4UhkJBXoMiy4+giB9OOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746510253; x=
	1746596653; bh=bCKUsyhTOsmEswgyeQLPOiTcdJnFTI3fddDDTGxV5hA=; b=p
	oOJhYdYSJZgpYxivCNuOqffQbQAGI8w1IUza7fA3GorjMTZgxgkd8vt026qM3NTe
	8xqzx4acQzPQC0nMfXUHfAQcVo7NrEs0KkbNuuVtfisQ/hfuvX9goWam4Uyfo0IK
	tsz8aNLvyZSjDDbOqZ80NvpRe3FFKmpHLlU8XWD27oSqKsoOq/u4qvrx/ucL0OrV
	q9kUE2ifKSf5O7LRoy4HyZr+BADulywMT4oEI2Umx6ChHdx/5bMqE/luwAd0C78s
	x27UBoPVmx9IjFf5Hd5zrUrR5DtCwBFQ3QPZQWCq5HfAG4RDeC91w/TR7NKxcMZE
	13WU0CybcyodnOyb6cBMQ==
X-ME-Sender: <xms:raEZaFd13NIjHiTV385Tph4zXZ9EOHFjbAs2U9VWxLL9QAbnR4UYJg>
    <xme:raEZaDM8dL_Kpfj027iJFLNcDGd4s3YSPk4jh1mSs83zBSJaXNgFxdcq7I3N8A8C5
    lOgzrnQOn3MENY2vOY>
X-ME-Received: <xmr:raEZaOjL96IMKpYe8mgs4DCydHG0Z1cb_otH2xY0wCz_qpxg8o8f5KXnowJxJ7Fw3GJfLB9fTX031VqRQlnlby8HQFCGCB0Z9Clj0Ua6qPDXbqK2v6QXKY91w4VapW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpefthigrnhcuofgrthhthhgvfihsuceorhihrghnmhgrthhthhgvfi
    hssehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepkeejuddvheejgfeh
    tdevffekgfdufffhheffgeehhfdtuefgudevtedttdehjeeunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhihrghnmhgrthhthhgvfihssehf
    rghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohephhhonhhggihinhhgrdiihhhusehngihprdgtohhmpdhrtghpthhtoh
    eplhdrshhtrggthhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepshhtrggs
    lhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtih
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrhigrnhhmrghtthhhvgif
    shesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:raEZaO-td3PNP7_HRPB3MQd1EXIpRzuxdS_-Cfi5iVqunaM2v77Lbw>
    <xmx:raEZaBuN0Ybb4IUHABM7feAakXOcPbHHJJWdanV0r5hvTxqR6RqhIA>
    <xmx:raEZaNHyyasJxmemvX6FuWGEfsDc7Boc-gdmEXowUjRXRYIe4EUU_A>
    <xmx:raEZaIO6bR4YMT2q5XAXRcUP565FeHUeX5vphjx--48VYL4BxCgvGA>
    <xmx:raEZaA2pzlZ0Db1XXKgiA83DVbgc3OzSLm7g-Gdu8LE3qNzQ6WkqR08K>
Feedback-ID: i179149b7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 01:44:12 -0400 (EDT)
From: Ryan Matthews <ryanmatthews@fastmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ryan Matthews <ryanmatthews@fastmail.com>
Subject: [PATCH 5.4 0/1] PCI: imx6: Fix i.MX7D controller_id backport regression
Date: Tue,  6 May 2025 01:44:05 -0400
Message-ID: <20250506054406.4961-1-ryanmatthews@fastmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <2025050512-dice-brick-529d@gregkh>
References: <2025050512-dice-brick-529d@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, May 04, 2025 at 03:13:54PM -0400, Ryan Matthews wrote:
> One conflict resolution is needed to apply the redo patch back to versions
> 6.1 -> 5.15 -> 5.10. One more resolution to apply back to -> 5.4. Patches
> against those other versions aren't included here.

On Mon, May 5, 2025, at 05:23, Greg Kroah-Hartman wrote:
> If you want to submit patches for those branches, I'll gladly take them,
> thanks!

This patch applies to version 5.4 only.

On this version I build tested but didn't run test. I have practical access
to relevant hardware which runs 6.6 but not this.

 -- Ryan

Richard Zhu (1):
  PCI: imx6: Skip controller_id generation logic for i.MX7D

 drivers/pci/controller/dwc/pci-imx6.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)


base-commit: 2c8115e4757809ffd537ed9108da115026d3581f
-- 
2.47.2


