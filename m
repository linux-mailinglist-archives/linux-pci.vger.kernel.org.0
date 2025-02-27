Return-Path: <linux-pci+bounces-22518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78354A47484
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 05:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B117A2A01
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9EE1EB5D1;
	Thu, 27 Feb 2025 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="b1qnD13T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l0sT/XTW"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A41EB1AE;
	Thu, 27 Feb 2025 04:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630865; cv=none; b=G+MP6oaCW7OTrN88PH+TzJHid3qVz4ZrHDSSQPLfWinNnZnob2bp0eTno6/CH4Qh7KxNSj5jejFiC4e0fesknPzGgHBShCCck4tuaWUF+BzdDzAfGcce2Zhib+enng/hKNSzN00FOdKfOLEqh7vhC5sywKNDvMFSd0phprR0zT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630865; c=relaxed/simple;
	bh=VcpWO8z77qaNLHG1nRp/n6b+cEG7/sPdYjjnCUOfhBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5HucxnNoG5qrFdtAJnQg967PBged8IzhJdZ0RAv04CfCa4CfK4B/i0oBvpq/mH/aiUROyI5dfrfwknB6z6d297FHh9fJpx1MHOyKRF1KYT0NX+VBUOhHhXOkiw50gpAl6kgtvFcbSDtpCOqOsCXngKsFzViRWvLn4XK7vjo0zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=b1qnD13T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l0sT/XTW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D6CB11401AE;
	Wed, 26 Feb 2025 23:34:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Wed, 26 Feb 2025 23:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1740630862; x=
	1740717262; bh=cGWv2yHIpEPNc0VuJdqBaoIWLEbGRz0HU9xEmUNeCL0=; b=b
	1qnD13TZC1KoT6WCnHUgMh5Vp1PIKKxIrXWT0Rtuk+fA4JmdNoMKy8pCGTNNjegl
	HdA3yoKhjhVE7b7hN60JppdrsAx37qHVZiYsCBm38O2j+ONTAa0OMcxzIWf1YD6k
	mnGcngPV5xnu1WBQQWs69tI9TfslcX2hEhTc/K8UYJlcDot4RGP/wcM87Cjfe0c/
	5aAM7T5bkKRFiSimvwr9lTcjupbLTe6OohOgdwewWenqAujwuX0tPZtA+uTQ/UOI
	XtKZHIYCIVHD3K39rG0GzD/FjsTm2WxanwTDR5RW3AcNAZYClR1eUSvi0VDHUROQ
	zMtDtG//tlNF9IuxWVTCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740630862; x=1740717262; bh=c
	GWv2yHIpEPNc0VuJdqBaoIWLEbGRz0HU9xEmUNeCL0=; b=l0sT/XTWddvSc5YR5
	B2hTbx1T3LiEN23y7QklnO9NkZBXyV5NkKCUh42XRPQdbRdBDriz7Hvyxqvq9DaI
	TIGKnP1D5nw/8azRyieOG5FIuniu1Y0kyEQZLPuYSw/xmkishelLDngWmS9PCKQ2
	IvPVmWX2wjsYM/2xnbI311DSF3UEyAl0cIocNxOgkqzlgRLv4RyE7r6hRXV7Lx0L
	3yKUxhxDviQo8bRSrxAUlqmCTgCUroNhvBoGFWFU5CthA0gNnyeakMFtBk4R/Mjj
	4ukzTPLPxZqgKLLf10YqO1/fySzjIUPozGUcJ2ldx/t0jlt46kqz7ng5ORXYBz9n
	v8TlA==
X-ME-Sender: <xms:Teu_Z0R3fB_dhZq5vF-XQU29Uq63aLTzP52xcGliLdRf0sxr6WdflQ>
    <xme:Teu_Zxz8y21EzIQHWZnNKBvybMPTB53bF8FCTx96s1F2ebimVgcfLxC2iRJOZ9Zhx
    3IAUze6ECoj1_GI8sg>
X-ME-Received: <xmr:Teu_Zx3Yi63DVxLhItPvlnii1zR2OkQONX272-TCoh-USzBxkWZkSM3G93_qZReTMG60gsR36yM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgr
    nhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrg
    htthgvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefh
    gfehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepudeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglh
    gvrdgtohhmpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghird
    gtohhmpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopegr
    lhgvgidrfihilhhlihgrmhhsohhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegthh
    hrihhsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopehktghhsehn
    vhhiughirgdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehlohhgrghnghesuggvlhhtrghtvggvrdgtohhm
X-ME-Proxy: <xmx:Teu_Z4B-VC4b73nD91SvL87Yr0Wi36qRaxWJtdSPdMBU5JGK5OPvGw>
    <xmx:Teu_Z9ig5H1pO5PFWJ-UjS7GuyJiVDLMYZptJRPfdgHUsxJPy4sDsw>
    <xmx:Teu_Z0oo4Rqhj0dfSAHOvwuUzLZA6SUJ-4HK_LJBXJa1_OOvLMagEQ>
    <xmx:Teu_Zwg15n6veUR_VSMKiEK23XPjEkXw8LpB59zHMi6YNTLGf-Uxcw>
    <xmx:Tuu_Z95o9oZ3shg3DKP-TZuzfxEXFKjErVE_v9ogWSpn38x7lSKPOPT2>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 23:34:17 -0500 (EST)
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
Subject: [PATCH v16 2/4] PCI/DOE: Rename Discovery Response Data Object Contents to type
Date: Thu, 27 Feb 2025 14:34:01 +1000
Message-ID: <20250227043404.2452562-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227043404.2452562-1-alistair@alistair23.me>
References: <20250227043404.2452562-1-alistair@alistair23.me>
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


