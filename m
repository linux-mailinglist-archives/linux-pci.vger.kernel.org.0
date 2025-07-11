Return-Path: <linux-pci+bounces-31925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151ADB01A28
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 12:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569D91753E8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADBB289804;
	Fri, 11 Jul 2025 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bz+QdSKw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B7289E13
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231324; cv=none; b=cbq6Bj9sa3eKe7EhpcOCcXKCo2rXEbwVGaCvXjDc3iXUJs9reijaETV2sCa29EF0PmjFp3j7z4icKG0GIML6upKMRiGgwZldYerErRRgCfwuid4Ll5H+vG9ijydblzwVVyDSx9ocFK+bvuIzfrkfTleHLSV/zrqDLKhuTQC8Zgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231324; c=relaxed/simple;
	bh=2xu+OXOLKfoKa+DHjFfwab+SE6ntpEh2pVa/29N5gAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLjNtj/dTt6L92oqu8QiZbGo8bDHw4wNkQ/MCjJ7w/Qf6xloKZPFDKv9F/lN4n2bLl4bFSBc1K1fRrAw8tM5hrsrwbUmof25UDOc/wGCG7pdREMztRoBTNL9qVFOMs+/OCe1i59xZCgb5FSvuTO9jiWO7OEaNLDD35LyAq9eluw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bz+QdSKw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAr35G018332
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 10:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RBto8+nkBzC3SIB5+AQtnfGYPNuUEuMvL0M4sbENf7M=; b=Bz+QdSKwQl5wal/U
	gbg+0WNw8MtXdTa6Uj7kikkL6LG93PVtd1ukrhBBNo+7sDT8LDNirMEIL8DpW4l2
	yhwwHsETVlCt7X6wCyeE+hfmdhGU9ur//FySrA3jehGFrSYHOtPL+fXo8rSaHq1l
	VJNcEuAPbd9W0KONfQMPj1D6fX2Tk7oAOjrntUj6IXeWm8WMFdt2CKpBfxP/1Bo0
	5c+v8w1pNWFWASpvoftVHdLNHFRbYUmvTVSaYwbXtK8tdTQ3E7N0P98WEVO5F+2d
	xB3GTzJhrD6lMeyiTNyHVAMMROAPUbrPt4jvHM0rRiwD24R7bgS8OAMZmfXVVRMt
	AsSTDA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47t83u4mh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 10:55:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23689228a7fso29195015ad.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 03:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752231314; x=1752836114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBto8+nkBzC3SIB5+AQtnfGYPNuUEuMvL0M4sbENf7M=;
        b=d2NJf/g3ZOmt5puBRXPunWekoLquoccXYdvfbrD9kib1xhqyZ9tLFXYg3hi4PhIhM0
         uDwAfOpgifpRc2v5zDQE4Wegw/pebwJtjuRHj/Tuolx1vx8UAxMVSLq4gNpf7pguhzFg
         6bqK7IqvzAGcbxX8ieY9q0m7PcK2DFX3wvealEp6lbeYu82R2UQgoJYQhI2qCfKjiGN4
         uHsfyc56oqpM+AHUbnTEWlPMkZgbWE5aP+3d3kM8j9Wtk/AAnnpj0rB9AL0Mli6T0zGb
         dfitZ7YKEOPLAvjetaZbjpeCQf+ZG6v9OvQ9A2LovA5YnTR/qUOJoUkMQMFIx9IfCuQy
         pRzA==
X-Forwarded-Encrypted: i=1; AJvYcCXsSvIqRZ/tqjDM3PQfU2pQxtilJ/M87OGh5E34J9/n5+Hfj0NvlUhSIWqYoTxI+rssLFBWMWCxY1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx79/M/L1+8oM1gG+2yGGRqAuad0w+I5M7FINYNIIbjUvDseNdT
	PuloNYSvVjoEQfhNe+Kni0Vaa/ue23JFHvxZ5nW00rK4Kyp5MBo3oQfFEfBwenCImthi7zeuu6h
	LfgIrnViXcgIGH6X/t8SU0+fDZ1AsozzF9PczJWJsKV0LSZLE1PnYjeOryLBA5hY=
X-Gm-Gg: ASbGncutIUBU2kWFEZRDb+D9a5ctGswxmnqh7/s9vY+0lV+ZkrPxyxxeYLJlfx02YDZ
	ioQmp4HH5OM6+/T//Z3Co9wf8i9N7ZVsdkS6i7UCOI+x782gqUIjN+VvyeZlOBFq/0aLVgG74E2
	gfrBxGEvLYQpjvTiNtLPaKDHss/bY766KPqYdv3OJlVmJQMQez5hkJYRdVw7Z3ENkffhn9j+8SH
	y0F/7NSHP0EXdFSmkbHELZGSTextgeq2LKdUHkNOBgOJDfu0oEJCU68KHEQBasiGvJx7P88pV4U
	eXhfS6YHHyX885hBil/3Kxk9Wu18kk9EWZk+BKKYYSD1TWlvF7OJWziK7i67KqLAvezH
X-Received: by 2002:a17:903:19cb:b0:23d:da20:1685 with SMTP id d9443c01a7336-23dede2d1fbmr41332525ad.4.1752231314422;
        Fri, 11 Jul 2025 03:55:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO7zVGoYd5Gn585ClIUPh1ymONaAtRPnkgGM+Z60hbp5/SJEPrqzqHuoCurum2APuuK+XViA==
X-Received: by 2002:a17:903:19cb:b0:23d:da20:1685 with SMTP id d9443c01a7336-23dede2d1fbmr41332125ad.4.1752231313936;
        Fri, 11 Jul 2025 03:55:13 -0700 (PDT)
Received: from [10.92.212.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aef8fsm50345125ad.76.2025.07.11.03.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 03:55:13 -0700 (PDT)
Message-ID: <35f057fd-9aa0-4de1-a6cc-0d17ffb99e23@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 16:25:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-6-3faa8fe92b05@qti.qualcomm.com>
 <qo6mb3qlt3xpuvhepwcv6be4wd53neee2t6buzk4tdiy22xsub@vu7lykp3rnu2>
 <226bab3a-54e5-94ad-9d84-0b82f9dc4e2f@linux.intel.com>
 <2a18cf9e-1dd2-4e09-81f4-eb1d07324c8e@oss.qualcomm.com>
 <irnkdlrmlozp7joydgnawfuivl2nnuxsb2t4osgxzbtyrfzd3n@7dhzjcd42aiw>
 <c7d4288d-4d0e-a3c2-83d2-c3f1b282d4ac@linux.intel.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <c7d4288d-4d0e-a3c2-83d2-c3f1b282d4ac@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ndggj256xYzQPKj6LuNXd0YVNW2eG-ID
X-Authority-Analysis: v=2.4 cv=OotPyz/t c=1 sm=1 tr=0 ts=6870ed9a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=9wcXyvJq732FR575IagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3NyBTYWx0ZWRfX02qAWhRkHkMX
 TX43Ouzji1xgITzfAPJqxBJC1AousrT5/6S4Av8A5te27cLOOYMkp/xGuFxG1E4ZCjtL+3kqeJS
 Ds/IOFBjiacsv/ElgXyL7B+aKm0I3+TQHzusVBC9vpc3T3olHwMwsjaagaU1Fq3shF7An2EGdlF
 wX1adqPzhaCtL7GdMYqdEXb4LlwF/0hyv1GEe+JvX4rJ4yvlOYFRW3+Lkx9anDVVkQctd+pb2Th
 t0W27y+k8/3XPkpw1AxHFGprKcXWVsCs9K8vmJB+PG0S4hqIxiqLLZyizyxz2MSMYS4BbYEtMEw
 FcelsG46VYvZEdJyArYb81ZKNq4/Du7mjMPf7MZkY4C9fpz7DK6qZRZZ+hSXW/LwTtgr+U2pMJn
 Am5Ze32JBXPVc7M5+HoFqAOy4NH7k1WDXnkZcyBQKCbU1JlZSj1HBoC0yf85ldNWJ6gBPmyJ
X-Proofpoint-GUID: ndggj256xYzQPKj6LuNXd0YVNW2eG-ID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110077



On 7/11/2025 2:51 PM, Ilpo Järvinen wrote:
> On Fri, 11 Jul 2025, Manivannan Sadhasivam wrote:
> 
>> On Wed, Jul 09, 2025 at 06:01:22PM GMT, Krishna Chaitanya Chundru wrote:
>>>
>>>
>>> On 7/9/2025 2:40 PM, Ilpo Järvinen wrote:
>>>> On Tue, 8 Jul 2025, Manivannan Sadhasivam wrote:
>>>>
>>>>> On Mon, Jun 09, 2025 at 04:21:27PM GMT, Krishna Chaitanya Chundru wrote:
>>>>>> ASPM states are not being enabled back with pci_enable_link_state() when
>>>>>> they are disabled by pci_disable_link_state(). This is because of the
>>>>>> aspm_disable flag is not getting cleared in pci_enable_link_state(), this
>>>>>> flag is being properly cleared when ASPM is controlled by sysfs.
>>>>>>
>>>>>
>>>>> A comment in pcie_config_aspm_link() says:
>>>>>
>>>>>    /* Enable only the states that were not explicitly disabled */
>>>>>
>>>>> But the function is called from both aspm_attr_store_common() and
>>>>> __pci_enable_link_state(). So I don't know if this is behavior is intentional
>>>>> or wrong.
>>>>
>>>> Hi,
>>>>
>>>> I think it's intentional. Whether the behavior is useful is another good
>>>> question but the current behavior aligns with the explanation in the
>>>> comment.
>>>>
>>>> My understanding of the situation is:
>>>>
>>>> pci_disable_link_state() and pci_enable_link_state() are not symmetric
>>>> despite the names, never have been (this is one of those many quirks ASPM
>>>> driver has which should be eventually cleaned up, IMO).
>>>>
>>>> It might be appropriate to rename pci_enable_link_state() to
>>>> pci_set_default_link_state() to match the name to its functionality (and
>>>> the function comment):
>>>>
>>>>    * pci_enable_link_state - Clear and set the default device link state
>>>>
>>>> Note: "the default ... link state".
>>>>
>>>>
>>>> I've already raised this concern earlier! As you see, my comment are
>>>> not getting addressed. I'd like to see the author does one of these:
>>>
>>> I replied to your comment on v3 patch[1], and I feel instead of having
>>> new function() we can use same API to our purpose.
> 
> It's not about what "feels" something. One should clearly write down why
> such conversion is correct/acceptable when it comes to existing callers
> if changing an existing API. The note should be such that it remains a
> permanent record for future (in the changelog).
> 
> I don't have answer to what are the expectations or intent of the existing
> callers. Convincing a patch is fine is responsibility of the one who is
> submitting the patch, not reviewer's.
> 
> Unfortunately, it is usually quite hard to figure out for existing drivers
> we're not familiar with. I'm not saying your "feel" is necessarily wrong,
> but the existing callers need to be properly investigated if you choose
> that path, not just handwaved over. It likely boils down if the
> ->aspm_default and controlling it are useful features to have in the ASPM
> driver as your patch would take away that ability.
> 
>> You replied to Ilpo, but never got an agreement. Please try to close the
>> discussions before posting next rev. If reviewers forgot to reply to your query,
>> feel free to ping them in the same thread itself.
>>
>>>> 1) Renames pci_enable_link_state() to pci_set_default_link_state()
>>>>
>>>> 1b) If pci_enable_link_state() is still needed after that, a new function
>>>> is added to symmetrically pair with pci_disable_link_state().
>>>>
>>>> or alternatively,
>>>>
>>>> 2) Changelog justifies very clearly why this change is okay with the
>>>> existing callers. (And obviously the function comment should be altered to
>>>> match the functionality in that case too).
>>>>
>>>> If approach 2 is chosen, it should be very carefully reviewed when it
>>>> comes to the callers.
>>>>
>>> I am in favor of approach 2 which you suggested, but lets wait for other
>>> reviewers feedback on this. Based up on the response i will make
>>> necessary changes in v5.
>>>
>>
>> I would go for (1). It is always going to be a problem to change a legacy API
>> like this. We might end up causing regressions. So it is safe to rename to
>> reflect the purpose and try to come up with a new API that does what you want.
>> If callers want to migrate to the new API, they can also do it in the future.
> 
> That's my recommendation as well.
I will take this as learning, we will go with approach (1) as both of
you are having valid points.

llpo,
In the previous patch you said you have some patches on can you send me
those or shall I proceed with patches from myside.

- Krishna Chaitanya.
> 

