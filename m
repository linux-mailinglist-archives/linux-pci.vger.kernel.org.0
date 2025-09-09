Return-Path: <linux-pci+bounces-35723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED171B4A118
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 07:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3C1162790
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 05:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BF026AEC;
	Tue,  9 Sep 2025 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSm37yw9"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9AA42AA9
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394265; cv=none; b=kPQy7u7rr4UG6vPckhchBuDp+1Y7WzeK8I7BcXgBOShGsW2uWTY7nbWwXykJ0AvPghOJ6bVJrYeUxu3FQJrPdT+3fPE6rONm9hldK+QvLQYNgJrhgYIi5Vhw6neLDmeALKfqnsJbTH9wl+s2N346yCdme15dG0H/ip6MyYJI5uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394265; c=relaxed/simple;
	bh=WRKEjVB88UyDSuQnn2M8CsE1PKosjlo1Gos8s6oIScU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rurwWaXjBQHiPEXwdhHCPH3R85whcRGvrTbzU+cnrFwz9dJT/3GeBBQgpOosUwCi+8XzSBBPkQrP4JMZiqJdIm/+kYRRMl+QK1ROcY8+r7CpqpJoQcvK2akR56y3BHeAXc9tq7PQqFphQtSfQHjtGHJQIZRA3sL6QtdY5YQjwKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSm37yw9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757394262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wr2ePTIKgu+dXGPmYEIQm5pOk8ImaQGQj8O0LKwZ6pU=;
	b=eSm37yw9NOpsyoundLVopN2CaT50Q0JxrKMxqrSx5VTjO5ldAcrQsD0BAO4S2/sCL2lI6r
	FUYXXE9kALTPlS6190Ed1ic3fAlXRQZUxsxqgDhRJRtV2ChfHbLJwiPlvJB4454wJ+B4dM
	lMUEEWNp7a0uuTzQ5EZFsILV6SAIoSk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-n86Fdx_TMy6waGlKKWlfNw-1; Tue, 09 Sep 2025 01:04:21 -0400
X-MC-Unique: n86Fdx_TMy6waGlKKWlfNw-1
X-Mimecast-MFC-AGG-ID: n86Fdx_TMy6waGlKKWlfNw_1757394261
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-816ae20ff2dso535682785a.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Sep 2025 22:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757394260; x=1757999060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr2ePTIKgu+dXGPmYEIQm5pOk8ImaQGQj8O0LKwZ6pU=;
        b=RoKCAPzrMOOrb6PaHmFOhwM/M9F5Mhkp2cNB05QE/HUk3JVj/Dx6Wznaz4DKzoqaVe
         +G2weaT8abZ/1RZYySIozAFHG1nA7XVMbOCmcU65XK1bFNi6jwXQs8w7M0YU8BytlKrp
         YTGPE3roUTrc7X82immPje8N/S2q5o8K7j3W+VBee6b7/9MyQ9c2Ns/yFfmPNctxF8rj
         MDoNTjDMsiFdRC15FtLf3ViFTsfdncQCZWltPoJHjh/IYJLzoVIsDnm2noffQtuB00/Z
         bRjcnDAalCNDrsluKeRIM46D96tmarKRRaqr144YIgR5dPC18NDyeJJytu3wjnnV2Pko
         2o1g==
X-Forwarded-Encrypted: i=1; AJvYcCWhKOF+0yzmp505hxRWeMv32jiqQAlcsG+iikEPcD1wY/d9A/mFyqVEBBVrHm+9DKquXR7/enPwb4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwSNT62l69iNop9ORd07n10DzaONhAEmVvrBsNWB1ZU4kGFEs
	Wwr5jc0aulxVbTjlwJyfI7BP3MKzeIys2QoW4VqUUn1mOLIpILx+yi+qNg3QVV40CeeDZS2i/cZ
	Nk6/GSVqimrYYNSaVUnhcVAhBJbAU2u2fuIlVSU/LCGgDTd/DU8UQ7UJ8IIAVHuqwbrkykQ==
X-Gm-Gg: ASbGnct35UXeAg0+qLxyjDOc2bVcxwl+bmq598mBY1hQTXO5mkPlBAnC7P6j7FoYzm3
	OKUCmKXsta4hlDYtFNOhkjyQdXaSCHDVX0v0H210rcB1qJmN2CVpSEpmd3OpeDWQq0ZXHqsscJ9
	6TEdN9YxlNc060e6j362G1d1rr38CHLUuVV/Zd5n3bekHpQyCUg07rZKpv053M1JkS6H+KJak1S
	qVECE19Fp4GVDw0OfSihi6YpHJtcArlvSEbMDJtyhj8Kuu+r/q8xfGkfBwsWBUeUf4Wy9KLYNmI
	7U3qw52cb2ehGu0IRuUsktrCYtMSF62ZhmGa1xBX
X-Received: by 2002:a05:620a:4049:b0:7e6:9a11:f0c8 with SMTP id af79cd13be357-813beffa169mr1079398685a.21.1757394260361;
        Mon, 08 Sep 2025 22:04:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+4M9jnqZ7XEtL8iNZFr7DfeWbk4fN2cPgrooLCIHf05hyNRzqCDxbOlnIixcIpPme44IWnw==
X-Received: by 2002:a05:620a:4049:b0:7e6:9a11:f0c8 with SMTP id af79cd13be357-813beffa169mr1079397285a.21.1757394259952;
        Mon, 08 Sep 2025 22:04:19 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58c51dacsm64417585a.12.2025.09.08.22.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 22:04:19 -0700 (PDT)
Message-ID: <b71c7500-3e1b-491b-8cf0-989401bc6795@redhat.com>
Date: Tue, 9 Sep 2025 01:04:17 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] PCI: Check ACS Extended flags for
 pci_bus_isolated()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com
References: <11-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <11-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/25 2:06 PM, Jason Gunthorpe wrote:
> When looking at a PCIe switch we want to see that the USP/DSP MMIO have
> request redirect enabled. Detect the case where the USP is expressly not
> isolated from the DSP and ensure the USP is included in the group.
> 
> The DSP Memory Target also applies to the Root Port, check it there
> too. If upstream directed transactions can reach the root port MMIO then
> it is not isolated.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/pci/search.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index dac6b042fd5f5d..cba417cbe3476e 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -127,6 +127,8 @@ static enum pci_bus_isolation pcie_switch_isolated(struct pci_bus *bus)
>   	 * traffic flowing upstream back downstream through another DSP.
>   	 *
>   	 * Thus any non-permissive DSP spoils the whole bus.
> +	 * PCI_ACS_UNCLAIMED_RR is not required since rejecting requests with
> +	 * error is still isolation.
>   	 */
>   	guard(rwsem_read)(&pci_bus_sem);
>   	list_for_each_entry(pdev, &bus->devices, bus_list) {
> @@ -136,8 +138,14 @@ static enum pci_bus_isolation pcie_switch_isolated(struct pci_bus *bus)
>   		    pdev->dma_alias_mask)
>   			return PCIE_NON_ISOLATED;
>   
> -		if (!pci_acs_enabled(pdev, PCI_ACS_ISOLATED))
> +		if (!pci_acs_enabled(pdev, PCI_ACS_ISOLATED |
> +						   PCI_ACS_DSP_MT_RR |
> +						   PCI_ACS_USP_MT_RR)) {
> +			/* The USP is isolated from the DSP */
> +			if (!pci_acs_enabled(pdev, PCI_ACS_USP_MT_RR))
> +				return PCIE_NON_ISOLATED;
>   			return PCIE_SWITCH_DSP_NON_ISOLATED;
> +		}
>   	}
>   	return PCIE_ISOLATED;
>   }
> @@ -232,11 +240,13 @@ enum pci_bus_isolation pci_bus_isolated(struct pci_bus *bus)
>   	/*
>   	 * Since PCIe links are point to point root ports are isolated if there
>   	 * is no internal loopback to the root port's MMIO. Like MFDs assume if
> -	 * there is no ACS cap then there is no loopback.
> +	 * there is no ACS cap then there is no loopback. The root port uses
> +	 * DSP_MT_RR for its own MMIO.
>   	 */
>   	case PCI_EXP_TYPE_ROOT_PORT:
>   		if (bridge->acs_cap &&
> -		    !pci_acs_enabled(bridge, PCI_ACS_ISOLATED))
> +		    !pci_acs_enabled(bridge,
> +				     PCI_ACS_ISOLATED | PCI_ACS_DSP_MT_RR))
>   			return PCIE_NON_ISOLATED;
>   		return PCIE_ISOLATED;
>   
Reviewed-by: Donald Dutile <ddutile@redhat.com>


