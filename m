Return-Path: <linux-pci+bounces-40099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2997EC2B134
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 11:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A3D04F1D99
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D72FE072;
	Mon,  3 Nov 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BsWGaqtI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MERA8aAL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580F21ADCB
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165862; cv=none; b=KPNC5RNm9j9YZYGThvph1yusPOvlB40niSsQxOar2GHbAN5kpLLc7tpD+g/NfzDahaRpqdoQ1fZj4aRPOUtP3hrZkOOMdhNJ6ysrx/2Ncm6E5dETPjpX2VzE3wBYzEwLz7AQXIyEJ6zFt3ciz321Kzt88kUdEh0lbDaEdJ2y2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165862; c=relaxed/simple;
	bh=DUl/v+dDDeGqqyWq9yWVSUSXbQeJIusN+vU25wQ/e/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQcuXorzKe55CS+imYV0fujJKX7I/5EUh1/pUJVwlZAXnzswNQs04pEmK9qzqQL1kUWvlpv4JY3uTj8pFuKxo9OmwMYjmygj7Jnh/sTHEnU3QJeY316UslbbNlUOJXJjvRdjxTFFXZU5DYoHzUChzNseVZwtHRU/4gstjv0QnIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BsWGaqtI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MERA8aAL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A38ofAW2730216
	for <linux-pci@vger.kernel.org>; Mon, 3 Nov 2025 10:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jWE4ljXKfIWeWBpJ574mSlDJqGovq2Rh5s9YuFuiV3I=; b=BsWGaqtIqSlRSyOZ
	ja/kOMcXZ+vWZwhJyjM5cYka3YfJuSLcwRtK7nJaCZjTyYidO9yG25tcpL6FS2Wp
	yExKrgOVk0MVT2kpXeHxtEqV/UWbYiTv/58GYHN/baezMKkfT8QAwbilZYprUR4x
	f5Ei3TzdtVLGoLfLNlAB1qJ9B0KC1C6S4vNDRe+z12uPaXQTkCjNAoghCF1wPXL4
	WqNNnP32qLldY5extbEzZBPyBSFMy1fTVdpVrflH2h29Aw3nMS/01NBGZu8Pymrd
	q1eurZCadmdhdXOKL1mL3mYr0EVZtSfTyJ8oObnnWk1CZumZungxZBkhoCf/coIa
	fN1PzA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6s86g9wv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 10:30:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8804372387fso10490326d6.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 02:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762165859; x=1762770659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jWE4ljXKfIWeWBpJ574mSlDJqGovq2Rh5s9YuFuiV3I=;
        b=MERA8aALj/qDbz+/oXVoCHKMPLPi1NBkTO6dcwgNwN8rKDt96Sqhv53tqgbDj3TZj2
         K/hr9CjDJ8Hsf6PsQdudgrgGn/2zI+/YHLh9IRxQS7FBYAGenYyvVV2IaDj/my0UIZE+
         ngYcUGZmHLC98vAa0s7YdrJJDFp0sW13Bx7Rx4vIibIsuw1psI3C4tSe6kVWSBimd8HH
         wEqUutFP6exOefI9mjTVUVZwIwkS6Qb1vC/uh5RCBURYDW/4TpKbqmeVKIzdFoHTLtLU
         Iek0yHep5Fx+WltUp8m+0Wt4gdwx2KE6kJzhB0N52b62liTpW4XanaIPJHwFshm25Y80
         t9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165859; x=1762770659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWE4ljXKfIWeWBpJ574mSlDJqGovq2Rh5s9YuFuiV3I=;
        b=K7bvcN0vXL7uLCj2ztHbCehYl8ZvmdcKxtknlpZU4/Y8beVM96lDc3kpDBY8BFXGjQ
         EYNPD5/yjmyTATFTDOukbjrejF6iIczoilngGr/Jb5FQeGOIZ5Iatmr5AWc3feVDBw9g
         dpeilp/7+zt1hypE4FL646Pu1oYq1I1Qw7HIcDYt7OlswsaJM0jY9TlyH80rPmHDXPt+
         d+bnmyHSGrUJtxDMaKZhNn48kAKvDWrs3+4qZS2x9hQDyZqnjChvdVyQQFgxMXXQXoDl
         xtHzqRfBvwTEj1lNe/Fd+uXA60JWarDY3FW/rmKUHMCcDQzoqUuLApB1Q+D2EvE7RfiS
         f47Q==
X-Gm-Message-State: AOJu0Yyw8XTNAGUwnGSbFYeDiuxNcxzVsndEBAqptD2VBuS2ondvWCMS
	k2gvdCKQP0xPCgIpb5FEM3JeBFRis/F1DodLjdtZLg9986H2hiu8g9cQwbwNufkri14l2lpqBpE
	88IwFwMn25Kh15Ahwu36uBxGBZnGC5SvBpsHIFivoHasNSvr+AnRxSAsew3983oo=
X-Gm-Gg: ASbGncsCOY3/MD7IOM09JYyRJsbRSIYMdzevK1g9661DiD49yz+nxPjaOHM4MN3jh68
	5A5B5DriXAFUHQ8qI2YMMAVjQfOB2ZGc9Qe1HgcZO0A1W5i7PBTxUpj+ZfscWiBPAoIXa+KTMfD
	pPV3OfI6Rv7Vn0YRiJWx6uHWpKQy83QjSxzdts1kVo6EKbnjVx8WaFSiMVS2eZ9/iFpq83MAEYZ
	UU9NtbXJG/mi2n0sGYT3h01oLvbzwnrWou+ZOrCPvVeHOTSBfsDUvd8db+ESfnWFSkoOqAIhbcn
	4MP7o2RHFEI6aJ1zOfYWTrzz7WOtJIDDZDgXXlaWgPP3xLeZtFTYI5JDp5K0SA8xvjxWsidy/Dc
	3IsSeGl6Q+9rRM24M2IYadnWLZJm/eDqb3MMpAsnxMbriqt5HzEFHeTNx
X-Received: by 2002:a05:6214:415:b0:880:5cc1:693e with SMTP id 6a1803df08f44-8805cc16b70mr6734636d6.7.1762165859033;
        Mon, 03 Nov 2025 02:30:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQp+B6BbASeIJWfxPDgxaNj/gsZ2jj9hIlPnMzU22TpzxNI//yIFYM2vt+axjIO4e746PIRg==
X-Received: by 2002:a05:6214:415:b0:880:5cc1:693e with SMTP id 6a1803df08f44-8805cc16b70mr6734366d6.7.1762165858569;
        Mon, 03 Nov 2025 02:30:58 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975cfesm1000680166b.4.2025.11.03.02.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:30:58 -0800 (PST)
Message-ID: <801d8e09-276b-427d-8419-7f2355df2295@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 11:30:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/7] arm64: dts: qcom: qcs6490-rb3gen2: Add TC9563 PCIe
 switch node
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
 <20251101-tc9563-v9-7-de3429f7787a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251101-tc9563-v9-7-de3429f7787a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5NSBTYWx0ZWRfXy82kWGoND8h8
 vuNCXYnzPXRJDDfw5wYpSnpAedriY+jifIlrV2wFlMkliKlao4FrL7b2NX0lM7yaqymP0PYuklF
 OvSQ6tWxrPL56FwfceUhsddoojWNCB1RPr0/FBh+aGbkKPrMwLmLdPvTy1/uhyCJNTulgEyu54j
 3CS0wVvyXI/1ybQIECf+4tqGXrDz+xHhkZT2Uzolr2rSml2CksC55njgRw9bHNVhIKYXqeP4ql3
 CcOnmdfWP2azXz2lgpWZ0cv0yuZd05kYOmDHs0wnZJ9uCpT+P1p7MlNk8N7jWLToqQbohzGJXzs
 I9JbPCE+vq3DzA+ip5n+eYIMNH/aT+F/HPqNJHhGjCew275ts/WPMcc/Iz4qgVRJxAJC37O9Mzi
 gnt3NcHotYsXGHkyG2hmU+LA7ZLaJg==
X-Authority-Analysis: v=2.4 cv=Tq/rRTXh c=1 sm=1 tr=0 ts=69088463 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=gkRObvzxmN_HJK3DEhcA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iTYrsCYZ-ihNNNEDIQ6siCJtIxaqh2YG
X-Proofpoint-ORIG-GUID: iTYrsCYZ-ihNNNEDIQ6siCJtIxaqh2YG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030095

On 11/1/25 4:59 AM, Krishna Chaitanya Chundru wrote:
> Add a node for the TC9563 PCIe switch, which has three downstream ports.
> Two embedded Ethernet devices are present on one of the downstream ports.
> As all these ports are present in the node represent the downstream
> ports and embedded endpoints.
> 
> Power to the TC9563 is supplied through two LDO regulators, controlled by
> two GPIOs, which are added as fixed regulators. Configure the TC9563
> through I2C.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> +	tc9563_rsex_n: tc9563-resx-state {

The label and node name disagree about the pin name

> +		pins = "gpio1";
> +		function = "normal";
> +
> +		bias-disable;

Odd \n above

Konrad

