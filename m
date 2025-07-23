Return-Path: <linux-pci+bounces-32829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E77B0F78B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 17:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE481162E79
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27EB1E3DD7;
	Wed, 23 Jul 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OVCYvSH8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D54A136658
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286271; cv=none; b=ORxGH9tkGAPUtEPs7mAbs5XNjFDgNCVnWlHxjyOX4S7YUMEgRg6Tfp6ctsntPJZ252j7PpBGScegTOfaCa3n8CWu8AT2HR00ZOXiALKWZWGtpZuJc9+JTsgEbj/4i5XO6yS/9qJxIcQfh0vr6yoDrDbupsy8RvcClutW+UTtgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286271; c=relaxed/simple;
	bh=2Lu4l+b66ZqRwcHiTle46y1MR/xDZsH3kzwngLbEfnQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YuSjIO3SHWRH+ttNfmzXLGRJumtI5+CWSgl1mUK0sIdcFACkE9otrTp9bvIflpnFEGh0WNC4c5S7ngB29Lf2HXyH7H1aKhXMeZCyMkZ6YSlKJGp2DlCekLOUH+3qonkKRBS2NJmj9Z0Xg6aw2IQ+ouRJEHrUPVbeNRPaRWQGgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OVCYvSH8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8rs6n009238
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 15:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YtkieUEHX0j7NOkthBC+xkyEn4NoDmNOetl5nOn3gOo=; b=OVCYvSH8JEgtNcW/
	Hvr2RshnKt96aXumsRwK3VvezPHpxY/onja3yBGT/IIGtR4nCEtkaMEiF9WPjedY
	RxXqoKh/FUtVddKCdpSrLF4y9RJZB01MLgZ/rRAe2ly5cMVB2Z8fnLGPYCOBNqTP
	XpV1ECegQvR6l9sXSKPVXdLEe1kXrJurmsK0Qm5i8pWu0F0VxkFOkz1b43Kzes/o
	0FcHb6qpslb9VTVWj6+vI3yrnAJ0D/+owCPz1JLCMn1Oo1d9/MaoE0fU2gr0Tad8
	2owIPQUk1tZMp8dVnpgVvP4XWUisK/n8k85PzPvDWSt/y+jZ7hgIpSLoXinwjCOY
	Brvz2A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na471g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 15:57:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab4211ca00so1096181cf.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 08:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753286252; x=1753891052;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtkieUEHX0j7NOkthBC+xkyEn4NoDmNOetl5nOn3gOo=;
        b=p2rn2ZH6EgnQ67uL/zl/9696Fvb/nHmcVP5Baz357YCiHlWfgXkXZ08CF9+mOYORV5
         Qod3YFnMNW9cP1kR1cfqKb+DXG5Af/eUJQ+9ip17MjGM5l8FXmxxHtXBk556M2w6zcYO
         qCEmTGnEj2Vv2ROZDBhSSrXRD0dp5/mSZMxoYzTjDf08EtxVXBIFII9cNzq9HL9y1Rur
         vUkHHiFjT+C5/+pGii7sgNxs/ML3Gu8Hfk2jhA95+T0h/fIKYd4Bm9LJXuNAtKWclyT9
         nMuRPlCOUAlzT4hKYp1OGZ8rSoC/hJXzOSR5QHwDvvdm+bdxpxqJjJ7tIenY3AwIhHO5
         9e2g==
X-Gm-Message-State: AOJu0YwOmmBzl1a8jM0RVm8lr6KfRvFrtBXHiy724/OAVrIy6CnEQM17
	lXD0l3s9dEo36bmSvSdncA1AzuORy9OhPwukgaaSmzkoOPiGSwdOtJkedRgzl6H0Quy91qHfs1f
	ZOHxfNYhRrC+nxEaOuFPT71A0yt9/zxNtalV986sEon6fEZjFckdPzHRVOTUwC60=
X-Gm-Gg: ASbGncsXXijhiuW7PYpZOHrO0bPXJq8BzbWRnEl0ThbK+Td68RYzqMxlWJDjMmuDeQ4
	IFt7WwVtpTBHFlCRic4YBSeJRnSQ0P0/BJ97uzUZ0M9CoJT0e2aWv1NKiegBmeoJAMrOHRf2bpi
	tWUCMnpSOreSlUkLdDHD4p6sSo2Gfm7yTjl4yTWZ5H20vJZhpKQMNqV3nvcrSOQIKfu+vXsTbGu
	Y2oZwMLpwM3fvGTMrnPqz0xj7lLWFKBVMvBnUxuEo92Bh+U15241fHzSzDaIMRCGXwBmwsp3jSU
	mgbNDrx/4a/8lQbXwaybPsQC3hLQqJyIQDw=
X-Received: by 2002:a05:622a:1482:b0:4ab:5d1a:93bd with SMTP id d75a77b69052e-4ae6de8785emr46128961cf.23.1753286251732;
        Wed, 23 Jul 2025 08:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENrtc6QBbO0UPOgNoyMOBayciVcsK2EoG0Ya9QJi7FVg7P5WTjyM0W0swWYhkBXSIiTPi+sQ==
X-Received: by 2002:a05:622a:1482:b0:4ab:5d1a:93bd with SMTP id d75a77b69052e-4ae6de8785emr46128651cf.23.1753286251322;
        Wed, 23 Jul 2025 08:57:31 -0700 (PDT)
Received: from [192.168.1.17] ([61.2.112.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae5c52c3d0sm24709271cf.26.2025.07.23.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:57:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20250709033722.2924372-1-hongxing.zhu@nxp.com>
References: <20250709033722.2924372-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 0/2] PCI: imx6: Refine apps_reset and EP link
 behavior
Message-Id: <175328624589.28758.7232251472383556230.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 21:27:25 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: hFv3-dmrmz6p0jfmPJYaMr9_hZ_dUQ7s
X-Proofpoint-ORIG-GUID: hFv3-dmrmz6p0jfmPJYaMr9_hZ_dUQ7s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDEzOCBTYWx0ZWRfXx64bXl0li37w
 7ime4JMq++xIno7tOiX5ls7RwJ7GRVPWaA9W3luNQBoDuKS1G/ElNX4breXHhELb4eiYoFIhgF5
 VjO6JlTAPTDXFpuMPGNDX3CLUciNmLHHQSYFiUbF9HwWgr1MfjbHlAvBC9SZ7IFUQLUkQqL2ZGs
 5kH+zmZE0akYMEZAuxOXlFnvvDTVRlqlXRYpQFmyg+qX5Hlu8zXnmCK2sTSX9RiKARAWrhsf44M
 d2ZLJB1SnHtZHxMhytluXtQnHozYj8VQurbB1OzXbgUtR//sPCyDG9xUyueNawp7KCWn4GikWz/
 M9gbinekbDNsvPdKGZKgw1XQVlRZxYnMqfy8vXVbJRg/pvitIVIZcMIN9KK/V0XSdxyICbCwWpf
 TCVKy1FvgmX9KhKWgb6XY3WHlIST/R/Ov+4bkYPaSfl4v/hcnfSmIzgOGrVRc5y50JslfiD+
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=6881067d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=L2vWZV9GmkZVUxua0bORKQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=L_pc-btOT9_bO7MH69IA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=545
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230138


On Wed, 09 Jul 2025 11:37:20 +0800, Richard Zhu wrote:
> apps_reset is LTSSM_EN on i.MX7, i.MX8MQ, i.MX8MM and i.MX8MP platforms.
> Since the assertion/de-assertion of apps_reset(LTSSM_EN bit) had been
> wrappered in imx_pcie_ltssm_enable() and imx_pcie_ltssm_disable();
> 
> Remove apps_reset toggle in imx_pcie_assert_core_reset() and
> imx_pcie_deassert_core_reset() functions. Use imx_pcie_ltssm_enable()
> and imx_pcie_ltssm_disable() to configure apps_reset directly.
> 
> [...]

Applied, thanks!

[1/2] PCI: imx6: Remove apps_reset toggle in _core_reset functions
      commit: 315b747ae6b07ffabb27ed8ca584e6e6df8050a5
[2/2] PCI: imx6: Align EP link start behavior with documentation
      commit: a43b68bc510aa61a5b7618c79784dbc83074e504

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


