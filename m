Return-Path: <linux-pci+bounces-39749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9862FC1E38C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 04:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69FF3AFF0D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 03:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC8E2C11C5;
	Thu, 30 Oct 2025 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mwRl5gtH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QM3+iLIc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B52C0293
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 03:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795553; cv=none; b=Z/zfkyB2Xi7DSSxR6A7qiDCrc1cq2mbbWyTEGgzTeZmLB+XDxPLypkOw7KCOX47rl8Q/IWM9Z8xa/iOy8AJuh5TUaECbnMzwmDg0fkFsvmXlYSwCweaIHqOXmT592OevLqrqPvsPWXBk8W3vF+b/XMFW4G8HJqeHfOnjpwiqRks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795553; c=relaxed/simple;
	bh=w4b7bMYZQ1lDA5SR2sOhvAp6iXdLS4+/1bLZLHD6SDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgvrwvD5MBakprQYEH+f228i7Xglzx+iyk14jj+r8kvPmj4ATZnA3NYtx++ezEZIIVqEEj4vq/xvB7xR+La6Wgm3QPAXxPhLGN35hduIJaa+Sp9bL4tKZ4+WLjr1ayoey92J+lEJ/ifW6tyF1frMgryW0YR7/gxTURFkgbeWUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mwRl5gtH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QM3+iLIc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U2g4RZ4135357
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 03:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PhYPs7vpcUnJsvDso3Np9kelujWCWr8tqGZf4I83GIE=; b=mwRl5gtHBK+PfKXe
	oxxbsWD0u+UUtaO0ETxqmp20A/rNxi9lJzuLRPLgHmSSCAm24Gmiv3WBKCHCSH1F
	FFdkHgpKoa5xCqt8HnSqIw/cYw3soYbFUHgZQIC5KhH+xwd1hWoAIx1H0EbNcBM6
	KrUP8o1QIR1NVE0MmnQlE0eVud0TC5GRPLLnIKj8KtyWDfYCRu/daUQWefdm9o4d
	kA880vQVjEWl4aVNRTEgKkRxniUNFCEK5qWjbyBQaNNUbq8T5n8GpYZdgclTScf+
	c9CRh4u32hF4AlkdnMhlg4N1ISkv/o8addhlR1AlRDeuzWlROzVkFGX2oEQ+N+hW
	kRyzeQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ff9u78f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 03:39:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-294880e7ca4so11295315ad.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 20:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761795550; x=1762400350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhYPs7vpcUnJsvDso3Np9kelujWCWr8tqGZf4I83GIE=;
        b=QM3+iLIcEVwLzKYVbQ1q0tQqXD9GuNotd2y5yO50SvY06WO8pw+LUIuPgtHFeYnK33
         bu4RRd9z4tbiMh8Wou4jJlMKO4TRAW58ccmc8AMJBlLu0oGIJM7khWzSSks8WwM4rJfD
         AbzOAN5aA7PI782+goROBwFKvUiq+C5orWFRMVXcC5AMsvL0mm1BgcDVGLG5pTNVlA4V
         jE4AB8iX3VP/qUVBEXLhzKkIlifWmaNJWGoxeThwPhRjcsarRMIULKC020vx8haycpMB
         Bd/47GomkQqfcAph3HXe6rBV8deNlO58btN2TCtSIltUUZBaNqI6b7BYmXFTM7RNU2AE
         15WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761795550; x=1762400350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhYPs7vpcUnJsvDso3Np9kelujWCWr8tqGZf4I83GIE=;
        b=f3rBOpIEaYrTjL9oZITVK5zQq6f4osrmvPzGpYUDjAmdQQcXB06/cdCx0ejds234K9
         f0yxaMqampz+iZnmWZ/WYgOP2xlgE0HUvK7V5UFUq99qjB/o9G8kKU+ooGMpYfFJFLIl
         nruw3dr7By0T/Cqz0mpf+XPClxzdmpn8rNjV8gYArnoU0vEul6bS5QJsTJwnBiDixDpn
         owPffVmHPZuvgh/z1hmP/cjUx1u7DuL2xe170eyyK5IRFDk9LznEvzZ2273hWiJknirJ
         JQMnUVPHj5HLswLiJsBME36MrwtJzT5V3wbUyaKLBRPvG0DuKnzhUJ6sfzb7ZvEMCxx0
         yVvg==
X-Forwarded-Encrypted: i=1; AJvYcCV8btp8sOSCh8WRYOa2ZBRHyD2FTZ702fDSygj33l/rQf06WfjOErnHsu3TfDsFjl/+vBnDkwFb93I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWXKLpF06SfDFzNtDIPNI7/hUsvBjLakaNcstZqSMVr00BBVg
	ClX9TcCeQ5Oz7Kw/e/pi8a01VT5Rob4oTlBnzFml0IAOrkHf/mqLvBEMB2QhSvB9CC8tXkghB/V
	hCa+ENQT48dwcpB1aqAlmK5Ire4I+ekjjzC16jKrD3QKrFT7yXhbahalnq2TuJbA=
X-Gm-Gg: ASbGncsvaayHSN6IVQfpidleTBf6jzcdJZEuZsQgC3hk5azfbYywnAYOuOaOCjbjYKt
	BxeN1rIzs9BHyqeDbSML36Yux5jeBwdYUKj1qmvo+vPzdDecKzlNAdT3h55V9WV7OrNpiV0jKaC
	SSYFPYpVFRG5OgCu2VrqkTwOGGJ92dgy7LENHUqTDkdFq3rF9EJKB+9aG27+KDtuzKWexLfKRog
	SradehAswOA9AmEBCGZh03GfDlNC72HU05t93J7KPeyWQ9v6BE826K06ewr90NBKlLA2+rbEC8+
	CkmC4Qo43Ww8GGdqFRiUwAOCnIDkqwfWIhEW0Aart2XMIupPlNd3UIYAo9XY7ZJ2sJoHB+DH328
	n7zCoyKbhnFiLo1Xt1B12yMpIBOnAbnY=
X-Received: by 2002:a17:903:240f:b0:274:777b:ca6d with SMTP id d9443c01a7336-294deeeb76fmr69476125ad.43.1761795549865;
        Wed, 29 Oct 2025 20:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDuq6Cy861gKvQjGL7vn7LoqYvAFnjvADCSK6KoaTP0/m4xLO7nEAtd1CcKZenG2kW18zBAA==
X-Received: by 2002:a17:903:240f:b0:274:777b:ca6d with SMTP id d9443c01a7336-294deeeb76fmr69475615ad.43.1761795549359;
        Wed, 29 Oct 2025 20:39:09 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e50dd9sm167674895ad.111.2025.10.29.20.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 20:39:09 -0700 (PDT)
Message-ID: <06a9de6c-c9a7-4c5d-9be3-5c9c9b4a56cf@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 09:08:56 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] arm64: defconfig: Enable TC9563 PWRCTL driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
 <20251029-qps615_v4_1-v7-7-68426de5844a@oss.qualcomm.com>
 <jjbiamlcof6gttme3crotwyzsxtrguohaib73gcsaabpan5fqe@s5uroqqargti>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <jjbiamlcof6gttme3crotwyzsxtrguohaib73gcsaabpan5fqe@s5uroqqargti>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CigzXJC5Mx3HvyJQC3CdFQqTrzsIJMf-
X-Proofpoint-GUID: CigzXJC5Mx3HvyJQC3CdFQqTrzsIJMf-
X-Authority-Analysis: v=2.4 cv=Cf4FJbrl c=1 sm=1 tr=0 ts=6902ddde cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=eF76SeNzXSV_S8XMPHAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAyNyBTYWx0ZWRfX+CoAeWiBN5bW
 9fWXHW3dtcB2nEzVvD5giDoee6IE1lZOJ46QwSRMqJJVtrdSchmcIi9GAsaBegYoJ+0OciODYXk
 IIbHvM3KKUjBg5qjQYgCWNefl3M8+Xc3zqwM8QFSoD0hqxwI3k6znRyRT6+e8NWyUECc6dW3aUY
 2Os4Y2txt6C6aA1wDfg/s+Iv1T67K1/YNwKT6TgODJwAJbE6RU6OL+CcguPgZsRrHenvQDUO+Y2
 lR1ucK7L0Kvt8bbKSbR9s3rwF19l8jNgZf2bL0oueJ6vI+v1RxDrgfP7GgHNDv2Ul+EXDe5UQcD
 knXvnx0e8A3/MoRp9jUmRZz01/sPH90oN7DPA3HP9MfhXN3fN5DDGEz6A8QPjBDnAKXtjzOHgo1
 elpeEs5QGi6suy+JtxEbY618JLfB+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300027


On 10/30/2025 5:34 AM, Dmitry Baryshkov wrote:
> On Wed, Oct 29, 2025 at 05:00:00PM +0530, Krishna Chaitanya Chundru wrote:
>> Enable TC9563 PCIe switch pwrctl driver by default. This is needed
>> to power the PCIe switch which is present in Qualcomm RB3gen2 platform.
>> Without this the switch will not powered up and we can't use the
>> endpoints connected to the switch.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
> There is some broken logic in your commit order. How comes defconfig
> changes come before the driver which actually defines that Kconfig
> entry?
>
> Please reorder your patches _logically_:
> - DT bindings
> - driver changes
> - DTS changes
> - defconfig changes

Ack.

- Krishna Chaitanya.

>

