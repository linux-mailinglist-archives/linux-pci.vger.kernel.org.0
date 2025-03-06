Return-Path: <linux-pci+bounces-23043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE434A543FF
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 08:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32203B0E6E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 07:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663DE1FDA95;
	Thu,  6 Mar 2025 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="RcbtAlu5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RO7G6Nh2"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3281F2C56;
	Thu,  6 Mar 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247570; cv=none; b=MHYNy6+qFR+SWBbLlZvsenehmQOMtB9F6bbDVtZcNfnyC+S7mU6WJegJBYJZn5liE9OZ1d3GkdoqVGIG4k3hrLYfhXXllGeUWabom4lKdbYpHZmdkkd04Oex35kmFheFJ+gvZ/YpHhQ018jJTApqKwdDR8kkmq7417iGVyn36KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247570; c=relaxed/simple;
	bh=Gw19BGiRJ+S1jh287HgloDvNJBa1oVk2Ewb5ZcrtM4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SL8vfaJwmMkIBqN4DzD3qnr6n16Bvz6pfcCIoVwAaiuBXgjD/HeCTXcYWiSBe34BHou+hmW9SerPgyD6rOOVhLl0O5BdfQVRoeC+SMwSPF5XPqzo/OLwkZQ67Iu2eIfIGT7Wem9Q55kBedBtAb2NhtE47zxi22NvWcA1bL1KlA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=RcbtAlu5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RO7G6Nh2; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3763511400D7;
	Thu,  6 Mar 2025 02:52:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 06 Mar 2025 02:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1741247567; x=
	1741333967; bh=+AikzYJZgUWf+WlVSI8pRPzzSPYsq8ldKAtOnTLUJ2Q=; b=R
	cbtAlu5hvjZTHtuWOJu2Ckloj+m+Xm3qmyxZI5QbD70aOKqEq2zBxuleYaeO/fxi
	glqxcW4MYhvy+jIGDnApyT+jiQKCnEclBWXhIhTZTRFBAFB7DYjjfW3pXPRwYUcW
	Ec5sAKIPEO6VDPY9U1DNsBl3LKe2xPZXq/bIGb4hTB8sj4z5D/ILPR+Df4JtiA72
	vsStp9FUQJ/7AG5WmGTsmyBwEgf7bcTo35UM9Xi3T7YX8GaGTCuxTryTdIhP7RGV
	+I+puIwn5NL8ZRyT4i+/PVUI6S/F2PhpxQRg7rn1C3QSWYzTmL/fMerff3JBLjR8
	rNZtghqd+o5B1XZJ4p6IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741247567; x=1741333967; bh=+
	AikzYJZgUWf+WlVSI8pRPzzSPYsq8ldKAtOnTLUJ2Q=; b=RO7G6Nh2eERZC1qh1
	OiYd0x0qsB4+k0HTkSDGujTSMXk1Z+o7IkKTedcxKvDKK39AIVYQvJsy4NU5MmuE
	yALoxoMIQuCculq7RlhKHxL1KXbJp8AktXNR9F5Ly/DLPAaTGEyI/Fmz9irosnEG
	XSGUdR+mL1HDBb+Nar56PVy+suMw3HIHWQdryrT64DCYtPPuiRn3W0xFFRoF6piV
	ctpSYggU99ScWlIzfE3Y7pCaBt07YQYuZZiSCHKFAJtzCN4VrpFeyvPNYCN0iTgH
	ilXekkl6iAmU5vAukaPWTsD52Bct7zBg8dHH0+7YarEtvytzn5xifpZJ7HkdVvR1
	yuemw==
X-ME-Sender: <xms:TlTJZ2lTIOTiSKDOA9FvVIuknnnNNebCx4yn8bupzNc-FAvg_bgfYg>
    <xme:TlTJZ931dWe_AXAJ6HAYI-zR9Xmg9YF7Q_Z6-Ij_TwPWrJ_Gwo_2bLpFIra6lew4W
    E0JodbfK7EActMiM2s>
X-ME-Received: <xmr:TlTJZ0qVOk2KywQXly5WsWIrW7l91KxYfzO_TZr6jeNYyT82TrLE060C8RE2FRCn_mdbHZHhWx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhr
    rghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrf
    grthhtvghrnhepiedtfeekteelvdelveevueeujeffuefguedvteekveejjeeutedufeet
    hffgheehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    eprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvpdhnsggprhgtphhtthhopedu
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghhvghlghgrrghssehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvih
    drtghomhdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtohep
    rghlvgigrdifihhllhhirghmshhonhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrkhhovghnihhgsegrmhgurdgtohhmpdhrtghpthhtohepkhgthhes
    nhhvihguihgrrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtoheplhhoghgrnhhgseguvghlthgrthgvvgdrtgho
    mh
X-ME-Proxy: <xmx:T1TJZ6l4LZWpB47K_4EmIHpxSpQnF-nXYPL5m_oDynyJ3brEnQmJfg>
    <xmx:T1TJZ03602Q4WFye1Y3AS9F8Bdh0fOhbjDBge8QrF2i70ZHKHVwu1g>
    <xmx:T1TJZxtdBWdZSnQDErfYvCHebkSN4F6RwboodghK8nHiTeGWjZdo2g>
    <xmx:T1TJZwV4cGA878lf5eF4Nc2Wu4LKHLiPPH964kpuF9Wq8b3MZa2Zuw>
    <xmx:T1TJZ-M__BoTFUw0dE0x4pral1a2w7ndQm381xRUREQmsucUdog_lv_C>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 02:52:42 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	lukas@wunner.de
Cc: alex.williamson@redhat.com,
	christian.koenig@amd.com,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	logang@deltatee.com,
	linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org,
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v17 4/4] PCI/DOE: Allow enabling DOE without CXL
Date: Thu,  6 Mar 2025 17:52:11 +1000
Message-ID: <20250306075211.1855177-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306075211.1855177-1-alistair@alistair23.me>
References: <20250306075211.1855177-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCIe devices (not CXL) can support DOE as well, so allow DOE to be
enabled even if CXL isn't.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v17:
 - No changes
v16:
 - No changes

 drivers/pci/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2fbd379923fd..fff4f3c6f6d3 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -122,7 +122,10 @@ config PCI_ATS
 	bool
 
 config PCI_DOE
-	bool
+	bool "Enable PCI Data Object Exchange (DOE) support"
+	help
+	  Say Y here if you want be able to communicate with PCIe DOE
+	  mailboxes.
 
 config PCI_ECAM
 	bool
-- 
2.48.1


