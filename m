Return-Path: <linux-pci+bounces-23041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90096A543FB
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 08:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B87D3ABA59
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 07:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD9C1F8736;
	Thu,  6 Mar 2025 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="bf5KmD4D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sxF3EM4e"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271AA18DB34;
	Thu,  6 Mar 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247560; cv=none; b=fP7xr2gsjgiPXHVBUuQLhj9tV+4nwlE0BKOmCdmqNh4hu+fxYADKf+Us30vXASbgjqAlu+p7Fb/xe0QPW0yOLAEj8TZeGbYH3+t/Yc2lW2dtSaBySKMwIgVJYiO+B5591eOpqw+mpf6iyhOLOcIroyKM2naCWTecf3tIdHOHsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247560; c=relaxed/simple;
	bh=M/YxEJ2L8wTs1U/PS4HQTpEb4DZJAEYAupnNN2j3Jzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSAzyy7bTy6tGpL47Fyy2L/xKVYjYTJPAVw6f5IJhzUA9UVSh0HjR+4bPWdTS+SI6QMIRWpRkFvJnbUu396evIPBKijlrCuEthgl87IoERtIJy9Nh778csc3IMQCJJUevZj/Gdej2qtjyWVYacptXAAj99QodLdtl+TlpESqjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=bf5KmD4D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sxF3EM4e; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DBCC811400DD;
	Thu,  6 Mar 2025 02:52:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 06 Mar 2025 02:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1741247556; x=
	1741333956; bh=YRcThRT2EhjAfRZeeeirJn8cTWGB4Udwa6OEE37/Slo=; b=b
	f5KmD4DP8y0T3Kz0xCNeM6wDMtr5gAAWc0kINzA3QuNdjIQrJKT5tzacR9R1t3Mw
	Rv2esVRK33KfGLH4+nlky68oqrjy6PDMHp6XW1bhSTP0iMErTAIh4CdGilHBQ9nW
	UnVfy6wP8YfWxeH1gGXt2RcZuoNioLBiSWlvc68UlExS/3h4RXk2nnoDC9kXEJwt
	Ldam3ovNwxL8hscM9AOZzQROyl2bRAaUii9jhkbOmH+KLrupK1lStwTMsanw21OM
	vgTQaPgFnIpZlvhc3dZZI9NCDu1PGaUmLSUcn0C0uI1Eg2iSC+9bDX6ePCtge0+q
	aSUfVgzUw0PCwLC2Puvrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741247556; x=1741333956; bh=Y
	RcThRT2EhjAfRZeeeirJn8cTWGB4Udwa6OEE37/Slo=; b=sxF3EM4ejTQYiCNCN
	76OkwputIAZ3+wLxuT2kqMoEBhYkYj8a1juTV/mW77bsugEDMNDVpmiS59xwHUIc
	0FziZmdkKZxHIjK3o5cL8qT3bUE8/uC6wFHnwLNw2F0ypnIvontSrwjzAK61g+qc
	nJiceyiCjcrYZt04ETksNDb+JmygYAuAjeczwBx5iAG956ejDBljYdbrZbBSiNSy
	QKoEjzeSVs0+BXxnbpyCG951nlMvEqeczGEvzLTT0+CQAe+6oJpfbQS1EfyS8X9d
	E4uFDtfRmhKN9egtBpGwCUK34zwmHaZ5yyabAbWvsZIeEdJqQ58YhhUOzuA2RN9R
	VSNYQ==
X-ME-Sender: <xms:RFTJZwxS-Pi_MjiyaFUxUxCMV5lAzSOJL6_b91qYcSnSYiXGy3Hypg>
    <xme:RFTJZ0TTd27JvFPuZZER6mwEm6_Yhyj3paFFh5ugXL0tF6Xn-fjrKfqbSjY1ATB7a
    dJ2rUxf1G77BpBtiik>
X-ME-Received: <xmr:RFTJZyVk5GK77E77w2MEJ0gAtp2pnjk4NB3kKaNAET4XZ3yd7CB4U59qYm5UuLnaMBa90UZgHCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhr
    rghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrf
    grthhtvghrnhepiedtfeekteelvdelveevueeujeffuefguedvteekveejjeeutedufeet
    hffgheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
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
X-ME-Proxy: <xmx:RFTJZ-hNN_rQWV9lx7bUO3oSUj78X1W_jbgBrfHT_TD5IOmflFsJ4Q>
    <xmx:RFTJZyBgrndFVBhTa2ocd7zfgQq3tkZLtBVsr9fWMA9kJSLHKQspGA>
    <xmx:RFTJZ_JJAn6syRw_sNL7RhDaRJndL_6MRWP44Es7yBjKnFWGhkr-Qw>
    <xmx:RFTJZ5B5Hi_A5ZZXdgx3EQ51CgK-vggltmfW0usmjJrrOHrHOzaBKQ>
    <xmx:RFTJZ6ZWit2dy3AwsdWWWz37pofwEHjbuxCl6R8ak5So70L_NVa3TVIC>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 02:52:31 -0500 (EST)
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
Subject: [PATCH v17 2/4] PCI/DOE: Rename Discovery Response Data Object Contents to type
Date: Thu,  6 Mar 2025 17:52:09 +1000
Message-ID: <20250306075211.1855177-2-alistair@alistair23.me>
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

PCIe r6.1 (which was published July 24) describes a "Vendor ID", a
"Data Object Type" and "Next Index" as the fields in the DOE
Discovery Response Data Object. The DOE driver currently uses
both the terms type and prot for the second element.

This patch renames all uses of the DOE Discovery Response Data Object
to use type as the second element of the object header, instead of
type/prot as it currently is.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v17:
 - No changes
v16:
 - No changes
v15:
 - No changes
v14
 - No changes
v13
 - No changes
v12:
 - Use PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE for PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL
v11:
 - Avoid breaking changes to userspace header
v10:
 - Split original patch into two
v9:
 - Rename two more DOE macros
v8:
 - Rename prot to feat as well
v7:
 - Initial patch

 drivers/pci/doe.c             | 18 +++++++++---------
 include/uapi/linux/pci_regs.h |  5 ++++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 2f36262e76f8..f4508d75ce69 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -418,7 +418,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u1
 
 	response_pl = le32_to_cpu(response_pl_le);
 	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
-	*feature = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
+	*feature = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE,
 			      response_pl);
 	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
 			   response_pl);
@@ -426,9 +426,9 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u1
 	return 0;
 }
 
-static void *pci_doe_xa_feat_entry(u16 vid, u8 prot)
+static void *pci_doe_xa_feat_entry(u16 vid, u8 type)
 {
-	return xa_mk_value((vid << 8) | prot);
+	return xa_mk_value((vid << 8) | type);
 }
 
 static int pci_doe_cache_features(struct pci_doe_mb *doe_mb)
@@ -442,19 +442,19 @@ static int pci_doe_cache_features(struct pci_doe_mb *doe_mb)
 	do {
 		int rc;
 		u16 vid;
-		u8 prot;
+		u8 type;
 
 		rc = pci_doe_discovery(doe_mb, PCI_EXT_CAP_VER(hdr), &index,
-				       &vid, &prot);
+				       &vid, &type);
 		if (rc)
 			return rc;
 
 		pci_dbg(doe_mb->pdev,
-			"[%x] Found feature %d vid: %x prot: %x\n",
-			doe_mb->cap_offset, xa_idx, vid, prot);
+			"[%x] Found feature %d vid: %x type: %x\n",
+			doe_mb->cap_offset, xa_idx, vid, type);
 
 		rc = xa_insert(&doe_mb->feats, xa_idx++,
-			       pci_doe_xa_feat_entry(vid, prot), GFP_KERNEL);
+			       pci_doe_xa_feat_entry(vid, type), GFP_KERNEL);
 		if (rc)
 			return rc;
 	} while (index);
@@ -675,7 +675,7 @@ EXPORT_SYMBOL_GPL(pci_doe);
  *
  * @pdev: PCI device
  * @vendor: Vendor ID
- * @prot: Data Object Type
+ * @type: Data Object Type
  *
  * Find first DOE mailbox of a PCI device which supports the given feature.
  *
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..7f9af95e2e6a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1205,9 +1205,12 @@
 #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
 #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER		0x0000ff00
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
-#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
+/* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
+
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
-- 
2.48.1


