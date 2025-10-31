Return-Path: <linux-pci+bounces-39915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BD0C24B6F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D201350A35
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 11:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A93451DA;
	Fri, 31 Oct 2025 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Usrcukr4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="acqbTkB1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522CC3446D2
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909138; cv=none; b=Z2FZLIkc/Zo8Uj57dUoVldzzj8dQVYv2uGmJn5nj1Jn58kj3NAZJMv//PbGfVkiv1bCqGR4Z3/+rXgS7HNS2MiXvk/9VsuDfR/VUM3k71vBLrEzpq642KD969P2CkJpuJhWA2sGsnMNZ06nWJr7hgkgF4sYVELJt2IUdEpbA4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909138; c=relaxed/simple;
	bh=kRgViZa4KGaZCel0lL7UaLwBZ4oTyRhW1O/XbfTvd4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fh/LE5iV8txkP3wi/nTAadlbWYJR/ZywHG1FTYVksdEjU47zkxwtH+LIM8Ng03Sy9SsFuOAkO7ISLr1d0Lj1rC4tQSoMDYLrqXTRPwTNMc+WEZ/0fBqx1RLom/fQdad9t7xP0o1ftyhOOHtyKZee+8evNLaqgDvS6JrkKBTonh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Usrcukr4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=acqbTkB1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9jZP92471666
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E7sek4J5JcaJw3gQMQZq1+elUkhg/cQB5aGi2C7MD0c=; b=Usrcukr49l57A1aS
	1nQW0kFBQrOVre0mECjsOjjH199lj3BVFUCGOfosUokPi0MzJMgf5vVR5G1FKw8w
	pR6a89vf/VNyTRZdoblYNRnQ4fWm4U7fEb/qq+49Gna4c4iRJ7vi9ouJ1xl/QBLQ
	X4A2dVaRCJuKzLuEoXP3BjZBtNl9jCUoy+bbuWi1IHZ1XVlAJu4e48jA03elz93p
	d9MzZGVpr/0/LKzjBnhpoJK5MKdqm3n2OgyKNCggnBviaFpGtUS4STe7OXHOpBZe
	scFMEB7Wl7mI/hesN7Ui8Y27+3VCjYVP8Jr5muWGZ1iVdMc0WkXGgua2MccbdWZ0
	XDJjbw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4trv07na-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f610f7325so1831758b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761909136; x=1762513936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7sek4J5JcaJw3gQMQZq1+elUkhg/cQB5aGi2C7MD0c=;
        b=acqbTkB1arKLS03vqzLxFSZAgwo8TD7mGq6+4rtfiM3lElHSwD0EDXn3GQkialf9Bw
         NQmHZAt3/D2a7rPV1BNHjdhbkebBHaENtijp9evrp+tk4t/ULJIgGnUnhsx9eV1tX9R4
         Z074cCrVVVL3dbHndEkrMaRerw+DQqvf9jIWPORp4VdNh9KnOWfyNannRqdrmmsjcEgI
         Y2boMlpIsymtM920HtCfjI/NqC4KbpBT9I7RKJ+qBD/Y1VLEK+g+XxTpYG8Z4AJVjcp2
         vWI72p7WEavqXBFjEZWt7THT9c8EON/zKe6psgA12gsCjLAOwFPAa55i9rmpGBAEfLW9
         YSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909136; x=1762513936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7sek4J5JcaJw3gQMQZq1+elUkhg/cQB5aGi2C7MD0c=;
        b=oWDpTozFGwLT9ifuiJsljjOmVCbzZCBmkRCm735JCci/VUzCq9UdhxKOVNT1xL8TeD
         kdTkLYU+Q5OeSn1qbitNpeH+V2Do8GXYP2o24w7gbVpq0RBezgga3Bauu54GLB44O452
         2zksku55i0Cf+5SRlyXWyugAfVN3+NlEbQ/9FRI6ho3Vrk5A5vghpiHJ6+f0safdxFIw
         DGQFxPhZaNESGX00/k5fJUWyH8Exn0m+zLdp4PXU6uE63jwwHkkhi5/hJ8mr/mw18df0
         JL7HxZa5o2aFZqNr3lXOq7n7SV1vmDUDsWy7uJ5Rf57ydRxxbQ23obYevWVoAr545Tjm
         8LRA==
X-Gm-Message-State: AOJu0Yz/e/uE1hXXs7kInoJd/YdDuiSAmXiWyh7Bqt77g4VMv+UH5oQE
	AVeEh6eebmYIyyGTlg3dw8ZtsCAv3O10+2+t5PdwjhO10issug9pn2mUH82BKtvs0Q460InRNIi
	ProgOY1G8wdKbaZFGep5AzgL/jhrERBQvDIj/PXNGNeNj4Q7VY2c9FH2TzRNh9V4=
X-Gm-Gg: ASbGnctiziX7es/4NtQ/ojNCotyZBxFJJoR1lX0JdhThQYSj+axNsZe56CIeCDDUcRq
	Fnw7o0uMgp559jEkGgZgYsnN+xGQSfwhjFtiCCr/MDIU7YFO3Kvj8kNNs0Tg6SHepEGC3+Apd54
	B3yY6UBGJ+rmnfUZHZ80CEVC6dh5wjS44fmONJQ8LIGBIWhs20v0FxiQlq7zKiUw/Fu/iQiyNDS
	IObMYJCOy3pmwJXbXkP9cWDh0DOuXPLrnTLKVfszC5ZtG10YcHUYa2Zq99pFnLCRr2IEmyzQNVv
	IzYaL599hA4SQxmrtWVdYKgy/RMy/ypMWTBMC3BM/iRBNsC0p2kYn0cDLQrrKJkNUMO1nYqeqDj
	PmeMqNsDqlfM1CiorTCg0QZ9x0mHL3VljBA==
X-Received: by 2002:a05:6a00:4f8d:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-7a7791d1125mr3910379b3a.18.1761909135812;
        Fri, 31 Oct 2025 04:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhubKPPE9D0JeUD5go47qodOpssjwUn3GwTRVSQBCP7yHbELN2ptPRHkakDse55oZJV5R7HQ==
X-Received: by 2002:a05:6a00:4f8d:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-7a7791d1125mr3910338b3a.18.1761909135279;
        Fri, 31 Oct 2025 04:12:15 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d7793fsm1887363b3a.25.2025.10.31.04.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:12:14 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:41:59 +0530
Subject: [PATCH v8 2/7] PCI: Add assert_perst() operation to control PCIe
 PERST#
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-tc9563-v8-2-3eba55300061@oss.qualcomm.com>
References: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
In-Reply-To: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761909120; l=1537;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kRgViZa4KGaZCel0lL7UaLwBZ4oTyRhW1O/XbfTvd4Q=;
 b=HrAyKeLouCz3nx/+f3+TeNc5DoW/Qgx9BloWz6GcfHSiQxuYfJFNO62EKl+/6nGVXm3dt4O0E
 45aSdLQoOpYAW7vKoeIdYI/cz0UMi4JzErzLjHNJWdTgv9X2GE0Su1J
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: a_FAYjFMUP3KxnA19kg7V66EwhyHMwN1
X-Proofpoint-GUID: a_FAYjFMUP3KxnA19kg7V66EwhyHMwN1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMSBTYWx0ZWRfXzQJcmPKVvJyT
 RoEoD6uuHluG79s3st/AbUKCOtGrd55YDd/+/tEQi2V0gBBYt8/OyDdpWvkahC6JUPB3uRREBhw
 x5KuZkDr6VKRPCqxcXr8pLRYAUBy3I+tjNv/Wz0DjhtwGAyV511jXy45atqtdkf6iTjn96Uv1L0
 BLG84GVtZzaY7DFRe7DG7FyyUK2MqVHCX7GJhDFFFFaXq2JIomGUZvs+YqxQCTytm7beZUQGnSP
 bIMxqo3fHWmY8PF3eKuArRExHsd+Nv51MeoBHIQ8nwFE0nDymNw2NN6ZrmVRjfpHzQSvtgecGjP
 QXFQm2DaemiLOO9D3wYmAQDFTq50g6RYDDh/lYOLHhYBaMiGyQ29TvtzkClpk0T+nAW/5WnqmDT
 GMc7wZU+68OkaN7t7inpVnoX0eue7A==
X-Authority-Analysis: v=2.4 cv=XoP3+FF9 c=1 sm=1 tr=0 ts=69049990 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Ocqi7cVID08-S0eeb-IA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310101

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


