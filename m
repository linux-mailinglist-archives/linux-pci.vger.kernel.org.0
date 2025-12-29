Return-Path: <linux-pci+bounces-43804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A84C3CE6F79
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 15:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D46B43005189
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 14:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1CB1397;
	Mon, 29 Dec 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CY5z40tE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aE+oredO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DB4137750
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016918; cv=none; b=mYIKusKtloO5tjMVcTCLB11KshA4Op5feQPYqw2cj6fFxcmdsaKTYukLvKDHWZqmI83vjmgMclOatCfdnD+uDM7AiCJZhYMI7oSHEx02Y9+dxDpybu6PH3uHmi7G989dog+10fkJ9zpidpSq1pOkicR8ig5v9lTE6cg1q87L8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016918; c=relaxed/simple;
	bh=Vky3XCQrDM6vV+npv9sywksgy0jxftnVHm+HxyMUORg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GfIf8ibLzuRphEFrrcPTiap+bHRwZ12Q6DoDL/0DIFwu5324/ayvUf6VstamfbZ4m6JO6ZvAAOE6XOmnaoEaEKOKtThPX1hFQL654CqdlOUbM0AkKEZ9Hc6UzftdGr0sACfEkhXP+LrGaZ3jtltq9q54gs0/cWfSFE7G09cjFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CY5z40tE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aE+oredO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT9vIvK1348132
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 14:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X04kRLfSlj6sD02s+XiExWmGb6e4Bxh3i/MAC3s9w10=; b=CY5z40tEkSypewRO
	DBxsDC93Rfvg7hnlJk5MLRElwbDBYxR4Aftucg1a7fiEZZpj/y2m3g1hgNnsajey
	C8N5AdUNq+XbaVBFC+8dl2L9wMZb9M1J/9R2galmMpZ4sVJceZQB7+pCM+GAJjbO
	SJ1jrFvKap/jUx3kVSp8MVfcPyK2kXDTD5DVHrKfDEDyycsXJZ6FQIeeljmyx1zW
	rm8w2jbjKyjprwZiUAV14aCaaY0pSQTxdvOpU9q2/Ep3vMziO0MeNYVMHN2bR6++
	eqoMNl2OCPR5vZyqa5POVkcMeazcT+2tDfV5JHV9EQXIkd4DtELwk2JbaTopJHl+
	vb2xzA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bavrj2xhx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 14:01:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b4933bc4aeso8910047b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Dec 2025 06:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767016915; x=1767621715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X04kRLfSlj6sD02s+XiExWmGb6e4Bxh3i/MAC3s9w10=;
        b=aE+oredOxn8nxeZMwMNpv8i4z3Ze5aGfxbc8fT3vcFtZJvWwWsWA0EX0Ts8OxjKZ+A
         p67Cnt7C7DqphvRPXHy3IXVeUIS6O7N6IXg0pU/LX34ByIMpt4UKHpJhu43j/836edtr
         TevtvEsmt9FdZO4ZelQa25Ff0yAIj4xmfVdtt8widHZ4JxMKb5uHAmsI4lvdpdT8Z7ob
         90MpGsYFIqqWk7Ur4x2DwfsXuKJCJk4Y8tmo5/dI10W95iuDy/8/GpA/gl1c9l/lyvmB
         hKmXXO5IqOVmPzfQ5xyrGXRgns70DmegEZ7l1nCkKuNuGWmT5dFyeraz1AJwwoAzR+FT
         1zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767016915; x=1767621715;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X04kRLfSlj6sD02s+XiExWmGb6e4Bxh3i/MAC3s9w10=;
        b=FYZIHLyEt6j+zGTZO5EO+NzoYaxTwSkm9KRdNXkEucN6hjPZAqWuCzjmQiJAziU0J+
         af0Eg+noEnvGg6m7pIa7TZHmypccSIJu0dvv1qgaIKMWW6FYNaVPgvmL5rjn1YKRSw0K
         BotcGaLy8YSS7NDlxbsHE6tX5tlo6GpGU8ktQjq6GcshxFiqBb2emlWOr/BafU4YIhoa
         hpxlifs10fOGiumHCwnXxl8dLue5D2xCzNniXyAmaJYmtDd0AfiWXj7Ct0WkbQ7cQ//t
         BNCAuli07OE2wUkWuBNAWOsU0JG1umkCXdvED3ZL2ln4kwe5f+DqYMLXIlXKeGaOKvwO
         OzlA==
X-Gm-Message-State: AOJu0YxeAB8eofP3NcdutS6iZ02KtyLdSqFaOYY+svQM7ojYW5GMhtsb
	Ylpp6BQutYTzaVyXqGFBb59v9VjloqdQ5usvrH4zTXdf4/dcPkQYxXjXPBsTVNThn6a4GnWEA9l
	FcKF6Fae8xu0ebuZod9zV5Sprjct4yWiZRPt01+h+D4uc4TtxxWR28Pn3Efykeu8=
X-Gm-Gg: AY/fxX5HX2pJFqoFXGwQPlYV56YkPadCBFSb9KZCei0MWmjmicKPjHVQpuyypd6cAoD
	QR1Sk84WOszpwJtddDatayDEUCML1ALYgu144VY8mAFRidQU/TlVOqZAq5ym1aAGK7p7PasUxn9
	+/BeFfzfgPAZTXIjaCiqKjnGE6qUjss8MIt2oGajqzZmETldB1zgQRItvhRIv5lkOiDTo+YIKyA
	RfvvkUqHKx583Z0ZP2gYMzVSwTIZgGv8fceCbMY6Ew5hrqgfLc/IqYHQ10H+KEhzRKpYRXA3N1W
	if1GIkJYq8mLi1Qw52gPP3dtyCjeadwP0pNfClSn2sBe/5oj49kB292EH0Oue7lxuGXgVd/Eye1
	S5wWJYfFzbw==
X-Received: by 2002:a05:6a00:742a:b0:7ff:ecbb:1c28 with SMTP id d2e1a72fcca58-7ffecbb1f34mr20146569b3a.16.1767016914665;
        Mon, 29 Dec 2025 06:01:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOPWCFO0bItBjjPbkKLz58fIEDs5xKRO2DT2/iQRyyouGPGOG9+Pz/xrqFakgkLJkcd/gKZA==
X-Received: by 2002:a05:6a00:742a:b0:7ff:ecbb:1c28 with SMTP id d2e1a72fcca58-7ffecbb1f34mr20146529b3a.16.1767016913970;
        Mon, 29 Dec 2025 06:01:53 -0800 (PST)
Received: from [192.168.1.102] ([120.56.203.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfabcbcsm29894236b3a.31.2025.12.29.06.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 06:01:52 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>,
        Will McVicker <willmcvicker@google.com>
In-Reply-To: <1766540332-24235-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766540332-24235-1-git-send-email-shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2] PCI: dwc: Use cfg0_base as iMSI-RX target address
 to support 32-bit MSI devices
Message-Id: <176701690925.96530.10471203793481823479.b4-ty@kernel.org>
Date: Mon, 29 Dec 2025 19:31:49 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: bu_q4XGlslYfSWY4WwKThQZ1Yal7lsVu
X-Proofpoint-GUID: bu_q4XGlslYfSWY4WwKThQZ1Yal7lsVu
X-Authority-Analysis: v=2.4 cv=coiWUl4i c=1 sm=1 tr=0 ts=695289d3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=yqfAiM0thzgeCUM/X8CCWQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=1Kt0cXbBT5kQnF2g-j8A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDEzMCBTYWx0ZWRfXyVFMVfmG9usU
 D+6NZ0/KMOMcsfi08GZlRzLl/FobRzgSNSHHBwOm0c0SbkBb6errJS8rYHwmMXRrX3Dt5Ay8EZg
 dKxA47x4Tk2stMSycX9U4Rl0ruEHtMw+AvQrJp/MNWuu0+4ofjkvQ35eq1EUDtc4c2kwxL5XML0
 qiX/CzVi6Bzwm0WamxSIwI7CsjkFuNgR15OgXKSH6cjDcvWOEFDs5NOhxuE2VFIeAJ8kPtW1BvO
 MCLJGTNURHQbWMCDBevtwGGtfQTon/WHhTiSVd+gAIaM4fJcUVxHXRjhkx82NsGiPNnlAKbmqfp
 4MdrqxixHq6jN9tCz6rvEK0d6d/xuv7qEcB/cl7E6HMwrxxdITCkw1fLrWkJy9vzqsNLoufWb61
 mx25wHNl1QkU06mJNxngcSkU9K8iLanU9Eu0OVt2F7RhGlVgXaStEOQB6n0cibLlG1k6AFUqd7c
 9zcSNHeMuzFkAiCAcjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_04,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290130


On Wed, 24 Dec 2025 09:38:52 +0800, Shawn Lin wrote:
> commit f3a296405b6e ("PCI: dwc: Strengthen the MSI address allocation logic")
> strengthened the iMSI-RX target address allocation logic to handle 64-bit
> addresses for platforms without 32-bit DMA addresses. However, it still left
> 32-bit MSI capable endpoints (EPs) non-functional on such platforms.
> 
> Per DWC databook r5.10a, section 3.8.2.2, it states:
> "The iMSI-RX is programmed with an address (MSI_CTRL_ADDR_OFF and
> MSI_CTRL_UPPER_ADDR_OFF) that is used as the system MSI address. When an
> inbound MWr request is passed to the AXI bridge and matches this address
> as well as the conditions specified for an MSI memory write request, an
> MSI interrupt is detected. When this MWr is about to be driven onto the
> AXI bridge master interface1, it is dropped and never appears on the AXI
> bus."
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Use cfg0_base as iMSI-RX target address to support 32-bit MSI devices
      commit: 68ac85fb42cfeb081cf029acdd8aace55ed375a2

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


