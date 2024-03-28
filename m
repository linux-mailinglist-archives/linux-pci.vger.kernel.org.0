Return-Path: <linux-pci+bounces-5365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE378890DB0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 23:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F44BB227D2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 22:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679F9208B4;
	Thu, 28 Mar 2024 22:36:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A8932C89;
	Thu, 28 Mar 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665384; cv=none; b=aSy1KMHFd+wHWMAnKqcm4b2QloBzFJfOQ6T3DrPub6uFc1agRFc23G6/jMMKqPZUVYHj3Ev9HRoCIXTZt+r/yYj2AIEWsp6OPwhE9K7LnHpQqZlNt7S1kqRbaTtAmsdp97OJUP38vHbv5Dzjvm1l6CVXTSZPaWL61dUulbGP9wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665384; c=relaxed/simple;
	bh=gj2wLdswjPOOndy4D8/Kdw2o0gqtcmzQErV30pF7frk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqBZc0njxaAhBZhrYEMwy9uz7nc2EnclIu+sIO0aoA/x5713KSWFf7AP+OGNE817VCmzyuXuhNay5zgtn9PyPRat1Q4akkpBqdx238fmFSnLRjMiFemJk26h9gAKOlO8+OkP5I/2mkzWvEBQwEP7/ACQBKtmHidAN4v1we4lUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-515caffe2bcso779418e87.0;
        Thu, 28 Mar 2024 15:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711665380; x=1712270180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyCAY2qw35sgCbOx8eCrICiPTagVb1iTRuM2XaxYdj4=;
        b=WGhWDLCGBm1IV4wE4sUBXhk2T936WQQ09AnOVJez4MroYjFGvXgF0lxlYqdHw0VFyB
         EVrG2G+cjtPWze6h4MnLdXr1rVidA0UGHEUZxBU+2EcwX228m3nmAgHKy4MaaFR+/QqW
         snEk+2gaMbDY9O8Hu8q+qe/56v4OCssm9jmNrPd/xJR1CnSEyeXx2ePmK1JGqHPX4+y8
         6f5/mc+nzEOvGQICPy7ICK4MqaFKxVd8QMsIH8IKA5TjShsqN9vksQ82qQ1BT1yL/z/l
         EJzloLyEQzE2idHIkI6pnJVqMgye94GfdoSKibqyhFA7Zkyft1Hidl9jiB50ksEh7l69
         Xg+A==
X-Forwarded-Encrypted: i=1; AJvYcCX/gtQgP0e9Ysp+5QafLbYIADNVNnW3Wdn7kvFuKzAQnGGqAGUwTSBpTvRJe3xIYR4wpnzY0ztlNxYKA9N2DpNbBrziCKF/FRKkLKY4
X-Gm-Message-State: AOJu0YwekdTsBpf2EKQz7xISJ0M9FjXM995dkRQpaE+Pt3ICU2fNI53d
	iO5g1IsKpYl+kH91CYSGRA8Jo0dlopi47MmDg/kXr2m0OikO+7fsvhxk6JwU
X-Google-Smtp-Source: AGHT+IFmTgmyxdYwbz6b3GR+1vUcgLhP4Z/3hfmPAaXWrK7zxfx88bQCeyk+KZEhZIXh6nrGosVRMw==
X-Received: by 2002:ac2:44c1:0:b0:513:e21:2a64 with SMTP id d1-20020ac244c1000000b005130e212a64mr420323lfm.31.1711665379474;
        Thu, 28 Mar 2024 15:36:19 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id e5-20020a1709061e8500b00a4e07760215sm1222580ejj.69.2024.03.28.15.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 15:36:19 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso195185366b.1;
        Thu, 28 Mar 2024 15:36:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrRyX73iL8o/HJA6LieZHuQntQ5fEyHlRowEVdE0hwqtlmmQ0qoAhq6Y5yrRTKHpfUSWpxWehGRuZ1VS3NC8iL2W+Tc4EkaQbUpGtw
X-Received: by 2002:a17:906:2813:b0:a47:4b39:ba1c with SMTP id
 r19-20020a170906281300b00a474b39ba1cmr308203ejc.39.1711665379110; Thu, 28 Mar
 2024 15:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a144b96b-6ec4-4a62-b2ab-1ed631d81544@linux.intel.com> <20240328161831.GA1568357@bhelgaas>
In-Reply-To: <20240328161831.GA1568357@bhelgaas>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Thu, 28 Mar 2024 15:36:07 -0700
X-Gmail-Original-Message-ID: <CAC41dw-wZ7eM_y5AkwW3F4dJiHYuR3YSWwap5M7FVB_fZAkg=w@mail.gmail.com>
Message-ID: <CAC41dw-wZ7eM_y5AkwW3F4dJiHYuR3YSWwap5M7FVB_fZAkg=w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Update pci_find_capability() stub return values
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 28, 2024 at 9:18=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Mar 27, 2024 at 02:49:34PM -0700, Kuppuswamy Sathyanarayanan wrot=
e:
> > On 3/27/24 11:02 AM, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > f646c2a0a668 ("PCI: Return u8 from pci_find_capability() and similar"=
) and
> > > ee8b1c478a9f ("PCI: Return u16 from pci_find_ext_capability() and sim=
ilar")
> > > updated the return type of the extern declarations, but neglected to =
update
> > > the type of the stubs used CONFIG_PCI is not enabled.
> > >
> > > Update them to match the extern declarations.
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> >
> > This change looks fine to me.
> >
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
>
> Thanks for reviewing it!
>
> > But the callers of these functions still seems to use int
> > declaration to store the output. Any reason for not changing them?
> > Like the usages in drivers/pci/pci.c?
>
> This patch is just to make the extern declarations match the stubs.
>
> No particular reason not to change users other than I didn't want to
> change the users before the declarations (to avoid warnings about
> assigning an int to a u8 or u16), and there's not a lot of value in
> changing local variables, where an int is just on the stack and works
> fine.
>
> Changing stored values in a struct would have more benefit.  I took a
> quick look and found these possibilities:
>

Agree. Thanks for clarifying it.

>   struct controller.cap_offset (drivers/pci/hotplug/shpchp.h SHPC cap)
>   struct pci_sriov.pos (drivers/pci/pci.h SR-IOV ext cap)
>   struct altera_pcie_data.cap_offset (drivers/pci/controller/pcie-altera.=
c PCIe cap)
>
>   struct tg3.msi_cap (broadcom/tg3.h MSI cap)
>   struct tg3.pcix_cap (broadcom/tg3.h PCI-X cap)
>   struct bnx2.pm_cap (broadcom/bnx2.h PM cap)
>   struct bnx2.pcix_cap (broadcom/bnx2.h PCI-X cap)
>   struct bnx2x_sriov.cap (broadcom/bnx2x/bnx2x_sriov.h SR-IOV ext cap)
>   struct amd8111e_priv.pm_cap (amd/amd8111e.c, removed [1])
>   struct pci_params.pm_cap (qlogic/qed/qed.h, removed [2])
>   struct qed_hw_sriov_info.cap (qlogic/qed/qed_sriov.h SR-IOV ext cap)
>   struct eeh_dev.pcix_cap (powerpc/include/asm/eeh.h PCI-X cap)
>   struct eeh_dev.pcie_cap (powerpc/include/asm/eeh.h PCIe cap)
>   struct eeh_dev.aer_cap (powerpc/include/asm/eeh.h AER ext cap)
>   struct eeh_dev.af_cap (powerpc/include/asm/eeh.h AF cap)
>   struct icm.vnd_cap (drivers/thunderbolt/icm.c VNDR ext cap)
>
> [1] https://lore.kernel.org/all/20240325220633.1453180-1-helgaas@kernel.o=
rg/
> [2] https://lore.kernel.org/all/20240325224931.1462051-1-helgaas@kernel.o=
rg/
>
> Bjorn

