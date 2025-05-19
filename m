Return-Path: <linux-pci+bounces-27945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98EABBA29
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6AB1B614E9
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07AF276022;
	Mon, 19 May 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RS+YL75N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB097275847
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647808; cv=none; b=VYJWAr5vwN8DI5bd4lBxSq7WU1bVq7dfUCaLFwK8wHqOe2nW46dwVe/c8PrQlAgdZjw+s08Cqw16xwacVTmxHXnPvxeQo0yrOmZlcfqfhCxIQQ/WZRmqZhbStvnQYo6qqxxfApsj5tzd+QuCVi0e+Omfb6YZ5Mc0ONZ8bbGcl1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647808; c=relaxed/simple;
	bh=xsy7qnLw8evkZCbeD6p1+RvCRcE2R11sd9iRKK+i99A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q1I6P0qFnseG93Ayfl2Yaoxo+f8AF81uvWJtq2GTc3+GbkQTSE168gqxNDbOb2EAv4julcdU9h26CeJFsOypECUkilRDsA79BvamQ9tMSvdyjuKL+WvoIY00TByo9o1sc7Xkld2wufDZ4aYO1P5S7bNMDZDKp4QBKsGEVWISTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RS+YL75N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9ABpk000361
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ms4AsHGtqF6++l3IqWfdW5IwKyh+gOLE1wk2h0gxx4A=; b=RS+YL75NsAXYwD4h
	vOPSfO9/6++DZ3QSQOHFI3BvzmyhvOLwftO0SdfpaojVaKKwo+DLzSzf5UAMdrTC
	dVp/5+XMAzkHxzkAIj1asWiL4ieyPHUAmeGaIZeDfdiuNd5CpGhqAF59dl1CJj+z
	3azDRP8Pb6ASd0YVDXk6hRUn5qE4j0ZPh/WvSx3yXiaX569rqAPVzC8FOsEhIK2G
	7kr1WNkoE57X30ufXmItEnIG0xJcM1YbN1b2Xmfz/UVoGab5Khn8c+Q3NHNe8uIL
	DBI+TErcBCECOPK+P5C0pY9oXss+JRRw4c0mPVh1/3mx7xe+sNtVOURX8Q7WwyDg
	d5n+NA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjkykyhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:43:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b090c7c2c6aso2742438a12.0
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 02:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647804; x=1748252604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ms4AsHGtqF6++l3IqWfdW5IwKyh+gOLE1wk2h0gxx4A=;
        b=QsuX0hDVzdWstVjRBSXzsKsJllMI+/UIhWYw2LkLonhHFcrjvABic9FrRLA00goTVs
         l8gWfJOuMqL9kLTbCOI+31jQu3E4kcHuOXMUrpW4Y80GLy800yzlA1gFQtgKdr+K9Uqi
         fdw4OdM/iAY3yVR3In7BzWDWEmnsej18G/vuMNVSSvWSZXx6xssgciH1NuIAEDCFcd1I
         KWDNIMwS0IvLmgg0MbM3PYhHJC0OCN2Q9enWZaU2Wb7mZgpo6Qcgxo0aDU1h264TUX+9
         KJKeRppcrALKDjctS95G0ETZ0oqSHwhadSaM52Eq4f2sTeVdx6dRV+st9KkewKH6p7YZ
         qD4Q==
X-Gm-Message-State: AOJu0YzVsVJFjBcymZyDNQ1DIRKGRIyy77h0fxNPmDtuHe1rcc5J8AzM
	kBYXH4OjzzKI/WZ/lyc/ZZE3UoMJnXUl/oaIqN9qrFo16hXJMANXlnhvRF7VOo/1axRwMOtflCX
	vQDXxxzE8q84V4xvHF8pR/TMIVZ1tgGSQ8DRAMfdFrVojmX4Hby76QPJmajFlTME=
X-Gm-Gg: ASbGncsldI0YHeU0omlOis3v/I4+slsJyS6/dZgmsJqhgxIXqwZzeOMGkvyO482/1rd
	JUA9aEIo6cPA3DxgJKpxZqN1agOIqOM18RWYzCJYHS/WdHN1I8TiQXChKLdfBkQK9QeLAf8gXO5
	cM8Ue9gpkA3lnFmLu6qflZ79LPAPMdcBI0QzlCrrKJ70o/FDCXyAiW6xEpNUzVOYIFpfnjMESom
	G3d0XkjQIIn+GZvNXKTES6qnuaos+jFIY1bLbrlZeNdbJIKg0MB9GHIngT08wmw5T7PqtFbxAmP
	kjPuFUhoqNPSoJmO6ioxFLZXxyLiQus3zjmK0KI3rhAqf4Q=
X-Received: by 2002:a05:6a20:c681:b0:1f1:b69:9bdd with SMTP id adf61e73a8af0-2170ce8c064mr18624930637.37.1747647804343;
        Mon, 19 May 2025 02:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI8bB3sFr0+tAayp3kXPL7kM6eemjerF+In7kpKG9A5RQSxk/YcDRJJ2IJ/dU+O5cjxvqLww==
X-Received: by 2002:a05:6a20:c681:b0:1f1:b69:9bdd with SMTP id adf61e73a8af0-2170ce8c064mr18624902637.37.1747647803999;
        Mon, 19 May 2025 02:43:23 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm5809092b3a.78.2025.05.19.02.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:43:23 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 May 2025 15:12:22 +0530
Subject: [PATCH v3 09/11] PCI: Export pci_set_target_speed()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-mhi_bw_up-v3-9-3acd4a17bbb5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747647743; l=732;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=xsy7qnLw8evkZCbeD6p1+RvCRcE2R11sd9iRKK+i99A=;
 b=RV/zKoNt4pz2Mou112fotyg8c0PTbzunkvtBsWXq2bk893o8qU7lN8dMiEzhxdflw+gCEpJv7
 9JVlb2oi2ZZBJOg4cF+FTL8G8iN1iD4P4HAC145b5z3tE5eyuOK7RZF
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: oF1DdUtaTvOGl6Z4-tfe_59zG7mWLT1_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5MSBTYWx0ZWRfX/+oinxdKceo4
 dtI55nlkicWpoyuata7DSgGlYbsvYwTmYAbFc45wZXqwC+SXuUXwef7A1JFAZGfwnq8CdXecQyi
 RgAFcqaSpV5v7G77RY+FwbGNH4hgNQTQnEHw+1gZ0wzkla+hLQdEnaeNjukJhuibiRHsRSBt8fH
 bDY8cgKLiOEQd5ol/SYs78zIMEXXtg+pDuJ6kptynJznM0ksGhhtqR3JsZG/Q4bdkoiMElr3ny/
 F09UHFuG+Ia3F0Tt8A+CW4azTyZ2YOeKcRYrciWsPcZYK+9JIoVFq78Mq8NjuUoNi/YdfKlPPEo
 tx972Lab0DDQqaWXJl+r9gdzdN+fANL7Bt/9TMqKkR5RcVbkI4M+FpEx4AnwyUzYVvjV3jQumR5
 lASLPwvVfj89lIzmA2Kh9LeMJ7A+4UbN605cWFCzkSCEHUbEVvfLmYXF+FgbYLPaGIddTPY4
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=682afd3d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=JOcJ30pghDwnvxMqNTgA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: oF1DdUtaTvOGl6Z4-tfe_59zG7mWLT1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxlogscore=955 adultscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190091

Export pci_set_target_speed() so that other kernel drivers can use it
to change the PCIe data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/bwctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 3525bc0cd10f1dd7794abbe84ccb10e2c53a10af..02c544c6186b8c6b87730d1c924f07858571d2ae 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -214,6 +214,7 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pcie_set_target_speed);
 
 static void pcie_bwnotif_enable(struct pcie_device *srv)
 {

-- 
2.34.1


