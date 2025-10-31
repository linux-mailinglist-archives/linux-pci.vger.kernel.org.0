Return-Path: <linux-pci+bounces-39876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 508B7C22C3C
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 01:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EC624E36B0
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 00:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D731A2E401;
	Fri, 31 Oct 2025 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cR1N+OpS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218F2AE77
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 00:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761869241; cv=none; b=OM0CRgJyVD60H1fq3qUxnzfn+jnK/2p3bisyTD10vSWWgElvM9Q1HCyZc2s6UbyKoc8h6yXiByWuI+ocHoi4fie84eyzGu8ygv0ZXAukO+FwpNpmgX/7+viPUBYfRkxACrWNFkEtAWWqZUPChOiwWX9xuMGsvQU1K52IuJSAjSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761869241; c=relaxed/simple;
	bh=rGYe5yjMqWmwR+Rx3bwQkg6QzWBsMmU301TBlTItHbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/ML+jvtGyIGgmg4LneBlFeJzQxy2v15eGm3Emi1MH/e/eCrx6F0MOn7R9htnAlBJPKIXlPKKTd9Xdt828iV3KF8afrvIddU8ObE7GsCL4FCyvLZRpJ9cUmRhYNV0uFQdgivC+A0eh2ByYXDWhu6h4s+6YwVKjWMRiaRtMXJCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cR1N+OpS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-586883eb9fbso2165573e87.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 17:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761869238; x=1762474038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmcJ0gQt/4pCFYZHqsOZ/9fiYMntoegxT4AsogqqgxI=;
        b=cR1N+OpSKhnaUqB0cxyIpRKFqhUcBNeYE1uNDyywppCyPdAiIDfVK+DN/WnZdsDjl6
         tXIfmOqoT636yHm297Tarjqr7NePfDrTkeNDXNFwrg3SuPWKGQL4TTZPRXbVAoAghA/z
         NAqz9GkHVK1c0fHfZzOaqD5E3CC/0Hm5eh3Gqtjql/r1fxZKYltUh9fVhcavgZua8Lpc
         faTNtMW64S9s/Ep9SSWHyWloDyYJP2EWHYxNMrwAq3SuJFXE61H+7f3pNnW0tF3t5s33
         VWlkaMP2LN+VdunYydJPivyGTq19Vv08CHOFejtu+wuJZ8jowGVLqlJMAEW8wWrgt6+P
         L/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761869238; x=1762474038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmcJ0gQt/4pCFYZHqsOZ/9fiYMntoegxT4AsogqqgxI=;
        b=O3z/fd+0P1L9p4eCZXldFnkrUt/guNXuK5/0TTKvJR1IT+y69hAWbPjsUHBAbYybmO
         LHaAf9UlN5bL4aoJNgc4UblSwFgLOEVpbPsD3M5X1PVsJ+cp5mJEowARCbBNl7UU6Gy/
         ANbKqutMk4w/82yvXDgH9uqLWuj+1zJinGCndrM7oTxOJhH+MlAqS27NU3ijjtHVTEkx
         29ct/0QeDnZeuOVHUdcHZtX/mSq94kamqTZ4+mVrg3w+V4oDS4UxqB5xRRyPUIjnI7ra
         jjlqDXVeeXtv5j66o6sIwAiq9iUHrki4jQH4SHyql/BJkRUj2bnVdqhqDk8dRuJG/8NZ
         39Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUfmBh0bTPit9aaFc6apHn1cU7xhSEAdMBOZF1M+5XiO9A3tWZr+etk93YKZa9PiWJJH8CPrBuE8zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQ5O0k34L9ZShCdmlf8Plm4ZGsQV8ly4/IOiYqj9MrBs5DjZ/
	Bq1vC8q1oLQbujeuuyjfJ3clog9WkN/gixVtuKY3UInRUvLOQECygScB3XcpZBHFMvISTWtLl5Q
	qT/VDw66+afjiIzSI0inYBHtw32ou4kNJGIJfzm8T
X-Gm-Gg: ASbGncuYyTVWMiBd/lWUYUiH+2NPS9kV1mp5YqzG8Jyc92wD0fAePmUCbg2qliQqG1O
	E3BSYXMVP4jD5ELglE7E6vEDPcQ17Vddxq7lPsW8W7TJ+j6xa/Mosn8Mk27/+uEYc1TYQ4rYs5H
	CMgirSsbA0sdkpUZQaRat9R67xxS19M7X0sLkPvG0fb+106xihdx2c6hNDrtl8fbdb4D3hhh4k3
	QziXUinFCY7hiu1WV0+wNDqukEha0VHPWzD1kFVZsEbD7dIGjdfx22a0pMp2sgS6CeOrCWxfebt
	PBJGfg==
X-Google-Smtp-Source: AGHT+IGpSBRowIBw9czJoVeMZr9H9pjBQVUhqQijMhY/2cscmjLpJGHSTZmm55OV1QXgaD7LcghLgUjQ0e4dM+E9He0=
X-Received: by 2002:a05:6512:401e:b0:593:f29d:786e with SMTP id
 2adb3069b0e04-5941d5335c0mr554266e87.33.1761869237738; Thu, 30 Oct 2025
 17:07:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de> <20251018223620.GD1034710.vipinsh@google.com>
 <aPSeF_QiUWnhKIma@wunner.de> <aQP6-49_FeB2nNEm@google.com>
In-Reply-To: <aQP6-49_FeB2nNEm@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 30 Oct 2025 17:06:49 -0700
X-Gm-Features: AWmQ_bmRHrPwuytRU-oUtcv_mAPxEXlUmanD5v3yODN3rFDHRS7aA8xmVxSdYMk
Message-ID: <CALzav=ci-CrUgH6Kjcm6eTRB0LCYgjds3Wnun7dsG6dWBe7i+w@mail.gmail.com>
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
To: Lukas Wunner <lukas@wunner.de>
Cc: Vipin Sharma <vipinsh@google.com>, bhelgaas@google.com, alex.williamson@redhat.com, 
	pasha.tatashin@soleen.com, jgg@ziepe.ca, graf@amazon.com, pratyush@kernel.org, 
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org, 
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:55=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-10-19 10:15 AM, Lukas Wunner wrote:
> > On Sat, Oct 18, 2025 at 03:36:20PM -0700, Vipin Sharma wrote:
> > > On 2025-10-18 09:17:33, Lukas Wunner wrote:
> > > > On Fri, Oct 17, 2025 at 05:07:07PM -0700, Vipin Sharma wrote:
> > > > > Move struct pci_saved_state{} and struct pci_cap_saved_data{} to
> > > > > linux/pci.h so that they are available to code outside of the PCI=
 core.
> > > > >
> > > > > These structs will be used in subsequent commits to serialize and
> > > > > deserialize PCI state across Live Update.
> > > >
> > > > That's not sufficient as a justification to make these public in my=
 view.
> > > >
> > > > There are already pci_store_saved_state() and pci_load_saved_state(=
)
> > > > helpers to serialize PCI state.  Why do you need anything more?
> > > > (Honest question.)
> > >
> > > In LUO ecosystem, currently,  we do not have a solid solution to do
> > > proper serialization/deserialization of structs along with versioning
> > > between different kernel versions. This work is still being discussed=
.
> > >
> > > Here, I created separate structs (exactly same as the original one) t=
o
> > > have little bit control on what gets saved in serialized state and
> > > correctly gets deserialized after kexec.
> > >
> > > For example, if I am using existing structs and not creating my own
> > > structs then I cannot just do a blind memcpy() between whole of the P=
CI state
> > > prior to kexec to PCI state after the kexec. In the new kernel
> > > layout might have changed like addition or removal of a field.
> >
> > The last time we changed those structs was in 2013 by fd0f7f73ca96.
> > So changes are extremely rare.
> >
> > What could change in theory is the layout of the individual
> > capabilities (the data[] in struct pci_cap_saved_data).
> > E.g. maybe we decide that we need to save an additional register.
> > But that's also rare.  Normally we add all the mutable registers
> > when a new capability is supported and have no need to amend that
> > afterwards.
>
> Yeah that has me worried. A totally innocuous commit that adds, removes,
> or reorders a register stashed in data[] could lead a broken device when
> VFIO does pci_restore_state() after a Live Update.
>
> Turing pci_save_state into an actual ABI would require adding the
> registers into the save state probably, rather than assuming their
> order.
>
> But... I wonder if we truly need to preserve the PCI save state
> across Live Update.
>
> Based on this comment in drivers/vfio/pci/vfio_pci_core.c, the PCI
> save/restore stuff in VFIO is for cleaning up devices that do not
> support resets:

Err, no, I misread that comment. But I guess my question still stands
whether we truly need to preserve the pci_save_state across Live
Update. Maybe there is a simpler way for VFIO to clean up the device
in vfio_pci_core_disable() if we make certain restrictions on which
devices we support.

