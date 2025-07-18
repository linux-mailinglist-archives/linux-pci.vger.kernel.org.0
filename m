Return-Path: <linux-pci+bounces-32561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD9B0AA90
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 21:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0353E5A83B6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 19:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BB62E7BA9;
	Fri, 18 Jul 2025 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKBCGRKC"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB62E88A2
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865858; cv=none; b=bMDGA409SfoprXWQkDohrPazp6aqm+QQpRvKSTJjaJqS+ziX3ZQA/iwuNGnWMhJwVycV/qt/72tB3iXXipDrU6uBWZGAJ/9CR3GzegTlRUrX0o1mwAcR79wRmSxf3UoBoFc4Zv4rdiccPHFPNUjx1wKO59duk+DmZOZiPYsBQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865858; c=relaxed/simple;
	bh=12HnDqMeVgttmuY8covfcXjk4vazl0YNAz1/AvqhAPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJOQQM+zpb8Gp9fPKw+x3CeiIFryj94jtwFmE7lrk58neuOAfQ3SoAvjghEhraTcFYYZ83IaVd7PnA0QDXB/AmfCj/RRBuEsqczZmLg6h050poM8jzJ+zHLoeveievg00wy6IC92pr2n6tmxE6s/qDuA+e2nl/h5debs2Ajq9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKBCGRKC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752865852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8D+e9uBJDRczJqfQeOvVP8ReNAlQCGSx/AVjBJK5K4=;
	b=DKBCGRKCLhqNZMGQRpvHYOgmotdb9wZcDw596wFyJcrxjX0QkMQt/9Dswcvzyj7+rXe0iS
	mtlhfGnULYfoSZEFmr7lsKew/+mV3gpktl/XvWySlylo/pWH1naqLjwmV8IxFr75lXbNoS
	DXjiS6WN57/bLuT9HSB2x8EyL8oIKpU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-bk2V9gkZPEyYp2TrlFBEuA-1; Fri, 18 Jul 2025 15:10:49 -0400
X-MC-Unique: bk2V9gkZPEyYp2TrlFBEuA-1
X-Mimecast-MFC-AGG-ID: bk2V9gkZPEyYp2TrlFBEuA_1752865848
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311ae2b6647so2319291a91.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 12:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752865848; x=1753470648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8D+e9uBJDRczJqfQeOvVP8ReNAlQCGSx/AVjBJK5K4=;
        b=jxp8Ql6XF8cDe+0dSPVgun7tRoG60K9/ZCZiWNgBwliKKGp1qSpUzuPy5O7eyU3zb6
         TkFHVCIRbcL07l+PCkjNFIEy9xKp3t+NyeG3/sZaGDPjhqvj6A8QFIg1DmA0OMBlhoXC
         BbbwTga7j2T/0OAXy/58/Fw29vh/9S474mZmbNSqd63ChRQCcSZD/qzJkh9GGCjdMmuL
         M+tMj56ecnhG0DqvwhkbN1jczeF6uVG9/IMAzPKjCVlsC10xmSyDGrXwgGnMLgM8k0co
         gdHZK/eQ9dUizPUdsLL94fPwclBo8YTsGW8spFpVcoEKfy7oCljYO48cMgiUzTVyGq5Y
         7pzg==
X-Forwarded-Encrypted: i=1; AJvYcCUXoK1qB9G39oRksL21SVmej/E6nJcbASzFjfXuKPeyT/iuNOSVQvSoxJffX6sv5RAXvg/UiXm2xBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeFN6h7qVkidR7Oi6KeJuOXHeAxRz+voA8WcH+pR6GDdTCeunk
	pALlslGQbg9vV39oOHCAn6tiwyQrj3poxJubKy8sJW9yp0pC7SZyZuMWEYPPVrs3sgexQ2cGdQF
	xPeRqSYcruHroDG9IpvCbq/nYuWaKj8YtBhFwQGvYOUETVLIdyoo7JMb7pU8odg==
X-Gm-Gg: ASbGncsxsRH7LtbPqmD7B9JLorjFSF6y3ag0PyVsAd0UWXtTLTWYqRetw1HZ1w/jHgs
	wcAV8WfxNLOqJel00xI6d7KeDgloZqF5WxoW+hsVYPhdDvA9mROLbBMGB7Lsz6gsHr5MjDw3WJz
	Z7gbpuXLQPxVsiBExLW9bxL8/syr3R4/CZbjySZnJx/rWZQRgqkIMnYGO4gJIFFfIUAXOdrjg4t
	ANHb3vLV1R0va+aH3r4bK+eihaZBShrHDQVOx4UhyfhrwApSPjmz5xtkwujK/MjCRKTWgz9Ezyb
	eH1xp95qv2UkglqqsCI0Km4tUN9ewJqUO445v8ZR
X-Received: by 2002:a17:90b:6ce:b0:311:b5ac:6f6b with SMTP id 98e67ed59e1d1-31cc253d5c7mr6000480a91.9.1752865848247;
        Fri, 18 Jul 2025 12:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIqj9LP2vHBGP1tqCvOrWc8j8Q/BDtDPfNNbouKYvr5XMtLMkhhPcn26wkmN3ctBxthZr59g==
X-Received: by 2002:a17:90b:6ce:b0:311:b5ac:6f6b with SMTP id 98e67ed59e1d1-31cc253d5c7mr6000449a91.9.1752865847822;
        Fri, 18 Jul 2025 12:10:47 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e6a68sm5667046a91.19.2025.07.18.12.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 12:10:47 -0700 (PDT)
Message-ID: <519d8178-4cec-44c2-8b24-cc9ae9dbd221@redhat.com>
Date: Fri, 18 Jul 2025 15:10:42 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] PCI: Add pci_reachable_set()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <5-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
 <3bf0f555-535d-4e47-8ff1-f31b561a188c@redhat.com>
 <20250718174921.GA2393667@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250718174921.GA2393667@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/25 1:49 PM, Jason Gunthorpe wrote:
> On Thu, Jul 17, 2025 at 06:04:04PM -0400, Donald Dutile wrote:
>>> Implement pci_reachable_set() to efficiently compute a set of devices on
>>> the same bus that are "reachable" from a starting device. The meaning of
>>> reachability is defined by the caller through a callback function.
>>>
>> This comment made me review get_pci_alias_group(), which states in its description:
>> * Look for aliases to or from the given device for existing groups. DMA
>>   * aliases are only supported on the same bus, therefore the search
>>   * space is quite small
>>
>> So why does it do the for loop:
>>    for_each_pci_dev(tmp) {
>>
>> vs getting the pdev->bus->devices -- list of devices on that bus, and only
>> scan that smaller list, vs all pci devices on the system?
> 
> Because it can't access the required lock pci_bus_sem to use that
> list.
ah, i see; it's only declared in drivers/pci/search.c, and it isn't
a semaphone in a per-bus struct. :-/
... so move the function to search.c ? /me runs...
I know, not worth the churn; already have 'polluted' iommu w/pci, but not vice-versa.
(although iommu-groups is really a bus-op (would be a different op, for say, platform devices going through another iommu).

> 
> The lock is only available within the PCI core itself which is why I
> moved a few functions over there so they can use the lock.
> 
>> Could we move this to just before patch 11 where it is used?
> 
> Yes
> 
>> or could this be used to improve get_pci_alias_group() and get_pci_function_alias_group() ?
> 
> IMHO it is not really worth the churn
> 
Hey, your churning at the moment, so I figured you may want to churn some more! ;-)
just a comment/suggestion; not required.

> Jason
> 


