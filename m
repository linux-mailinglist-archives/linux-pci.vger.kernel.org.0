Return-Path: <linux-pci+bounces-43120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E4BCC48EF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 18:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02215300DB8E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A088737D549;
	Tue, 16 Dec 2025 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ob/rS13G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YnKHilH0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDAF37D528
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889536; cv=none; b=l/V0Q7lUI2/+EWYDrfhNBql2uBAT2ELsZ9L9El1Eq++Zob+CZTU0fmvisF39NkCXTqQ0mDB1q5klbbK/ToYNVBO6w0LVJx4ZBFsEGh7j0hm4q2y07BJxgQkbq/5+Pqsrn7rk1bU2taympaiDN1BxJEEko9dagUk88Do7mvV22y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889536; c=relaxed/simple;
	bh=Euy9ek4QLZuPFAnOhsN9KCwtXXEQaqYZLJTxTZGnA4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pDg2Pux6aO/+2KSTQvrdCA26Jay1M3FqQw3CPZPxuy4Zc0mccOxyhCkRFGjeLa+L1i5g1TxYRP8uwQ8XGTD+ZCfXReZBCAEYPr5uFc1bTdvfbcj8LHWioEZnR3tuql6gXhcZNFL03L5fSzSRElYyvl78QIXfH5uEqKeR2vBHc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ob/rS13G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YnKHilH0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGC7FqH3708522
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 12:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zuGyltVA6H6nPxZKnvtWx6VprlmZukvoZn9Yp/vgZHc=; b=Ob/rS13GoqBVbFYD
	wdp16VmrANKoEioP7jAoGTbpTssK3gfNXbMQHbwIDAariPSyvMKR8A1tkcaijm+v
	9SvjeoNs4areadaC7oek210kWh9F4d8ZiFJoYi2VSEk61P2DJSyWQu7u910Q1cNN
	Py8GEt5oafpqYVwZqQ8sSAAtXPKmaYcYVgfdmzLja4fKbo2aUVOEYF6DvmUteqRz
	AuuAUmK0AXAyQgSM/pU3Nkf1Ny2NICe4o6McOe7S7qSKxTSPdngPn/SzProEOMNE
	bRaY+edvbKDspq9Rokb1KYS/zAoHhK03D3BhlO0mDHI6ox4TpM5iudQTiIwXdDic
	rx2VaA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b375b05gu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 12:52:14 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7f046e16d50so7237745b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 04:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765889533; x=1766494333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuGyltVA6H6nPxZKnvtWx6VprlmZukvoZn9Yp/vgZHc=;
        b=YnKHilH0gkmKjPHztZcibOTBe7bxBgT+KMaep4gh9uzEpOB3eqHXlFUKuIV1JOt/Bz
         eWSdam2mY0YTb6d+NSOvIOWRaI9tqojXIKl7Ir/tQWKlrbXYVjAOSptvL/OaFr2mZh8C
         Gg0x2DB3mc78oWWQfZYZaoESIv7vH5U4+B15c2fC1NSeddzeCqOz8uhj5FIWsAvEJ2ys
         zwzvmOJF6nPJx6jLANz45/4yOV69xfVNkhNhpb80gxg+M8FwW2c+2Tz4GjFiLyjUjdqL
         oXI+ktF9PvgN3zjxk7UBdyOS9QiQCO/wgDw8Mv7TQWe0PgEEDRdAowZMdexHdccHV1cD
         d20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765889533; x=1766494333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zuGyltVA6H6nPxZKnvtWx6VprlmZukvoZn9Yp/vgZHc=;
        b=WyVFoojf2FV3Ndv/NypYoUIzOe1SB2JF4fnFZAsE+5HYMZsaa7IKiv98pNXGCMhHD5
         HLUjqtopYX6x5aAMwO7ikCz/6t1e3jKbEoB07W+qyJdz99lbAfOTYukB6k16rDk0F8nK
         uByG6CyVCbVGc15bNKtatxai5sbAvQTSkHqTvx9lyCbX/NwdoMvYM6dXFRV/3rQ2sjFe
         2Y0vv5meXeTRWB+So9getcaWidgMjLvMZsC1CF6ZFhHOLUpkWCU/Of1QB3oaFsy9242f
         Sm0k1DRVCJRktZBPr3QWIbz9HHCR3ZUubfxYiGx76HHWGC/EKGs+eDlsFW2btFqMCVPr
         fRuQ==
X-Gm-Message-State: AOJu0Yxd/I1cm5C0KNjpGwze7zsX+ZTXUVWkaeKjC0ZA9wD9lmGNA9Um
	f0GnR8dBUd49XcfK5kKu8+tc2/gOuc6fsLrEk7h1Dun6oAvJcr6ZyGI3UVOfktcyVScP5zYEiQo
	eo+vsGoXs/PbsfFT0gliOffJWPGNC4l7FAfmoi4HyplIJfUkjzVXv+H+QfBT9DF4=
X-Gm-Gg: AY/fxX7CYkqNslXX0sdyrfDIeKTxpXWdMqqDaKoiKz58yy4Aul4n97bb0fpRXbwEfXv
	/BSCvjWY6b8gdU5Cu/YgBoqsQ/rSDF6OowCoiwCN7wOuXr2kNmvWdLAhv/grq+YrRzp9czhWk/l
	/yFReWH2MDwBB6BBt/DTc6jnvwspYZACoF7xndoMdTKuuU8sOj5wHPL5Ry/XB4Y5BVYn3KTjLh1
	4mKQCBj2xaLcxll9c1K7oocyfCy4whPtRW7M1xcAVHoR6B9bs1JoDahOACdER6xMmYcKomdNS8w
	5vtyqIj8DXlqhDcfd8b9FsP39eJu477oTx/acDEBDV3kd8/Ar2AnfdZrPtRMyJ+7Trt7t1Eq02D
	pysNP0EYIgbDTYqBe1gqzeD2TpQm3307lSNz6lTm3hw==
X-Received: by 2002:a05:6a00:400c:b0:78c:994a:fc87 with SMTP id d2e1a72fcca58-7f66792ecf8mr12198567b3a.6.1765889533273;
        Tue, 16 Dec 2025 04:52:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbzWWEuXvy3Bb0GZybRlU1R9lBHtqRfDs1n7sfrT91bknh/oRbvNgSVQ+89tPZ8Sywl1O1lg==
X-Received: by 2002:a05:6a00:400c:b0:78c:994a:fc87 with SMTP id d2e1a72fcca58-7f66792ecf8mr12198546b3a.6.1765889532741;
        Tue, 16 Dec 2025 04:52:12 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f5ab7d87e8sm13634362b3a.25.2025.12.16.04.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:52:12 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 18:21:45 +0530
Subject: [PATCH v2 3/5] PCI/pwrctrl: Add APIs for explicitly creating and
 destroying pwrctrl devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-pci-pwrctrl-rework-v2-3-745a563b9be6@oss.qualcomm.com>
References: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
In-Reply-To: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Chen-Yu Tsai <wenst@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7336;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=RVCEpUIHxSA8U7uEnCgFGs1zmOAMqmbSgGgoPH/vJ+s=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpQVXowa0/qVQmVD9ttth18ch8HEhPBicNLp/6r
 q/fznDA/S+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaUFV6AAKCRBVnxHm/pHO
 9W8AB/0dVPIqtUNItBuVnF70kFtvmucI+rTyuRPKA/kU9qN5BmXs9CHfiGMJwFpiSNYXOuRMOW9
 N/g+Lhsh44uC/DlEhqrzCjG1/25isbTdJg2Vsc+5uetfq9EplOJIkH6QmIdvz1Y304a92mqpwic
 +CbYb3q8F9JTwSX0XF5gzTgNK2HgtE+dkfDXO189vCbSosz8Rn1wx4XCDi9LtL9sYZ0cV5jI9vv
 SJIqyAZ/daKt7sbwzKOSt3tFkuBhoUnG0OSpzhZaneXI7bfkq4vFTpGHi18Sd/VvBKAE5wRmMap
 CHtAhWlOO30Lk4xYkjsbFoizqJYIqzHnNeqI1Cl66yFGza7S
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwOSBTYWx0ZWRfX7YIUPdOTZ5Ec
 HMCySJRCUnuj52e5TuxjRSl+PMbStpqFVgz8DeFzV5jlP1uKtcsgWW3oqGcHFWv6EkXQWSZzcWK
 hh1br9Oflo7JqeIh3OQ7Kabj3oGiaHwWMg7g/c96Rf7EXaFKXZS82JkNz5xMqTgFlgiFr4Di6rm
 6QtqVw6uO7WfUEFPvBiOpklVGVtlYMx9VOM0LAL6wjzwfzPnSprdVsRYM820cwkn2xVgkiY2X1s
 eDtI6QcaCCj7T0iCHgUqsTVRZJJbZXVlLvmbEuNNk+9u/fjmAhjS1O+CMpPnjzAkq5bIMsYXzZ/
 qnYYDXaaShteqTxNK5zDQJRHn8/N1HpjxyeZLkTFxyD2GpVYgnqeJeVMlkbsicKeEsJMsG9odXa
 Odu0J9Pr/yWdXIT4c54C0NGqfN+E9w==
X-Proofpoint-GUID: yHVsZF3SM3KicfKN4f8nmJkVolsk-P1n
X-Proofpoint-ORIG-GUID: yHVsZF3SM3KicfKN4f8nmJkVolsk-P1n
X-Authority-Analysis: v=2.4 cv=T9qBjvKQ c=1 sm=1 tr=0 ts=694155fe cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=wnJ2AIBC+6MZbTdryK78rQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=KKAkSRfTAAAA:8
 a=I2O-u4IYt9Uj2DONGs4A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160109

From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Previously, the PCI core created pwrctrl devices during pci_scan_device()
on its own and then skipped enumeration of those devices, hoping the
pwrctrl driver would power them on and trigger a bus rescan.

This approach works for endpoint devices directly connected to Root Ports,
but it fails for PCIe switches acting as bus extenders. When the switch
requires pwrctrl support, and the pwrctrl driver is not available during
the pwrctrl device creation, it's enumeration will be skipped during the
initial PCI bus scan.

This premature scan leads the PCI core to allocate resources (bridge
windows, bus numbers) for the upstream bridge based on available downstream
buses at scan time. For non-hotplug capable bridges, PCI core typically
allocates resources based on the number of buses available during the
initial bus scan, which happens to be just one if the switch is not powered
on and enumerated at that time. When the switch gets enumerated later on,
it will fail due to the lack of upstream resources.

As a result, a PCIe switch powered on by the pwrctrl driver cannot be
reliably enumerated currently. Either the switch has to be enabled in the
bootloader or the switch pwrctrl driver has to be loaded during the pwrctrl
device creation time to workaround these issues.

This commit introduces new APIs to explicitly create and destroy pwrctrl
devices from controller drivers by recursively scanning the PCI child nodes
of the controller. These APIs allow creating pwrctrl devices based on the
original criteria and are intended to be called during controller probe and
removal.

These APIs, together with the upcoming APIs for power on/off will allow the
controller drivers to power on all the devices before starting the initial
bus scan, thereby solving the resource allocation issue.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
[mani: splitted the patch, cleaned up the code, and rewrote description]
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/of.c            |   1 +
 drivers/pci/pwrctrl/core.c  | 112 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-pwrctrl.h |   8 +++-
 3 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..9bb5f258759b 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -867,6 +867,7 @@ bool of_pci_supply_present(struct device_node *np)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(of_pci_supply_present);
 
 #endif /* CONFIG_PCI */
 
diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 6bdbfed584d6..6eca54e0d540 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -3,14 +3,21 @@
  * Copyright (C) 2024 Linaro Ltd.
  */
 
+#define dev_fmt(fmt) "Pwrctrl: " fmt
+
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/pci-pwrctrl.h>
+#include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
+#include "../pci.h"
+
 static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 			      void *data)
 {
@@ -145,6 +152,111 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
 
+static int pci_pwrctrl_create_device(struct device_node *np, struct device *parent)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	for_each_available_child_of_node_scoped(np, child) {
+		ret = pci_pwrctrl_create_device(child, parent);
+		if (ret)
+			return ret;
+	}
+
+	/* Bail out if the platform device is already available for the node */
+	pdev = of_find_device_by_node(np);
+	if (pdev) {
+		put_device(&pdev->dev);
+		return 0;
+	}
+
+	/*
+	 * Sanity check to make sure that the node has the compatible property
+	 * to allow driver binding.
+	 */
+	if (!of_property_present(np, "compatible"))
+		return 0;
+
+	/*
+	 * Check whether the pwrctrl device really needs to be created or not.
+	 * This is decided based on at least one of the power supplies being
+	 * defined in the devicetree node of the device.
+	 */
+	if (!of_pci_supply_present(np)) {
+		dev_dbg(parent, "Skipping OF node: %s\n", np->name);
+		return 0;
+	}
+
+	/* Now create the pwrctrl device */
+	pdev = of_platform_device_create(np, NULL, parent);
+	if (!pdev) {
+		dev_err(parent, "Failed to create pwrctrl device for node: %s\n", np->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * pci_pwrctrl_create_devices - Create pwrctrl devices
+ *
+ * @parent: Parent PCI device for which the pwrctrl devices need to be created.
+ *
+ * This function recursively creates pwrctrl devices for the child nodes
+ * of the specified PCI parent device in a depth first manner.
+ *
+ * Returns: 0 on success, negative error number on error.
+ */
+int pci_pwrctrl_create_devices(struct device *parent)
+{
+	int ret;
+
+	for_each_available_child_of_node_scoped(parent->of_node, child) {
+		ret = pci_pwrctrl_create_device(child, parent);
+		if (ret) {
+			pci_pwrctrl_destroy_devices(parent);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_pwrctrl_create_devices);
+
+static void pci_pwrctrl_destroy_device(struct device_node *np)
+{
+	struct platform_device *pdev;
+
+	for_each_available_child_of_node_scoped(np, child)
+		pci_pwrctrl_destroy_device(child);
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return;
+
+	of_device_unregister(pdev);
+	put_device(&pdev->dev);
+
+	of_node_clear_flag(np, OF_POPULATED);
+}
+
+/**
+ * pci_pwrctrl_destroy_devices - Destroy pwrctrl devices
+ *
+ * @parent: Parent PCI device for which the pwrctrl devices need to be destroyed.
+ *
+ * This function recursively destroys pwrctrl devices for the child nodes
+ * of the specified PCI parent device in a depth first manner.
+ */
+void pci_pwrctrl_destroy_devices(struct device *parent)
+{
+	struct device_node *np = parent->of_node;
+
+	for_each_available_child_of_node_scoped(np, child)
+		pci_pwrctrl_destroy_device(child);
+}
+EXPORT_SYMBOL_GPL(pci_pwrctrl_destroy_devices);
+
 MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
 MODULE_DESCRIPTION("PCI Device Power Control core driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
index bd0ee9998125..5590ffec0bea 100644
--- a/include/linux/pci-pwrctrl.h
+++ b/include/linux/pci-pwrctrl.h
@@ -54,5 +54,11 @@ int pci_pwrctrl_device_set_ready(struct pci_pwrctrl *pwrctrl);
 void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl);
 int devm_pci_pwrctrl_device_set_ready(struct device *dev,
 				     struct pci_pwrctrl *pwrctrl);
-
+#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
+int pci_pwrctrl_create_devices(struct device *parent);
+void pci_pwrctrl_destroy_devices(struct device *parent);
+#else
+static inline int pci_pwrctrl_create_devices(struct device *parent) { return 0; }
+static void pci_pwrctrl_destroy_devices(struct device *parent) { }
+#endif
 #endif /* __PCI_PWRCTRL_H__ */

-- 
2.48.1


