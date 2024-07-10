Return-Path: <linux-pci+bounces-10047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEC192CB42
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 08:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645551F240D8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 06:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DD76FE16;
	Wed, 10 Jul 2024 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dWBWZkCn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF6823B8;
	Wed, 10 Jul 2024 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593531; cv=none; b=CzGedF6Yv2yLJs3KzTlvU6EqLltPkVm2VxFUx4zx4phFDdWEOsXUzaMjsj/51nwxSPcVnW6H2+3tnWK7Ouq2hNy2wdXbBnX9zV43HlFPbVsxa/DpAJ1FmzNwbIhsAniba33AVz0AsxjLmFlCl9g7NRjHGW1FO7X2kfDOmUj/zmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593531; c=relaxed/simple;
	bh=c6s/kU5kJKDxbaAHeTR8iJMDS1fdiyZv2JN2GX1bLbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sjM/8TSXjYYE5IVOhXOYJfRet0ZM+FHV2uk30f6FB3I5a+u/vQmDHwveELWq82kvAUZ5mGyQPGzRjspbwZBLPs0EG2X8QDB0hYIhq5Si+oefEY21ED2C5U2/1tw1eVqwKGYlNOanHW2CKS9R4Sj4HThc/0wxlpZDuvpSlNKJQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dWBWZkCn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A1ewHJ013428;
	Wed, 10 Jul 2024 06:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ThU3ymjDFgyaP72PBMA8ehpyj5YfinnNdLwyUy80PK0=; b=dWBWZkCntDc3Z83V
	In7flcQ20q2HNfD9+0nkDd8AIuLwVrTxVk2210YwMiJGEk/b7orKB8u9v8N4JZBq
	Jr4dqf1vXGlIqCpFsLdWAnlGKLRlk6aHGCHiT2+x1teaVB/ekCKwdhiWfyD6h6fS
	U/fwIlnBSjH/Y++UBQY+ZrVaacojnKWgSZO0yjPp0msQrKBRpYjsBEe56k/cN19c
	TZ31DuLtXkaHnSekRyC1MgEV6fgxG/cqa0TkHp91CcZGC3gbqgCc1qS8orGaQ5SW
	4qg4QHf4xdhjrXyVuCRXrbagnqfxgW56uwfC3L0f/lDWzJgULx+GkQZhLQF4Xr7k
	GWWdTQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wmmrkm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:38:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46A6cihs031947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:38:44 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 23:38:37 -0700
Message-ID: <82254f66-33ac-4737-a2bc-d606bc9b7486@quicinc.com>
Date: Wed, 10 Jul 2024 14:38:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add support for QCS9100 SoC
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240709162616.GA175928@bhelgaas>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <20240709162616.GA175928@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m5kx9a9xKhMjev3afNlYuJTeDrQyCzlS
X-Proofpoint-ORIG-GUID: m5kx9a9xKhMjev3afNlYuJTeDrQyCzlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=628
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100049



On 7/10/2024 12:26 AM, Bjorn Helgaas wrote:
> Add blank line here if this is a paragraph break.

A blank line will be added in the next verion patch series.


-- 
Thx and BRs,
Tengfei Fan

