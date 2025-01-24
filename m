Return-Path: <linux-pci+bounces-20327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C01DA1B353
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 11:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01C33AD87A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05C521A43A;
	Fri, 24 Jan 2025 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q3hQPxrO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00121A422
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737713461; cv=none; b=WM2JGZyAtaLQI0BExDZrwxOuQWNBa28ATDYDriTbuZ7qH+ZcA7aEnbb2BmopgQZehOGtgQl8wohCd/o67SliwxxuI5swNzvlpdC0HMYclbHYO8OSFLUT7NYRoS2kXwoNlJKP8rxjX9cOia6qjpjjw/C+jpJBbKFRRRxDK1ub4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737713461; c=relaxed/simple;
	bh=N2lF14aGwlo/azpWF8BRBrEW5+wH2aHyY+T2Zoz8R8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ln/iVNyDMQjHcImk/0TK88wO68/vtUoU6FvJBCfHoKKxxMprOqsrWOt1XUYiTtAInjtJnnpRnHyVlHP95+omCwc1RZNTF7A/VyKzLRavACy5zQKQBD9UuMgkdilTbCC/J7/0Zb5bDQKGp57HHGNcJvlFyVMi4fHYUleLYScd5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3hQPxrO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O6AnoP005676
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 10:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QTuzQaNN61y
	5MqpLSwcmOsw3cjnsMlfMXyB5by59pS4=; b=Q3hQPxrOOGpKzb5YmLU2pPiHj43
	rU9xFVN5EZaUW3EO4scLVnyRapoTSdivZhDxZ77e9D5sVxtmQNufOO6rQh7rwWaH
	8kBKRWlc7T/CxtZoOATBbi+3hXK/nEUknCZ91PXHHL/I/wZoDP1cZKPDyNBQHncO
	ph1K2SGB5y6zQooMj14HeOFVRFM1AXoq7/dBWWOxlfjSEpBuEi82WQr2nrahZ+ao
	coQI8rqFEfgBNJ83DqJhRcF3O5z7Uu+tXEs3MEgYDx8lctLUa5Gct0txizabrsnq
	xGQfTwFcC/cpWzyo3RhSOy8Y7IBGHCKS+ivxkNZvg5khSpLBHWDAQQI9glA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c5c50kd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 10:10:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21655569152so36694005ad.2
        for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 02:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737713458; x=1738318258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTuzQaNN61y5MqpLSwcmOsw3cjnsMlfMXyB5by59pS4=;
        b=i2SFNZimqz0f0EzuXz+aBBE81wMdWdy54HGrlEqcJRhmv8AQxEDIbpwdARKwVJQYQJ
         w15l7TNvf8m8ESz0u9FjpwTyM5rNBlBSHuQ/RIV7ilzyEnX3wN0d4PWz1Am3KRtyQu11
         QSY5izKQylevErOyAgGkrp/LELmtZ2p4byNOZxUBrhmylYdWFABXGByZowvGmJjPvZp3
         86eT+xC9k/D1G1vRk1bL07TUm5d8/qQNRP7/xtixIXbhmUaUFeggpjOha7LxnPR7yK+m
         0GVTfgZMPvpH31c2hIlGDeQiDRFEBsDJ/0M9N68zB6ZHgsmkc6MvLLzQJSuWlcObBnG0
         hZsw==
X-Forwarded-Encrypted: i=1; AJvYcCX2/Df7TSaOEBOpReRA6Yqh1pky7YgCZrxiIvzPh3ktOdFkUmV6r+v3iWlgzDpqeeWj5ulIVa58qM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xPGKcd7qrhRY3B68GdMdEyBSLILnJp+zCzA3UknZ40ebot6r
	stu9CZmFcIzGA7sY1wXUz0AJQsOLQrbQheTPvfGHCs4DR5acBqzm5sNsICSCQENWLC1oksQiHe0
	SuMujJ7JMcs5ftYzYLQ1qgjDdv/6lvFezPkuy26XmvvnpzapR6r2hDZcx4jU=
X-Gm-Gg: ASbGnctYkxMqLiwFGHRR/u5lLP2CRqkf3WkGE0FRUeuZ3a8UJO9cFvoiJb+3204Scuh
	HGnCaSCUKp88jc7sFV/9TSTmdBY4s+5/suP9ESFb5x2lIecbT2DxerBjyTQAHgtJRBlLSXGnmy5
	zsidxG49Km/bi2cbz9l+PagvXpWcPbLjQ4jM1zIDpPP/IfYKFQIDv7o6oOgYMQco2o2leNRfoXy
	aXu+lZP7hSpX7WxUtrM2t4EGFe3b7R4OKhWCm5/ik68devJ9CfWvVV/xuSMuw2w+Uo42ZazRA2I
	d0/UzmncBD3TZIoFbqoc1QFS8tqYQg==
X-Received: by 2002:a17:902:cf0e:b0:212:4c82:e3d4 with SMTP id d9443c01a7336-21c356093bcmr449066635ad.46.1737713458441;
        Fri, 24 Jan 2025 02:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPdt/tWXnYv0ZJnPog4hmu7Y653tEvtmLqJ8rL0b6LAjLhAX1Bo1hz2SKucKP3+NMNwSY2mg==
X-Received: by 2002:a17:902:cf0e:b0:212:4c82:e3d4 with SMTP id d9443c01a7336-21c356093bcmr449066285ad.46.1737713458082;
        Fri, 24 Jan 2025 02:10:58 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141dacsm12773825ad.133.2025.01.24.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 02:10:57 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, dmitry.baryshkov@linaro.org,
        manivannan.sadhasivam@linaro.org, krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH V2 2/2] schemas: pci: bridge: Document PCIe N_FTS
Date: Fri, 24 Jan 2025 15:40:38 +0530
Message-Id: <20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124101038.3871768-1-krishna.chundru@oss.qualcomm.com>
References: <20250124101038.3871768-1-krishna.chundru@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XdsalQeQUPV6f6H85MVXKVPtcVmvTAQU
X-Proofpoint-ORIG-GUID: XdsalQeQUPV6f6H85MVXKVPtcVmvTAQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_04,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240073

Per PCIe r6.0, sec 4.2.5.1, during Link training, a PCIe component
captures the N_FTS value it receives.  Per 4.2.5.6, when
transitioning the Link from L0s to L0, it must transmit N_FTS Fast
Training Sequences to enable the receiver to obtain bit and Symbol
lock.

Components may have device-specific ways to configure N_FTS values
to advertise during Link training.  Define an n_fts array with an
entry for each supported data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 dtschema/schemas/pci/pci-bus-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
index a9309af..968df43 100644
--- a/dtschema/schemas/pci/pci-bus-common.yaml
+++ b/dtschema/schemas/pci/pci-bus-common.yaml
@@ -128,6 +128,15 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [ 1, 2, 4, 8, 16, 32 ]
 
+  n-fts:
+    description:
+      The number of Fast Training Sequences (N_FTS) required by the
+      Receiver (this component) when transitioning the Link from L0s
+      to L0; advertised during initial Link training
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 1
+    maxItems: 5
+
   reset-gpios:
     description: GPIO controlled connection to PERST# signal
     maxItems: 1
-- 
2.34.1


