Return-Path: <linux-pci+bounces-36726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABAAB93FFD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 04:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CC33A5563
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 02:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F09125A334;
	Tue, 23 Sep 2025 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxioQbUP"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6438E1CAB3
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594396; cv=none; b=qMu7OHqkttrqTCVxgZnJ1xGNBNeFsPAVF0uyhDG22vI9ZWN7a3x0vtJTO7cUmaHfdbXu8v/OrgMgfadqtBShis/5rcHejWDxufWUcH6HaVdGKamRcSqYQ4f9Jm169kG5AXpkfd85Zg4j8V4/lpP5Nbty3oJsA1VTbgenR/WuO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594396; c=relaxed/simple;
	bh=g9MBrqKRxZdbNaQ2i02BY1V65gw6a+Y7SeILJk5mGz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYPZ5tpY+B2KOdaBnA0fzcyrOvQkROHwD+VmIzjA3SN4mrAbGRUFRpFeprUc+mhXpY3nTzyKaYRsCh4Zt7htLZvLdEUrRhtzrTgqKd46lGMHnmcZbtXTG9ZZJOD/Gvk/JwxXLD/izL4ArkQ4XPSZXe2JWmtFwDBElYnosgpIikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxioQbUP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758594393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PCUD8Djs42q6wF1aYGU4dHZzCceidwhyTYH/cv8Ps8=;
	b=CxioQbUPhIJYHnS14nRJO6/OsqhoufsrIptD7QP6JHHqeNb6uO1L2eATAeUbUuBmvxj4G0
	ry1HqRtBmx5FZ+Giuzqfg9GZI1ZGVJXPpeUvL2D8JyJLhB9rGSKywZo5WXdJ8WyXaMs9Ef
	/srTlu6Wn0xJUWdgK/d1TX0z1bg/7IA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-uVJNy-q2NNeybRsGWG3L_g-1; Mon, 22 Sep 2025 22:26:32 -0400
X-MC-Unique: uVJNy-q2NNeybRsGWG3L_g-1
X-Mimecast-MFC-AGG-ID: uVJNy-q2NNeybRsGWG3L_g_1758594391
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d374dd29d1so8385551cf.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 19:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758594391; x=1759199191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PCUD8Djs42q6wF1aYGU4dHZzCceidwhyTYH/cv8Ps8=;
        b=mnMDVPYFA4zYrQJMkbyjuSW4NaSJTQUY+CvLw/9OPlQgOYdAxavedTDzNjGb9Z+yi/
         bKBpEXJU5yPr7Oxng6giMsIeT0oc0uux15+iH5/GF87jv1EGaZaVkjtfQ4pSASemB5bK
         eIwTpsC52ANb5et+fieYGDbxwPZFmC8cEdO99W2NAxrQ5zIS7IoV9xZSo96aavsUIHs4
         shaE6jcjmqcE1B5M+zdx30zm8ter16ZsOGbgU24nSDkRq7JR/eC7Ra10D6+w0KO+Rswl
         oVqp7KF8Qn5Aqs77vqaPDZU6/uZ9quzCdnJ4dyRqs1uQCvAGE7GIgJu0f7EsUikKBJoc
         UGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO3f0XAqWTz4SdWP8rNhVxFXFDOkieYUTqtLxPU0OljenJSY0ENwd6MAKsZyd5tMvvHBdACkVePzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvicka8esqf0VqLtRW0JwRHAQpXuf9pZi8W/+4WgdRk452r+z7
	yEiRkXLRX5w/YeAaQc1SPmFO98DoD/LslBWXq/4HxT0RT5QKSMteA0ieucyDuMMIcKVUKfNkNRa
	YkhhrZorXYhgVH9f3uFkLfua9tMgzq3TY1Us88Jgjz03cyTLqDYlE3TJqTrfQkg==
X-Gm-Gg: ASbGncv0nwWtCP7g9lp5ND7jjtoVQM3oL9/il9cy2J3O56x36iQSwKtGam5yQ6OB8Bt
	+L+7bAXA68oX+gfqD+djZJeTatYvnOzYDsMO/ZqDYyHRz1ouwmMVsmTUjMWiuVtpo3bVW/wD76q
	fsaXhcEH4ei3JaXOQ38bIw4Ndto0WLKZFyoOfIxceXDTF/9i0wSyvJYEIo79+l1yxWhMwlz98ek
	8r7UPc4j9MZShtapAuQLRbjprNPz448nmy+0S00dFiRPukWwzhg+R3rHlFI5LI3MjREezLfaHDH
	zGkf0fLJ38KZRttRLbdqwEKfueaF2wI4ipNh2GsE
X-Received: by 2002:a05:622a:22a0:b0:4b7:9abe:e1d0 with SMTP id d75a77b69052e-4d3736be686mr10224561cf.83.1758594391150;
        Mon, 22 Sep 2025 19:26:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh1sa0UCiSmZuNAaBvHrwWnpQZ66gjDzkXkZDaP2M4kQe89ePy6njY8SwRBtPjwxnoKyKQGQ==
X-Received: by 2002:a05:622a:22a0:b0:4b7:9abe:e1d0 with SMTP id d75a77b69052e-4d3736be686mr10224311cf.83.1758594390717;
        Mon, 22 Sep 2025 19:26:30 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bd9b0c128bsm81896451cf.0.2025.09.22.19.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 19:26:30 -0700 (PDT)
Message-ID: <066e288e-8421-4daf-ae62-f24e54f8be68@redhat.com>
Date: Mon, 22 Sep 2025 22:26:26 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] iommu: Compute iommu_groups properly for PCIe
 switches
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <0-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
 <3-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
 <20250701132905.67d29191.alex.williamson@redhat.com>
 <20250702010407.GB1051729@nvidia.com>
 <c05104a1-7c8e-4ce9-bfa3-bcbc8c9e0ef5@redhat.com>
 <20250717202744.GA2250220@nvidia.com>
 <2cb00715-bfa8-427a-a785-fa36667f91f9@redhat.com>
 <20250718133259.GD2250220@nvidia.com>
 <20250922163200.14025a41.alex.williamson@redhat.com>
 <20250922231541.GF1391379@nvidia.com>
 <20250922191029.7a000d64.alex.williamson@redhat.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250922191029.7a000d64.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/25 9:10 PM, Alex Williamson wrote:
> On Mon, 22 Sep 2025 20:15:41 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
>> On Mon, Sep 22, 2025 at 04:32:00PM -0600, Alex Williamson wrote:
>>> The ACS capability was only introduced in PCIe 2.0 and vendors have
>>> only become more diligent about implementing it as it's become
>>> important for device isolation and assignment.
>>
>> IDK about this, I have very new systems and they still not have ACS
>> flags according to this interpretation.
> 
> But how can we assume that lack of a non-required capability means
> anything at all??
>   
ok, I'll bite on the the dumb answer...
lots of non-support is represented by lack of a control structure.
... should we assume there are hidden VFs b/c there is a lack of a vf cap structure?
... <insert your favorite dumb answer here> :-)

I can certainly see why a hw vendor would -not- put a control structure
into a piece of hw that is not needed, as the spec states.
For every piece of hw one creates, one has to invest resources to verify
it is working correctly, and if verification is done correctly, verify it
doesn't cause unexpected errors.  I've seen this resource req back in
my HDL days (developers design w/HDL; hw verification engineers are the
QE equivalent to sw, verifying the hw does and does not do what it is spec'd).

Penalizing a hw vendor for following the spec, and saving resources,
seems wrong to me, to require them to quirk their spec-correct device.

I suspect section 6.12.1.2 was written by hw vendors, looking to reduce
their hw design & verification efforts.  If written by sw vendors, it
would have likely required 'empty ACS' structs as you have mentioned in other thread(s).

>>> IMO, we can't assume anything at all about a multifunction device
>>> that does not implement ACS.
>>
>> Yeah this is all true.
>>
>> But we are already assuming. Today we assume MFDs without caps must
>> have internal loopback in some cases, and then in other cases we
>> assume they don't.
> 
> Where?  Is this in reference to our handling of multi-function
> endpoints vs whether downstream switch ports are represented as
> multi-function vs multi-slot?
> 
> I believe we consider multifunction endpoints and root ports to lack
> isolation if they do not expose an ACS capability and an "empty" ACS
> capability on a multifunction endpoint is sufficient to declare that
> the device does not support internal p2p.  Everything else is quirks.
> 
>> I've sent and people have tested various different rules - please tell
>> me what you can live with.
> 
> I think this interpretation that lack of an ACS capability implies
> anything is wrong.  Lack of a specific p2p capability within an ACS
> capability does imply lack of p2p support.
> 
>> Assuming the MFD does not have internal loopback, while not entirely
>> satisfactory, is the one that gives the least practical breakage.
> 
> Seems like it's fixing one gap and opening another.  I don't see that we
> can implement ingress and egress isolation without breakage.  We may
> need an opt-in to continue egress only isolation.
> 
>> I think it most accurately reflects the majority of real hardware out
>> there.
>>
>> We can quirk to fix the remainder.
>>
>> This is the best plan I've got..
> 
> And hardware vendors are going to volunteer that they lack p2p
> isolation and we need to add a quirk to reduce the isolation... the
> dynamics are not in our favor.  Hardware vendors have no incentive to
> do the right thing.  Thanks,
> 
I gave an example above why hw vendors have every incentive not to add an ACS structure if they don't need it.
Not doing so, when they can do p2p, is a clear PCIe spec violation.  Punishing the correct implementations for the
incorrect ones is not appropriate, and is further incentive to continue to be incorrect.

Don't we have the hooks with kernel cmdline disable_acs_redir & config_acs params to solve the insecure cases
that may (would) be found, so breaking the isolation is relatively easy to fix vs adding quirks as is done today for proper spec interpretation?

- Don

> Alex
> 


