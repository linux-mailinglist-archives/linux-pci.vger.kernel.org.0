Return-Path: <linux-pci+bounces-43296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EE3CCBDD5
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1613E30424BD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E25334C22;
	Thu, 18 Dec 2025 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o3Ol76ap";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CUYBRZcv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54A334C1C
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062581; cv=none; b=taefO1qbERxqcx5PuIc+X1Op586/vXkfMFxn9uTAZZPF7Q/n4M3WWtSvfDvfQRRCmrHTRlo2gfUAOjNkSqF2jxlYDRw7Mm/2fmkZ4RnOrjwaF8447UioH/L1+7UJ2pzs/FUosigxsy8eUPhenc5eoxLlzANLItrGQyybcb/qww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062581; c=relaxed/simple;
	bh=/Ryx2XaukYApRR+V3xOMVWTe4klYiYbCt48ci7hYs+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyIIm5UkTuXRzAHjJnW+bODWsXqnlHPLYB+a+Lx57MpoGkVB2UBoKyzQjIu6mJBO31UZWXeN6Sbl8OnroHeP7WNTZI/JnlpqgR7LxwS54USeDvCGXXHyHSquG645h7P3jTD1XxQ9mCM+J9o7699bMDOu6+872UsLmyUTj+F3PJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o3Ol76ap; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CUYBRZcv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI9DcI4813844
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 12:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yShMG4kNQpdUj2h+GMzF3YTiuPcIUJL02zFHHKl4jrM=; b=o3Ol76ap8dWAa5dy
	IqOmJ4PXk3rcoVFFgTnGNdk7nm2+Jvy72XlVA5O2Ya+ilCxYWPMmiNBciLbaPeDP
	FVuVvxlPL7D24vvvCd/XKjjXVOYtrW3uTtI0SpFlYHPxBPLgiJ5qgSb02JGBs5SD
	fCz5vh7oXmfklQPEd1/BTTGKomqJX45ica5jwF0SV0Hv97FUaEKzc9SCGStnHDw9
	sz+9r+xYydUfkWB2Qe5UFvej08eV6IptuYWLv8DRi1lo4Vy7EYl+0bVG1IoGckgj
	5IBi7as+rfOufJw0nI/NmRnumWpjBXKuXdr+3G6CShGUqosxZ1kVE8xqQ71mm7pl
	8ODsAQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40v7b39t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 12:56:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0d59f0198so8915695ad.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 04:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766062578; x=1766667378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yShMG4kNQpdUj2h+GMzF3YTiuPcIUJL02zFHHKl4jrM=;
        b=CUYBRZcvfPU14M4gjExQ/IYE+T4d1PA7Mswl3DubbeUaUR4nD80XdwecwDoVOfOq5o
         2GwF74TPz6o7xhBYTS4ztZaTaL9M69cXR3Txg+DnlshbgFfra3NI8p87SEKYbO5G6yic
         KPgOMAXGQIA2ZKtcfLhijWN7RWdt40CFvBTblvkZvPICq8aNzWN/9Q9tbNa4ewbA+mTC
         6n2aPBeLNwKhE4fnBi4x08FXKarwkmeE6jXXQhBmGghopiYBr/5doIRd08O6YlJZetB9
         dtv/6IGPr2Vh8csbxVLwqlvynucZq/k8AVTUcElyZpQan0xif0/AcY8g1wy57CFd3NXV
         zrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766062578; x=1766667378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yShMG4kNQpdUj2h+GMzF3YTiuPcIUJL02zFHHKl4jrM=;
        b=EOODqMJl0s+Q+5Mp8TACJk+QfM6RLzGUlY75FLhsyXwyv5GGcuEBX0hGKobmr2rfqF
         Xgn+ZHE94o03fN0nrUv65jZ6BFlPbcG2ZmIzYPlhYq1QDVEfC+KL50GB5412+5Oufmht
         RI5BrL7RjtvvaAPzv0WCUs/cg+CuqsGtP3qvsj17MjF3WAChQvgD+Vi9sGJqpyyOzZmt
         0ThynWQKfXguqujvPdyrD/BMhXsbb5jDyETtleYI5Mrz1IfuH9zwyDLAwiPkKpShR1Mf
         GfrNp8d6d0Z05YEjNVmJW7jv1SMztcg95MYAn/xdKZHq8VjNtVwn6oX24WJDbf2IzBfm
         3TMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfUS9pTFl+Ww8DjAbTbICAJoJ/VnnUTlwyygBd/zk9a5u3DRN1ZRarogqymdb/5k5iXALgKT0xQj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8fOXSjpt0CXISIr0JfzVdR4+7+D9EcwppQJbd4fZTgXy4e/r
	Oqqhn80wOLO5UN4GQHcBTBohTfgMuHXbvsduPl9PaBx4ACbcluypbp2Ux+ff8bv34pavDf9/A6h
	HZMnJNSxESr2hKWA87ELGy4fRiOQZGu1c4zJ+T1B8pHWyNePapQE498OnalvbY0I=
X-Gm-Gg: AY/fxX74+2F+pIsT70TxG4sOWojuHiSWrWCOdk00/So9157W8L9EZI/KnA+HMUsuviE
	OSvlgBDNtynt7ad7kln1Nmi85kF/w4nMkSg5LAiwZxBRMczO+r7DdkaOSFUcRm9xag7lXiG0YxI
	Le1590BfFObZWoAncnGAU3OGLLg6C6Q7rJLyl1nfAwij+uCNXAez4LUnfBGGME2kXGs2I9hAT39
	8912/Lm5XSAEG/T0YKu0FlpeDrSvdzzFBiHhzMJO9AmThCgKCqXDwCFrDfZlgnT/BBMLjSqs3sl
	pdEXyWIhI7OC1EUcr0wvjdScKaNUtTHF4HDukLxuDUZHZxdLUPPEbY5qQh6B/LV9N/WxP9hNbdq
	0EP65DjE6PwUHx60+DGfEClcGQE/vDRSfImhIRykIUQ==
X-Received: by 2002:a17:903:40c5:b0:2a0:9fc8:a98b with SMTP id d9443c01a7336-2a09fc8b009mr164840305ad.40.1766062578084;
        Thu, 18 Dec 2025 04:56:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErm9mdtpsuYiQTso3NZAs3/Pbqu4BC0S5q3wlv+e8BBn0piG8M7lD78hdzUQUWcz37eUdmkQ==
X-Received: by 2002:a17:903:40c5:b0:2a0:9fc8:a98b with SMTP id d9443c01a7336-2a09fc8b009mr164839955ad.40.1766062577539;
        Thu, 18 Dec 2025 04:56:17 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1927169sm25025855ad.85.2025.12.18.04.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 04:56:17 -0800 (PST)
Message-ID: <c4aedf62-633d-4871-9dfa-af021e9a8e42@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 18:26:12 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: dwc: Do not return failure if link is in
 Detect.Quiet/Active states
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Jingoo Han
 <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com
References: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
 <20251218-pci-dwc-suspend-rework-v2-2-5a7778c6094a@oss.qualcomm.com>
 <237606b2-783a-4e11-854b-fed787e2903d@oss.qualcomm.com>
 <isbb3bng27ibc3xddvjvlgbtz7skbbpd4q3a6rdqul7ghmmsyy@ze72f2hs4kb3>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <isbb3bng27ibc3xddvjvlgbtz7skbbpd4q3a6rdqul7ghmmsyy@ze72f2hs4kb3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DDLPgG7DNzepkWCanXd0bVBQAF1IzDgi
X-Proofpoint-GUID: DDLPgG7DNzepkWCanXd0bVBQAF1IzDgi
X-Authority-Analysis: v=2.4 cv=f8JFxeyM c=1 sm=1 tr=0 ts=6943f9f3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=1m2I05raOZ1oqLzephcA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDEwNyBTYWx0ZWRfX4xv3UJ1B//aQ
 pZ6mZtaJSTNrzf7xZyGi6mREQsmyB43IFFAVXSwy8RFHZ27DEba7c6lo9+Pzlobr1ze1MJKKOn2
 d2C5Mka+KKWXzHUs221auYbej2XnhSOBxJ1coACVTb07SBH3dXPS0mmaaD/m1CCTGaLjMJRVe8u
 3gsKVFmrpiC+ldDdGghafrN04HjPWJOCrdfe36Mp98n2zJezqZi968t7D/3MmLB9NnCQn1i3uoe
 QELX0BkSfKoDD2O0u2B+JNAhcEOrpX1rgLgaaRe6+gQEStDuBtkWXTsC7r9nzx4kCvkjd4/sD1P
 KzEn3SewpXcHzBhyR8tRpJms5SLFpy+Y3drcMUH/ZcKsZTtmFUJHN44joFa8BuH/p+PWWkGwd5r
 Y1X+MO9fhKjtZfT8xKVF0uq46ixkLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180107



On 12/18/2025 6:16 PM, Manivannan Sadhasivam wrote:
> On Thu, Dec 18, 2025 at 05:57:30PM +0530, Krishna Chaitanya Chundru wrote:
>>
>> On 12/18/2025 5:34 PM, Manivannan Sadhasivam via B4 Relay wrote:
>>> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>
>>> dw_pcie_wait_for_link() API waits for the link to be up and returns failure
>>> if the link is not up within the 1 second interval. But if there was no
>>> device connected to the bus, then the link up failure would be expected.
>>> In that case, the callers might want to skip the failure in a hope that the
>>> link will be up later when a device gets connected.
>>>
>>> One of the callers, dw_pcie_host_init() is currently skipping the failure
>>> irrespective of the link state, in an assumption that the link may come up
>>> later. But this assumption is wrong, since LTSSM states other than
>>> Detect.Quiet and Detect.Active during link training phase are considered to
>>> be fatal and the link needs to be retrained.
>>>
>>> So to avoid callers making wrong assumptions, skip returning failure from
>>> dw_pcie_wait_for_link() only if the link is in Detect.Quiet or
>>> Detect.Active states after timeout and also check the return value of the
>>> API in dw_pcie_host_init().
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>> ---
>>>    drivers/pci/controller/dwc/pcie-designware-host.c |  8 +++++---
>>>    drivers/pci/controller/dwc/pcie-designware.c      | 12 +++++++++++-
>>>    2 files changed, 16 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index 43d091128ef7..ef6d9ae6eddb 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -670,9 +670,11 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>>    	 * If there is no Link Up IRQ, we should not bypass the delay
>>>    	 * because that would require users to manually rescan for devices.
>>>    	 */
>>> -	if (!pp->use_linkup_irq)
>>> -		/* Ignore errors, the link may come up later */
>>> -		dw_pcie_wait_for_link(pci);
>>> +	if (!pp->use_linkup_irq) {
>>> +		ret = dw_pcie_wait_for_link(pci);
>>> +		if (ret)
>>> +			goto err_stop_link;
>>> +	}
>>>    	ret = pci_host_probe(bridge);
>>>    	if (ret)
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>>> index 75fc8b767fcc..b58baf26ce58 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>> @@ -641,7 +641,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
>>>    int dw_pcie_wait_for_link(struct dw_pcie *pci)
>>>    {
>>> -	u32 offset, val;
>>> +	u32 offset, val, ltssm;
>>>    	int retries;
>>>    	/* Check if the link is up or not */
>>> @@ -653,6 +653,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>>>    	}
>>>    	if (retries >= PCIE_LINK_WAIT_MAX_RETRIES) {
>>> +		/*
>>> +		 * If the link is in Detect.Quiet or Detect.Active state, it
>>> +		 * indicates that no device is detected. So return success to
>>> +		 * allow the device to show up later.
>>> +		 */
>>> +		ltssm = dw_pcie_get_ltssm(pci);
>>> +		if (ltssm == DW_PCIE_LTSSM_DETECT_QUIET ||
>>> +		    ltssm == DW_PCIE_LTSSM_DETECT_ACT)
>>> +			return 0;
>>> +
>>>    		dev_info(pci->dev, "Phy link never came up\n");
>> Can you move this print above, as this print is useful for the user to know
>> that, link is not up yet.
>>
> If the device is not connected to the bus, what information does this log
> provide to the user?
Not every user is aware that device is not connected, at-least this log 
will give info
that there is no device connected.

- Krishna Chaitanya.
> - Mani
>


