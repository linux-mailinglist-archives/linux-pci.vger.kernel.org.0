Return-Path: <linux-pci+bounces-29274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDC4AD2CB4
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 06:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9B13ADC1D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 04:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875C121FF32;
	Tue, 10 Jun 2025 04:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ir40oDxu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145781F8691
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 04:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749529937; cv=none; b=fYfsoPtiuk9jaj0proaXX6ft656BsaYH2+BC2wgIdpCmJqiGP7wPKSHp48DqJqrTM0nRhq89o8XTC++0M0VU4jjm4peW1zPnqeEcE1T9eET2DJNnxKpMXpgrl+Am2DusNCKfd8RFBN2qvEwCOaFx39AYhZ8UZ6df6L1+u4IvPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749529937; c=relaxed/simple;
	bh=TB4ZNWBCjvGt5BSqyUv7p1TpCvZYbANGsyyzTWwm7fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLntiC3bxKCrMZYVJ51kLUVj+66HmyA/r88YLTOG59qMdYAyeuGFYU3Ji/yBP7IvfO5nO7KI051Qv8T57dUfqu2+zOG60+ANmfgo2sVTjosSnlowhc6Y/COc7RCVBOXLF0ohG+J9RURnlUV9srmNXD6zkvUmsHrAY5Vx7m7yzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ir40oDxu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559KiscU013424
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 04:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QVojJfQxCgn9ocPcE61oqYb8TABL5BLk+mOuJMx8dC0=; b=Ir40oDxuy+0dK6Tu
	pPQsgqXKAczMfd4hQshrPn32D2SrqDbreazix7cjUZzU5cncbpNmD3jxNndEnrwY
	m1Qfjbpf6Dr7dbEILXFR/vOc7cCz8asnrAkMemp/1IY5ykFN3LPwkJy8yAav/JXA
	T7cfmB1ZbCHwCD4J+d32gcOfV822mHPTKakvYuhXEItCJk5yH31jNN/ZTIYDt0Ue
	O+KD8VgYEMOP5IkU8T70lSDREdDZAKB4q6nXxldU9adIVXfbSUUbD11XVu/TVKdV
	1k/1kXhDDTZxkS3RwBEAS5NEUi57fim20VYnCoMVSY4J5/EkF0BXwMhU6NabtRiS
	Nu38xA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ccv81km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 04:32:15 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-742a091d290so3483406b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 21:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749529934; x=1750134734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVojJfQxCgn9ocPcE61oqYb8TABL5BLk+mOuJMx8dC0=;
        b=h7rKj/BZOuAIaJ3cypL9ZLDY9/QpQ4ZHjTjx+lQJ2Td0NrcKPO9t1gkkMaiJJm2N6Q
         uBOz0Csap0um6ES7hFQ5fmpL+6D1eYLL8gQadI9FQpxKZc3LW/SFHUNru6D8lYmiO5ZX
         6BdyU+7Y5MJQhZzhnkmk62WX2noMJuup+rBuomGNTTWRjGPdNxtWxsr2iBv+gT9X+cPa
         cSY73ehJOh/dl40ytErk3XxHs52Ft7knb/NPD2wsXGBsQiB7yN8BPpyzOUuWcPxSwwXH
         IGBjSzq/ZxNrkhFZQZdJAYUCQyDLi8BPDBkY1PIarP/BxDzzvw3vejVB0T9kt/KzKds9
         MBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV4LhOewtBKtYeFREJKb6CqKenbbyN9sYSlUn/kpTfy+Da6ptK/NZv+Ax7hlco4tYFtPwcU4LN2Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS1AiHOGti4zggqlc+AFcmLBs8QMK+bS58boi4n4QdSE5CpxCE
	+t9tpulM1ivlVnGLQud51c179Nc8lhRTC8oavdd8LfMtya4nSkbD2bDi3XJY0429AenLh3cnbzo
	hfJSzV3kiA0OpRhoxxe1DefKFCBZLUNH0GGs7DlpC3K6lPfrA84+WlSaz/g5gFwc=
X-Gm-Gg: ASbGnctBixXue9zIJhWEw7Bs8zNeYrmOSbMxYHJCWDZ9SD8z0JlpmoBFXEBmhIj7CB+
	z9S+u40HtvQRZn6aa7LvwNNTguVsyxYZCbTA0rlj7ITMkDmVwb5i8Qevrq2E8C+s44qs29KJr57
	JUUtpq5WSzPjZIY2k/JffPh+4yiRii5RwXlLfAeMKeOhe0DgTasnVTgmyZne6GbGP8NBcHFcMrv
	p2nO0j/mlmuFtLUmQDwP5hYOeEtUAJhFEqzFseDlxhe5CKDgML8ZCMqntp9GzTqlsLE/z1vJvlN
	pfaIub04pak+l5koF4JUdeJkTtVcVUcV2Zi1L6I6niSumYf98/h0
X-Received: by 2002:a05:6a00:806:b0:737:9b:582a with SMTP id d2e1a72fcca58-74827f3dab7mr22525867b3a.24.1749529934157;
        Mon, 09 Jun 2025 21:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7R6T2DzqqmZ8Jol0wT/yDgeRhUuXAjB/gYgVGkR+i9HNrdnkufPipZQ3OQAkvTjhT+YzTpw==
X-Received: by 2002:a05:6a00:806:b0:737:9b:582a with SMTP id d2e1a72fcca58-74827f3dab7mr22525827b3a.24.1749529933756;
        Mon, 09 Jun 2025 21:32:13 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af7b2aesm6771668b3a.61.2025.06.09.21.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 21:32:13 -0700 (PDT)
Message-ID: <c1e34051-1c7c-0ac3-f447-6c86254cddd9@oss.qualcomm.com>
Date: Tue, 10 Jun 2025 10:02:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/2] PCI/portdrv: Add support for PCIe wake interrupt
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com, Sherry Sun <sherry.sun@nxp.com>
References: <20250609162930.GA749610@bhelgaas>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250609162930.GA749610@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kWw7grgvQvKEQQfyxmwy3t5RfZ9UoUgX
X-Authority-Analysis: v=2.4 cv=TsLmhCXh c=1 sm=1 tr=0 ts=6847b54f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=IGDvqKsIrZGBqitOJ9wA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: kWw7grgvQvKEQQfyxmwy3t5RfZ9UoUgX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDAzMiBTYWx0ZWRfX5p/ilGbK0W9J
 ydNvKFpl8eug/UmAlWYTmmOfJa5YdDYoYdJ7zCAhU2Vglpq9sMbWye0TicqmCofXC/rSjYXmm6/
 YPQG+/yMVbcg/6ec6Mz9M3wt2GyVFl+iGL2CP7pD0Io7vhTD7gbMBya0oVCmK9Sc+W7dJr6RNPN
 1d5XpQD8f5tmltKB+NVVCXBCWqYnj77d+KcsNoBMcxu4aV31jryEapNDYsp/bg0Sn9M7SscfPQa
 /jnf/e2yfSl6WCeLEgFPBhBoTEJE26c/2EFRszhRuKKYO1/wHxXsAj54i4YrIKPpoo2GW7f6CXb
 L4Ym3s7th6/V2r4gbPEng1/0Q0Kg1Xtb9Cnf3uJMTZeXhgM0HDrGy5WEKRl4GDsHMT6K+qBYmFi
 cvJeHhLa+3ZBh0e5qtJd9kYrN4pnHcjgPXA6+ZnUn5xrsxzHC/W1sG2j7BBQal8HktSYWIRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_01,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=817 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100032



On 6/9/2025 9:59 PM, Bjorn Helgaas wrote:
> On Mon, Jun 09, 2025 at 11:27:49AM +0530, Krishna Chaitanya Chundru wrote:
>> On 6/6/2025 1:56 AM, Bjorn Helgaas wrote:
>>> On Thu, Jun 05, 2025 at 10:54:45AM +0530, Krishna Chaitanya Chundru wrote:
>>>> PCIe wake interrupt is needed for bringing back PCIe device state
>>>> from D3cold to D0.
> 
>>>> +	wake = devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(dn),
>>>> +				     "wake", GPIOD_IN, NULL);
>>>
>>> I guess this finds "wake-gpio" or "wake-gpios", as used in
>>> Documentation/devicetree/bindings/pci/qcom,pcie.yaml,
>>> qcom,pcie-sa8775p.yaml, etc?  Are these names specified in any generic
>>> place, e.g.,
>>> https://github.com/devicetree-org/dt-schema/tree/main/dtschema/schemas/pci?
>>>
>> I created a patch to add them in common schemas:
>> https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
> 
> Thanks.  I think it will help other DT writers if we can include a
> link to the relevant dtschema commit in this commit log.
Hi Bjorn,

I have added this link to the cover letter, I will add the link to
this commit in my next patch as this make sense to be added here.

- Krishna Chaitanya.

