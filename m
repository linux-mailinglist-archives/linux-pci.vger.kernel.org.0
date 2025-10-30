Return-Path: <linux-pci+bounces-39750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59767C1E3AA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 04:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3B6734ABC9
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 03:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C703A2D321A;
	Thu, 30 Oct 2025 03:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ff7b/zPO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="am4a+kn9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090E1E86E
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 03:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795823; cv=none; b=JOVylhIpRZcF3JtjjzBn0UZP2dhrwax81DHhkmjsc14py33L1OfLHMKzGNhJmwT9ae9mNsjEvHeNcbuxlfiNLVi130rv5s5aAcpU3jB5ENZgsqWtS45EUgP3+vosL95OwfG0lPFYkSvBteiHDuP7ejwLKsXZlrnrSWyNbgh7Vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795823; c=relaxed/simple;
	bh=syWr0hrchEYBIUz0nvESOsKkTCKM8MAjLs9LG9A2Ri0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Duhs7STa4tAsZAz3gNVeWKuERoyO2CU8sfIWSITnYLrVTFzFWPohtxv/HpTuOU0eMOJ5VG7eV9khXbxVO2bl7fLpM2Qn1kvmdCxz1CK6NQ9Mml3K7JKWsaR94JYB4XPvC4S3OLNEBdgnRerNmgg2Ylfi8Uj+6Xg8P18qat1l+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ff7b/zPO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=am4a+kn9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TM2qiv1699869
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 03:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sHSWFWmnOzX1VHAiA276NE1gVjUwB6rf3KGgQY67Spo=; b=Ff7b/zPO8tvJceRY
	Cy74AMHIYHiNdUVuJcP4f/lSQDyMMcebAS0DE7AeVm+xAKnTzShtg34YkxNy/wdt
	0g/NgpqpoAnJcIwT+n9clchm94r9tbrElusIK7GlLiRc2pz1AFcKCCUJFZpQCbHb
	e2XH92o1WH8HIESZAW0yg4FczD58ri60/EcSr39tD7F2kPSrT5vBlNVHNi37cCeE
	s75H5V6v6imgELujCXf9R4NerDgKzEjBRpO/HBLA7QXsuw075f/x6sEFhGWdAZcV
	aTVcBDFbMl/YzO6id4gLeaZXeFKzfoEj8DDXlNudFrRmuwCUptl38Lt66V1h83z9
	QLLDUw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ucj8sj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 03:43:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290e4fade70so5180605ad.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 20:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761795820; x=1762400620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHSWFWmnOzX1VHAiA276NE1gVjUwB6rf3KGgQY67Spo=;
        b=am4a+kn9pM3fQ7lSfl9eDgL7UcHRBU0k8iuEBI9mSGpI6iIG0IxuzNzxGrQYsRY8ow
         +8ZF6Bb3HSbqBjzFzTPcqJH1eY8VYXXVa8WwELqg/yr7ul71zsbsKjHNRgBvsXCFVYQ3
         2e5L6BTzVobh/aqOtcOG77OH7Zvp83U2f/QvPs373V2aINt0U/MIbhlOp6b3IBQ73WaC
         y5s506DuIJDJrt+uOJPI66VPSb4+sU65XdqqqDeOho4skt/MNzBijB9WF14GlvH/OXFB
         GjOL5sKWZwcwvvyqOihTezNqPjWYTlimnEndhR6U0t2d6S2mrBjyQSy+kXRo1pEc4my2
         frcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761795820; x=1762400620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHSWFWmnOzX1VHAiA276NE1gVjUwB6rf3KGgQY67Spo=;
        b=pdLg1c7FgSBeqyoCUYHyFa662TJn3s5TJ8qwlAKs4huIPQ0jcWMNDVI4GTUgn/ySUB
         vlG2jDZik/p+l8WOd1lTOuBJQzqIjBWoqV5G5hRGo6KbyvafmW9ELMkFxtEnzIG4mZ7m
         ZnfYfVskbc56EnK7fQDz6dikRU3oCrJ2v4xhhUqjk9vU4vNyvRvlV1ppEVjfZdqcPHGi
         mmhh2+7ClZHHJLoR2+NI3wOjnMSJZvV9vXNsi8QK3BDvL/87jJ6tsoN0cGxaIweZGd1Z
         bJZuf8lWCqxjSw9BQnvNRrz9w2a4GN4LKxJtpp9CKIhnfKCc85eZ9LDpvcrWRCQobl0w
         GoXA==
X-Forwarded-Encrypted: i=1; AJvYcCVemZNcw/jWdGoxCfRfD9n3ul7AWJJnuYQLfY1wzqhfg2nQttcE6jDUPzJHqva9sZovja0Pe7oSykA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcFknPEpQS2cWtJ7c9MZL+jpSoXneU4MkaMKYMrro4UL4jx2vF
	/yavP685hkTkNOVfkf7qetvVjOMMvIMuKWu2d35gDc3dvy7RKjAjWT1wtKHZ6t7ECeZdRNqLiWF
	fMPDZu26oGuf4MGWvtC2Z+4aGj/K2ieclar34XeI7Nbsu7hQ55Y2efg9lFA56zKk=
X-Gm-Gg: ASbGncsY76FhGY7Ml9Mp3Ec5nH/+mZU3Xb6r1XYVLaLpAD5n7OAf8I4+kUbQnY3CBue
	OcF1VqP53YSDXjSILv7AvKORRBQ9YRuN+myo99G2n1E5m8nxFPriL9G89zbr4nv72ogYl0EcdsF
	OYs86K95VvoFdQkGTCUyVy/VYPc1Sxl3fKXXMG34W8qtz0DPUqreZ+w2a1PwrAqq6+E6Y4OQj3x
	yISiws/FLNrWJ18mzLj6lBv6i0Yz/SrmX7sdoDPtcmlIqzW4wvwSWETmDQhEd9JDT6gweRmoDEU
	1H3TER3kjEBZ8jt3SerY0FU+Ky18KGl6b1NGcX9qzD0L+I0BuEkwJoXYZlCVR11D5d/kRG/5LHv
	Dtp5S8J+dEcwhCbIwnDHVBYxLVp8P6Ak=
X-Received: by 2002:a17:902:d487:b0:290:c07f:e8ee with SMTP id d9443c01a7336-294deee23a3mr66507285ad.43.1761795820112;
        Wed, 29 Oct 2025 20:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG8Tsm7zsMNvRb42NpHg0S5cqbhX8hvTZ+lzZFtUmt1DssbzW9YgQ30jiCbWgwAcLvsjL2Pw==
X-Received: by 2002:a17:902:d487:b0:290:c07f:e8ee with SMTP id d9443c01a7336-294deee23a3mr66506845ad.43.1761795819628;
        Wed, 29 Oct 2025 20:43:39 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2333fsm166960675ad.50.2025.10.29.20.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 20:43:39 -0700 (PDT)
Message-ID: <3dccca2d-272f-451a-9e38-901a6fa3a24c@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 09:13:29 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] PCI: Enable Power and configure the TC9563 PCIe
 switch
To: Bjorn Helgaas <helgaas@kernel.org>
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
        Will Deacon <will@kernel.org>, amitk@kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251029232323.GA1602660@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251029232323.GA1602660@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAyNyBTYWx0ZWRfXxqdg7QMDZ1bC
 SFtEbf7OjYev2gTAy0Y09qDJBDjX1DJJijxKB/H3ImPu+buem0ECYM0gqdiIyYxA+l6pZRE2jqm
 xq/hUqVnqBl52RNzfZuZrzS1if7i8DHKg5FrUcLlbAFip8ZrBMM+1VkN/q8waiLQoCPk2rIlnA8
 Fc9QGnd9p5IesK2D001jCDCoEY4oC7LVAwF/UMsjnY1MWP1vZA4RAxe0Z4rkppmai1FK9sgdQqu
 TbT3B5M2LvZ2SX+p7o7XGjKNlbRN5Jk4cocE3AbKkhYqq4Z2tBL5rWD+Ffbobid14PSgrTs4+Tl
 j3Tl/x8nMGB1UxoH0CdEp8F3r+BHZbBhF1ENeMnKRaG2RZn4gZ4U5EKuKib1792CI10SnjBaRQw
 0lLxZ0VMTYSpzVh8MDlHye7zBA9VVg==
X-Proofpoint-ORIG-GUID: CmbDytuL3Sg2kBTdBH-Jh1FJlKtBMqmq
X-Authority-Analysis: v=2.4 cv=V+RwEOni c=1 sm=1 tr=0 ts=6902deed cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=FxhApbZLZ_QfhaJha3gA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: CmbDytuL3Sg2kBTdBH-Jh1FJlKtBMqmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300027


On 10/30/2025 4:53 AM, Bjorn Helgaas wrote:
> On Wed, Oct 29, 2025 at 04:59:53PM +0530, Krishna Chaitanya Chundru wrote:
>> TC9563 is the PCIe switch which has one upstream and three downstream
>> ports. To one of the downstream ports ethernet MAC is connected as endpoint
>> device. Other two downstream ports are supposed to connect to external
>> device. One Host can connect to TC956x by upstream port.
>>
>> TC9563 switch power is controlled by the GPIO's. After powering on
>> the switch will immediately participate in the link training. if the
>> host is also ready by that time PCIe link will established.
>>
>> The TC9563 needs to configured certain parameters like de-emphasis,
>> disable unused port etc before link is established.
>>
>> As the controller starts link training before the probe of pwrctl driver,
>> the PCIe link may come up as soon as we power on the switch. Due to this
>> configuring the switch itself through i2c will not have any effect as
>> this configuration needs to done before link training. To avoid this
>> introduce two functions in pci_ops to start_link() & stop_link() which
>> will disable the link training if the PCIe link is not up yet.
>>
>> This series depends on the https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/
> What does this series apply to?  It doesn't apply cleanly to v6.18-rc1
> (the normal base for topic branches) or v6.18-rc3 or pci/next.
I sent this on top of rc3 as we have some dependencies with latest 
changes i.e ecam changes in dwc driver.
> I tried first applying the patches from
> https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/,
> but those don't apply to -rc1 or -rc3 either.

This needs to be applied on the dts schema in github, it is already 
applied I will remove this reference in next
series.

- Krishna Chaitanya.

>
> Bjorn

