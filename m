Return-Path: <linux-pci+bounces-43118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B411CC491F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 18:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40CE4304D463
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959C636A03F;
	Tue, 16 Dec 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZKpNU2Gg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BNetlMAj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58797362134
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889531; cv=none; b=kCqFO/ZJNfK7lkVCc4Oc0S56QK/6lJYrq6nj5EFPJeePUaQcEWHK/HNG6mL+MSyvpPBe1JttvCOdR2Js+R4ygMkTJZ9kpxwnmKKQEOmtwPvA5XUEGwBH2cC7aoSQeUkQ32jx9Wvat96fhuwKo6oe2bGSusl++43ho+bt9NPyscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889531; c=relaxed/simple;
	bh=AxJppRgcYa8seS/5FsyKFOOD0QXwFKTptF3sj3pGcEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BviGN2xJuIbLZcJhAVxtOyoTKa5dhneyO5W24EpJ8vR77OVfAZ/kVRk3Vu/ScmhhUh0/geVoNvkRZWgcM6opQa2HuuOll/6Z6joRwwdgccBTwd5N2RL525zbeYZWLSBk1tY559g99hlOeF/YU3YfqendC272BwbnwLNs24POp14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZKpNU2Gg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BNetlMAj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGCcLdN119470
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 12:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dPioBKyHQGix4/YkwPml8E9/ulH+evd13A8ZjC482MI=; b=ZKpNU2GgQhVzPtRE
	VyJ0bs2Hopws9cMrlj2lCNHj4YzqYvE26SvEByfi7kqFoPuXV+y6/IFmgnboIUnB
	q/SFIEVLEr4ZeqcieS8iYy+LfNOb7lPKAWcVmW9/8Rdi+lfJugJC/UoeM2+94gPT
	7D5vDzuAdzMGxZflVXoRE74lYx3qu1ClcJR4rKRVCLkTkKfHcv2/Cvy2MmTygvp0
	Y0EGb0QigYvzCSFJVipH8YUMw6eNUa54LDkP1aoLUEq2gauwcav9H6g2Vpa/Bsr7
	Kxac1cJyhI9kMqal6QTURFRQDmIBGE4KemmLK/B4xbC9KY6R6CmOLCvEgda4r6ru
	eeqgtA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b33xj0yu3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 12:52:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b9321b9312so9264804b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 04:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765889523; x=1766494323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPioBKyHQGix4/YkwPml8E9/ulH+evd13A8ZjC482MI=;
        b=BNetlMAjOXETgcVFMOUrvPA43ebJRY4tmIQFByqc8MKz/5Fx0YbL4A3Oc0+0NGhyQ1
         +HiKU/NHmNYQmRtNE4M4KMMsrz1g92In66C9h+Ywq4a3KpMLwpIND1aMOZGDDbnpifDh
         ssGzHCtjBzflCbkQcZQ/hAwpREa1UYjgn2pEAwhI7ZECK+Rw/CmKYCT8VIq7hfEiDzhs
         +TtQeaXrRb4gEdSx+c8F9wjGd2lLrUuMGBS2yV83R7LGiJ07mxWNdqVem+tLBW3wOdlU
         ocHKip0dh/l3ZbutrONmyAvUoREKr1eSs/+Sq4kcB/e1U3k2EkA+ahC91kckJ7R8vqZs
         P1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765889523; x=1766494323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dPioBKyHQGix4/YkwPml8E9/ulH+evd13A8ZjC482MI=;
        b=XPfW3P7WTsw9eajMn7ad0WF4aGSM64x4W0veCbqwvopdDJCIvp87Selhq8xlcwacth
         fSolX4x5Psq+JYdt2MdtM+bGsawfbGXcq9nF4oML6ArhIzC37DXWd3rfqkjninzBJ1TI
         40fY3aY7s8ZLa9PlH/ECeez8Y/NZYZYr+1RLBuGFFORNmfVZ0IGW4wbjbU/CPTOIFjVe
         S/HBA+eKFbx+JkkbUpKx+XH8l+FcjsDz1Gk9eNEyePy++W9Pr/UPIfEJih7ZUgcG/b8o
         eqUtT3rHDjGHRYgh7nZMONMLYtYynL8CDaFAengzgKhtXC3ZCE50qM8meyp46Fnx8L4A
         ySjg==
X-Gm-Message-State: AOJu0Yw7qz9D87clipAfs0fhIM86Yosy+zthO9LJO7UdlzDkhUhEnu7z
	mSuIbc78K4TPOFKbIdtfsPDr0PH8Lv8MnktNFLA4pl9n7JAF5PPO2zSHaU+1j7FK56tISALgGq+
	QLTkXHaqWcgA5CW/jifGMd9lvu5ZWxw5VgCtGtM6X5aKwgzn/hQEoRDdCL0OwDwI=
X-Gm-Gg: AY/fxX7NpCteKl2D+lwAKrcJ46PDGF8UDirW1W1W13Rh8O+5O078DYEuPT6HTOglJKT
	q6YqIGEkxGjYKziQP38tENZPpR2CK0ra32SaDHP4ytXpY1rJkyq8/tI6GzYdEP9PXjqHDFq6osh
	HgbGn8A5xgv/sYFDmP+YzHLZj8gTX31Innv4EOiIE3mvFbDe1M/cV5v7b7SLmq2L9BAwlBbnpRG
	oJ3p/Wa4q2x6XlU2HiEXIPgYZF/204nLRc7Wjp6Spf643pXW7ZWUb0XihIdhvBS8Cs7vDtqZp3Z
	5rGinlmPAOiwbAf+g3RiYWRgM4o/xN8X0j2I6ZwnMDMW3qdtHb+4Zinfp/m2YLvvS8mqD/0z0Xd
	+UcyHITi7Iv1VZVmdZNc87a0jUSi7hHJburlW6NBHAg==
X-Received: by 2002:a05:6a00:6ca1:b0:7a2:6b48:5359 with SMTP id d2e1a72fcca58-7f6679368f6mr14489950b3a.24.1765889523111;
        Tue, 16 Dec 2025 04:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPl3d2KGIwILstUtASrOvLk2LZLE7T3dGcnoLQpDR2FH5CrqA1YrdJ4MrgZdloc/MaQQoM9A==
X-Received: by 2002:a05:6a00:6ca1:b0:7a2:6b48:5359 with SMTP id d2e1a72fcca58-7f6679368f6mr14489922b3a.24.1765889522561;
        Tue, 16 Dec 2025 04:52:02 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f5ab7d87e8sm13634362b3a.25.2025.12.16.04.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:52:02 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 18:21:43 +0530
Subject: [PATCH v2 1/5] PCI: qcom: Parse PERST# from all PCIe bridge nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-pci-pwrctrl-rework-v2-1-745a563b9be6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7502;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=AxJppRgcYa8seS/5FsyKFOOD0QXwFKTptF3sj3pGcEs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpQVXoQKinTJXtBmgeKHf4UWzgeJqWHOAIYLFSR
 fFrXeGG9SuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaUFV6AAKCRBVnxHm/pHO
 9S0iCACSdGQz8geJOBd+d9udFswEfStON+sBAnT6wzMEECy6Kx+Rppz/rDrJPKnGd6WwR6Uc+YP
 WwUAdjI5aP24oqU5to62e1QRLJUZNLw09b00qEqoflK+erOs1c08/cVLB/pRRAAHktO+RBDsVTe
 1uTBLgY0SyATW4UlZSBcxQBUtTPdC12BslroOCVnfaRYyWeeZmHqYVNq/s6VcTrKI41tKScaH1T
 PMio5rP/1PWrHzOSXXXaYLjlFzcTBzUkfZkuyfU9BUbMtOcs4vqrojL95bRWLEdzMEZfNBHn2Cd
 W7Y31pKSo9KpFO2YPEhA/4NjEibNLtCrXxqFcxbcBfnxgTgS
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-ORIG-GUID: bjW6Cj-DPXPhyXgDpT0Bo87KAvaJYoa4
X-Proofpoint-GUID: bjW6Cj-DPXPhyXgDpT0Bo87KAvaJYoa4
X-Authority-Analysis: v=2.4 cv=KtNAGGWN c=1 sm=1 tr=0 ts=694155f4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=wnJ2AIBC+6MZbTdryK78rQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8
 a=xvucdaCnflZx_vE3ezEA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwOSBTYWx0ZWRfXzlnhfvW/myCP
 mAtxe6ieU6xJomacXHtMGIfz5utu6lv6HImYQRkQ/XNIQhnEBUQlNYFE42C+9z9LI82i3MxiBpl
 nZnKJO1yaMAQYpKloD6/adXiMpaJJNkgnF/mPAyrbzaKtrA22oVfuBEouTf+Y+DWQ+QphyjCl6v
 Z92BklWkdNvqMnNl8y83TEdwYoJ2TWB3geMi8KLm2ERV2EVbdeUeA+l7RIKewmT8k6dmi7Il6eA
 eZLXXxh9gK4Dgnjl+Pg+jnYeUgsr9C9BBJVpJV17t/ATTbOTtSRLo1GHHziDamxSaScB3dmR43E
 mp8Dgg2LxxHX1FM7MAoQPdblTiULrZ+DYZNrhqFqJ96UrUBOg+qhQ2GxudfT0WDjAELj7cOBArL
 CyMIsAqBm0EwM5E+fATb+Yhuv28olA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160109

Devicetree schema allows the PERST# GPIO to be present in all PCIe bridge
nodes, not just in Root Port node. But the current logic parses PERST# only
from the Root Port nodes. Though it is not causing any issue on the current
platforms, the upcoming platforms will have PERST# in PCIe switch
downstream ports also. So this requires parsing all the PCIe bridge nodes
for the PERST# GPIO.

Hence, rework the parsing logic to extend to all PCIe bridge nodes starting
from the Root Port node. If the 'reset-gpios' property is found for a PCI
bridge node, the GPIO descriptor will be stored in qcom_pcie_perst::desc
and added to the qcom_pcie_port::perst list.

It should be noted that if more than one bridge node has the same GPIO for
PERST# (shared PERST#), the driver will error out. This is due to the
limitation in the GPIOLIB subsystem that allows only exclusive (non-shared)
access to GPIOs from consumers. But this is soon going to get fixed. Once
that happens, it will get incorporated in this driver.

So for now, PERST# sharing is not supported.

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 102 +++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7b92e7a1c0d9..73032449d289 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -267,10 +267,15 @@ struct qcom_pcie_cfg {
 	bool no_l0s;
 };
 
+struct qcom_pcie_perst {
+	struct list_head list;
+	struct gpio_desc *desc;
+};
+
 struct qcom_pcie_port {
 	struct list_head list;
-	struct gpio_desc *reset;
 	struct phy *phy;
+	struct list_head perst;
 };
 
 struct qcom_pcie {
@@ -291,11 +296,14 @@ struct qcom_pcie {
 
 static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
 {
+	struct qcom_pcie_perst *perst;
 	struct qcom_pcie_port *port;
 	int val = assert ? 1 : 0;
 
-	list_for_each_entry(port, &pcie->ports, list)
-		gpiod_set_value_cansleep(port->reset, val);
+	list_for_each_entry(port, &pcie->ports, list) {
+		list_for_each_entry(perst, &port->perst, list)
+			gpiod_set_value_cansleep(perst->desc, val);
+	}
 
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
@@ -1702,18 +1710,58 @@ static const struct pci_ecam_ops pci_qcom_ecam_ops = {
 	}
 };
 
-static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
+/* Parse PERST# from all nodes in depth first manner starting from @np */
+static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
+				 struct qcom_pcie_port *port,
+				 struct device_node *np)
 {
 	struct device *dev = pcie->pci->dev;
-	struct qcom_pcie_port *port;
+	struct qcom_pcie_perst *perst;
 	struct gpio_desc *reset;
-	struct phy *phy;
 	int ret;
 
-	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
-				      "reset", GPIOD_OUT_HIGH, "PERST#");
-	if (IS_ERR(reset))
+	if (!of_find_property(np, "reset-gpios", NULL))
+		goto parse_child_node;
+
+	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset",
+				      GPIOD_OUT_HIGH, "PERST#");
+	if (IS_ERR(reset)) {
+		/*
+		 * FIXME: GPIOLIB currently supports exclusive GPIO access only.
+		 * Non exclusive access is broken. But shared PERST# requires
+		 * non-exclusive access. So once GPIOLIB properly supports it,
+		 * implement it here.
+		 */
+		if (PTR_ERR(reset) == -EBUSY)
+			dev_err(dev, "Shared PERST# is not supported\n");
+
 		return PTR_ERR(reset);
+	}
+
+	perst = devm_kzalloc(dev, sizeof(*perst), GFP_KERNEL);
+	if (!perst)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&perst->list);
+	perst->desc = reset;
+	list_add_tail(&perst->list, &port->perst);
+
+parse_child_node:
+	for_each_available_child_of_node_scoped(np, child) {
+		ret = qcom_pcie_parse_perst(pcie, port, child);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
+{
+	struct device *dev = pcie->pci->dev;
+	struct qcom_pcie_port *port;
+	struct phy *phy;
+	int ret;
 
 	phy = devm_of_phy_get(dev, node, NULL);
 	if (IS_ERR(phy))
@@ -1727,7 +1775,12 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 	if (ret)
 		return ret;
 
-	port->reset = reset;
+	INIT_LIST_HEAD(&port->perst);
+
+	ret = qcom_pcie_parse_perst(pcie, port, node);
+	if (ret)
+		return ret;
+
 	port->phy = phy;
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);
@@ -1737,9 +1790,10 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 
 static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 {
+	struct qcom_pcie_perst *perst, *tmp_perst;
+	struct qcom_pcie_port *port, *tmp_port;
 	struct device *dev = pcie->pci->dev;
-	struct qcom_pcie_port *port, *tmp;
-	int ret = -ENOENT;
+	int ret = -ENODEV;
 
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		if (!of_node_is_type(of_port, "pci"))
@@ -1752,7 +1806,9 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 	return ret;
 
 err_port_del:
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+	list_for_each_entry_safe(port, tmp_port, &pcie->ports, list) {
+		list_for_each_entry_safe(perst, tmp_perst, &port->perst, list)
+			list_del(&perst->list);
 		phy_exit(port->phy);
 		list_del(&port->list);
 	}
@@ -1763,6 +1819,7 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 {
 	struct device *dev = pcie->pci->dev;
+	struct qcom_pcie_perst *perst;
 	struct qcom_pcie_port *port;
 	struct gpio_desc *reset;
 	struct phy *phy;
@@ -1784,19 +1841,28 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	if (!port)
 		return -ENOMEM;
 
-	port->reset = reset;
+	perst = devm_kzalloc(dev, sizeof(*perst), GFP_KERNEL);
+	if (!perst)
+		return -ENOMEM;
+
 	port->phy = phy;
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);
 
+	perst->desc = reset;
+	INIT_LIST_HEAD(&port->perst);
+	INIT_LIST_HEAD(&perst->list);
+	list_add_tail(&perst->list, &port->perst);
+
 	return 0;
 }
 
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
+	struct qcom_pcie_perst *perst, *tmp_perst;
+	struct qcom_pcie_port *port, *tmp_port;
 	const struct qcom_pcie_cfg *pcie_cfg;
 	unsigned long max_freq = ULONG_MAX;
-	struct qcom_pcie_port *port, *tmp;
 	struct device *dev = &pdev->dev;
 	struct dev_pm_opp *opp;
 	struct qcom_pcie *pcie;
@@ -1937,7 +2003,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	ret = qcom_pcie_parse_ports(pcie);
 	if (ret) {
-		if (ret != -ENOENT) {
+		if (ret != -ENODEV) {
 			dev_err_probe(pci->dev, ret,
 				      "Failed to parse Root Port: %d\n", ret);
 			goto err_pm_runtime_put;
@@ -1996,7 +2062,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 err_host_deinit:
 	dw_pcie_host_deinit(pp);
 err_phy_exit:
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+	list_for_each_entry_safe(port, tmp_port, &pcie->ports, list) {
+		list_for_each_entry_safe(perst, tmp_perst, &port->perst, list)
+			list_del(&perst->list);
 		phy_exit(port->phy);
 		list_del(&port->list);
 	}

-- 
2.48.1


