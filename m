Return-Path: <linux-pci+bounces-35348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C18DB4123E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 04:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBAF1B24D5B
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 02:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84741DEFDD;
	Wed,  3 Sep 2025 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AgN98ydm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9851C84BC
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 02:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756865798; cv=none; b=nC+iig+ettEZLeYnyPzgD95vSUmyl8Eg6xjKCGQGqnGSGYuGbW8SQnm7CNDW9EGZapd3h7zlrziPvf+KpphpJoy6nXqtc9nzBU0OdESgu4pgobwfh7T8pG6q8hFVgtPnGB7r0Y8bA2roYjcM8nzgaBxXzVwzUFKshemBbmgDKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756865798; c=relaxed/simple;
	bh=v9zS6j9T98yNyfjNeGOWdW3vrw4eq89d9I5wRlLVeWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcyEUzRVKU9pfsBtVOaHAs5bJ7uKZ3bURqe1ORwIQ0CBneQIvbeC4+bo7yT0afJW9kVwudhA6RdVFfEqKdF4ZvUNlPtJBvvNAq0Yw2AZEwa/QwOBtophbqJkYQk5KPy/UoSSHR8Xv9iF+RPaRZAeT+wweKp9nb8GhkbIj5SZUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AgN98ydm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5831xm8j012695
	for <linux-pci@vger.kernel.org>; Wed, 3 Sep 2025 02:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v9zS6j9T98yNyfjNeGOWdW3vrw4eq89d9I5wRlLVeWM=; b=AgN98ydm4gYvt7nB
	l9MYyadPaUTYUvFUVU9zZB0ns+g80ToOn8/+yPoceO9rYRbQ4DZuZCqe4KBmtP+E
	yN7SRhYjyFYa078gPdpYmTs4q7Os4P1xBATPDLTOPaBDG29Q7dvmCQQSlFWdqOUQ
	mUs8CCxq11+ML76qCOBaL09QYU0Rmsexa9b6mzeYBIiCxvpJ2Yd+8hl7ET4CQtLk
	7Or06L9LYQbo8mFnG4gOZKygS+jmm0iTvsFzad5viwRcg861q3nXHXVYIvyyhm6p
	gFe1w4eJYHWQNpByN1dMskGHMO8lnL7FbPea33tHY9g1oO5DPh+flFFrsI3hO3rb
	w0MxIQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk91pa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2025 02:16:36 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77243618babso3553800b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Sep 2025 19:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756865796; x=1757470596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9zS6j9T98yNyfjNeGOWdW3vrw4eq89d9I5wRlLVeWM=;
        b=lPkyV6vvtlC7GncgTHZRA01vAt3sCoBJP5k9DR5/fz6Vn/dr1atoFcsv72LBgW43qc
         oCt1njaGorM/ov4xDIt6C9hvvTqLdGyDbJPd9GFZnf+ZFrgwtkdhpkFQ8yI4hZvQnrLT
         pcwBi9ujt/SKF8UyzI49QCGZeo9sB9CXHYrniV7AUGq9nlZgRNZcffin537CMUpuzh3J
         eId1qwhGKgNy+QMzysPEOL/iNPKR+ZLTOYik/xJwP9+NtfyiF9U+JWyJ8/GiNUv39mlp
         /hU/1eapU1BDqWyXXC554P6b9o2sjzXrG140BvVrbczKiUWBdjl8lcCYj5zYTrJVjSVP
         UWGw==
X-Forwarded-Encrypted: i=1; AJvYcCX0Db/7ecHSdZztyKLFXawgVB+Eg5x1YWBLg7b0K3Bjkqv+tMuN4ZVqP+SAC/cgr91yeAxlpZGSUe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOezyUHmzprfl6J4tJDJzHdYF0j9XiYNw7HQ6/eIOs0MaKwIzA
	4AWhj2LVSaOdgooQ71V65iKpEe9AFR+IdJxUrl5RGiUdYFkBnIkfva3kSQ9YwbkgpvIOV/kx+Wj
	783Sn2GTOnyiyn/AkTqLa614hiHoqDj8jU+Fafzf/Vie+5z/52+uTeEdpKYt0omI=
X-Gm-Gg: ASbGncvbXHUn5asELbreblHa0k/NeW+2q4pDN/E36oRyZ+pA81mwB10PuT6FN16S54E
	Xy/Pg0dfyLI82NLkDsCHgpOs8bvaCZJFBakXlkCH6G1gOSLUGJYPNxM530O7uvLrOnpNtphh6PX
	O0AJ9fGIqz9im11mmMdqUpluLEDWsg8d7tJANkPo6BHOFyLvbdn9461+a0yJqrtunyCNoAU2QNz
	QuW9GGTTgafseQHP70U1qZub7vhPUkay2jqz88r/ELFeUnHE6b8FyUeMWd7Pq04wOIoagN0FQRv
	iV66dJ1gF4vs+YHQf04wyM4zAvAxofgYwlZmFzRna8L9OUMOfy6zUeAQGGGhxTHmhbXgKcfw2xk
	DwU2ggEuJQVgKuac=
X-Received: by 2002:a05:6a20:5483:b0:238:f875:6261 with SMTP id adf61e73a8af0-243d6e0100amr17326313637.23.1756865795893;
        Tue, 02 Sep 2025 19:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn3oKdkiywXs7I27qdf2yUwn9EW1s0qdzWAjlJxUt+zYeJZsSbpJFkobFdywABWGuVgSjbzw==
X-Received: by 2002:a05:6a20:5483:b0:238:f875:6261 with SMTP id adf61e73a8af0-243d6e0100amr17326268637.23.1756865795446;
        Tue, 02 Sep 2025 19:16:35 -0700 (PDT)
Received: from [10.110.3.132] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4edf7ed519sm9565518a12.28.2025.09.02.19.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 19:16:35 -0700 (PDT)
Message-ID: <bec3a42d-317d-4758-924e-ac53f5dcfc10@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 10:16:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
To: Vinod Koul <vkoul@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, kishon@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250826091205.3625138-1-ziyue.zhang@oss.qualcomm.com>
 <20250826091205.3625138-2-ziyue.zhang@oss.qualcomm.com>
 <aLWW-izvybTo52VN@vaman>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <aLWW-izvybTo52VN@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yzjQ7FgnYU0nS8IPRqfB3v6e6RqS2owO
X-Proofpoint-ORIG-GUID: yzjQ7FgnYU0nS8IPRqfB3v6e6RqS2owO
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b7a504 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=buFmA9CyAF0SDTxNqVIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX0yJeV3qI4Wol
 3IKgENAwf5p7aqPE8cJ+Yn72EwFtxUTtNSMwMjfqzlMtaYQ+Lcyww8UTWLi0T3tjuSTABOQfm3h
 ZtzloqBTlcnvEc90N0HSNQAK3MAIGcP3+/tVFlcKp59RMAeTkoUO6VzXqHihzBhdaalRPZ1Ac1O
 SwhdDF4W1LvqMM8m6lz3AIZQNfpIQYlf2dL6I5OCEwYy5CRozsSKAwhnay/p92zzgN5d9F2QfsI
 UqlsCAvwJWI/v6mxtMGPTiO+Pg+/tpz0lB0qslKWcFhw3e5G17SSFifToEHsMH2oxH5w5f9MUmb
 RtsXdjcazb57NDcKt8vhz3YrXOEIE1F7VTTmx7WbgUxuJhUXVQIOzUPrMw20/7BOIFQHmqZ+tcI
 sfLHGGdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042


On 9/1/2025 8:52 PM, Vinod Koul wrote:
> On 26-08-25, 17:12, Ziyue Zhang wrote:
>> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
>> specified in the device tree node. Hence, move the qcs8300 phy
>> compatibility entry into the list of PHYs that require six clocks.
>>
>> Removed the phy_aux clock from the PCIe PHY binding as it is no longer
>> used by any instance.
> This does not apply for me
>
>> Fixes: e46e59b77a9e ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS8300 QMP PCIe PHY Gen4 x2")
> Not sure why is this deemed a fix, also no empty lines here

Hi Vinod

As per Johan’s suggestion in v7, it might be good to include a fix tag.

This patch resolves the issue where the QCS8300 PHY was previously

configured to require only 6 clocks instead of 7.

BRs

Ziyue


