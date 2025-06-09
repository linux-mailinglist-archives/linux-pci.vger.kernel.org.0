Return-Path: <linux-pci+bounces-29206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42727AD1BD9
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 12:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4017A60DD
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5923256C91;
	Mon,  9 Jun 2025 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OzEaZCQR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F023256C79
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466307; cv=none; b=uEJ+345ZEOmiLyjkLSbpNAE7vGttJAFB6uPdaUF8s3ZFC/1eAsQo3ldPgtCgFCQ+KeMDpAUVTrL0gyWg6lTxG6tv5x7lrInNNSJs2+2MXv9XgILvaleYBnLuTbOE/Cg3j8zXrTe8Hi2iAksBXxrk0n2ar4Zuviitm2kd2FlCW6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466307; c=relaxed/simple;
	bh=s3BgbObr46Znv5BUzFNNNM+2F0k3oFKX2PcPm3YAn5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqpLxyw8s2dRISWbcCeJ3zA8kIht7Psxs+kE7ZtSHA6DU24G6gtOzZHysIBnri1BbeWnTqao//KIYXF1Q1WHJck6xeHG8pH3SI0uDmjp6mhRraLiuIwGx2Mdmw/Td7gsXlqXtEDAlIMIPy/DMkHGP3Ww/Zp+79EUMfpt4CG0dtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OzEaZCQR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599dHhZ000483
	for <linux-pci@vger.kernel.org>; Mon, 9 Jun 2025 10:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w7A6tRGMDv2qa8hQq+J0NjE48UHIfnawBC6GPkL/QNI=; b=OzEaZCQRh5beUg2l
	57uAEDGAK6nHLFQlooM13k0An8SFSSSGT7k8kkNIzAwc0Nv525iQDnxT38oGuY54
	BBw3J59ZmaivQR+F4t0OiTyDSWhAbVtkCZIRU0ssAN0eNYG4JBI/owGjBUhwhSe4
	cZlln4K+91q9uGj+B3GC01j/QzwV316vrqzUrV2O7FodsfvToHgYUQeBzkUTWsrU
	x3iN9YDBmVyS+Xceb3rZf4Z8VgT1JMYasVfEb0SfSS8o6i0p3yzml4U0/AFNZj44
	CnFYC7HokpxN8k5FdlxfXixckwQXNhb0OCm4biOJd9u6XN2qEJUMs6eHan6t+Qxz
	vTnFAg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475g75t1bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 10:51:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235089528a0so42467065ad.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 03:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466303; x=1750071103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7A6tRGMDv2qa8hQq+J0NjE48UHIfnawBC6GPkL/QNI=;
        b=RxEtcqxElCmXRoui2Jhvg7J/f1AD6cX9Cg1BFgaKJEmEW1ZNEcACJo4Z92Zcoa9MRp
         HtgmZSnru2xpgutwXOclPwmB9M/ny6ICERynEsevkZOAllW0dq9FgYqQAJObB3XVWZoj
         KQN/6WJ1s5g35T9HS9jalgcymF2jTRgtNELuWxqkMctHnVyoR8Uikq9Ra0B8j626IqvF
         4mAEZX+EGbqW5YnZNjgJbIZrhHGxdRIia5QxWtPmb9FFENKoz+Q0N3KBuyyWEPnAplE4
         RrVTr6yNscG3BObCBatSUTD8/pugFYR9X2Xe6RfWzg/Dzo6ISsD2C9x7a0wKF61PzQBT
         ab2w==
X-Gm-Message-State: AOJu0YyskLUxREI0WLMqyfvrTrSoSvV8r2YSJoq87XlnzDcbdy0Q3s0a
	TGbJL42TnPqHW5VVN5SWGShdKq+e439zHvQTtirtB1jpI11WX16o+B8lWQr17HRD8dITNXBWur1
	WRLc20M1+Spkmc258XuxtbilUHXnXaDYCivPrqBbMARg/iquhq8PEzmUnvyTRtDQ=
X-Gm-Gg: ASbGnctmPswe5AYIgWDinllblhs7yAyUWVpTzbfcvv+M3JxCrHPGkpncHhRXJci1fes
	XLbUrGrxNf77LKFRXH5yrstrdr54GCWhCWKRSt2Yiz0tuzwP9LigEqG4yTcva8Rf4A3+yMuAOws
	8rrWvza1DYpc7EQtilFMs5IpPR3G7Wf+6Fge0lMfrUyoXO0xhATa3J82Qa98oapAIehccQU67Yz
	uWh3+IAf71lZ+Gy4/9oDQI/8Rr4Uwygice2J8utA3uKm37GL6TaL9lrCW5XWqvzGgJut9PJVSgo
	9K5fKAQJQxabIFfAWr386utHf1kxlwk3avN5H3Bh0PyElgQ=
X-Received: by 2002:a17:902:c941:b0:234:986c:66cf with SMTP id d9443c01a7336-236020d715dmr193522725ad.16.1749466303527;
        Mon, 09 Jun 2025 03:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGLzOtRKOSJqf7NTxp/jA1tIZZWcn7SzcOC28q5ajezBWgKmY9lqYSDR8i0Dk7f/REuQx1ZA==
X-Received: by 2002:a17:902:c941:b0:234:986c:66cf with SMTP id d9443c01a7336-236020d715dmr193522275ad.16.1749466303160;
        Mon, 09 Jun 2025 03:51:43 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:51:42 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 09 Jun 2025 16:21:22 +0530
Subject: [PATCH v4 01/11] PCI: Update current bus speed as part of
 pci_pwrctrl_notify()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-mhi_bw_up-v4-1-3faa8fe92b05@qti.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
In-Reply-To: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=1335;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=s3BgbObr46Znv5BUzFNNNM+2F0k3oFKX2PcPm3YAn5I=;
 b=ZfB1rQO8asuRz4N6P4tN0plpJ2JrMF1tt5D4/AjjMGr84OpeBvswukdYc5xJoV20WCuxq+p/5
 w/L+uUEC7JdCs9uZ6zUtriA3WQtBD1w122UYq7IZ4ufsrkQ8qgVr/cL
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: zHzmBZnO7GR8VhkHAM_a4lStBGnuAfzA
X-Proofpoint-ORIG-GUID: zHzmBZnO7GR8VhkHAM_a4lStBGnuAfzA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfX6xG+5/IniI5I
 Spa5+8Pn0jKJUbS7jtgjCFw/0WSq+k03FWlA7X5LOSdS0/N7XEyCCtZiVNvSBnpIp48/CIGSdJO
 fTXo9w3bD5hduCfog1Jk4mdZLVZnegV0Q5p4IAiT2cx4F7u297bs56x5ZqeWah9ckI9dTgtalEX
 UoGbxH3/1awvyxa4gzGQ9+A15RPgIripdGFP3NcmeAl/fQnfqpeEWTFg//ct9ROVmsbg78WkGLw
 ChkT1mvnWxZOyVJ+QnJTK8MFA7HMSqIcx/98m8rcwraL7usvU149tJy4+0QKUJgb7nv8gXLNQ08
 Pe8RQKXkLxi1jBz8S4FET+xlW5TPuetofZCLRr8B/PAoA9n0QDCBXzqwdOX7SGmB1OMVXmAvUSw
 XjzVHUYL6srqzXWETmKKWT0ohARSa7Ce77K1AgbYMxJQGk4JFT4rRBtqKZCkr6H4vls3zqI1
X-Authority-Analysis: v=2.4 cv=TeqWtQQh c=1 sm=1 tr=0 ts=6846bcc0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=3phiJa3m8EW-4BHYHVwA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090082

If the link is not up till the pwrctl drivers enable power to endpoints
then cur_bus_speed will not be updated with correct speed.

As part of rescan, pci_pwrctrl_notify() will be called when new devices
are added and as part of it update the link bus speed.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 6bdbfed584d6d79ce28ba9e384a596b065ca69a4..4c1d3832c43503a7e434a3fe5e0bf15a148434dc 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -10,16 +10,21 @@
 #include <linux/pci-pwrctrl.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include "../pci.h"
 
 static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
 			      void *data)
 {
 	struct pci_pwrctrl *pwrctrl = container_of(nb, struct pci_pwrctrl, nb);
 	struct device *dev = data;
+	struct pci_bus *bus = to_pci_dev(dev)->bus;
 
 	if (dev_fwnode(dev) != dev_fwnode(pwrctrl->dev))
 		return NOTIFY_DONE;
 
+	if (bus->self)
+		pcie_update_link_speed(bus);
+
 	switch (action) {
 	case BUS_NOTIFY_ADD_DEVICE:
 		/*

-- 
2.34.1


