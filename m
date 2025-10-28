Return-Path: <linux-pci+bounces-39565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB7CC16454
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A733BA806
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6345347BA3;
	Tue, 28 Oct 2025 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DCsYtHLv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MvMijUrP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F97238175
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673358; cv=none; b=X6rNkdUJ3pBSwcC8/yNU09oFAXsXgI/Dl3BlL0bv0CTzUhJsx9Wth9rPza6eKiWQvrEltiMYYyLrQQiu1p9X6zh1vFhq19m2kBt++lueiej5nlnXKtaVFOigrGNxaa/mKJNbVEb3ZKUhYYxasqZF/P2ucPb4v19G/aPu8y2q5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673358; c=relaxed/simple;
	bh=sVgolvHBSJka8vC4OKuZhc6q69RPDNNdOJ+9cK7cy2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WC3PRgRHRdHlc7jNTfmLrQ0DGFrjy881DjcH7BL8m+DV0LOviTHKdejaDC1BDlRpR/tRA04KmhzQ404ejgE7sZfdHKrkm2eJnOeu83lH3bQ3dFQ7P28Rfnb/NogNkKC6vrgb9MJPe7qNegwhg+I01XoRrArXuSSQBo+QQpgvOgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DCsYtHLv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MvMijUrP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEnvc21886891
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 17:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Us00t4uVlHXxk31bFSR+oXPx+8hv46C7a9Rtr50Zi4U=; b=DCsYtHLvNZ/Xxgq4
	TiVHhZOW3reQBKx+JuS/Cuz+0OII3UG33Fk3Mj5ZRRNHGrvT/qRkNPEWfeCNlA0F
	T8grrCu7uACH8xX42mTCzkjk6f4sHEN31xRluyW8aJVCpDCT7MVV03sAlApH0GJB
	eEJHZ07JvuDcOe7i3vttTzCz+U6rcaJFFffwnBt5/yiqUwJiIVb8djEoeduCDjYJ
	j/KCn4L2/lZ6NGtirdtyztz2JSSKq8uD9/Q34b1W1iheP65gf2y4dajgR824M9UV
	uJOUwR4rR3zVQrv94WQKx4xkzHhH9u7p7vXCPo7wujSAdqUCjZmeUX7Ye4zqNKxz
	K0cj+g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2njrtk6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 17:42:36 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso4191282a12.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761673356; x=1762278156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Us00t4uVlHXxk31bFSR+oXPx+8hv46C7a9Rtr50Zi4U=;
        b=MvMijUrPxK13KdSX5bWR+sVbiKJSQw4692hbV47CdQbY9OSNmQ4u0/jO9dcGlK0tBT
         QAuvR8egtqKNa7o/PXYLT/VJrAj/0N22AZrQMJLFUuthrPzK+nPUsQJwzruhyH8eYgj0
         Z//atSXM6UmBvBVmc4mo7dVbXcWTGDlI7tL3gBpMK8lRVw3WdgRy6kSGlkt8dQ+SzDts
         vowz2DrZuBLbO/ynfXoaGUhj6vtvJrwetmEiaqG81e624+B8FPhKkLMsyim4cIgA+MOA
         sM2r6suyOyP/4zew6KahTlQPbB8iLslTQdhjW4naTq4kQto0Ys10LPSTn5icKlFqojlG
         8GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673356; x=1762278156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Us00t4uVlHXxk31bFSR+oXPx+8hv46C7a9Rtr50Zi4U=;
        b=K/BOa6WCfaic1b8Zy9jb/JLCWav5X2Bc90Tach3HbXc+BPH6R4ywT7eBZeWX31m4bX
         UAXGjD7cdjjIE6wFN00K7UpsPoDBMCnlrB/85VELmXVPvb5nkub/0czNzsPgn4bGoQD/
         X73b/JyZcrfewUOP6Yg11gTJ8iAPCe0B/eVx9yWDmlxqVEHg6qHu5e4bwYyl0grGUFgS
         nsLNBJtez7yy+gXIk+qzYo6WPnCoTtGMjVSrGcLIkOnUjl7PFZ9gwnS4jg9NCQsYe7Wj
         dDcVx72qwN65PxBxNi3TqHbbVDyr6IUsYIo/Ttpqb+fj5tkAuHZQLEzn+ElHWUgMTE/8
         mbTA==
X-Forwarded-Encrypted: i=1; AJvYcCWCWIonFUZBl68NhJdg4lhq0efWZCNLkzUwKWvoGDPcBwGu346Z0146PZC3B4KdaGzQBGLRvXsQh2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrwRiJFy82KFKIk7Ht3bUg2Ui7wmK5Vs1vVZb1uBios+Ftdog
	AC3S/Zd+EuJQfrHrLOuXzAqIt45GQspQ00DA5vVtpZZUT2bbm9Z5OaQHccMrc66/37kwQ7PuzO3
	lM28L0Iht5T0Ty607N+DRUZySHbJuycy6C1hDE4tE25mL3ypxqZx4l1daxi9i++0=
X-Gm-Gg: ASbGnctXu/9/CjLVgoVmzCrCZD0Yb9zXKy0tgB1r0CGk4bHfAWBLIdWyodeta+3/f5q
	IlzSuGM7YzRk72Cn6kuRl/VTga8tzjmqJA5xX2pdeQzNd9AcngYDB3puoytF+cWm31Bm/09SHKy
	WQLGZUOpPSbIh1ZGQpYbqd6ms9TXuSSxIKDN0wgpbSH4tcRR4HA6JWjSEBKdbLg8rwrl8nwjM+s
	1aKlz+0uugtFVAI/2CZzRhQPn08+dRxI24gA7UTYw8MCbi8HTMYGi6TDd56aQpBS2RWPK1pNcF6
	ULoCS2THq38zWUEd2zJj9mXoJhR06E0g0rioyhhmE2TkbVSJCy4zMIAyb5i6JvWqK0Qjb9kjlYa
	LXdLGFj1gJsNYIDL2kB7PWQURIVjLi6DcAQ==
X-Received: by 2002:a17:902:e5c8:b0:275:81ca:2c5 with SMTP id d9443c01a7336-294cb5376c9mr68893605ad.59.1761673355780;
        Tue, 28 Oct 2025 10:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8YmrED6GOKiOwqc3GYd5ad4wsT16uGbVKCFKeOMcE0bVa3igKgSnhX7LKmDH5DOEt31TBtw==
X-Received: by 2002:a17:902:e5c8:b0:275:81ca:2c5 with SMTP id d9443c01a7336-294cb5376c9mr68893255ad.59.1761673355274;
        Tue, 28 Oct 2025 10:42:35 -0700 (PDT)
Received: from [192.168.29.63] ([49.43.225.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c414sm123607725ad.44.2025.10.28.10.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 10:42:34 -0700 (PDT)
Message-ID: <e9306983-e2df-4235-a58b-e0b451380b52@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 23:12:23 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v8 0/5] PCI: dwc: Add ECAM support with iATU
 configuration
To: Bjorn Andersson <andersson@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
 <176160465177.73268.9869510926279916233.b4-ty@kernel.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <176160465177.73268.9869510926279916233.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dqvWylg4 c=1 sm=1 tr=0 ts=6901008c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=jzToj74tLtS9RNrshGflUA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=DjtaZYkIGepEHi-_gOIA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: gj39Z6uQ_NW5CMy1G7yDvpMzqyxX4H-F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE1MCBTYWx0ZWRfX2QHpF1mKli7k
 GiQCM86dy493nR1fxq43+gdkDnG6y0cfNMuqbZ1BMClm4j0pP2sq7PRZl0qnAKXojjeE+XFSCE0
 WT/lTwsCysZdkYMHI3aPVKMBYaSDeU0luroA1nH9iMxI3NWJP9Rc+aicD3phckvq6yUakui4s0I
 td7/J6/htXd7laylirHdIC5hDm/mrN1n3gqDKzro4cwQ5q8gYZaADldIEEZcPe7VshVKM5Y1Rnb
 fAanH2n4nIUf1BPkRd3zWuVhzoELxUKXX+Bfex6snQSUWPv6RRq4OE4I6yaiA4ES18rYebVI4yw
 1eSFhlPFIDE15A0cq+X5xtsDyaXtyFG9Xq+AOf4Rqj9PSXgsGD000tjf5Au516iHULKSQvbhsDC
 dRiRYgc8QDB6zILZH8HfDVk+oR9nlA==
X-Proofpoint-ORIG-GUID: gj39Z6uQ_NW5CMy1G7yDvpMzqyxX4H-F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280150


On 10/28/2025 4:07 AM, Bjorn Andersson wrote:
> On Thu, 28 Aug 2025 13:04:21 +0530, Krishna Chaitanya Chundru wrote:
>> The current implementation requires iATU for every configuration
>> space access which increases latency & cpu utilization.
>>
>> Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
>> which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
>> would be matched against the Base and Limit addresses) of the incoming
>> CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
>>
>> [...]
> Applied, thanks!
>
> [1/5] arm64: dts: qcom: sc7280: Increase config size to 256MB for ECAM feature
>        commit: 03e928442d469f7d8dafc549638730647202d9ce

Hi Bjorn,

Can you revert this change, this is regression due to this series due to 
that we have change the logic,
we need to update the dtsi accordingly, I will send a separate for all 
controllers to enable this ECAM feature.

- Krishna Chaitanya.


> Best regards,

