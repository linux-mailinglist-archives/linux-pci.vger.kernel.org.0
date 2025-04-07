Return-Path: <linux-pci+bounces-25376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 244FDA7E0E2
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 16:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634DD164EDD
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26621D63FD;
	Mon,  7 Apr 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="obmqWVdM"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61C1A3A95
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035320; cv=none; b=p4XSR3mLKQj1xxqnVyF/vhMfaovMuytC9fYnm2ekhEXg7plJJ15Up0qsOMRKYH8mJmw6fuibS70IfcRYF5YmpKLEDwsPrJhNK2nejbeaCvGBtCexJ12LLcYykpn1tfy24Ctkj0FQEhu/KiUm0hVeX+ACFu18L/eNh+0LYR33IYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035320; c=relaxed/simple;
	bh=e+e+vr278szPyF9gqwUUwXgvTwdrbh/bn3cWb/Ho4uA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LdJjzMROWAMFdo2/vU8AzpGRKz6WQv5RWXgqcbUfnk9oqMAhIlP4UpKDDukMGFySM2ds5bKqqbj0/vXlfpxLWVA4VFgjqGGAgcxVMuVjAYUHWaqNtv1L8XUOIs7qI5hTH5gade/eZzSDoRqRiMT1R3sEpSofgXsQTn3SrNePbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=obmqWVdM; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=5+F78xouqk0u9NB2GFe7jEG2o1X2pXJr1k7TYzIRk98=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=obmqWVdMRf23SxD7kfn5L3r5PnBeSs/v3sW+3K9WwRuv5c8bf3CnL6FfPAI66E37E
	 JUouqNy607oCMGRllo20t6vruuKZlzsCzJP7X7u9qICxPl2ok0tpXE+/KrKROY5vtV
	 RmC+en8qIki9jZWFrtrHgezxB+F2oMh8rPCTBFmK7BuLUdVLc0ictdjlERsiAxOLqM
	 ohc0kdO7/9E12wga0SsYX3DQohFf3RfDjDiyyTzdWoMOyffUNRunm5xrjTffrQ2buz
	 ybMFoWW11AeH6ycPAYq0UpKoH/y1uNZoTfARbq1viiYuBnAV1jAScjfhlf7TAP7ihm
	 GdiYxi06TzOtA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id D722F34BA950;
	Mon,  7 Apr 2025 14:15:13 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/2] PCI: of: Fix OF device node refcount leakages
Date: Mon, 07 Apr 2025 22:14:55 +0800
Message-Id: <20250407-fix_of_pci-v1-0-a14d981fd148@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN/d82cC/x2MQQqAIBAAvyJ7TjDRgr4SIalr7UVFIQLx70nHY
 ZhpULEQVthYg4IPVUpxwDwxcPcZL+TkB4MUUgslVh7oNSmY7IhLYZX2zsnFahhBLjjsP9uP3j+
 zekXlXAAAAA==
X-Change-ID: 20250407-fix_of_pci-20b45dcc26b5
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
 Lizhi Hou <lizhi.hou@amd.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: HwJcR_D7fSmD09yDX6a1bRhjsmqzFvvy
X-Proofpoint-ORIG-GUID: HwJcR_D7fSmD09yDX6a1bRhjsmqzFvvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=623 clxscore=1011 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504070100
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix OF device node refcount leakage for
 - of_irq_parse_and_map_pci()
 - of_pci_prop_intr_map()

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (2):
      PCI: of: Fix OF device node refcount leakage in API of_irq_parse_and_map_pci()
      PCI: of: Fix OF device node refcount leakages in of_pci_prop_intr_map()

 drivers/pci/of.c          |  2 ++
 drivers/pci/of_property.c | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)
---
base-commit: 7d06015d936c861160803e020f68f413b5c3cd9d
change-id: 20250407-fix_of_pci-20b45dcc26b5

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


