Return-Path: <linux-pci+bounces-33718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FACB206F2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5EF77AB22E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 10:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A9028A1D5;
	Mon, 11 Aug 2025 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i3hOb9tb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD43277CA5
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909938; cv=none; b=nFjZU8dK3Qsoh6v2aasMH6Di64yaXSJlfU31Di88rTYHQYWWVCXJBNgogEaxpGHJ7Ze22hVJgEDwmwu7Br9J79M2JigVizEaaD3QqHZj8pr3J2VHW5XAiJlVk1WbFXSQCchoEtKIy8rjew7uYVUV+S2kewsY1kbnNiZx2FMeNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909938; c=relaxed/simple;
	bh=jQpXt5lJOPGLa1sqB2RfxQcFg7u6BQCGwUZwSWOyUyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0MrMWq90y2+S1WUlIfJZZt4xQVJKEH7SR0NcPzH0nzgIvIgWMyRoEsrvdP2kVeAdzs/no5h4Am1Xw8EndGVXaWwOZ7DcRmLPb0EncHyIK39H+bv1XS/TCU/fOPpFL2ajRUbM8zpJa2YnA4yf9IJB2RPxdZywFGM3cq+/zLVQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i3hOb9tb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BAGIu9023741
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LCBNoKc54TT9NiHquTumjmp6
	Jc2gxZAQ8MEjjE3KJtg=; b=i3hOb9tbCFgU3XFUbquG8R85Ws2AOF+31mP3dKy9
	iqa1+sEKuHZbTz79Wii6UtfKZcdW9Wlf8p0YuMs6nrFjIsL5mbWnt5cOFrf4iEse
	bVvbJe52a5LZG2ZXxK6YZz+Joqfs3o7US22vZQzzLIue/ljR5YN0uWIgw0NbJwMD
	26pvtvhFtvst+Fd1xRBx5gMW0mU2EiDvX83vzcs0VtmtnzhYJIoECuYSmL1/2lJe
	BTGNm+NdDo/In5b0r9RGFhjWmuH5Dhn9RiPREPVKhwfy2gSXTWZdbUnU/p/PUKh/
	s1U6awXOH5A0hBCKFpa3MaCsxJmhiT+TYCOe1dNqZOZVmg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem483ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:58:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b06228c36aso55820101cf.1
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 03:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909935; x=1755514735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCBNoKc54TT9NiHquTumjmp6Jc2gxZAQ8MEjjE3KJtg=;
        b=uQOkl8BMkgvx//wXJpdE7XLgknzgPHMEUQc277khMl5RlqOx73C0b/SOh6eNPbeJkf
         4lcf2Hx4W16uYiLOJrzeAtcxcwIzwgbDEY7ZpzTzDbbTPUTj8LLAwkPPgqCprGbwQc0V
         oXDKP1w+05dJaPNS3ekNJPjBGH4Ju4El/lpB1lynJYcTMSfv1qjI5zcz21PwckJ26g3a
         fPIj3aWkMUlyYjVqzgZsq/81GpxrbJzepuEcXuDPOmsJC07fpr9YZOzwhER3wznLQQye
         SoqrVCT9C9m7U6laR5RwuumyWuiMm/8JGV/lTYZI2po5KRrasbV4wipbGQJLFqysfhYX
         YShQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaglnSjC7ZEBgq0enzI4YZqamCSUtdUTi1+4ow130xKL+vdfTiwSEKaJVhV570BehnmXxEqVt58iM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7kHxw7sIXxvRcVstBVcwNSjW6AnI5X84t4JDTyt/ZXVnLT3Ax
	QzPWIY2fl+U3j5g+rkg9ca92aVhqSxxf+f7kNqBmUF4BXSrDDkmtOqQ3uZ748JXuMZEtmtjLpe8
	iu4pdstRvfK+BqWMqHz9LhpFoEfn5TzihsPNktqHg0IKcxUJpoNlAGq/VjOhicsQ=
X-Gm-Gg: ASbGncvvjPmT9cJO4PQSWcZUjFFIneo5OkfWh5ySONwkj/OZkNgwA41o7See0PfcQcq
	UFoI51q4/JEeNKS7Uk9qM9yWZBKp426WowWNXZYIxqFDHMRyFSDa5/Kyc1WBAt+Vx763SpFjmPz
	PUhiJ+1hnfendFPMQ+RVD6+JkNwA4/MiDHo9oNK7TiZB+Z3aJRqYxu/OPwAi446JII+cVyZ/GrC
	42EMiettRc2f95p92Upj6VjWEzZflggdnJmW0WxZ9bbdRshJAOCVhpFtOEPiKauRTBfElXt0OXK
	ci7UBfrQOf7lU1fLbj5fEBx0I9v6aI4nE+a+y78A3FrIGOaIKIR8oseJ5v8/LBlEh0OAQTg9lDf
	e/hLaQSnYs8Nl3mhfbV4CWI+vDN5tRkyT06lv9dxRIbzsBjNiTTwB
X-Received: by 2002:a05:622a:1a94:b0:4b0:bc43:dd90 with SMTP id d75a77b69052e-4b0bd6610f9mr96569941cf.48.1754909935244;
        Mon, 11 Aug 2025 03:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBrlBvmKL2RueO2NS0xviGlmtRPiD5NDEbuXSKBImqyB7gwapNEVCwYcaPgiOWwUqYRHjJCQ==
X-Received: by 2002:a05:622a:1a94:b0:4b0:bc43:dd90 with SMTP id d75a77b69052e-4b0bd6610f9mr96569681cf.48.1754909934768;
        Mon, 11 Aug 2025 03:58:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cc9df19afsm1050425e87.168.2025.08.11.03.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:58:53 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:58:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH 2/4] phy: qcom-qmp-pcie: add dual lane PHY support for
 SM8750
Message-ID: <mjg63cvby3jtosoiswqg2kjxlubavyz5o27asthjazg2z2x6gj@3u4gywclkg3r>
References: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
 <20250809-pakala-v1-2-abf1c416dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809-pakala-v1-2-abf1c416dbaa@oss.qualcomm.com>
X-Proofpoint-GUID: G2QblsJXcso2DNasX-BcD9kwYFKwtHa5
X-Proofpoint-ORIG-GUID: G2QblsJXcso2DNasX-BcD9kwYFKwtHa5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX1AfY78mx3L5l
 9+gMWP+7UVviwgf+qKdZqM+RcCFEsDHJ44QUwrKa9RtwyjTMFBkh6Uu9Ahuk6pAix1cJJw0Xzg0
 4kcSB1MaJEy4ZmWhBT7RgtGayMzdgGqtLRwKIWhqEb7MUqkYZjMVqOLb3zQkNVhySTT8VOL2wxp
 Loxog0F3rN2h1EGhqYnBmsZisDWoHcG5OQhpoZwy9z71FKb8ocIIZ1pQ9BlS9JaFhXqxGjxpcoB
 LZN6yfcqbgq/ZRR2w8zB4l6hDebaaK9nNgjNC0ryYQ64TWMIve8pUpCFNsy2TJ8J3fJOZFYV+7/
 OcHjfFYpPMxI6/Oq+zb6A1b6ksbCdC/26szdCPyCNaB+aGLpKwTS3G0IkYRl/21EJOJPbxwPa5W
 ssIi6v+1
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=6899ccf0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=m1AchfmAwCg5kGC2PD0A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On Sat, Aug 09, 2025 at 03:29:17PM +0530, Krishna Chaitanya Chundru wrote:
> The PCIe Gen3 x2 PHY for SM8750 uses new phy, add the
> required registers and offsets for this phy.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 149 +++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h         |   2 +
>  .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h    |   4 +-
>  3 files changed, 154 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

