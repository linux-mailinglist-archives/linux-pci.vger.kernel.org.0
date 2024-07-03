Return-Path: <linux-pci+bounces-9714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E349257C9
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 12:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765971C22F3E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 10:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DD414D42C;
	Wed,  3 Jul 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LO3g+rXT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315A1411E3;
	Wed,  3 Jul 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001137; cv=none; b=FR/6cdKiE6xaZQObm1jXaiifnE5L3YqigWPI9E595nX/0BPRel1P3uMiyrviTcCN5O48h6UOGHIAZDiho3Pp9j+OBKZHdlEvFrPL3AcQ7327ID3RkKp2YpMqtdDb0w3rcwru0oU4hr7hmwATN2v4pi22uS/fy4fmBfQa5uSdOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001137; c=relaxed/simple;
	bh=btIei9/sNOh68L5VxbSRNJ6/SY9lrijEipZIFbe55Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aiNfFrxYcZx1qyiwqy4MW0B9IRVVKKI5g+YW6CqLlIAe8SDj3HTEBTU4kyKhZT1qaLDRFFRWADq9upt6pdh1t0QVQre68O3/C5osXYqwUxzVP0x+FWtXYO4DMteTFahp03LJ4a59dK6ak4cx0aZj9+bhdrYgPEpFJzTkt5lM1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LO3g+rXT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4632V6vL028807;
	Wed, 3 Jul 2024 10:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MTYyEqDPQFUg534+DSkldx2EQ4hiUNnVI33QmvBczZk=; b=LO3g+rXTgZGcl6je
	Rl00DBC52bV/FNAWASeog2Cru0JsaypLW3GIlbDU7M6yXixixBpgsVS2g2s6hP2o
	gOg3MVIiGXxM6foWGxKOVE1pNpCDabVLLy7ME1un5mROUZvVVAUGSvRzFcJpYuV7
	pjwKBkQRG3eBpSiiMK1gx+osblIsz7gUs0nknVyMDFSjRtQBFO17oJABopAwn4KR
	6MqqXHYgtie84G7tLEvErF4Hcb/C+bXioNXyzOE51JB/+SvPv8DkEyF37FC5fBac
	mxeUAbIeHw5CyFdS7RkAl0DOQkQVXfm5ynLxaZlU05YfyJ41Z0MTSCICSG3KUucn
	FjDZgQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404kctjq2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 10:04:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 463A4a3Q012329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 10:04:36 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 03:04:14 -0700
Message-ID: <312b699d-1ca4-4a58-877b-af9d91132724@quicinc.com>
Date: Wed, 3 Jul 2024 18:04:11 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/47] clk: qcom: rpmh: Add support for QCS9100 rpmh
 clocks
To: Taniya Das <quic_tdas@quicinc.com>, <andersson@kernel.org>,
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
        <robin.murphy@arm.com>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>,
        <quic_rjendra@quicinc.com>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <otto.pflueger@abscue.de>, <luca@z3ntu.xyz>,
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
        <linux-gpio@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <kernel@quicinc.com>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
 <20240703035154.2182083-1-quic_tengfan@quicinc.com>
 <20240703035154.2182083-12-quic_tengfan@quicinc.com>
 <e08b4798-b1fe-4e8a-80a4-716696dfdcd6@quicinc.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <e08b4798-b1fe-4e8a-80a4-716696dfdcd6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tMRDhs9g2i136rzis9EqfAfQCqfDYtjd
X-Proofpoint-ORIG-GUID: tMRDhs9g2i136rzis9EqfAfQCqfDYtjd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=771 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030074



On 7/3/2024 1:33 PM, Taniya Das wrote:
> 
> 
> On 7/3/2024 9:21 AM, Tengfei Fan wrote:
>> { .compatible = "qcom,qcs9100-rpmh-clk", .data = &clk_rpmh_sa8775p},
> 
> This is not required, we already have sa8775p bindings.

This patch is necessary, and the cover letter provides detailed 
explanations for why we are making this change.

In this patch series, we are renaming sa8775p.dtsi to qcs9100.dtsi. 
Additionally, in the coming weeks, the auto team will submit a new 
sa8775p-related dtsi to upstream.

Within qcs9100.dtsi, we are updating all compatible names from sa8775p-* 
to qcs9100-*(only have qcs9100-*, remove all sa8775p-*). Consequently, 
we need to add support for qcs9100-* in the driver as well.


-- 
Thx and BRs,
Tengfei Fan

