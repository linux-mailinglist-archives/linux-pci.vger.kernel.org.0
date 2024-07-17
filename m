Return-Path: <linux-pci+bounces-10438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BAC933F58
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061C71F2130C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD1B181B85;
	Wed, 17 Jul 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="enNi8h2Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB820B0F;
	Wed, 17 Jul 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229226; cv=none; b=jT6McAhQky0dSo/jjKJsZlGkHAlTTeV1PWcDOMllGyPI4FLj4krCLXeT+AV5kvmWjOXV6+u2c5+C5ScImhkCkBi4XtCgfUZxBwgJAy/Y8TaVfgp6HyS4FmndVW4zakzfi1/YhPziF1771JH6tMchmg8S/pHZ5ldJHfeiwyUwnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229226; c=relaxed/simple;
	bh=jcruO+kuviHtJapjmGFj62kWfgMh4BjScgLMIcyT7nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lw8tYUSi9h+IyH2LdSfBnnbWHIo4I8MLPH5I7y0Mrm9A6sMwUbfuKP3kXFt9MNWEKCgURuCauUIzhv3K3+J1SGCbbLVWf8hQkmjBoL3LuD4O49zs6vOfnVL3yxVUpm91N1cRrnBWzshzeIGcSyYtx4zPlyBYGtjC7FjTlzSsoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=enNi8h2Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H7U2D1013666;
	Wed, 17 Jul 2024 15:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KQuC8wNnJRvzmHAjakKh2cb5ARzuKdfj7f2ORel+PHc=; b=enNi8h2Q+6PLG9xc
	+zSMLAErQfjU3Tksp6s6AR7uyOPAYjL+xNtM95uWVt8jH6G7ZdKTEfTTLKuJmt2U
	G/YTPSQswFqed+33pUnpOuK/tJUXz5/6om4GAEgvIJe9hKtACBJ3grlAZyx+Z/cp
	h+4mGs0T1Wy43by73OQKwiIWa6IdP0RL7VCpKl62eNFbWeeHMa8Mnn2n7ariags1
	qNFGcTi45uLJer7SDsg6vXnGXNh7zrvlQGp3EEXPu2VlbUG0g+DwcV9katRAVGbh
	43FeE8rxsKZHHPxkL8y8Wmco/OE8kEhXybkTVVH5yg2WXHQOgq8BXqBBmKa5Zd6P
	2/Kb0g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfwap2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 15:13:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HFDTHF021036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 15:13:29 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 08:13:28 -0700
Message-ID: <5dc0f70d-801f-4a82-8488-c200f790bad3@quicinc.com>
Date: Wed, 17 Jul 2024 08:13:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Kconfig: reduce the amount of power sequencing noise
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Kalle Valo
	<kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Torvalds
	<torvalds@linux-foundation.org>
References: <20240717142803.53248-1-brgl@bgdev.pl>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240717142803.53248-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UlnqAdv4AblUlfPWyqJFSA40g_RYKitL
X-Proofpoint-ORIG-GUID: UlnqAdv4AblUlfPWyqJFSA40g_RYKitL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_11,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=418 impostorscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407170117

On 7/17/2024 7:28 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Kconfig will ask the user twice about power sequencing: once for the QCom
> WCN power sequencing driver and then again for the PCI power control
> driver using it.
> 
> Let's automate the selection of PCI_PWRCTL by introducing a new hidden
> symbol: HAVE_PWRCTL which should be selected by all platforms that have
> the need to include PCI power control code (right now: only ARCH_QCOM).
> 
> The pwrseq-based PCI pwrctl driver itself will then be selected by the
> drivers binding to devices that may require external handling of the
> power-up sequence (currently: ath11k and ath12k) based on the value
> of HAVE_PWRCTL.
> 
> Make all PCI pwrctl Kconfig symbols hidden so that no questions are
> asked during configuration.
> 
> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/lkml/CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com> # drivers/net/wireless/ath


