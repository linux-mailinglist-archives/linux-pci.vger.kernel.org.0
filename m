Return-Path: <linux-pci+bounces-25785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2B7A876DE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 06:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2A7188FAA3
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 04:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789EE19048A;
	Mon, 14 Apr 2025 04:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MI0jWEIL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4718DB20
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 04:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744604508; cv=none; b=RlYHMvD6wAJJ/Nw/lE3vDtWuvYFHQ0a3ATaljyWH3YWOEs3ShdtPeonZ59smS3/3DezwuAnLrLlZmCmiRj48wW/tpACAzr5/AvwMslwLyKrhrJK1jBv7BUkj487/qgNdWAzMDG8Twya/JPXJwLXQOGO3Nwcv53jx2ii1nlYl8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744604508; c=relaxed/simple;
	bh=TQ2XuJsuSjCYY9Sr0D87ughaklctGZthjIEj5rhAbrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ll8Ys1+7GM+3Z/q9o/3LlOXg+h7UKVIcZINTB7aj6ROorvwQ0PAWyqcqpNZ+3PqFl7fZmo6LeD5kDXRrFGm+XLd6LodoiXZTaYIMpXdjQuENnhfkfbGf0VZEMLbqpAqSqrcP2OZMM57fTZKpvgTtY4DCes8ZDbOBOc3/Tqh//O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MI0jWEIL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DGrpVc011276
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 04:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v1062Qb00rdFXbKWOZt6famOxoqeq892jzAre1MombI=; b=MI0jWEILVHMt2AcS
	XFwlhBQRn8gK7noR6O1l4pt0l0XCxTsqqVLbNRIPp02OBaeNC6f2OyhxMcsL20cM
	OObdLxHf1NUAhGLCxCPqSKBYbU7eqZuCA0XV5hKyHnYhvWZKhJvQ7WUlWm52dqB3
	VptvArV8r9NeJZ4U40FqqLs3LY57WRaV3LmhAsG5qVdHOGvSxVBVzT+CjMpA9jq+
	R+5WbhWOHclg7eVoTMdB6TNR5J98ZCXSELa0UumVlk4lwRZMHJETnt+tWeVYAe2u
	11T5FPVPyf8CmSggkefbHAa+cJ97dqAVaeFj6Gv8plAthzCdB3pUuT68HqbSGJRo
	X3fX4A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxju6uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 04:21:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3054210ce06so5249773a91.2
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 21:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744604504; x=1745209304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1062Qb00rdFXbKWOZt6famOxoqeq892jzAre1MombI=;
        b=qeJf6imyCf+rC4HETLsJox4pNpdzm+PJUSHSuuzlRjf6ZEcWntMKDdhnNv+xbPg2Yh
         FLOIb/m3qSW/q1XI52l701rJAQstrNyWJLVTorwnb1LA+0wuhX3gZvjJDHFnHfXv1p1p
         K9A0A9l8304zPbOk9jX/wzfCrshutYvHBBiVsT5KuE3OXtsZQFsNEH9nCLua4O3rvJ/g
         gfbsk4hlFjdoRO3+zHsY0RuRekD00Qe6e1xml19feJVqFncm/xHyYUeJFPX4oNaA3js0
         S+7mTN2IzQvIeEh3tNqUL2hlv9C2A0nv08ckfHd90mqfnyDb05QVox3LqbWYwotzvXEJ
         3K7g==
X-Forwarded-Encrypted: i=1; AJvYcCWSlJ+CCFw4nfivahSuZmLL9Ethz6GYj/K9pkA4fExYAWWO48k420q+rwdGx3XUbB+Q/Mm+qeAAuVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdDpiUZP2zHijIBinlGUoeHklDuV01OTMnDqCCUKXt6Y+Zhve
	+Qjqo+EfegFEI0xZndCq5oh1ZTFso+rk0mthXJUq2XBcsKECnB3z3IR7oKGXvRwxm4QH9qD/bkE
	454nBhT375gMV4xJKrbPkkPhUmQ43UWU93/ZcsbxEPSPVCBi+UJ2OSXti8GY=
X-Gm-Gg: ASbGncvHPFZBFR7trOd8o7Q8jkbv2TJfX4fRzfTtZRCGLOf90IN6zurJwJgBGVREuVi
	VopWst0Bl/XG5SJD5e+ebTsUXZ3tru304i3HtELx7X97mb8qOgxSiPtMF8jVBE3nmYWwRnUrtNa
	aBqI6G6oRodt6jbJyt2AKdz9ffZRengkMJeHKdLsjtCtBWhdBt5h4AEfXhVImfmdTPszNUu5uT5
	mcvvev1+WYQ6xG7Gr0MuPJx28U5tLbCIs/Q6pwQZApWJYHFiQibmXHoE/WBVWUXIqOePRG2n4mi
	jtijPXCh6G9Z24oPs1pAS/q4i2XWgmtGZmUIJ+B1Vg==
X-Received: by 2002:a17:90b:3808:b0:2ff:6608:78cd with SMTP id 98e67ed59e1d1-30823646b04mr16670444a91.9.1744604504095;
        Sun, 13 Apr 2025 21:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgLh9KbrEwTxyAmeC0D1o+Gbjg5afrIg3u0yS7IjiKO0bk4BGXPzyV29VIQvaXYKiAsiEiIg==
X-Received: by 2002:a17:90b:3808:b0:2ff:6608:78cd with SMTP id 98e67ed59e1d1-30823646b04mr16670397a91.9.1744604503461;
        Sun, 13 Apr 2025 21:21:43 -0700 (PDT)
Received: from [10.92.199.136] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df403d40sm10120276a91.49.2025.04.13.21.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 21:21:43 -0700 (PDT)
Message-ID: <9cc84d20-90e8-069d-db0f-21386c5b0a98@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 09:51:34 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 7/9] PCI: PCI: Add pcie_link_is_active() to determine
 if the PCIe link is active
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        Dmitry Baryshkov <lumag@kernel.org>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
 <20250412-qps615_v4_1-v5-7-5b6a06132fec@oss.qualcomm.com>
 <Z_njmA49Gda-m0aH@wunner.de> <Z_vw_i1P_Y2gCYrR@wunner.de>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <Z_vw_i1P_Y2gCYrR@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=67fc8d59 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=DLE-xEQoUa54y48t:21 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=a1gpy7YTC9TOQ5gj66gA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 2IEIu4YtHesDgy0TZwK9M4d4qTD3zsR4
X-Proofpoint-ORIG-GUID: 2IEIu4YtHesDgy0TZwK9M4d4qTD3zsR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=723 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140030



On 4/13/2025 10:44 PM, Lukas Wunner wrote:
> On Sat, Apr 12, 2025 at 05:52:56AM +0200, Lukas Wunner wrote:
>> On Sat, Apr 12, 2025 at 07:19:56AM +0530, Krishna Chaitanya Chundru wrote:
>>> Introduce a common API to check if the PCIe link is active, replacing
>>> duplicate code in multiple locations.
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>
>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> 
> Looking at this with a fresh pair of eyeballs, I realize there's an issue
> here, so unfortunately I have to retract the Reviewed-by:
> 
> pcie_link_is_active() differs from the existing pciehp_check_link_active()
> in that it returns 0 not only if the link is down, but also if the
> Config Space read returns with an error.
> 
> In particular, if Config Space of a hotplug bridge is inaccessible,
> 0 is returned instead of -ENODEV with this patch.  That can happen if
> the hotplug bridge itself has been hot-removed, which is common with
> Thunderbolt, but also on servers with nested PCIe switches.
> 
> The existing invocations of pciehp_check_link_active() do the right
> thing if the hotplug bridge has been hot-removed, but after this patch
> they no longer do.  For example in this hunk ...
> 
>>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>>> @@ -584,7 +557,7 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
>>>   	 * Synthesize it to ensure that it is acted on.
>>>   	 */
>>>   	down_read_nested(&ctrl->reset_lock, ctrl->depth);
>>> -	if (!pciehp_check_link_active(ctrl))
>>> +	if (!pcie_link_is_active(ctrl_dev(ctrl)))
>>>   		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>>>   	up_read(&ctrl->reset_lock);
>>>   }
> 
> ... pciehp_request() will be called if the hotplug bridge was
> hot-removed, which isn't the right thing to do.  The current
> behavior is to do nothing.
> 
> I realize I steered you in the wrong direction because in my
> review of your v4 I asked why pcie_link_is_active() doesn't
> return a bool:
> 
> https://lore.kernel.org/all/Z72TRBvpzizcgm9S@wunner.de/
> 
> So I sincerely apologize for that!  You actually did the right
> thing in v4 by returning a negative int if the Config Space read
> returned an error.
> 

Ok, No problem. I will revert v4 patch i.e returning int instead of
bool. I will wait for few days for any other new review comments.

- Krishna Chaitanya.
> Thanks,
> 
> Lukas

