Return-Path: <linux-pci+bounces-18028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023419EB280
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 15:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F9B1889F89
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D812F1AAA35;
	Tue, 10 Dec 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="06CqwVGy"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219D1A9B55
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839274; cv=none; b=WHl9bwTW1pZgawlKUFSfDouM00jkND+z5zU+EN8UWLswnxh8Pj8hlNTmbTiifEsHevAcg4KRygJETAqKUgTYQw94YxHWVYOhP+zoV6B4t2e5tueIMYp/Z1VROBD20hBUmbVjW8nt8M0R17fUpZ93eD5e6WjqzQPUvQobyleQPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839274; c=relaxed/simple;
	bh=8+e/AA77sYSxm1KAVQfMKzWoogKkDDGjLcjjHsjn3hM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X/sNfpvBCUCJzZ3a6RLdDSWZoZDSqVbtVyihQUjFOwnsPYy14zhOJ9EjgWkaeVyRVh5SBZF9jV5p0iOvGp5g8V5EuOZaMvpZ2RmY0d7T9Xp98V2wXkNEa9kwOgWk3Y2mlBVpx0TKRxQAcnNiJrPeZODcg2Ox7WOV72bNgbPd2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=06CqwVGy; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733839272;
	bh=IJ0i8jvvYtAOUxtHXbbbAA9omlwHVpAhBt6zS/cGok0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=06CqwVGyBP/w6rUs+gK0Urjtz0AH+L74lcijDxKn1TrbEq/CIrO9WTcFyk6/HGydO
	 qljcc20+SIOC1oIDZYguTl3GcmGcC8LTBf1LUC0tZ0/bweLh3Z3geRcfX5zKjGfz8P
	 RtJ6qu2qHzYLwzwuXyuQv4pFoMUI9Yvc6Gius0uoFnFAK9TYxvgfCDCA68/4wOeeP0
	 RGAXtZ7N+ABmT+O6yYTKPPbvuKh31a4RcUBSwlLVgNiiVd7KkQjFQz/MD1ZYgrEP1J
	 vlAR/4BqxST8EZcGBCoe0IxV8I2eY/hQh9hmT5BC8ra2VjgFzhYrOp6tlMcs1JlN5h
	 u6X8/W//Ingpw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 8281A800438;
	Tue, 10 Dec 2024 14:00:46 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v3 0/3] PCI: endpoint: fix bug for 2 APIs and simplify 1
 API
Date: Tue, 10 Dec 2024 22:00:17 +0800
Message-Id: <20241210-pci-epc-core_fix-v3-0-4d86dd573e4b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHFJWGcC/32NTQrCMBBGr1Jm7Uh+DDWuvIcUCdOpnYVNTbQoJ
 Xc39gAu34PvfStkTsIZTs0KiRfJEqcKdtcAjWG6MUpfGYwyB62MwpkEeSakmPg6yBuDN06bIfh
 ee6izOXHVW/LSVR4lP2P6bA+L/tk/sUWjRnv0vlWOrbPt+fESkon2FO/QlVK+T7fno7IAAAA=
X-Change-ID: 20241020-pci-epc-core_fix-a92512fa9d19
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <jpinto@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Wei Yongjun <weiyongjun1@huawei.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 0-lwvZK-LFeQ81EucUeOkBtPxer9kBFy
X-Proofpoint-ORIG-GUID: 0-lwvZK-LFeQ81EucUeOkBtPxer9kBFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_07,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxlogscore=528 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100105
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bug for APIs
- devm_pci_epc_destroy().
- pci_epf_remove_vepf().

and simplify APIs below:
- pci_epc_get().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v3:
- Remove stable tag of patch 1/3
- Add one more patch 3/3
- Link to v2: https://lore.kernel.org/all/20241102-pci-epc-core_fix-v2-0-0785f8435be5@quicinc.com

Changes in v2:
- Correct tile and commit message for patch 1/2.
- Add one more patch 2/2 to simplify API pci_epc_get().
- Link to v1: https://lore.kernel.org/r/20241020-pci-epc-core_fix-v1-1-3899705e3537@quicinc.com

---
Zijun Hu (3):
      PCI: endpoint: Fix that API devm_pci_epc_destroy() fails to destroy the EPC device
      PCI: endpoint: Simplify API pci_epc_get() implementation
      PCI: endpoint: Fix API pci_epf_add_vepf() returning -EBUSY error

 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++----------------
 drivers/pci/endpoint/pci-epf-core.c |  1 +
 2 files changed, 8 insertions(+), 16 deletions(-)
---
base-commit: 11066801dd4b7c4d75fce65c812723a80c1481ae
change-id: 20241020-pci-epc-core_fix-a92512fa9d19

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


