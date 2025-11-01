Return-Path: <linux-pci+bounces-39992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE29C27735
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 05:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD9A84E7F92
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 04:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A127B19E97B;
	Sat,  1 Nov 2025 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dzTVcveU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lv/R3qTL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798B26ED32
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761969605; cv=none; b=J1BpW8wTfi5RkhtTwlF+72VoGppfvpsVgxDcylF9EhL727vH+jIfnp9dtIYoyWtYwpEPLsPjcsqAH/WEKubcb+FSATVHG3rGzTYLs82X44igUKpko1OJ6nQRWapmyAIveyNQ5deHxougjtq4JFjxzC2G7RP/3IA/GDlD7F4nSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761969605; c=relaxed/simple;
	bh=Cpg3+E+77cgaN8CmBzJQTZxMkFdRoEwVVkKgFdeA8+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lhqxq5IAQIJzvvyXLlJUwvOBBlIvE5fmlFaGbX7/V0TNrw2OceCc8i/R6HsaqSCitWRHTtdxIiwfZ5hD5I2+RH6+eEscbNnPJ2mKn573qVypa3T0GLz0pWbs+mDE7d7bA7cl/PGx/IR0rlSopR29iqN1ZL619qgtxE3BnQrHWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dzTVcveU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lv/R3qTL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VHfdCt898728
	for <linux-pci@vger.kernel.org>; Sat, 1 Nov 2025 04:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GlcIk8VGLe34WMvbqxhiaOvLED3wY6vnyW7vFGcSUZs=; b=dzTVcveURJ8uBolK
	OOSdkNSFIcfNzfZcHSBI3iIdy2T0b3AgjykcvGapYMMp+g+R9Y+beeKOd1qW/yOE
	fraeZF555tJibJi9Z4xAGGQzrxQA8CO5I8xgNd8YWMeDFjWeckaUeRbeysvL0Ku3
	mKXGgfh34vpuPijRz5HPKkkmkZr0vACMlgoKH03F+nYqT6RIcBGi6cYcU6MhWcuq
	wJgy4rSI/MpZElbAEix1nrQSXShKSc1PqxbTge8gGOScsinmGlAIvTReg048ky9M
	gVBYOx08K4hZTyoUOzV28lK0NR14gG3oMVpWDvRKSort3seeCVbYrU6BFQ5N0pBE
	9XalxA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb24149-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 04:00:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29554d36a77so5175345ad.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 21:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761969603; x=1762574403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlcIk8VGLe34WMvbqxhiaOvLED3wY6vnyW7vFGcSUZs=;
        b=Lv/R3qTLHtplkj08Zv6o2y2cKofRedW0+ESotJxMcJAUfC0H2WQeKItIPAl5hZP8WZ
         ZtebFiQ6t+j/tRInF+bA6bIUst8YewNpaV7kSDC7HtgKtkJGo1tjjyWBhoRcetEb7PNv
         w/vbhVO5kt/VBM2heKduj1EISd4VxnkjZI97iDzmV/xUSsVzE+CDK8e6b0pnVDP6kb3i
         mjZFxs87IMXRyVLWizCUgTSsxhqYDyMPv0B5ZZKTAbVxwichg9QrcXQeRy1SV74a6kh5
         NPbCPJ9qsWH1j2N+LXfuLA62u/u0HpETJ1fb0t47lGZmkJaGg17OZOfuFQ1ZiOmx4TPc
         SdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761969603; x=1762574403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlcIk8VGLe34WMvbqxhiaOvLED3wY6vnyW7vFGcSUZs=;
        b=IRgO6FWC5yeQO03hZNaBaeA/BJN7sIqRCO/C83U0OCvnRjfhvvhQu6O5CegnK39Tmt
         D3fnWHb4//B2QCwCeN4AOrKBXz9tMh4fFejaxT7VFdH5KgBY0eCnIk1qQU3uQo/GZrbY
         l96dhN92wmUarGPQN91QOkIlOMXw9SXE/BUIak081nUTacJlFnzsU7qM2OWcGIdiL+/A
         zuC8VHz9RgTwaZ4pSVTSrl0Bcwpy+EUGkHbVP6J0gKtUmJPssvNB1dwqjlVPxh6NGUHx
         2biQ1wurWrnP90WUSKUASrctQqmNwF2MaECl9CV9kgY9vVEYhomRGmwqD3o96GMKY396
         usfw==
X-Gm-Message-State: AOJu0YybeXUmZ4xmcX9+XVhgWz7B4UDW5mx3O8MmAHL1M58LmFH97I8a
	g/dW/egojHycjDchTtGM7nv908Ga/ra5dPgSrREqcNUxGPIlt2iPPDB/f9vrJrK4PaDslYcMuB6
	dS3f/I9xmoIlpTd4pB9EoTRNiSre3lsICa12W6lYdP7eeZ+kZcsOELtxtUdgg/z0=
X-Gm-Gg: ASbGncvaI7dvyRrmwlMrY5C8z/vNUMdXGtQHLNYb+Wmv5il1aXU1haGJPEXV+wrMKdm
	J6ivBTAmWdgM8MFxoZmyjsjsUFICNaC0LZ/T8fAp9NpIQyZTnJ3u0OWx7MEYfkcQt/SPpPE35k1
	XwGZKlnsGCpfeXa9XAnvcTI0PX2YHTqj1WUPRzpj28rD9i70Nq23AEMHV8v+HXQ0NhXJ/NjdVBp
	7kze1kAVEoyithngKh9hvZ8YAlKCXaU9yw8ecsRvlnPEX+GMHZcmF6ZjKvUzG5SXZCprCVtkCmf
	dDcZ3H2njQ5idGyU0rXKF2Esc6qD0deipYWMkIFBcq7AAoKJ8e4Si0uw8tZ2j1r6TWpww8vHxUN
	wBMjpZNNzQqO0ZjYAaQbc/Bzt8LzSWbFa9A==
X-Received: by 2002:a17:902:ce91:b0:295:4d24:31b5 with SMTP id d9443c01a7336-2954d24341dmr27202545ad.26.1761969602744;
        Fri, 31 Oct 2025 21:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnujD4KfpMKIa1jbnip3JbXoF83Crapp1dKuTRMgwycbHmlRZs7b7Qay7n+31/vmIdwou0WA==
X-Received: by 2002:a17:902:ce91:b0:295:4d24:31b5 with SMTP id d9443c01a7336-2954d24341dmr27202175ad.26.1761969602200;
        Fri, 31 Oct 2025 21:00:02 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268717ffsm41490725ad.2.2025.10.31.20.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 21:00:01 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 01 Nov 2025 09:29:35 +0530
Subject: [PATCH v9 4/7] PCI: dwc: Implement .assert_perst() hook
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-tc9563-v9-4-de3429f7787a@oss.qualcomm.com>
References: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
In-Reply-To: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761969577; l=1221;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Cpg3+E+77cgaN8CmBzJQTZxMkFdRoEwVVkKgFdeA8+8=;
 b=E/GibS1CySbengy4S+tVaLsYBBBEbb+oHQBsSpYkwMFpxOdh2BPROUZK8Zfy+jh1PyWjjMkpo
 C6wCyo30DSpAmHjbtYN79LvxVb7VI5uZCP0EY0r3zi1L5PJ1zPHTwUI
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=690585c3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=dSOQ3hK3KXaY1HoqDbQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAzMCBTYWx0ZWRfX840y9hgpB5pf
 8WHMG5h9a50EgeYFCIRLzFmxh+nJncX3lTHD7NLgSBQid8J/hI4KtyKWdzg2JzQKxNB5ON3DRoR
 c0AiEYj8/0Gutis9u8Lrke3crX88tDsOLIPOYuo8VXguMZB8MzxdN/w4rWjWFHFoYsSwf2FjIzU
 r433aBiWZUYY3Qr9Sx6z5he8/Of/W/5WTYdCa+7llnUbNDIaiEtk6fygf6MznOMpBef1Vnmevka
 l0B6M32zqKVYHeeD1jIvFEOIMzVAzoDvJkMer00pT93NDQsIlbFxXSe1IneoF07dx5nnOx/lgjq
 035iu5xDC0dAxepDaB/2rk9et/z45yQYwauk0jKxplI5PUDurCxQqJHIyquqEaNuFwBHStz05uk
 Lr81wohm9d9T4PPYXjcptLsfRR2IUg==
X-Proofpoint-GUID: Ejw-1k23mkGbAOGkM_GV18abrpsPScVV
X-Proofpoint-ORIG-GUID: Ejw-1k23mkGbAOGkM_GV18abrpsPScVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010030

Implement assert_perst() function op for dwc drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c4812e2fd96047a49944574df1e6f..b56dd1d51fa4f03931942dc9da649bef8859f192 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -842,10 +842,19 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static int dw_pcie_op_assert_perst(struct pci_bus *bus, bool assert)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	return dw_pcie_assert_perst(pci, assert);
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.assert_perst = dw_pcie_op_assert_perst,
 };
 
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)

-- 
2.34.1


