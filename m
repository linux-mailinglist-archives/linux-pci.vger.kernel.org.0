Return-Path: <linux-pci+bounces-37727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BE3BC66CA
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 21:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AC7E4F4560
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 19:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28112C11FD;
	Wed,  8 Oct 2025 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PSdS5V7S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228B2C0F76
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950518; cv=none; b=fLFBEfCttkANnQDXkZuo4o9Qx8tbJ27QF0FtQXaLf05hlEECXwLGy7OKw2hlnbUOi9f8PH6nBngrziqeaaHpvFwISPycgxHB4IbAqzWoYS7FkT0GRR0YuwcTd4vUlTsK96WaYjD0+RT1rxpBFYoCtwsGBIP8W1VzmecmsMTlc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950518; c=relaxed/simple;
	bh=36H8OByZz4/Y/E0gK6HuNWj3lJs38jOo6haF23jGHnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8GqPMGbJNrqpX1pu4Vo4200TB73s9EI8Pw40H2/TmvDsTfT+28lSKj//GOPMTAJyVjYYYrjUkoX7HSUr23b3gytE3BcB+rS95yx1cdtCRBeGP1aodUFUaqAB26FXLS7r4Nvjg2fNeCiPvjAOo5q7rz6m1ykhMclgGA9cT6Nqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PSdS5V7S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5IsU027650
	for <linux-pci@vger.kernel.org>; Wed, 8 Oct 2025 19:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Rw+KzFLht2yFEyIY3QTrtR4U
	azMsrTevmU+uxmGDP9w=; b=PSdS5V7S4B5LBHn/bBi7uCxcLnpqO98yWb2aZxkL
	lHs5i9bU4aIKC039KmHUdulwm0yCEhO4dWty9V8u9aY5N4T/vnWejxXYq64f/OZ7
	S63MguaLUpJpbI968PxkYiryqfI1Z8c6uhPzDa2WjBu9GrRcv0HB9ABQ5qlvLTAN
	la5vrp2lBgE1afSvxkRgwqZXXfwxNDosmbqLLrDPJAzNStM+qH3o4D+S/3f2DZdD
	oQjt3tOvTfi0Yxzq3l9gWBAOkmsA1gINUmpL9RpSm/0e/AJZ+GKQFaMotmfLl8NJ
	/JIn/yFtiD8sY+9NwjFQ6JPr1mQaZuQnKyaCF07D5mLYSQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nrb4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 08 Oct 2025 19:08:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e576157d54so5435891cf.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Oct 2025 12:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759950515; x=1760555315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw+KzFLht2yFEyIY3QTrtR4UazMsrTevmU+uxmGDP9w=;
        b=XuqqiSCFwJR7WCwU+8SbHxF3W1yEXWFnJEmkonGpn06xzleQ/opyph5DoE0jzCYsRW
         9QUkwILggFUBSdoCFlDADgsKDJgVt6K32wh6EdChl1Zqo2M5839hWFlYWtxNgDnI46ul
         qhlTlVkBceqxfw0Hk5dHRAs87K5UfJtrF51Kh4V+J03xFRuSsfs3qvL+HmuyYsbDM25e
         2/cY2MFHw4hIzE7MntLzZX1sSjfPHg0bUwWPwBNHMFJVXKuk3xKtMXPDjCYKQtq5UccB
         BKIjDxloIc6AM9EaXRzOAnMKSz+CyCtsCXzAxX8jGKIGgAHdbpT+hJiu8EHe0gEJtyJq
         qtkw==
X-Forwarded-Encrypted: i=1; AJvYcCV4RWsXeTZ46ZGpLNvUBS1jBZL5RLqwuxbchR+d8A2dDv2oXqBxCo9DHZm5KF8FcRdNC5vHPRRc5Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmj3HbcmV/ZW/UJ1AJbM8Vs9W0bbNPLG/3eq+FJYowDxpwSwWm
	Ip++J+mdKlI96OXXLoHg5xaOazWmXynuzZIbpzwmOtFqaaATXRdxb4SZedBY5U/Wh8YjB9m/E7L
	WJcZ/SdaBO18EJQGn7J9CsgT/W6kGNsfsWreD4aVvqfGSiLeA8IU08bqgRkse/ik=
X-Gm-Gg: ASbGnctkbFd0Ff5FKwo13MknSqaDsYMx8DcjTiUe8/EVQhULN2vGUlS6N1nDWZ2eZn4
	XEf14IpgFGgcMUi7IiJdavmciu5UAwp0FsKgxuFcP4szL8bWgQCmpSrqIVxrABAuwNkwwBsweuf
	yKypgdLI0wbI4s/UzjV6c05a+RFHf0T8IkmL/iFiOnEeB1RGa/f+I2CMIm+heX7BnYCSnQGojiD
	zHVVsqiZLJQeEjK6slXfMBiA0dOVkdiBlj82e404HngFXzFNpneBB3pikdgfBRPG90sCVLsccvm
	RRuU3HFb5aWsh+Mx0k70tUV9SsVVM5EDAhMIMR6jXY15wpbsFuTzTgynuVe1Vituf4eDUF7C4vO
	I7ksMJe+R1ygPIL7O2///HRvs+c/4srKUNAphEUwWncI5K7EwV81YSHtx+A==
X-Received: by 2002:a05:622a:4206:b0:4dd:e207:fce with SMTP id d75a77b69052e-4e6ead64a22mr57960201cf.70.1759950514849;
        Wed, 08 Oct 2025 12:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9dfHI26F6tmDQPEhiuoqrcfAbe3ngcx7SImkYRwO78fn/4c/EYGv3VDRX+xMY9m3o8N3kCw==
X-Received: by 2002:a05:622a:4206:b0:4dd:e207:fce with SMTP id d75a77b69052e-4e6ead64a22mr57959571cf.70.1759950514231;
        Wed, 08 Oct 2025 12:08:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39fdbc4sm22092051fa.17.2025.10.08.12.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:08:33 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:08:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
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
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and
 controller node
Message-ID: <qref5ooh6pl2sznf7iifrbric7hsap63ffbytkizdyrzt6mtqz@q5r27ho2sbq3>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
 <20250826-pakala-v3-2-721627bd5bb0@oss.qualcomm.com>
 <aN22lamy86iesAJj@hu-bjorande-lv.qualcomm.com>
 <4d586f0f-c336-4bf6-81cb-c7c7b07fb3c5@oss.qualcomm.com>
 <73e72e48-bc8e-4f92-b486-43a5f1f4afb0@oss.qualcomm.com>
 <8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: XuUH07UYxA9piu8nMbZOEc-Fhv9AoXEp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/CNwMEOEatgv
 AIdCQpKaQtMpEiZFPTsm/oaYSWPp/km8ZqlyCupE11p0gxuBPjgVLgseurQO4xua/IGHc8ukSys
 5xGo6JKikqqGJuiBcB4PnnWSNNSspjaPK1Cqa3T+ZABSQus7Kge3kF1BoXAG+TKIpdd14b1qg3/
 gnqAEDSGPb9ygwG5rP75TjVdi/HvLkxTNxVFPhQjEYwYgy4joLid8lPD4b9QMX/0Hn1j/rLWgLz
 SQLJNncOwp1FeQqN+gmQ+2t40H4ngQ5TdrzOBgmxWCSSMtpzfLSzgM/fMXwJgUMkSe20IflNO6g
 +34X2x/esst66KQsBy/wpPxmcZMCwitbmQ2WcnJHhgbY1igJQ+bU0HZTNq3TgV3ZOF7p5NuB6wd
 +0Fulz/+pzCwKTK6avFGvL8Ic/w7TA==
X-Proofpoint-GUID: XuUH07UYxA9piu8nMbZOEc-Fhv9AoXEp
X-Authority-Analysis: v=2.4 cv=b6a/I9Gx c=1 sm=1 tr=0 ts=68e6b6b3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8Rp3m3j2afKyq596a-UA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Wed, Oct 08, 2025 at 11:11:43AM +0200, Konrad Dybcio wrote:
> On 10/8/25 10:00 AM, Konrad Dybcio wrote:
> > On 10/8/25 6:41 AM, Krishna Chaitanya Chundru wrote:
> >>
> >>
> >> On 10/2/2025 5:07 AM, Bjorn Andersson wrote:
> >>> On Tue, Aug 26, 2025 at 04:32:54PM +0530, Krishna Chaitanya Chundru wrote:
> >>>> Add PCIe controller and PHY nodes which supports data rates of 8GT/s
> >>>> and x2 lane.
> >>>>
> >>>
> >>> I tried to boot the upstream kernel (next-20250925 defconfig) on my
> >>> Pakala MTP with latest LA1.0 META and unless I disable &pcie0 the device
> >>> is crashing during boot as PCIe is being probed.
> >>>
> >>> Is this a known problem? Is there any workaround/changes in flight that
> >>> I'm missing?
> >>>
> >> Hi Bjorn,
> >>
> >> we need this fix for the PCIe to work properly. Please try it once.
> >> https://lore.kernel.org/all/20251008-sm8750-v1-1-daeadfcae980@oss.qualcomm.com/
> > 
> > This surely shouldn't cause/fix any issues, no?
> 
> Apparently this is a real fix, because sm8750.dtsi defines the PCIe
> PHY under a port node, while the MTP DT assigns perst-gpios to the RC
> node, which the legacy binding ("everything under the RC node") parsing
> code can't cope with (please mention that in the commit message, Krishna)
> 
> And I couldn't come up with a way to describe "either both are required
> if any is present under the RC node or none are allowed" in yaml

What about:

oneOf:
  - required:
     - foo
     - bar
  - properties:
     foo: false
     bar: false

-- 
With best wishes
Dmitry

