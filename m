Return-Path: <linux-pci+bounces-15844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748289BA0BD
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 15:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D481F21951
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 14:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D17519E975;
	Sat,  2 Nov 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pOxZcKSk"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CDE19D081
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730557600; cv=none; b=obb6viOBpjillbZgB0BNXXA5oSdokE43KIZOwTR09YLVGd/oyJ0M1AZQZH/nSODQVV3oh1XWs0lai4MUcKa/ga9LGKUdInJddwmdtpGwk59tqW4pTl5IMc0NgZv4v26bz5N+HWuaxrbneDpayc4sZJCSvDq60v4SZqxlUe/p8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730557600; c=relaxed/simple;
	bh=B5uj7fFZFGlYUPPxcsqRf6Qf1AxEihPlkRvJtWFl6P8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CFYJMEzp9bJiyuVTyEZq5FpplOCHOqBqzDK4x73W4qssjCbcPY9thyXHxrhzM8kKTxaaaKRsn3Ict/9HDMv1oy+w9fGXz/7TZ8zgeb435ihBiwaPdEJTKgKoNhf9qsCPmJyTmr54a7J2SvKgLsPwt3IbT7RcFKqF+PmRmAaGwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pOxZcKSk; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730557598;
	bh=2qJA0iT+79jJZMm6vexuDaqDkPei5IKQN5lIHoHArPw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=pOxZcKSkU1bXNHMCmaBjOU6Tv4aY4gRQrCy98dJQ5/k4BTmRLjveEzIbe8KtNykVN
	 su6k1Yk+jmKFJrOzD4d1EcDuT9rNyvuJLMqlNqEDGNqtJlPLVDCkla4OHAaneJZptU
	 vcSU0rRJwLZNd9h36H0hBMJVv0RPiLY6E/qsmeR8YpJzCsJe7gnijFSJFzkABd0k9q
	 1WFVZYtLheaaZVPGOxyJbVWZO8sBZAa8PU4nTFOspM/pA2zQeX0AxAIiUcXqowxp7E
	 5OOuMwECKwwGsf2QY5XWJCuO3hPHMXjWMYVZHSgQQ/9E5zPY6CAIwalE/zUMciCwrH
	 jfcx/IgHrgUjw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 3ACACC80113;
	Sat,  2 Nov 2024 14:26:31 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH RFC 0/2] PCI: endpoint: fix bugs for both API
 pci_epc_destroy() and pci_epc_remove_epf()
Date: Sat, 02 Nov 2024 22:26:13 +0800
Message-Id: <20241102-epc_rfc-v1-0-5026322df5bc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIU2JmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwMj3dSC5PiitGTdVMMUyxQD4xRTQwNDJaDqgqLUtMwKsEnRSkFuzkq
 xtbUAX3I9AV4AAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: R3s9R9NWQbSqjSXMPZ-DrbaAHYmNU9fd
X-Proofpoint-ORIG-GUID: R3s9R9NWQbSqjSXMPZ-DrbaAHYmNU9fd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_12,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1011
 adultscore=0 mlxscore=0 mlxlogscore=430 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020128
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs for below 2 APIs:
pci_epc_destroy()
pci_epc_remove_epf()

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (2):
      PCI: endpoint: Fix API pci_epc_destroy() releasing domain_nr ID faults
      PCI: endpoint: Fix that API pci_epc_remove_epf() cleans up wrong EPC of EPF

 drivers/pci/endpoint/pci-epc-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)
---
base-commit: 11066801dd4b7c4d75fce65c812723a80c1481ae
change-id: 20241102-epc_rfc-e1d9d03d5101

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


