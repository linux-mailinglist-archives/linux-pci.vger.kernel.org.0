Return-Path: <linux-pci+bounces-24088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463F9A68933
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 11:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B7316D091
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 10:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E079E2505C3;
	Wed, 19 Mar 2025 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M7DAHyEz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC324FC1F
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379233; cv=none; b=lEMivd9YtLpUaJVJZSFSwRwH8hI5j4nL2SGiEvbBqa2Iq58mZMicJlBy4Q56tYVfSz3G3ZGUI/IikYiNGV6G1xdJYxa5QFTgpzP/tPssQlpEWywEwblyJk9GFAPR3/od3Y0Tj+0+UvjR8ukS7kxvwQCaZxoitUZImwMNLA1Y1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379233; c=relaxed/simple;
	bh=y9h27SLWPoVDltB6CIbW/qHjd4Js5SJZr7Tx7UfBrGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tauXRIuc3QGIanJDqTBpmAPMLyLGmhxt6WuYhSJwC0ev3oKtQ8/5AsAgL2nTv0zaOJVxhZN7zPK9EjodSt9n8SlpbboWep8bmNiqLRZUPnp+Wm6a1b88aihv8C9I85PMr8HxdihTYqs5q3A1dpl155Y14mo/Vhm6Mch5g/1AYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M7DAHyEz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lqcJ002134
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 10:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nCdGea/fniAjYxjTkptR2PXN
	dWdSDj0g0BJrfvxohsA=; b=M7DAHyEzSwjiT5zIwIMh/eTqV6NbrNyibg6Ravij
	2bBr1C5UUdbw/3C3faJj8CNqu/qSoLAVQtiH8zwBGYLiDWhKSHV3qxNhg76enC/w
	+TlPprjEJyKrltohukWZXzJpnHDWNFcGZw1iSCxpI4JPWW8ZfOEjjM7CjOVJ4bRK
	vTE/XXVMboxnxXWwgUD0WN+k3v+qtUZyyCFQXD/2mfRPpnds0130IiieaepTLugv
	LvcyudIsB+pRyubkVBlQsQXUW+jIKLPmUcoU+HtsgRmYRgkOScE8myu8QO15Mq7u
	7u6Es9LX7YF3KoqWg2TLrhxEoVrNZbF4yyGK1/3QvX5JLA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45etmbwgy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 10:13:50 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8feea216aso10353406d6.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 03:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379230; x=1742984030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCdGea/fniAjYxjTkptR2PXNdWdSDj0g0BJrfvxohsA=;
        b=Tpa50QYlCyPMvKzHsdhjnazeRTHWBu5+Cz378SxYnxtEQcKdd35d83cgrszMiGLS/c
         /6D1+4RPXitdenmRHzJxIpPYge/fAKsq0ybrqhAY6IOoT9mF4hKMffWxjycp3q3DEyNM
         tuBVqzRcJu0vhyK/2nijKCkNBo0IL8QNAB1X7nj4ThsA2Whs9rs/MQVv4+G/m1mhxMhD
         YAUVqxHL1bpXyS2JuKEEJowNcYId9OWnJfM/WQqEA9roCquvUXDbFQwYvDwJrnSmP2K3
         kB0zYyDIEb3LvHfEQIaYrmstVfA5p+/j+Dztc733Srxz2vqO0sRLOn12VFX5a6BnmiKH
         hvhA==
X-Forwarded-Encrypted: i=1; AJvYcCVmCvh4ewvK6iy3bP92rKYY/BasZXU/yI6EFG8VaRF8Z9bVC/3+dQZKHafRForXa+QYjGSODkCIVhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU5EstFFuKtgcaHolubIRUuTHmh+wCHl1d+6T7j+IrCMqpvwPK
	vqPjIgequ+ljQ0+gou3b4HsZHM1bD79ZqbNLqGkVhpLlgQQsalhQKIDrR6B0/fNAko2AD7ajpXv
	wbHn4bQhkVOnKGUCA9n7wWk+0/WQe7xGQ3vbjZqL97MFSsViQ59pIGfQ34Yg=
X-Gm-Gg: ASbGncvmIE4EiEy3KMdPSZ5cjexMK82e/2cE4EjyEYgCCP2Uz82964nPDoxkXTjdhjs
	gkEPo1Ka+pEyI0XpMxy/ZdkUx1NMVTnrwq/Uhcxb5gNrFyqeZKDB8OQf1NOMcHU7JD9IQ38qtwO
	v3/JZEkl+ntD+OUeuX4f0s/TadqvWUw3NGgo7WWxOSIDf0GTcR0Z4YMF1L3KyKSeJ/4YQfPV3u3
	Mwaqn4dDDLZ+APdW/vzamsdUqVmJV36Y8yFb+OTymJnMWOxm8q5w5EUfb1F6A/42FA2hHP7vLn/
	mDF51S7VnM7+YMlQENWsBIQneh8TkmprCfl10nPvbeMHLI/Il8O+oY4iHbeLS/u/HfgyWMw+daO
	B1I0=
X-Received: by 2002:a05:6214:4b0e:b0:6e2:49eb:fb7 with SMTP id 6a1803df08f44-6eb1bba4639mr102881556d6.3.1742379230262;
        Wed, 19 Mar 2025 03:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeKxKTUxvOd7lS/OAOZc/Z4Qp58eBwPQpZlvy6aoebQ9tHl+QQCrVFpJLLrXFT7oAhwv+f7g==
X-Received: by 2002:a05:6214:4b0e:b0:6e2:49eb:fb7 with SMTP id 6a1803df08f44-6eb1bba4639mr102881226d6.3.1742379229910;
        Wed, 19 Mar 2025 03:13:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ce032a56sm1096024e87.78.2025.03.19.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:13:49 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:13:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
Message-ID: <hkm76yogjp6fjrldkyatekhg7orcd6wkc43d2e7cwzqfrdxjwh@b4f2rilmf6gh>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
 <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
 <8a2bce29-95dc-53b0-0516-25a380d94532@oss.qualcomm.com>
 <CAO9ioeW6-KgRmFO93Ouhyx9uQcdaPoX3=mjpz_2SPHKiHh3RkQ@mail.gmail.com>
 <16a9ff11-70dc-22e9-bd3c-ed10bf8b4fea@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a9ff11-70dc-22e9-bd3c-ed10bf8b4fea@quicinc.com>
X-Proofpoint-ORIG-GUID: cn7iEXOMl5rV435BTaIfS1OIzSdS3b_w
X-Proofpoint-GUID: cn7iEXOMl5rV435BTaIfS1OIzSdS3b_w
X-Authority-Analysis: v=2.4 cv=aMLwqa9m c=1 sm=1 tr=0 ts=67da98df cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=GjCQcdzxkWFPqvLgVS4A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190070

On Wed, Mar 19, 2025 at 09:14:22AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 3/18/2025 10:30 PM, Dmitry Baryshkov wrote:
> > On Tue, 18 Mar 2025 at 18:11, Krishna Chaitanya Chundru
> > <krishna.chundru@oss.qualcomm.com> wrote:
> > > 
> > > 
> > > 
> > > On 3/17/2025 4:57 PM, Dmitry Baryshkov wrote:
> > > > On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
> > > > > Add a node for the TC956x PCIe switch, which has three downstream ports.
> > > > > Two embedded Ethernet devices are present on one of the downstream ports.
> > > > > 
> > > > > Power to the TC956x is supplied through two LDO regulators, controlled by
> > > > > two GPIOs, which are added as fixed regulators. Configure the TC956x
> > > > > through I2C.
> > > > > 
> > > > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > > > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > > > > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >    arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
> > > > >    arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
> > > > >    2 files changed, 117 insertions(+), 1 deletion(-)
> > > > > 
> > > > > @@ -735,6 +760,75 @@ &pcie1_phy {
> > > > >       status = "okay";
> > > > >    };
> > > > > 
> > > > > +&pcie1_port {
> > > > > +    pcie@0,0 {
> > > > > +            compatible = "pci1179,0623", "pciclass,0604";
> > > > > +            reg = <0x10000 0x0 0x0 0x0 0x0>;
> > > > > +            #address-cells = <3>;
> > > > > +            #size-cells = <2>;
> > > > > +
> > > > > +            device_type = "pci";
> > > > > +            ranges;
> > > > > +            bus-range = <0x2 0xff>;
> > > > > +
> > > > > +            vddc-supply = <&vdd_ntn_0p9>;
> > > > > +            vdd18-supply = <&vdd_ntn_1p8>;
> > > > > +            vdd09-supply = <&vdd_ntn_0p9>;
> > > > > +            vddio1-supply = <&vdd_ntn_1p8>;
> > > > > +            vddio2-supply = <&vdd_ntn_1p8>;
> > > > > +            vddio18-supply = <&vdd_ntn_1p8>;
> > > > > +
> > > > > +            i2c-parent = <&i2c0 0x77>;
> > > > > +
> > > > > +            reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
> > > > > +
> > > > 
> > > > I think I've responded here, but I'm not sure where the message went:
> > > > please add pinctrl entry for this pin.
> > > > 
> > > Do we need to also add pinctrl property for this node and refer the
> > > pinctrl entry for this pin?
> > 
> > I think that is what I've asked for, was that not?
> Currently there is no pincntrl property defined for this.

Does it need to be defined separately / specially?

-- 
With best wishes
Dmitry

