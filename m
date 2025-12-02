Return-Path: <linux-pci+bounces-42483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE304C9BC40
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 15:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE6D3A7FF0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3414A3168FB;
	Tue,  2 Dec 2025 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dfYzBASd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FD6jXe5D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755112F5A31
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685389; cv=none; b=WeVsQFIrPXvw6VxC6jDV0RqD9NRqOPaVJH/8TLqgVxgIQuTxXt/31cn2nwmOjcORWwKW4h3IZbLzfOZASOd3eH5mqiDvRDScqn6tOy1Ur0cPtyNQQWW/cUW6ROdPYHgVtZWr1znhnmiTSSgUHqUHJ3G7ytOE8GJjAZTRiMqO8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685389; c=relaxed/simple;
	bh=5z1ouJ38EhP2+fHSIKbzZu23IGvzKgpnENHaWvqW/bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Meaf38p7HK08WsFj9oFou2jWPbracwLabDsquWmTWD4wqfCvJjtjG6as9fG7b6OSZ+cvEKQ95W0xeLZvQPBrbwFtn6ukWM/59Mk2ExTWWDetCop+hhIvf6+DEdhp6nPEtWgQQLE5nC9KT384bb4Kq+F59+j7F9TENSErhCwijFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dfYzBASd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FD6jXe5D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2B5AQJ3311173
	for <linux-pci@vger.kernel.org>; Tue, 2 Dec 2025 14:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvDGlE0S/6XgEh4WV9txDwLAXqVJ3Idv7+GFUaC/Ruo=; b=dfYzBASdItj2/N5g
	0VnEqjooYOUbN8kLHVQkeLPtWK67g4wWObSjH8kw8MlGDqBwxECuOXMp146ATx5S
	9dmgdEazvUCvGPzV4O8ImZXhy2KKgiNz8b37DCE5ZUiCd442ejhSGI+WtgrHtVdi
	ekiUpF5fb7gdwFR4gMvZDXai2bEdkPnIzPk/kaohiCLbXzt3lszqz3R2vg+HnIT9
	bDve1x0RxRYJbjUyEJ6OD7VTQ49LU0ozA4LxSGMGcITqc6W4w+CKLi44JhFIzQxA
	SFEsWuETF8bv8x1OPidO9G+1lGOEE2+XkJqA4Jb/m3tkyLTQnpjVTm8OU+IyscY7
	uiYLdQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asxwwghrq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 14:23:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-343823be748so5049454a91.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 06:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764685385; x=1765290185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvDGlE0S/6XgEh4WV9txDwLAXqVJ3Idv7+GFUaC/Ruo=;
        b=FD6jXe5DAm4fNjx1LBcv5M7H3ML6DPzN38bVEyv7Xw/UCMnGAW63drv0KH3tdxcPFh
         QQd1zPEadHdwPhHNxt0GicrXvNdkch8A0n872JR/nGnvBc6SKyE8Iu1+4WKobJdsufuN
         /8Nf4btBLaI6Noub5DCjN96erXPZ1V45E392zo76KYUZQH7hbtDO3doHI7YyK9GgY5WA
         iKUApt20SP68UbYydBhzHFwZo9WlaP3i0+WZwfhrBvTfUI2NtD1U8kLoaVP2+jQ+mjoo
         s5CGa5vJRVrhp7TuoJYAQTz8172IWorDYDMqV9M9GHJwlIp9xwzL+iSskrJ4+ugyqhf4
         cmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685385; x=1765290185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pvDGlE0S/6XgEh4WV9txDwLAXqVJ3Idv7+GFUaC/Ruo=;
        b=n7CH1VL1I0M/i0DZUzF09gYV37mg8xS+T/OvHCqDS+CVPew1HdX5k5q/WSscpiYVdH
         qDYypExvvfWcX7cBg1WNX9qia68meL96MHyN9JD3i5/CVKzS3eKHnMiwNYVBf+JTkU7i
         UApTXg3J6m7lk05e4qtX3B2VuyUhzL5XDGvwLEvoc+5ANCQU+fJ9eT/CrTh44jnmpUhW
         XFLTjlXxtje9gCeyk+2Y2bHh6IYNOH8L4K/YV1qzHnm+NyR7T1hsti0iE39AZng7ddPj
         S5LZYCKy0QaIwIfea4TF3uo4L/ACSzdLO8y1StWitEUvtuaam8Ek/zk5+/CiBL5hTTY6
         vxNg==
X-Gm-Message-State: AOJu0YyAsWIpZ0UPq6eDFOzKJTc9LMHH1vR3Q/B1Oww3a+O7FTlcZccy
	8SKMdkxa3oJ0R7qtiY15o6VFfxjjwUzU2o0uFUS+Fip/fceMYsNSoJmp8OENVq2K1oFuZvAWrq8
	I9xZSe3NIueVok2J/MEs3RCcKiQRDUG9fc5EY77cwYFSGgzaOTQydKiX2DikgumE=
X-Gm-Gg: ASbGncvYgzxieiIgRWMGjaFbkjlzo24SJh5MqVWIaQVaualORQscODxIqRvPbe7d7BT
	gR82LLTVnfav6FLGUtoXr2PiRt7u9p7ac++FmAfquYi33gVBD20C3SEecw5vlI+ePjzHrqxqc8g
	Epu9AmW0UBO4W3wobJe7B+Qn67pC/bQ4lU2ws5ceqtL70QRIBSLGSv7Ae/nlVdd36kzv6lRFEx6
	rU4gucrVECunBiRIN6Pf1ok9u1WBfmjm+T734LtMYNhQ+GqHKsjF056Z5jLxzZXIFv0astfp3G6
	NEM6odRLxB4Ef45+JD+uNamCrUOPb98VlaC8H5X9HWB0FFNNhteaaAwDa5n4pCmWOzsn2NULoOz
	sinpSZxVwMuWnwLPWxT7SwxKggDnurL6nIPlqNBw=
X-Received: by 2002:a17:90b:4c45:b0:341:3ea2:b625 with SMTP id 98e67ed59e1d1-3475ebfa712mr32702726a91.12.1764685384951;
        Tue, 02 Dec 2025 06:23:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcAutCfpDdRSSnk5MniXuwtr5pZ1zGjMgaerjI8XmJ3h8BcgaKPJR/IPoENuE65rkpJv7/dQ==
X-Received: by 2002:a17:90b:4c45:b0:341:3ea2:b625 with SMTP id 98e67ed59e1d1-3475ebfa712mr32702678a91.12.1764685384366;
        Tue, 02 Dec 2025 06:23:04 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a4821sm15659084a12.29.2025.12.02.06.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 06:23:03 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 02 Dec 2025 19:52:48 +0530
Subject: [PATCH v2 1/4] PCI: Enable ACS only after configuring IOMMU for OF
 platforms
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-pci_acs-v2-1-5d2759a71489@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3924;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=5z1ouJ38EhP2+fHSIKbzZu23IGvzKgpnENHaWvqW/bk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpLvZAK0KxrEsmvfHKka+ak4tP+Htq2wuvd6IOD
 Gb94sH+n1eJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaS72QAAKCRBVnxHm/pHO
 9TfPCACbwfeix1zhTrWBa2NPzMJrnW85zmPWFT/Qmgjv3jGIXa9W0UdmVZwtwyn5nzAQ94sdyrH
 zA7N3Wps46qw3ZGtdl1fwzu+dZNkBZnD+3Kdx2l9texP7AIR+FWTZMg9mtxABxxAf9JGLpwJSz5
 hezCe0rymO+HB8nl9ehmsnUT6WSnkFoJ2JFixPOCg1X42VOyv5XibQE+X+j1rZ7OQLL0lXcghQl
 b9M7RvD2fs+Qil4L0S0QkZS+5VLJQq4+2dMy6gMWXiTZQ+IgifVXwv6sPk1sVXzpFDf4vDQGN34
 TA7JCsA5LTM0oCeKOSGAKgwvOIhdnVAZ+I1cMv8WWSgV3N8I
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Authority-Analysis: v=2.4 cv=JbyxbEKV c=1 sm=1 tr=0 ts=692ef64a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=8ziBJk15IZ5r+wOU3RLduA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8jBi6dqPNo5Cx3X94iEA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: oHkfFsBrXO4uNdfJLyOrBmGFwFCh9k9m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDExNSBTYWx0ZWRfXwVTbIOogldCn
 Rglo1kKtZnyDx5mqbmAwGLmb0Q+XsY15ZVRRn1XRAiOgPGrMh8VXvg7chxEY5FmN4s79tCiN/3C
 EtB+AI6CGpb4cZox/Cj3C4ZSEia0MVPIGvyq0hAooJGZKrkzB71J5i5BIFgfM2QN2EiriOHVk04
 r3jYYfH5JI3yBGMjsGg93/ul/ioREWGT8CosDcTmSd8jkDKb8C/gRENDOvZ5ubfxXwopSh9dInQ
 jMNAqmSBre5gx4an3HV7zDItLGUukizbhJhiNf6G8vVadfnvDSNguJCqRDw8SPc17IWqSq3lV2B
 0TO/kluQIqv23oG/ATdqvtyeMu3c+VoBiuMETYh27IffS4WQpyCBChDXVDwUUOOT0IK64Yby1LC
 UG1np+k1F1ReGkM/ympr9SDPW3I7fA==
X-Proofpoint-GUID: oHkfFsBrXO4uNdfJLyOrBmGFwFCh9k9m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020115

For enabling ACS without the cmdline params, the platform drivers are
expected to call pci_request_acs() API which sets a static flag,
'pci_acs_enable' in drivers/pci/pci.c. And this flag is used to enable ACS
in pci_enable_acs() helper, which gets called during pci_acs_init(), as per
this call stack:

-> pci_device_add()
	-> pci_init_capabilities()
		-> pci_acs_init()
			/* check for pci_acs_enable */
			-> pci_enable_acs()

For the OF platforms, pci_request_acs() is called during
of_iommu_configure() during device_add(), as per this call stack:

-> device_add()
	-> iommu_bus_notifier()
		-> iommu_probe_device()
			-> pci_dma_configure()
				-> of_dma_configure()
					-> of_iommu_configure()
						/* set pci_acs_enable */
						-> pci_request_acs()

As seen from both call stacks, pci_enable_acs() is called way before the
invocation of pci_request_acs() for the OF platforms. This means,
pci_enable_acs() will not enable ACS for the first device that gets
enumerated, which is usally the Root Port device. But since the static
flag, 'pci_acs_enable' is set *afterwards*, ACS will be enabled for the
ACS capable devices enumerated later.

To fix this issue, do not call pci_enable_acs() from pci_acs_init(), but
only from pci_dma_configure() after calling of_dma_configure(). This makes
sure that pci_enable_acs() only gets called after the IOMMU framework has
called pci_request_acs(). The ACS enablement flow now looks like:

-> pci_device_add()
	-> pci_init_capabilities()
		/* Just store the ACS cap */
		-> pci_acs_init()
	-> device_add()
		...
		-> pci_dma_configure()
			-> of_dma_configure()
				-> pci_request_acs()
			-> pci_enable_acs()

For the ACPI platforms, pci_request_acs() is called during ACPI
initialization time itself, independent of the IOMMU framework.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pci-driver.c | 8 ++++++++
 drivers/pci/pci.c        | 8 --------
 drivers/pci/pci.h        | 1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 302d61783f6c..a4ee93497a06 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1648,6 +1648,14 @@ static int pci_dma_configure(struct device *dev)
 		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
 	}
 
+	/*
+	 * Attempt to enable ACS regardless of capability because some Root
+	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
+	 * the standard ACS capability but still support ACS via those
+	 * quirks.
+	 */
+	pci_enable_acs(to_pci_dev(dev));
+
 	pci_put_host_bridge_device(bridge);
 
 	/* @drv may not be valid when we're called from the IOMMU layer */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..9f594fc6dade 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3677,14 +3677,6 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 void pci_acs_init(struct pci_dev *dev)
 {
 	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
-
-	/*
-	 * Attempt to enable ACS regardless of capability because some Root
-	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
-	 * the standard ACS capability but still support ACS via those
-	 * quirks.
-	 */
-	pci_enable_acs(dev);
 }
 
 void pci_rebar_init(struct pci_dev *pdev)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 36f8c0985430..972b28fc5455 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -917,6 +917,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_acs_init(struct pci_dev *dev);
+void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);

-- 
2.48.1


