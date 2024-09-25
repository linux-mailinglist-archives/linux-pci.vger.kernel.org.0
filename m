Return-Path: <linux-pci+bounces-13473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E0998518E
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B021F24A8C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 03:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61CF14A4DD;
	Wed, 25 Sep 2024 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qo2KTyM8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA586126F0A;
	Wed, 25 Sep 2024 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235644; cv=none; b=omZnqBgxIJrXQGtit+JHLdQBAYV8K4ECDoCxoE4VHZ93rPysa2kN4oxym2Ei4oudJYUpc+xNKpAccSMfRbW5U4DF5UvcZ8i/t0HvSKSh9vblmR7FeqtTDfHsz9KFFLwXWVjpxvq2dzvQNjTcUDsurZWP9sraFNStl9nteLPiEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235644; c=relaxed/simple;
	bh=8IaeXU8v7pvd1GaZ60wnggcBhffoHu+Rw5ZykBmr74U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oc8zLQNbb674bw5L95nI7lXBl4Y0k7OBXqJfGTHqip+GLWTynMYAY0yZERe6EsVwx8jZpOkPDyihnBbExhFb/uBUq0TRXVX28wHYcWb1AXcdrC+PG8Atl6jDAuL2iwYg3Wauk+tIetgb4GoUWLpsZWU/yOo5gsGcXALSHvb6Mpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qo2KTyM8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OJ57ll014296;
	Wed, 25 Sep 2024 03:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8IaeXU8v7pvd1GaZ60wnggcBhffoHu+Rw5ZykBmr74U=; b=Qo2KTyM8isGhWo9n
	mgCwFEO4gu1iWwBZrFmAclykWyQTfU7+ca70n91SXdfCT4aHdPe6Ud6iWsvWG66R
	KaOttd4kqP+64No4lQwPV0PCR3+YpwF6CTD7fmGDzFL3+F8W6LKePGE6h894eyJ+
	QqI+49eW5Tc/xW3x2CbbVuaRNVoAbyflmGz2bMEO4M+eWsMW8kzpA2oVHmhKP+Gy
	wc4eYt4VkraYVU+/B46AGPQs1OdVTUFRYtto+M7TnnitJIG3Lq7pmEH0+i7gnEbH
	6mP8/1P4kLu161Z0CExEV6vmZvRiNESGtVTaZWUU6Xsw4sOZhWVs6LPa26j/Oxu3
	nzT5DQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snfh2xay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 03:40:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P3eXPj012440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 03:40:33 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 20:40:28 -0700
Message-ID: <dd16ff25-8f05-4137-9726-7f63ab82f30a@quicinc.com>
Date: Wed, 25 Sep 2024 11:40:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] clk: qcom: gcc-x1e80100: Fix halt_check for
 pipediv2 clocks
To: Johan Hovold <johan@kernel.org>
CC: <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Mike Tipton <quic_mdtipton@quicinc.com>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-5-quic_qianyu@quicinc.com>
 <ZvLNNDCOy68nK2B5@hovoldconsulting.com>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <ZvLNNDCOy68nK2B5@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EVIdORHBfowiQCKqqaKJOSDHKth64nAV
X-Proofpoint-GUID: EVIdORHBfowiQCKqqaKJOSDHKth64nAV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=622
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250024


On 9/24/2024 10:31 PM, Johan Hovold wrote:
> On Tue, Sep 24, 2024 at 03:14:42AM -0700, Qiang Yu wrote:
>> The pipediv2_clk's source from the same mux as pipe clock. So they have
>> same limitation, which is that the PHY sequence requires to enable these
>> local CBCs before the PHY is actually outputting a clock to them. This
>> means the clock won't actually turn on when we vote them. Hence, let's
>> skip the halt bit check of the pipediv2_clk, otherwise pipediv2_clk may
>> stuck at off state during bootup.
>>
>> Suggested-by: Mike Tipton <quic_mdtipton@quicinc.com>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
> Looks like this one is missing a Fixes and CC stable tag. With that
> added:

Will add Fixes and CC stable tag.

Thanks,
Qiang Yu
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>
> Johan

