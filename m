Return-Path: <linux-pci+bounces-21842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CDDA3CBD8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 22:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5027A20E8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 21:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15480257AFD;
	Wed, 19 Feb 2025 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPiPoa7p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EF20F082
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002045; cv=none; b=DvRtmmaOljt8/wMc2NckRcP0SgVIgAQnpBmrLVUQMdWUpIzZX6LnABJN5jHDCx/v0rCbO77RoMRu3HqLYOJKy1GrIxAS9GX7Y0uOx9j8wNIkzHFnRl8JZ6xvDhy/n3OD5ECUWu0nJ8iHBVjPn2nGdYEKuImmD9h1wpt1ZivtoPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002045; c=relaxed/simple;
	bh=f2Evl1/Y2JRZTJBM8MgwzdslOMp6PcDTZCILmIIZjgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TomddjW2q7+N08WpTFyhYP0WnjaftrfeMTxacUO31oOCCbJ+Gcv6hpN5lGTyCltRtnxfxgkJauuWrWDLveYAdVpG20jhsAAsPif/azUY868spktH2vAPi24SyBaeGkGq4HHsZDHiDMqVaX5OktnicdtHplFwU9Z3HlKnIqEAZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPiPoa7p; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e04f2b1685so346861a12.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 13:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740002041; x=1740606841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hly2+E/pWLYHFHzBEhpYiIK1H+/yy5Tlka93bMM+wKs=;
        b=wPiPoa7pP09xjsSP70pkj/bvYFKd8x4lNN0emVrSQKf2EdGmTdHIwxYbfq/D5U/v7v
         HNweq3GlDYEk4vlyOlA4AA3oA2ER6qqWPtPaq7KIrkmGz3S31FPtfYRFqXse1fmpDih+
         js2cqwMLiire1+Wic3M1WykeFStfatbO17Fl6mYzgD5QjB5SIEwVKPIWt+Se/LmY246M
         KvsxSviAtIozPXJu6NLqQ3eKjsuGjr4FcnEPNnHxDFrvgbdisJ5Us6VuZK8mqdEjtQqf
         DDjgBwEAa1aNRhC6xfCj9QR9YWfoCEpi6xtk45cHLQjk+OlINjGznmuvSZCEeRB6Kk4w
         REVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740002041; x=1740606841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hly2+E/pWLYHFHzBEhpYiIK1H+/yy5Tlka93bMM+wKs=;
        b=HNYQ0WjY7B2eg8GFVFM0Hu19UfXq+SMZYbca/bCzLQkrLcFR3B9TT3p+EjHefhd8xF
         G6Bqfqc36oxM7DtgP7O61KtXw3rpoqkw6axYROWsK9/Dy/voUFN7vMgQW7xO4M20RqOU
         GAFkwn9zOm8kUaQvt743EbPCAA1UvVaKzS7XNKj+dxBWeSZ+ErFV6gTW51ABLUz7hrvC
         7rNz429bpv8gg1Lihu5MfwWzhAbIAEcxc2w/Jq9aFI76L/46YOBGbACbQwgvZkxo9Zj5
         O/RtjIc/WI54/76sFo3da6D7eeuT9S52COBqYM1XdwCHuXxK/M7spf+/RY5kU+q7rTTj
         ltNg==
X-Forwarded-Encrypted: i=1; AJvYcCW327Sc2Lb52mMnR8zdDlAFj7Kmpjb+PHe6FP/6hjpBaPol4RGK9AB7cpMIYJZ3NPBP3GAw/je3a/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1GluJpuMKxX/8xs0xHnF9OVToPxoDURsI07rU04K/QH0f0u4y
	uz4QTxBhBS1qs1N1cb74ymv/w5oGjOaFugFtNSoWLwdP0FxGoz6yUYPpcAlLUpjl6Zpuy2opbl3
	MB1TJ8QfJ+DZbcBrpg7EVANDuX05YO4+7tMamwv7mqGNE9chMsOjMtMsVUQ==
X-Gm-Gg: ASbGnctTd+Mk0tWfC6Zmlqkvry6RI0mBLbqYNRzBA+HMubO5AKl/9N/UFIJ8pyb2KL/
	A8FFY0H+BuNJgB8tPglvQ8sd+Yn9KF/pXsrSH5Z6q5EZ75/TTK+O1lsEU7565scx9joPcutv7
X-Google-Smtp-Source: AGHT+IE8hY7HZbQxDsGR2DbY0WjBS8/vjMy9cpF4Uk6YeOTrso2rzJyYUK3piSrXg5oFlVO1VY67vEoPtoW7JVgAxy4=
X-Received: by 2002:a05:6402:35cb:b0:5dc:caab:9447 with SMTP id
 4fb4d7f45d1cf-5e036063e6amr49959261a12.18.1740002041121; Wed, 19 Feb 2025
 13:54:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118193024.2695876-1-jperaza@google.com> <2024111818-molecule-pedicure-db1b@gregkh>
In-Reply-To: <2024111818-molecule-pedicure-db1b@gregkh>
From: Joshua Peraza <jperaza@google.com>
Date: Wed, 19 Feb 2025 13:53:48 -0800
X-Gm-Features: AWEUYZkO-tcQ2iOyT9akmDadkWwc5wTxIV3gUrRKPZqCyQfwcTlPQkMZ347whJ8
Message-ID: <CAFRSFxLF-i9Yvcf653-5gThV6PS_USqM3C5C8AaWrXuFaj8EZg@mail.gmail.com>
Subject: Re: [v8 PATCH 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, helgaas@kernel.org, iommu@lists.linux-foundation.org, 
	jean-philippe@linaro.org, joro@8bytes.org, jsbarnes@google.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com, oohall@gmail.com, 
	pavel@denx.de, rafael.j.wysocki@intel.com, rafael@kernel.org, 
	rajatja@google.com, rajatxjain@gmail.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 11:43=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Nov 18, 2024 at 07:30:22PM +0000, Joshua Peraza wrote:
> > This patchset rebases two previously posted patches supporting
> > recognition of Microsoft's DmaProperty.
> >
> > v8: Joshua renames untrusted_dma to requires_dma_protection and updates
> > some comments, reducing use of the word "trust" to refer to PCI devices
> > and matching the word choice in Microsoft's documentation.
>
> So this is the "clarity"?  I'm not sold, sorry.  Again, did you look at
> the previous discussions we had about this name?  We don't have to use
> Microsoft's term here as it is used differently by Linux today, right?
> If you really want to support the DmaProperty, why not just support that
> with a new bit as that's something different here, right?
>
> Again, look at what this is supposed to be conveying.  They ability to
> DMA to anywhere isn't really the root issue here, or is it?  What is the
> threat model you are trying to mitigate?
>
> > v7: Rajat updates a comment with Robin's suggestion. Joshua re-sends an=
d
> > Greg requests clarity and documentation on why untrusted_dma is the
> > right name.
> >
> > v6: Rajat renames pci_dev_has_dma_property and links to Microsoft's
> > documentation in the commit message. Robin suggests clarifying a
> > comment.
> >
> > v5: Rajat changes the name to untrusted_dma. Bjorn suggesting changing
> > another function's name pci_acpi_check_for_dma_protection to
> > pci_dev_has_dma_property and seeks clarified documentation.
> >
> > v4: Rajat changes the name to poses_dma_risk. Christoph suggests this
> > name doesn't capture the intent as well as untrusted_dma and Rafael
> > agrees.
> >
> > v1,v2,v3: Greg suggests that (un)trusted is the wrong word for referrin=
g
> > to PCI devices, recommending a name something like "platform wants to
> > protect dma access for this device."
>
> Or is it?  I said this when?  Just how old is this patch series?
>
> confused,
>
> greg k-h

(sorry if you're getting this again; re-sending as plain text)

Sorry for the confusion! What do you think about the following for a
new cover letter?

Threat model: An overview of the security implications of strict vs
non-strict IOMMU is presented at [1]. This change is motivated by
=E2=80=9CCase 1=E2=80=9D where a DMA-capable device is processing untrusted=
 inputs,
e.g. network devices.

This patchset proposes using =E2=80=9CDMA protection=E2=80=9D to mitigate t=
his risk.
This has the following effects, currently controlled by the
=E2=80=9Cpci_dev::untrusted=E2=80=9D flag.

- Separate IOMMU DMA domains
- Use of SWIOTLB if CONFIG_SWIOTLB
- Disables =E2=80=9Cquirks=E2=80=9D in intel IOMMU
- Disables Address Translation Services

The =E2=80=9Cuntrusted=E2=80=9D flag was introduced in 2018 in [2]. The mot=
ivation for
that change was to enable using IOMMU to protect against DMA attacks
from externally facing devices such as thunderbolt ports. The patchset
introduces the =E2=80=9Cuntrusted=E2=80=9D flag which =E2=80=9Cis supposed =
to cover various
PCIe devices that may be used to conduct DMA attacks.=E2=80=9D The patchset
originally proposes naming the flag =E2=80=9Cis_external=E2=80=9D but is re=
named to
=E2=80=9Cis_untrusted=E2=80=9D and then =E2=80=9Cuntrusted=E2=80=9D supposi=
ng that it could apply to
more than just externally facing thunderbolt devices. The fact that
=E2=80=9CExternalFacingPort=E2=80=9D is not part of any standard is called =
out during
review but also that Windows expecting firmware to identify external
facing ports makes it =E2=80=9Cas good as a formal standard in the Windows
world.=E2=80=9D

This current patch series was first proposed in January 2022 [3]. It
originally proposed a new property =E2=80=9CUntrustedDevice=E2=80=9D which =
would cause
the untrusted flag to be set. In V1 Greg questions whether the new
property is part of the ACPI standard, asks who is making this policy
decision, and states =E2=80=9CThis notion of =E2=80=98trust=E2=80=99 for PC=
I devices is
crazy=E2=80=A6.=E2=80=9D Mika links to Microsoft's documentation of =E2=80=
=9CDmaProperty=E2=80=9D and
suggests that property is adopted instead. Greg objects that Linux
does not have =E2=80=9Cdma protection=E2=80=9D but Mika says that this is t=
he IOMMU.
The term =E2=80=9CDMA protection=E2=80=9D is also used in thunderbolt drive=
r code for
the same purpose and in an Intel white paper [4] describing the
technique. Mika also observes that Linux has recognized several
properties documented by Microsoft but not part of the ACPI standard.
There is discussion between Mika, Rafael, and Rajat about seeking to
align with Microsoft on the semantics of =E2=80=9CDmaProperty=E2=80=9D for
compatibility with firmware produced for Windows.

V2 of this patch series [5] again proposed an =E2=80=9CUntrustedDevice=E2=
=80=9D
property which Greg objects to because it is not sufficiently
descriptive, not sufficiently documented, and policies about trust
don=E2=80=99t belong in the kernel. Rajat describes the =E2=80=9Cuntrusted=
=E2=80=9D flag=E2=80=99s
current use, controlling IOMMU and Greg suggests naming the flag
=E2=80=9Cuse_iommu=E2=80=9D or =E2=80=9Cable to do DMA=E2=80=9D

V3 of this patch series [6] proposes recognizing =E2=80=9CDmaProperty=E2=80=
=9D with
slightly altered semantics from Microsoft=E2=80=99s documentation. Greg
suggests adhering to Microsoft=E2=80=99s semantics for =E2=80=9CDmaProperty=
=E2=80=9D and to
introduce a new property with new semantics instead. Greg again states
that the flag being named =E2=80=9Cuntrusted=E2=80=9D (not changed in this =
patch) is
confusing.

V4 renames =E2=80=9Cuntrusted=E2=80=9D to =E2=80=9Cposes_dma_risk=E2=80=9D.=
 Christoph suggests
=E2=80=9Cuntrusted_dma=E2=80=9D and Rafael agrees.

V5 renames the flag to =E2=80=9Cuntrusted_dma=E2=80=9D. Bjorn asks for clar=
ification
about whether the semantics of this flag will match Microsoft=E2=80=99s
documentation. Rajat responds that Microsoft has agreed to update
their documentation to have aligned semantics, in particular =E2=80=9Cthe
property is not restricted to identify =E2=80=98internal PCIe hierarchies=
=E2=80=99
(starting at root port), but to "any PCI device". As of today,
Microsoft=E2=80=99s documentation does not appear to have been updated.

In V6 Rajat updates a link to Microsoft=E2=80=99s documentation, renames a
function to pci_dev_has_dma_property() and uses
acpi_dev_get_property() to read =E2=80=9CDmaProperty=E2=80=9D.

In V7-V8 Joshua re-sends and Greg requests a summary of the history of
debate about the name for the =E2=80=9Cuntrusted=E2=80=9D flag as well as w=
hat is the
threat model, what does this property convey, and why we should use
Microsoft=E2=80=99s DmaProperty and its semantics instead of inventing
something new.

Links:
[1] https://lore.kernel.org/linux-arm-msm/20210624101557.v2.3.Icde6be7601a5=
939960caf802056c88cd5132eb4e@changeid/
[2] https://lore.kernel.org/lkml/20181129155153.35840-1-mika.westerberg@lin=
ux.intel.com/
[3] https://lore.kernel.org/all/20220120000409.2706549-1-rajatja@google.com=
/
[4] https://www.intel.com/content/dam/develop/external/us/en/documents/inte=
l-whitepaper-using-iommu-for-dma-protection-in-uefi-820238.pdf
[5] https://lore.kernel.org/all/20220202020103.2149130-1-rajatja@google.com=
/
[6] https://lore.kernel.org/all/20220216220541.1635665-1-rajatja@google.com=
/

