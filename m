Return-Path: <linux-pci+bounces-24111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0368CA68B3D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 12:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4DB188DD28
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0719B254B04;
	Wed, 19 Mar 2025 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QHEP19yA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB022505C3
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382404; cv=none; b=pSqb1b7DQFni8Tbjb6EYcIvoW9WuQif+LiZUvOkVJhMejBsHmBp0LxyAYWzmRBPdAALFuse4wAQzkN4NXpsi8MZjGLAiE7T0p3bysONUnNZQObJqN/2iqDZhMDAR22QU15H00MsN0rQFjvcndQWB2X4XEJRPxPxvEvxqhJWaoXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382404; c=relaxed/simple;
	bh=+6dINfWYNledSDKrXEMCld5larCRcQ2l9XF8anqBVjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdH2uMcsRWVles9rgELDltfcwsIUmt8bc7b0klsSMLHsfL1vKvdUdRvpxNw7IO5WnhRiJ0f/cpGzNQkOeroWlkxQYwReSnPdeCtLdLD7mzA799aRiel1gs4iFnqCddbZ7EuyH0U1c1D6oX0z1tqeyp+oFn3oUY8GUmkxKYkrH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QHEP19yA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lkD5026940
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 11:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zpsXstT/OPpXfwxen2clafNs
	aafRQUG65nkBT0J8LsY=; b=QHEP19yAAefK9EtYpTBUzF1zrikRg2tIl8LSwLsS
	743G8O6EXY9jdDTCgqz3mXxf7zJ037zHg+MaRzb+EOav9X2pCuP9+Rdk+Fa2HkRk
	4UtXGSzfGYAT88ukdMJQ5MK1WbeunhJKF13WIosb6JMVHASK1aVFEUHtBvp1vMQF
	Wd+ngZvh+XUrwUiY5lL/1lfV0WSLYfhENNKh58Z1d7Iaa1m+5npEUAACQACFLkNx
	n4QTf9EcARzc4s79RfAqYTNDw2KAJPIqZPDYeJKD9ca1UmTgaPG+fez/EDtR1YcZ
	Gv7cBK8ZM7nJzc3vBLTzVClNtMAS4e/PEX5hhaHRRplwiA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f91t36kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 11:06:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e9083404b7so135196206d6.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 04:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742382400; x=1742987200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpsXstT/OPpXfwxen2clafNsaafRQUG65nkBT0J8LsY=;
        b=k/MVL08GhZA3HOtMUXvizjAzfSoiEO+mNp4YekVy059bznRhXWZMV8pgdiojnidT5t
         VUvylPVzu4KVlhgAaRG/rlF+PBrp29MEOtyh4Ft1FfnY6fIWb1ukKSNnrYWdfpv8N2qa
         aKsq7J0ctITVOfxKB3jTunO+xxDdYaNsjQqiZb2GpAcxPpZcN+pEYUu1GKkv90XKUsp0
         jyKsSjkb3yVjs6XTMMhiWoLx2Ow9lk/FXqK/2i8huYqzfZCgcmtf1Ulb9wa0F7rG3CMC
         jZIZXsuYYnJ969RtnODQfajCKfKwazzcafJ6TmrgQY/4b7yc2Pp6/qedsqrh5x9EzuOi
         lBcA==
X-Forwarded-Encrypted: i=1; AJvYcCW7CKFOV190vAlQq1s/mk3ZtM+3LgLlS4XVpW+AEf6YJFMXjPIJEOhX60PcXB3tEfbDsZuRTqG+dAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJeU3Un9WMPcDvfX72pEpSonc3FZVoMpSTqn1PRgqIeVGfRhp
	MhCM4FRg0hy1F8oq8YyYfUGvzDVRJiJiMfphjS6N2gKXHnt8gPQSbZM8soPNiRo4BY6fjKY7cqM
	WYNLmYq82ngOr6vLwcYXxCsB1lxc56yh+LuEzXrXhDXzfY8VjeOPbN3CUS/o=
X-Gm-Gg: ASbGncuSQj21x/S7ytnMESaDv25uB+UdGl3it9KMrhsHEHaFcAwMl6HdOBePS5VJb6A
	Y27m9QGmIbl80l+t0BbzafM+cudZVK9/XxQ4DJNzi5BzROifIxOjRRJrLCQZTSJnTgDk9qXaoRo
	BM/G9yRcxGVSyG7dvF0OQQVIPY74s2cDtcolzT6M6j0m+4NPbgaaIUQAb7a7wuk3vr3sdGGaAv0
	ZuqWviMgcFEYQKS0c+ysYA7s3sWuvTZtyEj3tHwqUES7dmQkJD0WRUt/TOVrItWeBsRSB5IF/Cw
	G00RoE+vFKV08AkwrIHzJ97hJn5ohKyOkjdO7vxRxqp4sqqpvtV8Y5lUhlIXq25mbJtjXFyRTj4
	66zY=
X-Received: by 2002:a05:6214:2529:b0:6eb:28e4:8516 with SMTP id 6a1803df08f44-6eb293c733amr37447766d6.33.1742382399870;
        Wed, 19 Mar 2025 04:06:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2t0QGksJArRSWkBCYZvSyReO8b4mt3eWRfhwdfAQcyv4fEjzOnD9kov0aGqtEzwp57TDlNw==
X-Received: by 2002:a05:6214:2529:b0:6eb:28e4:8516 with SMTP id 6a1803df08f44-6eb293c733amr37447326d6.33.1742382399503;
        Wed, 19 Mar 2025 04:06:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88508asm1920760e87.186.2025.03.19.04.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:06:37 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:06:34 +0200
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
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
Message-ID: <ip7xacfkpv7gf5w3gdgrweo5z7bqxmkfmvgsjfaurk5j5ac6mp@nqccdhunhwws>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
 <kao2wccsiflgrvq7vj22cffbxeessfz5lc2o2hml54kfuv2mpn@2bf2qkdozzjq>
 <8a2bce29-95dc-53b0-0516-25a380d94532@oss.qualcomm.com>
 <CAO9ioeW6-KgRmFO93Ouhyx9uQcdaPoX3=mjpz_2SPHKiHh3RkQ@mail.gmail.com>
 <16a9ff11-70dc-22e9-bd3c-ed10bf8b4fea@quicinc.com>
 <hkm76yogjp6fjrldkyatekhg7orcd6wkc43d2e7cwzqfrdxjwh@b4f2rilmf6gh>
 <303194d4-d342-ea4c-0bb6-5f5d0297ba23@quicinc.com>
 <xkjozxbchqi6mhstqctejfk7vmwux4kdff2nyrcu5nxqzxv73z@agb7rbapsvx2>
 <f2e67746-853d-8545-133a-13452548d504@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e67746-853d-8545-133a-13452548d504@quicinc.com>
X-Proofpoint-GUID: AnhdQKWfBBjFuNIuACfAeWRxmqQUFk9j
X-Authority-Analysis: v=2.4 cv=Xrz6OUF9 c=1 sm=1 tr=0 ts=67daa541 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=YhunDdt0IHZmoyGD5E8A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: AnhdQKWfBBjFuNIuACfAeWRxmqQUFk9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190077

On Wed, Mar 19, 2025 at 04:16:33PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 3/19/2025 3:51 PM, Dmitry Baryshkov wrote:
> > On Wed, Mar 19, 2025 at 03:46:00PM +0530, Krishna Chaitanya Chundru wrote:
> > > 
> > > 
> > > On 3/19/2025 3:43 PM, Dmitry Baryshkov wrote:
> > > > On Wed, Mar 19, 2025 at 09:14:22AM +0530, Krishna Chaitanya Chundru wrote:
> > > > > 
> > > > > 
> > > > > On 3/18/2025 10:30 PM, Dmitry Baryshkov wrote:
> > > > > > On Tue, 18 Mar 2025 at 18:11, Krishna Chaitanya Chundru
> > > > > > <krishna.chundru@oss.qualcomm.com> wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > On 3/17/2025 4:57 PM, Dmitry Baryshkov wrote:
> > > > > > > > On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
> > > > > > > > > Add a node for the TC956x PCIe switch, which has three downstream ports.
> > > > > > > > > Two embedded Ethernet devices are present on one of the downstream ports.
> > > > > > > > > 
> > > > > > > > > Power to the TC956x is supplied through two LDO regulators, controlled by
> > > > > > > > > two GPIOs, which are added as fixed regulators. Configure the TC956x
> > > > > > > > > through I2C.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > > > > > > > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > > > > > > > > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > > > > ---
> > > > > > > > >      arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
> > > > > > > > >      arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
> > > > > > > > >      2 files changed, 117 insertions(+), 1 deletion(-)
> > > > > > > > > 
> > > > > > > > > @@ -735,6 +760,75 @@ &pcie1_phy {
> > > > > > > > >         status = "okay";
> > > > > > > > >      };
> > > > > > > > > 
> > > > > > > > > +&pcie1_port {
> > > > > > > > > +    pcie@0,0 {
> > > > > > > > > +            compatible = "pci1179,0623", "pciclass,0604";
> > > > > > > > > +            reg = <0x10000 0x0 0x0 0x0 0x0>;
> > > > > > > > > +            #address-cells = <3>;
> > > > > > > > > +            #size-cells = <2>;
> > > > > > > > > +
> > > > > > > > > +            device_type = "pci";
> > > > > > > > > +            ranges;
> > > > > > > > > +            bus-range = <0x2 0xff>;
> > > > > > > > > +
> > > > > > > > > +            vddc-supply = <&vdd_ntn_0p9>;
> > > > > > > > > +            vdd18-supply = <&vdd_ntn_1p8>;
> > > > > > > > > +            vdd09-supply = <&vdd_ntn_0p9>;
> > > > > > > > > +            vddio1-supply = <&vdd_ntn_1p8>;
> > > > > > > > > +            vddio2-supply = <&vdd_ntn_1p8>;
> > > > > > > > > +            vddio18-supply = <&vdd_ntn_1p8>;
> > > > > > > > > +
> > > > > > > > > +            i2c-parent = <&i2c0 0x77>;
> > > > > > > > > +
> > > > > > > > > +            reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
> > > > > > > > > +
> > > > > > > > 
> > > > > > > > I think I've responded here, but I'm not sure where the message went:
> > > > > > > > please add pinctrl entry for this pin.
> > > > > > > > 
> > > > > > > Do we need to also add pinctrl property for this node and refer the
> > > > > > > pinctrl entry for this pin?
> > > > > > 
> > > > > > I think that is what I've asked for, was that not?
> > > > > Currently there is no pincntrl property defined for this.
> > > > 
> > > > Does it need to be defined separately / specially?
> > > > 
> > > yes we need to define this property now.
> > 
> > Could you please point out existing schema files defining those
> > properties?
> sorry I was not able to get which schema file you are requesting for,
> if it is tc956x it is in this series only.
> 
> What I understood from these conversation is we need to define pinctrl
> property and refer the reset gpio pin in next series. If it was wrong
> please correct me.

You claimed that pinctrl properties (there are several of those) are to
be defined in the schema for TC956x. I asked you to point out other
schema files which define those properties for the devices that use
GPIO pins.

-- 
With best wishes
Dmitry

