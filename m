Return-Path: <linux-pci+bounces-39633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BA8C1A0E7
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 12:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D9C188BB8C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 11:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B063376B9;
	Wed, 29 Oct 2025 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DQPSGRmG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dz5ZrOMY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A634338F52
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737429; cv=none; b=YmmrIh4/RI2yyNHtWMz1rb7ruvQlkdUKICHwjLk5KA3FxkFKj3+XmzX0eIowRJemh9nMlCHKgvcWPuxe//RRmpXpJW9AT17e9pcOfCMFuU1FBlg1xNMtncB+nxbGKPU0DdxOZz4RC9InViK3vQuwk4XEHxDRqwIJP7Y94k/ocww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737429; c=relaxed/simple;
	bh=kRgViZa4KGaZCel0lL7UaLwBZ4oTyRhW1O/XbfTvd4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hbKLSLofzS6iRzbqHCeDmxQ4C3hLhR72/J849E8sbI8+j4jqQyU3zdHlr+TdpOsSeQtjd/q6pW6+pSnuPMKzmntuaBJMuYyuUtonxCkJv1IPe8AUblPTbCe90PP+mqwTqfVruxSo5qLd7Fraa0AFLsumfLYi9WAJAKidqBwkL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DQPSGRmG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dz5ZrOMY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uxgG3676883
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E7sek4J5JcaJw3gQMQZq1+elUkhg/cQB5aGi2C7MD0c=; b=DQPSGRmG3c/8SrOx
	hqpZ7nzbpvZcXxVBCYDkX3lp0iIynf0YJ9jSm2popx9x/W2tIqNQLHpxNPNNy1kK
	nNXc5052y/Gu8yuHi10pM8X6E7LZhTPwyQ+5VFwbLI0CBrrONyfNX81getHpm7US
	VuK/wBbeS8pTk5KLwwETTR9ehtp00ad9dWIFLbZbeTmHszY+SqikC8Nvo+Nwkf2q
	JemCs8bbbRv78vexmxtUagVKMYfiE43bA+dCmEkp17+xxHQTHANjVt/LoX0BP/+y
	lx1+JviLcikFwqN7TLY1RRjjgbFsU7+0wyyVtgyNNovzwP2pLev0RwWjO0hWVXTb
	R3LRRg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1jb9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:30:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290b13c5877so143200655ad.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761737426; x=1762342226; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7sek4J5JcaJw3gQMQZq1+elUkhg/cQB5aGi2C7MD0c=;
        b=Dz5ZrOMYhKqn/Iy4HAENVZd85fiCGeAxCSRjQWy03P476C9BXhpHh+tw9Mc08E2t7C
         atEIue+pGkgwlxNREa7ZAXPGQNPWAnZKJXlCma2cJd1midwgtj0FuEK5g8b7ii8cH2eG
         XCKIosNG+RnqlELDFNv/XDTC7YzpNcbSBNwoq1laiAQTjE4Q8cNRgrBsSSDtCIH7iwQK
         oCiEUnlKaymIefk8spMnHujuk/mvVbKSWi5/dTL9h0jziqYzMNMoZsWl2D8bM/C0IlAj
         TjXNL5o6IS+Q90MNX8S65kgqgxe7yfFXpAm9AYF2t4E1Cd0SVqGuNjlJpjipS3kbI8bz
         HAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737426; x=1762342226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7sek4J5JcaJw3gQMQZq1+elUkhg/cQB5aGi2C7MD0c=;
        b=SiI/Np9a3lFHZBvgn3O8q9FLGIOldaJz2BB7YADR/eDszF//osxh5m2ydEjuIG4igC
         GoOqJid0A5lAWFI3fl6ESlnAYzUljrisekFigXqb/ArVvHZj8QFhngrQHnUmn/LI5wgP
         WGV3PaD5Vc5YY6ikSx+BZtfCaeddyJzl0dz35JF00EtTLGu414FGjGrCtaxzcdEht2oP
         sHQqUVrpe7VajSJtElfYIvAym/VKxMCDZFmzA2o2fiEEQojNtO4bGRqs+ncZy3HYOlsF
         NR2v0Q12cz7lX2Uu921haBIWrGdHX1OxFbIgbn1nyjN66JJjMoTo8gSP7aciE1YLLIA5
         4QSA==
X-Forwarded-Encrypted: i=1; AJvYcCVFRYVA35TlR4PpxmLTr3raIRnG6sLmZnw/m2J4PTdLfdlerlj7Eq4GXQG7Dwkius8ea+0GZyLDXjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbj+LenW9xfBFaCd4bQr2/IYPapHBdk2+yrDByu/u21uIU7o1w
	Xj8a7IK9i/CUTws/shD5nIaI/SUvSprT1Qd94UCYUvw3F8jeYsJ7HqzukV4KO+XRibX7cEf2kvJ
	9/QY27bgEUz8LmLV+NGvQHgbAbw5zO35iruNgrOowET303QTcyEyENS2Crv3PYkg=
X-Gm-Gg: ASbGncutCDI3V2x508ATn8lCDHAMyLiKWwI7gYclXtbzinmGO9BgR26j5tIfbojtRAk
	7d6LWNGLm+NIT+iI7rJe7GZOQPWkfVV3DHEpu+/OUSLmg6vWrBE4jYthv0g/Iu4CPlT/Ac1ram2
	BcSw7536c+LoY6lx9r30+RiYw8yO5KZnclDYfUVhrFP6PDBskjUl9O95H5ooR0HEqsyz+ip38y8
	j3bMs9xnCff4XIt/x5kKkBp+DP9We9Lupir79ZfQ0A+IrTqp9LtXe3mNVAg7J4f5R5EJ2XH75iY
	vZK/gxH6zvzjaZKv+jKhpWhlL0tRmuutMNYULxo5FrbjHn4mEqzjQpYHyy40xhjZZ3EHHWmevHz
	3ZyZPlnbV6QAEf062qXRRnrU3WN+vM5/ylQ==
X-Received: by 2002:a17:902:cecb:b0:267:ed5e:c902 with SMTP id d9443c01a7336-294dedf64cbmr40460775ad.20.1761737425051;
        Wed, 29 Oct 2025 04:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIfsHVKEWsWz2BHUSJeZ10JbEH9dJ62Uke5+/3SiZnq91/wZtwSuoAq+jP/ohaK8whQGV3UA==
X-Received: by 2002:a17:902:cecb:b0:267:ed5e:c902 with SMTP id d9443c01a7336-294dedf64cbmr40460225ad.20.1761737424487;
        Wed, 29 Oct 2025 04:30:24 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d429c6sm152154935ad.85.2025.10.29.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:30:24 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 16:59:56 +0530
Subject: [PATCH v7 3/8] PCI: Add assert_perst() operation to control PCIe
 PERST#
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qps615_v4_1-v7-3-68426de5844a@oss.qualcomm.com>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
In-Reply-To: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761737398; l=1537;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kRgViZa4KGaZCel0lL7UaLwBZ4oTyRhW1O/XbfTvd4Q=;
 b=Wn2wemwGSrMgNe5eofO27eQXZ77sOUAVyX9DJBD9M17t//dwyKWk4QUnx8EayalfEjFvvcFE0
 tBAHEzTYMVqBRoueX/dG+9i/X6PIb8NzwikYAt6G/sCsf1iLvVEfEL1
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Nu/cssdJ c=1 sm=1 tr=0 ts=6901fad3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Ocqi7cVID08-S0eeb-IA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: as7Zct8XoIMkdXAQqHoVJWDtyG2KAz1r
X-Proofpoint-ORIG-GUID: as7Zct8XoIMkdXAQqHoVJWDtyG2KAz1r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA4NSBTYWx0ZWRfX9hBjN27TTWFA
 weLz2p8ATVBpf3w6y+sYqqjAW5q/b5EH0s5afnFyhJ1YQHe0F9tV+EbxTsE8muOdCdps9+GmdXz
 Jl2Mpwx1qFGbLZF5lWOIeQavKzDTPBst4PWAxX0joth3CSaOdg4i5ERNLKhNNHdpC3b1B898Qi/
 YXmSbmBGyZZwXwD98f/8a4hOweRsltPjhW1w8SbeMoCLh5F+jkZMamRoBcdWyvJyywJr3QM0YfT
 bqhuUvZvo+/GHzzy0Xdf7CNj4HnGv8xc7dr3SayCmETyAb1MF4Z0jAEEpM8a1n6bwK6VvGmOB1K
 hDuCWA3kZ/fQlYUcjV5c6QdZ8LpzNbpXZDYLmBarvFRwHSQtBDvh352LYjVuLSQys1Qd7H2SJUv
 BY4UnCtJfb1DnzlBkB8c1L5qtiSJMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290085

Controller driver probes firsts, enables link training and scans the
bus. When the PCI bridge is found, its child DT nodes will be scanned
and pwrctrl devices will be created if needed. By the time pwrctrl
driver probe gets called link training is already enabled by controller
driver.

Certain devices like TC956x which uses PCI pwrctl framework needs to
configure the device before PCI link is up.

As the controller driver already enables link training as part of
its probe, the moment device is powered on, controller and device
participates in the link training and link can come up immediately
and may not have time to configure the device.

So we need to stop the link training by using assert_perst() by asserting
the PERST# and de-assert the PERST# after device is configured.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e427aecbc951fa3fdf65c20450b05..ed5dac663e96e3a6ad2edffffc9fa8b348d0a677 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -829,6 +829,7 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*assert_perst)(struct pci_bus *bus, bool assert);
 };
 
 /*

-- 
2.34.1


