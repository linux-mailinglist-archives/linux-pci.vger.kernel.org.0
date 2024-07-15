Return-Path: <linux-pci+bounces-10339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95106931DE6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 01:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7BBBB22B3E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17E9143C53;
	Mon, 15 Jul 2024 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpjlGoO2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFAA143C6C;
	Mon, 15 Jul 2024 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087839; cv=none; b=JhCo+dWxdb6loN9fqx5OpmX4jwCrClas4oCaw0OhWK7eZQn+n8HEzjGZaXxXeLIDcaR5+GokxGIBaz1Z8GXZOETBC/Ly7D47yfsekTuTTyGSiggCFFr5xLoIVbLP5koAujjTx2klDWSgCanGmslSIAhM4U21Zad+oOFQ+N1T8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087839; c=relaxed/simple;
	bh=djDVMLy8012REatdkamKJadfXs9qmSxCHfOhPtpMocg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1yvie9R5B7xYWZ8xkX/g++VfeHCm9PTwMB934bSv0z6tHE4ey7+sC5trgr9KLvihbbTd6mjF2PXIj02OTZt4wvkNrVlEu5XPauOcpgILvcLJMzXYc543S06aZ/+eslrRz1eMLsIRCXz7RbRmTqfyr/1o7pbQJcqvsC/XKfi7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpjlGoO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692DBC32782;
	Mon, 15 Jul 2024 23:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721087839;
	bh=djDVMLy8012REatdkamKJadfXs9qmSxCHfOhPtpMocg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CpjlGoO2qzevP2D7uZAGUe1Xj73fz+shsIlGR1s3G6tuaBMemsg1dAnRn7R8pJ2+8
	 0Kfh3yUnJ0uGwbdvtCfG3aK5dxwR9XQvFRg4bghZie2bJSekTet3Uy1pKACflDxjWx
	 Dhval8OIRetyBafzWUJYT/kR/mlD8mCygXZD7mWIaXqFACKno5c5+u8BPXCRn/NAV/
	 KpIEE/yxArk6M2wNTgwOGRqeTQ3V7rsUafFWe/pEWOgE+6wR6ftMIXUdrTenKcqsDQ
	 taWiGrdIts3UDLEmjEiKlMEuyTNf+XweL/cBY2bOs7TKNoAwYoewgjOBnNUqx6DTzr
	 1XdtUfpeqQXOQ==
Message-ID: <5f7fca8b-ab74-4fba-8df8-152ad6f94227@kernel.org>
Date: Tue, 16 Jul 2024 08:57:14 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <kees@kernel.org>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxarm@huawei.com,
 David Box <david.e.box@intel.com>, "Li, Ming" <ming4.li@intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Alexey Kardashevskiy
 <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
 Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
 Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>,
 Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Jann Horn <jannh@google.com>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de> <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
 <57791455-5c70-4ede-97d9-d5784eef7abe@kernel.org>
 <20240715230333.GX1482543@nvidia.com>
 <f228526a-984f-4754-8ade-3f998a8b436a@kernel.org>
 <20240715234259.GZ1482543@nvidia.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240715234259.GZ1482543@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/24 08:42, Jason Gunthorpe wrote:
> On Tue, Jul 16, 2024 at 08:26:55AM +0900, Damien Le Moal wrote:
>> On 7/16/24 08:03, Jason Gunthorpe wrote:
>>> On Tue, Jul 16, 2024 at 07:17:55AM +0900, Damien Le Moal wrote:
>>>
>>>> Of note though is that in the case of SCSI/ATA storage, the device
>>>> (the HDD or SSD) is not the one doing DMA directly to the host/guest
>>>> memory. That is the adapter (the HBA). So we could ask ourselves if
>>>> it makes sense to authenticate storage devices without the HBA being
>>>> authenticated first.
>>>
>>> For sure, you have to have all parts of the equation
>>> authenticated before you can turn on access to trusted memory.
>>>
>>> Is there some way these non DOE messages channel bind the attestation
>>> they return to the PCI TDISP encryption keys?
>>
>> For the scsi/ata case, at least initially, I think the use case will be only
>> device authentication to ensure that the storage device is genuine (not
>> counterfeit), has a good FW, and has not been tempered with and not the
>> confidential VM case.
> 
> Oh, I see, that is something quite different then.
> 
> In that case you probably want to approve the storage device before
> allowing read/write on the block device which is a quite a different
> gate than the confidential VM people are talking about.
> 
> It is the equivalent we are talking about here about approving the PCI
> device before allowing an OS driver to use it.
> 
>> 100% agree, but I can foresee PCI NVMe device vendors adding SPDM support
>> "cheaply" using these commands since that can be implemented as a FW change
>> while adding DOE would be a controller HW change... So at least initially, it
>> may be safer to simply not support the NVMe SPDM-over-storage case, or at least
>> not support it for trusted platform/confidential VMs and only allow it for
>> storage authentication (in addition to the usual encryption, OPAL locking etc).
> 
> Yeah, probably.
> 
> Without a way to bind the NVMe SPDM support to the TDISP it doesn't
> seem useful to me for CC cases.

Yes, that likely would not work at all anyway as the driver needs to start
probing the device before authentication can happen, meaning that DMA needs to
be working before we can authenticate. So unless device probing is changed to
use untrusted memory for probing, that would not work anyway.

> 
> Something like command based SPDM seems more useful to load an OPAL
> media encryption secret or something like that - though you can't use
> it to exclude an interposer attack so I wonder if it really matters..
> 
>>> Still, my remarks from before stand, it looks like it is going to be
>>> complex to flip a device from non-trusted to trusted.
>>
>> Indeed, and we may need to have different ways of doing that given the different
>> transport and use cases.
> 
> To be clear there are definately different sorts of trusted/untrusted
> here
> 
> For CC VMs and TDISP trusted/untrusted means the device is allowed to
> DMA to secure memory.
> 
> For storage trusted/untrusted may mean the drive is allowed to get a
> media encryption secret, or have it's media accessed.
> 
> I think they are very different targets

Initially, we can certainly treat them like that. But eventually, we may need
something more as CC VMs access to storage has to be trusted too and so will
require both HBA and the device to be trusted. For the TDISP handling, I am
however not sure how that should looks like (is it the HBA or the storage device
secrets that are used, both ?). As I said, I have not spent any time yet
thinking about that use case.

-- 
Damien Le Moal
Western Digital Research


