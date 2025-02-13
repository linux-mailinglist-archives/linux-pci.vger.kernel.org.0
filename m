Return-Path: <linux-pci+bounces-21402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8100EA3525B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 00:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B2F16C2B6
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 23:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E971C8600;
	Thu, 13 Feb 2025 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="A7ID/3d1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9658C1C84D5;
	Thu, 13 Feb 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.183.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739490614; cv=none; b=M14caYOKdRmkYC6jjyeSaEkyNztuepI5WTVYabPdz92dmM4mX9UplWVBcnC9HsQ/TadWlEdRL3sCLlpSWDDHeV784mr7B6rL3nJP58Hrqwc3+xlUKJ1nukeJ7s1k7jDHplJ9IrWYj2sJnxTnXAVZyMBW1XEdXOomBSI5/kEfaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739490614; c=relaxed/simple;
	bh=YwdKjtTYS3+zptSjDBAb/erAKI8A4xk6i0sHjTqzoh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jV2KuggZboh92OGttqW/A4Oc6MxWtAFp6TR7im2bqMj5BR6mjNI0v5lo/ChIONSXOR3PmY2MpKbb6AiIpy1N3AWtFFA1HDAn+wDGSW0s75o/Py9j+F0HhG0HpGkf33qxqJezr+vxhx4Y1p23m7R6Tbq92WY7ur50iKUEkhjk3EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=A7ID/3d1; arc=none smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DJhlCi027348;
	Thu, 13 Feb 2025 22:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=S1; bh=8NHMDldMEuw6WIZ0B7
	u7QFZhMPvYiDmpuy2D7Zl34aQ=; b=A7ID/3d1JNB0xgVv2CDdm/n0Y5hTIoyA/N
	37Df7mZNK0LRjV7NJnar4OJi2FzvxGmqVZpSshL/9HOYWwGAOsxuCrhO3qgy/gJU
	dse1bcufkh7G25zxJ0hBkcZozrMAxKSy0A4hqnvmCj+J4p/+2e1n0Mpx81QPDhOw
	kOucHht7aOhsp7jiVT7IS2Iwsv50B6kMNSAxNaXUho8Q259I/lE49pSmqexMHaU+
	tlTowt5HhwX0KlTXT39nWfSvWLmUL4dOEA3A2wWNz8PLrNnSVtdZmRSGL90nQlXE
	T7s0PNd9dXtYtqN721kU0NbGrnLWQ/9t1h9S1IL/oyZ0A9o1GxNw==
Received: from sgppsea01v.sg.gdce.sony.com.sg ([121.100.43.225])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44p0mmdgtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 13 Feb 2025 22:53:59 +0000 (GMT)
Received: from pps.filterd (SGPPSEA01v.sg.gdce.sony.com.sg [127.0.0.1])
	by SGPPSEA01v.sg.gdce.sony.com.sg (8.17.1.19/8.17.1.19) with ESMTP id 51DLRppk022529;
	Thu, 13 Feb 2025 22:53:57 GMT
Received: from usculxsnt14v.am.sony.com ([146.215.230.38])
	by SGPPSEA01v.sg.gdce.sony.com.sg (PPS) with ESMTPS id 44p0bmgbk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:53:57 +0000
Received: from pps.filterd (usculxsnt14v.am.sony.com [127.0.0.1])
	by USCULXSNT14V.am.sony.com (8.17.1.19/8.17.1.19) with ESMTP id 51DKd6lV092768;
	Thu, 13 Feb 2025 22:53:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by USCULXSNT14V.am.sony.com (PPS) with ESMTPS id 44pnhvvpgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 13 Feb 2025 22:53:54 +0000
Received: from usculxsnt14v.am.sony.com (usculxsnt14v.am.sony.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51DMriAn125634;
	Thu, 13 Feb 2025 22:53:54 GMT
Received: from cronos-ws00.ad.gaikai.biz ([10.10.10.214])
	by USCULXSNT14V.am.sony.com (PPS) with ESMTP id 44pnhvvpg7-2;
	Thu, 13 Feb 2025 22:53:54 +0000
From: Maciej Grochowski <Maciej.Grochowski@sony.com>
To: kurt.schwemmer@microsemi.com, logang@deltatee.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        linux-pci@vger.kernel.org, ntb@lists.linux.dev,
        Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: [PATCH 1/3] [PATCH 1/3] ntb: ntb_hw_switchtec: Fix shift-out-of-bounds for 0 mw lut
Date: Thu, 13 Feb 2025 14:53:17 -0800
Message-Id: <20250213225319.1965-2-Maciej.Grochowski@sony.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250213225319.1965-1-Maciej.Grochowski@sony.com>
References: <20250213225319.1965-1-Maciej.Grochowski@sony.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sony-BusinessRelay-GUID: F1OhbvlU05EFDWnPyfUPs3NTY_XyXnts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Sony-EdgeRelay-GUID: mICYUBQG4l03tOJ_gR2plvBEOwi5aRuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-GUID: 5G5k_rLuJ25iXar4E9tM7C7hLlpV5Taq
X-Proofpoint-ORIG-GUID: 5G5k_rLuJ25iXar4E9tM7C7hLlpV5Taq
X-Sony-Outbound-GUID: 5G5k_rLuJ25iXar4E9tM7C7hLlpV5Taq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01

Number of MW LUTs depends on NTB configuration and can be set to zero,
in such scenario rounddown_pow_of_two will cause undefined behaviour and
should not be performed.
This patch ensures that rounddown_pow_of_two is called on valid value.

Signed-off-by: Maciej Grochowski <Maciej.Grochowski@sony.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index ad1786be2554..6ab094b0850a 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1202,7 +1202,8 @@ static void switchtec_ntb_init_mw(struct switchtec_ntb *sndev)
 				       sndev->mmio_self_ctrl);
 
 	sndev->nr_lut_mw = ioread16(&sndev->mmio_self_ctrl->lut_table_entries);
-	sndev->nr_lut_mw = rounddown_pow_of_two(sndev->nr_lut_mw);
+	if (sndev->nr_lut_mw)
+		sndev->nr_lut_mw = rounddown_pow_of_two(sndev->nr_lut_mw);
 
 	dev_dbg(&sndev->stdev->dev, "MWs: %d direct, %d lut\n",
 		sndev->nr_direct_mw, sndev->nr_lut_mw);
@@ -1212,7 +1213,8 @@ static void switchtec_ntb_init_mw(struct switchtec_ntb *sndev)
 
 	sndev->peer_nr_lut_mw =
 		ioread16(&sndev->mmio_peer_ctrl->lut_table_entries);
-	sndev->peer_nr_lut_mw = rounddown_pow_of_two(sndev->peer_nr_lut_mw);
+	if (sndev->peer_nr_lut_mw)
+		sndev->peer_nr_lut_mw = rounddown_pow_of_two(sndev->peer_nr_lut_mw);
 
 	dev_dbg(&sndev->stdev->dev, "Peer MWs: %d direct, %d lut\n",
 		sndev->peer_nr_direct_mw, sndev->peer_nr_lut_mw);
-- 
2.20.1


