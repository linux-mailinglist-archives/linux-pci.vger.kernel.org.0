Return-Path: <linux-pci+bounces-27376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D43AAE3A6
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287481C00A91
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ACC289E0B;
	Wed,  7 May 2025 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DW2le85c"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C839ACC;
	Wed,  7 May 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629807; cv=none; b=bBtEl+uDcJkpV3lX34gE5dbY3+rzz8AiuDZjhOTyfxTsek1hxkG8qVmGvM12VbfXodJDpaJVt8Kkwcq8CfiZ73jIfq3Er9Mdf/PoE3DgQJGnV053XADI7xubvRFZ64uZM1QVxVtiW/BkLzo3G3wo7PtkX01nXyZUrIxU2Ep6Qng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629807; c=relaxed/simple;
	bh=WV4wvP8JsNZ0F1PfFxjv62Ig25+RnsR6VnAycPTqcGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imEXiD8y18++MsCH8H1biyP/n5i5RLLM5XDzbD1Rk8AaW5BSpitSGg4n/uzvC7O+K919YinU+gzHqkgZhUB2yHpRS+eQpbck393peHDh0M8kv2VUWSkWR2q+lwEr/juhywUUD5MYB7XSiD5AHLPN7elJeH7vQvMc20OWbxKkNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DW2le85c; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=tNmFFnlLRbbea3bahp28nTfyzV1Xhe+xKP45jX8AMAY=;
	b=DW2le85cvHbAy9SNvaybMrSBPDunRSVb5CcYqqAywCjz8Z/8jafn3bTFOlIyEi
	BM2AtqF7+Ib74XnedGReayUxz/MTVTfZwXHuLvT4FlMeyDnn0O0MFoN+zFNl12Ec
	ieqn4hQYr23XcKusyjn0FzupqJ0MeMXNLtPVhmVVv99rg=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAXG1lgdBtou6IsFA--.12424S2;
	Wed, 07 May 2025 22:55:29 +0800 (CST)
Message-ID: <2ae86e9f-2a91-476a-b017-e0e20489d8da@163.com>
Date: Wed, 7 May 2025 22:55:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] PCI: Configure root port MPS during host probing
To: Niklas Cassel <cassel@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com,
 pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250506173439.292460-1-18255117159@163.com>
 <20250506173439.292460-2-18255117159@163.com> <aBsN2_YG0RsH4RPA@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aBsN2_YG0RsH4RPA@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAXG1lgdBtou6IsFA--.12424S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy3Xr1UJw1DJrWfAFyDGFg_yoWDuFcEv3
	4Y9r47C3y8Xr90kw43ArZ8JrZxGanxZ3yjg348XrZay3s3Ar48A3s7K3WktF4Uu3WFvr17
	Cw1UZF1xA39xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1eT5PUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxBGo2gbb-2P7AAAss



On 2025/5/7 15:38, Niklas Cassel wrote:
> On Wed, May 07, 2025 at 01:34:37AM +0800, Hans Zhang wrote:
> 
> (snip)
> 
>>   static void pci_configure_mps(struct pci_dev *dev)
>>   {
>>   	struct pci_dev *bridge = pci_upstream_bridge(dev);
>> @@ -2178,6 +2209,10 @@ static void pci_configure_mps(struct pci_dev *dev)
>>   		return;
>>   	}
> 
> We should probably add a comment explaining why we are doing this here.
> 
> Perhaps something like:
> 
> /*
>   * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all),
>   * start off by setting root ports' MPS to MPSS. Depending on the MPS
>   * strategy, and the MPSS of the devices below the root port, the MPS
>   * of the root port might get overriden later.
>   */
> 
> 

Dear Niklas,

Thank you very much for your reply and suggestions.
It will be added in the next version.

Best regards,
Hans

>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>> +	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
>> +		pcie_write_mps(dev, 128 << dev->pcie_mpss);
>> +
>>   	if (!bridge || !pci_is_pcie(bridge))
>>   		return;
>>   
> 
> 
> Kind regards,
> Niklas


