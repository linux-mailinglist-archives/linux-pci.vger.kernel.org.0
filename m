Return-Path: <linux-pci+bounces-38413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90C1BE61C5
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 04:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6965E0B93
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 02:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8240244660;
	Fri, 17 Oct 2025 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cy/oem3V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA823EABE
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760668560; cv=none; b=tnsaIBJrQ/DqT3wmgrfmCTyhDzj6vV/duFkADdV93wjTL2EasM371Kul7M6oDGLsimV47oXEFjzIX2mPjr/Ud52Ti+z8fuZ6CbToGAXkDH0cx7DugNbHJTx5F6qQCG9y1oipxPkcDgE30PYdC8VDSJWsr4Wb93aStigT7dIre7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760668560; c=relaxed/simple;
	bh=PoY93QrFluiRf482zySA19jKnEH/DBPNuZphN1G6VcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBTUpeUhZYs/tuHyG8oDS6hOlaSYSp6JruZwJyAyUMfIGCx7gfTabX5g1i2DLgOMryM53KYfUxgPsBiLOtaIiJeu+BZ79dROb4ud9dZ/0Id+3yOvMn9vFph+F3v8zBffoyW1DxOSmGPtJ95ng2hiwJ4VFW9kk/FMQm2Cm4hYH2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cy/oem3V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLQv3025269
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 02:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pnta0ElwtxRwPXhkcckaPVCu
	qE+PUgPrCXZcvvyV8VU=; b=cy/oem3VT/N+gkNmaxhKasRfMmHNHtM0/B1QS2l0
	zzK3JBNlR/jZ62z3fp6IKF4UseUftnd12jwgPv7qCGN8HEAk3S/5aG0o+YgXBP6D
	YwPaelPkXozleWIVid3Me5eAOJrBDEzXDup8XeCKzRpEfh1mPzkrbgS4fZ06GEMZ
	G17dHHS5wQWr3DjJdxx+1JLCmbxEChutOfNm/dTZ6JOKCV1fIMrWHSu22uLcqLOW
	28l5lwJ8otRaWZb4ecCrvCw+PEIPuiiVGHOGUl/WENIJTqKXjrdquFjhr2NvARQz
	+si+dT+RzFLwLNDCfotFREn2ziHSukT9eV1dwKHSzZoDEA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkjhqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 02:35:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33826e101ecso2794402a91.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 19:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760668556; x=1761273356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnta0ElwtxRwPXhkcckaPVCuqE+PUgPrCXZcvvyV8VU=;
        b=mfj/G7pSFH4QJ+jsWTMEewgTPEtjabnISJX0IZhxhBVJ/zZXWplQ44agpxbIKolRk2
         /wCX5b4GFgZVIJgWV1+daGXIw87NEKgvAdzYd8ik1sNsR668a3CGAukb3W+PJeUfEC9W
         Wb7IHnpNPYVFzbYwQdnFNnYcY1jJ+LXtFl4O3WCpY15lqHDk8rKZP0p2/rRGo8rkxxvy
         4UITbKvKh9S/Eij+O7vl5+YqaFVvN66xnIWCVaMp1Ae2tf5FLMG+PB1i93L44N8opKMR
         XHzxp16Lny0mVX3Am0G4f8bymIHxPdBpk9T1rZYX8XZSl5+0GiyFrMHeCt/aJrbBk9qH
         Sdjg==
X-Forwarded-Encrypted: i=1; AJvYcCUiPXddGD5pAbr8Q2F10HsQZCRTUfvdEANkvt0TYfj2H1CigkMeTMLk4cr7U3tB4mwTeeHSE0AuTog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx11wNhJsOnnuyZ83ZxjNj8ZwyB9rVCu3JADbbSJYoxiVuViqD0
	KRa7dx8z+zMhRpEcGj8hPGepgG9Y6KR0QQfQS16FHQo3s5dey3lKYpggNtQdBlfjOMbi1s7BQBQ
	kzQzP0Nkt+bWOmB18lzTSZr87VbuNrB/BQtW8Cekpd9diD+UCMzTTYy9uOAUiOTM=
X-Gm-Gg: ASbGncted6I7KI4H252mWXEG+8Cw9oeDRXNXKiOCCrlOC7Vwe9frUyKFHkyEOmvieti
	q+gEV3PmefwGdVqjY7epfdqnH2XJdZn/yN7HL6pCx1Q5j1PnHeCeLeG9xrdzxovcriaz++DL8eX
	LCwsq/v3+p8DhUblzryNXd5X+SHLwVA4IYowuf97R33qMU6UDFweM0XoeE/rFZtlb+qid44AtDI
	HbWv0LmCnn6US4nlJRHbCruSgsXQKclsPGMQ68BvsQM5VrWUT6xHiIeZhqrDpknFVqEY13tDsQw
	HLNNqIuMtEYJaKKvq1/qUSiaA1HS++BgGdn5xjcuA0o5nJxCReh/O0sDxJmp3Ggg9aNfy1A6bl6
	nWrTbNJr+g8sSwiRfGAG2VBL810N+BPM2W9pLboeuujxXyg==
X-Received: by 2002:a17:90b:3b4f:b0:314:2cd2:595d with SMTP id 98e67ed59e1d1-33bc9bb57a5mr2474414a91.8.1760668555625;
        Thu, 16 Oct 2025 19:35:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWaqgs8yi7UTt2AbGY82T7BUeI2rUPDLBynvD9H35dUeDbKXFf60ihFhe6zjxdPRmQf21ffQ==
X-Received: by 2002:a17:90b:3b4f:b0:314:2cd2:595d with SMTP id 98e67ed59e1d1-33bc9bb57a5mr2474387a91.8.1760668555176;
        Thu, 16 Oct 2025 19:35:55 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd7b3da78sm946297a91.19.2025.10.16.19.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 19:35:54 -0700 (PDT)
Date: Thu, 16 Oct 2025 19:35:52 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Message-ID: <aPGriPZ3u54RCpVx@hu-qianyu-lv.qualcomm.com>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
 <20251015-kaanapali-pcie-upstream-v2-6-84fa7ea638a1@oss.qualcomm.com>
 <k7xjihanbqelhm6pytrugv73pc6bmspn75vy5a2thcqnxkzwhd@bsyp2nqkl5rf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k7xjihanbqelhm6pytrugv73pc6bmspn75vy5a2thcqnxkzwhd@bsyp2nqkl5rf>
X-Proofpoint-ORIG-GUID: lCh_HY9sWuGWT_AaZWUYTjowUVPqSldw
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f1ab8c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=SE4x-66S8WGdbeowD1cA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: lCh_HY9sWuGWT_AaZWUYTjowUVPqSldw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX0TWCpaw0m2PM
 IbMxcvHQKifsIbLZTZxjtjhYAqcXfp7HfURaRlnhBA2t7a8Nb07WLWeb3X3pmo3R6AkdNI4VHTX
 HwBzN23omYRxqgU7lsievQZRx2gDEHMdhk0spdI2gjreCb+eytljbogBdj4TlInuDEYCCpoPlss
 wc2rnGc4yIkOpyJQvALWngfIROeh2wgiLPWlB5zyxGBi84nD/1mtjIl+nY2crljpkEHZqPoAIK3
 dzz1mWwqe3337qT5OUAPC2qbYlBV48YUoo47s2oPI+ksA0UmCqmY530QlWAJEmspqBtVnX2hCWA
 A78RMqzS8mPlT3oJf71fgpcEkIzsw9BJkapyYB+NbkVhBMPKL3wzzdvCkqivA8SWBgmqAVSqxZs
 wdw6y9W46/fRVpA8uZqQ4NOLFpAdyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Thu, Oct 16, 2025 at 03:05:15AM +0300, Dmitry Baryshkov wrote:
> On Wed, Oct 15, 2025 at 03:27:36AM -0700, Qiang Yu wrote:
> > Add QMP PCIe PHY support for the Kaanapali platform.
> > 
> > Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> Who is the actual author of the patch? Do you miss the Co-developed-by
> tag?
>

I wrote this patch but Jingyi help submit v1.

- Qiang Yu
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 194 +++++++++++++++++++++++++++++++
> >  1 file changed, 194 insertions(+)
> > 
> 
> -- 
> With best wishes
> Dmitry

