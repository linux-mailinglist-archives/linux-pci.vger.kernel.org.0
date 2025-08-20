Return-Path: <linux-pci+bounces-34361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDA6B2D65D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F2816487B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B5C2D9EED;
	Wed, 20 Aug 2025 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DhSXmS1D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481262D9ED8
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678550; cv=none; b=gOKZ/toEtzPIwGZQI7/7DhuMn9npr3q7bEelYXY26ACazd5OWZf2oW0ipWY+jFfisRJa8riZQI8LPekzQWhzbUqdtQe6VqX34QIt056l1/v9JY2uHiJHsxFs9WU2j9B/4qBPv5Yu9JuqvNveL0QLHQLH04ZZhuAsyZnoj1O3+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678550; c=relaxed/simple;
	bh=qbiTA97ecG75CN8dtvPjbRcNXFdrEC8SJKen2afmr8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bvz6Cfaip8AAnfdrvtZ3usLZHxJCc+ffy5ahRh+aBSZxFzpN91xPrnLwxTQIx3wRzQ2WALniSAsSszHZaeXEk+RokLOpdhE77yAzAXmYl6lRRwyCD6YqFWbnmgP6U1/8HA8JgCjUI1ohaBjfBYD/4a2khvpndNV26mUxWMNfBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DhSXmS1D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1pJEC025245
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wWW4BGFpCWnZEZLf1V0C0XICc4F6I83lE+aOEu8pGoQ=; b=DhSXmS1D2tEcfEs+
	0F1dr8C9vF75Db1WZpcBehjJyqnZDzAmxIQ/2eeLoQGP3x6SaOX9iU1elAFGoZY3
	Pd787xDJ86WbgVE8OhdGxRlX+Xt4F6zGna6qkpocWZNJ4s0BjNSxlGG3MCxP1mmt
	jwioZudGCfVFco/FfO6AqEi7BpmFOVrdoTRbA8FncN/Dvg7ScApr6WwtPnf/S++l
	Zq+BHogpGSttwdOaZWk4hY1IydOIi2Is880jq365zlQ0o3OWbOdlBkBRA1otn8wa
	fvaRxnSk/vG+TKCkCNqzgO+cWBXmy5sIwl/Ii/hdtSNUhi5Ka40LJYFtGlgRNnFA
	K/lB4g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n529106k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 08:29:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24458274406so149023625ad.3
        for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 01:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678547; x=1756283347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWW4BGFpCWnZEZLf1V0C0XICc4F6I83lE+aOEu8pGoQ=;
        b=M4GoAeEZnIQrf8j+gEJsv/70jZpe/lFva80gp8Vc3qxcXsNzS9RuWoqb3dVlFgYenR
         tnR8KcIrHLS8Dne0gPUFdUbZPP/bFSKtPUcPvgauEv4Rl6MUhpBrsC0OuM3AkWogyMAo
         Z27kOnmb6VH+uvQhWIbjxPWgSRopsCWwvQQ1HIUVcekDBcCJQJM6NwL7+LHKR6+ASVGu
         40IBFxh1OgA/1lgoPM8uMFjkcEkjmvZ65d+07y2YtPayiyut3NMYE8svI0MmLiNTzmtt
         tgr+1pK5BAT4qxzKPH8SGXysfTxMBGBFtbR9SGfPXcuJIy6P/ULZvf88mGC1yR0CZ5UL
         EglQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv7NtYIPq90+GlCEYaAH2do8hVWtXEixxJE5OuvopZ7gpaH46s0ldtM5plyDnFUQ5bFgY3i1h7TqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXCkDUo0IMFx+aBWvabddLWED9iMHXIRinN8e3X35unzdjZ5lQ
	e7A8SpgiM3bce+I4B1csEat3AByvGd85mxCExRNaTd4aehYo9dvM90U2zaahSe90ZKC6x2g3aBE
	0Ov0KjdJ/hDw63Bj/d+D2edclJFPMYUM2xd+Dr9Lzp8SYe/NjNa9f4SL9EmOS+gM=
X-Gm-Gg: ASbGnctQjdvEp7HCeUN7hQtUiE4jBWa/lkvxgIORByyjqD6JkmcVdV67pH40j6zJsM0
	2l+Fd87jyQacVZXe7B3L03dv15EUcUw34YJS8p0GAx2QWs9Po8hAzMuUwrQtapxJ4VPFh4QpwmK
	r6HRPUmTnUlkquz3hxm9fZcpAnBbc3Tg4kAVmfdeIM3BIoaARa+f8A4mByoGkSJUEP+OpHeiCIV
	naNIjoltJIXKel1VG3FX3RYcYDYq38RnLHZxQb4ckg0Rp+xpw2P3eqvqYua4R0U/E1zO+ivOQwy
	DL6KLzjm3rCslTGJ5r4kg/VDUTYy4svDPBsEP8Zx1ZIxTnxc2DmeEQhOpIjxxiucFlAnxKF8wIg
	=
X-Received: by 2002:a17:902:ec88:b0:240:a430:91d with SMTP id d9443c01a7336-245ef0d5915mr22618785ad.10.1755678547502;
        Wed, 20 Aug 2025 01:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSJ1H1k68/Z9d58rrQY87Pvbazso9gHhcBZnMUte8gdhBHonHKpDa9vvaIPOQgp3qW13nehA==
X-Received: by 2002:a17:902:ec88:b0:240:a430:91d with SMTP id d9443c01a7336-245ef0d5915mr22618395ad.10.1755678546826;
        Wed, 20 Aug 2025 01:29:06 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:29:06 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:58:48 +0530
Subject: [PATCH v4 2/7] OPP: Move refcount and key update for readability
 in _opp_table_find_key()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
In-Reply-To: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=1497;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=qbiTA97ecG75CN8dtvPjbRcNXFdrEC8SJKen2afmr8Y=;
 b=Y2kKzNaAKkSTFkX+ee44JG1EL0b6zaOZsUtgDls6JWW7HqrCg8Dons6oSWblDqtIqytD7X1iJ
 PylRDO/5ugsA96VHM0f7uTAOTYikgrV1LorOMCRMWAuPEYWHOKoTpC1
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a58754 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Zg3aejBZfcS9hqUhyUQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 1kixyOMjHbPj99ow-zvvgZ4y0N5wdJvp
X-Proofpoint-GUID: 1kixyOMjHbPj99ow-zvvgZ4y0N5wdJvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX3Zqlmv747Hnr
 izQceiBO3ouz/0WeAmt8MlQrjGUeqZwJLYOEJvZetGhZ5duiDte+Cn6XIpsWpltWDHJhPCBxjJ3
 93ZcmehkELSWEs+V/NTfqt1nbWz8hh6E+QBe4gYEKzuUQbdWGWJv7hliJPJvg6G38yj0dah4l4h
 BoNkErdRTX3lsXavYJVP7Ye92EecIUn7y3rHwmnQe1uJyTKsC9XRQr/6IV3AMloOLQ8sMG3jbDp
 BgSwvsK2jlIR9gzXAusS90fo7pc8hFJfZ2e8fqVKigXjrnH+T9lRFkc+Tu0PtpTlc24xkv2sXSC
 5runNe/M6eOjvDcXw+oXwEDFYjYDa6QMLhEWM34O6/LLJlFciRQZVoLGEn70S/Av2hZc1OsElAD
 A8yqbQSxP6kWYqep1/VzS87s4+4a+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Refactor _opp_table_find_key() to improve readability by moving the
reference count increment and key update inside the match condition block.

Also make the 'assert' check mandatory instead of treating it as optional.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/opp/core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a36c3daac39cd0bdd2a1f7e9bad5b92f0c756153..bf49709b8c39271431772924daf0c003b45eec7f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -544,24 +544,22 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
 	/* Assert that the requirement is met */
-	if (assert && !assert(opp_table, index))
+	if (!assert(opp_table, index))
 		return ERR_PTR(-EINVAL);
 
 	guard(mutex)(&opp_table->lock);
 
 	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available == available) {
-			if (compare(&opp, temp_opp, read(temp_opp, index), *key))
+			if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
+				/* Increment the reference count of OPP */
+				*key = read(opp, index);
+				dev_pm_opp_get(opp);
 				break;
+			}
 		}
 	}
 
-	/* Increment the reference count of OPP */
-	if (!IS_ERR(opp)) {
-		*key = read(opp, index);
-		dev_pm_opp_get(opp);
-	}
-
 	return opp;
 }
 

-- 
2.34.1


