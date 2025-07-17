Return-Path: <linux-pci+bounces-32404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D0EB08EBE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 16:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26421C2565B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE392F6FB6;
	Thu, 17 Jul 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SIg+XjZz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0372F7D09
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760917; cv=none; b=g2vLhfA0FwcCSwFSCctRb9QYJho5AvZ1nfSYYgNF+wqwVfZe7cLYC2yynycSnjD8fRar5GSx1fYuOl2Q0Z2O7zuoJCqSU+IJcupK6Ag9pOtTET2DDZmG3MNSAXK3GfjmmEvSRmTFcpZqWSdRNfIu3s/e/o/cxXcuhNN4us5EAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760917; c=relaxed/simple;
	bh=e62XasrSHfC8Z0rurv2mAXh/7HxCFsu1wN+MrwN9ftk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKpFUa1TbEmHpla2s3FiSg1r2qiRnUVUSFk6gA9fMpV3K/261agqPlAzwn8N1SaQPolzq7T+AoAjyus106vWM8cSMiJBh3S9XgvFSOwvrlaqKUIHw47RIfWQREP75QL2/OOOKVaPnlxl7iBLuoSEnjgGQKL7sqssjrMAT5yORkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SIg+XjZz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBv1mi000564
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 14:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EOr/OjPds5RpcIm2BU/TDEzd1odaEkIi56AvFfjSPPU=; b=SIg+XjZzdNtHWPcX
	BEWDOFV6r0YmEmgqNFN9JMn9P7DdwEWKSfgpfCOs9aeEf/9N5R5Q3VQ4YFoPyPyc
	F9/CiylnChK6PxkrqYQkOod0BgnJ5BLCkGy2S99cFgAWUF7Dr8Ljj7DF8Dn0ttUU
	JdtWjg0UPL6OoHU6REgNE1e337vzhwKFGnQ3UmqEXdzps+mr4BzVuO/hUwwBCOmj
	gIMUrEfue6U7v4u/rRC5T4NVAMm9cHFPNiEVlzvCEg5HBextE1Z7za1zDTQtHHK8
	qniRQpxsOGfHdTlAsCowgmG3CBdOgHelRN98bL7jDashvre4VKataiSzSnL+6ajW
	HKNxHA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drtxw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 14:01:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-756a4884dfcso1101222b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 07:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760914; x=1753365714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOr/OjPds5RpcIm2BU/TDEzd1odaEkIi56AvFfjSPPU=;
        b=maP3ZOHNKi6hntquxrsxk82cL+l8F63RFm+Q52CmfbX2X7ubFlOYVWF0NLXcrkGiE0
         CiVdEH+/L/Lzldx+sbISDlgk/XZ6YCv+fHnAJuOZYTtBfSLrnp3bIHb/sDSJM2Stj7F8
         q/a4IxbKUGtEyt4YEX+ck8PVT+OwXuREmL1FD5060Z9X/bQiMrgZC2vNhRib3+3ygx5s
         6+LKGEGlZG5d7YKGt74KHWMwln1xb34rZ34nSpO3LHg7WwnAsQ25SJvyNkgcP12wbj6U
         NI8SxVnQbDvd2xdLipQqqoPl80HwbW8GFELh6viNYMNj+u8sH8NjgP8ELNuuMgh4xvks
         vz0w==
X-Forwarded-Encrypted: i=1; AJvYcCWRIwIqbWjO8TukcO6P5U59CGsgPokuOISHuG5WTCWqjU0YkfvmdknOgygWOwMwlhxX3GSgkm244S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqNYlFvhc1L6zMR/U+uFweDq5Edvznb5j0UdW0TLDgBAV3l49
	2Ygt/2tS1loWInDTW2V6oj2POxG6ihJz0ED4SD/5i9Rmrn2a+ZB5CIRYpbgzotjfdbinEWRFmWo
	AgCDREQbwxz5WRFfhLIXN8tMTI6xppIgl7oF7nc21Q8p8n+A6GeLOVFHLiWAagt8=
X-Gm-Gg: ASbGncuvRaH6GXwJtOLB+E8sYmmnQGH0XBP2w/rAv/RhkdmgEb8/OiJsq36uL78TCzL
	OBM6qz/yKPQHSsLxAHY4Q5Dcdw5zWePwnydebOJDW81Dco+xxcAn6iDnUvEm9G1ZRd3arfOzZmU
	+2YpkvKT5rEKAHVlShcVGZxfw024nuQfoORc0RtDOGxJ5snQolQ2h5magFo0keWeUMZQ8B5o8l0
	08oRhdZsTZljiRxN0PN6uCVoK99tRYNO84A2rbBKOfTd9ESoxTjRU3mMkiZEmdHWsdCSauU+bQa
	XM7od7K5YPpJYrVvZDVgZepxkPdsnobINLPt7bUGIeRFHirVzp+gR2aC2zo8wZjlNrSs4V3spi4
	=
X-Received: by 2002:a05:6a20:2588:b0:222:1802:2dd7 with SMTP id adf61e73a8af0-2381143f214mr11866936637.13.1752760914179;
        Thu, 17 Jul 2025 07:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMvl3MAcM4sjD4kYy+/+p3tdz64aMRUaqIYkDD07g/QLTinAeONBpOyIiIidysTHEQEjPUng==
X-Received: by 2002:a05:6a20:2588:b0:222:1802:2dd7 with SMTP id adf61e73a8af0-2381143f214mr11866851637.13.1752760913624;
        Thu, 17 Jul 2025 07:01:53 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7507a64b57dsm10311986b3a.14.2025.07.17.07.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:01:53 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 19:31:18 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: sm8450: Keep only x1 lane PCIe OPP
 entries
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-opp_pcie-v1-3-dde6f452571b@oss.qualcomm.com>
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
In-Reply-To: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752760888; l=1743;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=e62XasrSHfC8Z0rurv2mAXh/7HxCFsu1wN+MrwN9ftk=;
 b=r7CoP3HyktXj92XLKc2jPHd7tzYKulq7P2RE5k93K7GbLTC10b0OfqnOXhwx0gCvpiisoVuOh
 qpz2HrEPlbVA3JZgk6dOhKdIF9rXgbkjo4GDl5FCcacO4lWG0e82ctF
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: DA5sNvsH5XNO0e7BgbhvwIeu11EXB9je
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=68790253 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_k9ig2nQFDp-gxZIyLcA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: DA5sNvsH5XNO0e7BgbhvwIeu11EXB9je
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMyBTYWx0ZWRfX4RUYcARucDr6
 Vl8GMU1o4aAUedzYWM0/alLHQBZwykrhHb5W3LhFecry3lMIgbw3ZQFCMg8lD1z5+vYJtfrL/bu
 sAgxWrcyv3FPe/Y44QBwhBdzvFkeIaXUagCMjQCHXaTiStItsVRIMtI07IZSSlm8wamF8iJaUr6
 t5I8vog94hAvkNBsoJvA6HqUaJQw+RFIEJKK3uk4fcgKpof8XKbLHspDa6u8gso/u7aGOSRBqLw
 sveidjkN8lokTVpid+oqp4ADqDGbOEd1lFdrugjqKYysQZ9ax6EkjTJlyVlE65k/HKoMhlLC1jN
 lwPi2HbqqDvCuYwWbInzTbzP8NwUuzAEoC73GXvznV7CMQKHnPeVUqYF3Yx4LusDEu89PD+vjqY
 PpA/QzGEODZhEVJt6MyJcrrekyJYL3VFZhz1dnKit6G8AxfhDbkvn07DIq4wOS9/XVfoct6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=614 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170123

Currently the PCIe OPP table is included entries for multiple lanes
configurations like x2. Since the driver now uses bw_factor to adjust
bandwidth based on link width, we only need to define OPPs for x1
lane configurations.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 54c6d0fdb2afa51084c510eddc341d6087189611..d752dc2b17f03284fada7584b5fbdf7672e06142 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2216,20 +2216,13 @@ opp-2500000 {
 					opp-peak-kBps = <250000 1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
+				/* GEN 2 x1 */
 				opp-5000000 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
 				};
 
-				/* GEN 2 x2 */
-				opp-10000000 {
-					opp-hz = /bits/ 64 <10000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
-					opp-peak-kBps = <1000000 1>;
-				};
-
 				/* GEN 3 x1 */
 				opp-8000000 {
 					opp-hz = /bits/ 64 <8000000>;
@@ -2237,19 +2230,13 @@ opp-8000000 {
 					opp-peak-kBps = <984500 1>;
 				};
 
-				/* GEN 3 x2 and GEN 4 x1 */
+				/* GEN 4 x1 */
 				opp-16000000 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
 				};
 
-				/* GEN 4 x2 */
-				opp-32000000 {
-					opp-hz = /bits/ 64 <32000000>;
-					required-opps = <&rpmhpd_opp_nom>;
-					opp-peak-kBps = <3938000 1>;
-				};
 			};
 
 			pcie@0 {

-- 
2.34.1


