Return-Path: <linux-pci+bounces-33300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3ACB18544
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 17:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22D7188AA30
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7FC27AC31;
	Fri,  1 Aug 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FTa4HOPa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1399F27A91F
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063469; cv=none; b=A38LwjzanBTI1xj8Fi+OHAdrYuuBSJRBcX1KcUNBqI2KN7jnxhyv8Bln2TbxTu5zeJjFnzuN29T7j7id8ULLXQ/xslm1rpsloctiNLON8gmGw77zosoXzdVI/bKpEPiMUF2LaK0vKBVsI8ioudMxYorGG+T7Fm3EvKKGPTHPBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063469; c=relaxed/simple;
	bh=RpGOywfowaGN9OsyBA2/LgrnaFIHzI9fYHm6QlHqw2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1QRb2ttlhxktZvnFG9VJSJ4TxW8tsDkrWOEKwdCbUgJmNpCntGKP0c7BLMsKigUEBSoHoJ1AdLNuwMj2YhrChzlM8DQK2YXCdpEmJo/fPldbDhrn1hE3SQ3jP6lN55KRAmuVl60w4WYu76HXIMN+0lkD61FHctegvgPmXtTWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FTa4HOPa; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab82eb3417so24168241cf.2
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 08:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754063467; x=1754668267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3gynLxJTqeTyUkKqh0jIH8V/DuEC4i3JqHA8TCee7s=;
        b=FTa4HOPaAmcytdM3VHYuB0XywqAms82n2swzRONdlt97ztwLx+zoG+dbhgpL2Rzw8Q
         CA5gdtctNFiPp1emGo2dCSdD0DxQk5r9Gl3Dzb842vHty6uVYEr7Bd0qcZKQaV8t5ojf
         EaiqvL6MU2QnHsnoSpkx3N1hmZ/hv7X75cH0ZG335nbKXqz8OUpf5dnaDOxxmxHvhM0i
         bvKl9NRPV8958Lb+32YbRuAG5VAWE+VrYLLpCMN6YHlsj9ya3EM6tctcSj1eopPQvkxI
         lZOGYtO4c2NcXPv1uxAA1eRoeIHni5HBwZ3xfJFU3V8nV/wbBNgzeLNoi75PEGcKt1sK
         r+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754063467; x=1754668267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3gynLxJTqeTyUkKqh0jIH8V/DuEC4i3JqHA8TCee7s=;
        b=C75DzxPI+ae0izubtT1DXd/FjOll3hzzjfDjsmlF/+x1QMWH5jTIvtq+G1UpSzmQcU
         yKNNAsFY1WL8np3SdpFnk8JRAuLFWEBfdQKDM1CdbY/9D4cFmHa6cw1kIG6Rx68KM90q
         YBmBYlb285/2dqn70bQXqtN8V8QVgpGN5tqDbvjvh04VxDQc0hsmJIHqcfPLH5LUer03
         vU3nu7DIgMam377fqd0y/TnL4AXEK/eVydO3QiWLu7QOOfgbQqaxwYbSpnglOzxpCBkO
         saFk1IWJ8MPe+BGvS2YTJv3YrKTlbvziXnfPPm4EWp3Cjd4+U7K+MyqzFmyaGeZPC57R
         5oiA==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZnKpMGyVJ7QYAhmksV/U9i2hRJI4h1Mjm9XbnAYcBMXPuZn7sbR93lhgOycIR5vRZCEqNQTKygA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjKxHETRNvNLBN/ZmNYHRWIBgdKA6Gw86BfDFSO5/6qdaFr56s
	gwZS1ddGG/RIO6CUTkdvubgRTsJJKngDid27fcf8UBRlkP/9Gs9H+NT52k0mCKzVHez7bji6Ibw
	IgxFt
X-Gm-Gg: ASbGncu3Bxu+6P4olXF2BuXiUus1gN/AEM9pLV1YOTSMUp2FtvPc4t40JM1Cd9kRyD/
	lLYwJmu0ljkyIensPwFoQqx3ZF6Zr3EjtHTgeAHCq0tUCzqGWX75hG/dtomHMqTSmLqv3cSyGWJ
	/5BkWeMUuTYpj9jRSau0n8qA6ZDGIH95JDvLHNqOyXD3yPWuJSd+OnXaek/f3zN+BW33xNKiY4u
	QPt+y3nZQAovBdODG6EI8t2bOnzvU3au8hElGcFwQPeIRFb8LLFjHGNKyPtiXl/7/rXorn/7Xu9
	wTObz8zB+fHALtgcoWTQFQ6ifn1abE1C8mqkZosMc2GSBgtNZWxTuer4W93yKSyQ/PVN2emA6Ji
	Nv+1Phcp4RLNuxridp/N74xoIlaSH8tlaOXBF7hNNFQ8CPwetYQCwGnI0OjVyAdSmnEsO
X-Google-Smtp-Source: AGHT+IEyXPyGXUOy8NoNlJS1LStkuChjrlNcwcpgQHWbKJrFB6xXGqddUnimBUGWOittnxJdqJOp0g==
X-Received: by 2002:ac8:5c94:0:b0:4ab:6715:bf48 with SMTP id d75a77b69052e-4af10ac17femr3708001cf.36.1754063466582;
        Fri, 01 Aug 2025 08:51:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e681f2369dsm208619285a.80.2025.08.01.08.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 08:51:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhs2C-000000012nE-3uEu;
	Fri, 01 Aug 2025 12:51:04 -0300
Date: Fri, 1 Aug 2025 12:51:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: dan.j.williams@intel.com
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 00/38] ARM CCA Device Assignment support
Message-ID: <20250801155104.GC26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Jul 31, 2025 at 07:07:17PM -0700, dan.j.williams@intel.com wrote:
> Aneesh Kumar K.V (Arm) wrote:
> > Host:
> > step 1.
> > echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
> > echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
> > echo ${DEVICE} > /sys/bus/pci/drivers_probe
> > 
> > step 2.
> > echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
> 
> Just for my own understanding... presumably there is no ordering
> constraint for ARM CCA between step1 and step2, right? I.e. The connect
> state is independent of the bind state.
> 
> In the v4 PCI/TSM scheme the connect command is now:
> 
> echo $tsm_dev > /sys/bus/pci/devices/$DEVICE/tsm/connect

What does this do on the host? It seems to somehow prep it for VM
assignment? Seems pretty strange this is here in sysfs and not part of
creating the vPCI function in the VM through VFIO and iommufd?

Frankly, I'm nervous about making any uAPI whatsoever for the
hypervisor side at this point. I don't think we have enough of the
solution even in draft format. I'd really like your first merged TSM
series to only have uAPI for the guest side where things are hopefully
closer to complete..

> > step 1:
> > echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
> > 
> > step 2: Move the device to TDISP LOCK state
> > echo 1 > /sys/bus/pci/devices/${DEVICE}/tsm/lock
> 
> Ok, so my stance has recently picked up some nuance here. As Jason
> mentions here:
> 
> http://lore.kernel.org/20250410235008.GC63245@ziepe.ca
> 
> "However it works, it should be done before the driver is probed and
> remain stable for the duration of the driver attachment. From the
> iommu side the correct iommu domain, on the correct IOMMU instance to
> handle the expected traffic should be setup as the DMA API's iommu
> domain."

I think it is not just the dma api, but also the MMIO registers may
move location (form shared to protected IPA space for
example). Meaning any attached driver is completely wrecked.

> I agree with that up until the point where the implication is userspace
> control of the UNLOCKED->LOCKED transition. That transition requires
> enabling bus-mastering (BME), 

Why? That's sad. BME should be controlled by the VM driver not the
TSM, and it should be set only when a VM driver is probed to the RUN
state device?

> and *then* locking the device. That means userspace is blindly
> hoping that the device is in a state where it will remain quiet on the
> bus between BME and LOCKED, and that the previous unbind left the device
> in a state where it is prepared to be locked again.

Yes, but we broadly assume this already in Linux. Drivers assume their
devices are quiet when they are bound the first time, we expect on
unbinding a driver quiets the device before removing.

So broadly I think you can assume that a device with no driver is
quiet regardless of BME.

> 2 potential ways to solve this, but open to other ideas:
> 
> - Userspace only picks the iommu domain context for the device not the
>   lock state. Something like:
> 
>   private > /sys/bus/pci/devices/${DEVICE}/tsm/domain
> 
>   ...where the default is "shared" and from that point the device can
>   not issue DMA until a driver attaches.  Driver controls
>   UNLOCKED->LOCKED->RUN.

What? Gross, no way can we let userspace control such intimate details
of the kernel. The kernel must auto set based on what T=x mode the
device driver binds into.

> - Userspace is not involved in this transition and the dma mapping API
>   is updated to allow a driver to switch the iommu domain at runtime,
>   but only if the device has no outstanding mappings and the transition
>   can only happen from ->probe() context. Driver controls joining
>   secure-world-DMA and UNLOCKED->LOCKED->RUN.

I don't see why it is so complicated. The driver is unbound before it
reaches T=1 so we expect the device to be quiet (bigger problems if
not).  When the PCI core reaches T=1 it tells the DMA API to
reconfigure things for the unbound struct device. Then we bind a
driver as normal.

Driver controls nothing. All existing T=0 drivers "just work" with no
source changes in T=1 mode. DMA API magically hides the bounce
buffering. Surely this should be the baseline target functionality
from a Linux perspective?

So we should not have "driver controls" statements at all. Userspace
prepares the PCI device, driver probes onto a T=1 environment and just
works.

> > step 3: Moves the device to TDISP RUN state
> > echo 1 > /sys/bus/pci/devices/${DEVICE}/tsm/accept
> 
> This has the same concern from me about userspace being in control of
> BME. It feels like a departure from typical expectations.  

It is, it is architecturally broken for BME to be controlled by the
TSM. BME is controlled by the guest OS driver only.

IMHO if this is a real worry (and I don't think it is) then the right
answer is for physical BME to be set on during locking, but VIRTUAL
BME is left off. Virtual BME is created by the hypervisor/tsm by
telling the IOMMU to block DMA.

The Guest OS should not participate in this broken design, the
hypervisor can set pBME automatically when the lock request comes in,
and the quality of vBME emulation is left up to the implementation,
but the implementation must provide at least a NOP vBME once locked.

> Now, the nice thing about the scheme as proposed in this set is that
> userspace has all the time in the world between "lock" and "accept" to
> talk to a verifier.

Seems right to me. There should be NO trusted kernel driver bound
until the verifier accepts the attestation. Anything else allows un
accepted devices to attack the kernel drivers. Few kernel drivers
today distrust their HW interfaces as hostile actors and security
defend against them. Therefore we should be very reluctant to bind
drivers to anything..

Arguably a CC secure kernel should have an allow list of audited
secure drivers that can autoprobe and all other drivers must be
approved by userspace in some way, either through T=1 and attestation
or some customer-aware risk assumption.

From that principal the kernel should NOT auto probe drivers to T=0
devices that can be made T=1. Userspace should handle attaching HW to
such devices, and userspace can sequence whatever is required,
including the attestation and verifying.

Otherwise, if you say, have a TDISP capable mlx5 device and boot up
the cVM in a comporomised host the host can probably completely hack
your cVM by exploiting the mlx5 drivers's total trust in the HW
interface while running in T=0 mode.

You must attest it and switch to T=1 before binding any driver if you
care about mitigating this risk.

> With the driver in control there would need to be something like a
> usermodehelper to notify userspace that the device is in the locked
> state and to go ahead and run the attestation while the driver waits*.

It doesn't make sense to require modification to all existing drivers
in Linux! The starting point must have the core code do this sequence
for every driver. Once that is working we can talk about if other
flows are needed.

> > step 4: Load the driver again.
> > echo ${DEVICE} > /sys/bus/pci/drivers_probe
> 
> TIL drivers_probe
> 
> Maybe want to recommend:
> 
> echo ${DEVICE} > /sys/bus/pci/drivers/${DRIVER}/bind
>
> ...to users just in case there are multiple drivers loaded for the
> device for the "shared" vs "private" case?

Generic userspace will have a hard time to know what the driver names
are..

The driver_probe option looks good to me as the default.

I'm not sure how generic code can handle "multiple drivers".. Most
devices will be able to work just fine with T=0 mode with bounce
buffers so we should generally not encourage people to make completely
different drivers for T=0/T=1 mode.

I think what is needed is some way for userspace to trigger the
"locking configuration" you mentioned, that may need a special driver,
but ONLY if the userspace is sequencing the device to T=1 mode. Not
sure how to make that generic, but I think so long as userspace is
explicitly controlling driver binding we can punt on that solution to
the userspace project :)

The real nastyness is RAS - what do you do when the device falls out
of RUN, the kernel driver should pretty much explode. But lots of
people would like the kernel driver to stay alive and somehow we FLR,
re-attest and "resume" the kernel driver without allowing any T=0
risks. For instance you can keep your netdev and just see a lot of
lost packets while the driver thrashes.

But I think we can start with the idea that such RAS failures have to
reload the driver too and work on improvements. Realistically few
drivers have the sort of RAS features to consume this anyhow and maybe
we introduce some "enhanced" driver mode to opt-into down the road.

Jason

