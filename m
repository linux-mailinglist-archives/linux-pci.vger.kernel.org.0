Return-Path: <linux-pci+bounces-27255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDE3AABAD2
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 09:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 570B27AEEC4
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D85427C17B;
	Tue,  6 May 2025 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IrDgR2wf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KhXUF7Rw"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76188339A1;
	Tue,  6 May 2025 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746510208; cv=none; b=rGUHaLYU4L7zQU5OffefpXsaWATql0FBnrNyxAoRZ/zE2lrULouaAeDlwv3e3xYhhv8/kqcQZI6K0rnJdYhrOxPv8J4qTT0Zn6JRcfA7WCNIBULAe+DOuu1vlf2rjrY0QY/yXMHtomnf47aaf6+cOhH9ZWeH55hkpL1e9/lK5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746510208; c=relaxed/simple;
	bh=ncN0A59KRgG+4V/9fwlMI76SRzqyk4YuSWuFyAJgfaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOAsPycAbezdS5sklGBGhFSKpQvozjupGXBh+Q5gpAOji0MAgIS5pT4FTYbxVsitvjvOxKU4yJ0zJryPdIpn0kC4w5SlCzHLbLiLs0BUX6Ew9MJAmurhBfQCxe3NSgR1h6hLOZSyniEqDUVFfpIH/XrjWdsAew9tMK/y6UNp1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IrDgR2wf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KhXUF7Rw; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B3631140205;
	Tue,  6 May 2025 01:43:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 01:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746510204;
	 x=1746596604; bh=eJyBvUyVyt/LY55+1hDQugUZsMKccw2udrBjXVpTgnA=; b=
	IrDgR2wfnc+RGFlTjBnVic4/uJxLShINzhS4IHEoFOf07y54EYbUSM4nRhSGo3Nv
	scINpuq+TSPdl7F9HRdGnN0PIEf6SDqHVeqtR0Rd1qq8308UMYNfvNzYeXPmxLZE
	12YJaC6M3xNVXNyi3tjkB8lo3BihNEg/Yr6do3vlr7o3gDUeDS7gbGTMAqxxj6pz
	6jk7lAMf3aNPFltzW6Frb8qGQ0Rzf9j3kJiuv9ZSD3KHvLDrqx3hghlup6ti/kiF
	L7Re5DXN2oCgtI23kYOYE16wWxnukoUjINBl+DlU0ZuwtByoMB3UDMFYdCLdb30o
	Da7qqge15pJl5F85jn/a0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746510204; x=
	1746596604; bh=eJyBvUyVyt/LY55+1hDQugUZsMKccw2udrBjXVpTgnA=; b=K
	hXUF7Rw64vQRnwyeo6g2lUMyA50SCQ80Y7goV7OD3mb9gKqmLPCKhEejsY2rwyRn
	oPdRZPDuaOfyJfr8YCd7mqa0Rrcr9fgJwXZpTHBRHvIvRJxZ+39eixlwiU9sNMnu
	FujF67HC6K5gYxpeGI1tmmOQVpLUd5UW4GbTGUmYEoW5RlPdoaGdahbavKpTINbX
	nzT/5jehZnp+LKGasMOd9gGK9E7UHNb9rNISQGOChpD6280dIrQoi4Mqs4aKgCO7
	C+zQt2KvBZW4OWZDNAtJHEoLW8G0AV0ZDZC8OOsCVX6COEVpuHi5MOR9/3BpJ/Lc
	ESTNthbgSOQ2QCwVmJu5g==
X-ME-Sender: <xms:fKEZaJkrZRW5v1_xPm4Il0AD6zHjjWgeiM0ea4rjdlmzWsK7RfQV9w>
    <xme:fKEZaE0iQSjl2k-FEPgiH1aLIS3LUnf405H_7u4sKrOYIHnJM_nWoSIvGkyDtNAy9
    4A93rGEumihez3rqMM>
X-ME-Received: <xmr:fKEZaPog6QQ90iLQ0oXlPSIdmUad32w48mUtitSnlrOcJSNHXf064hGv2BH9MlqTq9bgZoWUGOoyVOlgwsNC-EPP1r2cCenhNbLx_lu3BiDOQ4RVTdkwqwekt_DngyA>
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
X-ME-Proxy: <xmx:fKEZaJkSPwIzfrZmU3je4F4n-GDmqhPcrQzvL1laLCIi4Mlez4CPFg>
    <xmx:fKEZaH0l4K5jYm8KEgyD7IhnFLklPv13QXx7jMmqMpFcqLeA8cXwRg>
    <xmx:fKEZaIvgQE3tx6zJdqeYlo08Hq2_eBpu8ztMnLrVNT83HZit_BTx6Q>
    <xmx:fKEZaLUOHisqQRBCACbtSMpowQeqB_UiaDTB84YpCCfNPixTzKvc6g>
    <xmx:fKEZaMGCQZbJtTvXmJ-51Zkv-9zXm978ijZvdnIy3BPVRx9ojBjFQTz6>
Feedback-ID: i179149b7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 01:43:24 -0400 (EDT)
From: Ryan Matthews <ryanmatthews@fastmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ryan Matthews <ryanmatthews@fastmail.com>
Subject: [PATCH 6.1 0/1] PCI: imx6: Fix i.MX7D controller_id backport regression
Date: Tue,  6 May 2025 01:42:55 -0400
Message-ID: <20250506054256.4933-1-ryanmatthews@fastmail.com>
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

This patch applies to versions 6.1, 5.15, and 5.10.

On these versions I build tested but didn't run test. I have practical
access to relevant hardware which runs 6.6 but not the others.

 -- Ryan

Richard Zhu (1):
  PCI: imx6: Skip controller_id generation logic for i.MX7D

 drivers/pci/controller/dwc/pci-imx6.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)


base-commit: b6736e03756f42186840724eb38cb412dfb547be
-- 
2.47.2


