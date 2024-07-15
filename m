Return-Path: <linux-pci+bounces-10334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B49B2931D94
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 01:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C601C212A5
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAEE13E88B;
	Mon, 15 Jul 2024 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5QUAVm9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6822626;
	Mon, 15 Jul 2024 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086021; cv=none; b=WPtRZwMJRoL4i18DjvjGQaVNZm0oYv1QEaLbxvaz5a+flwOthCSMRQXbjUG85q1tmN9rJJ20ynHIqMEGvsBRilupR6EQ0+d+rmfWKPgCzNF3AIPsR268M+hFXds1eaadoz7zxyaxn2NsJZBRUsPNLTxR9RuiEYR03w1Opv0rFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086021; c=relaxed/simple;
	bh=nv6hFOXVDJmU18/Y4pmTtQz2bbEI62pxcVOChF+3FZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hn+nOANhk7+RpvR0rWMVZGmvy/8/FCkdfzI7AHOcpqwfbl7UAMN+m2rTFnL54wp6Z2+6XZQaSj3rYSHmHKZt3dHNEbuqahpP5ddAPI2hIBsR6lXICae9OYacgI1NdAr4Y3+uQ107MaNj1yst6jGEYpQK9VmWS2zycU89dHf9bts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5QUAVm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0284BC32782;
	Mon, 15 Jul 2024 23:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721086020;
	bh=nv6hFOXVDJmU18/Y4pmTtQz2bbEI62pxcVOChF+3FZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g5QUAVm9YOcy7Cy5uZ/7QQDR1Ve8+26+s88WF8f6jbBUwvN+jRUGAEmkZoplkGDPI
	 kL9E9Rm/NYJxBs91JnnGK6Lta0ULTkmoeXDLF2m8NXzOPjDHpVeOalAzL/Y0GucTxD
	 YVMDRWy5FAtcmIEsY5xO6IlW68dp2LM0OEnp2uWutmF8XevptkIb9U/jRdxcNkRumw
	 6rE3drOlF9zAM3zSPoBtdk6MvDKnDGW46ukCXZUvWPSqYRh4mHkxXUGxVbiOBpB+oY
	 3yloiYMLIIrLo1iPM8zzkl+GTjL8rSzF3jCft7/aOWiN5ICkf7m+XumpPJw6ysWbuc
	 kXhIBdBPhAnYQ==
Message-ID: <f228526a-984f-4754-8ade-3f998a8b436a@kernel.org>
Date: Tue, 16 Jul 2024 08:26:55 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240715230333.GX1482543@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/24 08:03, Jason Gunthorpe wrote:
> On Tue, Jul 16, 2024 at 07:17:55AM +0900, Damien Le Moal wrote:
> 
>> Of note though is that in the case of SCSI/ATA storage, the device
>> (the HDD or SSD) is not the one doing DMA directly to the host/guest
>> memory. That is the adapter (the HBA). So we could ask ourselves if
>> it makes sense to authenticate storage devices without the HBA being
>> authenticated first.
> 
> For sure, you have to have all parts of the equation
> authenticated before you can turn on access to trusted memory.
> 
> Is there some way these non DOE messages channel bind the attestation
> they return to the PCI TDISP encryption keys?

For the scsi/ata case, at least initially, I think the use case will be only
device authentication to ensure that the storage device is genuine (not
counterfeit), has a good FW, and has not been tempered with and not the
confidential VM case.

> What is the sequence you are after?

The above as a first use case. For the confidential VM case, I think the HBA
needs to be involved as that is the one doing the DMA. But to be frank, I have
not spent time thinking about that use case at all.

>> And for PCI nvme devices that can support SPDM either through either
>> PCI DOE or SPDM-over-storage (SECURITY SEND/RECV commands), then I
>> guess we need some special handling/config to allow (or not)
>> SPDM-over-storage authentication as that will require the device
>> driver to be loaded and to execute some commands before
>> authentication can happen.
> 
> I'm not sure those commands make sense in a PCI context? They make
> more sense to me in a NVMe over Network scenario where you could have
> the attestation bind a TLS secret..

100% agree, but I can foresee PCI NVMe device vendors adding SPDM support
"cheaply" using these commands since that can be implemented as a FW change
while adding DOE would be a controller HW change... So at least initially, it
may be safer to simply not support the NVMe SPDM-over-storage case, or at least
not support it for trusted platform/confidential VMs and only allow it for
storage authentication (in addition to the usual encryption, OPAL locking etc).

> Still, my remarks from before stand, it looks like it is going to be
> complex to flip a device from non-trusted to trusted.

Indeed, and we may need to have different ways of doing that given the different
transport and use cases.

-- 
Damien Le Moal
Western Digital Research


