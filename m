Return-Path: <linux-pci+bounces-6660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082758B1AFD
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 08:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4956B281DDE
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 06:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1C34207F;
	Thu, 25 Apr 2024 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="It1Mo04d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916741757
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026412; cv=none; b=IDVyf/n5Q2ClG5zDi11OsBBjSTR5m1X805ldPUxBRgMZYoZSkv79MaeWStkjP2UrBzCsDVcLH3UiMSedrOee04QnME1jCp1P/LTEcd9ryNNAkLcrIZkkEcEclOhwpiOtZPTLueXVJX5oIvnQcjDmVlEBSM6P9zKb/D0yl1TBYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026412; c=relaxed/simple;
	bh=738bx0ebszciNfqD7UVbAZya1SA+u1TcvpkDfJNU9Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/56WIdwmt9ZRT99Q+F4w82Dq4Ca3XJxnuHp6UtL7tH9ofD5CT5a28ZpPcevPNoc7Gq1MBNoO+P0gglVEHthoXYxTE9Bwc2O31hIpPCw5U+0KnUxToypiSGqayvrNuSihvhAG10ynPmFzoJxuq2Ea7lIIPBCAtiZE2uYGnIp5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=It1Mo04d; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 57FEA3FE54
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 06:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714026409;
	bh=vEKVDSHMK5F/yU8ggTZJjhUhsGYpK1yP0OK1ux8Mb5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=It1Mo04dCe+tCH/jmCiuKboCxyCyJewDkfXOsZxlIcIJgDWz3L2+e/JmFgf95Kp79
	 sPRwnGaSsKl04ZTW3HkIbsleNZr+U1Fm5wKTIfw93/mruc2JFGVht9crfbHhMSIUuv
	 uZYmgfzEWiQDuxWlEa/Y+KHVQYESAJVrJvypzKPOsYvwLGdARG7bGZETE3BiBDNwTN
	 SoPHGUqkMv0g1e4XrXRR14YNCdKR+XOK07PC8lZeGyG4eAewyIevNAu/fDVG/EMk2O
	 6BL4cFAzNvYTGFvHBaWhFh2XadCubnoxcIKZLWoqWNidGIxd9DvaVbSEIAaRb2a0Ko
	 hBuzf84lnzJwQ==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ae0abc0b41so819192a91.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 23:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714026407; x=1714631207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEKVDSHMK5F/yU8ggTZJjhUhsGYpK1yP0OK1ux8Mb5o=;
        b=ZJiaAeqW3TNBgSv3aT98jAEA4u/+vyjVc0Mw7hKwcPrDRqBD3tYLJybyqHbbKEUd5q
         MGN/Bk+VhCeIF+IvQKfcws0OERXQ51X5A4ckb6+9dChBndMU+bVFdBEq2h//efXHR1GE
         NA38gAxVDuiGReVSHsrgoJXhxAZpKyuTUO3FYSgJ4z6LzfKdTSbr+bYqaohcTRj4L0bt
         ptvbhxwcwTSH22wTdPxPfNU3JD97xCweqCrXorB+Tq4+Jfe/Xzdgi15S3Om6vn0E4IQ0
         JLNaZqlFcugTDGTfC4jRh6ICKqH4Ek7lx7RHEgoOh9WioNGpNW8y3icIFykVOUWael+W
         xuXw==
X-Forwarded-Encrypted: i=1; AJvYcCXrgOcdoH5eusc2ouPzd2pvosB4kMJgPokDW+Ka/HQvN22T3CtRowF78d21fkBaAzT+Yoa/z9Z2ONZQKWayvqPyE/pu8j4M4oE0
X-Gm-Message-State: AOJu0YwjZ9qrAEVpJHv8kc0qrqRS9w7eQdUNESRfOy7LXuPRO/ow55+p
	WUg0kRsaxpImZ6x+4+qtXusi06h1kdKRhGcPwUI1qnill4U1Sgif90ffVrWTl2ru9ORCH3tfvNK
	y4zZ1dOonIHjXQDZ9XhPhiDgHWkgtppHoMTOKX766jMundeQS3qsjzh3wsgNJdoYZ8oHU5N0vm/
	LBPE9+Kid8aaCnmGqtgGtVEFXfIMq2t71ANVi5kiI2ZKeU9RTro4dpEgeW
X-Received: by 2002:a17:90a:4485:b0:2a6:ff2e:dce0 with SMTP id t5-20020a17090a448500b002a6ff2edce0mr5440133pjg.5.1714026406795;
        Wed, 24 Apr 2024 23:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLNR3SuwzJ2NqCuDu7XgA6QzggBx2sXnYGhGItyhdXG9zOH57lKQGVFKFleuFQOUiHqsV2LTxk6EPDijTfycg=
X-Received: by 2002:a17:90a:4485:b0:2a6:ff2e:dce0 with SMTP id
 t5-20020a17090a448500b002a6ff2edce0mr5440111pjg.5.1714026406400; Wed, 24 Apr
 2024 23:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416043225.1462548-1-kai.heng.feng@canonical.com> <2aff18aa-32b7-4092-8235-aead9b708ea0@linux.intel.com>
In-Reply-To: <2aff18aa-32b7-4092-8235-aead9b708ea0@linux.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 25 Apr 2024 14:26:34 +0800
Message-ID: <CAAd53p7e5dWEsSdrvpZ_5b9LLrhVwQEChUkFityN_nOuT2K=zQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, bagasdotme@gmail.com, 
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org, kch@nvidia.com, 
	hch@lst.de, gloriouseggroll@gmail.com, kbusch@kernel.org, sagi@grimberg.me, 
	hare@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:15=E2=80=AFAM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
> On 4/15/24 9:32 PM, Kai-Heng Feng wrote:
> > In addition to nearest upstream bridge, driver may want to know if the
> > entire hierarchy can be powered off to perform different action.
> >
> > So walk higher up the hierarchy to find out if any device has valid
> > _PR3.
> >
> > The user will be introduced in next patch.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
>
> Since it has been a while, I was not sure what this series is about.
>
> IMO, it is better to include a cover letter with the summary of your
> changes.

OK, will do in next revision.

>
>
> > v8:
> >  - No change.
> >
> >  drivers/pci/pci.c   | 16 ++++++++++++++++
> >  include/linux/pci.h |  2 ++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index e5f243dd4288..7a5662f116b8 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6225,6 +6225,22 @@ bool pci_pr3_present(struct pci_dev *pdev)
> >               acpi_has_method(adev->handle, "_PR3");
> >  }
> >  EXPORT_SYMBOL_GPL(pci_pr3_present);
> > +
> > +bool pci_ancestor_pr3_present(struct pci_dev *pdev)
> > +{
> > +     struct pci_dev *parent =3D pdev;
> > +
> > +     if (acpi_disabled)
> > +             return false;
> > +
> > +     while ((parent =3D pci_upstream_bridge(parent))) {
> > +             if (pci_pr3_present(pdev))
>
> I think it should be "parent" here?

Thanks for catching this.

But this patch will be dropped in next version for better simplicity.

Kai-Heng

>
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ancestor_pr3_present);
> >  #endif
> >
> >  /**
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 16493426a04f..cd71ebfd0f89 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -2620,10 +2620,12 @@ struct irq_domain *pci_host_bridge_acpi_msi_dom=
ain(struct pci_bus *bus);
> >  void
> >  pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct de=
vice *));
> >  bool pci_pr3_present(struct pci_dev *pdev);
> > +bool pci_ancestor_pr3_present(struct pci_dev *pdev);
> >  #else
> >  static inline struct irq_domain *
> >  pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
> >  static inline bool pci_pr3_present(struct pci_dev *pdev) { return fals=
e; }
> > +static inline bool pci_ancestor_pr3_present(struct pci_dev *pdev) { re=
turn false; }
> >  #endif
> >
> >  #ifdef CONFIG_EEH
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>

