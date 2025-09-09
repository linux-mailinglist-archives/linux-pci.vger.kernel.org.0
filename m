Return-Path: <linux-pci+bounces-35767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA1B506A3
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 21:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E8F54752C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 19:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AE2340DA3;
	Tue,  9 Sep 2025 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHnwjKiq"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E3306D5F
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447903; cv=none; b=X2PW1dR1qrThNk6msZYpeeBrfAOYr4HxGGiEDAMAwCodQd/fINI/LJQkedop3xffe0zBzJ1Fg8Cx2FtKqA4+nK1L4fPXi8+hwijYQ5BIrer8hfVeU06ZTxexVREp/42zIjwfjhMul0A5XUQPHfPCb725alKD1teMBEh0qIQYPbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447903; c=relaxed/simple;
	bh=9kyPH/7+wdW7kBbHqGG+Ud1ODCMJF98xQA/Qhwi4KzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNfLyXtuqKnTM3lwS4fOI1AaSjIX1DphGYK92Hy/Bsbb5i/qx5G23l/eI91PQrqFZYWbV9Zwsz5lSVntStJN66PrlQpIF9484QoBdXZBPRUvznU0fSOGLnDQwBgQCQBHEgKycLibUjKCL54s01qIJnzA3IpXJno71+4kd+elrQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHnwjKiq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757447900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgCo6nYdRNSIrE5RFL1DFAnJKWKeGruM3UAqjFfXFW8=;
	b=SHnwjKiq84apbNKgH0ANyzPMVsORQMCt//AiXMFh6bhq5SUrLLBv/cf4s6eBihbA1lGu1g
	r3uros7D2NTd5ymffSQTsMgE8kFKYXN4TX0W7gt4YLSFeuzvkVCgAbZXwQyFDrQrMaJ0QI
	vjzmkZ1TNFaEXHPfyx4kjbL0ntZQllM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-hVukH9E5N66BoRPgDr3Sjg-1; Tue, 09 Sep 2025 15:58:19 -0400
X-MC-Unique: hVukH9E5N66BoRPgDr3Sjg-1
X-Mimecast-MFC-AGG-ID: hVukH9E5N66BoRPgDr3Sjg_1757447898
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-806a4452050so1164114385a.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Sep 2025 12:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757447898; x=1758052698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgCo6nYdRNSIrE5RFL1DFAnJKWKeGruM3UAqjFfXFW8=;
        b=QherAbrVPLvlSohsL/UY4tqPTw/7cjhMrcvYkynp9wTD7owLuRytICUVKSwL2tqJLB
         vZj63jLJTST9PsH8RHyf2ip8ar2YGTxb2UVoLZnE9v7mGBFmImxAgcTJ/e1iMC7HPPAT
         VxBk93sBNqPoDyhUTAK1Bq4nQKamsIjLVQsm2L04CnalwBPWFmeGHCx+jk/feW6l8WuW
         5LdMkywP98/c4hpUVsxdw1pQBm1e3zzgkifjFt0dWKLaITX8eOGclkxWAD7Niw6yAGHI
         DdqwkJWuT2q/mc04nWYa2WhPl0XTkuFK85ugOnGtR869BMoeKFbQa+2fYigjmql4xfkf
         Fnjw==
X-Forwarded-Encrypted: i=1; AJvYcCUsQRjKThEeG86kIgXAGiapveBMD5ui2oFlv3QCqcs14ERlo7PH9YwfU9uhbToM2pLbgn9uChxUe9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8IcY0CTmWehdeIPDkRJWL0yFBHGscl5GpxjQ6zT7I66PNup8Q
	S+IhHW/3NBK13Xq1kDIrmf23yLQfNoO/0qICjcMsmdFMfw2T9Y/dwoTJ6yLs2n5cWDg8XiPdFDu
	dsUSxUt40X7z/ZPM8Xv6i8+21wc7ewkY1G3CEUFrlbTSP/XodsbPGB1uy3uQSfw==
X-Gm-Gg: ASbGncu+kgpVkiV8Y1563DLQKeBXgHP7VLSfOABjGENMifvg+lxYb6Jik3tfC7qJHBc
	1kskn6fjTJzOVdiqfnqk/WDNy0VbslKQIeqs4mzBEDUtxIHgZgduzX09I5ThmKcNzVse94zsXwg
	rPhWjfA/555Ae/dTbY6Rmw3GpNgn28n8CNXcSMj2r3PvAIDX3SRLjOOD3P5Y3YcK/HyifEEtuyB
	aKbIo/UIBnGzbMuh0ZCiQmIJFtUQ4mLpPUEh8xhUZrWtf1ApDJ85pZ+MYmW+f0hz4J8eI77mBqP
	Ef1TkAIvO27mh1w25gdIi1cY40WBAvmh0PZ7UxPA
X-Received: by 2002:a05:620a:29d0:b0:813:8842:93c3 with SMTP id af79cd13be357-813c568dadamr1292510285a.81.1757447898333;
        Tue, 09 Sep 2025 12:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDoXxrFaCmJ/Gj+lCNKoCToXRUvhVa9mV8loJbiqez27cqgvzNF+qndJRohMfDl/gHnjbl+w==
X-Received: by 2002:a05:620a:29d0:b0:813:8842:93c3 with SMTP id af79cd13be357-813c568dadamr1292508485a.81.1757447897982;
        Tue, 09 Sep 2025 12:58:17 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58c54d9asm170295485a.1.2025.09.09.12.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:58:17 -0700 (PDT)
Message-ID: <819b6482-eb2c-4e2e-bf74-3396326aef5c@redhat.com>
Date: Tue, 9 Sep 2025 15:58:15 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] iommu: Validate that pci_for_each_dma_alias()
 matches the groups
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
References: <7-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
 <9487fde9-ec40-4383-aafe-7ae0811830f5@redhat.com>
 <20250909153511.GM789684@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250909153511.GM789684@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/9/25 11:35 AM, Jason Gunthorpe wrote:
> On Tue, Sep 09, 2025 at 01:00:08AM -0400, Donald Dutile wrote:
>>
>>
>> On 9/5/25 2:06 PM, Jason Gunthorpe wrote:
>>> Directly check that the devices touched by pci_for_each_dma_alias() match
>>> the groups that were built by pci_device_group(). This helps validate that
>> Do they have to match, as in equal, or be included ?
> 
> All aliases have to be in the same group, or have no group discovered yet.
> 
I guess I'm not asking correctly, as I think you agreed, but I'm looking for a clearer statement.
You said 'in' the same group; that's not 'equal', or what I think of as a 'match' of the pci_device_group() & dma-alias.

So, is it in equality/match, or inclusion/inclusive check; if the later, just tweak the verbage.

> Jason
> 


