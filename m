Return-Path: <linux-pci+bounces-37508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71696BB5F09
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 07:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294E619E67CB
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 05:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574121E7C18;
	Fri,  3 Oct 2025 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSzIzINo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321F51A08A4
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759469111; cv=none; b=Q1iNIkd6zencumf+O81ys0CaH3ko46catZEsnxfV5O589qsRyeAqwzIu2f4lepkJ/a4FJ/7hTikrXt8kgx8vJedCvTA1HPhN8uO1BN5Q8qlF/LH5qoDWKU8uysBh/UluhOJ0ejvVWoiv9OrHBppqTHrlxo7q9PPfgVPvYYMnOHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759469111; c=relaxed/simple;
	bh=EOzXcb2+snU5GyhFcUIMvU/Iu5AP4ndE6HRdY7JLoe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsMYNRFvPrKvSMW3th5i6MY3GP6uJE4BJdCv/tEcGq+/aVwctiCn4zSNZ5Rsr+nJpgvRtrwxAJEkwoIMEMrBP5cSFdm6h97//4ci50Cdd52M4U+zJDYy+Lz9w8CcEa7mbToaM+TgQC3QQPVqJkuSzGD8T63mJtZzbM64bK+GeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSzIzINo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AD3C4CEF7
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 05:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759469110;
	bh=EOzXcb2+snU5GyhFcUIMvU/Iu5AP4ndE6HRdY7JLoe0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PSzIzINoE/iFlnHHVSjX8RjDSjuVe0jHrE/XUZeqeGZTensJCaoBpMAf4Wug9Ty0b
	 ZdmJligdirwKiDAGVOm4YDXwHYPEo7s39FC4obKBdNkfjS7e9ztLtY/KjgbyUlKIN5
	 I/fxYmSvl1P2O1GJ9dUq2CNIn0zNfNygQl7ab8Y8VcTo1P55yBa2gOxWTywEHA5DZB
	 s924jVegnd/B2LTR9qlVFHZ7w2Kp9ViG4D85F83TMkBri2SgAfUDRPQ99EyicfTnCA
	 1hPsIR1dMeCYpcwhxGLU5/E9ZJhfKZyUX6lVlbf+LZlgxYbXyQ5T295ogoEWzwsRml
	 lQluvNnsPvnRw==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d71bcab69so19955937b3.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 22:25:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1PHoWl/RfxMo14ajIGmUL6j96Ay1J29SP1ziSzt3js8Hd4is3l1cwdctgIwvDcIifHlEB7y7wBKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRT7OYA0a0OjniitooBJT/mu0T++y9el5MOS6Z3Nq0xeLrF2Ew
	QCtWQh6nzeKn3/sjM8GBGvvwLdi85yrHMJb60rhmLRHJUkNYsEzumxR2DkdLDRgLg7wSuhgVBXw
	aezXBuJRrpNvjXmxMdJCYwoE434zF/A5F30WVaGcvrw==
X-Google-Smtp-Source: AGHT+IH1QaxvSwsxjI4CgG6jGhMwDMFvz5F+YufC61cns4ki360T00rHhtNN6NuQo5SKORdiM0w3plcY22ZTKfKp7g4=
X-Received: by 2002:a05:690e:254d:b0:634:647d:f582 with SMTP id
 956f58d0204a3-63b9a1061f3mr1276161d50.37.1759469109963; Thu, 02 Oct 2025
 22:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com> <20251002232153.GK3195829@ziepe.ca>
In-Reply-To: <20251002232153.GK3195829@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 2 Oct 2025 22:24:59 -0700
X-Gmail-Original-Message-ID: <CACePvbXdzx5rfS1qKkFYtL-yizQiht_evge-jWo0F2ruobgkZA@mail.gmail.com>
X-Gm-Features: AS18NWDhTnBi_Y6qY5_bokBauhakTKLowQI20S0cLVucoLN7G4cwQsTg60ByTaQ
Message-ID: <CACePvbXdzx5rfS1qKkFYtL-yizQiht_evge-jWo0F2ruobgkZA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Matlack <dmatlack@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 4:21=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Oct 02, 2025 at 02:31:08PM -0700, David Matlack wrote:
> > I'm saying the only drivers that actually needed to implement Live
> > Update driver callbacks have been vfio-pci and PF drivers. The
> > vfio-pci support doesn't exist yet upstream, and we are planning to
> > use FD preservation there. So we don't know if driver callbacks will
> > be needed for that.
>
> I don't expect driver callbacks trough the pci subsystem, and I think
> they should be removed from this series.

Per suggestion from David as well. I will remove the driver callback
from the PCI series.

>
> As I said the flow is backwards from what we want. The vfio driver
> gets a luo FD from an ioctl, and it goes through and calls into luo
> and pci with that session object to do all the required serialization.
>
> Any required callbacks should be routed through luo based on creating
> preserved objects within luo and providing ops to luo.
>
> There is no other way to properly link things to sessions.

As David pointed out in the other email, the PCI also supports other
non vfio PCI devices which do not have the FD and FD related sessions.
That is the original intent for the LUO PCI subsystem.

> > And we don't care about PF drivers until we get to
> > supporting SR-IOV. So the driver callbacks all seem unnecessary at
> > this point.
>
> I guess we will see, but I'm hoping we can get quite far using
> vfio-pci as the SRIOV PF driver and don't need to try to get a big PF
> in-kernel driver entangled in this.

Yes, vfio-pci is a big series as well. Getting a NIC might be easier
to get the PF DMA working with a live update but that will be thrown
away once we have the vfio-pci as the real user. Actually getting the
pci-pf-stub driver working would be a smaller and reasonable step to
justify the PF support in LUO PCI.

Chris

