Return-Path: <linux-pci+bounces-34321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CCEB2CC46
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 20:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA433AD771
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338EC30F555;
	Tue, 19 Aug 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQ2qppeV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3624469E
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628878; cv=none; b=fNJ0hrYK/+1snbhiljfSOzK5W+qkHZN5w4jPOezW7ExIsZx11wzMOpGiUUdww6HJvlfvQly8SksWaOS+KDuKTOhtgJcyU/xY1FffXUCt3vJC+fj0VyMYtmRiD3hqLLmjhfPZzsUmPAVp1kD73vRYUdSyTbgUSx1q1UqmA7/X5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628878; c=relaxed/simple;
	bh=sbZZCUCtnCLfLw/YHysbPYbpt95Fvc0uamYtlDZ4m9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKEF5bYWE50/d8dvusXSAQejRHoa0dxcCWYx19nkDBnaPAxwkXdyD/51na10dRUdR4l2dMBDCHoSGvD/Td3u1VNa1+bm78Pe0lXC22r/NuGneQ2hZyLgTfSDV07Vqh0u5l4c+FE4xIe1lwcYHRy6ffvcmfYNUngZMRk9DJ+khDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PQ2qppeV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JGxVSD030332
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 18:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fsKi6N3rGd39Et6hXl58o+48
	D1G9aAWyzqry7YPsv9k=; b=PQ2qppeVwsbl4TdPvLEdU55I/z4A61ULSXt2q/PW
	nMogvJgSPECMrhgsSWOkwDXVZULXvHvadbbBUoaPEmgXI7mnPloWACe9lcKu/xHP
	QaNEgGWLNSPDJ3u4JcxhmSNDQOYFLEkedMlAASlmxAgafwGle+mHE+zs6P2Qtqsd
	4/zul9f8GKx5euWwQyH6yVyyODYpwHNM8eD0sAJrneudCAOBnqJJP0LJqRqjUHs/
	N7DPNfk8gG/e5R25I3mv3d2K3oucbiT5b1LTB6d9mjwvI9Lyo1BjVIn2MFttHg9G
	bIgcK72Xs+EQq3tlwoUMPKUk518WpaSx1shbLzKsEiri2g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunwv04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 18:41:15 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9384d33aso51626136d6.2
        for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 11:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628875; x=1756233675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsKi6N3rGd39Et6hXl58o+48D1G9aAWyzqry7YPsv9k=;
        b=Q7n0HioKAh7fawYTOQX6YccqEwdxUlcEg2nU0GkBn+Y8bIih2pbHaAjRykxHULB2vs
         OytVuL2oQS0HHhdhBOznd4UIisIGsHJvJe2b0fjHMMvH1TNXZneuWQge7j30CWerGca1
         SBAsxhIUkTjSZN0JnbZP1AOFX4GSz1sVtD/D5C41sU/UiWt0zJ4HSBbwZpDUuIT6ZPmo
         cF4/2RoHJtFWX0Rpr+w/5sIWazLTSo2BrQpXnkp1hQtjX6osye+pXcIRw9E9VofnR+e6
         0xTYCJkQ5oYkd//66EdB44LFCbKhACwm2Taq+nWIgP6MyIssGbgvEKdMnzdCWtEkf6eD
         aLHw==
X-Forwarded-Encrypted: i=1; AJvYcCWIFBax/yxFBs1wZgYbLGsWzwdLQWsg3BJGCSUHIEjzNzn04sYaDNH3VeuReQPJxOhOCCHK1pakYZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ht99/bdX9tiUplSdddJ429eglfWTfTecAfbXA28tOoi1ZDE6
	ZY5Bo/yzpn73cun4AjgRxnlPFswGeefyeuk4TDAo0jYmw2d3Hk5V6AcjVbst+CI9gRz9ogMktyS
	EMYNxGycTQsPOYYWcpLdYg2sEWXuoiyxEhPEdlwNxgPeYDWvnFfGl9Y8BYb9h4e0=
X-Gm-Gg: ASbGncsObXaSJZ6+tuM6o+6VtXm8TD2u6M+azxwYUUOqgx5uJKqws+2ItLRQb7IQbBu
	zkXe8uMgATzF/wOuS+lI1K6h0cvmiU/s9mzfZUQ3xMADlKE1FH2VBEB0Xwb//QlpjM3AOipKrq7
	s1d0W5iXWrAlu+FJHCaRVYm7TqtjO+mXP1DBQv19iM/Tcw1NwLYGZRrQnSAZAtl4fPouq7ztc41
	c/tZp2b3b626F8oFS7B0tYMosTlihTiM93OkT+ViuzziwtPfyhPoSeHtxU05ybILZtkR2+b+Von
	h9UW3qCOadSUdYa4wXLediVqniSzTfv1M3RCzI/yaBJZXs+AS0RhVGurVwrOlR4ejDC1liv0/Vl
	24gHetutp9HKzaQSQGaFFyVpwuUw+Ti85cse8KVYxm++MsW3WUTbb
X-Received: by 2002:a05:6214:519a:b0:70d:6df3:9a8a with SMTP id 6a1803df08f44-70d771df744mr306776d6.58.1755628874603;
        Tue, 19 Aug 2025 11:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6i+ltbxHJqeyZJnz7Lrtjpq6qWxmofRvnlEwSWnAd3j1242x3FAk0HauMhjYXw0IZKvpbfQ==
X-Received: by 2002:a05:6214:519a:b0:70d:6df3:9a8a with SMTP id 6a1803df08f44-70d771df744mr306336d6.58.1755628873968;
        Tue, 19 Aug 2025 11:41:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef4425c0sm2189059e87.153.2025.08.19.11.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:41:13 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:41:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH 3/4] phy: qcom-qmp: pcs: Add v8.50 register offsets
Message-ID: <kssxh6n7ml7zizll7ifo3ihcwtsa5lnixgwtpbmqh5tt4tiqsq@pex6pl7kcklf>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
 <20250819-glymur_pcie5-v1-3-2ea09f83cbb0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-glymur_pcie5-v1-3-2ea09f83cbb0@oss.qualcomm.com>
X-Proofpoint-GUID: gIzo801ocwKSLKFl7JMZaUb-yvPyPl-j
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a4c54b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ijTbXYptY3SG8TVhS7AA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfXw3hWHRS4xLdm
 4UgQS/+ysS7nzAeIo6uy0HTYKOlLr5wX60a7KUBcSJc+fZX2RfxhZOuhjz5EfEOWSLySknHW1Kf
 CmqyTBhcJjE3q5+laxj7XU+0ZBBKYR+iEKgwBn3q8uD1nTa9iiQYSlF6ZQx0GK1GJyjT4RxrVtX
 MXC22OUzhkLbOUsWQ8MGPeaa9WiFdmFWrXRelHH/ACo5dqzTwm6WFHpUrjizrsx0eUuUaGzlVBT
 DBITvdaGR4L9VEQ0UCsNE6RaHkMPcipFEc1LSxtzCzj2zQl7x+L16EE1KXgBu92o3QkDSmQoru3
 772SkcjSNicv8vQrP5bU6OvGRF9QjOQILfPdH3DQGHZ+Lu4BuRGrGsbPYbOzlkRAGZ6r2jjrA98
 iYkOcGh/
X-Proofpoint-ORIG-GUID: gIzo801ocwKSLKFl7JMZaUb-yvPyPl-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071

On Tue, Aug 19, 2025 at 02:52:07AM -0700, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> The new Glymur SoC bumps up the HW version of QMP phy to v8.50 for PCIE
> g5x4. Add the new PCS offsets in a dedicated header file.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h | 13 +++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h           |  2 ++
>  2 files changed, 15 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

