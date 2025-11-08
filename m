Return-Path: <linux-pci+bounces-40611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFB7C425F7
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 04:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69AE24E530B
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 03:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864A52DA771;
	Sat,  8 Nov 2025 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AD2X0goA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NzhgHGMV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E742D6400
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762572237; cv=none; b=CN/6U4HhiGaRaLqDdrUegMBgPNjsjncOrUz9hPHowGAoZ15l9BAtRF1i65pAJftxftqL7PtWCVGCSCboCN0xT1IbFiT0RnfF/KecvNq0fZ9V9FIIIUkhdv/POIscos3bzwLlwlMitz6VIx7YHZjUeV2iMcOZouSpI3lro72jR+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762572237; c=relaxed/simple;
	bh=vNGFtql0TkKs5KVaiPU3EbeFeb54nkJVtXGFSv+d82k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBc4CEO6tD1ACCFGbETd343b3PmUlTthf+b2iuhnhUrWKcRMDpHP0IV/KF83BE/vl7PPq/cdBwjJqvMMHzqIIYm5E4ZX8dhsOxrUm4uBH9ONJbN5pPmQ10vOlnUngQpy0Ln85GMXG0Dte8s1KZAshLKO98TPyHDqhfKbAJNMqYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AD2X0goA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NzhgHGMV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A7DPMYW3129684
	for <linux-pci@vger.kernel.org>; Sat, 8 Nov 2025 03:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PsvMdivlLb1u8imgIMqsYM8vQGjaomHhkwMUSd15O+Y=; b=AD2X0goAEHWeGzMb
	yPIExrFMlNJbHcP343xycOHJTZSLk5fGpYZGQ4p0n8zhk25ARyg+23I8NMCiyZNB
	Tx1s2n6RsDnEFBVd3rnhns4vnYo6rOlzNrYecLgCHXjHSCr+UFriF54hovAUUzIP
	u+itK5PC/nWZnhmhRPxZfHV+B4mjFs7/6oEARlh/IJ5U1iIcrhI+/p+wzDhu4S2H
	n/Yr2p02deVwgZ6dUi93i6NLyzQtqnMMqHHxmtq8g8usaDXLndWwyhzcabwvyOBd
	5rc5Z73ay2ZBox57Ot0Xj4cdmmjgf824N1qmWQcPRprmBUc+KWjUCzB6d8mz+413
	YqrKsQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9hn09u0v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 03:23:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297b355d33eso22865865ad.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 19:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762572234; x=1763177034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsvMdivlLb1u8imgIMqsYM8vQGjaomHhkwMUSd15O+Y=;
        b=NzhgHGMVQefB04y7Ab8Npm2bIlxZ6OEFizLhoH1anwxp5AvCPVgF7EstOG0VnNUKMS
         CP3iS8/oi7/ZCQ/tur2z2vG1zbzZq8IiewJ6KcIuBqLGYWChWjHcoaTV4Fd/1SF9QAV1
         IYFltjaFEn0Oe5DRvy+/Z4u5uz2rNDsPZDUp900ogTVDczdofZDCtWno5hruEXaucCMS
         d2OMupYbx3gxjGOI1cdTfcH4kTOFnXCpqSAompMpy20bNfte4UB4/tCQHExx3lmRFALs
         lhK1Id6i1mWXBMB2Z1qIiu+sCSVm7+1bOh/I4Qag0Q6ajlJUfpFYEaQe3cx+sSaWHOU1
         Ifvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762572234; x=1763177034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PsvMdivlLb1u8imgIMqsYM8vQGjaomHhkwMUSd15O+Y=;
        b=DomMfqwS6daiM6GmSjow41JV4mNlUK/S74n8zO4NlU9Z9/ogSt4azUzwQyd0U4507E
         TW1mIIBLOH/W7//jYL6f4ZTRr6rAYD9vBkMyqwc6u9Xxga8zMpu7Gk6n3g9UH6HMUXZX
         YLu7APNlbaRW7RCZ9jFNAJJVwF/DiAc0r6VseSdpWi4i7l5XYf9CDag27R2GLRX8+Eri
         RdJYTMJ5vZXRghoqj3T2RDx+LQAPJFifhyeAOsp12GpoYFL8zwkxGtOYZixyqIpV/plX
         VS1/o0txBvGeBJuZP7CZkc5Sk0qhmiS1AHJZy8od2c3Qc9lMlfy0O9Ec/R97gnNisaxm
         tIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRSrGdNaWylJgHYc301PNBQagTZwxCrbKoOa9tiiIrnA4FddG0FiuVfTojaRvieWjAKvOnF6VH/5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGdqUN8u52p1zu8Pw8C8B/u4kLVfhqwY9FQHi3DKBtPahMC4Nk
	oghQhmY3AL6pewgRHc6ghXWvHD66qL3+bFI6TaVRHu5d3ZUYa5MIEPgb1/nzQzikneBEzCI29QG
	AFhg1Blve/KyP72yH7SwGP+NzabwL+u/hGLI3vdqelc4k9KFVlLoJRhohhaMIbQw=
X-Gm-Gg: ASbGncuiGaRxbHEFFY/p+MFTukFtMDd/+zh4UUF8dlmIEwm9MLBcX5c/KAohX+g/0HA
	zVzGFrWaecucLDVjwMe7GxzOY5pPrSXIuwB7Mz4Ak5KD4AvOsu2nl/zS9bTQZJjpznElnHxJZFj
	7ONRsYH5cG5ogN9ZLam++qQ4GVSQx7s/vHagjhzRtzwK/3F7QGmNw+AiamoycOuLVr8kNfDKeJm
	3xnddidwcIl8kCK1ZoC43FK1YwfzqQ2kyHlJ5UN48HZrgrsF68TqwFhSgqJBBFvpIJjuQJJDe3L
	b4Jf2jDRFAqTJ6XGjQqrsepo0ajrp/xE6U30dj5w/rRztnOD3uyi18eqLpS9CX6FzNJ920ibFGZ
	UproB7sLKTo2CXC0e0+13s8QFXhfbEb0=
X-Received: by 2002:a17:902:ecca:b0:294:f310:5224 with SMTP id d9443c01a7336-297e56be16emr16974345ad.29.1762572234162;
        Fri, 07 Nov 2025 19:23:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoZj2N6dS8+mFdaMeI142TuZkywtNAb/1bTGxlYB/PITBfh9JCKKwkBuRbEAYlbnVE80ANgQ==
X-Received: by 2002:a17:902:ecca:b0:294:f310:5224 with SMTP id d9443c01a7336-297e56be16emr16973925ad.29.1762572233577;
        Fri, 07 Nov 2025 19:23:53 -0800 (PST)
Received: from [192.168.0.104] ([106.219.179.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d83c941esm19942445ad.44.2025.11.07.19.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 19:23:53 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Sat, 08 Nov 2025 08:53:21 +0530
Subject: [PATCH v2 3/4] PCI/pwrctrl: Create pwrctrl device if the graph
 port is found
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-pci-m2-v2-3-e8bc4d7bf42d@oss.qualcomm.com>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
In-Reply-To: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=vNGFtql0TkKs5KVaiPU3EbeFeb54nkJVtXGFSv+d82k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpDre22WsJOPIG7sShlJ311sZrsjxnonpfd8c8H
 WCmoV661SKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQ63tgAKCRBVnxHm/pHO
 9XCyCACXbu1pTQ6dQ9ygrXjzccOn72u42GHCAwT2CGPzI+/M9639GDp2frlMaIKUI4A7923Vy0n
 IvawwDuAKmx2oUngxQTL3ArKbtXQHP4zx5X2WcOuLVEINmIfjHaJEvnMxI7V8OVU3F/vmFn2TWF
 S9sdC1TirTm5qVWLw+oZCbm0KnYUeQMWTkLd72bjpzb7qt9RsgR3B+TCDP7BGwV9F4g3+8B2J5X
 2J7kk/fLY7RT37X4gnt4CZD3lZqnyYamMNLoqFXzCWHQQE/EPFXZ+rggrKiwwryV4OsxAktU5Gd
 g3fwk0aF4QMOzvB/HMFWBfVrx4L19l2raUXGH0F2MtY60019
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyNyBTYWx0ZWRfX/ZkpQ7jKfgxo
 XBvPsDJJpdLpMFhsLXYt0rzIavyL+UettH+Mxgom/UdQzSpVWn0KuxQxXKUFWWlEfQcAdcHBjxt
 cWWjMJT5JrFw59PGBSIuaIraqPcVwDJFfRQ/Goj8Ph9AMn1l8FIOotoEmOgn9jNexnWS1S/Pokw
 6pbFvS+eockH9DTPaeToUfaeYU48keRfg81N59Kl0dIUaEa+kvVvmePxOgtFs3IUFe5WGzEQ+NP
 3GxkVZfYK674xtLF6tsxK14Q9b8qy+uQjoVe9DBt1iH0x8HfucR/Bn4aj5ncsS1UIJ58n4d7Azb
 2R1jc+e2J9banWLH0e6fOBJMcz7Pi2iDyhlMr3+9BVn/QH31q0Mx3z+eucUGq3awDJrNHuIXoYu
 nqQQKthd0bYCDGI6wA5EsD0fcyG/gQ==
X-Proofpoint-GUID: mHcF-6zT6T9MEWJlRJn-czFPXpyQ_Jo9
X-Authority-Analysis: v=2.4 cv=MsJfKmae c=1 sm=1 tr=0 ts=690eb7ca cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=qronr9GGDLuyXDLutoyxMA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=0pvPJS888BSDkZzuOKoA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: mHcF-6zT6T9MEWJlRJn-czFPXpyQ_Jo9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080027

The devicetree node of the PCIe Root Port/Slot could have the graph port
to link the PCIe M.2 connector node. Since the M.2 connectors are modelled
as Power Sequencing devices, they need to be controlled by the pwrctrl
driver as like the Root Port/Slot supplies.

Hence, create the pwrctrl device if the graph port is found in the node.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83e75a0ec1263298aeac7f84bcf5513b003496c..9c8669e2fe72d7edbc2898d60ffdda5fc769d6f5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
+#include <linux/of_graph.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -2555,7 +2556,7 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	 * not. This is decided based on at least one of the power supplies
 	 * being defined in the devicetree node of the device.
 	 */
-	if (!of_pci_supply_present(np)) {
+	if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
 		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
 		goto err_put_of_node;
 	}

-- 
2.48.1


