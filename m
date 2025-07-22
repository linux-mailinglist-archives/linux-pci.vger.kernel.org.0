Return-Path: <linux-pci+bounces-32706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA9B0D576
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1E1189E8C9
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 09:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786812DECB1;
	Tue, 22 Jul 2025 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h66mzq9E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F52DEA7C;
	Tue, 22 Jul 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175535; cv=none; b=Ow2XPTMK+aBLWjX2XyQrKb66A0bKMC67K7qEB1FulAiWxN0AYwkPv1H09PD9fah5SIAVwyAitCKCAt3uGJ2E79KxQJi8eRO01O5B5bd/XG3RhLuMGxehX9ZUl2e5DJhNUaxw7eqswsGZlc/DpedlQWhWNLdKwWklVS7udj/pTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175535; c=relaxed/simple;
	bh=VNhPpP9nTZfwcQe50UFfEyJWIJvl18Kke8oJpcNQVy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZ/zpaz4k7yGlFPVkQ/MkTbDRFJK8kZgaousnWZyqd+QEl9ZlzYqeRN9Ew0/XTbnKaSX75PGIovasrBh+IM8SWSkfYdZFlh+f3GGhpGw08kyKcrJsckkVvSNY4cidmKQ2BFGUomMhfKAw7rhHYICozffJqwvLm2HZ6sJ5dR9Ko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h66mzq9E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M83bY0010113;
	Tue, 22 Jul 2025 09:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+zQNPUwt9X9
	/JA4U4uF8w68hR2+/013zgDHQgB4OXDU=; b=h66mzq9E/YNFnClTfP0UIN/6etJ
	c89d5PIeL+ZoKK5D/cY4cSOG7JbL+P8NRjzIfaoHuDTUzMlL20qUmjH1LMKVouME
	1ZZrBc6fGe0xbSxymQ0OdP5H7BaeuJWHNkXRncmmYFYBQLq/7dF5GDY4OFEuXkxn
	+uanrCIhvkBhXX65LLbcDUtYd66W7RCkM9M3vQOmL2rbpkxi0EiRJLi7wj0bX1zT
	wdY7TAeQYPWfUmIhG7vJcSi1IdcBAthMF+ack9VGAHHBGsU38nD4QG0fiFmplzTH
	0dIgXcXGUMKml+EyTaDhlRJlWHmIh52phf9KqW7vJugLgSzwJX+T2merH1w==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1879b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:12:02 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56M9BxLc003098;
	Tue, 22 Jul 2025 09:11:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4804em6q26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:11:59 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56M9BxDX003092;
	Tue, 22 Jul 2025 09:11:59 GMT
Received: from cbsp-sh-gv.ap.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 56M9BxfF003090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:11:59 +0000
Received: by cbsp-sh-gv.ap.qualcomm.com (Postfix, from userid 4635958)
	id 6094240D28; Tue, 22 Jul 2025 17:11:58 +0800 (CST)
From: Wenbin Yao <quic_wenbyao@quicinc.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        robh@kernel.org, bhelgaas@google.com, sfr@canb.auug.org.au,
        qiang.yu@oss.qualcomm.com, quic_wenbyao@quicinc.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: krishna.chundru@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com, quic_cang@quicinc.com
Subject: [PATCH v5 1/3] PCI: dwc: enable PCI Power Control Slot driver for QCOM
Date: Tue, 22 Jul 2025 17:11:49 +0800
Message-Id: <20250722091151.1423332-2-quic_wenbyao@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
References: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5D46GenhVRAHMCI0zVlwKsj-njJwf1Mn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA3MyBTYWx0ZWRfX7TNh/q8+UWda
 7kyOSX2KUL7HSgQLp0o6ig/Qu6r/Xir6xWoJCCa/AA/Lu38Vm1CjzKnxUDBfM2gCUnTOMlYm8ZU
 50J+7GvhFrIGU6YwffU9KlK9MxXifn/+5KymiFfmrMGfvcHT6IToVgEtwygt92dWbrMqxnfp1pG
 RXdat5ndUv3i7n6cb8ZfkR6zXQ/JdTUQzdfOW6ZHhJ1wuyQ3iYeiLWCa+VGF6yyRKUi/mgUtJob
 gXSo7c/4VLfkk5lWXfiEe04xbkA2iBAl8tDbBDEcu6w1ugkaW1s24zmsjJeYBa3fNaQ5VGrUN5K
 XWoQ2H/poLKqIoWHfxDw2pgHM5K0jISlQgKnn8ko48h05JJIxOaud0DUvj2bf4sD56Tblz19hGy
 WueozI/91oNC+LEN7Hy6po7vnUo/kLDe5sIg7kcZd0ELJOpQwJ4+m4Di/ASUagFtDTvGzf3f
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=687f55e2 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=Ss6HhLVMW9w6KV1y8EMA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5D46GenhVRAHMCI0zVlwKsj-njJwf1Mn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1011 phishscore=0
 mlxlogscore=738 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220073

From: Qiang Yu <qiang.yu@oss.qualcomm.com>

Enable the pwrctrl driver, which is utilized to manage the power supplies
of the devices connected to the PCI slots. This ensures that the voltage
rails of the standard PCI slots on some platforms eg. X1E80100-QCP can be
correctly turned on/off if they are described under PCIe port device tree
node.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ff6b6d9e1..deafc512b 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -298,6 +298,7 @@ config PCIE_QCOM
 	select CRC8
 	select PCIE_QCOM_COMMON
 	select PCI_HOST_COMMON
+	select PCI_PWRCTRL_SLOT
 	help
 	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
 	  PCIe controller uses the DesignWare core plus Qualcomm-specific
-- 
2.34.1


