Return-Path: <linux-pci+bounces-24137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ECEA69279
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 16:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B607A67C3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864E91DED4B;
	Wed, 19 Mar 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VRb00yd1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07721DE899
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396530; cv=none; b=QRmd7Io31nojsZYyggRXVt5mpg1yCqKqZnBnhjoyVAzSK24mmFyfcGoTDov4n/CBIJgnWJJ+W9ua8sTRBfbmLpIrcQI8TV+64SkKiSIs65HzWDXve5I2s2t1+H24alXZH/FMpi97j4OH1dKltR5TgMwauAu927Nq0KNWFKegVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396530; c=relaxed/simple;
	bh=ypBdPJ0mXTyUapwxBRM2LD/hxkv5mKnsOGXBpGKuhOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGZ83KBO97/ztb7J2h30RYcTJFShPFHf8Xxl+8dywGcBoQY4eGV8VklUFtFvQFH4uDXBd9XHsTXk4MsOAbJ10MFqjfrdU30PUFXDFJhAUrH2mJVNNDqablji+YVZt2L7oaHo592r85vnQ+tB0MlVl3rCfF5rQ2e3qdSd9DIDxko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VRb00yd1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JE0hDq012004
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 15:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=k6KTdeiq8dxbjGdE5EAnEudk
	MbvTJdZTGS85nm5lZeQ=; b=VRb00yd1G6GS7KhykHqqBSdekOsb7XSKxM6tIITD
	a7DIQARfv4dMupNSvq03t6fioy/6wmpF9gVoMx2mt6dagFaCmGtdJ7RdXcR4615/
	seacwpw7Nu0j7K75t55hYhgS9RNcpyHR2VdOxWvuuLfk92/gzNNi45x5UsH1x0fD
	ls25aWya7CIIOUeyq3HCS97whawcX1NQ66GPxAqDZ3DCVYlYeGAz3aLIcwJNRgha
	UpZrQ8jPLVd0nurj9YfIxKK8T2A7RY/fTvPlaR5ISVIsYus0TT5nhp3P/bhJyEwh
	n6FlvkZGqnZ9PZecmqk5gSVrLF7MkMBlbifStzd0F6ZlWw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f010nmt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 15:02:07 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-727405aff47so9176997a34.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 08:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396527; x=1743001327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6KTdeiq8dxbjGdE5EAnEudkMbvTJdZTGS85nm5lZeQ=;
        b=l+1BA8mjNBXYHya3nlMMBc1KCCOioOud+YgIFUf1Ax1ccxbQBL1TkbtXBxOn+IQwsF
         GQVMRbueVHxpGnRL0ANcqv0T93r5mPL1mlMXWuOZxYNp04fY9o5yEFKG5S+b2bAn3IRw
         B8e8yiXX52sl+P/4kSVSsA/56KyD0aVA++aWDLHzViMYQtuGEZB5UJZ7j8RKC+PQASRS
         mVWrF47EAAPKW+q3O638kFJkXQNeV9xXR+ipy+wNErkbhNhO3KBplf4z+cGmuX43HY3E
         AUHk/yuYbK3KV/Dcsf8rfcKTB88FDwd6Jd7jLteoBq+/a2q7HSAKNfowsPvtovTGkwyX
         XFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgpsmr74ELesKeL35zhdQszpaVaLU29YNNVIPavA/1cjjZ/2aEmZ3tn7ML6xj2LS+yukYJeCbuG44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzoKWrA24FID5e4BfyARZ5uSzucn9P/l/0JBX9Hlz9DPgxD4O
	AshkeZtTnLlV4t1KnoTSJ3QMg1o37ahwX2tPcwT5Y0BbsaEKDz/SvpOIhP+J3A8tSF+GZ/QNslG
	xBfVGOla+fJ5ekt8hh00ieQhq86P1cWmBDwGZIDP+tfN/CYIPeqFArUw7urU=
X-Gm-Gg: ASbGncvP6hf5GqmRAfvwoFByki/WyMjQ16LiTc8BtzR8CBTaX3inFHfoH57GJm3exSA
	fBrnK0zgCvWvNVi9mA5VbsXon98/hh+52CKMSv6K7cVMiUdTeRzwqSbh8/e4ng8624BXtJ2FXOd
	UM0yEwf3lMHLnhURI0EOCGdO7g4xirbTCsm1xbvS1EbcI6Zu+ZRecXa2/cGxWyiLG58CVUaBuSo
	mItdb841/bQxFrPQaoygqRJqw1Gkd9lY4RZ9pO42k9fQFjuhtZnMfRaQ5xVyypG5QUqMN3w4uZ2
	MbnrRMxexXe1TngvGHVPzaGG3ZiYA60BE1dGNvF6kZ69cZGHRtOrLfsAws/qgHcY8QbtnWeWJoM
	NoIE=
X-Received: by 2002:a05:6830:258a:b0:72b:9c34:1361 with SMTP id 46e09a7af769-72bfbdd837amr2980823a34.15.1742396526706;
        Wed, 19 Mar 2025 08:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp82vW6CDw8+kT4t7XMK20uo67eznB21+X+P3s6Kc1x537nTWzYxocTvvNIrK4Cbq7RAvgmA==
X-Received: by 2002:a05:6830:258a:b0:72b:9c34:1361 with SMTP id 46e09a7af769-72bfbdd837amr2980770a34.15.1742396526124;
        Wed, 19 Mar 2025 08:02:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0d26fesm24172481fa.6.2025.03.19.08.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:02:05 -0700 (PDT)
Date: Wed, 19 Mar 2025 17:02:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
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
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
Message-ID: <5uh7einhu5uxkg2s2wda6ut5ho2fkstk7m5cnhthsh6clxnjhr@xvnkxnx2ygh2>
References: <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
 <8a2bce29-95dc-53b0-0516-25a380d94532@oss.qualcomm.com>
 <CAO9ioeW6-KgRmFO93Ouhyx9uQcdaPoX3=mjpz_2SPHKiHh3RkQ@mail.gmail.com>
 <16a9ff11-70dc-22e9-bd3c-ed10bf8b4fea@quicinc.com>
 <hkm76yogjp6fjrldkyatekhg7orcd6wkc43d2e7cwzqfrdxjwh@b4f2rilmf6gh>
 <303194d4-d342-ea4c-0bb6-5f5d0297ba23@quicinc.com>
 <xkjozxbchqi6mhstqctejfk7vmwux4kdff2nyrcu5nxqzxv73z@agb7rbapsvx2>
 <f2e67746-853d-8545-133a-13452548d504@quicinc.com>
 <ip7xacfkpv7gf5w3gdgrweo5z7bqxmkfmvgsjfaurk5j5ac6mp@nqccdhunhwws>
 <38677d30-e2ac-427b-9de6-9e5f1465e7a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38677d30-e2ac-427b-9de6-9e5f1465e7a3@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: KMJVeiVjfxvMKVyxNIDdYedQGZVUPd8P
X-Proofpoint-GUID: KMJVeiVjfxvMKVyxNIDdYedQGZVUPd8P
X-Authority-Analysis: v=2.4 cv=G50cE8k5 c=1 sm=1 tr=0 ts=67dadc6f cx=c_pps a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=88wPE7EdY0131lUj-p0A:9 a=CjuIK1q_8ugA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190101

On Wed, Mar 19, 2025 at 03:12:50PM +0100, Konrad Dybcio wrote:
> On 3/19/25 12:06 PM, Dmitry Baryshkov wrote:
> > On Wed, Mar 19, 2025 at 04:16:33PM +0530, Krishna Chaitanya Chundru wrote:
> >>
> >>
> >> On 3/19/2025 3:51 PM, Dmitry Baryshkov wrote:
> >>> On Wed, Mar 19, 2025 at 03:46:00PM +0530, Krishna Chaitanya Chundru wrote:
> >>>>
> >>>>
> >>>> On 3/19/2025 3:43 PM, Dmitry Baryshkov wrote:
> >>>>> On Wed, Mar 19, 2025 at 09:14:22AM +0530, Krishna Chaitanya Chundru wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 3/18/2025 10:30 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Tue, 18 Mar 2025 at 18:11, Krishna Chaitanya Chundru
> >>>>>>> <krishna.chundru@oss.qualcomm.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 3/17/2025 4:57 PM, Dmitry Baryshkov wrote:
> >>>>>>>>> On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
> >>>>>>>>>> Add a node for the TC956x PCIe switch, which has three downstream ports.
> >>>>>>>>>> Two embedded Ethernet devices are present on one of the downstream ports.
> >>>>>>>>>>
> >>>>>>>>>> Power to the TC956x is supplied through two LDO regulators, controlled by
> >>>>>>>>>> two GPIOs, which are added as fixed regulators. Configure the TC956x
> >>>>>>>>>> through I2C.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >>>>>>>>>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> >>>>>>>>>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>>>>>>>>> ---
> >>>>>>>>>>      arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
> >>>>>>>>>>      arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
> >>>>>>>>>>      2 files changed, 117 insertions(+), 1 deletion(-)
> >>>>>>>>>>
> >>>>>>>>>> @@ -735,6 +760,75 @@ &pcie1_phy {
> >>>>>>>>>>         status = "okay";
> >>>>>>>>>>      };
> >>>>>>>>>>
> >>>>>>>>>> +&pcie1_port {
> >>>>>>>>>> +    pcie@0,0 {
> >>>>>>>>>> +            compatible = "pci1179,0623", "pciclass,0604";
> >>>>>>>>>> +            reg = <0x10000 0x0 0x0 0x0 0x0>;
> >>>>>>>>>> +            #address-cells = <3>;
> >>>>>>>>>> +            #size-cells = <2>;
> >>>>>>>>>> +
> >>>>>>>>>> +            device_type = "pci";
> >>>>>>>>>> +            ranges;
> >>>>>>>>>> +            bus-range = <0x2 0xff>;
> >>>>>>>>>> +
> >>>>>>>>>> +            vddc-supply = <&vdd_ntn_0p9>;
> >>>>>>>>>> +            vdd18-supply = <&vdd_ntn_1p8>;
> >>>>>>>>>> +            vdd09-supply = <&vdd_ntn_0p9>;
> >>>>>>>>>> +            vddio1-supply = <&vdd_ntn_1p8>;
> >>>>>>>>>> +            vddio2-supply = <&vdd_ntn_1p8>;
> >>>>>>>>>> +            vddio18-supply = <&vdd_ntn_1p8>;
> >>>>>>>>>> +
> >>>>>>>>>> +            i2c-parent = <&i2c0 0x77>;
> >>>>>>>>>> +
> >>>>>>>>>> +            reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
> >>>>>>>>>> +
> >>>>>>>>>
> >>>>>>>>> I think I've responded here, but I'm not sure where the message went:
> >>>>>>>>> please add pinctrl entry for this pin.
> >>>>>>>>>
> >>>>>>>> Do we need to also add pinctrl property for this node and refer the
> >>>>>>>> pinctrl entry for this pin?
> >>>>>>>
> >>>>>>> I think that is what I've asked for, was that not?
> >>>>>> Currently there is no pincntrl property defined for this.
> >>>>>
> >>>>> Does it need to be defined separately / specially?
> >>>>>
> >>>> yes we need to define this property now.
> >>>
> >>> Could you please point out existing schema files defining those
> >>> properties?
> >> sorry I was not able to get which schema file you are requesting for,
> >> if it is tc956x it is in this series only.
> >>
> >> What I understood from these conversation is we need to define pinctrl
> >> property and refer the reset gpio pin in next series. If it was wrong
> >> please correct me.
> > 
> > You claimed that pinctrl properties (there are several of those) are to
> > be defined in the schema for TC956x. I asked you to point out other
> > schema files which define those properties for the devices that use
> > GPIO pins.
> 
> pinctrl-x is part of common schema (see gh/devicetree-org/dt-schema/)

Right :-)

So there is no need to define anything, they just need to be added to
the DTS file.

-- 
With best wishes
Dmitry

