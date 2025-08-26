Return-Path: <linux-pci+bounces-34768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F83DB370AC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 18:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF461893547
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2F32D23A6;
	Tue, 26 Aug 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G58DRmbu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7862BE05E
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226443; cv=none; b=WeeuDz1rl2qQHFf4uiUTHF05T9U+8MxXoUzWmhwnPkzthw0bO/hARaEsQOrdc0+5w7YxY7u4ifG9GroU93Ahrp+61LPfCl+BcoQ+aIGZGx7fvu1g5ub7KVgbKkJfGlsQiJ37L0nG9ydBguXxyFtGUnmH/zx7E+0bCSi1Q7gbtGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226443; c=relaxed/simple;
	bh=J56EJimurRukl3HtUzV6/w+RvxdfQC5smmvRwJRThGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZ3H+T2wW42A1CyfPRDYALNCXRzcwuEjKB+t/IrF9SgOXdEv4GtXRsRz+uczuGUqhYiNoL7L8LbIFiZN8Q8QLNwUkKnHJJw3yBprygbtRjN2x35WCAQCLfW458E2MIkC1m4J3EVvDN2GCGOmt13CO45yMTM2YtoGHsZ+KhK5QhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G58DRmbu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QC4EJ6006105
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 16:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D8Cf1CJKboWxP5q6R9op8Umbt3K2i/Dw/P1MbHCzwOI=; b=G58DRmbuwEUS4o2h
	8tV3cbWxBlhGZysuRweeh60AncgOaM3rPSQVPCZoBEAdLGxK60cKoGCIOuJEcL7m
	Q9mNEve5xv+EfeCXpqc3lWz+dr/U9cV+wYYyO1mPltRPWf2NarpdBrziynk4lUsz
	NeFX+VrObpy/5frnVlzvuOKGstYpF33J3323wdw/xDs9NC6GxCFqOLKk3aG9gaF/
	vX/DA3S0beVvqKryKMVJ+L5EZe/2ZKps8tdsnIKx7+EwA68MhxdGvLDSWLRz3R6x
	YAiQoB857POlABA/DuetPtzzqDFQ7rzMPHPm2rA5kM1xdzqfeXjPaA/ca0Jx3Ly/
	ju7H9g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpev18s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 16:40:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-246164c4743so106317395ad.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 09:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226439; x=1756831239;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8Cf1CJKboWxP5q6R9op8Umbt3K2i/Dw/P1MbHCzwOI=;
        b=EM/sruHQ5d2srQXu93xdNEx2bdIfB7DMiN8lojWttSbZ96zLMuDPCwHRimlMtNXBRo
         vcrjXPN3MMike/13yaqAMPgLnl2qcwONBlkUSOWlEZ4T9fIIYyNl6XZ2BVR0NvFJWTIm
         kDR42fomW8qKzO9r+kd1RuDHtxXlu/BfncJHGiYo8qDFBKPGz2cimds2lQWb9hK7HjUJ
         yxAjsc9/VjFmiawMiQhEgEFM+5NCk99yObjwbo1Pjzwutb18Mm9xN2rn7zsPRlTgFV/H
         +KBw3EIg1VoFmX/uQc1KRWIXc/TTrTY7X4DbCruGizHmyJrGJoxgf+yMoupPMMxaGpKu
         87bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyqSAO+O2f3C/GRTzulAUqga2eWOGn35EuOWiQiVKA1Bsb3JlPV2KUOBpQELp72HR34InEMdV3le4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xc1Xf9PHwKyG7TKLzxyDzTOcV8b0EzZ/AVtN9ZzbzaaeK6Kw
	OvVc+S+vD3t8v831S9JZk2pKaxYYtY5xe4IY5G4nYnA+NA/FArJT8xPR9gcpIxk4p5Jf6EfFvUa
	2V+9Cw3b8JmLLuaHr7OglnIKT9yZZfyqlot+9YVAwYQl4/mXeVQhBfP4WwmTf10o=
X-Gm-Gg: ASbGncvmhDnKynPgX6gdBkRScHrKxepFIS/xW4ZXz7hUGKvYD9nAqyLmycCiAScMpES
	d5ERybjsxHiyyW+T4V+FkV8rV9rVraurApg5dliRHRxLFZ3D7c4SDaZk7zFBLCJzzrtaR1QNIA0
	qUtDVHOnyhchBqE7g0iwTYyI9J83P7j930lKZfiv1dpFi7xxpWm8GHPzygHb2/2/+rcvfM2MZ5P
	xhhqetc7ADbdaUMHGFtze87a2WIO70iKE6H5T+DKn86WYB6JjkH52XfGcbzj3vY1yFzgi3ndQyD
	4Hcq7SKcz8/vbruSIcbljS2lzVFq15r4TKOuHx9kWtoAyShGaxKqsiqCyhdb3NqFHs6ElecytRM
	Ejw+Ng/4Mbs1XemWhOMM=
X-Received: by 2002:a17:903:187:b0:235:ec11:f0ee with SMTP id d9443c01a7336-2462eded8bbmr208960525ad.14.1756226439410;
        Tue, 26 Aug 2025 09:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkvFu2SKqaYn2g8jSdQZR+kEMDsbfiuYDSgXyjcnbv8H+hGCJesN+r1R0F9BmVI7ktbx+DaA==
X-Received: by 2002:a17:903:187:b0:235:ec11:f0ee with SMTP id d9443c01a7336-2462eded8bbmr208960165ad.14.1756226438902;
        Tue, 26 Aug 2025 09:40:38 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668864a4fsm100775575ad.91.2025.08.26.09.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:40:38 -0700 (PDT)
Message-ID: <e4178055-f3a6-4cb3-8c86-731130c6f25a@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 09:40:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] wifi: ath12k: Use
 pci_{enable/disable}_link_state() APIs to enable/disable ASPM states
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org, ath10k@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
 <20250825-ath-aspm-fix-v2-6-61b2f2db7d89@oss.qualcomm.com>
 <2fab10a7-8758-4a5c-95ff-2bb9a6dea6bf@oss.qualcomm.com>
 <705a4fe5-658e-25ac-9e4d-6b8089abca46@linux.intel.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <705a4fe5-658e-25ac-9e4d-6b8089abca46@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iYXg9f_kmGOY32C_SiqWfFzBesL4_uVU
X-Proofpoint-ORIG-GUID: iYXg9f_kmGOY32C_SiqWfFzBesL4_uVU
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68ade388 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8JU3Fd4Pt_mHVKaqA_UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX+eBMN8JcnvMS
 n54v3xKTRXPVZ2RoA3EjBRJaJhg8CsMDbLeWfJkLHgx9oISJfVQGp90V+GEuQviszMGm7zpk5x/
 qO3g6abzN3rdpTHnbyxgtrV5cX3CdO+Pxoa8chBPxcZuuNZCzBTSLhOzIHQ+z2EqEqTLBswOsg+
 M3fbA4JcEoiFa7ZuR1bMNG9VivTZuEAClbRODYUZlXleX+JJ4W7LdlW89HC38LJGNEWt89UKICs
 t5Ql4brDLKHCzvu0uVUzOdYwXrKS5U59xHFavOvuEQzzjT/IVPHshYhjo9R+VE8/pyC5LnL7WMg
 jSYiJDC/4xIFXsF50mUGlQumMOg92k6Ph2f+/deh+E2NvJFb39dCPw28oR44yuc9Ov2Cx9vets9
 aJrQa+NE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

On 8/26/2025 9:00 AM, Ilpo Järvinen wrote:
> On Tue, 26 Aug 2025, Jeff Johnson wrote:
> 
>> On 8/25/2025 10:44 AM, Manivannan Sadhasivam via B4 Relay wrote:
>>> --- a/drivers/net/wireless/ath/ath12k/Kconfig
>>> +++ b/drivers/net/wireless/ath/ath12k/Kconfig
>>> @@ -1,7 +1,7 @@
>>>  # SPDX-License-Identifier: BSD-3-Clause-Clear
>>>  config ATH12K
>>>  	tristate "Qualcomm Technologies Wi-Fi 7 support (ath12k)"
>>> -	depends on MAC80211 && HAS_DMA && PCI
>>> +	depends on MAC80211 && HAS_DMA && PCI && PCIEASPM
>>
>> As you point out in patch 1/8, PCIEASPM is protected by EXPERT.
>>
>> Won't this prevent the driver from being built (or even showing up in
>> menuconfig) if EXPERT is not enabled?
> 
> It doesn't work that way, PCIEASPM defaults to y:
> 
> $ sed -i -e 's|CONFIG_PCIEASPM=y|CONFIG_PCIEASPM=n|g' .config && make oldconfig && grep -e 'CONFIG_EXPERT ' -e 'CONFIG_PCIEASPM=' .config
> #
> # configuration written to .config
> #
> # CONFIG_EXPERT is not set
> CONFIG_PCIEASPM=y
> 
>> Should we consider having a separate CONFIG item that is used to protect just
>> the PCI ASPM interfaces? And then we could split out the ath12k_pci_aspm
>> functions into a separate file that is conditionally built based upon that
>> config item?
>>
>> Or am I too paranoid since everyone enables EXPERT?
> 
> One just cannot control PCIEASPM value if EXPERT is not set. ASPM is 
> expected to be enabled, or "experts" get to keep the pieces.
> 

Thanks for the clarification. I now have no issues with the ath driver patches.

/jeff


