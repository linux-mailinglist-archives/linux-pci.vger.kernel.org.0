Return-Path: <linux-pci+bounces-37827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46D8BCE3F7
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 20:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CEE401C20
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 18:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD73B2FF164;
	Fri, 10 Oct 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WRLRSjuw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5F2FE079
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120949; cv=none; b=XJbZsAbvK0Ft9i0nXCPWemaI4gmB15enTS+bX8Zwvz4O1yd/wDf8HxwAG9y4BTIj1U8lVy3jT65TfqkIg57pnXe5ZuTiDJy+gBLfHbVO397AoEZjHX5VRs5WrRNRrrbtuPj+77pFHiBLLXBaSSqzkuiDGoiYHD67M0reMwgtAT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120949; c=relaxed/simple;
	bh=DDGFgNcpRXXs5drDknCOk7ZT+jZa1tJMMOq5dszvroo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTFIp7V17WF2b3LPHSv8HAcHyU4DOqa42ZaSMzpU7gPPhss/CmmGGnhC5nVO1FdM1vHxrloiHO90fxXhARa1YUu2SVlFloaVLFbroG4qx90c2SwF7m9mdouzWsn6cgtgF74wVLn3BSAvZmaYEP2SL+x8BwvIO0ackAZl4/iH2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WRLRSjuw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ABQ7iw016556
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 18:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dMas5ueTnfbR6ogwJDvGtBET5Zhd3Y1zcYOGGYAo7eA=; b=WRLRSjuwy/30kckx
	lUlmPjjISE+Oc+T53aXKK8yjijNhLGKAdhrajBwPqIcZrrPhzM7aMXm5F4p6DdDc
	UDl29/ajikFx0MESr89fC1/HeWYCv6fi7RSKTI1kUuag4TVql0CwY7D3X3dPjuP4
	WYAYUitFYyFVHg3Ru4uEiSwlDHYXogiyyohbO/eQdJYWFaueDnAkF2NiRpcV0QZf
	qke9TQsrjZOm9dguouFN5ZE63ATbNl+HH0yYBepSwzKuES+rDWsucSlVUEp6xsoz
	/x6VJeRizTjasHjaOK7fHHF/G1j9xbCC+IKAW7LqT6qPrFsS8dWYUSyLzEg0Ixwu
	lVv9yg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49q18y95vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 18:28:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8703ba5a635so100493385a.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 11:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760120937; x=1760725737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMas5ueTnfbR6ogwJDvGtBET5Zhd3Y1zcYOGGYAo7eA=;
        b=Emt5/Hk2nilHU6OaHvpHU+O9sYjTX3d+wwUAzm5eXny8FjHbfE/ejk5Cru2MLRuqz/
         rjCDebEwOQ+6LrSGr58Izbta5qpZqntYJmnGQ/RcV8zoSdBrH/tkzZZsySsJT5uVPwxB
         87xGgKmLSwGS69rPlAyvwT1kwbXOJ9nQBQdPJaCnu9QaAKZoZhvcfUqdAGMrO3GQOvmb
         epJorUNYYoNgjWCIDDexU2Ma8rQPpRs600PpDBCE657OU4ufBIaDG6p8vmad5f1AUkjS
         IpQUxMo6cJSs3nq1EE0aDJt8r4PJdSdo1926ISG93lQD4zND9Rm7Wz8d5B1dkK++j3Pg
         EzXg==
X-Gm-Message-State: AOJu0YxpbB2o8HrX5C05WM/0+tFu3SxTVMAFepWv8S3q7F60wrKxiQXj
	A9Slb1BA7u1AXU4i+inbozs6DfcZYdLs3VirzbDbj1HK62SHYhP9finr+73m6vceTQwYQuRdb3K
	D9kb7sNt4DV7eXSt+utWrYTR22K0KSEdziNV97+plNwSLjPuzEZ6crAXf4MWjPAo=
X-Gm-Gg: ASbGncuRqXgcVjpqan30qqQMEPxIh+sVdoJfJniEF3bjb4+Cny2UMH6zfamQyqmvMqh
	x9PIFahiSAAs2lEH+CDTjCiU5m1rAU872jp33hXsOWJElySMKBsuc9TwD+m8sEcao05zE38Lp10
	aQoP6I+SOFkNue0SfwBNDvDpmr68514aThYeekvKKQUugAJUmBz7XTH+LIozOXsp4gzE63h46wB
	36nUdCPgkqfFip52OGod+ElZAGLKc9WKc9lEJI5QFQ3Nd2zf6w+AOTQgorGjmOfm05GI1H8rRcj
	iFyYbGKPOOJJWJ7MoqjeOWyhTNUPGSqNTdBGaWIl1Gv24cxJeM4p8/FkmKtn7wfNKBOsAkgkdJM
	cs6zNaM+ENoHOmsIbgRHdbw==
X-Received: by 2002:a05:620a:4609:b0:86a:3188:bb40 with SMTP id af79cd13be357-88353e1de97mr1201123285a.8.1760120937379;
        Fri, 10 Oct 2025 11:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH4ijfK86so2oQgbaGVcntvQ4Ssr8eaS2Emg+YzBaOfN0x1ZloTX9mbEdoCPNs8davYPPQ1A==
X-Received: by 2002:a05:620a:4609:b0:86a:3188:bb40 with SMTP id af79cd13be357-88353e1de97mr1201119785a.8.1760120936880;
        Fri, 10 Oct 2025 11:28:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c133f58sm2911251a12.30.2025.10.10.11.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 11:28:56 -0700 (PDT)
Message-ID: <896b58cd-9a13-4b7e-bf62-e062728d3e53@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 20:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: PCI: qcom: Enforce check for PHY, PERST#
 and WAKE# properties
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
 <20251010-pci-binding-v1-2-947c004b5699@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251010-pci-binding-v1-2-947c004b5699@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0-xweNuJ56sg5mQdOsbIYJHoW9qK_CSU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDA2NSBTYWx0ZWRfX+qRDDaN58xn1
 3pwhUsZGfxbBSgO0Orc8dzA+nMqEDLG50OGbMr7x4ex4OLEk82nKlr0oaGIRfsRThk9bfAW7c4w
 VhqBgXAokxMjsd+I0251lGa8FMVCJxtvmLKK+YJgHQLpStm+8ncEw5TlMemFV2aPUV+IcSx0kvg
 WSW5NzCxQzozGPPu07SEFFlz9aI2tAsBk1S2UXav9X9erz7oLzIFAMQCgCC+GFqd824ZrO6aJPX
 2H7jsSZCgxBT9Y9IAJpl67GyAehdzhym7xf+J4jdroRFXClslbtx1H5DbtQg/TPclp4Z9sQ2WJS
 CjCbxsSTaFm0BMWMQoSq8VfgY5PyTSqyFNXfOZREuiZBfARgFd5KcKmO2caatFtleg9ZG3gvfNB
 5LpmkGk5V2sWEm/HPMgc708iXddhZA==
X-Proofpoint-ORIG-GUID: 0-xweNuJ56sg5mQdOsbIYJHoW9qK_CSU
X-Authority-Analysis: v=2.4 cv=LJZrgZW9 c=1 sm=1 tr=0 ts=68e9506a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pqiSj10MyONZ7g7U9k0A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510100065

On 10/10/25 8:25 PM, Manivannan Sadhasivam wrote:
> Currently, the binding supports specifying the PHY, PERST#, WAKE#
> properties in two ways:
> 
> 1. Controller node (deprecated)
> 	- phys
> 	- perst-gpios
> 	- wake-gpios
> 
> 2. Root Port node
> 	- phys
> 	- reset-gpios
> 	- wake-gpios
> 
> But there is no check to make sure that the both variants are not mixed.
> For instance, if the Controller node specifies 'phys', 'reset-gpios',
> 'wake-gpios' or if the Root Port node specifies 'phys', 'perst-gpios',
> 'wake-gpios', then the driver will fail as reported. Hence, enforce the
> check in the binding to catch these issues.
> 
> It is also possible that DTs could have 'phys' property in Controller node
> and 'reset-gpios/wake-gpios' properties in the Root Port node. It will also
> be a problem, but it is not possible to catch these cross-node issues in
> the binding.
> 
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Closes: https://lore.kernel.org/linux-pci/8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

I would also like to add

Reported-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Since he originally made me aware of this issue

Konrad

