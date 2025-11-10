Return-Path: <linux-pci+bounces-40678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF6C45275
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 08:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0873B1D1A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC942EBDF0;
	Mon, 10 Nov 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mfq5Ae+S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iuay4f2K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E442E9ED8
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757992; cv=none; b=lHmybUmuTUVaTmCuwKWsJfiwoxlljds03aN7fw/JELWxxHT88DNV0UpTnfD2KY+IFKNBg5gJ7xInMZwwNZl66uPhc3fCTjUFirRagcUeglBMFPMRznnqeg4tKQfjQQTnK1YWvV9EN9IysmGnIi0gJQkEvY+a3uCaiCV3lv1j6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757992; c=relaxed/simple;
	bh=FEATCEIhTHMz7b3SDtTSGozMG3s3HSCmKvUHkBi8n1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/7YuRU8RocZRN2ab+sSYvNCVdM68g/kDmKV5LADhaK3drAVfZkhT3TXAcQNfp4Ad7H3ZsNxhsGo4pfXpFGZuV/zRHkDwDA4zF319DAPjzCoKeDFg8dSb8+/aRpieBTCzEqY3I1vMBDJqZQ6WsfVciu3AeTTVhsNMYbBOqGWRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mfq5Ae+S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iuay4f2K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9NQfKv1809858
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rLpEAKj005z2AVaIsDA+4OzjbLyJv2txT17XxeH5bAw=; b=Mfq5Ae+S14LyzdMo
	9HJLI8eMFX5mLYmfdE+GLug0rB26Hgy0U7cJiZGx2BJKCTmyixDJ/OXl2/6DonLc
	HMKKJyhGd9QiRR/QF1JdRgUSQf1Bud4TAlnzRvC+vu5ri22/05Cqw5Xz+p24U4rS
	a4g44ru0SkEir7ne+dGbmA5wLACO12ACaTUPGyCUxS3GLUOUY9u0uTcDscNDPWat
	AMhZnAf7eCreD84DKaz61PWiw7582GkZEQZHZMumMNsJH2H9TFq1nPmlWbNhfNrL
	gUrMrCdh2828B4Jl6ZLQOUohctUgNXS/8EU2MHlaM0QBYB8i1/WlUgUMTCVV/ZvB
	8a4k6w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aad2a2h0m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:49 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bb27b422cf2so1979304a12.1
        for <linux-pci@vger.kernel.org>; Sun, 09 Nov 2025 22:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762757989; x=1763362789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLpEAKj005z2AVaIsDA+4OzjbLyJv2txT17XxeH5bAw=;
        b=Iuay4f2KOCO7briXd4wcKw7kNyBRxJT9ilPl/ZI4uxlSE8eTvOQC4WKTNOWzxtEiBT
         rOU4Ft3TL8AIHeyJCxlaFO0FM+VtP9EWtp07LKFLs5G/Tqn/fwGkMQUgQTdrA/8mFMgd
         hvEf7hRw5hXkpXD81hdPwf4Pg8RdWhslb2V04aJPJ89V8JDkBi0uqtOp8H83yV2CxQW8
         Rjko7pr5XXlB920ZRBwaOepd3wKMo35Oud1jPlpfTwGu59MAVZr9zB0AgUAdv6XmSuYP
         YxJaI8LLQUZUr2kpl8mwUhiuftwYkO57ivbWKWypFcJ2tWWwRzWJex+MXXyxPDnMYxap
         BQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757989; x=1763362789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rLpEAKj005z2AVaIsDA+4OzjbLyJv2txT17XxeH5bAw=;
        b=vvg6kSSChbdndytTcK1QmNbFBO4xWWzaL/as6wqllpr4F6KE6q8hF17labu281ie0S
         xT2bSk4qYT6T9gUUBPqS3YNb7/SXB059Q6DcuVYC4ppa5yjOImzZqyID53nbY5jEu1v1
         nqjI+c35MHXHW6yaGkVIM4i4JVCzVdlO7ZobWXZEny+waM8EMiyoKNPPHeWjnx7rcMRI
         48x0joPUIvM+Wu78ISz4iYHq1WKlQwUpkh4Lj8HXJsZDj0mA7J7jhT1g7LcprZyxqkQx
         imcie3qSG6V21h9Q1p94kTtWI8mYjb1tPnKeTBg6UEL1Wk2/FAtToC1DJbUfL+ELrPDR
         CM7Q==
X-Gm-Message-State: AOJu0YzVyEwtaFy3zTm+l6YjN24Gsk2YtaKYHb+IkJTAFoZUNQSwoYqx
	GuKiY/bfxYEh+O1a1Rh7/rAL7G7wy524a5v5yalCxM9j9roVZk2qXtj5KcSz2NnlOD02VmCZStD
	BTJxTU2y0rbr/2NQ3O6+/EzR3B81m4wow2w0kqC53Hrm+FacFRRGznee6IYMNUgU=
X-Gm-Gg: ASbGncuCZNF/MNkOa0+XqXQXTrBwh+W0+KxMt9d1XhBAu6mupdh0casIsrKQHjsV4lh
	bpZfpa21ANCngENueaDCJmthuj50Xg3JM5o+bjjNSMimMVYo1xYZMZIeA7g324jtpn61OGa+r9N
	Kh8lx0RYWDX4az4a9I4TMzBhktj8Ipg1yRtTHUiTDRHAi/o0wPMuslA4YWQO4Oex+C/4jeXXqBE
	VQPEReY+ekz09zi5yD9gcurWeJzl/htH/LzqiQgKTfGWO592AJJ4/cmHrXn4TylwVY0Hjxf468C
	O8AQxZwMArQK+TxI/oF/qrozjFMYaISAbJS3FF6UxJ+zSFjUMHioMQDeTFeCGebBUDDAHs5SYfO
	gZaTZFTszDuG/MDxcOzZwMHStCaov7GrIHel6DU5jALQ8IQ==
X-Received: by 2002:a05:6a20:3d82:b0:351:2c6e:6246 with SMTP id adf61e73a8af0-353a3d56f88mr10141641637.56.1762757988713;
        Sun, 09 Nov 2025 22:59:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9d1kkatJ20pVQSTVs+EbB1h3xArAS1XPRCq6+wqezpcPrpWDk3hkhBM5GKsQi5YCcod6Ojw==
X-Received: by 2002:a05:6a20:3d82:b0:351:2c6e:6246 with SMTP id adf61e73a8af0-353a3d56f88mr10141607637.56.1762757988234;
        Sun, 09 Nov 2025 22:59:48 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c09f22sm10565900b3a.20.2025.11.09.22.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:59:47 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 22:59:44 -0800
Subject: [PATCH 5/5] PCI: qcom: Remove DPC Extended Capability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-remove_cap-v1-5-2208f46f4dc2@oss.qualcomm.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
In-Reply-To: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762757982; l=1170;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=FEATCEIhTHMz7b3SDtTSGozMG3s3HSCmKvUHkBi8n1w=;
 b=7LHbWxRs1CZJ6up1opRxZmF8nyfMw1R5TXGUaO+VWMOWI9Cdw76BRGYMkj2u2t6JT8UTIFEXQ
 woxRuWtw+t+DQ56tVmZCnsVjxR0YX7zCcTHOEddtozmDDVD+0lkXXrT
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Authority-Analysis: v=2.4 cv=aedsXBot c=1 sm=1 tr=0 ts=69118d65 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=LA3sOWcMmZYsM6F2gv0A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1OSBTYWx0ZWRfX28rGcCFJHWF9
 I1ij3dwpD/kiVYqHhLzks+DlNk9gXc1ZjkeIsLQycKf4KyRGCoyzD7xtTBi8J1FaPquTrSZWtbJ
 pyGJSiJOAcb07pnYCLPgbTHPa0mKz0mrslTKhoIzWNDYOZDPQa7U0J0nv5AS/Q8062o2X54Dr4I
 JhwaiqrsLekpPhi9B0MSoN4x5KAs+1VDdYYDZI90DdmoQoScm41SPBPaVg3D6zIUKJ7Pf7GMgSf
 W3jMKZIMq8KIsCnqP009FgnbU+I8ptdBUjOrDHoej/MUeekWZfDssdhEZjZLyn1dxKPydm9WOdc
 QhvBeH9dV9c/0O8CABjYy9P3vQU9PThZHjYUcjXDHAkkwC0eM28Hi0JbffEH6Yv1tFP6xFdP+17
 IPJdcDEzixGSXpMfcGTPRYKc6IxzKg==
X-Proofpoint-ORIG-GUID: nNGMVfvvOpiXFRm496r2qvZMH25__pjD
X-Proofpoint-GUID: nNGMVfvvOpiXFRm496r2qvZMH25__pjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100059

Some platforms (e.g., X1E80100) expose Downstream Port Containment (DPC)
Extended Capability registers in the PCIe Root Port config space, but do
not fully support it. To prevent undefined behavior and ensure DPC cap is
not visible to PCI framework and users, remove DPC Extended Capability
unconditionally, since there is no qcom platform support DPC till now.

Co-developed-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 09443ffbb150e9c91bfd3b2adf15286ef2f00a2a..1b0f72bc38d912ab46739aa7f904ceca617c668d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1351,6 +1351,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	}
 
 	dw_pcie_remove_capability(pcie->pci, PCI_CAP_ID_MSIX);
+	dw_pcie_remove_ext_capability(pcie->pci, PCI_EXT_CAP_ID_DPC);
 
 	qcom_ep_reset_deassert(pcie);
 

-- 
2.34.1


