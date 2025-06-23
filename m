Return-Path: <linux-pci+bounces-30391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C5EAE4293
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 15:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6D1178D11
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2503E25394A;
	Mon, 23 Jun 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QoItL0vM"
X-Original-To: linux-pci@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster4-host10-snip4-5.eps.apple.com [57.103.65.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA34C7F
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684702; cv=none; b=IVyNCVyTRy7G13x7Z1RGQHBIgmfjb8a/fbMaoVjmkPNBQWgaBQQ+59ZrqpQXFkpbwtqH6lj3KU/Uy/L1bgbV5HqTp3Ekte/xAHrThyKZWL710SEIGp1RyWhXhUlvVUu185jN+OsAd6ic8lO1nTmOITcXLppETeT3BFbm7GrM0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684702; c=relaxed/simple;
	bh=hGL+O64Kgwi3JLzYOP69Z4x9abzBj8jCUu6rxSh82Qc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gt0FmQZzrsmPs8ZroRzH8XlEn7t0ZIVSH/8tN0sJjXEAk5nV8yankW18WPeoCNDmYs9+uGOKjMw9BhaNU4jtcJZdmCgjyCHxRMHOft1TWrFktFHZ0vBUNsoNLo1Q30u5lvm1FkwEkiGRjr3IrCl3FHJHn1DTndghGVcCOYMl4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QoItL0vM; arc=none smtp.client-ip=57.103.65.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id E57B018004D9;
	Mon, 23 Jun 2025 13:18:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=IPYp1WXvz2awZJLrrDoAg95UcNF/Dwv3JgXuLb/Y64Q=; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme; b=QoItL0vMc4n7v1vQHmXINnKWRfVprzpKJjqHr8XOhfp8qGnVR8FAowRG9cwRoMqDcg2xiQhkHstEyyVcIQwGjATfyYNU6ktdTDN/oYgqdRjiR5tA8iLrJ/ER1TL1ITRVmmiRbRE2VHklW+H4PmIbilyU6Z3NpUdMBwnyp+5zMnQBuIOcmKelMOGDJ2iIsCHF1FIln6u0/CTKkFRo+wkhPhC0x0oRkvd2RtnBfTiOZhWGR9X1hilH+UCy/ASf8y4rQ48UCnLjC4qNTWZgc9lU/TmYVBPo3TERbf81VYCtGIvhQJ3hbsC6S76jnC5wRxNNFu2xAAszq9YgFS78ZOjvlQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id E612E18001E8;
	Mon, 23 Jun 2025 13:18:13 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 0/2] PCI: of: Fix OF device node refcount leakages
Date: Mon, 23 Jun 2025 21:17:37 +0800
Message-Id: <20250623-fix_of_pci-v2-0-5bbb65190d47@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPFTWWgC/22MwQ7CIBAFf6XZsxggoNWT/2Gapl3A7kGoYElNw
 7+LPXuc9zKzQbKRbIJrs0G0mRIFX0EeGsBp8A/LyFQGyaXmip+Zo7UPrp+RmOSj0gZRnkYNVZi
 jre8eu3eVJ0rvED97O4vf+jeTBeNsEMpcWuGMUO3ttRCSxyOGJ3SllC+QQCgWpgAAAA==
X-Change-ID: 20250407-fix_of_pci-20b45dcc26b5
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
 Lizhi Hou <lizhi.hou@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Zijun Hu <zijun.hu@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MCBTYWx0ZWRfXyxbfRb22vCvV
 9eKMT9hn2MMHwRnk9YAbOoen629wJZ1aKzXRLet6EwpWX2ZTJw9iDKp//SZifTdgVAmOuRdGp31
 +Pjb7w2aHJ/aspCkxHOQxXvLRC9dLLPUzukCRzn5cKxDbfg9BPxFtZjhIgEgvQniYTxqz8VZ0wG
 nlnVi9KHm5+6utqZronnykxlypE5iaCrQawpwlDDRw8fjotAqEgrRItP33Lxj69v38ip+3u3tB1
 IV3Jm4lCvlqOVQuKLKGh74oODWM9BavFg+r+E4xxH1WRY9AyG3EBv0RhZwF4Ujbylyxn1yuiY=
X-Proofpoint-GUID: hilczxtHtrYGtExfOj-ync3zgWvv2vgO
X-Proofpoint-ORIG-GUID: hilczxtHtrYGtExfOj-ync3zgWvv2vgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=895 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506060001 definitions=main-2506230080

This patch series is to fix OF device node refcount leakage for
 - of_irq_parse_and_map_pci()
 - of_pci_prop_intr_map()

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Similar fixes within mainline:
Commit: 962a2805e47b ("of/irq: Fix device node refcount leakage in API irq_of_parse_and_map()")
Commit: ff93e7213d6c ("of/irq: Fix device node refcount leakage in API of_irq_parse_raw()")

---
Changes in v2:
- Change author mail
- Link to v1: https://lore.kernel.org/r/20250407-fix_of_pci-v1-0-a14d981fd148@quicinc.com

---
Zijun Hu (2):
      PCI: of: Fix OF device node refcount leakage in API of_irq_parse_and_map_pci()
      PCI: of: Fix OF device node refcount leakages in of_pci_prop_intr_map()

 drivers/pci/of.c          |  2 ++
 drivers/pci/of_property.c | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)
---
base-commit: c10ba24fb5c9d6e2eb595bf7a0a00fda8f265a0b
change-id: 20250407-fix_of_pci-20b45dcc26b5

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>


