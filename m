Return-Path: <linux-pci+bounces-10834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7700693D22A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 13:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939391C21279
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 11:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8551791EB;
	Fri, 26 Jul 2024 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klyXMRRL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FB1B27D;
	Fri, 26 Jul 2024 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992931; cv=none; b=NaUKCM1RdZbVirkvopGkIUEJN6Sx4PZCHOsLQgsdA1emirQuwSME2ANF08lVD7Iv+nS3bCp+TSz/N3YvUTqfPm+WHr0EwMIcK8Mh+5UdZeKnidi4y75KNrx1vNj3eP05hCj6Sgw7YrK4hlqYGiDq0F7slFOMDWMOOEhg1gCVOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992931; c=relaxed/simple;
	bh=9KLBUTKVzTgRfxzPzZcqpuZgkjX7XqPwnJIx/0VK6Gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7EFRf/IEeIdPuNeMxnCtbCiVR2Lo0gSrCQCYm1tQTsyBxCjQCZSQgJhedbSZ0hqEWZxpLGBnxz0S6mptXWtuVqsmyWUAuw7B5F3xCYBNySXfpoMufx4p0ERNzFS0BToRqwnk0Dx6YCgSGtskYl9Bj2ZK+94tepy9N4W3rjKf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klyXMRRL; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e026a2238d8so1896307276.0;
        Fri, 26 Jul 2024 04:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721992929; x=1722597729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KLBUTKVzTgRfxzPzZcqpuZgkjX7XqPwnJIx/0VK6Gk=;
        b=klyXMRRLDIDAmT2Shxfjj3D5MCH1d9el0yLzDfAVLs/ZkHVo9SHHvRpZ2uQjZFzUNu
         +oDxtSHlpr1w6KVH1VptOE6X2TYf4MsXlqcbbi3kI4DMf4IIG5J20JD1GWQ0uzcC1IIC
         ixnzRD9qhyHCUrVNRO6tXVO1aXhAokyL0Bz3UPu+HvmADTTQIdpDq9UVegqzZVTiAP9K
         LAWXM6HlllWH9WlZa2Iu+BL0PgHYs6ag8wjFI/6hX5Y3FPMV7y8/snse3tUrP1LOgEQ6
         VSE8rGOql2keEmH+aY+W1Cp8qgta1K0cP1MTT+S0tBHi0geXrJAw1Q0n+8bOJapmssE4
         rsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721992929; x=1722597729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KLBUTKVzTgRfxzPzZcqpuZgkjX7XqPwnJIx/0VK6Gk=;
        b=gQB6kGiEN2wFkCqRUXaDZozIxUP8AXvzn4soRyHtx/JbV1pgyYaad5SHGE+0eHG3wT
         Iv/DxKFYpoBM9INju3IcYYB4hKna+rziE26oux0j5i0+YxusVbiNUE6TUhpdXjCBPT0f
         REEIAEsp3ivIxgUwuyK3no59HOWYnI2Tfo2aILCHFRpRMUEpk8WFVw5GYxJAyjUDEdQA
         4BBOSrJd5JaeDPf407zF5JmLCEA780iand0j6s0d5pxT/4oh2lbKJ+0b8iN/E1xMEdZG
         oavqTS0gPJ5fpcyPyeOQv96LSkND9i9yrkI43L5MUHpLBxZC06xLiRGVcsnaI1bjJEO9
         /iDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHRIYzBXFD8lwj/6RgIkEy/0BFmnUf9mIXnfbYPDaJ8gSBgEBZy4ATuAveuqvbDSG82JN8XSTET3qN2WVeNFwTfDdgiStLhKewAuyB9QI1fFAEx5/2TTX71guezJESH0z/nfM5EcMq
X-Gm-Message-State: AOJu0Ywddc/LRj4Ecrmos6KLTPE18pH575IBwgE6hmFSc1SNKpldp+Br
	FD+uX5gPHoDJexhUhtQm9ZMLv4PM0uY2PcjsRr5Xv/jW4XyCruEzkGnA0/3xatObo2bu36slneE
	TmzBRtXHHx/T3hDHypxHNguUw5XU=
X-Google-Smtp-Source: AGHT+IHfiRT04fD1aIIijUVn1LJf1PfXbkNfXEcYD/1CJL/gaxz2KQ3vBAQUTFrHITYLbMSt26GPOJ1ny88bD2E1vbA=
X-Received: by 2002:a05:6902:1610:b0:e02:b466:e59c with SMTP id
 3f1490d57ef6-e0b2c6e86f6mr6101084276.0.1721992928829; Fri, 26 Jul 2024
 04:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com> <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan> <20240725053348.GN2317@thinkpad>
 <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>
 <ZqJeX9D0ra2g9ifP@ryzen.lan> <20240725163652.GD2274@thinkpad>
 <ZqLJIDz1P7H9tIu9@ryzen.lan> <9c76b9b4-9983-4389-bacb-ef4a5a8e7043@kernel.org>
In-Reply-To: <9c76b9b4-9983-4389-bacb-ef4a5a8e7043@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Fri, 26 Jul 2024 13:21:32 +0200
Message-ID: <CAAEEuhp+ZtjrU1986CJE5nmFy97YPdnfd1Myoufr+6TgjRODeA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, rick.wertenbroek@heig-vd.ch, 
	alberto.dassatti@heig-vd.ch, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 12:53=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org=
> wrote:
>
> On 7/26/24 06:52, Niklas Cassel wrote:
> > On Thu, Jul 25, 2024 at 10:06:52PM +0530, Manivannan Sadhasivam wrote:
> >>
> >> I vary with you here. IMO EPF drivers have no business in knowing the =
BAR
> >> location as they are independent of controller (mostly except drivers =
like MHI).
> >> So an EPF driver should call a single API that just allocates/configur=
es the
> >> BAR. For fixed address BAR, EPC core should be able to figure it out u=
sing the
> >> EPC features.
> >>
> >> For naming, we have 3 proposals as of now:
> >>
> >> 1. pci_epf_setup_bar() - This looks good, but somewhat collides with t=
he
> >> existing pci_epc_set_bar() API.
> >>
> >> 2. pci_epc_alloc_set_bar() - Looks ugly, but aligns with the existing =
APIs.
> >>
> >> 3. pci_epc_get_bar() - Also looks good, but the usage of 'get' gives t=
he
> >> impression that the BAR is fetched from somewhere, which is true for f=
ixed
> >> address BAR, but not for dynamic BAR.
> >
> > pci_epc_configure_bar() ?
> > we could name the 'struct pci_epf_bar *' param 'conf'
>
> +1
>
> But let's spell this out: pci_epc_configure_bar(), to be sure to avoid an=
y
> possible confusion (config could mean configure or configuration...).
>
> --
> Damien Le Moal
> Western Digital Research
>

+1

One thing to keep in mind is that 'struct pci_epf_bar 'conf' would be
an 'inout' parameter, where 'conf' gets changed in case of a fixed
address BAR or fixed 64-bit etc. This means the EPF code needs to
check 'conf' after the call. Also, if the caller sets flags and the
controller only handles different flags, do we return an error, or
configure the BAR with the only possible flags and let the caller
check if those flags are ok for the endpoint function ?

This is a bit unclear for me for the moment.

One solution could be to pass two 'pci_epf_bar' structs, one is to be
filed by the function call, and the other an optional parameter
'desired_conf' (i.e. can be 'NULL') if NULL it would mean let the
controller decide, if not NULL 'desired_conf' describes the EPF
requirements (e.g., chosen BAR address or certain flags, size, etc.)
and 'pci_epc_configure_bar()' would fail if it cannot satisfy the
'desired_conf' requirements.

But still 'desired_conf' is a structure with several things that could
be independently desired, e.g., a given address or BAR size, flags,
but not all of them might be a necessity.

Let me know what you think.

Have a nice week-end.

Rick

