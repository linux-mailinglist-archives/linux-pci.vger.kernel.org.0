Return-Path: <linux-pci+bounces-42817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 860C7CAEF00
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 06:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B9730393C6
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 05:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CDD26ED3E;
	Tue,  9 Dec 2025 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hiWMEyZa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bnn91Asm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94039259CBF
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765258048; cv=none; b=IVi99/96a52PMIXatV/eE2d7RNivtdrhGrixSz52xim6WldlL/vJW9fzwYp32P3X4g0mAYOBfeJ+Tz8cWiQ2BqFHo38T7H+s9bUBqyGi4n/e4qihhc6th4OphSE0CJFhHVxytTwqm4FsZ6q+tT9s1I5OiEeeq0dwBDm/nhQpX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765258048; c=relaxed/simple;
	bh=DnJomOWsH/A9+29OhJx1O4OlsjuyvkTziAeXXYA7uv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtYyyY0QYqJRQzDH28vRPUhqgJ4hBU1YlsjAX3gtdtPtASIn9VCepIT8C1ueHmZlwD8ha0B4dUS19HZvhl8KLf8Aw+w9duG6iG7uP1kEfDLfUsMhv4Xmvk+4fO+8BnQpRTS55MNo2cMFkgJh0xhyzoU3Qtvw99dfv+uES7i1LBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hiWMEyZa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bnn91Asm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8NWw7T2618397
	for <linux-pci@vger.kernel.org>; Tue, 9 Dec 2025 05:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IMCgIJGsE4vObHn0eT5NJVOvY+iZ8qd9njYcH5Sk0q4=; b=hiWMEyZamUrermsn
	ZkvUFMtcYyIz1JiDFfThKTyfU2Zv4qkKfnDLvxk8rS5dKDd7TzbWQ9wMGtTvx47u
	klblJA7Trk1xMirfXyJeIt+FlIrX6vDYDLQI2rUbppiNC7ey35PK6Az2h2/50k1x
	PTL9iAoW7raS/idnJm7x9qlQuDCvbM1/jPW8pgWoWOmMXJWo7SkLX88wM0WSqMkS
	l+zy6txIaxWV25r19n3Ryk7vLlF1Px/IKO4oM60XDLWLy5CYvFQ092K4jheSeT17
	UlYZmwfIyMl3OUkOTihpWK26akyJ30px2Rx/ZM4PBPlIyYGGT+NuIgnihaNJDWDA
	fH2WuA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ax76u1123-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 05:27:25 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7be94e1a073so9768941b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Dec 2025 21:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765258044; x=1765862844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMCgIJGsE4vObHn0eT5NJVOvY+iZ8qd9njYcH5Sk0q4=;
        b=bnn91AsmlKP7hmXhakLN3Cw2PNVHmqbFFmTwCrGBF7tJxF5VKZKIzCbWbyztI20/UT
         9dfmSLOU/JR5XhtNc8r3Cue7MYwHNAEzrzjYgSMCU/BGcviIwWRWuNsaEUSoa/au95vt
         DU9+l1w5701YGhfQgxyxJA063nVpV3RFdGldsvD4JyHdepnL5uEbgdnXLA6DjBlKXYjb
         /Smgzxtb58hbPGDMhf39uyQWk1Tg4Af2GXgm/v6QWZ4PMNwfr76QocsqRVt7bE8pb/wT
         aafD1koZNFRjQTR92tkfPOsuHG8bJyYzNb9YcQFprCXW6b7F80uA/bwg4Soy1FCzCLC8
         FrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765258044; x=1765862844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMCgIJGsE4vObHn0eT5NJVOvY+iZ8qd9njYcH5Sk0q4=;
        b=MnkeWswfYpGdRcXiyc6iQJf7FXRV3vv2CU+HsChWYGInOWehxbhe/mqm2OaYMmF+R4
         ej/l5AhGE4dWiRtyDWyVmcjpsbPu+im2LdaAVRLlkUO3mq6unFIDcPIlc7h7Yx9SDGT2
         NY33gEKE/aAHoVL9qsSJVM/Bs/iSeM4W17D7u9TWYQdb17nDv/Aqdbzhg3Z1ZGRzqT7O
         wuQDGm95ro0pkR4ikG3cM4UI/f7oejDMP+XQn6RXG2RCJw9ZR/jUJ5GIbFsEG2n/SUcd
         M4Of5fJ9UOzCw2cHgXQjXBNtsFmMgsDdXr2fOey7puq7BOkIwpfQgEu8lKDrmpBC5SHs
         wwOA==
X-Forwarded-Encrypted: i=1; AJvYcCX5KXpV0l9GRwq7iXIAg7JI0u+THRoqcYUIpLNbnoqMmgRGzUaSWXanOQHH16V9yXwjXKjAkrMfJwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIm8/CiDDhzEzJyNT7nE+qZkcogIgciDQX6ENcCco01K81/la9
	orDLIMEIivaOJ3szklmN14Izy2oqLI853KzXwE0MkQwhr8SicBWx1jW6zoJ++01/J5TYlMCfLRa
	MgFQmfx8BQ8WkECLGFjspuPXEybb65yCC58isiU1N5vNAJPOajlsmxWqPuE5wvO8=
X-Gm-Gg: ASbGncueurGfjP+dIthIBxr39lAD9xFxrq+mz2tagv3rv9K/f3taGT1n/ljbn9Z2QHX
	Oenizf8K8jAYXO+FBj3Hpw1Yrlmj7EPhLnl2b9l7wDc7EDsHiA90VqN1OElHUvUHidHEeekJYge
	MnsAJ7KPvhk81MuSEZeriaRbh+ho2MDHBodf7Y3G7PuGwm7mGg2uzsWG74uo4FVsQza0AlxoZTd
	aQj2IEg8WtMQ57arn1xNssuB+4GuOT8qpdkut+I4m1fRmAKNHfoSyKImZk6wFDTRcpFpdYSkAk9
	57fBkNgw//cqdFREdeDE+pwT6zvd4BLAGjLplF1bSdSIxmnJfIKTLeZ8viqTyCnw8bhAFuhnGJV
	fVhFKMXWgPKV4NVgDDFRNCP/3t8VSmevmKK9Q/rSrmA==
X-Received: by 2002:a05:6a00:2e14:b0:7e8:4398:b35c with SMTP id d2e1a72fcca58-7e8c54372eamr8721698b3a.47.1765258044190;
        Mon, 08 Dec 2025 21:27:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmSLsEWNV4wfPoZd1g+hDEGVfykeAdoNKus/hSUixAEIUH767tMdjHwQvMb9nzDHCd6MS5mg==
X-Received: by 2002:a05:6a00:2e14:b0:7e8:4398:b35c with SMTP id d2e1a72fcca58-7e8c54372eamr8721679b3a.47.1765258043686;
        Mon, 08 Dec 2025 21:27:23 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2a081587esm14616953b3a.27.2025.12.08.21.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 21:27:23 -0800 (PST)
Message-ID: <dad4957c-ca13-4742-b46d-03f0478911d5@oss.qualcomm.com>
Date: Tue, 9 Dec 2025 10:57:18 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: dwc: Make Link Up IRQ logic handle already
 powered on PCIe switches
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki <naoki@radxa.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20251201063634.4115762-2-cassel@kernel.org>
 <f1059d5d-3fa5-423a-8093-0e99b65d5f4c@oss.qualcomm.com>
 <aTev28wihes6iJqs@dhcp-10-89-81-223>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <aTev28wihes6iJqs@dhcp-10-89-81-223>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDAzOSBTYWx0ZWRfX0pSiT+JNGeAg
 aFfgiPMYBmoFVPGYhsG6mfHMtY3Oe4k6lnZcZQKpP8LpVyKSaZvPJ141wIoxUc2xMnuyIObU1bU
 pK6meD7fNHUH599NVssoXk65A4/TNe9oAEdRacWujltBkXAeeJVhHVvAtU4HTC78224hGYBOANh
 UaCp2YQwS+qE6kj/04J5DUdm1fid/C1yjpcKw7IaH40JSCIvUrx1yTT2M9mk0h9KpEHtV/+sgtJ
 MkGQXSGzwpz+1AWHSv1sORlL7LxV1t/QumAMrrKTN9L3k2K8IM0T42yvN9uQWsOmGr99Yw8GHXd
 RTDTTwo14e6iLnb/UKeKdHG5bTa9rAIE0K7AUhfIm1t3aQCywsnnYQ+ehOc/+ZVOdGfGKwrzLaU
 wTsHife904/R2n7FVFzgUKbPHaRHag==
X-Proofpoint-ORIG-GUID: ROO4UJLO4vbBRxGF47_X5JDg7YIU79CK
X-Authority-Analysis: v=2.4 cv=PYTyRyhd c=1 sm=1 tr=0 ts=6937b33d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Vr8HXvedtgjsJtqvvw0A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: ROO4UJLO4vbBRxGF47_X5JDg7YIU79CK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-08_07,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090039



On 12/9/2025 10:42 AM, Niklas Cassel wrote:
> Hello Krishna,
>
> Currently:
> For controllers with Link Up IRQ support, the pci_host_probe() call (which
> will perform PCI Configuration Space reads) is done without any of the
> delays mandated by the PCIe specification.
>
> This seems quite bad.
>
> A device might not be fully initialized during during the time of these
> PCI Configuration Space reads, but might still return some bogus values
> that are actually different from the Configuration Space reads if done
> after respecting the delays mandated by the PCIe specification.
>
> I think the options are:
> 1) Keep the pci_host_probe() call in dw_pcie_host_init() for controllers
>     with Link Up IRQ support, but make sure that we respect the delays also
>     in this case.
> or
> 2) Remove the pci_host_probe() call from dw_pcie_host_init(), and make sure
>     that pci_host_probe() is done by the first Link Up IRQ
>     (i.e. what this patch does).
>
>
> One big thing with using the Link Up IRQ is to not do any delay during PCIe
> controller driver's probe(), which reduces startup time, exactly as your
> commit message in commit 36971d6c5a9a ("PCI: qcom: Don't wait for link if
> we can detect Link Up") explains.
> Therefore, I don't think that 1) is a good solution, so that leaves us with
> 2).
>
>
> If pwrctrl drivers are created as part of the pci_host_probe() call,
> I think that perhaps an alternative would be to create an explict
> pwrctrl_init() function, and let the PCI controller drivers that actually
> use pwrctrl call that from their probe().
> (And just remove the same from pci_host_probe() ?)
>
> In fact, looking at your suggested patches (that hasn't landed yet):
> [PATCH 3/5] PCI/pwrctrl: Add APIs for explicitly creating and destroying pwrctrl devices
> [PATCH 5/5] PCI/pwrctrl: Switch to the new pwrctrl APIs
>
> https://lore.kernel.org/linux-pci/20251124-pci-pwrctrl-rework-v1-5-78a72627683d@oss.qualcomm.com/
> https://lore.kernel.org/linux-pci/20251124-pci-pwrctrl-rework-v1-3-78a72627683d@oss.qualcomm.com/
>
> Seem to do exactly that:
> Call pci_pwrctrl_create_devices() explicitly from the PCIe controller drivers
> directly, and removes the pci_pwrctrl_create_device() call from pci_host_probe().
>
> So I don't really understand your concern with this series, at least not if
> it goes on top of your series:
> https://lore.kernel.org/linux-pci/20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com/
Hi Niklas,

If this series goes on top of the our series i.e pwrctrl rework series, 
I don't have any concerns.
My only concern is link up IRQ never fires if this patch goes before series.

- Krishna Chaitanya.
>
>
> Kind regards,
> Niklas


