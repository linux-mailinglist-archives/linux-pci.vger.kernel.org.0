Return-Path: <linux-pci+bounces-6956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889288B8C29
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 16:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117071F21A69
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78C338DDC;
	Wed,  1 May 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YhNGVtqZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42721758D
	for <linux-pci@vger.kernel.org>; Wed,  1 May 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575116; cv=none; b=miYcrtsz9b7lAVNUINwfWPWgNTmmWhCMMm/FDleLuYknft2f7q34SUonyMk4n0oRnf2XSBVN1FWA7ZFs5Hv72oHuqbtAEtAu6EwWUkcuuY/wPY9MQz5+v7LTxzCdrQDEKORvNDePOR9sfjyEWuyGpkkgAbGSchbr41wNiNyYAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575116; c=relaxed/simple;
	bh=X6Pnw2tcDN7YZyClgiEZOtBTDmCe3DkN+TIqz9S9Z9s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D3KhXOMdjSDCJs1Bt1xwYHs3tXxSkvPU6D1+a2lBU+ActDEfE6nN6LYX+9AxMtlPqASnIEDdZP3WbKcZ3l2HlCExi/eg8OmBWUnDq1kLhFabcy07x0rQqzOnqfb0jVXkeyErtTzObn0C34H6vMxf2DCdv2R4zRbG1YBF4+ZK3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YhNGVtqZ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441EpKrT017526
	for <linux-pci@vger.kernel.org>; Wed, 1 May 2024 07:51:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=0phYYRi1muT+hJTE/ugnKzt7c+BQuVKX1nJ9cxFrIEg=;
 b=YhNGVtqZtSGezro67d1+4w23YvlHMVlWxtW3FgmLcIZkq6xM+afQG9gdrbspnSCzBS/7
 yIvfXsg2pY3L52WQawcF3Lt+zQ2PNdSLA09YrFIZ4kOpWGoRzjG1yfiE/xup15YXKnO1
 ScKo4r4ggZ7idAghC6Hn5zzeG5cKbPPQp4Kz/HhhPfHIXxlKKk/8AgaOfCwwpD16NmvU
 SoDEAPPRK1HCIdY7e0B1hB6uj1YVfBctwBFUA1V9RY2T5Cn+fxcz3dCtqtEn2i3rnmNd
 rczu5Jht8iFNwNYHbeSV6UiyH3g/0C3dfmYHyP8QwLTQv0+IbJUPLb6tMbJTRbSPCRAi VA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xuqv1802w-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 May 2024 07:51:53 -0700
Received: from twshared10106.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 07:51:23 -0700
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 84B40214B0F2; Wed,  1 May 2024 07:51:19 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>,
        Suganath Prabu S
	<suganath-prabu.subramani@broadcom.com>,
        Peter Delevoryas <pdel@meta.com>
Subject: [PATCH] pci: fix broadcom secondary bus reset handling
Date: Wed, 1 May 2024 07:51:18 -0700
Message-ID: <20240501145118.2051595-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: x3VZMzLPdApmIewDsx65P2tJ86mE8JtE
X-Proofpoint-ORIG-GUID: x3VZMzLPdApmIewDsx65P2tJ86mE8JtE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_14,2024-04-30_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

After a link reset, the Broadcom / LSI PEX890xx PCIe Gen 5 Switch in synt=
h
mode will temporarily insert a fake place-holder device, 1000 02b2, befor=
e
the link is actually active for the expected downstream device. Confirm
the device's identifier matches what we expect before moving forward.
Otherwise, the pciehp driver may unmask hotplug notifications before
the link is actually active, which triggers an undesired device removal.

Cc: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Cc: Peter Delevoryas <pdel@meta.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd42884..4dc00f7411a94 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1255,6 +1255,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *=
reset_type, int timeout)
 	int delay =3D 1;
 	bool retrain =3D false;
 	struct pci_dev *bridge;
+	u32 vid =3D dev->vendor | dev->device << 16;
=20
 	if (pci_is_pcie(dev)) {
 		bridge =3D pci_upstream_bridge(dev);
@@ -1268,17 +1269,22 @@ static int pci_dev_wait(struct pci_dev *dev, char=
 *reset_type, int timeout)
 	 * responding to them with CRS completions.  The Root Port will
 	 * generally synthesize ~0 (PCI_ERROR_RESPONSE) data to complete
 	 * the read (except when CRS SV is enabled and the read was for the
-	 * Vendor ID; in that case it synthesizes 0x0001 data).
+	 * Vendor ID; in that case it synthesizes 0x0001 data, or if the device
+	 * is downstream a Broadcom switch, which syntesizes a fake device)
 	 *
 	 * Wait for the device to return a non-CRS completion.  Read the
-	 * Command register instead of Vendor ID so we don't have to
-	 * contend with the CRS SV value.
+	 * Command register instead of Vendor ID so we don't have to contend
+	 * with the CRS SV value. But, also read the Vendor and Device ID's
+	 * to defeat Broadcom switch's placeholder device.
 	 */
 	for (;;) {
-		u32 id;
+		u32 id, l;
=20
+		pci_read_config_dword(dev, PCI_VENDOR_ID, &l);
 		pci_read_config_dword(dev, PCI_COMMAND, &id);
-		if (!PCI_POSSIBLE_ERROR(id))
+
+		if (!PCI_POSSIBLE_ERROR(id) && !PCI_POSSIBLE_ERROR(l) &&
+		    l =3D=3D vid)
 			break;
=20
 		if (delay > timeout) {
--=20
2.43.0


