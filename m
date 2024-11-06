Return-Path: <linux-pci+bounces-16135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F199BEF09
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 14:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FAE1F2491F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 13:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219C01E0DB1;
	Wed,  6 Nov 2024 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AVJoO+oe"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DF41E0096;
	Wed,  6 Nov 2024 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899774; cv=none; b=db/2n/vidzGsdaztAukbk655A/qKbVK57mDwVWu+gwFOFfEuEF9Az5LZEUFcFCUigM1+nah1anjune72ZnxpL+cVcWCj1nBZ2byvvrtzT2hLmTs/e7nVsZifmxqklSLVZ0alTTfIlib2QdQfJg6ZFHK76PNseoXWwQZn+qXHsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899774; c=relaxed/simple;
	bh=fVNkLpFzLkJsXQDVFwWhgGwWb8WzrbwjQ1RM/7ZwYPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KO2X2LrliGtim4h3GbOMerwUG91mMeX6E+3P0hBbyqj0+aeiTpKatXfakFdcw1dm9rABvUl3P5EK6uSK4Apf1eNDaWeT7YhAo7qkP6+bD8uFW+CdCp5Z5r0ANRWw9EVJhqoywiR7QodqJodlHqPYgQfPeehK0NxKN8MTwBjCupg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AVJoO+oe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730899770;
	bh=fVNkLpFzLkJsXQDVFwWhgGwWb8WzrbwjQ1RM/7ZwYPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AVJoO+oeMmm6+03UpFQIcu/uxg08bLNLx3b7YD2da7REpGSSjwKsSCYY9orX7+GLa
	 +lEPCi5Wa3UjHuyTQuDiE+qUuIRHPefudnng2qA5oVp/NObxK2okD+nu4KW8raVwPA
	 Ru8ku58XniWkPi0/f3AH5ZQWfPm8IubNRnTdIpf6hLESLuGRLYi+JWSnfpZVjLvNv3
	 yUiYriF2uZhLxtpG2jl9rLQGmPoNkO94ickQYhoKkW3SKLeefU54klvGizPyMFKC1Y
	 cvWPhVTrnbzVACKrdK2tBGK/iDvOp1fE7KTDaA71YrmhLbk27D95OmIbHk7DuuFDQe
	 oMQtWCMeVGMJg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C6A2F17E3637;
	Wed,  6 Nov 2024 14:29:29 +0100 (CET)
Message-ID: <e2e41af9-ed09-4ac5-9481-e605d1340b3d@collabora.com>
Date: Wed, 6 Nov 2024 14:29:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: mediatek-gen3: Add support for restricting
 link width
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
 jianjun.wang@mediatek.com, lpieralisi@kernel.org, robh@kernel.org,
 bhelgaas@google.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 fshao@chromium.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>
 <20241104114935.172908-3-angelogioacchino.delregno@collabora.com>
 <20241104132046.GA2504924@rocinante>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241104132046.GA2504924@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/11/24 14:20, Krzysztof Wilczyński ha scritto:
> 
> Hello,
> 
>> +	ret = of_property_read_u32(dev->of_node, "num-lanes", &num_lanes);
>> +	if (ret == 0) {
>> +		if (num_lanes == 0 || num_lanes > 16 || (num_lanes != 1 && num_lanes % 2))
>> +			dev_warn(dev, "Invalid num-lanes, using controller defaults\n");
>> +		else
>> +			pcie->num_lanes = num_lanes;
>> +	}
>> +
>>   	return 0;
>>   }
> 
> If you were to handle non-zero return value as an error here, perhaps the
> property has not been set, then we could reduce the indentation here.
> 
> Something like this, perhaps?
> 
>    ret = of_property_read_u32(dev->of_node, "num-lanes", &num_lanes);
>    if (ret) {
>            dev_err(dev, "Failed to read num-lanes: %d\n", ret);
>            return ret;
>    }
>    
>    if (!num_lanes || num_lanes > 16 || (num_lanes != 1 && num_lanes % 2))
>    	dev_warn(dev, "Invalid num-lanes, using controller defaults\n");
>    else
>    	pcie->num_lanes = num_lanes;
> 
> Does this make sense here?  Thoughts?
> 
> 	Krzysztof


Sorry I've just seen this email.

There's a problem here: this property has to be optional - and if you change that
to return like that, you're breaking compatibility with older device trees, which
are not specifying any "num-lanes" property.

Please remember that of_property_read_u32() returns:
  - 0 on success
  - -EINVAL if the property does not exist
  - -ENODATA or -EOVERFLOW

Please either keep the error checking like I wrote, or alternatively you can do..

ret = of_property_read_u32(...)
if (ret != -EINVAL) {
	dev_err(dev, "Failed to read num-lanes: %d\n", ret);
	return ret;
} else {
	if (num_lanes == 0 || ..... etc etc)
		dev_warn()
	else
		pcie->num_lanes = num_lanes
}

Cheers,
Angelo

