Return-Path: <linux-pci+bounces-6574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA18AE835
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 389C2B25D04
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49666135A7D;
	Tue, 23 Apr 2024 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="APkYP6so"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812E135A61;
	Tue, 23 Apr 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879038; cv=none; b=knU4Cj7xYkZsvuW6NwoGG5YoHn8El7of9OLWyzNCbcx4mdPsUmolGlsofd99MLjBNg6Vu8Z4Z4KowUjUC+vr7FoIpXdkOUdHGUbH+yVk11EazRy0jDYZIp2WHU/zTuRIwT1cfc1pvLoADPT92pV5d4MxpZNCXxtnyOr46CO7/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879038; c=relaxed/simple;
	bh=s8B8mBRZqb0UbCIrbQqEbuF/Zx/nSdseOONtEXgkorw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XAOUX3zGJ+LYn1rngtGOPHpJJWw7h97ujJti7Vq3EOjZZd2xAMZSR9lFYA/ChYBUlp4dWPMT2pqY8z5pDrMHxmqXDjcSawQ2KHoeXQwuyAecFUPVkB7fzyNs/iZ+8j9SUH+45c5xFrlkKwgaZx8C3WarEmzyiENZKs/Z2wX1oYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=APkYP6so; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N7uKxt007928;
	Tue, 23 Apr 2024 13:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FHxXmsQzs3QHPANqiuntiLXAQir+SMKlWo2mg8cQ+cU=; b=AP
	kYP6soWSeW4vz6OdUBsH54jFQ3Tcn4K1yP8iD1VWmgkGfn+H2MnRsIpAPJUv0iIu
	ZZzz5+pj6CRjbU9+yptwrNYRqVl5oGc4IW036T/zFiygcz5jX1Y9mon40JjcKOmN
	TZ7UGOStm/2C4ye+P+WF2SD7HpdAa46XdKMvwsmeDbGywDcXXXX6kxQ9Y3TMAuPQ
	Z9BbVoEBjU3OpPD7NceNNyVgQ44wB+HkeRLcBxd3Bttd0r3bZvOpH0z8lTL5mo6i
	t0KwxgNUOKSIKjKk15xxccAoeubkr2IQ9C2/GiZv8eOFEXoX1D8tFxIm7Cw4TGTz
	/+FN8igCGHmkpnQrnMcg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp91fgvyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 13:30:20 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NDUJYQ023702
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 13:30:19 GMT
Received: from [10.217.219.66] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 06:30:13 -0700
Message-ID: <7f69c37c-07a4-07b8-9d16-dd4991f15311@quicinc.com>
Date: Tue, 23 Apr 2024 19:00:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v10 2/3] PCI: qcom-ep: Add support for SA8775P SOC
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <manivannan.sadhasivam@linaro.org>
CC: <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_schintav@quicinc.com>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1711725718-6362-1-git-send-email-quic_msarkar@quicinc.com>
 <1711725718-6362-3-git-send-email-quic_msarkar@quicinc.com>
 <8cdcfa2f-7a8f-4f63-b919-df0afde7d9de@linaro.org>
Content-Language: en-US
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <8cdcfa2f-7a8f-4f63-b919-df0afde7d9de@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4vmaV2N2r0bYxsn4RJIWAubYy3W2-8U7
X-Proofpoint-ORIG-GUID: 4vmaV2N2r0bYxsn4RJIWAubYy3W2-8U7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_11,2024-04-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=916
 priorityscore=1501 clxscore=1011 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404230033


On 4/23/2024 6:38 PM, Konrad Dybcio wrote:
>
>
> On 3/29/24 16:21, Mrinmay Sarkar wrote:
>> Add support for SA8775P SoC to the Qualcomm PCIe Endpoint Controller
>> driver. Adding new compatible string as it has different set of clocks
>> compared to other SoCs.
>
> So is it the only change after all? What did we conclude on the NO_SNOOP
> saga?
>
> If the difference is only in the consumed clocks (and they're only 
> supposed
> to be "on" with no special handling), I don't think a separate compatible
> is necessary at all
>
> Konrad

Hi Konrad,
Thanks for review.
yes, we are going with the NO_SNOOP change for this platform.
And that series has been reviewed and waiting for this patch to get applied.

Thanks,
Mrinmay


