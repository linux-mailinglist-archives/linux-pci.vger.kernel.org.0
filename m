Return-Path: <linux-pci+bounces-16187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB499BFAF4
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 01:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323E6282C4A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 00:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A7610C;
	Thu,  7 Nov 2024 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="N8COT8m2"
X-Original-To: linux-pci@vger.kernel.org
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB9539A
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940811; cv=none; b=gMU3SMf1JVpQ5e+aBT7UYwnmkv84+0y5CylGLaOenm8jASCeB70m3aaJqPNRvrDCwRXO0+5mUN17WCOWHpt7l77pkIpShELfjXSZa49cgYs2jni7IPt1k8g99b3bNQlJlCy8ss4vkSQK5rzfUY28GkZE+JUMv4d3Htw06nLG/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940811; c=relaxed/simple;
	bh=MrdZR5eu1M2nFnB/YdbF/PX8tuoD+PLdZKXphLgoFqU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UgMOLfsmkNBb/Ndq7KxtlG1LdTrEWxl77dRqywzSji+CPPaMJhdbaQBUB0vfQTtpPBtnHccqQTzi8ImrjZkQqmIMj4JY1M6wnw6lHd1A73SU9I03hpr8bihqqI/Q3oIAwk3vd0mQpqtncuuU8WzbVx0oP7LcCspyTQRLv4pSeXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=N8COT8m2; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730940809;
	bh=OC8I3JRIV3yaS/vVDQBYjtUQm+4rbt+D6iTS7uiIaBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=N8COT8m2GkjD0eFI97D8CNwjzkzFRsYr8FpR2VGY+R6m03s3oSuGpi/iWSV4+lRvV
	 GPd0P+iJhVB2Et9oN67lt5fQboOUOx7iH3D1X3xafwsU6PnQptJzgFZL//JrqHWUcv
	 nnzZ5c/X7DL+esvQURPFKghiRliHvbIdwWl3VIDypvyX6bhI5btmEzl8MN+oHAVF2F
	 GDP12wcXwB+eJol8zvx8TsrpeoyK6g7nk6ixR+1N0WVvx1vVYAxCRuusgno3dJWlwQ
	 zfu9mcfI0LKNFbsDTgfyYqJoJxmcwyDQ5TkfWMyu422Y3gjfGdycGINXUhLeu4YZuM
	 l74pUYeC2soqQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 3903C1800D8;
	Thu,  7 Nov 2024 00:53:22 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 0/2] PCI: endpoint: fix bugs for both API
 pci_epc_destroy() and pci_epc_remove_epf()
Date: Thu, 07 Nov 2024 08:53:07 +0800
Message-Id: <20241107-epc_rfc-v2-0-da5b6a99a66f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHMPLGcC/2XMSw7CMAxF0a1UHhNkuwQJRuwDVQgcl3pAPwlEo
 Kp7J3TK8D49nRmSRtMEx2qGqNmSDX0J3lQg3bW/q7NQGhh5R4TsdJRLbMUphUPAOnhCgvIeo7b
 2XqVzU7qz9BziZ4Uz/dZ/I5ND55H3NXNo/U1O08vEetnK8IBmWZYva0gtV6AAAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: D0AqXRSHqq08mNOJ1_LrveuaQxzbT9q3
X-Proofpoint-GUID: D0AqXRSHqq08mNOJ1_LrveuaQxzbT9q3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_19,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=441 phishscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411070004
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs for below 2 APIs:
pci_epc_destroy()
pci_epc_remove_epf()

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Correct title and commit messages, and remove RFC tag
- Link to v1: https://lore.kernel.org/r/20241102-epc_rfc-v1-0-5026322df5bc@quicinc.com

---
Zijun Hu (2):
      PCI: endpoint: Fix API pci_epc_destroy() releasing domain_nr ID faults
      PCI: endpoint: Fix API pci_epc_remove_epf() cleaning up wrong EPC of EPF

 drivers/pci/endpoint/pci-epc-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)
---
base-commit: ad5df4a631fa7eeb8eb212d21ab3f6979fd1926e
change-id: 20241102-epc_rfc-e1d9d03d5101

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


