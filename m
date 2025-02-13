Return-Path: <linux-pci+bounces-21393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C2CA351AB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 23:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA8A188F324
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 22:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8752753E1;
	Thu, 13 Feb 2025 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="lakk68M2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719332753E4
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 22:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.183.30.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487261; cv=none; b=HURMVeYS2k2/5QACtfG+271aPtDveAyX9nKgfiX8ERiiZRwO7hTNWeOC5vlMllTo0hsgemEUDFoladWYTQNSzbdRUK1dUeAaMzpwV2J8OJGNfoNcA7AQ3udi5hs1TFgTkcjTIiGBtsXwRgV48+Ca5MQOXgg1X2WIKTwSkxPd1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487261; c=relaxed/simple;
	bh=gTg/Dst+lb84ttlI99Z4m7gYGhsGRdWgwl9GT/XpYmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b3Ux/KBZlL26/6EtEfwa7kFQ0Es9xo7h2W3RIIskn59Uz3q+CNoOcA8YisBmxUrBmzbpG+tu19gi5lq1aNtU7NzFonXWlluOSsJ2OeIpx8WeGwyMZUFRpsOWV4jhqULeLqhEdgjN8Gj/fRvjmTGs7SgbAVjl4rBUVTdZBWFINxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=lakk68M2; arc=none smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DMLiPd011922;
	Thu, 13 Feb 2025 22:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=S1; bh=xCM2W9clGNPdVJljL/xnBxgEYK/9OZy14EGmUq4alt
	o=; b=lakk68M2qzhhgLu3yxG1dZgArOh/g18qWs2hgNJAS6nikbkUKYHCIWA5lX
	BGsSP/sFz+UtaLLvwS5vUIbTwpGGa48C1oDgaf9BaAKAZR6ItaeaMqKoJAAIL1Kt
	qYleLs/0VGzl4aCvrBbmWneEnQSq68xVs0leSDZbfTsqIVopsTyRiufyjUR7hXES
	Mlqt4UJ/EhODqyMBASaVohO2VbrGBhR+q0UTfDwMfSI3inlp6y52kiHe5T6wcJ5g
	69fi1E4CcP4f5lW2kAfy/ApA3N2sBLq2lkstYXyZ2gl3qSCSEiglBHyJ6mamxYGO
	QizPTKNQZmQCuPqCQBQfqzBcfnJg==
Received: from usculxsnt03v.am.sony.com ([160.33.194.235])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44p0jpw109-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 13 Feb 2025 22:53:46 +0000 (GMT)
Received: from pps.filterd (USCULXSNT03V.am.sony.com [127.0.0.1])
	by USCULXSNT03V.am.sony.com (8.17.1.19/8.17.1.19) with ESMTP id 51DJx7cL004982;
	Thu, 13 Feb 2025 22:53:45 GMT
Received: from usculxsnt14v.am.sony.com ([146.215.230.38])
	by USCULXSNT03V.am.sony.com (PPS) with ESMTPS id 44pnhv5ax2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:53:45 +0000
Received: from pps.filterd (usculxsnt14v.am.sony.com [127.0.0.1])
	by USCULXSNT14V.am.sony.com (8.17.1.19/8.17.1.19) with ESMTP id 51DM62Vt025105;
	Thu, 13 Feb 2025 22:53:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by USCULXSNT14V.am.sony.com (PPS) with ESMTPS id 44pnhvvpg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 13 Feb 2025 22:53:44 +0000
Received: from usculxsnt14v.am.sony.com (usculxsnt14v.am.sony.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51DMriAl125634;
	Thu, 13 Feb 2025 22:53:44 GMT
Received: from cronos-ws00.ad.gaikai.biz ([10.10.10.214])
	by USCULXSNT14V.am.sony.com (PPS) with ESMTP id 44pnhvvpg7-1;
	Thu, 13 Feb 2025 22:53:44 +0000
From: Maciej Grochowski <Maciej.Grochowski@sony.com>
To: kurt.schwemmer@microsemi.com, logang@deltatee.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        linux-pci@vger.kernel.org, ntb@lists.linux.dev,
        Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: [PATCH 0/3] ntb_hw_switchtec enable 256 LUTs
Date: Thu, 13 Feb 2025 14:53:16 -0800
Message-Id: <20250213225319.1965-1-Maciej.Grochowski@sony.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sony-BusinessRelay-GUID: AltUXmuWYDrfBZ71Xf6yFq-N4U-Oxqdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Sony-EdgeRelay-GUID: Mie7OJO6v4S7dSqLQO9ZwR3oSat-GZOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-GUID: rSe7ds1pPFMhkG3lVOoylLqVLwoLFkht
X-Proofpoint-ORIG-GUID: rSe7ds1pPFMhkG3lVOoylLqVLwoLFkht
X-Sony-Outbound-GUID: rSe7ds1pPFMhkG3lVOoylLqVLwoLFkht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01

Microchip NTB devices support up to 512 LUTs shared across all NT
partitions. This short patch series increases MAX_MWS to 256 and also
address issues when the number of mw is equal to 0 or MAX_MWS

Maciej Grochowski (3):
  ntb: ntb_hw_switchtec: Fix shift-out-of-bounds for 0 mw lut
  ntb: ntb_hw_switchtec: Fix array-index-out-of-bounds access
  ntb: ntb_hw_switchtec: Increase MAX_MWS limit to 256

 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.20.1


