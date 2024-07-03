Return-Path: <linux-pci+bounces-9709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606D092570A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 11:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C1C1C2218B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF013D89A;
	Wed,  3 Jul 2024 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j3Ehs6Ap"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0013D60F;
	Wed,  3 Jul 2024 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999683; cv=none; b=URM/u2nBBT9LTMbgCyDA6GNHplj9Pk03cMHPDDfztInf7ypWG65sbrfTquGoNiYIrNXAe8BHcUcUqfEWG5WsbGc9mIrSVGGn1GSXEI/ilIk2trUJBCYO/JxNrXLDNTAATGeiT+v2XJ5d8upiiQz6tzpcBc7eLsJsYiX07o+vQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999683; c=relaxed/simple;
	bh=D5bmYFbTnQTtjYsNZyh9ZSR8LSHiNPbLvAJD8cZzbYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YAjIpYDqEmqlx6uWJD3zwUq1R2oZxb2DifGLmW/5ZKHxmrrMlezMP1RUre+cu0xnkeWo+H11YqEx5g79+Btq9vLZC4kuBZj5H5cpT3AkSKT7x7w8Rv29nAnxnpqTS2+7lO/h9NQ1aQZySaDcQr0i+PCMrB+8FRW0D2eHobVgwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j3Ehs6Ap; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462NWMm4005551;
	Wed, 3 Jul 2024 09:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TMN22tJYs4aAZjuMNYZk5hWvC0MHLAbXmOFNPbB+8cE=; b=j3Ehs6ApzFhR+TWK
	TyI+iTHF2SDxZXMzIkZP4hhe9cIOpc3TijwW24NKNOPUlhO9wXa/0PcKMf3uPEuW
	7wRdbghFPiOnKi5WHpXAFijUmJpGnpUGB0ZiO0HAKwiZUOay6zguV3zO2cdZmYCm
	+sLdGJi/UnwTU/IE96aO3Ie7ugQRsGW31saJv1SE1nRM7zbfztI+mc4M7phh4J3n
	yM4DvlO7sM2jLqKLkRhetVWPhy/P1zV93AYxkBT/BK6HZ715PhzDW1153dj6Fx9s
	XqQkvAyKoJgyiIlAs1kTF3sdmZS3oyAUsrGyeh53Sb5k8ehXyDz5ojVWcnakE+ih
	WhFhiA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4027yfbcv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:40:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4639e6gL020230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 09:40:06 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 02:39:43 -0700
Message-ID: <64934d64-3922-4cc1-a01d-6dcd773bc466@quicinc.com>
Date: Wed, 3 Jul 2024 17:39:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/47] arm64: qcom: dts: add QCS9100 support
To: Krzysztof Kozlowski <krzk@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <djakov@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <manivannan.sadhasivam@linaro.org>, <will@kernel.org>,
        <joro@8bytes.org>, <conor@kernel.org>, <tglx@linutronix.de>,
        <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <linus.walleij@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <vkoul@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>
CC: <robimarko@gmail.com>, <bartosz.golaszewski@linaro.org>,
        <kishon@kernel.org>, <quic_wcheng@quicinc.com>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <agross@kernel.org>, <gregkh@linuxfoundation.org>,
        <quic_tdas@quicinc.com>, <robin.murphy@arm.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <quic_rjendra@quicinc.com>,
        <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <otto.pflueger@abscue.de>, <luca@z3ntu.xyz>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>,
        <bhupesh.sharma@linaro.org>, <alexandre.torgue@foss.st.com>,
        <peppe.cavallaro@st.com>, <joabreu@synopsys.com>,
        <netdev@vger.kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <ahalaney@redhat.com>,
        <krzysztof.kozlowski@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <dmitry.baryshkov@linaro.org>, <quic_cang@quicinc.com>,
        <danila@jiaxyga.com>, <quic_nitirawa@quicinc.com>,
        <mantas@8devices.com>, <athierry@redhat.com>,
        <quic_kbajaj@quicinc.com>, <quic_bjorande@quicinc.com>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_tsoni@quicinc.com>, <quic_rgottimu@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-riscv@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <kernel@quicinc.com>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
 <20240703035735.2182165-1-quic_tengfan@quicinc.com>
 <7417fd8c-e852-45ee-bac9-d92921036e2f@kernel.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <7417fd8c-e852-45ee-bac9-d92921036e2f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kiiVH7Fe3W0fNlX1fdY9JogHsKzjFhan
X-Proofpoint-ORIG-GUID: kiiVH7Fe3W0fNlX1fdY9JogHsKzjFhan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030071



On 7/3/2024 12:45 PM, Krzysztof Kozlowski wrote:
> On 03/07/2024 05:56, Tengfei Fan wrote:
>> Introduce support for the QCS9100 SoC device tree (DTSI) and the
>> QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
>> While the QCS9100 platform is still in the early design stage, the
>> QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
>> mounts the QCS9100 SoC instead of the SA8775p SoC.
> 
> The same huge patchset, to huge number of recipients was sent twice.
> First, sorry, this is way too big. Second, it has way too many
> recipients, but this is partially a result of first point. Only
> partially because you put here dozen of totally unrelated emails. Sorry,
> that does not make even sense. See form letter at the end how this
> works. Third, sending it to everyone twice is a way to annoy them off
> twice... Fourth,
> 
> Please split your work and do not cc dozen of unrelated folks.

I can split this patch series, there are two options for splitting:
Option A:
   1. Initial qcs9100.dtsi, qcs9100-pmics.dtsi, qcs9100-ride.dts renamed 
from sa8775p with existing compatible.

   2. Each subsystem have single patch series to each limited driver 
maintainers.

      - About 15 series need to update related drivers, so each series 
will have 3 patches (bindings, drivers, the compatible names in 
subsystem-related parts of dtsi/dts).

      - About 14 series only need to add qcs9100 compatible in 
bindings., so each series will have 2 patches (bindings, the compatible 
names in subsystem-related parts of dtsi/dts).

Option B:

   1. Each subsystem have single patch series to each limited driver 
maintainers. Each patch series only update bindings, drivers, but no 
compatible names change in dts.

      - About 15 series in total and each series will have 2 patches 
(bindings, drivers).

      - About 14 series only need to add qcs9100 compatible in bindings, 
so each series will have 1 patches (bindings).

   2. Squash current qcs9100.dtsi, qcs9100-pmics.dtsi, qcs9100-ride.dts 
with compatible changed to qcs9100 dt files.

We tend to use Option A.

Welcome to other ideas ideas for splitting the huge numbers of patches 
as well.

Another, each splited series will also have cover letter contain the 
whole story like this cover letter.

> 
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
> </form letter>
> 
> Best regards,
> Krzysztof
> 

Previously, I've been using scripts/get_maintainers.pl to obtain a list 
of recipients and manually removing duplicate email addresses(although I 
noticed you have two different email addresses, so I included both).
I'll follow your advice and use b4 to submit a new version patch series 
to upstream, confident that similar issues won't arise again.

-- 
Thx and BRs,
Tengfei Fan

