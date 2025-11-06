Return-Path: <linux-pci+bounces-40506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88080C3BA47
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 15:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD3856462E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC4C333734;
	Thu,  6 Nov 2025 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QQvZ+d5A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="crdGjc9H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDFF302760
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438065; cv=none; b=IxC/4JE2AUobEq8ZQgWUvdOig3oB/xtIXs0jk163Rp4FGDw8K5Z0xbbi/w5POLpq0PhACgjYBPszbmO/j5dqEcbUS8dobGzPWrvvcwT96C6Fc8btZWwERdD+JkG8wJZ118Ve8/Uqc7rBRKmfaWnldeNtN4Iee+KQ39pSVMMfA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438065; c=relaxed/simple;
	bh=SOccKiy5Rdbr6pq6sB0mWtUflMzLr3rVH64LwrFeOVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sy0Zj/zuvydXYwAwMjo34n9nFnvVjOeBI82Bb02rdxMp5PINHS1dDNBUyC8IxdrBBz6WY0KmPmNRskVDkIBeUWHHHIoCEh9foUHO/Dv7r+mNB/Hz4xpaKxyAmMRwqTj+3W9Nj47yGaB8uc0mSyP6ey/R5+MEqXStO2Pun7SSn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QQvZ+d5A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=crdGjc9H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6BlE734131423
	for <linux-pci@vger.kernel.org>; Thu, 6 Nov 2025 14:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zlBnzVB5nxzy+Z7vwR/dqDEVVZyIcEzuFRGM+j8huts=; b=QQvZ+d5AIl179X7G
	oNgzd+fA/TENVGJ6bfTJwJZJ2yI0qR6nhARxOCIwxPl4eTZu/+OvD6EYlwjMt4mb
	0lSfkkyv7HTPsm+GAcwHINSubnm0wC9DdsNRaHJ/b7buC1badIHer5IQo0THbteL
	ZRup+VGq/Q5Uftg76iR8Ex583V3FIXh0UeKpkcF6YEKnHOAH2ZIcul8oMf9kej5E
	v7yLps1O5kXDHyZphCBXtBc6Hrpf423CHqwjkh93na6EK1hyS06PldPIkOENV0Xh
	RDA0BdingP6TbQwmPkGXi6sYApeIg7SxcqSpxDR0t0o8bloYfL18abGs39KWqXTZ
	eTS6ew==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8u3x0c2p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 14:07:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33baf262850so1173553a91.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 06:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762438063; x=1763042863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zlBnzVB5nxzy+Z7vwR/dqDEVVZyIcEzuFRGM+j8huts=;
        b=crdGjc9HnTa+VhBHLl6fkq3p69JScJaWrIyXbqpGD3cikY9LhXxEeTU0RQ2iISBSxb
         w9mo21SWpmFZva0uLXopf+1pMnDluY3+s4WaYiP5+LpMkjbZZapH/wSBhOWpsbRpE/kD
         mO1Y9UYJRi1JIKYu/S9RbvoIibPxSSrnLBH7VnXXAHBZMHA/iYaxocs9xL2RUNN4g/BL
         GC/iYbwHuOeQxRr2q1Lvstgo8fMfY5H9i+je+C7KkUIZBeHg7n83L7Ydw8StETtQjRfz
         kZtP1CSbtMYUkroAlCkLvAe2lcCqLHq+af7E33ACMN779H1L5MSlKPgqHQg2t8yDQ9+S
         GDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438063; x=1763042863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlBnzVB5nxzy+Z7vwR/dqDEVVZyIcEzuFRGM+j8huts=;
        b=GDgVYsf2so7COecodes7EEfeFsNYPHSJdspNL8tetJSKzjN9Y0BO9cU+JPhDVgvDGf
         7IAmc8AQOYNji2zDq1Lau+GlY9xAcrnlBLdmICB7DVJPYRpHpNHoYsfgJgBHH2LRRQvM
         ZNhMP0YTVIqfzSm2Via3ZAOkWEpIwkd4DfPyxuSRkNl0qG4feOPn/o1n56lkIwCeiEuD
         P0nSOPfA4kzde4HgLZqZYKc9Y6r62Pfzk3OuXJYQ/+ZBEh0rERp674mxaG3NQ8u0AGf9
         TSaXYn6jYuizVCbdO+WvRFfejvH+5boQ4mepoOt3pDSXX1lN/nCqo990x49QDc6Sv2qj
         8ShA==
X-Forwarded-Encrypted: i=1; AJvYcCXWbqbXPE7xsAhXWavT76srfLv2jK748mxLhrFs/BhB38WLYZVMJkGLnZzczJTrJJwlfXCgzaa7dSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYlodCryW7PN6VWIdK/7Wd18sdZJdGlX/Jk0LabIu49yYLfEfy
	qNoY/+wJALuYQcVNOPl7HutNNC/e3pr/WflPCRsnttBVzTIOM9MgTOgkKuBCJ5XZUu2FbeVwrPK
	DGuvi5tQH+SLQdG3RByFFQgYnWhpBs4+Wqu4VKuqfbd6RVHSwYEOiaoGCMoQwjlU=
X-Gm-Gg: ASbGncviZIKtkfvCJqaKT/Nj/yebDVvTdR9xzy9NInco0gR5qj5C8g76lkfb0cFJ4Fn
	1zblARRbaMzhVem2205uKAyq0JzxTzL5y7K5/qffQGpeRHJ5+iM//N7fHLU4owgU6xpjh0FU8Mo
	zPV0pd4a9ET3cCCDaQThgXB6tKAemBOm8M5MEvS7H+ZbZJ0BYAri58GAB69M/orugSVRkdI77dF
	boLYpA9DWu/2VFKKq96aqFHMkxuG7NuZne1OduI99H6uBRWqsjibJX6OReTv8u0Ehj7eKJKCwmF
	uFW1QvVAissZg+BJDbhCcFq9+/U0aa09703Y62ft3Q8pZlkxCKoDC7kklfMtFwZO/RhEdcI5DIv
	HLV+lGEw0uRoa7JeZmBJBiwJT74m36/EL5g==
X-Received: by 2002:a17:90b:4b83:b0:340:ff89:8b63 with SMTP id 98e67ed59e1d1-341a6dd839cmr7917820a91.22.1762438062726;
        Thu, 06 Nov 2025 06:07:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb5xADXggWF7dRNeF7sG95acRl1JztjRAlFJmaO2OvQU/vqH3pUikfwbJOHiUbUbKUov+t3Q==
X-Received: by 2002:a17:90b:4b83:b0:340:ff89:8b63 with SMTP id 98e67ed59e1d1-341a6dd839cmr7917764a91.22.1762438062062;
        Thu, 06 Nov 2025 06:07:42 -0800 (PST)
Received: from [192.168.29.63] ([49.43.224.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d0daabd1sm1131993a91.8.2025.11.06.06.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:07:41 -0800 (PST)
Message-ID: <96c49d08-10dd-4a82-a6ec-345701b771d6@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 19:37:32 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] schemas: pci: Document PCIe T_POWER_ON
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org,
        krzk@kernel.org, helgaas@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
        conor+dt@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org,
        quic_vbadigan@quicinc.com
References: <20251106113951.844312-1-krishna.chundru@oss.qualcomm.com>
 <7v5bmbke37qy7e5qns7j7sjlcutdu53nbutgfo6tn47qkojxjy@phwcchh5gs5q>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <7v5bmbke37qy7e5qns7j7sjlcutdu53nbutgfo6tn47qkojxjy@phwcchh5gs5q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDExMiBTYWx0ZWRfX5xX5HoFJ5OKD
 K932YkgXfts1lQ098DUpa71bDtLu4rFuKg7usA1+aWD9hkFguRa5jDcTJ8CIBHICcNXjFAIlAfZ
 O3BInolS7J8i51xghGZfVlpxfHmrM8WtKJKa9pXkQIoFvtaxHBLlLwWT01OBqRYSWY7yWK/V25Z
 YqfHqcf9fKlfgSRVdbGq9cENHpCMzRCLe8iKnRifppCz4jbNI7OkvzlVdWHqXILh5myA84UfnH9
 4jppR67FeobH4rdoG5oY/Bcwfs2X1DncMWK/uHGfKhVlZ2lT0HFMqVJkqFJ7T3AfOl0INFXJ1K3
 BI+04MLLZNMdlhjY2uNxvygBJ6+eXxj2imMrHby7q7ZwiCfnlTMZ57o0poTFtKYu4Il/gA9DeOO
 SRSR6Qpqli2/dCPtDc4RYaaWUL1YKg==
X-Proofpoint-ORIG-GUID: bDE-xJV4kCWURe6YixLgpwSY8sPU0EkD
X-Proofpoint-GUID: bDE-xJV4kCWURe6YixLgpwSY8sPU0EkD
X-Authority-Analysis: v=2.4 cv=BrKQAIX5 c=1 sm=1 tr=0 ts=690cabaf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=1uN4TIezCBQZsvcDmGHwSQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0lSf4L86Ka8fYzTnLDIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060112


On 11/6/2025 6:08 PM, Manivannan Sadhasivam wrote:
> On Thu, Nov 06, 2025 at 05:09:51PM +0530, Krishna Chaitanya Chundru wrote:
>>  From PCIe r6, sec 5.5.4 & sec 5.5.5 T POWER_ON is the minimum amount
> T_POWER_ON
>
> You should provide reference to the Table 5-11, where T_POWER_ON is described
Actually 5.5.5 section has only table 5-11 which describes this, I will 
add the Table 5-11
reference also in next patch.
>> of time
> "(in us)"
>
>> that each component must wait in L1.2.Exit after sampling CLKREQ#
>> asserted before actively driving the interface to ensure no device is ever
>> actively driving into an unpowered component and these values are based on
>> the components and AC coupling capacitors used in the connection linking
>> the two components.
>>
>> Certain controllers may need to program this before enumeration, such
>> controllers can use this property to program it.
>>
> I'd remove this statement and just mention that this property should be used to
> indicate the T_POWER_ON for each Root Port.
ack.

- Krishna Chaitanya.
> - Mani
>

