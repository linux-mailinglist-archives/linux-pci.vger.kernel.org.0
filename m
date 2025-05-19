Return-Path: <linux-pci+bounces-27940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A7BABBA12
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA4A8C12D9
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C34270556;
	Mon, 19 May 2025 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kKKAZkPI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A127055F
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647779; cv=none; b=RNIAADkKiTNoZh1WH0IVyyUUyNgdMTnNF2Tz4NhonZFL2SbbHusDqnXKTWLyIvpsb0EYofaZN7PFMFGejcap8fl/cZgUxXmoNAgB0iyq7UzHgt00ILwrHAxxzZkkhcn8IseMn11Oo26vDlKbVopvPx/+zCZxjfwJi+hjjXFD604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647779; c=relaxed/simple;
	bh=MfTQ3eSGE1lsQsEKDfhk3n4vHJQjv6X96tSeWcGlv9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sVvBzbomlsIF4Z6zs/vCMgatHVp2n4FURYuZCEGYtj0pwH0lgDQlYFV8Xp2zrZ0livisGya28gzd/xM9KZoEJXln7spGQR4goynK9mmrf0in3hVQYyeDxNKoYz6/ZL82tAnVDyw4mYOYnVpNbWrz5GXbC0pLCKc5kFWsFfVnIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kKKAZkPI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6P3Es007437
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J1/73SEf4ytXoZ1yrIlcLZ+v5wHcPMuVTgw0lx2XQTo=; b=kKKAZkPI6RNDjmuv
	H7XiYRa14vGzrsv8xoWeuBl5p9PkYLjXZjfgj2farMRVSOKTrJvtAcSUOyZIA2Tk
	gr5SDApVc0yZ0cBJOS7SeY6oPQ2zdxwlhpK+ovGFSxvdjNjQCp2yQlZvREG2nawD
	FhG+siBqr34WwgYXCOik3NDK7Vhr+FWyQEbvuqCOabyK6CPzTJTSXuoO9u+NZ1j9
	gDskj05FmwZrVo3Q2wxMs2/6QkIJ6cW0LTb3BL1mSP03wku10Glv4rib8/lB9PTX
	bx7UU6sw14ByggecxvDtPmriXj7Yzje8EdBnYEVYZEwptYv8/jjYGF11UOUi9P4d
	bknKNg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46qybkgm9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:42:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7425efba1a3so3867656b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 02:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647776; x=1748252576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1/73SEf4ytXoZ1yrIlcLZ+v5wHcPMuVTgw0lx2XQTo=;
        b=ViCOU4FAiHhpjpVcEizlpAs66kJJkFlcjtMtRMIQoyMz5qCKg6l5sUXhSUeWxZQ/KK
         lzYArqE5XoyIOrK2f0USPRAnwYFT570TUx73fIteplIFVbo0WkCE1sGxGCBgBblO6kIQ
         qyrad2Vk8SXKWtK5v9y1iy3JFyTul7n4Gw4ec6ZVXwRDpN0gHCTyw2cUup7qWiKAMTBz
         40Bp1RqZ2zoMidYSqkT1VRRLgK8VOJW+X4mdQLcBL5g9S1PYliJjogNqzwxpvwrhsOEN
         8KAx+l99/YDuvWjz1m6hsP74Vc/mSgdJRQpEfVNxWF9I7fICVGZWJh6vTboJ5siQKJgA
         9WLA==
X-Gm-Message-State: AOJu0Yww2+GC04tfsnwR6L3j6AEkcMoXbe7+YWn7yyY/sRNe0WGvenFv
	BzembeSEYoEP6J0FevsiVAKZtmLFH96ZeoVcVgiB8/yV/OfczKGGTumzsE3FKxc18PgoTDy0NJ3
	FN3NZyoKP3AO/1qk6eEPz9GPahbPPgx02DGAihPha8iNFvZHGdgBxVo3po2gHUeg=
X-Gm-Gg: ASbGnctxFAzHlpqG/byU9V0a4wjmhzvtveqwzt9SilMkUFmZniN0ETuZQzaw7FyrHJI
	go2PQw6vEpU7TIvkVaQiM9VrC/AB79kaoBOMsdzM1JaATDoyiBRKfs7kxQCLcRZXuH68iskV/D8
	pBsoIQ/dXYyJANvb1MwwmaW3Un5tDJc4P2IcSxsC26ptxrmUaFSPAXh5EVcRCmjN9wOTWjFgeQa
	Sp9J0FMk9ddjOfyRYGSX/0JBPwDAbY+d40Qs+vRMk1cxAG4iWz19ObCQxiG6SR9wplDL52EPVaT
	8V/I2oQIKp1ZAKU8rzhU/dTgkfftOR0zKxiFfPNeCOwrj1A=
X-Received: by 2002:a05:6a00:ac1:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-742a99fab76mr15619567b3a.2.1747647776269;
        Mon, 19 May 2025 02:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6FoWtfS3J3KvBeQkijcvhEZQEo0F73rDNyaSDtfdrDQW3C1qk8ZesN/i6Mh3j6GEYFvr+HA==
X-Received: by 2002:a05:6a00:ac1:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-742a99fab76mr15619544b3a.2.1747647775854;
        Mon, 19 May 2025 02:42:55 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm5809092b3a.78.2025.05.19.02.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:42:51 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 May 2025 15:12:17 +0530
Subject: [PATCH v3 04/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-mhi_bw_up-v3-4-3acd4a17bbb5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747647743; l=1002;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=MfTQ3eSGE1lsQsEKDfhk3n4vHJQjv6X96tSeWcGlv9o=;
 b=Yem+nDFvzc6dsaIOAR4b6zXLoldPziYHuM1lIowV7FV6LiFHouh58R4R3CqoekwHVIv/w/HTI
 vxXIWwGg9BDBlBKkBDVhf2SY+qlPn4lRdA9jAvQfk0MP/izsfcAVMWG
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: YMgUG-FVcFZXZzuf2ttPvTrjwMsz_ODy
X-Proofpoint-ORIG-GUID: YMgUG-FVcFZXZzuf2ttPvTrjwMsz_ODy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5MSBTYWx0ZWRfX1wCTjMuqtXoP
 5ve6l8V/M5ZkqcCmE/eeOOZMU6xrUVjPkGNv3QAFzN8wwpuAEpn7V9+LHR5Bj4qM8Qh1SG0Rs+e
 qBvipZc1LyNInw1ixIq8qxRDnJRZ+IskISwcqqdhFA/XvwyqFpw6/SiMZUq3nZUso5RdUU4aF8r
 xlwH2wSIZBLGgz6RPAJbA99Gc7g2A+mvXxc/rREQfZuHwW5poI/ZRdI1bqAK2WhRi6PzuR1p666
 fhLYh0bR9+S/mJXeC5V/oCGJVxoqb/knZbOlSDegvt0vxPGbzgbTvFnoyI4fzFuRhFjY4nlZmCm
 zYmIeqjmrviISyDmprWK8BZ+g0JXFw8Hw+PWUNDG0PDYjWyRKM4TZGDiSJ/eq+N9iOzK1T9RhxF
 Ixr2XhRuJB8RdGG/mwk83CochaUkKvg9dKn+hbBPa2lEByAPFr1k76kwyMSMi55Ysy9mk16p
X-Authority-Analysis: v=2.4 cv=RZeQC0tv c=1 sm=1 tr=0 ts=682afd21 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=JOcJ30pghDwnvxMqNTgA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=977 malwarescore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190091

If a driver wants to enable ASPM back after disabling ASPM for some
usecase, it is not being enabled properly because of the aspm_disable
flag is not getting cleared. This flag is being properly when aspm
is controlled by sysfs.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 94324fc0d3e650cd3ca2c0bb8c1895ca7e647b9d..0f858ef86111b43328bc7db01e6493ce67178458 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1453,6 +1453,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	link->aspm_default = pci_calc_aspm_enable_mask(state);
+	link->aspm_disable &= ~state;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
 	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;

-- 
2.34.1


