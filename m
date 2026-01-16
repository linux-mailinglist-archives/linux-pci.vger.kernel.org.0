Return-Path: <linux-pci+bounces-45048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8278BD31CF9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 14:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E0A03027E35
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F1A265CC2;
	Fri, 16 Jan 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HZ2AXBWZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F9xADq5j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC5267AF2
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569937; cv=none; b=GSAfNlUE+7TUesNOcrKt0DFot6pV22PBgXThQ7GXNPMa0UKYbvSsZcD2ovRyfdGBJVur6s0lkPhg5Ki0R4B8cMGgGIEj3rcWjZjJZ02eRnMgmq1/8fxbX2vu2r5Elaa+MHZztoJcD3nr654etDby5wVcqtyAr/bvwmzpIc1Ve7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569937; c=relaxed/simple;
	bh=wO65puuOPV8mWj29LAskYkY/c5gM/i22JAIZF9FnHbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kks+z/HOqpec/Owf4sxmOexkliDRFaQAniAODSnuzKrFTJNIsW7ey5QmJBQ/u+A6qV3XWHxSei1Wh1jBumZzBSSr2FY7hV4W6brifZ12NeTAnuYgHpqeMLk1CUrZiJPoshP+PG5+eQu4VkjOYp1PREw3mw0mHMfPJ2CjIUQ/mp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HZ2AXBWZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F9xADq5j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60G8819c3714113
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 13:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m89N69Feqk6zBGnS3QVDdgrPq5aK1zZ5zVjNDPweqnc=; b=HZ2AXBWZU2kpQLpg
	NN45Nz7tAuSugBM+AmURkwVJ+Ce0J4zqgjUA6vcTngFHSqFWQOb7VjIj4elT60UJ
	T2858fH4KE6QF6iTedIVXqGZ26zIYjlOqc7SFV8mlALgpNQChe0rctK/g+GzxeFy
	jhKL58fXv8wevGPWBemkLGp8dj6z6u8EcMY+FSdcB1ZXAJu4JtQrxXzvj+TZlUmi
	ddOFS1QkOTd3kfJLWrKUAVJIWFv6nJDG2lNEs+Cg5aY2ILOvx0h0jME3ZrQvEVN7
	CQ+Md5gzBeiy6KPsMcXdsv+am0YPX9vHyxI3C57+7J4t3R72BnLO/PRNcuae8Vzo
	CYK3bA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96paa2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 13:25:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so2834388a12.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 05:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768569935; x=1769174735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m89N69Feqk6zBGnS3QVDdgrPq5aK1zZ5zVjNDPweqnc=;
        b=F9xADq5jCfCKcEhE2KeCPQ8B6+yi2fsbPQx0kn3luZ5Oo08ZibU8a05bx5DvBhSiaO
         2BACObJIBr/ihbHVqZAIFNyLQU0TmJXcrRND/1sz09fo8FFNhCYkyizuvQgNmROVmN8u
         lwub6Lk/Yt9WUGbzB6G07LEuk3Ntrs6I2kekPihiZsA40woqXx83S1dAOuqaHSdmODkD
         dw+Nv6g84j0B7/6Y2bertsuii8oFjUwjXtkP7bn1Deo+YYp3mVQy04/eG/kDPCHr+4ot
         WcDmQZ0Rne2Y3+Immt31XHtBqeT8mJPJCBnTNyEQFioT7VmbKsPfOJLVsTk/W0UIsj4P
         2N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768569935; x=1769174735;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m89N69Feqk6zBGnS3QVDdgrPq5aK1zZ5zVjNDPweqnc=;
        b=syd6nkzxYZamVsJeXYi1H7Hdz8HTBmagbRdFZesaA4F6b8xvAFIXTGQv+ssRT/YCyO
         wpUXU2TASCnWCuj7v0PAQd8ZSgw8nBc5LEmvZ/pNBWsWhF2a7nkDWMiWJ4r7gF05DanF
         1z0EETocxaFPVvkRMzvrsKNDHrcOYpE2jYDmzp3zBnbFQmurJkdjgQW3BZIOuWJA458t
         SuwlkIzmJsCBqgWIDA4g5Ur0pjhczUuyztFTEIxckAvKuhEF8Ff4yZBzoWpoNwz7jfrK
         IBvld/Qh1D+a/9SlNBSxY1mAOZB7Vcgf9CkUjU8tz91Y7+5UgyGvX/ZIJ5AgOnbTAhUW
         CdoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaimBjx8a6Qk9VR69RMdCkRQijnlLoNqldGDmsYrwzGpavVEfbYcoFP6yKVIGgJwxi/ycPDHLxtAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXrNvynFtdORCOphUgOKz1Un8GGShZrx4sIcIkK0EKnczwIt8v
	14v67vYT/CRrkoPC6TXaYg36iAZyzAtSS5Q+w6nyblsU7okKWhfMOE8BXxwbVcYeqTpTnRVK2VC
	6Hb2znxVBQ7XdcBWjQIm18rUXPjr+nZzDgm7Tok41yGj8UguFfZQmqjbx3kMlLh0=
X-Gm-Gg: AY/fxX67Zj11AqQEtWIfVX1prDwQOlV1/JpGnxNw114K+YwliPCS3CjHBjXsZMawbMt
	Wxt/dXPrEourGUSe5UrS2cnuw+k4OWl/cMZ9vqNpyx3tKv6Bl3YIHI+s0jAaH/on7Jqb2ilrkMO
	5C9eCv+PwRcVzJze4EPPsrwuk1PstyhKYn/C+kCkMALWY1tZqAph5bf+E5q9tFLQZOcN2/iDMfN
	22/4RXjHtWwECnb3SwS0VA8pjEPZuubB6TXqvNhhi5rik+oe3QFtzRekOfzITz/CZO6lA8YDEub
	r1hvfi8w1NxMJtAS8BuCfzsvGs6ScxB68IHJZQQw3Av20mWrHz2qd/KkCYPvKNyJbKRNhnEERcp
	XINIg
X-Received: by 2002:a05:6a20:3945:b0:38b:ebaa:c167 with SMTP id adf61e73a8af0-38e00c2ef84mr2544608637.20.1768569935116;
        Fri, 16 Jan 2026 05:25:35 -0800 (PST)
X-Received: by 2002:a05:6a20:3945:b0:38b:ebaa:c167 with SMTP id adf61e73a8af0-38e00c2ef84mr2544564637.20.1768569934560;
        Fri, 16 Jan 2026 05:25:34 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:6031:39cd:c600:2b20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108b252sm2138072b3a.7.2026.01.16.05.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:25:33 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, konrad.dybcio@oss.qualcomm.com,
        qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
References: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/4] PCI: qcom: Add support for Glymur PCIe
 Gen5x4
Message-Id: <176856992835.23711.2150005271893614146.b4-ty@kernel.org>
Date: Fri, 16 Jan 2026 18:55:28 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NCBTYWx0ZWRfX1Cw2R6Ld9fwT
 IZ8Lg+aWk9n12aD659cLuPy6xZZL8IwXu2QVILNQoUnYYtToiuAUnA1wNbAKD22C4Ekr9x0GR41
 H7Uqgc22PEmOj2OAprb2T+Uqm8BnVubVEIFHgST+AlRNVRWWjy9WtxyMbKk/nC7atLtjAl+Bnwr
 A/sz4Wfi8g837uFe+N+CUt5yOrueKkO4wrrFwG896+zurzfLJEytP+ndSkP+hhlv2akUHOOtJKi
 x8FVLeLjXv7225xU+tdSlL28JskJrhxqD7A+gaeZsARa0DvaIGz90+xStxn0gvjDOKBh12BtA01
 CN5PSzgIBAlLCv5vmOuOYZRTDGoL3RF8EB0dE4RjffGyMEbi7GIFwuLq4M7M90uhMbc4QPEGPfI
 fgfq971p3Rvtm+sRntkajmwH8I3mBjNrpVVT3g3EnW+zTD8UNmURQFuLvRf4RzAxwO5cbF8QUyp
 mPeKso1JrbU9DSZ+oiQ==
X-Authority-Analysis: v=2.4 cv=M7ZA6iws c=1 sm=1 tr=0 ts=696a3c4f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=extm9pdXzRddJ-xlDaQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: K0e5XrNlT15FGOxh2680AIyNcv0xUOwa
X-Proofpoint-ORIG-GUID: K0e5XrNlT15FGOxh2680AIyNcv0xUOwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160094


On Mon, 25 Aug 2025 23:01:46 -0700, Wenbin Yao wrote:
> Glymur is the next generation compute SoC of Qualcomm. This patch series
> aims to add support for the fifth PCIe instance on it. The fifth PCIe
> instance on Glymur has a Gen5 4-lane PHY. Patch [1/4] documents PHY as a
> separate compatible and Patch [2/4] documents controller as a separate
> compatible. Patch [3/4] describles the new PCS offsets in a dedicated
> header file. Patch [4/4] adds configuration and compatible for PHY.
> 
> [...]

Applied, thanks!

[2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe Controller
      commit: e74887035fba99ead63235740908debeb1326dad

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


