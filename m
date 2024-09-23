Return-Path: <linux-pci+bounces-13349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B160297E60C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 08:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D8C1C206A5
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 06:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADA217996;
	Mon, 23 Sep 2024 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtlOF5Aj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B4EAF6
	for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727073259; cv=none; b=hexscqbh8iJZTsphuwbm8IDtECE7N0tle+xeygbXj3a/R2K4npWjE2qSr04vVMXLDzokCh9KQpigET17xctXF7rey3eN7oS2LrJAqocQjT6qIO2rU6QOLWpqJSVWJoYP+vuA/61Kg5BHfkXY5IS2nm2mQnTfFML5BjxoeIMjcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727073259; c=relaxed/simple;
	bh=Xud0Bj40lmgGEoTZDAPWyWJLudpfWg/JlILBKYnl8wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3gfeH606mztCQNw8E2e3/ts9bhcRPh32upbYiVKqf86orbKkMhRyi87VNYJ3rU2MsDf99yeJNsg2RvzmgbltzDD+QpwNKTOtFa4MKJBmP53NlMktZ2S3uyrLxXumEd30WksKl7O6qQatFST6UP8prTNLFfSdgm2kNNahZ9+rFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KtlOF5Aj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5356a2460ceso16498e87.0
        for <linux-pci@vger.kernel.org>; Sun, 22 Sep 2024 23:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727073256; x=1727678056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xud0Bj40lmgGEoTZDAPWyWJLudpfWg/JlILBKYnl8wU=;
        b=KtlOF5Ajckwkg6VamADcog/KUzCgb5vH2UhqC4cYsOh18dVn7t2WMHznwAAcsdk12E
         Nl88lkP+12GEgpi50C+bBRE+DHA32pvJTo/GQ827mlb9zAunQaPv+/oqxu9xucXOExRB
         mLR2dUsimiEpijMWQd3GNIQEiDpMeuRqMWyjf/1xPllCWnUsbF8jmmCDcRrD64nQ/RhE
         m7B6DvaMCpcvhIq9bzcKpbyVuhzsoMfXaqLlOf+Hdc6iZUQOGM8QBrk4ny8GiH6gPbS/
         mMbUiVvm7IkpnkWlnssljjqBqaPBb1xuH9DHkNbes1XP6kCEaANHDhHc3/0xdV6dbkhB
         tCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727073256; x=1727678056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xud0Bj40lmgGEoTZDAPWyWJLudpfWg/JlILBKYnl8wU=;
        b=cOVM7WjV9E4uLv3dffjSr4c5VWBMQrhBLOhfdGNJmGMedTTXla2mELNCnlBHLDIEyN
         zgCcZdoR3Fu6ECBYj2ZdhTAHHkfVo/3AgSSELJjb3vzKnapUOVlEhfOIjJ/7RhKPGPTm
         r126BKoUiM7fDTbcY4f/KmPYlLUEbo3VVTmC0td+9hlpfWTZOeBS4ueWTEwHnb1m+tp7
         D0zTjZsbOAW92jIE59yGkP1AfMORsC9qEYs2GXKUKzH9zVrxB1SpgY/PjPQxq2KP+1yJ
         oth/Nq9p1qxPpzvZppvCMwAKzTKQnA2m+RZwnUWs/cq3D1CGfe0Aa2OrnGvPZsFf/ufx
         WiPA==
X-Forwarded-Encrypted: i=1; AJvYcCU8q2UwWGx3NUEmPYoHbqgwcjzWzZ26rjwFhGl72R/Ui0j4G5uV2qogqr0lDf6eHFTtJ0RFJ+1KOxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlP6HdT36Hqs4j73z6CrxGgL2VlN4B3soww+6o9wrQqv4Q8aYG
	g8mMLpamZz2ydodWV2gdmka4NoQgwPVtbjVLKrwmpYYDzFTquLTIUAA2SM5gEMZVuT2EZdAaLKz
	Q95X2+hXXhSH3vLj4b+dA2lPy2AV/RC+KoC4d
X-Google-Smtp-Source: AGHT+IHgv+WaPXBGFfSh9JnGkKaZC4QUllbsOmespG23ynT9oxBxJviTj2hcvIQ9UBIe6mOnZUKQNkHqaXIlGoHHDO0=
X-Received: by 2002:a05:6512:3c97:b0:52e:934c:1cc0 with SMTP id
 2adb3069b0e04-5379961b0d2mr217481e87.7.1727073256077; Sun, 22 Sep 2024
 23:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823132137.336874-1-aik@amd.com> <20240823132137.336874-13-aik@amd.com>
 <ZudMoBkGCi/dTKVo@nvidia.com> <CAGtprH8C4MQwVTFPBMbFWyW4BrK8-mDqjJn-UUFbFhw4w23f3A@mail.gmail.com>
 <BN9PR11MB527608E3B8B354502F22DFCA8C6F2@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB527608E3B8B354502F22DFCA8C6F2@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 23 Sep 2024 08:34:03 +0200
Message-ID: <CAGtprH-bj_+1k-jwEVS9PcAmCOvo72Vec3VVKvL1te7T8R1ooQ@mail.gmail.com>
Subject: Re: [RFC PATCH 12/21] KVM: IOMMUFD: MEMFD: Map private pages
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alexey Kardashevskiy <aik@amd.com>, 
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

On Mon, Sep 23, 2024 at 7:36=E2=80=AFAM Tian, Kevin <kevin.tian@intel.com> =
wrote:
>
> > From: Vishal Annapurve <vannapurve@google.com>
> > Sent: Saturday, September 21, 2024 5:11 AM
> >
> > On Sun, Sep 15, 2024 at 11:08=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.co=
m> wrote:
> > >
> > > On Fri, Aug 23, 2024 at 11:21:26PM +1000, Alexey Kardashevskiy wrote:
> > > > IOMMUFD calls get_user_pages() for every mapping which will allocat=
e
> > > > shared memory instead of using private memory managed by the KVM
> > and
> > > > MEMFD.
> > >
> > > Please check this series, it is much more how I would expect this to
> > > work. Use the guest memfd directly and forget about kvm in the iommuf=
d
> > code:
> > >
> > > https://lore.kernel.org/r/1726319158-283074-1-git-send-email-
> > steven.sistare@oracle.com
> > >
> > > I would imagine you'd detect the guest memfd when accepting the FD an=
d
> > > then having some different path in the pinning logic to pin and get
> > > the physical ranges out.
> >
> > According to the discussion at KVM microconference around hugepage
> > support for guest_memfd [1], it's imperative that guest private memory
> > is not long term pinned. Ideal way to implement this integration would
> > be to support a notifier that can be invoked by guest_memfd when
> > memory ranges get truncated so that IOMMU can unmap the corresponding
> > ranges. Such a notifier should also get called during memory
> > conversion, it would be interesting to discuss how conversion flow
> > would work in this case.
> >
> > [1] https://lpc.events/event/18/contributions/1764/ (checkout the
> > slide 12 from attached presentation)
> >
>
> Most devices don't support I/O page fault hence can only DMA to long
> term pinned buffers. The notifier might be helpful for in-kernel conversi=
on
> but as a basic requirement there needs a way for IOMMUFD to call into
> guest memfd to request long term pinning for a given range. That is
> how I interpreted "different path" in Jason's comment.

Policy that is being aimed here:
1) guest_memfd will pin the pages backing guest memory for all users.
2) kvm_gmem_get_pfn users will get a locked folio with elevated
refcount when asking for the pfn/page from guest_memfd. Users will
drop the refcount and release the folio lock when they are done
using/installing (e.g. in KVM EPT/IOMMU PT entries) it. This folio
lock is supposed to be held for short durations.
3) Users can assume the pfn is around until they are notified by
guest_memfd on truncation or memory conversion.

Step 3 above is already followed by KVM EPT setup logic for CoCo VMs.
TDX VMs especially need to have secure EPT entries always mapped (once
faulted-in) while the guest memory ranges are private.

