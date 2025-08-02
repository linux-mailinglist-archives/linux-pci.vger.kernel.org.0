Return-Path: <linux-pci+bounces-33332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60561B18F17
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 16:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFD0AA48A6
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B45723957D;
	Sat,  2 Aug 2025 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M7AKg10Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90504199223
	for <linux-pci@vger.kernel.org>; Sat,  2 Aug 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754144274; cv=none; b=hGMRXIECKb44FAQtlXQ1nIInD7AIZTH+bCCJJIptE2D5Wua3nXgcpLiZn26dxb/UIq8WtGLyvgAhLKiB2hWbM8zAAeUwNiTlBw5iq/0S/0B5oa86g7ArQ/sQRT09cPIRSyQt+U6V9q6QHeTSHZrQjiYph0IRaWheEn5/r+ZGmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754144274; c=relaxed/simple;
	bh=FQ39B9jERPUAW3pWSgAAeA1QG0tXEiueP0zJxCjCnZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1EVo9k4T/tWpKOp+oVIoOSAvChuZ+Fs2APOmiIMxzbhYL6PC4J/jU/VLYlqpwNYekpQrPb1dxyz/oei+rIud0U8QDTs+ecVKO+j02TwBS5RhQQKJdqUkAqnuG0sGGZ3orry4WPB+dBqQPBAMb3Ywbq1UBmT3xsHH9h5Q0k2OJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M7AKg10Q; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e34493ecb4so205893885a.1
        for <linux-pci@vger.kernel.org>; Sat, 02 Aug 2025 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754144271; x=1754749071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XAht3BlYnywuDydAQFgQqb1h2JGOGBLyurA+IzlOJa4=;
        b=M7AKg10Q1tOBYnNb2uxAK4ffI5vKMUd6RvghGQZGCGrjBkk5h4rT4TFTkRmcBzd+Ka
         suuYTRmyYA6amkQzUnJLi8T77RiGMSs7Maou9KfSRSbK+i/XfszVxRIWqVWZl0nLmYkW
         wsoSOvGiyWHUs8koYze3rBeR7kuJZ2szUhpVq4hRz0pJoVbMi4WTwBr0+o4iXBYcuPKX
         NTdBPYyvFAVWB9y4/aoZrDhkN6Klsb1ey5zXxjcIiRgwwi02lWtKWIjImBxKQiXFlMOZ
         QKlJuyR9n4DQo5ISIQcEn1Uahvb4jAm0slD2hGnYKHeo1AT2VXJicQMxYIpWIERnhQAk
         U7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754144271; x=1754749071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAht3BlYnywuDydAQFgQqb1h2JGOGBLyurA+IzlOJa4=;
        b=wJ7IqiwzpEJj8NHemTZdn3oi6HbbR4hQZdG0XlmCBft3YHnE/4LWezaXM0DNxFu2Ld
         2NxiD6e2fa8UwBx1gA8KtEaTjd9+k/LTLgwLso12TM/sXNEjErqyAugCvRz10d0RLAoC
         A8fZ4/6pToLKF8VeuzypH/0QjCJpKioXpoCG+c5VlBsFKXyHzYqQUc38FdpDQSBuGTie
         siZAAAiLnnMYHvSYQlXZaETUxM2TeDZlqf0z16hbVUR56raFBZrEmKJsUZUEbhr6DK6U
         dFNOQ8GjadivUpQmqsO3D/Oo2rcN9SwWiJLk1TQsMfoz12fXzACOK0+qdd2JTTX1FbNq
         URIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUusH/PB5CDGYuoxaHuV2+44O1TToKzxsiGUIm3rOPob9Mb6uXGW/zFJQGr1bV67t2Oevfnm8OHJ/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVfw9af4wO4AV+FYdXo64QeWVMIXXDVroH3lsKVm8boxP8IgI
	WcKr5KduK268p9qHBcUzFvbKzcBJlr0+sIiOzPHYn5i4nyPQVfj80NRCEeM7yoYdkhw=
X-Gm-Gg: ASbGncvrYGNAJ02e9JFTtcFnKm1xsBsXgTkXhrDg2J9wURmHaUKSj76Qqp46KxyW11I
	k7IAjbG3mwCQCAjUKZxZGQ7TSNKKi0yiiu23mjLfUIod6AYYIZaSRMR2XPBbPRZZXoKvTwUUImA
	Boiwhn6fZDuX7LpzFQ241sMgglrlLuOdLE/NMY5nAHfCfP26AjufOQD4jrHMCAH+7YO3VYbkgSW
	x8mcQk8Ui530P7P5PriMEdk4veEFPrB7w9t5/zSeKw2KYNqceIQRE/L6sxNCyhQgER37SwwdfHB
	k+aBd18CIITEZVPc7hFVxcPjiMyXs91KWgHCDbfKw9UaqqZunF9EHGl+nR1gtYUfI1sMw/+6wE3
	PnTQiaE9SB3k8kCTYOHhjNq0ahOztlAf1Q9/8/vJ2Gn0XpqiagfYbbEibgu44lqqLh1X3
X-Google-Smtp-Source: AGHT+IGdPAmPi73Qx9Dpc4yn7AJ3AWkRwpu/Z2rB1pE3w5ZLbSl1DPKWIHYygsiQ4vWMpbzVE9HS0A==
X-Received: by 2002:a05:620a:1645:b0:7e3:39c2:9856 with SMTP id af79cd13be357-7e696268352mr406724785a.1.1754144271303;
        Sat, 02 Aug 2025 07:17:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e681c8c727sm313508585a.78.2025.08.02.07.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 07:17:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uiD3W-00000001AEi-0hrF;
	Sat, 02 Aug 2025 11:17:50 -0300
Date: Sat, 2 Aug 2025 11:17:50 -0300
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
Message-ID: <20250802141750.GL26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <688c2155849a2_cff99100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <20250801155104.GC26511@ziepe.ca>
 <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <688d2f7ac39ce_cff9910024@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Aug 01, 2025 at 02:19:54PM -0700, dan.j.williams@intel.com wrote:

> On the host this establishes an SPDM session and sets up link encryption
> (IDE) with the physical device. Leave VMs out of the picture, this
> capability in isolation is a useful property. It addresses the similar
> threat model that Intel Total Memory Encryption (TME) or AMD Secure
> Memory Encryption (SME) go after, i.e. interposer on a physical link
> capturing data in flight. 

Okay, maybe connect is not an intuitive name for opening IDE
sessions..

> I started this project with "all existing T=0 drivers 'just work'" as a
> goal and a virtue. I have been begrudgingly pulled away from it from the
> slow drip of complexity it appears to push into the PCI core.

Do you have some examples? I don't really see what complexity there is
if the solution it simply not auto bind any drivers to TDISP capable
devices and userspace is responsible to manually bind a driver once it
has reached T=1.

This seems like the minimum possible simplicitly for the kernel as
simply everything is managed by userspace, and there is really no
special kernel behavior beyond switching the DMA API of an unbound
driver on the T=0/1 change.

> The concern is neither userspace nor the PCI core have everything it
> needs to get the device to T=1. 

Disagree, I think userspace can have everything. It may need some
per-device userspace support in difficult cases, but userspace can
deal with it..

> PCI core knows that the device is T=1 capable, but does not know how
> to preconfigure the device-specific lock state,

Userspace can do this. Can we define exactly what is needed to do this
"pre-configure the device specific lock state"? At the very worst, for
the most poorly designed device, userspace would have to bind a T=0
driver and then unbind it.

Again, I am trying to make something simple for the kernel that gets
us to a working solution before we jump ahead to far more complex in
the kernel models, like aware drivers that can toggle themselves
between T=0/1.

> Userspace might be able to bind a new driver that leaves the device in a
> lockable state on unbind, but that is not "just works" that is,

I wouldn't have the kernel leave the device in the locked state. That
should always be userspace. The special driver may do whatever special
setup is needed, then unbind and leave a normal unlocked device
"prepped" for userspace locking without doing a FLR or
something. Realistically I expect this to be a very rare requirement,
I think this coming up just reflects the HW immaturity of some early
TDISP devices.

Sensible mature devices should have no need of a pre-locking step. I
think we should design toward that goal as the stable future and only
try to enable a hacky work around for the problematic early devices. I
certainly am not keen on seeing significant permanent kernel
complexity to support this device design defect.

> driver that expects the device arrives already running. Also, that main
> driver needs to be careful not to trigger typically benign actions like
> touch the command register to trip the device into ERROR state, or any
> device-specific actions that trip ERROR state but would otherwise be
> benign outside of TDISP."

As I said below, I disagree with this. You can't touch the *physical*
command register but the cVM can certainly touch the *virtualized*
command register. It up to the VMM To ensure this doesn't cause the
device to fall out of RUN as part of virtualization.

I'd also say that the VMM should be responsible to set pBME=1 even if
vBME=0? Shouldn't it? That simplifies even more things for the guest.

> > From that principal the kernel should NOT auto probe drivers to T=0
> > devices that can be made T=1. Userspace should handle attaching HW to
> > such devices, and userspace can sequence whatever is required,
> > including the attestation and verifying.
> 
> Agree, for PCI it would be simple to set a no-auto-probe policy for T=1
> capable devices.

So then it is just a question of what does a userspace component need
to do.

> I do not want to burden the PCI core with TDISP compatibility hacks and
> workarounds if it turns out only a small handful of devices ever deploy
> a first generation TDISP Device Security Manager (DSM). L1 aiding L2, or
> TDISP simplicity improvements to allow the PCI core to handle this in a
> non-broken way, are what I expect if secure device assignment takes off.

Same feeling about pre-configuration :)

> > The starting point must have the core code do this sequence
> > for every driver. Once that is working we can talk about if other
> > flows are needed.
> 
> Do you agree that "device-specific-prep+lock" is the problem to solve?

Not "the" problem, but an design issue we need to accommodate but not
endorse.

> > But I think we can start with the idea that such RAS failures have to
> > reload the driver too and work on improvements. Realistically few
> > drivers have the sort of RAS features to consume this anyhow and maybe
> > we introduce some "enhanced" driver mode to opt-into down the road.
> 
> Hmm, having trouble not reading that back supporting my argument above:
> 
> Realistically few devices support TDISP lets require enhanced drivers to
> opt-into TDISP for the time being.

I would be comfortable if hitless RAS recovery for TDISP devices
requires some kernel opt-in. But also I'm not sure how this should
work from a security perspective. Should userspace also have to
re-attest before allowing back to RUN? Clearly this is complicated.

Also, I would be comfortable to support this only for devices that do
not require pre-configuration.

Jason

