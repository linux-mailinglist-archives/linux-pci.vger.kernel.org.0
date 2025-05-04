Return-Path: <linux-pci+bounces-27121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB62AA891D
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 21:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A132A3AA7F1
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 19:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50261624E5;
	Sun,  4 May 2025 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Kf+SHWhv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o9TZoKMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B016DEB1;
	Sun,  4 May 2025 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746386114; cv=none; b=HrfN3EjXEsmgTGdIiJMW/qRgJXGn+PsGtX5pvwgBYjZccgxs+r0pWWOFD9hI8XV7CvrlPvyZUbnEv8htDXosJLKqV5FsWIj/srt2ItZ6iT4nB6tnYpwNHIz/lu1CCzBEGCWWgcCa+gJuWzi+PzB7SuBcEKs6xaJhhQeV+/EFSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746386114; c=relaxed/simple;
	bh=40e3EJNEbCr5pCROPNz3tCvrONTu+7+7tBbS/pxcfRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CpzJqZYCucTBzM2yfBYU8xSYlyKdf4sKqLhBff245G5DmN1DT/WDeYsUoB1Jk8bgN54k/L1v92E065/0+JMs3JqTM0EM0BqhcceNNOcso1Py5ShIL4MfbIS8H3CC/wdzLiaVPOBHLrCpgcnFwzEY2ND1OCky3+BJz1olcvXlVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Kf+SHWhv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o9TZoKMl; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 87BDB11401C9;
	Sun,  4 May 2025 15:15:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 04 May 2025 15:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1746386110; x=1746472510; bh=FI
	vTXFayAfBRloPSAWdyHb9FghKMruymHMlmt53XaHU=; b=Kf+SHWhvV5cbcRJ8Fe
	Cv1/s03FDk6Z1VPyzvrHT7+9zFBsoTI3IlMsdkFixKRXy6qiBFZBsPrlyiVwAzOZ
	49I6odfz1J9KUtnpDiCijs6VlGyH7JcRdegLCqaJi9PTnxVw+frigNRRVMwQro6q
	+dIPJ3mNNfNTgd/7CW2oDjX2Zni6BNbMbjCOWtZJnSJYX5ooEJ2V6KSwXMiZgYFf
	CVCNLVt0ZeaZXNwMOqeO4Zq2qyFFhI4yfRKE8TkIbTyjFpOsaUN58SWBV1owYlr/
	x477sfIsEiIpnWR3TP7SeWYJJ789O3aIDDkmzH5QY3Jz3+JEu1iv/M+ytrdPljsv
	5NpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746386110; x=1746472510; bh=FIvTXFayAfBRloPSAWdyHb9FghKM
	ruymHMlmt53XaHU=; b=o9TZoKMl5LRCKGwg1d25gRJZew7iuwWinBHbhX7qWb88
	8hLlIG8EG3blmHk3zgYVf1FrUnUw2Nqllf09gFG21x/lWbsu3/vWCYxdQn/QxmLR
	OFaa9vU/P/F3hGIuoCukeh8l8HwQgWA36F7FRU013EpEBU9WcLwpY7lE6HtRNi5g
	7+1maTKXIKYWGvAtXI6hasw2+MbduQAltlJiUYPYSDP9/cv0NM+84X3tbzHO47Tr
	Rw7zCm0hMl6DdQ01OtQ/BRpdO/AeEvM+L+U743tQTfpVpIpu0BYJNFL42yf0DAJI
	Ptnew1QAOQ5Z0tGA1SXO4uoHOprUQh1f2DupY4IeqQ==
X-ME-Sender: <xms:vbwXaEGkTFvh4SKQhXkHdIlAPN6qEjq8qR043rxYn7m_rkDZC_GRSA>
    <xme:vbwXaNVxFs1UqrroY3eOZZiME4JtkLdhXD3jjLYbXqYobJ3rYT1THkUHulhQ6h9Rg
    qk3JGf19NvL3cjS-J4>
X-ME-Received: <xmr:vbwXaOItkBrjghZD4HK_GbxYbH4tfX0V4hxhoqbsipRJNz5onjvuO30IuhdirM2ZUJUQdcitxSyyBa_DGrGyarsX71cdhoGCmI6_7lsX3-r0xBfkJv-LjiUfjVMZo98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdej
    necuhfhrohhmpefthigrnhcuofgrthhthhgvfihsuceorhihrghnmhgrthhthhgvfihsse
    hfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephfefgfefgfelgfethfej
    gffgkeettdeuhedtkeegtedujeevudffteejvdeguefgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprhihrghnmhgrthhthhgvfihssehfrghs
    thhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhr
    tghpthhtohephhhonhhggihinhhgrdiihhhusehngihprdgtohhmpdhrtghpthhtoheplh
    drshhtrggthhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepshhtrggslhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrhigrnhhmrghtthhhvgifshes
    fhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:vbwXaGEB2GVgQ03s4gQzBUZ9_RKTkzEBYp894v8XAGwYfsCSdZW0oA>
    <xmx:vbwXaKWA5Q2pmEcafRQxGnyPAlT_MW3RFrXkZT9dzrUaUVwMS9cVaQ>
    <xmx:vbwXaJOgTkuxlariw4NInLvNU6o55tw_OBW2IIKpf5ne9L9nUh4wIw>
    <xmx:vbwXaB0C4KhC8mI1WvdZcudu1H9VbcArfL66UYTkOoncMc-FxSQieA>
    <xmx:vrwXaCl3qq9pMJLZj0J1Py_NgDh_HAUqWyhsGSjk3_V8Q7iVM1H3TByh>
Feedback-ID: i179149b7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 May 2025 15:15:09 -0400 (EDT)
From: Ryan Matthews <ryanmatthews@fastmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ryan Matthews <ryanmatthews@fastmail.com>
Subject: [PATCH 6.6 0/2] PCI: imx6: Fix i.MX7D controller_id backport regression
Date: Sun,  4 May 2025 15:13:54 -0400
Message-ID: <20250504191356.17732-1-ryanmatthews@fastmail.com>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This fixes an i.Mx 7D SoC PCIe regression caused by a backport mistake.

The regression is broken PCIe initialization and for me a boot hang.

I don't know how to organize this. I think a revert and redo best captures
what's happening.

To complicate things, it looks like the redo patch could also be applied to
5.4, 5.10, 5.15, and 6.1. But those versions don't have the original
backport commit. Version 6.12 matches master and needs no change.

One conflict resolution is needed to apply the redo patch back to versions
6.1 -> 5.15 -> 5.10. One more resolution to apply back to -> 5.4. Patches
against those other versions aren't included here.

 -- Ryan

Richard Zhu (1):
  PCI: imx6: Skip controller_id generation logic for i.MX7D

Ryan Matthews (1):
  Revert "PCI: imx6: Skip controller_id generation logic for i.MX7D"

 drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 814637ca257f4faf57a73fd4e38888cce88b5911
-- 
2.47.2


