Return-Path: <linux-pci+bounces-42279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C004BC9369B
	for <lists+linux-pci@lfdr.de>; Sat, 29 Nov 2025 03:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660A63A256E
	for <lists+linux-pci@lfdr.de>; Sat, 29 Nov 2025 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6BFD27E;
	Sat, 29 Nov 2025 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZALh4Pgc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XPNEh+RI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A436D50E
	for <linux-pci@vger.kernel.org>; Sat, 29 Nov 2025 02:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764383086; cv=none; b=HeNeJrn9ttWTxFpjaoaHsp4VFfGJHYPZUxX0gVkKIX9PW2V1KgIkc+UodliQ3lmPvflhDmcMvGMDFpGOoK55GzaTpZvZVHuzQQyAfGbOfBaUNiQHcaC3OXdcK4UF9AceO5fYb4HuxpNgLPzihl0Wwo7up68N3DUlNz+ZxCyfc44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764383086; c=relaxed/simple;
	bh=TUv7Oe2UKTAu+JIdqW78JWt8UxQDxDD0peTNXsINvvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBW62jD9+8WD89fqrt4UYYQXgdoEHU64JDxOhz9ONkRhnqBiyzLtm48l91Q7EGCd0tyF5Q7NmbZjHfhmmvYaU9OuzQqDI+J+sH7pCxcZNJKGs8GBT+oG1KbwA3pUQxkI8XVtBMw/AInHocHkJfHXUDm8H+OpIfLsLOo5ou4C3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZALh4Pgc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XPNEh+RI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AT1nNpa1594989
	for <linux-pci@vger.kernel.org>; Sat, 29 Nov 2025 02:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LwkbFZLKD9aKeC3WKC6OPnPkUZ3sWv42q7KMB+JxdX8=; b=ZALh4Pgcd8YVKgP+
	fN0REEvqQUhyynIAaVR7UNxqaYTXjuvxBkRg+zmy1wtOwMHLTannk9Qe/dEuYVjh
	NtotnQuuhIJybxaFmG4qKnYXSkH7vfsKuIHpWUpn62qx/ErVGb6FWhcYiQbwxAiY
	TiSzF9GoMw+fqvRH+OAzedJSvSMo/cTV4aEFaQPDy7rm+REIQS0uf5B5WKIwrmXa
	YMfaX5cQC6NRedarveoSEBgodtt1eOq9EF2roeELSgB5PTTVukVPGnUGXiravc54
	5CBpHgINJLw7PNM2SoGY57Uo3p40m9ParY0orVWnfZjyyBBWBNvAF+c7DIIVWqhh
	FvBtvw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aqdnr95n4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 29 Nov 2025 02:24:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3437863d0easo3465350a91.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Nov 2025 18:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764383083; x=1764987883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LwkbFZLKD9aKeC3WKC6OPnPkUZ3sWv42q7KMB+JxdX8=;
        b=XPNEh+RIAtYPadhiOoZwojN/LfHcfgMKnAb65XP75X/FTOzquojll9/UQ/A+4JVhGj
         n8etJhuH0KeD8n917VWPChRbsqSv2+g0EwTKEwlh7ZTdQ0v6BQuKfGSY93i0sxlOqSII
         Ho0DKhdZhX1Y9t2t2kFlx9ab2ljx0zJ/mXIUa6pDfLNo5uj8AKFWw4B+rXdh79PDO72J
         nYKpmVpQROIyo4YN52hhcPk126ILUOtKlDy7RBC+3iFKuoah1ZqKMFFWHTMDYI0xgWQD
         KzZ4hWzB4XfBw6D01gSodbvZVEhwfb1peGv/95KLuiUU8i6rsn6kaUf7sK/Yy9M/2p1K
         VO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764383083; x=1764987883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwkbFZLKD9aKeC3WKC6OPnPkUZ3sWv42q7KMB+JxdX8=;
        b=qIlvl1+D60Afj1cUguOUrHhcOC+hlGp9ncGjXaGHYpRQuzr8TIX3c0PFjuh1TOdA1K
         DLZ27UEyO2oUVHnVDhahG7kz0bM7HBFUwMsD1tiRdeCzSqeJh6FfCgJkUEEwfkz1ksQN
         bGmF5gtj4BK3dNFgOuBPpYW6h+GSnmI6/LBOPNgoUGmI7tr08j6hJtiLa97+M5+Aq0qJ
         +eVY6ys2fO68ub+KhuZcFc4KOT9abcL44ZXNlWhYfIzGDBDxYA0RfZpC75+usz+xmn86
         G18YKYqtfSIADbroN0vXRALElaWLI/nEcMWxdTU/3t/aQKNYKfv9hYvBwI2F/eD58nSU
         8Tmw==
X-Forwarded-Encrypted: i=1; AJvYcCXKotGU9XbdEPlg8XxasxZbYEYymXTs5V/xbfjOyvNoi0A3wPg2KRBZzK/JBjWJeIaBoGQYAUoWFLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBSy58z0KZ0oAcd/4qm4puiS8JpYD44vpbT+9M8ghrk16NESR
	Jt0ZmriTpaAw4vYvQBiqgpTZ/R/AKIL+BCn/hBGS4y5Oe9WuvRhP0HSU81Mzoj/d8wwVFqIQ+ha
	w4hysA9u1i0BbhcnClWxKwl0X7RGfblw/vRI0Ifaipdz4rvKbVESS3SmJcfnlVF0=
X-Gm-Gg: ASbGncvA267cKqV4WZu5SMvxT6laRD11aNfBWHIEoFVCMk9PXfuQL8nrBacnyhvrTdD
	ahGGXCSQVMt8ImJRh3ratPxbnPUtwHw/xL1mYmzQL36obS5t+dChi0NvyfWJXiCoss5vFKb8nfu
	DfNe3DtVifM2xz7vzDXICW0OnnDFtYHCP40f+8q+4G6X1W0ti29gbIVtekdkmjZFwIZ7WEH/Ct7
	oDwbDyHviPQnfjRmqEAoZzH698lIjJH+fDwp2TIzZY7GTVLOL2RGZJPnyCIF+X24ib+fV7SJLri
	fZqOQ7omNHPFFHxME7FZ51NDHpAvs4sfbbXpzGY/9KsLa9tgsB8mrT1hYj0UMROcf9/mcR2/Ge/
	pj69asv6EWDWMAeJJhJIjcfntkWt1DXZU19XqbaSJMHMy
X-Received: by 2002:a17:90b:3f44:b0:336:b563:993a with SMTP id 98e67ed59e1d1-34733f241bamr28027490a91.23.1764383083408;
        Fri, 28 Nov 2025 18:24:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuS9uBDENp+8fKPMnRbGGtrFWsMhy+XKSLqbm+LJ7zW7xyYkOcTCKFSJdCUmmv6bSYkyVlxQ==
X-Received: by 2002:a17:90b:3f44:b0:336:b563:993a with SMTP id 98e67ed59e1d1-34733f241bamr28027455a91.23.1764383082897;
        Fri, 28 Nov 2025 18:24:42 -0800 (PST)
Received: from [192.168.29.63] ([49.43.225.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f080beasm6276026b3a.47.2025.11.28.18.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 18:24:42 -0800 (PST)
Message-ID: <a4c6d47f-28b5-40d3-bc82-10aeb14f8e78@oss.qualcomm.com>
Date: Sat, 29 Nov 2025 07:54:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] PCI: dwc: Support ECAM mechanism by enabling iATU
 'CFG Shift Feature'
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Jingoo Han
 <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Jonathan Chocron <jonnyc@amazon.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org>
 <20250909-controller-dwc-ecam-v9-4-7d5b651840dd@kernel.org>
 <alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk>
 <c7aea2b3-6984-40f5-8234-14d265dabefc@oss.qualcomm.com>
 <alpine.DEB.2.21.2511280755440.36486@angie.orcam.me.uk>
 <cabf4c20-095b-4579-adc1-146a566b19b9@oss.qualcomm.com>
 <alpine.DEB.2.21.2511281714030.36486@angie.orcam.me.uk>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <alpine.DEB.2.21.2511281714030.36486@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNyBTYWx0ZWRfX15HQaJ7yzbqm
 gw2q+Vl3nV7KzS/nLktILs0xViOuaD+P4DFqlGuprNUVqGCsbjEpTHCpH4C3nHXkJVlvCkU9VQa
 rUxTlKcGY1cjo6E6mK8S6z7sLtL4Rgg0W2YXs0cplbEcDjPNgo3JdkxT5bDLB0na2rTQHX6qSfr
 pF78qy5AZnq1PBfsjKjo3t/5NmOGnXci1+OCpptGr4ObikrOWuEnzYs5BOUi2++HMDq3I4yXt5Z
 2YU8Sw/dNLPMYwlshOpejIbcGmbx7ZbxgYTrz9W7Z3Eb7LM4EH95Zrh+LDl+8wOzqF8FN1Cccfb
 6MfiebNBRWWWWD9asWrnH5OjjEC/3KqfHqaomlntdMXyP5m/DPv2zlOTf6AJJQpDBajVABXf08z
 Xw5V3NnbZDThmbQiVjp+sjkqY3WLCw==
X-Authority-Analysis: v=2.4 cv=E5bAZKdl c=1 sm=1 tr=0 ts=692a596c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=5EZHiQk+3i9I38XJ8QjOGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=guimUsFpNTjNUuBwESwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: q29Mio8VJOHNEQn0uN6qZX_J-KbsYXFo
X-Proofpoint-ORIG-GUID: q29Mio8VJOHNEQn0uN6qZX_J-KbsYXFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511290017



On 11/28/2025 10:46 PM, Maciej W. Rozycki wrote:
> On Fri, 28 Nov 2025, Krishna Chaitanya Chundru wrote:
>
>>>    I have no slightest idea why it should cause a regression such as this,
>>> it seems totally unrelated.  Yet it's 100% reproducible.  Could this be
>>> because it's the only device in the system that actually uses PCI/e port
>>> I/O?
>> Hi Maciej, Can you try attached patch and let me know if that is helping you
>> or not. - Krishna Chaitanya.
>   No change, it's still broken, sorry.
HI Maciej,
For the previous patch can you apply this diff and share me dmesg o/p
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -448,7 +448,6 @@ static int dw_pcie_config_ecam_iatu(struct 
dw_pcie_rp *pp)
         if (ret)
                 return ret;

-
         bus_range_max = resource_size(bus->res);

         if (bus_range_max < 2)
@@ -456,6 +455,8 @@ static int dw_pcie_config_ecam_iatu(struct 
dw_pcie_rp *pp)

         pp->ob_atu_index++;

+       dev_err(pci->dev, "Current iATU OB index %d\n", pp->ob_atu_index);
+
         /* Configure remaining buses in type 1 iATU configuration */
         atu.index = pp->ob_atu_index;
         atu.type = PCIE_ATU_TYPE_CFG1;
@@ -931,6 +932,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
                 }
         }

+       dev_err(pci->dev, "Current iATU OB index %d\n", i);
         if (pp->io_size) {
                 if (pci->num_ob_windows > ++i) {
                         atu.index = i;
@@ -946,6 +948,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
                                 return ret;
                         }
                 } else {
+                       dev_err(pci->dev, "Using shared io index %d\n", i);
                         pp->cfg0_io_shared = true;
                 }
         }

- Krishna Chaitanya.
>    Maciej


