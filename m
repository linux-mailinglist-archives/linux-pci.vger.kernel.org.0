Return-Path: <linux-pci+bounces-18963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDA9FADC6
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 12:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7D518839EE
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 11:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4490199FBF;
	Mon, 23 Dec 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hj0x/k01"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26276198A32
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734953818; cv=none; b=quKw/OPsnTym36WbQP2t2cHxqIfKClmKdmpPymheH/4N20R6mfthTDNotZvpzEROcKGPR/Ut8MoGkPYsuHmhv189wd45gBX5jMQOh0Et3n8LjgDrBMKku/uxab8iTD1F6M2QRqrJXqrdk1gAqI+8REgAwaFjSmFvPCqzRUAmNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734953818; c=relaxed/simple;
	bh=wUjPXxAsWNUWqccLWJuFOMSjEM1ez/Hb+5rIbn5YFbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMGiKG7xf4aH2y+m79cvsjRfLuRkI0oq6Rwd5od1nTPPQRVWWiUlHiKQMUcOuWIaYugSLK45xuALnd0V//DyxI+XfrJhi+k0UUNgtIcOVO91TX+URz65FyTplbvP7CJsBfDq8iKkF/iA+uar1bmZ3DL4V1mWFh5VB7Cl0l62Z7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hj0x/k01; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNBatHi029479
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 11:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GxBwnZdyh0+oIX2CZcOkzfj/L38PK1tR2KNoyu7vIgA=; b=hj0x/k01KvAQ9z5h
	Si0R0I4pRaVesF8/zDfSwU7szpm/avXesU7StxdUVi+xyOuRoG4EreHn3HddGqML
	5MHoZLKruRk6BfaP9+E3V7IYwE36NjYbERQCdCtCdfCCEed/6BaX7UxCKJwFMUVn
	zQtzVlp3L3B7V6M5LUeMGLliXnyMI8vuhb+JNceCjId7jI3TIPM5x8S4hxDKBMiO
	9QGm0xHpXiwpG3JEP2vMRDnn1Y6akLsZo5c4OesHoJ3n3q9gUhePR2V0bzTiyjQt
	sEDYnnlkt7G5HwF+Th9hkbCPTSg+UoPyjoU999IXdvRuticEhEZnQN33m8LbVB8O
	qWMWCg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q74x000q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 11:36:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e43ed084so54163285a.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 03:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734953814; x=1735558614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxBwnZdyh0+oIX2CZcOkzfj/L38PK1tR2KNoyu7vIgA=;
        b=nyshTIMjM5k74TfDhptBOoSveHaEnfJYNgqhC1crz6FnKisuocjAHnAykjIzzO6uip
         sUfFtImY1iaHYNtKyVXHd8jF6brwn5PFJfaVt6QvliHHwOQPS1+7uor/gjA0CCkQzAW0
         gjNZ5anfqWk8mDq21D52BVkv054P/jgQU3sbiCLcUq29dREVMRIRtGC54rJBjwx2jvZh
         /KMtlsrRrHdyeZ4vgL4aCeTjBF+tAUOtNWQ1J2Mf/qJbeYk62zugTaHzU2amsVQ2b2s7
         EZwkas+Lf/YYbxc+i0kSgZw0Nb2tCqP9X+PBoY3HY4OWDRiKKuC7n6C/H30A7ne0Yco3
         gMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2ba48IG6bgrKYdxavUPud4zqKCGqZPkOtViwQKnBH0gi25bjzk86iUhP8SoCLuojyiNDeo5aFQPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYgp5CnL93JH7IkY3ODtPTgbP95hyblR0+DnRJL7ZBUIFAL+bO
	ZfWBV5fGDHfNaZV+2VndusG+1ApUUSPxqIJG/n4U0Dz2iXSCfLalCBCoJFcrpIKHyCdTJnBqYwr
	p/ZqUO3GcSktUgaDXYICQ2oif4oL/Ff6y0su60w61jNSKz+J//ZLKaYzFsRzrckfGxfU=
X-Gm-Gg: ASbGncufcA+G2vEhd9AAtp8OE7deUBkGjznvj9PmDsKMoAbZLMRhOt46lChTBLgPE7O
	GpFyxnj70PdiBkd3MWyTIrmHkJuKIzVgyQr4ZqF8Fmke5jiMJFUXqeCVc0+FElZuxt3C1C8Oli5
	B5jovpHr4ar/BKhk4y4H+Tzz3Wi0it7K0L5UO8NTFuKdgpIvLbX7gOKJJ4dnbgyF4Y9ao6M2qDS
	9mW4Nc00cUROkkvMdrr2TfoU+zkVOT5rMyQ/lSYQJf9fCTj482ZeMY4o30+nhRm1gQQCuH5SHez
	QAG9445Zf+x1+htUsm3ssn2sTYvaTuniwu8=
X-Received: by 2002:a05:620a:1911:b0:7b6:dc4f:8874 with SMTP id af79cd13be357-7b9ba7b0a79mr760624485a.12.1734953813778;
        Mon, 23 Dec 2024 03:36:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtL1xYU4q5iFeeT8egnMEG6BfPX15L+zymBOyU7oucET9/Hf+ap7FsaWk6YB8aHkpe/bKmYw==
X-Received: by 2002:a05:620a:1911:b0:7b6:dc4f:8874 with SMTP id af79cd13be357-7b9ba7b0a79mr760622385a.12.1734953813408;
        Mon, 23 Dec 2024 03:36:53 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aaee340665asm50505166b.187.2024.12.23.03.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 03:36:52 -0800 (PST)
Message-ID: <93ff7098-a77a-48a1-a14e-de23940bc763@oss.qualcomm.com>
Date: Mon, 23 Dec 2024 12:36:50 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: x1e80100: Add PCIe lane
 equalization preset properties
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, quic_mrana@quicinc.com,
        quic_vbadigan@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
 <20241223-preset_v2-v3-1-a339f475caf5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241223-preset_v2-v3-1-a339f475caf5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _fJzOV1TgmOwG05x8v-StVLU7WR0Hbsq
X-Proofpoint-GUID: _fJzOV1TgmOwG05x8v-StVLU7WR0Hbsq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 mlxlogscore=597 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230104

On 23.12.2024 7:51 AM, Krishna Chaitanya Chundru wrote:
> Add PCIe lane equalization preset properties for 8 GT/s and 16 GT/s data
> rates used in lane equalization procedure.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Does this also apply to PCIe3?

Konrad

