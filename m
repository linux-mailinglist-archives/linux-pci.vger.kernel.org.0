Return-Path: <linux-pci+bounces-25377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C62A7E125
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 16:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DFC3B00DB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69DF41C85;
	Mon,  7 Apr 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="C2xvzMbN"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791C01D61A5
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035324; cv=none; b=dfi+degpf96R+chWbQEaHsTMoBay07OVYcTPn3WJcV32Jm8hcRwFO2RmMWSx1g00+gprhyv8tcpMwKeHgGpDh7GQeWBQ4wjJDivdpDBTHcVEu9VTEtn4/U4eI76FR4VqWuyfVy3B+pzYoRoVl0aKJAefNFIKIi26DMPC06jOmsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035324; c=relaxed/simple;
	bh=FGMzFht7sYyJH3fHbO3rJ9gt4mL0Jp0IXQJkLSJxcR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qh2va+QjY1yD3JL9UpGsX1ZvTXHw3e2VPMqwuN/OHaUL/4Pvs5RwYx0paBSBr0dcTNbAH/dm0/z9sd+gdrYOtLhcEMwhYXcpNtrRJkA/QnYtXblJ2gRytBgqGsgwLXPWhXWl209Dg5uiKddJscnPHVIXqKRRc+ewbojsuG2TzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=C2xvzMbN; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=zIc+teFC5HxNtKRb6tabwtXjk4yww4FlTdpPz50t3m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=C2xvzMbNvtwax7t9LF+4nxhbQbUlxdpR3+oGqpUDK0tksWhu1H+vsR8YNHFU1oys/
	 EiKfMaONtRsHbr/tzFazKW3o7Pq0RswuRO15/BDrpIz1OlXqeyVn3aqdFlTTL1ny+u
	 f4DHUOZZGIyvsmpUNhBa2BwmauPte9OFOS+GOXuz+pfMIX/KdPr7IQTCdphTM3lL2o
	 YtOOjZSiIv8f9Sh7OEE8xDv4MOgMJjMC6YrvuOThOSsUEhRyt7PL0TUukKAnOvA8WM
	 j0tqdE91G044XNB2LjFN2K2WrLA2nLsi2Gj4nFV8YBtZS4yZuIjrJXaB9rnXSRu9WX
	 idK1B2bxgpxyw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 03A7634BA628;
	Mon,  7 Apr 2025 14:15:18 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 07 Apr 2025 22:14:56 +0800
Subject: [PATCH 1/2] PCI: of: Fix OF device node refcount leakage in API
 of_irq_parse_and_map_pci()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-fix_of_pci-v1-1-a14d981fd148@quicinc.com>
References: <20250407-fix_of_pci-v1-0-a14d981fd148@quicinc.com>
In-Reply-To: <20250407-fix_of_pci-v1-0-a14d981fd148@quicinc.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
 Lizhi Hou <lizhi.hou@amd.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: v1g6p036Y7IArCEH4aHH1TM5eRGRHLxg
X-Proofpoint-ORIG-GUID: v1g6p036Y7IArCEH4aHH1TM5eRGRHLxg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504070100
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Successful of_irq_parse_pci() invocation will increase refcount of
OF device node @oirq.np, but API of_irq_parse_and_map_pci() does not
decrease the refcount before return, so cause @oirq.np refcount leakage.

Fix by using OF __free() to decrease the refcount.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/pci/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index ab7a8252bf4137a17971c3eb8ab70ce78ca70969..0a5cba7df1bc918dc537d187c145b9fd73c520b7 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -576,6 +576,7 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
  */
 int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 {
+	struct device_node *np __free(device_node) = NULL;
 	struct of_phandle_args oirq;
 	int ret;
 
@@ -583,6 +584,7 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 	if (ret)
 		return 0; /* Proper return code 0 == NO_IRQ */
 
+	np = oirq.np;
 	return irq_create_of_mapping(&oirq);
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);

-- 
2.34.1


