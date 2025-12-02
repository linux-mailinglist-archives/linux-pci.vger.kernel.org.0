Return-Path: <linux-pci+bounces-42486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8EEC9BC52
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 15:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0274E3490E0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3E1325731;
	Tue,  2 Dec 2025 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NIdvMNWc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CmZpTjVN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F232572D
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685400; cv=none; b=YFi4stwZNq6dzjiSH8e4b10vfBXBO/9Sob+ESiGT9wzEH3MvUaOPTvLqMaexHkUY8n1643VlverXg84qINChyq/CxT48d7hljcszNV6+yjkRQny0pxbT++LPS3GL3AhWt9TRb+07LHOavQTLa5G6nctyG2BsbyUVYAs8A7nz9M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685400; c=relaxed/simple;
	bh=pRTmIB6LMS2I/NMlLkQVrAoVSoFyYgoyBRTO1H+wJzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtLdlSFIICy+yIgy04g01gpvYkMJO1KHaNTshOHmF3rL78+qR1xB+Ae9d1+7YVL2mvtHupuSXuI9LL7ML0Yo39nswHNQwZJkLWJpdYkHHB2Oicg1hqQAL6tw0NjwzXf9luGS12x4OWdJr/hqlXZeoWR35g+txfy9aR2fZzJ/b8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NIdvMNWc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CmZpTjVN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2AVdH03660575
	for <linux-pci@vger.kernel.org>; Tue, 2 Dec 2025 14:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QIIBjNvOJPz0nM8jdNic3VTJoyxgBAw5GlTLZa5uxBY=; b=NIdvMNWcCR/aQmkb
	MqL6WBVnr3oz06JX+toYuEG71wniyOjm/mZRuSEixxKK0NTD4lovOmLzdA2HNg4o
	obDxWEAPmNgGORQxULkxRwbIq/o2KKaCkfJv+pBVXCnXQ3aDnA0/oWMMSSv647Tb
	TMfIoLmMGfC0xtPkQHubK1Tt/CyvE5a8ogIPHUh1Bu9jy1OCSwT2upFhJwxVLm40
	er4qLIgumDnxyrOMXcpG4a6haiY9LkPPr6qSzNTi8m/fsx1R/ADboncP+74NyHlq
	Xq6k85ebm62SdkMzvr5prP7wuY1xtC6YEnkwGBSFWfZMJ0CmmL6kGiuYSSmryFGj
	Oeo8ew==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asxeegnsv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 14:23:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b4933bc4aeso4337547b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 06:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764685396; x=1765290196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIIBjNvOJPz0nM8jdNic3VTJoyxgBAw5GlTLZa5uxBY=;
        b=CmZpTjVNk8AWdYF7bwFSKJRJnSmkwdWNboi7vq+X+H+oWUkPf/7eiaBme6iL0evxdI
         EVHHm2lDcpY+zpMGJ9QbqM+cEG9xPRGn+0CoKhDaVHT2Pm396mwLypNyRN10e1ApEyr5
         qnTv92YHeGNa+wQGSgsYpQHaNssQk5TqR99kxMWoAov0SLLAsg6NuDhmFnji5BptJdmd
         ZEeOZ/WpxDV/U614ZmtFGx4rgF68Gr8F+8OZHTnlngnMBW/XLT3PmQaxKm3IY1GwZv/t
         LpLe2RybGCthll0An3mCSXy5gt8N2lx8RJEOaEtkB6BUpzRVbP18rsgc32l3vsxNBJCc
         SiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685396; x=1765290196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QIIBjNvOJPz0nM8jdNic3VTJoyxgBAw5GlTLZa5uxBY=;
        b=sUiCdZtvpeKVZ2w/HJSf7oAENWKOsWU7plDvyxbOr5FUPsFa3yzapbS4AFQKcn9Tfm
         GUP2NpdpTZRRVRk7ifxKy2oTLPFGKKX7U4FfGf/d2sZtuHMyNgXVEueG05+8I8cBtIbe
         3ru0X7OxCs5ZsjQ8CJ4DFGave6t5IzlQUhDUh8DwCjU0qxpFOtJsVAjiOVupNgUJaGxe
         xhocCnJDfRANIdRbDpr7KLSScYDV9RSfjI1fOeUNE2YjfQ2qer7P66n46WjWAG6YaK8e
         UJKKMDziqv7i5ER2/VVeU2k84Ba8j2yy5rcW3lywVnVBQQgtAkvlw34q647GZUZCsg2u
         kS3A==
X-Gm-Message-State: AOJu0YwwZJcZ4r8GjdnRB9Eid3J1IadmUnQsJC3cD460wdn4q1M3Z4sy
	x2TBVVEFsfiqufF2+2rpmRTMOdhSugbu+0sGDyt3MqZtDXnbwM26RSMbGHUfy50IqHixjObiHmz
	dwui8D4v1wSgOj66zAIE8s9UX1qCyb1+GeF+WPGylHFmmEvvZC7KE3FHPBx5wkmo=
X-Gm-Gg: ASbGncvoCNIV0hod9/dKRm6BM4WWZ5ZPE2Iv+2q7Hkil+LfgD7XvPGR9QAaMa9dbHpT
	l3KtmD74UDzZ/iX4Y20uEkPByXztlQ/OSTanAJXBSETPwA50GU04h0KvGi24CAtnDu82OU+oZLV
	FzqXxNJJblhoqk9BdV9V88FtSjLnpRNkLLY1pU7XqL0mdZo4PqkcpbHKUPIlW3goE37vAlBSSOQ
	w1b/2/kWAYh2+ut+lkjs4310XFkLnLp7b3wVCWJNV2HIyJSGFmRfkvML1ipGqFJ7FFMNa3/MwTj
	KsSIviCC/rSWAfIa3QoIqBk3wNHYn8tP92TbG7Vu1YvV2kLwodqXf9KHbVxqAdo/RxtYprFpWG6
	ejwmJygQXgkg3MdEyrXokQv9zOu+Wp0+z5p5WiZU=
X-Received: by 2002:a05:6a20:a125:b0:341:e79b:9495 with SMTP id adf61e73a8af0-3637e0bd69fmr31557248637.54.1764685395928;
        Tue, 02 Dec 2025 06:23:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXg3DjQM/4ZIRpcDRT/tJi4qz/yVH4IAtQoIwviN0V/oe5Yh00yD0sJ44YqA3xpq26CgNZuw==
X-Received: by 2002:a05:6a20:a125:b0:341:e79b:9495 with SMTP id adf61e73a8af0-3637e0bd69fmr31557219637.54.1764685395435;
        Tue, 02 Dec 2025 06:23:15 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a4821sm15659084a12.29.2025.12.02.06.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 06:23:15 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 02 Dec 2025 19:52:51 +0530
Subject: [PATCH v2 4/4] PCI: Extend the pci_disable_acs_sv quirk for one
 more IDT switch
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-pci_acs-v2-4-5d2759a71489@oss.qualcomm.com>
References: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
In-Reply-To: <20251202-pci_acs-v2-0-5d2759a71489@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Xingang Wang <wangxingang5@huawei.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=pRTmIB6LMS2I/NMlLkQVrAoVSoFyYgoyBRTO1H+wJzk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpLvZAherrBpCOwOposcs2baS4ADrcU3EnqXe/b
 RPhSEm4to+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaS72QAAKCRBVnxHm/pHO
 9boTB/4mlbW8TW6gVy8o/sK2KC32UFLRsRusBG+Y5HF7v5PnfVZjhehuZQqeWahB6SG8PnCnNMw
 p1vnghlQYA6p+k9uZBX7i8lvjrTHSfECP81eQX6mOTdd/SS7Q/bG5VkaSdJs0G0BmKOMonBiwCo
 tkJc6Bw58gWszhaKmKiioql2hYnCu1EZ/DL3tkCLQmoDdOXfdCWJB2TLgRnuxDZQYyTXQGMbKmc
 RHLwb9U9uX0DK6GBP9dlHYIq3XgDLJQ9F3sljaBUPu68lnZhQ/TJblV9XocY82GhQVbw2y5faTh
 f9OgdJktdiR0udcHpUW6jMF8aNAtqmC9uRgAr4HYTy/yvtS0
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: 67smYM5LJKGJYZJhkVG5t5vWRKp881W9
X-Authority-Analysis: v=2.4 cv=TMRIilla c=1 sm=1 tr=0 ts=692ef654 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=8ziBJk15IZ5r+wOU3RLduA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2xi2RfK-dtapqwj757MA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 67smYM5LJKGJYZJhkVG5t5vWRKp881W9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDExNSBTYWx0ZWRfX9N/6e7CaLiuv
 3J/6w02dEhxdE6RhhDWxdF6adq0mBj8DFYImAN/d1hfqk+bV01RNz1vaU0iwmQvshGfQxaLW3cI
 AL+X28bYhcZtRTgpG8FSdW5EQryqYBK3LcVB9CutxMB9W6KIqyE2LJg9XXoQ4dw0jD6RMe/XKiQ
 OcHaqhieVE7R33yVVI4EFagHOgeVwB3iIaOLOId00EpfX0X8XqHYR1ZO+WCou/LadL43gsDtoRF
 tWT8UqgNCrYenkGJ3mftNVZL1wyKUdYkQ7tNydVfTO0Kud+7PsxFb/ZcKPp71/XK/t4gdSUxuMc
 5QhSHX36Bem/9gc6Pzq6cfaOTszulUQppWSOREHKoJDsEC35X4dr6lmPPaV4kG4rVXpelKu/FtR
 1kILahII7hjdgRCNcwjE5x3IjRrTLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020115

The IDT switch with Device ID 0x8090 used in the ARM Juno R2 development
board incorrectly raises an ACS Source Validation error on Completions for
Config Read Requests, even though PCIe r6.0, sec 6.12.1.1, says that
Completions are never affected by ACS Source Validation.

This is already handled by the pci_disable_acs_sv() quirk for one of the
IDT switch 0x80b5. Hence, extend the quirk for this device too.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a5956726a49f..314aacf5a309 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5798,6 +5798,7 @@ static void pci_disable_acs_sv(struct pci_dev *dev)
 	dev->acs_broken_cap |= PCI_ACS_SV;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IDT, 0x80b5, pci_disable_acs_sv);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IDT, 0x8090, pci_disable_acs_sv);
 
 /*
  * Microsemi Switchtec NTB uses devfn proxy IDs to move TLPs between

-- 
2.48.1


