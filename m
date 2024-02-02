Return-Path: <linux-pci+bounces-2974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C835084671E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 05:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA5B28FC0C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 04:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E4CF51D;
	Fri,  2 Feb 2024 04:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CTzz14Q+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8AF513;
	Fri,  2 Feb 2024 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706849517; cv=none; b=L9vP0whoB7r5Sn3ZoTctwfJWYmzOwrxpEn0s2CotvXg/o9lojzoKACHcTniM2VE/eqqFisEY/Mk4vaJjB8HRv1EMvw7AGALRHFBvyWFHp89NSGiZbnZDZR7JfmuMVHDJwqFtepXQGetWXhY8bmR72xoSgbYWGdMIiYdL6GwUpcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706849517; c=relaxed/simple;
	bh=MbeoFB9DxXuqtKa3HpPQkLWrTH55Z9XH6TqSAg7KCo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RNal+VaMaWuUDCyZY4n27ZE6LjZfmcBTJfGNcEkl9EberK92Gj6jb5g1ww19nFaInikw/ok1gYswdN+/Xk8PAJtHQIQsFDXDa4wXQ55iFlgS/FRNH/6lXnrBZST74XAEh5ag7oQ4IglYKjj+87KWBsfQDR8oGmQ4tue+HHbF+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CTzz14Q+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4123mJnQ012457;
	Fri, 2 Feb 2024 04:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Kr40Gu7ZnkwDYNF2wB6/kUvqE4WqqMaeLDAq4SXbIiY=; b=CT
	zz14Q+FsuEExXaXXl6pAjGMcYGU6ghZfwZWctR/EzKog6HJUfL6ZbSmpMLEtHiY6
	ne/l//pIfsWgxRtEf8cv5dBxaJUcaSGRiLwBMBRXzWbAs9FhqCYX9CfJ0pER0yEh
	sw3FD9bWifV3RyqUl+nf4Vwnh6Bx+1CNX0sVBr6yyN7UPWUUVSVF5TNX7qQUgydV
	mAU3qHypyjbOYpz2a5qvij6/pUqLO+6imVQRN1/Jgyi7byFDl5Ub5+t0CsDXtASC
	VG1IxTIMV86pJ319Hz81cjXQREGWDRcUWwWk4pOOILO5SKY/G469XpaD/Wucr37Q
	urXXP0pBWX0AanFGQ8eA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptvgd4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 04:51:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4124p2Yf007983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 04:51:02 GMT
Received: from [10.110.16.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 20:51:00 -0800
Message-ID: <39779388-9aad-43fd-9ede-271ead40cbf7@quicinc.com>
Date: Thu, 1 Feb 2024 20:50:59 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] PCI: create platform devices for child OF nodes of
 the port node
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo
	<kvalo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jernej Skrabec
	<jernej.skrabec@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Linus
 Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?=
	<nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peng
 Fan <peng.fan@nxp.com>, Robert Richter <rrichter@amd.com>,
        Dan Williams
	<dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Terry Bowman <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>,
        Huacai
 Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>,
        Srini Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
References: <20240117160748.37682-1-brgl@bgdev.pl>
 <20240117160748.37682-5-brgl@bgdev.pl>
 <2024011707-alibi-pregnancy-a64b@gregkh>
 <CAMRc=Mef7wxRccnfQ=EDLckpb1YN4DNLoC=AYL8v1LLJ=uFH2Q@mail.gmail.com>
 <2024011836-wok-treadmill-c517@gregkh>
 <d2he3ufg6m46zos4swww4t3peyq55blxhirsx37ou37rwqxmz2@5khumvic62je>
 <CAMRc=MeXJjpJhDjyn_P-SGo4rDnEuT9kGN5jAbRcuM_c7_aDzQ@mail.gmail.com>
 <oiwvcvu6wdmpvhss3t7uaqkl5q73mki5pz6liuv66bap4dr2mp@jtjjwzlvt6za>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <oiwvcvu6wdmpvhss3t7uaqkl5q73mki5pz6liuv66bap4dr2mp@jtjjwzlvt6za>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lTFaTi9YnTkmqQ4bQa9bhYouASZn-t3K
X-Proofpoint-ORIG-GUID: lTFaTi9YnTkmqQ4bQa9bhYouASZn-t3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020032

On 2/1/2024 4:03 PM, Bjorn Andersson wrote:
> On Wed, Jan 31, 2024 at 12:04:14PM +0100, Bartosz Golaszewski wrote:
>> On Tue, Jan 30, 2024 at 10:54 PM Bjorn Andersson <andersson@kernel.org> wrote:
>>>
>>> On Thu, Jan 18, 2024 at 12:15:27PM +0100, Greg Kroah-Hartman wrote:
>>>> On Thu, Jan 18, 2024 at 11:58:50AM +0100, Bartosz Golaszewski wrote:
>>>>> On Wed, Jan 17, 2024 at 5:45 PM Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>
>>>>>> On Wed, Jan 17, 2024 at 05:07:43PM +0100, Bartosz Golaszewski wrote:
>>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>
>>>>>>> In order to introduce PCI power-sequencing, we need to create platform
>>>>>>> devices for child nodes of the port node.
>>>>>>
>>>>>> Ick, why a platform device?  What is the parent of this device, a PCI
>>>>>> device?  If so, then this can't be a platform device, as that's not what
>>>>>> it is, it's something else so make it a device of that type,.
>>>>>>
>>>>>
>>>>> Greg,
>>>>>
>>>>> This is literally what we agreed on at LPC. In fact: during one of the
>>>>> hall track discussions I said that you typically NAK any attempts at
>>>>> using the platform bus for "fake" devices but you responded that this
>>>>> is what the USB on-board HUB does and while it's not pretty, this is
>>>>> what we need to do.
>>>>
>>>> Ah, you need to remind me of these things, this changelog was pretty
>>>> sparse :)
>>>>
>>>
>>> I believe I missed this part of the discussion, why does this need to be
>>> a platform_device? What does the platform_bus bring that can't be
>>> provided by some other bus?
>>>
>>
>> Does it need to be a platform_device? No, of course not. Does it make
>> sense for it to be one? Yes, for two reasons:
>>
>> 1. The ATH11K WLAN module is represented on the device tree like a
>> platform device, we know it's always there and it consumes regulators
>> from another platform device. The fact it uses PCIe doesn't change the
>> fact that it is logically a platform device.
> 
> Are you referring to the ath11k SNOC (firmware running on co-processor
> in the SoC) variant?
> 
> Afaict the PCIe-attached ath11k is not represented as a platform_device
> in DeviceTree.

Are you considering out-of-tree drivers? My understanding is that there
are different PCIe modules, ones that don't have GPIO-control for x86
and ones that do have GPIO-control for ARM. The out-of-tree cnss
platform driver used for Android has a large amount of DT control
<https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/platform/-/blob/wlan-platform.lnx.1.0.r1-rel/cnss2/power.c?ref_type=heads>

(not sure off hand where the DT files themselves are)

/jeff

