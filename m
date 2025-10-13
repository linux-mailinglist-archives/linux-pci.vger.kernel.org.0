Return-Path: <linux-pci+bounces-37891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE093BD2AB7
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 12:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4345E34AAA7
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF74302154;
	Mon, 13 Oct 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdb2ehCv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC7307481
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352862; cv=none; b=jpMtSwh+CEtw1S/luzWsLBX9ibu2FUn+vFEZkBb4ujvxJrimt2fVpw6gdJTxj/JpdIPMq1LObd3wg7aFAhaiWO/+9c6uZDmdG1RI7oozlQ0ElKslkAfdo9tjmwj2Bu4xM80UDvmQhdxEB8n1P89JyWc45ChkxKCur2V1eYqC+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352862; c=relaxed/simple;
	bh=s8aliwbSN8aDBycb6R1r4K4cCFRZ355dOg0hIcHGa6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rTZ2+vH0Z3igQcEVw3Ftd2sNJNQzi9Yfv4Hkn/bh52sQAV9eGKMUKa+xQrefAW70KQsL+Socqu1APtGwoE10ItrQaj1bbItslb/hTZCC7lVyFdzjtITkT1Yt4UlHZlStB+jA5IOQM30pBRJeWuqvSo0SZeHPW05YLbU9QQtkzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdb2ehCv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D4pUtL020462
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dzqy/pPgafXyIrZ6tRmMgMR1smWL+TClMm1JmbNZJBg=; b=jdb2ehCvapwFCoKK
	TZVZmSWkpxlOqrwE5nrUK09QmyWMqisZYE+hfs8sREQhMACN4DMnwT4GAsHDma7w
	G1XB8m/oFdgInMa7P7hqpvof7CcQF8IAMcPAQqnEd3yh+dLy1ApibyzgyP8OzLN7
	PgdpAlOwTVCEe5seGngB5VOLe5XtjG5aOk83Jm8snUFw7/8Wnad93AM5/YwrGK0c
	GQYUlFcDSNuSVlr+8wGQ1btjqfaokBQtwo/8MlndNwcmGq2lJ+WZIRD7Z5oyMoYc
	Pvoh0B4EDcWGZVZckgBjvQSH84o2PRkIQ6JPWwG+QKU3ryaF/sRbuFyu6l6M5yUJ
	pzOpfQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt11xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 10:54:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55118e2d01so6607930a12.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 03:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352858; x=1760957658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzqy/pPgafXyIrZ6tRmMgMR1smWL+TClMm1JmbNZJBg=;
        b=QGmXKg8i3tyJ2KtwNpTX1z+W0lvNJNl9vE10hwIpqkgWgzKaf+1hGTcYyoW+0Y1pCY
         KR3RKy8nd0s8kmx0pztXjCFnH0Q0GoyMwvns3DJnbvgoYCKSDMqCflJmn1bjdiRbPQn/
         0zPh5+vwCeitrfmaNbtu6qSWzAqOiz2GWjHf+YhhGtvKSEQo4Iib0WIc2UHf+3AGtsdW
         Kz1ArwCgByV5/+HfsNW/WnIWVrFmVUiUT5VGzR/7wtw79riMawXAWdi81iF1zQkwj/CC
         10c0sOfkE5B6ne2sVKWOhgA5JcVOymIOX+Vb3V5ygGFtEUDBE+FrRMzlfgjlfT+i4dtH
         1Hpw==
X-Forwarded-Encrypted: i=1; AJvYcCXxwFgL3Etq/Nhtxq1TaR76DKeoa55xRSyIP48BH4PD4DxDHSGkC7mu9E8O7WXBbiXXSsAU/ZiDic4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/AvnLgroZSX6ZDmnsnlRUxAXUbIwOwRsTtDwiQqRyrM+fsK+
	bX9QbSG9C34AKiukvFARWSaqdUEh966q74FJZY3WiQglmjoB9NOOs8e30vEqAb4K2x4HH9siQ68
	QD4bvkyjUgAtsz2TG7BCeAeXURe+TZZX97tobhVDWlM/GGaA8PMGUTnmuazIdbxM=
X-Gm-Gg: ASbGncsDtu71G9VHaWuD0yz6c2bPadAlvi1DnEgnj9iRFCzp4hBW4ojQ7Hi2WLaj3va
	8v6VXsZCgiAaCFO7sZuJmDgUwKhzZfJByu7KPPEY415apaEEuIEuTrV9lhwCFEIcm4arDZCnSJX
	g98iiivUWhuKGjKzZUwrV3kcStTDBEYjcfNLgXab24JWBYDTRv6ODDYdfQnWkliX11Amfk3Jtbl
	iOJ+xwfDrjYywXpBBp9q7dc0JTbE5NVN7cQt66AhdFJTm0d8Sk5C6ho0n4VPgyQ88kigTsYfo7r
	zfWCYtmxWB9qP5stYe6O0wRI5kbDBbL6a6f2ObMl/0dqJt7k3bnh2Te8E3LU27IyomqyYxsacW8
	=
X-Received: by 2002:a05:6a20:914f:b0:2c4:c85a:7da5 with SMTP id adf61e73a8af0-32da81345e5mr29088586637.6.1760352857988;
        Mon, 13 Oct 2025 03:54:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Dc1sV8qzTg3yBNUQrWbsJJQp0QNojNq7MP48Dww6Xlvl/hVhSX+o5b9dp/M0VJWQ68tALQ==
X-Received: by 2002:a05:6a20:914f:b0:2c4:c85a:7da5 with SMTP id adf61e73a8af0-32da81345e5mr29088557637.6.1760352857498;
        Mon, 13 Oct 2025 03:54:17 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626403desm11662295a91.7.2025.10.13.03.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:54:17 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 16:23:32 +0530
Subject: [PATCH v5 5/5] PCI: qcom: Use frequency and level based OPP lookup
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-opp_pcie-v5-5-eb64db2b4bd3@oss.qualcomm.com>
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
In-Reply-To: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352825; l=2164;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=s8aliwbSN8aDBycb6R1r4K4cCFRZ355dOg0hIcHGa6Y=;
 b=a9LPyMNvzxPSP5d74h2NSW3Y7ZtnU8wBZN6ChdVmntSo234L2UuCKTBXfZNDbzGbpK6SvrjLI
 wQHRfMY25SRDQHvbRmR1981JYMJhkbcL3Omgj8+AFkHcJdOnaHfsYos
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: fb3W-8HNTrzTC2EKGepRujF9Z9iFAo8C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX/rGojz2DOyo2
 pX6sD/efd3ARoivxC6p6xM3y6Yd3W/iiaoatFzn35Od1sIyvFLU6Rgd1WY6zlsVBsLMbvZTA57A
 22aWPSL+CwSTsytrFrtnG9ppdhZjhqULkhxIXhRmgr6xcxeebA17roIxaNc1LFlNiggWbEj81kQ
 H0SA4gFdcLRqLxWXGL+D5hPj02qfnxIrVAWm/i8zXCtlIal9/8uHz4/tEuQYD7ch0+mXFe+QPWr
 wRmx5yPL4AHxOIyujQ7B4VhR6vYzde3zH3xCoXh7VkXzKcEXjDyNGHts1FPyfwajtYfycbUgU6J
 z3v3LBcVRKJxB+ZVzUAeZvxCCoZ2aaunRcRux0geKfhP1yuESd54tc39z12BT6GK4uG6WxUoUnz
 kvia4W1Zu+rJkZHyPSa1PqIxdieWew==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ecda5b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: fb3W-8HNTrzTC2EKGepRujF9Z9iFAo8C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

PCIe link configurations such as 8GT/s x2 and 16GT/s x1 may operate at
the same frequency but differ in other characteristics like RPMh votes.
The existing OPP selection based solely on frequency cannot distinguish
between such cases.

In such cases, frequency alone is insufficient to identify the correct OPP.
Use the newly introduced dev_pm_opp_find_key_exact() API to match both
frequency and level when selecting an OPP, here level indicates PCIe
data rate.

To support older device tree's where opp-level is not defined, check if
opp-level is present or not using dev_pm_opp_find_level_exact(). if
not present fallback to frequency only match.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eba496bc99ca82051dee43d240f359..03b3a1d3a40359a0c70704873b72539ffa43e722 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1565,6 +1565,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
 	u32 offset, status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
+	struct dev_pm_opp_key key;
 	unsigned long freq_kbps;
 	struct dev_pm_opp *opp;
 	int ret, freq_mbps;
@@ -1592,8 +1593,20 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			return;
 
 		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
-						 true);
+		opp = dev_pm_opp_find_level_exact(pci->dev, speed);
+		if (IS_ERR(opp)) {
+			 /* opp-level is not defined use only frequency */
+			opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
+							 true);
+		} else {
+			/* put opp-level OPP */
+			dev_pm_opp_put(opp);
+
+			key.freq = freq_kbps * width;
+			key.level = speed;
+			key.bw = 0;
+			opp = dev_pm_opp_find_key_exact(pci->dev, &key, true);
+		}
 		if (!IS_ERR(opp)) {
 			ret = dev_pm_opp_set_opp(pci->dev, opp);
 			if (ret)

-- 
2.34.1


