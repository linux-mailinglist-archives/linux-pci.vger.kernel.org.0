Return-Path: <linux-pci+bounces-13333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C5697DA30
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 23:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3C21F22150
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 21:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD8917DFF3;
	Fri, 20 Sep 2024 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wy9GqyEN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B324F881
	for <linux-pci@vger.kernel.org>; Fri, 20 Sep 2024 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726866647; cv=none; b=bvD3DFKpsCvg0FS5Y2GKN73NN/T0OmtGKmA/zvrfkmE5sDDeIk6CkZDJ2Z9NzDuQOj8uGH8DUPMIMREkYzgo7hROhODmxdy7ghlN7XXyaVGaaJ9cVBvh+kV/MnuTSEs0zf+LVEtYFp2AQNT5m77HAnue788geuIjHL0Kpb94GU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726866647; c=relaxed/simple;
	bh=m+NtI7KFoRn8JqPaP71PrQB5dB7g9pqRx96cGl1zNOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSHL5pf7nIWgklfHdu68BHk9gybIeCJfD9I2rd5PPexMioyDq4OIo/1ibFhj5mVNotQVmLuK+MNXtbbq2jVstsBJ1fxaHPKtH1nLbFxLeWrDIOfMSTvusO3htSseR6tph8uDApphJTOdFsaq7B1IuHICpOr0eadA4N+FROnX8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wy9GqyEN; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53690eb134bso6758e87.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Sep 2024 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726866644; x=1727471444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+NtI7KFoRn8JqPaP71PrQB5dB7g9pqRx96cGl1zNOQ=;
        b=Wy9GqyENCR6rRak89lE+MmoAVFsfRhG4pPgnHcAzlv6s1K9vLr15Yqh8+fIySzyk9g
         x1/9eQXnHNbA4lbbidAvQm4cJdOuRt01xB6Xa5137qe5oGCk9d+dki5QSt7uKZWcFeUF
         Tul2tyrTaAvJihoD769elWPQonbwE/higHUHnm90zlo331Eg+uvcJX8shmDYaJdSF390
         IhOAvsXsSU4mkUKdkTWb3UP3z2UZCY6iBapVn4Tofs0z1JeA7PboIm656aXNmTKWxiis
         E+P3w+omlnEkkHu7VXV5SYYvluC8zFJwHXrLCv6ZYPAMzO9jVhXSvhAMid2BuSxRbJOj
         wgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726866644; x=1727471444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+NtI7KFoRn8JqPaP71PrQB5dB7g9pqRx96cGl1zNOQ=;
        b=rZmBlYf5OoGd1cM+hLKdgU62tbOrdF9ShORFBcSHTK5Ojtc8VpzvAbdVMMTWPWHMRh
         aEen0UyFWspQaoZm2/hDZQmaIuIaee5P3VJ9HM/LAPdBM85yGW4G1lVtH905pqWbJ1Lp
         OE7soVhBmgFHppr0d/naOkGBqMPC7pA6irKOZzPFOG2vrDjrOY+DmMUuUjBXAjrkv5t6
         AnkXp9XwyDPGDIQVQVPz9mdeaSaRsaFu8JlAdP1HI9uSsehJw9NAr5v6fIGs6X5da8+C
         XNaZNLh4HJdDlLwOYN4izs76AVYnB95uX9+ZcpBrPYb15+MDTq9MRKwzQT1rKwfRGX+N
         DopA==
X-Forwarded-Encrypted: i=1; AJvYcCVu8FybWvqKhIPiBLZF89/BsOZoW0K5KXd4Y1fZF1kG1wr3FvpuD4H/zkVvAwpps369pRN4bf0whq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyTCbtNh/SEmVV6bRuhS5v5El7o8D4XYPjwHU+HrXbXwpemqg+
	768X8/bw5Lr31H/q247kFXc0aoQxtPeWnqdnE+4JRKAuMLh2kxr0hUb+ZE2JlVmw1QNx100p/M5
	ZAEQfO/Q8d7bqhh3mluw72NT3GYsZCuJGvBBx
X-Google-Smtp-Source: AGHT+IHbQ1owfwv0bwXyOysxmcbe5slLoFbMmljycd2jsECKG87UWxrZhXYcSekvu/JQPuY2zRUCE12merz5Ttxczic=
X-Received: by 2002:a05:6512:3f0f:b0:535:6a42:90f2 with SMTP id
 2adb3069b0e04-5374fd2163fmr105932e87.6.1726866643470; Fri, 20 Sep 2024
 14:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823132137.336874-1-aik@amd.com> <20240823132137.336874-13-aik@amd.com>
 <ZudMoBkGCi/dTKVo@nvidia.com>
In-Reply-To: <ZudMoBkGCi/dTKVo@nvidia.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 20 Sep 2024 23:10:30 +0200
Message-ID: <CAGtprH8C4MQwVTFPBMbFWyW4BrK8-mDqjJn-UUFbFhw4w23f3A@mail.gmail.com>
Subject: Re: [RFC PATCH 12/21] KVM: IOMMUFD: MEMFD: Map private pages
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Dan Williams <dan.j.williams@intel.com>, 
	pratikrajesh.sampat@amd.com, michael.day@amd.com, david.kaplan@amd.com, 
	dhaval.giani@amd.com, Santosh Shukla <santosh.shukla@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Alexander Graf <agraf@suse.de>, Nikunj A Dadhania <nikunj@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 11:08=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Fri, Aug 23, 2024 at 11:21:26PM +1000, Alexey Kardashevskiy wrote:
> > IOMMUFD calls get_user_pages() for every mapping which will allocate
> > shared memory instead of using private memory managed by the KVM and
> > MEMFD.
>
> Please check this series, it is much more how I would expect this to
> work. Use the guest memfd directly and forget about kvm in the iommufd co=
de:
>
> https://lore.kernel.org/r/1726319158-283074-1-git-send-email-steven.sista=
re@oracle.com
>
> I would imagine you'd detect the guest memfd when accepting the FD and
> then having some different path in the pinning logic to pin and get
> the physical ranges out.

According to the discussion at KVM microconference around hugepage
support for guest_memfd [1], it's imperative that guest private memory
is not long term pinned. Ideal way to implement this integration would
be to support a notifier that can be invoked by guest_memfd when
memory ranges get truncated so that IOMMU can unmap the corresponding
ranges. Such a notifier should also get called during memory
conversion, it would be interesting to discuss how conversion flow
would work in this case.

[1] https://lpc.events/event/18/contributions/1764/ (checkout the
slide 12 from attached presentation)

>
> Probably we would also need some CAP interaction with the iommu driver
> to understand if it can accept private pages to even allow this in the
> first place.
>
> Thanks,
> Jason
>

