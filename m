Return-Path: <linux-pci+bounces-38290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E92BE111D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 02:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1013C19C1F91
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 00:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1D63FC7;
	Thu, 16 Oct 2025 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mVbD4ji1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2651367
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760573123; cv=none; b=Q8pE3zASL2oXwuN47N/1MU2gmOV+E+YLAIT2WkmfLzqFXYlVsmD9FA3fsPw6wyKRotZdWCOmSuSUoiOahbbhpZUyixW1c37ql3zkfvb7USy+RkVaX2RbPgxlH5RvfEFWB7jzIh1ldwFOu/56uoJ2cDQLQYIMc25mcFpOyJh9Le4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760573123; c=relaxed/simple;
	bh=Fax6VecnDWG9WfiWu3rGm/yJBg16kMyhvyosAjZ8fYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd1oZzXQWn1x8sBNS1Vf2PxfWH0rHRWcxV5QEkSnRIJURI104ZIwxqyCeI/ztpqdjs7ytr50i7TsKrt4iVT22HSWZgDvLDoOjawqsmtCibw0iamv7eI7zYL+zOLu0AKlediA1Q/bwTJJNEeSj5zjIYwA9l2YntaipQeW7opO8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mVbD4ji1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FH4weu024771
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 00:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ttH9o+JKFt12U4z1bUTlIexU
	G6jcvhEibO1N+cM/DzM=; b=mVbD4ji1HvPHj0I8MTQbn2quhJKosorfDjRHqDmi
	vz7qiYp3yhclG7K3UIUh4Jw4sDqUokOwqsDjDWcDCeDD4YhEAT73v8Zq5orGwd8g
	nvUyuhS2+KgTbIlQvVPGQYw2goRA42L+yqGvFAx2GsHcvqcMuqpXpHgPWKcfEsvK
	nv1VgxufuYnUf0ZT9RzQdR8R93HsRcEzWNSoUdg/I/cfoINn9Cl7ZaEWXYsHvLcb
	UrJCahJKXyz5H2SfvcsZycMe7f/HNu4MtEt9Cw8fpLRPrrZotGb2Fq3t120/f3X9
	MmTkszG2aaxB9kSeU4VwnaZyXoGCa6YvhlOvOOxfURpYhw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0xak9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 00:05:21 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78efb3e2738so5660256d6.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 17:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760573120; x=1761177920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttH9o+JKFt12U4z1bUTlIexUG6jcvhEibO1N+cM/DzM=;
        b=J4iFm2FxDx4/PZkhACqYnqqEbSUryd1mV6END3vtNQksVE+dDC6I+VOUSs787bs0py
         MUN7/jxczmKJPWNqxQ44yeowjVw+BaYlIoPcYQNhxkFrWIq61V6+kxkCauU88LwKEk8W
         p3xiqpO4SVW7SkGlzcik3G+Rp0Gylv/jrubUXTKSrni0zaIvxy4EkeotcoBykW6RMrmF
         SAEmwESQY5MYmLhe7z+O6+M8rEqyA/iRnFgKdiRYwgPQubcQdpgLyzbxAmVwo/VLUBLr
         vsoKIXjghhat/KP1l4tNuf9eCnWjX89cFr7GAEERIPrCZ1m63eQGU3ZfFbiQ1jWCbV0/
         g89A==
X-Forwarded-Encrypted: i=1; AJvYcCVLvtJiNM3Z7yiIcQQKsewCpcKdzXJwUdaTn0ftu2zPrp8dbiEczUxMAfq6LDe5FS00lbAwr/KHaWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuFhWdNxGZsnksA/zF4ZZTLg19twysvCp9DD9d8Wc5SVUcDRcs
	SyVjcUq91t+8PewUq2BC6rP0ojDdtXHaiTDudd7Q5/mmPg+xSME3fircmPuGBLn/s2jhG6FsjRh
	SjH1VcYWHcmsoeS0HWMVOd7okt/v65NhySqLiuT+TFayE2pOMEYjPRW8ljvpDfw4=
X-Gm-Gg: ASbGnct2Kw5yJ4qsHX/A8MRy86faq2oWxxcxoj04XDNJ28V3MGO/LpUdZpaQMWPDgR9
	Q4RiwQF+vplPKpuEpR5ylJBHhe9Mp1FDemhw8SaelY948hXGFmTixMpvgsJrGUWXYMjALZjvTk3
	5e+TqtQyLFuqAzuZZ2mz2DQZFVIYfeUAy9li3zEMYynJbSIs1y1hUXB44URz5gKTHa+RBWg5Lt/
	8/m1d44xoj8IOi2IdqJlg4qSPIJcV5a+c+intABoI5B/9sBiaWXynIM8sVRIO+7DYhmJ4GVh1ZR
	fuR0g2R5NUzwljtm9gl9HLU/3tCRVcPH+Aob8kbwcuSh93vrP0qiXzr9FQKquRGYMSeBsN/g6B0
	ORL6CB3REL6eT5vgCohFtI6GAjIcrrDSOTUb27vGCFp4BwEKuylQWTlsxhYEnPIqGKidmaZRkXE
	/GybIRtrpxXA4=
X-Received: by 2002:a05:622a:4890:b0:4b5:dada:9132 with SMTP id d75a77b69052e-4e6ead709f2mr460284841cf.75.1760573120302;
        Wed, 15 Oct 2025 17:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPHSdX8RqUU8RAtgjSgrc5QwEf9TAs3cpNtbgxxS9fE9uOnZFE46JhxPCkQd6l+F9bJayOlQ==
X-Received: by 2002:a05:622a:4890:b0:4b5:dada:9132 with SMTP id d75a77b69052e-4e6ead709f2mr460284401cf.75.1760573119860;
        Wed, 15 Oct 2025 17:05:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f8c79sm6592635e87.34.2025.10.15.17.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 17:05:17 -0700 (PDT)
Date: Thu, 16 Oct 2025 03:05:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH v2 6/6] phy: qcom: qmp-pcie: add QMP PCIe PHY tables for
 Kaanapali
Message-ID: <k7xjihanbqelhm6pytrugv73pc6bmspn75vy5a2thcqnxkzwhd@bsyp2nqkl5rf>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
 <20251015-kaanapali-pcie-upstream-v2-6-84fa7ea638a1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-kaanapali-pcie-upstream-v2-6-84fa7ea638a1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX9Cuzu/DBME/a
 51hoZssB3t2ehO38WEXDzC2Z0TllEJanoZdVQNlrCdmE5TyHGt5lePdTpSs5ByRUUO0vUVgF+Gq
 bVii2b1eljFPrIqfLJ+5Z4JutXGVFwVEQ4caYLre/m82j8ldv50AwyugQRl8Gly0bdIxUbjUTy+
 Plzq2154C82eBD7iE+n0NGUTsuK+8d1J8Rc1WWqdvF/jQzZW7QUg5EETyyUU5lbKB7pCbzJ80Ap
 8gSGxPir4Fy4Ol0ML7ZMOzXvyBE1pK88HHOCSQxCFAOhcKn6H+x8hRCk0LzRV2q7lvSONxpcSOT
 rU/cigBQd47infiwpK+ARyoLoyIrG7fZyVOvRbt4A==
X-Proofpoint-GUID: e-ocUyX1o-KP466ZOvgG_fEuUYO8DLVp
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68f036c1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=tdoatHydnEAQPWUjzvIA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: e-ocUyX1o-KP466ZOvgG_fEuUYO8DLVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Wed, Oct 15, 2025 at 03:27:36AM -0700, Qiang Yu wrote:
> Add QMP PCIe PHY support for the Kaanapali platform.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

Who is the actual author of the patch? Do you miss the Co-developed-by
tag?

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 194 +++++++++++++++++++++++++++++++
>  1 file changed, 194 insertions(+)
> 

-- 
With best wishes
Dmitry

