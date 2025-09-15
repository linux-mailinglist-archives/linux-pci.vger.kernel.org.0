Return-Path: <linux-pci+bounces-36168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7471DB57F04
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 16:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D07A18935F9
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1D630BF60;
	Mon, 15 Sep 2025 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQE8u7WY"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F241D79BE
	for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946735; cv=none; b=mxdbGdEUMXZ1wx1WDCWe4LLRlIxW1tR8aNV6oNQUadhpDYYAQeBip4fyIQFUSNSniOQI2DBKsoJZyWs9qtCgdraYEQLtfHOeUDGp/QzbaBeDtkZ3o1mTRC+2wxCiA+RPjMEU/sjLpLsp0VxYUX0OJwKXD4lBR+e2XDspo81It7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946735; c=relaxed/simple;
	bh=jkhBmwEWgExuz1omsIkqNe0kpbi2sCvXXyGnjOfUSxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpsViv1m8uzq75hLxiKY1y0EcRfVOUVAGD8VGQ6l/ldxmpnzIgetOZZ/OqGfCd7n0HEGLVM5nrqv/+Q91NKLDX47PhaueVl0bPI0MLFASIfI4etaTSpzcJHFyWsMPgpbQi6mw0v0vaR6upmgz3FJib1LdJj9Zb4Qu8q89VmTgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQE8u7WY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757946733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMcQQL6ctMeg3ZJ3cGBnYeUoh99uDNZTCO2BZOovfjI=;
	b=HQE8u7WYVsJXWwocQGOcT+xGM4+iLjl7Ip77W2pL3c8EEJ6ycw+wDN4zz4YpjfNd+3vYMB
	KYErRKFu33gD54zwvI1+GiqSjdfJJKlx3CnqMy1WpWgj/deYjlbVVWV0CelJCFxb89mymk
	BNHRRD7Olm/p54px5Jj77yISpm1sYB4=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-7fTfHmQFNY-19ODfIZGsvw-1; Mon, 15 Sep 2025 10:32:12 -0400
X-MC-Unique: 7fTfHmQFNY-19ODfIZGsvw-1
X-Mimecast-MFC-AGG-ID: 7fTfHmQFNY-19ODfIZGsvw_1757946731
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-62cc6f82436so908175d50.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 07:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757946731; x=1758551531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMcQQL6ctMeg3ZJ3cGBnYeUoh99uDNZTCO2BZOovfjI=;
        b=ubZhHjesRd/UmuFll6ezj86Wu5xvpiYWUfqoHJhEk+j3Za0iaPUamM7MHSer/LgjMS
         9ppCCiqDz0Ofc4RW6Cbq3s9WxNm+NBFxgXBJsIopSXsdjgmOfINyctAfvD1bYwlb+mu9
         HzaVjSvOB1ADTZUdhrJQ8U4voPnwyqM6DhmJUIwzhMZ2sIdab8bRTL3s/tZk44/+62Ig
         0ax6P+7NUsofL7p1KcSXlEnoBHW1h5H4Q13slqMdEPiAxBiRs6hArjk10U/IWqHyXf5/
         n8tuJ9a0tsQmjoljKEyaDCsjmM56IXNK8Mirp3Y6jGsqPJBLyP6FcqGqjRdsET7VOe5h
         WKUA==
X-Forwarded-Encrypted: i=1; AJvYcCU4YJPm/uXoS2/M6guHAI/7gDpBRjzoL0HGqnlw+El2oY9wcjZM9UJeuvehdsyjrPTZimIP8COKzJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBKHFw5XVs/dTQnCnVgGXnB9xcIwZzOELc3jZMM4RLSTR6kk3
	5/b5IPfo6EzIvJO4t3nmziz2F80McSqxftPeP8yXMgWyPiVrg3nQ7W9LdN+B88b0nlYqRFPvz2W
	XY/7xjkyXzXjBxf4NqniTLNcvBs6yT6zU1DmtSXC0vf/bxsGNjSigpIU25no4hw==
X-Gm-Gg: ASbGnct05Q/Aw+9yUWGPhu/PKiX3A94dHB5VVi8+LRATWFvA4YTUS+83Rtoh7+GGwov
	6qgz133/ZJgjsCjDzGxpWeeWzWAzTReTRXrOTOlIYvY5p0HXhdpc0LHPuXjgk+kbuGy5vHoimQE
	DWoO5At5+sBeZ0CBmHz/HJYE6CoCO9u86uXBZL2Kc1ue8M2+GAmYSSQR5clWgp+/uzNen3tNsoR
	txkjgaQDvqDFwvrZ5G2MwyrFU40XVe/xN+LWRGGPvZwpRmzsFmLdODFBOCjYSgOfHWj9tXwkmrH
	ndX7c9kzJo0pBA+1kFUrhYQsJWd8Gj1olGK1Jr70
X-Received: by 2002:a53:aa05:0:b0:615:7d8f:66ed with SMTP id 956f58d0204a3-627243538cdmr8359776d50.17.1757946731308;
        Mon, 15 Sep 2025 07:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/V0+bL/bskp22k8XnWmcAyP2OD4HiXiRPvDyo43+eFheTBQzEtJAc9iSkcCrfBIyEROc9CA==
X-Received: by 2002:a53:aa05:0:b0:615:7d8f:66ed with SMTP id 956f58d0204a3-627243538cdmr8359725d50.17.1757946730666;
        Mon, 15 Sep 2025 07:32:10 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-78ab368dce4sm4620586d6.38.2025.09.15.07.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 07:32:09 -0700 (PDT)
Message-ID: <f870603f-490e-46a6-8618-201c9550e5e2@redhat.com>
Date: Mon, 15 Sep 2025 10:32:08 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] PCI: Add pci_reachable_set()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <20250909210336.GA1507895@bhelgaas>
 <3d3f7b6c-5068-4bbc-afdb-13c5ceee1927@redhat.com>
 <20250915133832.GE922134@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250915133832.GE922134@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/15/25 9:38 AM, Jason Gunthorpe wrote:
> On Thu, Sep 11, 2025 at 03:56:50PM -0400, Donald Dutile wrote:
> 
>> Yes, and for clarify, I'd prefer the fcn name to be 'pci_reachable_bus_set()' so
>> it's clear it (or its callers) are performing an intra-bus reachable result,
>> and not doing inter-bus reachability checking, although returning a 256-bit
>> devfns without a domain prefix indirectly indicates it.
> 
> Sure:
> 
> /**
>   * pci_reachable_bus_set - Generate a bitmap of devices within a reachability set
>   * @start: First device in the set
>   * @devfns: Output set of devices on the bus reachable from start
>   * @reachable: Callback to tell if two devices can reach each other
>   *
>   * Compute a bitmap @defvfns where every set bit is a device on the bus of
>   * @start that is reachable from the @start device, including the start device.
>   * Reachability between two devices is determined by a callback function.
>   *
>   * This is a non-recursive implementation that invokes the callback once per
>   * pair. The callback must be commutative::
>   *
>   *    reachable(a, b) == reachable(b, a)
>   *
>   * reachable() can form a cyclic graph::
>   *
>   *    reachable(a,b) == reachable(b,c) == reachable(c,a) == true
>   *
>   * Since this function is limited to a single bus the largest set can be 256
>   * devices large.
>   */
> void pci_reachable_bus_set(struct pci_dev *start,
> 			   struct pci_reachable_set *devfns,
> 			   bool (*reachable)(struct pci_dev *deva,
> 					     struct pci_dev *devb))
> 
> Thanks,
> Jason
> 
Thanks... Don


