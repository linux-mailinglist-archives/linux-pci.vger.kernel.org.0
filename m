Return-Path: <linux-pci+bounces-30163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B37ADFF4C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 10:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AF33A4F36
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 08:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3479A219A67;
	Thu, 19 Jun 2025 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="niyOCXat"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711525D90C
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2025 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320028; cv=none; b=kxCYvzpqqUJjcjsG+rxHX25USsKKhYLde4PYCOFM6ndwvmGDVoPrxKH2hUfqXI4SzJfBa7mg86TFd2+6Pzsl2eZx87CROaG4vJsQlfsJa+0MhUQZIH+3sYqcGabOadLKESng+SdL+7kuFWiMwjEvD89hvKFEdcgOU+JBVevC+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320028; c=relaxed/simple;
	bh=wMaMYUd6M4iPUB+6W02x9RPOUf1vRDMFQbyKwn8OqgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMU+bH8YFH8GJinXrzQkuVtKCCW8eFcr2UW5cf0lFrg9IY0cDwIVSKu/myczXdD95rpZH3rypeXwOEAOtWUTmqx5dexFVFa+QFcTmf+Y0cmC/xCuj+AYbX7/zx39ymHr2lyaW9vmuC3zdh6oEdm0HNmlttQ0VTLWnbTcnWST9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=niyOCXat; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J4UFsh032725
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2025 08:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zBolN5oacxC0P41K6szANjJ24uE94hXebudQ19uN7Vc=; b=niyOCXatXE3NVwd+
	Rkwixu4yq9sq8U/+eSIBixS3OwlbFzGe4GgFFfmFHCs6i/wlpOBmUZ6RX5IAAuTm
	DakOpqraIU4clXJSyAl3RygvI8raZpmB0kCqxjAPvj9RHPZbp2b6yuxikIQ5EQY5
	dBUt9PRwY7lSQGzo2lHQa+2K2xTTpIW+gj9vlZYiYdHmcpWDUEgxIKaU63FEsLTK
	pkOBtkAFLW08p5YWRm3pABxJ56o+hF+poh9cCLA0Mu4Dk+F27WP7ZcvmodhxwTM5
	+rrw+7t4eDDkeZLQj9YPVCPsKzlObIHll42SgrcTSZxFk+/Yf7Rq1DV/YEL0xfYv
	PvZbbw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4792ca77p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2025 08:00:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-740270e168aso499604b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2025 01:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750320025; x=1750924825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBolN5oacxC0P41K6szANjJ24uE94hXebudQ19uN7Vc=;
        b=rFvqOJgSzO1xMjE7fVbGiBOsS4fWQXBJ+SMJ1C8P2Ewmxp8qdT5NpNIaMzGDB33ST5
         RUVwkajZIa9D43VYa4wNW7z+jrErEuCJzPQj9tlLnqGN7n13Z7r9GYluMIci2HnKobTJ
         A102JHxjW7xpCaTpxeFo1F6G3xFT3hVZaZSTqDL/W0Zw4iY0AFQUAlQ3Y2kDBwR1v3/k
         D86Tyg0UvmcQ7/3awQ9DEGUdg69gP+DAi4I9u7J0F394WLQkkdFOrbx+LqyBIeydrJb1
         /HtlvOKqtLrp6GZ1PDXKmPPYH1Un6SOMkwWJ37NmfKHzJn255bWpygN613Z3iah4n0dp
         t+5g==
X-Forwarded-Encrypted: i=1; AJvYcCXM8G9QpFhZhvszRZgrsSHVw4SpGfN3lZkB5v9jRrElBduAlEg8umCwEit5799WhDxwivKX8GqQT/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9hQN8TTnX0YIObUJhCbv1mRjEOUiJmHdnOQYf3lTQTB4VvLUB
	FsiKoaE1+U9FPTEttxyVA1xfvB4qkNK9QZBiLXxP28+igLOiXl1LsH7RU21sNF4iNLjND//qAdu
	KbScVgdZtDj/pPdihX7xb0GOSwd0/Wo1FX4SD9ZPTStBP9MkXdDx7Bb4yNHke9QA=
X-Gm-Gg: ASbGncsRvW9Udmehy9fVeowkk7ryCRr2MrrkcO5Ov0gAbI5qTaysXAg/otsVqvGBGaD
	5jveR7/l9lsxIFKy90WeXRQt24nbF7gTHhxdFsI8sFL8wN3p8SW0OoDjFdS8HLQpLuOev4EJecU
	uScXcIASDp9sYyQ2vHMJOZQP1+zqS/UFRFPITQTTBBrOxkt3OEvxc4QY6ddpKk+0c3Trs39m5Is
	bwH/dfLSMqeVKEsdI+C5BT71dC5NUKFXgs1jr/OTTtMVUwbnDomxAhDbfrCU5U9kb0FBa1Elw6Z
	A7jvhPygw/ntIBhEHU1ECuAPTZYzb5IOccB2C1CNJLjdwLEXKP3vrTALoIKWHHIkxZCdnw==
X-Received: by 2002:a05:6a00:228b:b0:748:fb7c:bbe0 with SMTP id d2e1a72fcca58-748fb7cc2d2mr2897049b3a.24.1750320024830;
        Thu, 19 Jun 2025 01:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeXph0uurb6f9i+olydyrvX72jabH9v+6bXULYDipT8b9iY6AU8w1map6IEpxVIXRkai4iyQ==
X-Received: by 2002:a05:6a00:228b:b0:748:fb7c:bbe0 with SMTP id d2e1a72fcca58-748fb7cc2d2mr2896469b3a.24.1750320019594;
        Thu, 19 Jun 2025 01:00:19 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900ce7adsm13061762b3a.149.2025.06.19.01.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 01:00:19 -0700 (PDT)
Date: Thu, 19 Jun 2025 01:00:16 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, krishna.chundru@oss.qualcomm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/4] dt-bindings: PCI: qcom,pcie-sc8180x: Drop unrelated
 clocks from PCIe hosts
Message-ID: <aFPDkFUEE4BzdJh/@hu-qianyu-lv.qualcomm.com>
References: <20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com>
 <20250521-topic-8150_pcie_drop_clocks-v1-1-3d42e84f6453@oss.qualcomm.com>
 <qri7dxwqoltam2yanxicgejjq3xprd6cunvpgukasmtt7c5lmh@ikdl24royen6>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qri7dxwqoltam2yanxicgejjq3xprd6cunvpgukasmtt7c5lmh@ikdl24royen6>
X-Proofpoint-GUID: twdz7WvwJyGgYO76gFKz3LESDhn6Lcm0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA2NyBTYWx0ZWRfX7yujiYwysoC4
 7rdeauncNepo97Zx4mq9XbMEGJGKWxAMz82a38gD106En+cu5FEemBr+3Z6cBBxTikBY7CGGAEd
 rGagR8U2fuJj3JOZc4fIb0d97A2PPInIuFvEUxAgdNXbuZyyfgdrJvMU5qHYpUcw2ylRC7/b3Mm
 iDU1CVlpILE/vZu56/9H/uPnbLdSMomWBeXoOKp7xHGmuO7OP8sDkgGfQKvoIqQx8tAt4rimTkh
 aR4XPKX61StbW8xc7WkKoTJ6z2DsRfUCJs5RBK7euvxadrU4kHAZCqTkOrnIoZDIoGpNfacgMjh
 Rh0nPxmxuhJGPXolHlLJlE3fCFZqqN3SzQnAKXftMvy0uR+1f+NbOfZ592AvVUCW2ud0CJSIRbp
 dDC/srKV8ajN4g4ZkeRBA9MH1OXhgbYFTv7vkgvKKKrdD/F1dP0P9gQHWwSXYuOkCNb6slk6
X-Proofpoint-ORIG-GUID: twdz7WvwJyGgYO76gFKz3LESDhn6Lcm0
X-Authority-Analysis: v=2.4 cv=etffzppX c=1 sm=1 tr=0 ts=6853c399 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=3eHYEclfckd1VWwzELkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506190067

On Fri, Jun 13, 2025 at 02:43:38PM +0530, Manivannan Sadhasivam wrote:
> + Krishna
> 
> On Wed, May 21, 2025 at 03:38:10PM +0200, Konrad Dybcio wrote:
> > From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > 
> > The TBU clock belongs to the Translation Buffer Unit, part of the SMMU.
> > The ref clock is already being driven upstream through some of the
> > branches.
> > 
> 
> Can you please cross check with the hardware programming guide (I don't have
> access to atm) that the 'ref' clock is no longer voted by the driver?
>

CLKREF is required for PHY. Since it has been voted in PCIe PHY driver,
omitting it here is reasonable.

- Qiang Yu

> - Mani
> 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml         | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
> > index 331fc25d7a17d657d4db3863f0c538d0e44dc840..34a4d7b2c8459aeb615736f54c1971014adb205f 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
> > @@ -33,8 +33,8 @@ properties:
> >        - const: mhi # MHI registers
> >  
> >    clocks:
> > -    minItems: 8
> > -    maxItems: 8
> > +    minItems: 6
> > +    maxItems: 6
> >  
> >    clock-names:
> >      items:
> > @@ -44,8 +44,6 @@ properties:
> >        - const: bus_master # Master AXI clock
> >        - const: bus_slave # Slave AXI clock
> >        - const: slave_q2a # Slave Q2A clock
> > -      - const: ref # REFERENCE clock
> > -      - const: tbu # PCIe TBU clock
> >  
> >    interrupts:
> >      minItems: 8
> > @@ -117,17 +115,13 @@ examples:
> >                       <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> >                       <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> >                       <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> > -                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> > -                     <&gcc GCC_PCIE_0_CLKREF_CLK>,
> > -                     <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> > +                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
> >              clock-names = "pipe",
> >                            "aux",
> >                            "cfg",
> >                            "bus_master",
> >                            "bus_slave",
> > -                          "slave_q2a",
> > -                          "ref",
> > -                          "tbu";
> > +                          "slave_q2a";
> >  
> >              dma-coherent;
> >  
> > 
> > -- 
> > 2.49.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
> 

