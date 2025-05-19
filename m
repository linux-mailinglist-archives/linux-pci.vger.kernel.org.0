Return-Path: <linux-pci+bounces-27946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CFEABBA32
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5336F1B630CF
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4792777E3;
	Mon, 19 May 2025 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NT+X5ju3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF952277026
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647828; cv=none; b=ifNSwoqIE1BV3VzYDdg88MjctXcT1KUf/0T1XCl8lYI0kBAWtu3s1D90V2/ouU0t4fukcP+7yVZk8+zNF89UNl3pxNY0sc9wa8o9nRLWfEfX6gnsw+YFQhXNK5k0mAWrQNt7jWazjB4ryutDIazbQXsrhqDi5Ez7xAj6XR9h5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647828; c=relaxed/simple;
	bh=ciggJN5AEA2xtLRmbdfXbsqmVBeTQ+3RUbZugVrrsac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GtXMb7CP+WfiJGpI1eEWxe9E6j8EO1eOBSRp1LgyGt47WcDSLb27nh5fPyrgXnIrtnwssOx7lJ+I2JS6hl2S7mABylU5M5BNb4fb7IdXBGAIeWjnNluEzneOboQQToI/CpxCBpL/qRoQdXYhe0HqKEeNI4ukYWmZ4vggr8bN9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NT+X5ju3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9Zu9d020271
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sdf7PFBmZ+dWTupOwPp2L2RRFGZXAccr7B/5Kw7lJr4=; b=NT+X5ju3qOKvzfHe
	xc5ntELMAsH2oxInT4ogGF8raCjNMz+8pSHBkmWC7inueP4yKG40TmtQpMEoxBxZ
	Oj3K6ZDzdek8HDAP4rTU2xpSbjJB9kHw3jb9NyV9jp25oMDkQp4nSVMEPo7bYXr/
	YA9MNSXVqfdsUZuSJLj57rDsD9XWuGegv0GeY+4ppbGcShh1WrF+na4/dmRq/Hjq
	IL6/UsqwvDSzt62q0jcKEg9tv4ji86zVbAHP/nCoINLm8NSlxhOR1r9rIGAa6G9z
	7dknjoM8VhmGRlu7SmX02PS3VgB/TZTgcevLW+xDbSujeAaw4eZuV84rmIJG06Lj
	CfvzFQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pkr9uur2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:43:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-742cc20e11eso626043b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 02:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647810; x=1748252610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdf7PFBmZ+dWTupOwPp2L2RRFGZXAccr7B/5Kw7lJr4=;
        b=vG6n0FkbaobDkxptSn0GB7Caj0kYqdqlXchl+4mIC/jQ5TOF5NNKaNmdN3Rg4rMniJ
         Ug+NQ++4TZ8v96CTRJ0cDinHO5syKmu+J/FaCdfZKhDlR7ctvgPCDyOXxC9gQ9I3pzPF
         JXSaz11g+ELxvm9L963eKeFBs7ASyY0dGFNp4zzuH2EPBba1x8m4JAuLUQuUIYYttwSD
         TK4hql5mXxf3EbF0l0ra5WJ257mQTexeRgxJLlUmPOgonVc1QLCuogGADiz086xC87Ld
         +IA8FGp5nOxGjtGuPR6KbH+Ih51mC7b+64jIlHAkqMbTp4Ox94iKSQ82aOsswJkK8epy
         TqYQ==
X-Gm-Message-State: AOJu0Yz16afpJ09eExaefPvUXJdAa3bq8z6uanXX7hYk9H4Mt5zAJ1Qg
	5yCFpV1i+TnuGyPJGWngvAWXrpjyt8coiPbxpubuJkmhPWBeSknS358p4wGWtegCY/XHlNIoTUB
	wod8/V0qdR+h2MvtIMWZS1e+sjKRAsrUqmnKtkEIk5NYNM0dg0VU3YTGi6kuGFLE=
X-Gm-Gg: ASbGncsdHzo7haWzM33MK25IrgAXwSW2sf47k43j8kd9m7UAnjlBMiEUtU8SE5WZeXA
	0qM/GXfsDihDLyjDbvh9QOuzKFYRLOznBBekwQ8I/dpQ3+c5GB2crsN/xWE8n/agSuYMxRcG7WC
	KtdTF01oj61y8ybCG133NKt0yNqzK5MnB1eILA9BI8/fv00TF9hUd/dbEQZOnrnWrn3Ug5GugL/
	1aUto+l3khFMy1V7kBpP73oyhdOYSUsZmUb+YRWoNvt/jYNcCc/KzYWicihJ0LmLgGG64u4rQKy
	+CtFONFO/8RVp4AKYLHnrHXme6Ci47fLuSzhhcGsqglFMUA=
X-Received: by 2002:a05:6a00:858f:b0:73e:1566:5960 with SMTP id d2e1a72fcca58-742acd507c1mr15013613b3a.19.1747647810004;
        Mon, 19 May 2025 02:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBiZoJIttAqGh73o7b+oxSz8Gg3VOIHkxWf1cUJrHMPT58Y/cYk/xydm04u9gJFvMbMdWJzw==
X-Received: by 2002:a05:6a00:858f:b0:73e:1566:5960 with SMTP id d2e1a72fcca58-742acd507c1mr15013579b3a.19.1747647809549;
        Mon, 19 May 2025 02:43:29 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm5809092b3a.78.2025.05.19.02.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:43:29 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 May 2025 15:12:23 +0530
Subject: [PATCH v3 10/11] PCI: Add function to convert lnkctl2speed to
 pci_bus_speed
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-mhi_bw_up-v3-10-3acd4a17bbb5@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
In-Reply-To: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747647743; l=1624;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=ciggJN5AEA2xtLRmbdfXbsqmVBeTQ+3RUbZugVrrsac=;
 b=9tbNb0ShTaqF9yKpDzZgn5+IkqxjlBzSFrrncqIPIUBywJht4BGIpIewbdNC9EZoJ5T+rqib5
 hi5eVz2dqkxA/eMOSAv3OvErH80iQTydRIqFwBY3czPX7odtNQdyhO4
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 8ykCSyVfm7INpzo9svSDhdDpAnA1Oy78
X-Proofpoint-ORIG-GUID: 8ykCSyVfm7INpzo9svSDhdDpAnA1Oy78
X-Authority-Analysis: v=2.4 cv=DdAXqutW c=1 sm=1 tr=0 ts=682afd50 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=rcts_Xg4tTJKaDXoMsUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5MiBTYWx0ZWRfX5ic483nVcums
 +SI9p8jJRdnji9JJGXrSr4g3PyPJGCQ5Y6gN0u8qlY1XYK/QuQqo1KCthibridrLcTiaSuJjir3
 pyZRRYWbfbw04UtTNFxaNa0frexBxueYUCOOm0NIJFHcFShJPQ2wVqvvfPiJTCcxhsE/SUBEcqe
 hpTu4+w8SdlQYKnJdHghnlWTsYtFQOjt0jnFlgOiSicGHRPtHvyleWmJNqtPlafxE0MxH2zIFQF
 D5CbZQLyno4QH9QqUODqX32Q353laxWvMsBMXCgPWhljN5xOcFMtDvWCPhAdUOB/VZKyFkHgGA6
 Ht/+GK1S/yK6Vyl2aQ7snYhF8sUeHGjSUM9k700+IIXTZXeUEhgC+ir0rXFpIjjyu/SQGiOEcv3
 FK4PenC72qmnSZZsRqS1sBcAFQBoiZh1iR0DaxH302shVepYTpH6J2N/NWyauuNfZwLueW6h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190092

Add a exported function to convert lnkctl2speed to enum pci_bus_speed,
so that other kernel drivers can use it.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pci.c   | 12 ++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e77d5b53c0cec9c7cdd043ac44329d1b285cae83..363565fd71bc184bb07e4f21e9009ce382e6075b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6035,6 +6035,18 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_link_speed_mbps);
 
+/**
+ * pci_lnkctl2_bus_speed - convert lnkctl2 speed to pci_bus_speed
+ * @speed: LNKCAP2 SLS value
+ *
+ * Return: pci_bus_speed
+ */
+enum pci_bus_speed pci_lnkctl2_bus_speed(int speed)
+{
+	return pcie_link_speed[speed];
+}
+EXPORT_SYMBOL(pci_lnkctl2_bus_speed);
+
 /**
  * pcie_bandwidth_available - determine minimum link settings of a PCIe
  *			      device and its bandwidth limitation
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ce9d0812a61c2337ba533ef246393a0101e617ee..48c3f5b1f6f86b652355fc9edbcf834d64fddd11 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1655,6 +1655,7 @@ int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+enum pci_bus_speed pci_lnkctl2_bus_speed(int speed);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)

-- 
2.34.1


