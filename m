Return-Path: <linux-pci+bounces-35949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEADB53CB7
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 21:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3147D5A80A7
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD02242D9D;
	Thu, 11 Sep 2025 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1TGNSXo"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E225F7A5
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620265; cv=none; b=B/WuGc+Wg6s2KExzJHX0QMyzY1B33CdGNKWjGnJfzIAagEIUOJrar12/ViQEG8Iaf6mdheVdLGCcXXivNLrHtYRiRK9DsAaU2Icsqd9hfeK6P2PD55NRIrYGP7JoUx0S0vvBN2Ty7ovTBF5PZGcnxaAt75wtIJl+OsEPi5e//Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620265; c=relaxed/simple;
	bh=hLur9OXrLJVNhi3C1WvtgxiOwyKSS2/BRYUd6nt2+lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttXflnHpPrpd50083pB1Wmk4g7Exk9fI9tIKNbHRJfoB2K5L+78B8xUyxibSuoDQ9+pmoWXQecYV4Mi9Fi8XjMwJ69utc16QuuTB9nV2ai2D3xVi8Kj9IYVb4FUYcf97ztdnT399S8krJfso2eY9+oeyMDumMGLjrlGd48SEVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1TGNSXo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757620262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09h8euVLQFnhNfq+GfL1OKCW/f8r8xXjiDas370lAT0=;
	b=e1TGNSXoRBJfKbS/TR4Dc85kP+hA/3SaeCtosKAOgUsQ7l0k3mmsXaeClKmVZ6gj+KLU9f
	sJzpfaeKK8Gk8IJXkXlB3cwYf309qdbwB2h8kKKNsqrzbqXL2qTdypo9phrZ9qlrsj9A9+
	wHDG+tr7hSGy13rsH3m3tvH7kI+Q6Ko=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-7ezvGP5XMd2tNzb2Xw3RTw-1; Thu, 11 Sep 2025 15:51:01 -0400
X-MC-Unique: 7ezvGP5XMd2tNzb2Xw3RTw-1
X-Mimecast-MFC-AGG-ID: 7ezvGP5XMd2tNzb2Xw3RTw_1757620260
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70de52d2870so7595966d6.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 12:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757620260; x=1758225060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09h8euVLQFnhNfq+GfL1OKCW/f8r8xXjiDas370lAT0=;
        b=BKNI9OWxXK76I7g0kGvBQIuKfnlz/8mBbKnxF86EIGlw9ZsU70Bx+ivXQX4XWOvErs
         h7Tf6N6P0Vqk0G/aMPzu5Z7UouSSPnnC66VjDaMJRHscrunofA0Tah4ipjThORfQE4Bi
         hXrxrjy5ey9LRWx4aNwpqpw55MFo+HkH3kEEAT535uVaJ6ph48Hp0OFmH7Fs+oa45wL1
         ox9ZBhClIDr3Z25i6Nj2jQjKlZSGSTp7MfTanxJKma/x3SU4nd7cG1N/0EjqCgdvnK1t
         RIM6gnquBXZBFmq9KrqRvXe9uNcBM+vHwd9syLXDjHyo5Lv07EF0TJHOPbwdV91zzWnI
         4oMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6Zs1pmswEQR2+ndsETw29QLARNaTAZ9pgzGcXcEAbDsTenr9H+4HbOrJ4l/hkfuJRyljvN2YaIII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLf3aDtXJje2rgTNRUquYLaoHUDIKQJVhw1LnbfCy3BSaI3Byu
	Hti4+pRbgerq/bfiJ/eOjtfO6zUERpfXLggcaXqScGqlLnkcg1eDH8Fc4AzhBRGXni2PsjBWr4S
	47ZRmyspv8gsieBKhvVyoMVH2DqtYOepwro/5yxgG3OD0s6MFRQQ//7gZ1N0lMQ==
X-Gm-Gg: ASbGncsZa/XVkfV3DooQkR+9Z7MhI2U1Q1tUHGWuTuQYR+ZWefKZ+iPbPNAaxRWvGkP
	i4hD3iJg7NyzbLJWZQcCMRNKh7cpJ2XGz252BuF70baInGUBb8PmXh1ty3VINUPBsMvprXO6Rtx
	9Uig/5NNzn8sW9641cSoh+aWNFgtZNkYoBP1TU8PbW3s/UGhxMhC4wDfBxeXipSrVpWRz3nI5MN
	YCJ+4cPoDFB2o4CWkXY6sPqJXXcDDIesxXuxDa0iO6/pdmRnuebAz9n/iFAn786WSJtcP8DX7id
	SeiDEzV9nZKDwnggDW45Xs9EAnziZ7QMJgWu+DSg
X-Received: by 2002:a05:6214:2689:b0:70f:a2a7:ce72 with SMTP id 6a1803df08f44-767be2edcacmr5704886d6.29.1757620260155;
        Thu, 11 Sep 2025 12:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE25013zy+jxapmo75m2lXYdO9DhsJ09FzmF01ZPRWsNQN6+IV+NPQ6QZ2wA+tvyoAPi0B6ag==
X-Received: by 2002:a05:6214:2689:b0:70f:a2a7:ce72 with SMTP id 6a1803df08f44-767be2edcacmr5704456d6.29.1757620259688;
        Thu, 11 Sep 2025 12:50:59 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b54a1f41sm15832166d6.20.2025.09.11.12.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:50:59 -0700 (PDT)
Message-ID: <827cc327-0d07-4b87-89e2-e45acede32ac@redhat.com>
Date: Thu, 11 Sep 2025 15:50:57 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] PCI: Check ACS DSP/USP redirect bits in
 pci_enable_pasid()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <10-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
 <20250909214350.GA1509037@bhelgaas> <20250910173405.GC922134@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250910173405.GC922134@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/10/25 1:34 PM, Jason Gunthorpe wrote:
> On Tue, Sep 09, 2025 at 04:43:50PM -0500, Bjorn Helgaas wrote:
>>> +/*
>>> + * The spec is not clear what it means if the capability bit is 0. One view is
>>> + * that the device acts as though the ctrl bit is zero, another view is the
>>> + * device behavior is undefined.
>>> + *
>>> + * Historically Linux has taken the position that the capability bit as 0 means
>>> + * the device supports the most favorable interpretation of the spec - ie that
>>> + * things like P2P RR are always on. As this is security sensitive we expect
>>> + * devices that do not follow this rule to be quirked.
>>
>> Interpreting a 0 Capability bit, i.e., per spec "the component does
>> not implement the feature", as "the component behaves as though the
>> feature is always enabled" sounds like a stretch to me.
> 
> I generally agree, but this is how it is implemented today.
> 
> I've revised this text, I think it is actually OK and supported by the
> spec, but it is subtle:
> 
> /*
>   * The spec has specific language about what bits must be supported in an ACS
>   * capability. In some cases if the capability does not support the bit then it
>   * really acts as though the bit is enabled. e.g.:
>   *
>   *    ACS P2P Request Redirect: must be implemented by Root Ports that support
>   *     peer-to-peer traffic with other Root Ports
>   *
>   * Meaning if RR is not supported then P2P is definately not supported and the
>   * device is effectively behaving as if RR is set.
>   *
>   * Summarizing the spec requirements:
>   *      DSP   Root Port   MFD
>   * SV    M        M        M
>   * RR    M        E        E
>   * CR    M        E        E
>   * UF    M        E        N/A
>   * TB    M        M        N/A
>   * DT    M        E        E
>   *   - M=Must Be Implemented
>   *   - E=If not implemented the behavior is effecitvely as though it is enabled.
>   *
>   * Therefore take the simple approach and assume the above flags are enabled
>   * if the cap is 0.
>   *
>   * ACS Enhanced eliminated undefined areas of the spec around MMIO in root ports
>   * and switch ports. If those ports have no MMIO then it is not relevant.
>   * PCI_ACS_UNCLAIMED_RR eliminates the undefined area around an upstream switch
>   * window that is not fully decoded by the downstream windows.
>   *
>   * Though the spec is written on the assumption that existing devices without
>   * ACS Enhanced can do whatever they want, Linux has historically assumed what
>   * is now codified as PCI_ACS_DSP_MT_RB | PCI_ACS_DSP_MT_RR | PCI_ACS_USP_MT_RB
>   * | PCI_ACS_USP_MT_RR | PCI_ACS_UNCLAIMED_RR.
>   *
>   * Changing how Linux understands existing ACS prior to ACS Enhanced would break
>   * alot of systems.
>   *
>   * Thus continue as historical Linux has always done if ACS Enhanced is not
>   * supported, while if ACS Enhanced is supported follow it.
>   *
>   * Due to ACS Enhanced bits being force set to 0 by older Linux kernels, and
>   * those values would break old kernels on the edge cases they cover, the only
>   * compatible thing for a new device to implement is ACS Enhanced supported with
>   * the control bits (except PCI_ACS_IORB) wired to follow ACS_RR.
>   */
> 
>> Sounds like a mess and might be worth an ECR to clarify the spec.
> 
> IMHO alot of this is badly designed for an OS. PCI SIG favours not
> rendering existing HW incompatible with new revs of the spec, which
> generally means the OS has no idea WTF is going on anymore.
> 
> For ACS it means the OS cannot accurately predict what the fabric
> routing will be..
> 
> Jason
> 
Exec summary: the spec is clear as mud wrt RP/RCs. ;-p

The above summary captures the proposed update conclusions to the spec,
and enables a good reference if a future conclusion is made that should require
another change in this area.  Thanks for the added verbage for future reference.

- Don



