Return-Path: <linux-pci+bounces-13507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5E59855C5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 10:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A9A28426A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 08:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D915B0E1;
	Wed, 25 Sep 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHFDkqBu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1B15AAC6
	for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253868; cv=none; b=ZLH01/4Qt0cajeF0uvcuBOCF12tF7mPh46XG5EAzfrGebUfv4Z7m5nJe7M9zG1yQBQCnOtlrZArXrYARt2EoOjzSqFEePgQOcIKOrwss6+k8EnA9WefsRG/JLKR+fYah74y3xC8G40qssrvmHq/AoCy5f1Lpvi4VxHp5MwpNxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253868; c=relaxed/simple;
	bh=fp5Mf7idLBODRJmfv1T3S/u+ul+mXmM0kO3BnThv8HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5+2rq6+rHJ0hYj1PCjDx1tZ4swlj0arg54GmRS06HmfiZggx+76oSppwD+mV4bGVdSxcatRNhWPx+8NiOVS1iTrGGU3cmqCDxNBEAulmnGOFtyet1HTjD/Liz1lAVOZkaeqbZRrweVdXbRQwvWwBKfSeEpdxpoEuOxv8dzdF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHFDkqBu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c71f2311f5so12791a12.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 01:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727253865; x=1727858665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp5Mf7idLBODRJmfv1T3S/u+ul+mXmM0kO3BnThv8HA=;
        b=eHFDkqBueOcIZLN8FyF9nfIlzluiOtMzOnkItvV7KnXYEQyMk1YXcX1I8keXjz2JTO
         f3N6MQA4ycMgKkAPuWLDr2W1uljonPPEMq1W/s8R48c/rQZqblYXlQeaZxSyyCe+GWOg
         P4fTEJyGyGQJHAqLJnHMz8b0bF9RuvnF3G6h1/suG0KSCnH3qUjbYNlU3adrnUus6LL3
         RD+AJipBna+OinSEJJibddtR2wFjH0V/ql2VSQRcxeKQrhgsGfmYOcWglehLWJJai/mj
         u4fwSXYmo/1zvR0Ovpmcnkmv4amR9FT/QZYMKigI7b0egU+kOoM2s7k+TqWCq/hZbSEJ
         Uy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727253865; x=1727858665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp5Mf7idLBODRJmfv1T3S/u+ul+mXmM0kO3BnThv8HA=;
        b=fNq9OZ1ZnBXphuOCbSq0TNQYZJTLo2+B7fDdvIUwHCd55NeqvD+SrFzVPwJf019jw0
         bKc9Dun1wrQMvmRF5spJKbgneduia/coHrPaIEckRXX/EmND5zvNnDYDyqG1vATnAx3o
         Doq3pEwIND6SoGKSnAI2U1q4MafphnJzdpZpu7nOvyfAYBkaQX9zb/NMp3vLdSGlDsuD
         XWPOu+xXBasEeZSwsF+EbOe1SZxAxis+W4Ayz/yHjuG+v9TuOfnRJCWCAOCxTXQV1l+7
         nF5bWetodZwqkKPISxN3UuHjTnWLexGFK+GmRM3+xacBqdyE9jV+eBaWeEdgRv6arEJO
         jCGg==
X-Forwarded-Encrypted: i=1; AJvYcCWm1kzDT6KBsXV9ejxkiHkqAl7JtZTAK7lJ/8EaRfAl0SKWgDqWiPuL9wjPiQhy1BRGtBVYXPnY4RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTo9Gify4FoRZRksL4ZkYznJ2RrQz9lH39XO/AD6cJHLFiz0eo
	o9Suxb1yxR/UJMCZnFUG+NF8YbRwAhacZV/lG6FpyQPtF9B5fzQrVjHuBWdh/Lb7Lk3WBsuf3zd
	Aff0M+Kj9DelxRKHR++CJarCu/lOI0EuO+Kix
X-Google-Smtp-Source: AGHT+IHKRTDGK6cO+UR0DQQih7mccHmFaGUU/bQ5I0XVaFXESymT4q9yT3f6r4WgiGSRT/MGKTkDivZYIrZJfRkqMX4=
X-Received: by 2002:a05:6402:520b:b0:5c5:b8fe:d1ec with SMTP id
 4fb4d7f45d1cf-5c720fc0a58mr263957a12.3.1727253865144; Wed, 25 Sep 2024
 01:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823132137.336874-1-aik@amd.com> <20240823132137.336874-13-aik@amd.com>
 <ZudMoBkGCi/dTKVo@nvidia.com> <CAGtprH8C4MQwVTFPBMbFWyW4BrK8-mDqjJn-UUFbFhw4w23f3A@mail.gmail.com>
 <BN9PR11MB527608E3B8B354502F22DFCA8C6F2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CAGtprH-bj_+1k-jwEVS9PcAmCOvo72Vec3VVKvL1te7T8R1ooQ@mail.gmail.com>
 <BL1PR11MB5271327169B23A60D66965F38C6F2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20240923160239.GD9417@nvidia.com> <BN9PR11MB527605EA6D4DB0C8A4D4AFD78C6F2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240924120735.GI9417@nvidia.com>
In-Reply-To: <20240924120735.GI9417@nvidia.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 25 Sep 2024 10:44:12 +0200
Message-ID: <CAGtprH__2qLkwu-FvKEECVDn=sek42rVLWHuin9cwSbYVAOi=w@mail.gmail.com>
Subject: Re: [RFC PATCH 12/21] KVM: IOMMUFD: MEMFD: Map private pages
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Alexey Kardashevskiy <aik@amd.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Alex Williamson <alex.williamson@redhat.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>, "michael.day@amd.com" <michael.day@amd.com>, 
	"david.kaplan@amd.com" <david.kaplan@amd.com>, "dhaval.giani@amd.com" <dhaval.giani@amd.com>, 
	Santosh Shukla <santosh.shukla@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Alexander Graf <agraf@suse.de>, Nikunj A Dadhania <nikunj@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 2:07=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Sep 23, 2024 at 11:52:19PM +0000, Tian, Kevin wrote:
> > > IMHO we should try to do as best we can here, and the ideal interface
> > > would be a notifier to switch the shared/private pages in some portio=
n
> > > of the guestmemfd. With the idea that iommufd could perhaps do it
> > > atomically.
> >
> > yes atomic replacement is necessary here, as there might be in-fly
> > DMAs to pages adjacent to the one being converted in the same
> > 1G hunk. Unmap/remap could potentially break it.
>
> Yeah.. This integration is going to be much more complicated than I
> originally thought about. It will need the generic pt stuff as the
> hitless page table manipulations we are contemplating here are pretty
> complex.
>
> Jason

 To ensure that I understand your concern properly, the complexity of
handling hitless page manipulations is because guests can convert
memory at smaller granularity than the physical page size used by the
host software. Complexity remains the same irrespective of whether
kvm/guest_memfd is notifying iommu driver to unmap converted ranges or
if its userspace notifying iommu driver.

