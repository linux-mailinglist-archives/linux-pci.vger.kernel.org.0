Return-Path: <linux-pci+bounces-1023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC2B813CE9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 22:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E1D4B21C45
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 21:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D286DCFF;
	Thu, 14 Dec 2023 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSt1Yn+9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAE367218;
	Thu, 14 Dec 2023 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ca1e6a94a4so113600811fa.0;
        Thu, 14 Dec 2023 13:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702590436; x=1703195236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nduyr/omND1RV0m5sudW5gfsQvQK7/MOKLG7GcFC+fA=;
        b=eSt1Yn+9JYwGycxB0Ts8FaxTKk2k0Mns0fBR8mSA27FvYABFPHAlYXu5pBuUqcHGVi
         +L26Ir09fWh8+9iGbEfi90qAybqL7rdQsWFnpq/p1n8uC8vbRiOqXt5dxMYxtdLkWyhY
         o2XipONs+r/4cL/NAI8S1DAQ+Z11Nk9+6WS0bz1ZVvczrW7MbL7rQgW2Mf5NKrrH5ioF
         4WhTXe73BMAZKE2IWLUDLt4RhkMKGMLh+7oLAZu6dS+w/l2H+u5DWEcfCQH1MwQ3+PaW
         2e4qAZKdzzxcXpfpMkptBli1d/IqYmT+IncH5IKR75Ri2a3gTueppo5OHINb8TLTCXVg
         kryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702590436; x=1703195236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nduyr/omND1RV0m5sudW5gfsQvQK7/MOKLG7GcFC+fA=;
        b=uiG9SDOSZGEM4zScWgvp3shlean7y5HRg+BDvPQNCzLbegSV2s5f9+dxi2+DtUQFci
         MRr7J0sMYmfdhOESeRH7yJobdbL2U9JZcP04iB9EzPoCDfjUue+4fUbqeEz6mD9AGI0X
         vmkIJpSLKfIHLsRPiIV+N186ncXCYgSD9/JM4Xhyn6k773mpEWhi4HK7cnoRgDtx5Ppy
         zZi8wNLF67rtoNI9VHfaw5tgSIowSRB0/WrzZAOVAiqpXgLNBX58WDpX2LenbVMZbK7t
         XYmXh6tc2O6/4VR3Mpi+8OZWAGTj7uEl+T+ZcOF4vVEFEXh173XztfHultu7ub3UhQ9u
         2ZAg==
X-Gm-Message-State: AOJu0YwmJ6tk2EOQ8+sXmgNJq6oz4u53n9nAga1fK+lP2boCaTFjT2ol
	Rlaa+eA7yJfmDoCkid9tcZQKhjPZ+1u67WA5usU=
X-Google-Smtp-Source: AGHT+IG5OtOKTU/OUYcHnSY9v9R45zidnw4LXhpaahN1zHAsByoC0RbkOb9XwwfrCwZ/8wy3YjzoH7adqY3mfltG5C8=
X-Received: by 2002:a05:651c:2124:b0:2cc:25f4:6b1f with SMTP id
 a36-20020a05651c212400b002cc25f46b1fmr3368858ljq.58.1702590436032; Thu, 14
 Dec 2023 13:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214063717.992-1-mattc@purestorage.com> <20231214202856.GA1101963@bhelgaas>
 <CAPYCUs41ZfLUCLAYqfjyzXoDELkt1+6nMz6U68FAOx9TXoCbYQ@mail.gmail.com>
In-Reply-To: <CAPYCUs41ZfLUCLAYqfjyzXoDELkt1+6nMz6U68FAOx9TXoCbYQ@mail.gmail.com>
Reply-To: bjorn@helgaas.com
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Thu, 14 Dec 2023 15:47:04 -0600
Message-ID: <CABhMZUX9UVkyq5nx6qFuKJRjzHm_suRXyN=rWgqsYQ4cgV0f_A@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/portdrv: Allow AER service only for Root Ports & RCECs
To: Matthew Carlis <mattc@purestorage.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:22=E2=80=AFPM Matthew Carlis <mattc@purestorage.c=
om> wrote:
>
> Hi Bjorn.
>
> Thank you for the quick response, it looks correct that this is first in =
v6.2.  My thinking is that the kernel should use DPC on a switch port if it=
 would use it on a root port when dpc-native is not set.  I would be happy =
to post a formal patch for this.  Maybe using host->native_aer is the corre=
ct way to ensure that the kernel in this system will be using AER, maybe no=
t on this device but it will on some device. Then, we can proceed to use DP=
C on the device.
>
> I will submit something in the next few days here.

I think your message got rejected from the mailing lists because they
only accept plain-text email:
http://vger.kernel.org/majordomo-info.html

More importantly, I forgot that there is a native_dpc flag, too, so
it's not clear that testing native_aer is the right thing here.  If
native_aer *is* the right thing, it would certainly need a comment
because it would look like a typo.  I haven't investigated enough to
know what the right answer is.

Bjorn

> On Thu, Dec 14, 2023 at 12:29=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
>>
>> On Wed, Dec 13, 2023 at 11:37:17PM -0700, Matthew W Carlis wrote:
>> > Hello Any Interested
>> >
>> > Recently found that this patch had the affect of requiring us to set
>> > pcie_ports_dpc_native in order to use the kernel DPC driver with PCIe =
switch
>> > downstream ports. The kernel check for the DPC capability in portdrv.c=
 has;
>> > if pci_aer_available() and (dpc-native or using AER port service drive=
r on
>> > the device). I wonder if we couldn't do away with the requirement of t=
he
>> > AER service being used on the port if pci_aer_available() & host->nati=
ve_aer
>> > don't lie. I'm still trying to decide exactly what the condition ought=
 to
>> > look like, but it might draw from the AER service check above it. For =
example:
>> >
>> >         if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>> > -           pci_aer_available() &&
>> > -           (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AE=
R)))
>> > +           dev->aer_cap && pci_aer_available() &&
>> > +           (pcie_ports_dpc_native || host->native_aer))
>> >                 services |=3D PCIE_PORT_SERVICE_DPC;
>>
>> This sounds like it might be a regression report for d8d2b65a940b
>> ("PCI/portdrv: Allow AER service only for Root Ports & RCECs"), which
>> appeared in v6.2.  Is that true?
>>
>> If d8d2b65a940b requires you to use the "pcie_ports=3Ddpc-native" kernel
>> parameter when you didn't need it before, that sounds like a
>> regression.
>>
>> Looking at the code, that "services & PCIE_PORT_SERVICE_AER"
>> definitely looks like a problem.  We added that with
>> https://git.kernel.org/linus/4e5fad429bd1 ("PCI/DPC: Do not enable DPC
>> if AER control is not allowed by the BIOS"), but I think your
>> suggestion of checking host->native_aer is better.
>>
>> Do you want to post a formal patch for it?
>>
>> Bjorn

