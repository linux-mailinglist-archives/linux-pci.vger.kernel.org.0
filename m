Return-Path: <linux-pci+bounces-33337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7CCB196B3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 00:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66A216D35A
	for <lists+linux-pci@lfdr.de>; Sun,  3 Aug 2025 22:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B97C1FDE39;
	Sun,  3 Aug 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lwgOwQlF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273E1F4612
	for <linux-pci@vger.kernel.org>; Sun,  3 Aug 2025 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754259996; cv=none; b=OLs0v3c1vKwgQOV5xdXGk1PaV7ezxR0qPPvmlgSDcgDsvVQ46Y63sK7uUng3fIEvP4LhBMXwbdJ5i5uMJunZHXTke64ebG55WkMJhxd/IHdAqdcBahQ2UEZVU65loFff9eP7TipfvQ3wkZHIvikOrozTtLk9MDqOwHt6QXCtyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754259996; c=relaxed/simple;
	bh=wYigYoW+lk7ns2aDLy+APsAznDV0ufI5MwSPEED6jao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe+K1nLjm5XI+wSKMzWAJErLLsGSZTtuUiGWNnPm2ftIDt49u0LDucoHWp5G9Zqc0xjPBRwxz76d+CfvpmwCTzczyLggeCFxL9tYkt10am0le+ZZI6eyIa04Puxysj14lecdPN0BYRxGxIR3I2SmeFmhId0RlbNcdm4p09pRLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lwgOwQlF; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso41419766d6.3
        for <linux-pci@vger.kernel.org>; Sun, 03 Aug 2025 15:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754259993; x=1754864793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrQck+uyyPA+7VIUZESXHFEd7viA6waPNZg6g0JA4cA=;
        b=lwgOwQlFpPmF95OrHQp/6wyODYKskSW1tqhhx9dUOEPAO+lZlUgjmJ91fweDlM2kv7
         LDcBmczQY1ocArPENKbhgpxV8M/ZyFQLxEe4QzHQxtcJJjurgT7zPiQba4zSbFVLsVym
         lF+AcLUdKnhJmTXf5ijyqU+Bxhp2TQjn2uLos8am0iF1h8MAgYMaXCn4CHSNIgq6t61e
         aNU1w4YhfAhhURpXMCuBbFQBCXoSyXMHGldCK5A8bLXf/tWN5QdzzPiCRi0OF+d70LHQ
         /qwWEL+IbMsrQ7duXeYKPqfJKeOvGVVEi4jzAlDHpEofAHqKwlyEiZwVgFI2p3CaGv+4
         kPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754259993; x=1754864793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrQck+uyyPA+7VIUZESXHFEd7viA6waPNZg6g0JA4cA=;
        b=gpsdaZYbUkF7ShzvpbCioxcos21Czk7a8Vwe4BkdJEaD3bhZL5TtPZnnwxZMXxsD6q
         D4AgR8MSEwJpDONGGDKh/cduQ2xYzaKRIZXqHpuhFzefKhSwkgfsqfCGwb5H7sAW3KyU
         lUR46Wk798dldkRN5m8Y4Vn1YmZDXbHB21B7Cjvs1DUOC91kSPlifn9Nq4Eobl0zP879
         BrL3JE5L9a6v2mQodlu4n2I1CjYrRjukDT5S1jCGAdTsbrPq7dg8M2dU6JcJOE6nWbj9
         RReYozKTT86v3Eb6CK0+aq9f1OB3nYprHUPHG83oDO4+U2JqUN3E1KZqzWId7qesZ0Bl
         eW9A==
X-Forwarded-Encrypted: i=1; AJvYcCXN21TUqclou4BAM+rM9QWv08Wh/ZRr2PGKSYaFy4ggX71xBiWmqXtFFK8PFE5BcAjx3oIn1JkgWxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWsRvx0Ztyphi8D1l+MnUzW0jiPDe0cIyvZgkJ2yUGtCGyBJxa
	vLKuLT+q9XbZ1Swi5guwgVfGqOVJ/Tn+dhuwfIRiUWtg7nyr7KqWjdSMoObNqcMyWzs=
X-Gm-Gg: ASbGnctTrdNSkT+lzBplrFfWLfFfkaU88F800YXrmf5C0uPdvbk+/Enno2XlsHbUXsI
	4COw9hht/ww802dvrjqiG/QvDHxTLfQyy0aq4884891CheQ+CYAwVPaP6PmcrtjVsacMhwg3AjU
	yqvTfDe0opBr+0GW+5CpGaSra+qfYTr0+YBjF9wzy5m5AMy0Ry2PnP7bOcOyY/euN1Br/NqyrG7
	g6xVg80Hl6DjYrjbQfdquKxcytxLgEZKEsmcQgeD1tQMneqNaVdWcwpMoMGyU0XANWXggSQc1lR
	nvzk4SEWg2GBGY8O2ZMNlbanKXDR2DMh28OVo5irqOqYUEa7LZNPNF4XgMwevYvlDGp0w44+avi
	EI68sPTYq6jfXG/O5C7dBG3y/D8Z0vumqZxSkLUpVOjiiCoFsxzgZjkzUlC7r8b+7tbmv
X-Google-Smtp-Source: AGHT+IGv4aGklrPHBF50+dek/cjwzDyT/bBf0xi3QXvGw0AajwBqgqfxY0gnN3btROPjXI6vYpXBfQ==
X-Received: by 2002:ad4:5aa7:0:b0:704:f7d8:edfb with SMTP id 6a1803df08f44-7093637860dmr112866876d6.48.1754259993233;
        Sun, 03 Aug 2025 15:26:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9da7dcsm49993756d6.12.2025.08.03.15.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 15:26:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uih9z-00000001L1b-49su;
	Sun, 03 Aug 2025 19:26:31 -0300
Date: Sun, 3 Aug 2025 19:26:31 -0300
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
Message-ID: <20250803222631.GN26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <20250801155104.GC26511@ziepe.ca>
 <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>
 <20250802141750.GL26511@ziepe.ca>
 <688ea45a14015_17ee100cf@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <688ea45a14015_17ee100cf@dwillia2-mobl4.notmuch>

On Sat, Aug 02, 2025 at 04:50:50PM -0700, dan.j.williams@intel.com wrote:
> > Do you have some examples? I don't really see what complexity there is
> > if the solution it simply not auto bind any drivers to TDISP capable
> > devices and userspace is responsible to manually bind a driver once it
> > has reached T=1.
> 
> The example I have front of mind (confirmed by 2 vendors) is deferring
> the loading of guest-side device/state security capable firmware to the
> guest driver when the full device is assigned. In that scenario default
> device power-on firmware is capable of link/transport security, enough
> to get the device assigned. Guest needs to get the device/state security
> firmware loaded before TDISP state transitions are possible.

Yeah, those are the only cases I know of too, and IMHO, they are just
early devices. Clearly the clean answer is to put enough boot FW on
the device's flash to get to T=1 mode, then have the trusted OS driver
load the operating firmware from the trusted OS filesystem though the
trusted bootloader T=1 device.

You effectively attest the bootloader, and then if you trust the
bootloader you know that when the device gets to T=1 it can be trusted
to properly run the FW the trusted driver provides.

Think about this more broadly, does the prep FW load idea make sense
for something like SRIOV? No, it really doesn't. The hypervisor loaded
FW that is running the PF should definately be strong enough to get to
T=1 on the VM/VF side as well.

The non-SRIOV cases are quite often whole machine assignment
scenarios. But I'm sensing alot of that space is moving toward bare
metal machines instead of VMs.

I wonder if you can use all the CC machinery to attest and secure a
bare metal host?

> I do think RAS recovery needs it too, but like you say below that should
> come with conditions.

Especially RAS becomes simple because it basically follows the normal
flows that existed prior to TDISP, with the exception of needing some
attestation step.

I don't know alot about CC attestation, but maybe we can have
userspace provide the kernel with the accepted measurement and then
for RAS the kernel can FLR, remeasure and if the measurement is
exactly the same go back into T=1 automatically as part of the PCI
core FLR logic.

> I do think userspace can / must deal with it. Let me come back with
> actual patches and a sample test case. I see a potential path to support
> the above "prep" scenario without the mess of TDISP setup drivers, or
> the ugly complexity of driver toggles or a usermodehelper.

I don't see how, something nasty has to be done in the kernel to allow
an attached driver to switch between T=1 and T=0 "views" of the device
and lockstep those changes with userspace. This is not so simple and
it really basically exactly the same as driver binding.

I don't think we should be afraid of T=0 prep drivers in these early
days.

Something more complex could come later if it is really warranted and
people really insist on continuing this unclean device design
strategy.

> Yeah, that is the nightmare I had last night. I completed the thought
> exercise about driver toggle and said, "whoops, nope, Jason is right, we
> can't design for that without leaving a permanent mess to cleanup".
> The end goal needs to look like straight line typical driver probe path
> for TDISP capable devices.

Yeah, maybe it is worthwhile to someday try to figure out an
alternative - keep in mind that critically this requires someone to
also come with an intree driver that will use all these new APIs and
capabilities!!!

So lets get walking first and then someone can come with some
proposal, complete with a driver implementing it, and it can be
judged. This project is already so big, and I'm pretty sure if you
start to also need entirely new operating modes for drivers the basics
will just get bogged down in that discussion, and very likely killed
anyhow due to a lack of user.

Even if we decide that is prefered it is better to separate it and
discuss it after the basics are merged. At least where I sit getting
basic guest support is a big priority so I strongly want to strip it
down to minimal as possible to make consistent progress steps.

> True. Although, now I am going back on my PCI core burden concern to
> wonder if *it* should handle a vBME on behalf of the driver if only
> because it may want to force the device out of the RUN state on driver
> unbind to meet typical pci_disable_device() expectations.

Hiding some vBME in the PCI core might make sense if we can't get the
VMM owners to agree to do it on the hypervisor side. It works better
on the VMM side because there is always an IOMMU and the VMM can
emulate BME by blocking DMA with the IOMMU.

But I would not allow/expect kernel device drivers to have anything to
do with the TDISP states. Getting into RUN is fully sequenced by
userspace, getting out of run should also be sequenced only by
userspace.

Removing a driver does not change the trust state of the PCI device,
so it shouldn't drop out of RUN. If userspace wishes to FLR the device
after userspace asked to unbind it can, there are already sysfs
controls for this IIRC.

Basically, all this says that Linux drivers that want to be used with
T=1 should be well behaved, fully quite all their DMA on remove, and
have no *functional* need for BME to do anyhting. We pretty much
already expect this of drivers today, so I don't see an issue with
strongly requiring it for T=1.

Keep in mind the flip side, almost no drivers are structured properly
to forcibly quiet any DMA before pci_enable_device(). Some HW, like
mlx5, can't do this at all without either using DMA to send a reset
command or through FLR.

> > I would be comfortable if hitless RAS recovery for TDISP devices
> > requires some kernel opt-in. But also I'm not sure how this should
> > work from a security perspective. Should userspace also have to
> > re-attest before allowing back to RUN? Clearly this is complicated.
> > 
> > Also, I would be comfortable to support this only for devices that do
> > not require pre-configuration.
> 
> That seems reasonable. You want hitless RAS? Give us hitless init.

Yeah.. Realistically there are few drivers that can even do this
today, mlx5 for example has such code (and it is hard!).

There is alot of investment required in the driver's core subsystem to
make this work. netdev and RDMA can support a 'rebirth' sort of flow
where the driver can disconnect the SW APIs, FLR the device, then
reconnect in some way. However, for example, I recently had a
discussion with DRM guys about RAS and they are not even doing the
basic locking/etc to be able to do this. :\

Jason

