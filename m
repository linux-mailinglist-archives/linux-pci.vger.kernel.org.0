Return-Path: <linux-pci+bounces-33895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D697B23DB3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 03:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD393A8338
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 01:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088E919992C;
	Wed, 13 Aug 2025 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IiB6wOPv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813EC17578
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755048707; cv=none; b=YHYyTwL/FfolXl2PFyX/l9nQXPLnCchKrAg9JMnaqfxqb3zWzBHKMEuVbb811OHPtZe8Fhq13NfV9Nc6+Lvz+34eWJt9miphuArfCLNMigncbJcU38qSSTQTwwkfMAhd2RJTiBt+jp85Lx1pEDlyziaX1BDpv/zVPxmKZFwpAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755048707; c=relaxed/simple;
	bh=MvPb3zCS9Grc/PvA90a/i9WK+vFW2rPw8r2AYE0gtqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmC/CQj/23obtM99fD8tDilquphvhc0qeTjVViRcp91RQR5R/ix9XJk1XU9kk//4KRfqHyJ7H2zuq/c38ojMuzWZiDGWDjMlcnLC/gzjEZJWhmsqTqkpon3e6rZB7bGn5foao0EHRqDyEmUjDDIl/tYQldzDgBP1xwrf51LucyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IiB6wOPv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CLOH8O012907
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 01:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MvPb3zCS9Grc/PvA90a/i9WK+vFW2rPw8r2AYE0gtqI=; b=IiB6wOPvYXwAKf4H
	3/5ujJyGZpMq2KmwJJ8MUDUMPmhOg6LTMPvJY+5VQRhRUBcG2HSGxdyrIg9wFCyn
	JWlCSeL39kioCp1HNWSG2J8g6n1yRorLsefD+ozoJY1q2CE3Du1/5az7l3Br4bLb
	Kxa2n+GhYeTjn7h8jKjky4mhvKFzr4ATAp0MgU0xlwy3LnOqpm5AOUR5BxPZYAMf
	cB+flLbu68MCm8sxnUiRmzmegr6up+BHxPQXJ6DGkaOcIeUfm9kc7N/RQQ7cIaa+
	Nm5fPdevV650KCEApjTTlFYQruZu6AJ9Zdl9Xt22agft7PMGOFHZNl29HAFN8N2s
	Lx5XWQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbd6ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 01:31:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2400499ab2fso54066505ad.0
        for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 18:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755048705; x=1755653505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvPb3zCS9Grc/PvA90a/i9WK+vFW2rPw8r2AYE0gtqI=;
        b=Ofv87o3qOH3mCMv6uv+HT7FYjPqBHCCzcET6BYfMQPuf/PKstOfZtYuo8SFGICkJ9+
         REsYvuhoCsK8PyTxJ9G+1AxtZ28xl7GQjim3/xdmaMUP6rts12N9xCnA2wHAgjLrLnZn
         en6bB/12FXHBgaJM1SA+/nULws1Fr4FZ0ErZMZzPsQaXpjBP3ryANlJIIdcy32FaD4rd
         qk5JBc155EFLMjHDqGbKUM+Ug7ZTBhpuMiPHD7ukTQeSKrjv9x4qw7NIj08NrhpO6vTs
         nZLxkgHG9+eUei8hsUoQzl3quyVucpR1Zx0id63Ax94KcFWx1gQ0mmvI46VIzo3PsMXN
         92iw==
X-Forwarded-Encrypted: i=1; AJvYcCWyslea/GAyuyPMowjfMfjpXKRUm7hmzbTauKzPSvyNQyts8J/brwVPZkJDbQXGP4KA4A+7vmyCViE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGi8zlyohBY0UBxbU8gHyldpBoxx0nTC0FwIvFz1yfu2HSOo69
	mumYh244grH4q61gm+twPq6Ujq1/RFY5BxpV8p939OYmaPszQ5l1yY+LYnxPpRGpz402mOOejHu
	wC6aOT5ClBrwkc9vqV1mIoM0ODHmNE1eSHoy/VuJCz3UOfYee3VeiCn2uAOprGKI=
X-Gm-Gg: ASbGncu5dAm1IbZ6DsmQT4YMtoWOnZdB/IEaUZeVbatHp5b/AWKhDjQDmMSiM958xnG
	QOdXVrDuKwAJ30P5XIgh1+bHV6yYtUCbowWPqAWoSsQKl0O7N15F4A5VG7cXmY4W5mJchmhD/+i
	eNdLU5RoJSQLqAlWmAeXGY1DYiQrQOflDMdPYUlqu/ZjPv/PLzlzYScQb7P/1z+mqHdOPOU7TAX
	30PaaZIQgQFPrYBujotnCyn50Vq/K49Me//ZXChfbf1NCkjKTd3SI3K3GsfY7+9ThjCVPqTTbG0
	YiTnzjmGP+CtydARRNScsAKsEcxFAr2ZoWDNWbtx4gBjA2wECiYhlwvyDPWT/lJehLzQf9PSRDc
	5QP1C35WtF6f4UeMKOSvgKnn3dT1b
X-Received: by 2002:a17:903:3c2c:b0:240:bf59:26bb with SMTP id d9443c01a7336-2430d105d69mr17783295ad.19.1755048704787;
        Tue, 12 Aug 2025 18:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdQ1DXAaDzxKmVvrKlv5h38m6LWfzDz/yLj0/n0px8bSRgCo+HiXsqzUIOas6zP/ZN2Hi6dg==
X-Received: by 2002:a17:903:3c2c:b0:240:bf59:26bb with SMTP id d9443c01a7336-2430d105d69mr17782695ad.19.1755048704225;
        Tue, 12 Aug 2025 18:31:44 -0700 (PDT)
Received: from [10.133.33.58] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef83f3sm310234365ad.28.2025.08.12.18.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 18:31:43 -0700 (PDT)
Message-ID: <cef1da96-f584-4100-a97d-640fa24e5f54@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 09:31:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
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
References: <20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com>
 <20250811071131.982983-2-ziyue.zhang@oss.qualcomm.com>
 <aJsYd7tAi4CdOfZ9@vaman>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <aJsYd7tAi4CdOfZ9@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689beb01 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=buFmA9CyAF0SDTxNqVIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX/Z3UolrsOtra
 cGCRKNAJdY5jPi8a1eHW7tmS1aA7+nqIyNKkeWIqX1MwtUkX4MJfcCdZw2Hgcc4xtWJXSRDzcWH
 VT7vIRvCDjlZE87bAdUocD5mBTSygZC0bQW1QaFducFBAec5ZclKedpmJOE19j5M2DElGIJ7aRU
 +tFxdw2xirS0icfO169JsGIMm9daKrBk8Hh+r4NKtOcIsJM3JS3HkNN+DaS8Mh8A51BFYsuHBbJ
 XDLidVoRvzW+m992nsv+yB1Src0ROdjZ8dEMFA82WrK8CL4M2KLRTWIZYdmcqwWWsED7kIcSTjD
 j7oFJn091KC1HNcEa+hbuWfsyGVwD7Zu7IH0iLYh1eA4Dca5gMpa+dx7qzrlUSMs6ZhpNCz2uZu
 HKGMOtbM
X-Proofpoint-ORIG-GUID: DQw6PHiOaRKklZwsOi3lwJOVFKpHEfDj
X-Proofpoint-GUID: DQw6PHiOaRKklZwsOi3lwJOVFKpHEfDj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097


On 8/12/2025 6:33 PM, Vinod Koul wrote:
> On 11-08-25, 15:11, Ziyue Zhang wrote:
>> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
>> specified in the device tree node. Hence, move the qcs8300 phy
>> compatibility entry into the list of PHYs that require six clocks.
>>
>> Removed the phy_aux clock from the PCIe PHY binding as it is no longer
>> used by any instance.
> This does not apply on phy tree, please rebase

Hi Vinod

This patch based on the patch you applied in 8.12.

dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
commit: aac1256a41cfbbaca12d6c0a5753d1e3b8d2d8bf

Can you try to apply it again ? Thanks

BRs
Ziyue


