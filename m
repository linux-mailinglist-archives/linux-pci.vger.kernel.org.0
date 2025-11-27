Return-Path: <linux-pci+bounces-42196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F8C8E505
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 13:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B4474E6F8D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3F33328EC;
	Thu, 27 Nov 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WRkT38xD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fHbEc0PK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642EB11CBA
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247599; cv=none; b=C38qLyawiND7Hn81xAKurUlAPTb6us8zjD3YUXX6JU031KzW6WOIFtBMmwcLdEWLupWJDgEcoAElcvK5W7GXMw3sG9r4XsdculJ1rZYQpanFKz10RUBPrH6HmwfNRyXNybZW1TQjq436JtfBQemfYbYMi1lMB/GbuVEGpaaCiIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247599; c=relaxed/simple;
	bh=miFInMvn53m82x7l9rTHmWzPJOBbC4ekTp1q47Dn4KM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bRmtkVr9+YsNJEX8hVvaxiQ/S744Ozac5/ugmq5sTofVFMQAYJl4dIe1P1axuWTTZBNp1v+JXmv/CK3LVrLFc2e10bAJhYML7ILM9Nh08lYuj8v4SzFx9rDYCXeSXt0fno2tV4RZMYGD1Ge+FBeEsTv6UqXFUeQVrHDjp/w6/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WRkT38xD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fHbEc0PK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR8ECxi2388029
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 12:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=35K72LZ7CNIXSUqEkvYcGn
	b+isW7RPlSHl1quDFVlOg=; b=WRkT38xDeV8m8Lv5mcCKD0aCvW5HtO+cPpF/d0
	mt7Zye5fhU5x0oS5Z67gnwGkksL//EeDmEFpzVtnaN3qPLFpUTNsI6qcTACDXcn2
	cEG4prmdZi4Oe2Yg35LlQs8rqN23F5zVVaZcKpKpByV+WRsXfLc7SbboDf06Vi4z
	6Oi6ZnPu9BN7gH33g9Nld75bbnx0aKbyx3nZafzJ+FvML9l+FqFX0nS+hpeSSamD
	Ls1hC2AmWO200BbjEc40pZXFL087L0ZTGLZTlx3PpfUVH9ARPkivDN07hqcPHiIL
	q2DL/pblgHrYWGB6ZfS7CfxrE1H5DFJVoe8YrqWx9lUyzA5g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap7n8je8v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 12:46:35 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7be3d08f863so1233413b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 04:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764247595; x=1764852395; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=35K72LZ7CNIXSUqEkvYcGnb+isW7RPlSHl1quDFVlOg=;
        b=fHbEc0PKzhcrJZ8/Rm2IAjGt0G6bBMkjrXln3qYj1Vvpifwww/U6Wnasg02W8rt2E3
         q4/JIQsZFbcoXcAcQslJdXfLV+e1icx3zdnQKCsoAc6pB97hcwv3zTIyAuGu5UFcParc
         f+iOhvHBYFvj6J86MjrqdII7mttz6KUNlrVTLcjEBYeIIFL7q64VIq9lDPWKNC2CZydX
         MUUtN9Qk0NBO//rhkYhnMTImiK26BiPQmLxPbNsIFxXZ9E7C1K2QohIHuws6rvtuDBfB
         PuPmFsfvmMCpCgi/WDu3cUXRJaSitlw/4bPyAxxesfBIquiX77Zlt/9ZIVjeYhdj9RTH
         n3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764247595; x=1764852395;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35K72LZ7CNIXSUqEkvYcGnb+isW7RPlSHl1quDFVlOg=;
        b=CcJfXA5tAqFKb0F0fe0tdNGLIHwpDAK43Ks+1qzoO9AzTcxrfdHS5erKiYBGkqNZp5
         GJj4vO7/MvmAcJpJKe3O61PFaXNE8NpCZ4kyMruXPYm7Y5G0iLbxwCmRI9UvB/4LKL+G
         v+5fC7CbNoJSyieBwGo/cn9y/w2SgftnNpkdQMZyw+zMBep1BgNgcuZnBvfUD6HSsFpE
         JXroZS3fEMl5ckaHHm2F59HQm6McJc0Qzh27rI6Hu2W2oflJcdX6YGXKpKTxu6I8fbAr
         gYuMCPIH3huTn2B5EA4BaVdPO329ISfBOy1b8lA0EOHrNd/xRo17c/3eYhf1eXValj2J
         zRdw==
X-Forwarded-Encrypted: i=1; AJvYcCUkHcpcYSn7puomp/JHiIzQT4Exlo1EtB5gtiVbNUfl/tTWOJ79FzTKPRNs8W17DQAUHf8TQwNsHzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dPhBHXHLFkoRJ8Y7bg6tHnKFgW5peXxHbT8H5L5Ge2OeYUkC
	fvuYYGFG3rFiChbIEeIXLvN9tzU7hrSTiWXHUx+foytqPrXAqG7vMHeqH3lAm/1HJ6U1wtFV9Et
	KRH5k2SFqkd68TiVCFQfLTwsS6xxQ5XBJa/n/48L+IniIAusPiOm5b8JijOrbcWa8hWlVlZI=
X-Gm-Gg: ASbGncv9V6A2P9RXnpzToKzW/OyR5V7man1UwGEwWTrsZBPVcB+Yk/njgFQlnPzBBgR
	p5Qft2eKNn4I5irILkNI8jN+PfrSGYmscUbgsCRrU3P9D0k+WfKw31DpnOq1xou/ueRDjy47DxV
	I5+gYrOhoHsvVMW60mg6OrflpACr+I4yjCkOMc3CUTwdIhF+IRDcVhK12y+T1Jr2IdVGJMMqTOC
	CSzd8TQQ/EloeS+uKKj2aK4MmE5VFDxelXH6PpyaILhp9EtzfoVghGcLQ0W+PdTyuIcp4IxtEvU
	HqUceEbXjfWIqa5dFnLG4zD9vPN8DS8d/T4Qawzq87Q0qO9VfqQnusQVgi3HTQ/W/e747dcY6kL
	hi7Tiw+pIKajA6pW8xghsqpjk9/Pw9oIM1hywRcboIKo4
X-Received: by 2002:a05:6a00:1994:b0:7aa:93d5:822c with SMTP id d2e1a72fcca58-7c58e605aa1mr20761404b3a.23.1764247594607;
        Thu, 27 Nov 2025 04:46:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaOJRu3Qz3ekc1mYpEpd1CX08/AEElXAiHNTJwvQ3ibgLJx8n+aA0c61o6xfPzOeqqVM+u0g==
X-Received: by 2002:a05:6a00:1994:b0:7aa:93d5:822c with SMTP id d2e1a72fcca58-7c58e605aa1mr20761385b3a.23.1764247594102;
        Thu, 27 Nov 2025 04:46:34 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150b66c67sm1951332b3a.13.2025.11.27.04.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 04:46:33 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v6 0/2] PCI: Add support for PCIe WAKE# interrupt
Date: Thu, 27 Nov 2025 18:15:41 +0530
Message-Id: <20251127-wakeirq_support-v6-0-60f581f94205@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVHKGkC/2WNwQ6CMBBEf4Xs2ZK2acF48j8MMbUuslEodAE1h
 H+3knjyMsmbZN4swBgJGQ7ZAhFnYgpdgmKXgW9cd0NB18SgpbZKSSOe7o4UhzNPfR/iKGprvLk
 4p/beQlr1EWt6bcZTlbghHkN8bwez/bY/V/nnmq2QwhQGVVlrr6U/BuZ8mNzDh7bNU0C1rusHc
 j4PsrUAAAA=
X-Change-ID: 20251104-wakeirq_support-f54c4baa18c5
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764247587; l=4827;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=miFInMvn53m82x7l9rTHmWzPJOBbC4ekTp1q47Dn4KM=;
 b=XYY+XN0gfR9w01lMNENJrT3EsEi89OMO2DjFZYWFqszRGhCIqm/PYxYYN1N5zjtPkEDhJ08H2
 TVHMJ/ZOYefAWW69KLHSySnIqNrR5NILzxFyfnYr1tDL8vAwuCoq2CN
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: eQlY4Ogr02yu0FHIOKeRIPpHQuj_goNW
X-Authority-Analysis: v=2.4 cv=AufjHe9P c=1 sm=1 tr=0 ts=6928482b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ikd4Dj_1AAAA:8
 a=s8YR1HE3AAAA:8 a=Ly1ae7BopFzPCSorSWkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: eQlY4Ogr02yu0FHIOKeRIPpHQuj_goNW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA5NCBTYWx0ZWRfX016sIDxEjY1H
 f83FCP9yXwMO+We5wfXStCsds9GFcdr/VlA4cvkMOv5mMAGowaqrsISF0720Ib7g327zl8o+7VR
 qUtYEShrQKYLHTL27VOrGdvjBQw/aLsHJsv7ln0DTsSyE11XHr6XuPY3AtiMqgh7VDFYD1yp3ti
 tFLxUCH+T79G6Cu7wbM/+Jlh/NSA63ErHteXbdspDnIei8YvSplWRP7FWBvZH3SS20IhjRDzxpK
 +ubnaHo6FfCzpZErkpuk2EX/TxpcPQQ+LhjTVje5l7V9UrUfNWroWTUh7dnmIM1+ttDyZWV82Zt
 inzoBOC9FgCvCZMKwYz1TgloBID1fbOLRJfcEUSgw7C/854KS7AdcCi9xIgzEqVAneaXVzwwNjL
 LwqXiLUkPUAkW07/DSMcdFA6o41C4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270094

PCIe WAKE# interrupt is needed for bringing back PCIe device state from
D3cold to D0.

This is pending from long time, there was two attempts done previously to
add WAKE# support[1], [2]. Those series tried to add support for legacy
interrupts along with WAKE#. Legacy interrupts are already available in
the latest kernel and we can ignore them. For the wake IRQ the series is
trying to use interrupts property define in the device tree.

This series is using gpio property instead of interrupts, from
gpio desc driver will allocate the dedicate IRQ.

According to the PCIe specification 6, sec 5.3.3.2, there are two defined
wakeup mechanisms: Beacon and WAKE# for the Link wakeup mechanisms to
provide a means of signaling the platform to re-establish power and
reference clocks to the components within its domain. Beacon is a hardware
mechanism invisible to software (PCIe r7.0, sec 4.2.7.8.1). Adding WAKE#
support in PCI framework.

According to the PCIe specification, multiple WAKE# signals can exist in
a system. In configurations involving a PCIe switch, each downstream port
(DSP) of the switch may be connected to a separate WAKE# line, allowing
each endpoint to signal WAKE# independently. To support this, the WAKE#
should be described in the device tree node of the endpint/bridge. If all
endpoints share a single WAKE# line, then WAKE# should be defined in the
each node.

To support legacy devicetree in direct attach case, driver will search
in root port node for WAKE# if the driver doesn't find in the endpoint
node.

In pci_device_add(), PCI framework will search for the WAKE# in its node,
If not found, it searches in its upstream port only if upstream port is
root port to support legacy bindings. Once found, register for the wake IRQ
in shared mode, as the WAKE# may be shared among multiple endpoints.

When the IRQ is asserted, the handle_threaded_wake_irq() handler triggers
a pm_runtime_resume(). The PM framework ensures that the parent device is
resumed before the child i.e controller driver which can bring back device
state to D0.

WAKE# is added in dts schema and merged based on this patch.
https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/

[1]: https://lore.kernel.org/all/b2b91240-95fe-145d-502c-d52225497a34@nvidia.com/T/
[2]: https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-chips.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v6:
- Change the name to dev_pm_set_dedicated_shared_wake_irq() and make the
  changes pointed by (Rafael). 
- Link to v5: https://lore.kernel.org/r/20251107-wakeirq_support-v5-0-464e17f2c20c@oss.qualcomm.com

Changes in v5:
- Enable WAKE# irq only when there is wake -gpios defined in its device
  tree node (Bjorn).
- For legacy bindings for direct atach check in root port if we haven't
  find the wake in the endpoint node.
- Instead of hooking wake in driver bound case, do it in the framework
  irrespective of the driver state (Bjorn).
- Link to v4: https://lore.kernel.org/r/20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com

Changes in v4:
- Move wake from portdrv to core framework to endpoint (Bjorn).
- Added support for multiple WAKE# case (Bjorn). But traverse from
  endpoint upstream port to root port till you get WAKE#. And use
  IRQF_SHARED flag for requesting interrupts.
- Link to v3: https://lore.kernel.org/r/20250605-wake_irq_support-v3-0-7ba56dc909a5@oss.qualcomm.com

Changes in v3:
- Update the commit messages, function names etc as suggested by Mani.
- return wake_irq if returns error (Neil).
- Link to v2: https://lore.kernel.org/r/20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com

Changes in v2:
- Move the wake irq teardown after pcie_port_device_remove
  and move of_pci_setup_wake_irq before pcie_link_rcec (Lukas)
- teardown wake irq in shutdown also.
- Link to v1: https://lore.kernel.org/r/20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com

---
Krishna Chaitanya Chundru (2):
      PM: sleep: wakeirq: Add support for dedicated shared wake IRQ setup
      PCI: Add support for PCIe WAKE# interrupt

 drivers/base/power/wakeirq.c | 39 +++++++++++++++++++++++++----
 drivers/pci/of.c             | 58 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h            |  6 +++++
 drivers/pci/probe.c          |  2 ++
 drivers/pci/remove.c         |  1 +
 include/linux/pci.h          |  2 ++
 include/linux/pm_wakeirq.h   |  6 +++++
 7 files changed, 109 insertions(+), 5 deletions(-)
---
base-commit: f04a8f2f1f04a77e65d96f5ee146957522002900
change-id: 20251104-wakeirq_support-f54c4baa18c5

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


