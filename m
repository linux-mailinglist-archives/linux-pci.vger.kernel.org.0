Return-Path: <linux-pci+bounces-25238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B13DA7A454
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 15:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E875E176126
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 13:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1D024BC09;
	Thu,  3 Apr 2025 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLSTksYr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A633F7;
	Thu,  3 Apr 2025 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688142; cv=none; b=pMS8JjiMBZbPtVMawBFwIaVQZcuSa1r5H+idTQf24sca6TBb8evD2vTULIZvf4phYZzXlZ6FMufoDnFWzMd5xKJVZdcmDjjsBTe6dsoKqBDip/mec4yaGkas2xDr64s0Qxg8HQOCyJoditH8HJFIVwxGFwlOibBaaBIjipH/wPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688142; c=relaxed/simple;
	bh=lwmB6F4GHG5sQgDjJUpeneBFi7U2fOx9rdT4rpecV18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ji2K7sYrQEnTvBe4DOhQvuYe9TaRxx1Rz2RsCRlgX/bvQTFkeQSWxg1mXhNwYl6SMwSebWFAxeg7tEmTXHYaX5vNnEdqc7NYExiSZ2u5VMte6dsN3NM93q6cOOY/4rx4ypOW2DXwpheK9dgsR8slomwLrBaHXEF+DNZ9iSMB39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLSTksYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CCDC4CEEB;
	Thu,  3 Apr 2025 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743688141;
	bh=lwmB6F4GHG5sQgDjJUpeneBFi7U2fOx9rdT4rpecV18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eLSTksYraA7EQgSpq+dTxMeHGYfb9rPX/IhLg1LCtxu+wPzGEucXK+Dl4qOOQnzH5
	 3RzQI97RD2RuOhPM4w2sURynJj2DZMOw7+ZjVjsLsfueBAW+/3qkFFKEkyCiNU5zCd
	 irL3JqQhZjLkzTRcIzVF4djDapQUBBP4/IccgLP33dNT3JUlzdQFdwmsgkhGLUUT/5
	 OyrFGoM7J4/52epoEpb3u0S8Iq7r1Rv7HxtljfdFtZUFqZNfUINn/2Vp01qfWFpCAC
	 ewP/RI/WjwOwSFNIbwLVAEf1AVPc0aF3Fpu/HQY89jURFFURJ91wMQEuBvu+2aBr5H
	 ZdcT+dmXeYT+g==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72b0626c785so745628a34.2;
        Thu, 03 Apr 2025 06:49:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJi+AiJKrFpAcysVGKtmcHc1VRL53NPg7uQPdeCWCCm42oxQrQHELKLRVMCBbsCPpvc1LxRwVxF3Vd@vger.kernel.org, AJvYcCXiEQ7EnQ0Vh/j6FKJKUoax6jB367Ned9sxraYtr+3HWdK6cj8/v9R6vAKXmAILtn2gp2kCnyRx5FMC@vger.kernel.org
X-Gm-Message-State: AOJu0YwxZz77i16uJa/QzqGkh3+Qd+0pns8u1HD3yi+Anp2hqgEDjPNf
	urzxI5r5GXxghMA3wxt7uTB4g/Jl+w1RpBc5t05VK7C03/7VvpsFmT+7rNZ0xpnamZLerUOg/Xd
	NEaPaHBgR3prM3NX9AB0Vqyn5LYc=
X-Google-Smtp-Source: AGHT+IGFFBEXI7EF5Fv52eA1QamO5Y6TgbCLD9jR80WmbXowftmeK2ZUO085iRfrMqwSLTACoKYG8TGm+G489KvTm6M=
X-Received: by 2002:a05:6830:2714:b0:727:2f79:ce33 with SMTP id
 46e09a7af769-72c6387fce3mr12958802a34.28.1743688140890; Thu, 03 Apr 2025
 06:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401153225.96379-4-anshuman.gupta@intel.com>
 <20250401201349.GA1676401@bhelgaas> <CY5PR11MB6211BE6482B046D8946E1DA995AE2@CY5PR11MB6211.namprd11.prod.outlook.com>
In-Reply-To: <CY5PR11MB6211BE6482B046D8946E1DA995AE2@CY5PR11MB6211.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Apr 2025 15:48:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hSK0mgM3ZOj4q38RHpw+v7XQTRk-bRnmEkxUuxJb=Mww@mail.gmail.com>
X-Gm-Features: AQ5f1Jp_OtvVGdMkrSPKp7NTPWPoCB3U59cyfULUJvD1G9MOwgsmdilsIk_FSJc
Message-ID: <CAJZ5v0hSK0mgM3ZOj4q38RHpw+v7XQTRk-bRnmEkxUuxJb=Mww@mail.gmail.com>
Subject: Re: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
To: "Gupta, Anshuman" <anshuman.gupta@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"lenb@kernel.org" <lenb@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>, 
	"De Marchi, Lucas" <lucas.demarchi@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, 
	"Nilawar, Badal" <badal.nilawar@intel.com>, "Gupta, Varun" <varun.gupta@intel.com>, 
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, "Shankar, Uma" <uma.shankar@intel.com>, 
	"Nasim, Kam" <kam.nasim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 9:57=E2=80=AFAM Gupta, Anshuman <anshuman.gupta@inte=
l.com> wrote:
>
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Wednesday, April 2, 2025 1:44 AM
> > To: Gupta, Anshuman <anshuman.gupta@intel.com>
> > Cc: intel-xe@lists.freedesktop.org; linux-acpi@vger.kernel.org; linux-
> > pci@vger.kernel.org; rafael@kernel.org; lenb@kernel.org;
> > bhelgaas@google.com; ilpo.jarvinen@linux.intel.com; De Marchi, Lucas
> > <lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; Nil=
awar,
> > Badal <badal.nilawar@intel.com>; Gupta, Varun <varun.gupta@intel.com>;
> > ville.syrjala@linux.intel.com; Shankar, Uma <uma.shankar@intel.com>
> > Subject: Re: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
> >
> > On Tue, Apr 01, 2025 at 09:02:16PM +0530, Anshuman Gupta wrote:
> > > Adding a notifier to notify all PCIe child devices about the block
> > > main power removal. It is needed because theoretically multiple PCIe
> > > Endpoint devices on same Root Port can request for AUX power and _DSM
> > > method can return with 80000000h signifies that the hierarchy
> > > connected via the slot cannot support main power removal when in
> > > D3Cold.
> >
> > I wish the spec used different language here.  "D3cold" *means* "main p=
ower
> > is removed" (PCIe r6.0, sec 5.3.1.4.2), so it doesn't make sense to say=
 that
> > "the slot cannot support main power removal when in D3cold".  If a devi=
ce is
> > in D3cold, its main power has been removed by definition.
> >
> > I suppose the spec is trying to say if the driver has called this _DSM =
with
> > 80000000h, it means the platform must not remove main power from the
> > device while the system is in S0?  Is that what you think it means?
> Thanks for review.
> what I understand here, S0 term essentially means here PCIe Runtime PM or=
 s2idle
> (both refers system is S0 state). AFAIU during both Runtime PM and s2ilde=
 path
> Root Port can transition  to D3Cold if it support _PR3.
> I observed Root Port either have D0 or D3Cold state.
> /sys/bus/pci0/devices/$root_port_bdf/firmware_node/real_power_state
>
> Driver can disable the D3cold by pci_d3cold_disable(), so I wonder there =
is no use
> case driver calling _DSM 0xa with 80000000h.
> PCIe specs shall be simplified by removal of value 80000000h from _DSM 0x=
a Arg.
> >
> > The 2h return value description says it "indicates that the platform wi=
ll not
> > remove main power from the slot while the system is in S0,"
> > so I guess that must be it.
> >
> > In this series, pci_acpi_aux_power_setup() only supplies a 16-bit
> > aux_pwr_limit value, so the driver cannot *request* that the platform n=
ot
> > remove main power.
> Yeah but that value Xe driver received from GPU firmware.
> >
> > So I guess the only scenario where the _DSM returns 80000000h is when t=
he
> > platform itself or other devices prevent the removal of main power.  An=
d the
> > point of the notifier is to tell devices that their main power will nev=
er be
> > removed while the system is in S0.  Is that right?
> Yes the notifier will safeguard against the use case if some other PCIe d=
evice
> calls _DSM 0xa with Arg3 Value of 80000000h or its request return with 0x=
2h.
> >
> > > This may disrupt functionality of other child device.
> >
> > What sort of disruption could happen?  I would think that if the _DSM r=
eturns
> > 80000000h, it just means the device will not have main power removed, s=
o it
> > won't see that power state transition.  The only "disruption" would be =
that
> > we're using more power.
>
> Let's say during Xe Driver initialization BIOS firmware grants the Xe dri=
ver
> Aux power request successfully.

Slightly OT, but if you do it at init time, you also need to do it
after hibernation because the original ini-time request may not
survive it.

> Xe driver will prepare to transition D3Cold state with VRAM Self Refresh.
> VRAM Self Refresh relies on vram shall derive power from Aux power.
> But later at any point if some other PCIe device under same root port
> Calls _DSM either with 080000000h or _DSM returns with 02h, will
> Block the main power removal.

As I said in the previous message, this cannot happen if only one
driver at a time is allowed to request the Aux power on a given Root
Port.

If multiple drivers are allowed to do it, aggregation of requests is necess=
ary.

> But Xe driver is unaware of it can still
> program the VRAM Self Refresh and that make VRAM to derive power
> from Aux and that will disrupt the GPU VRAM as there is no switch to Aux

This is a rather unfortunate and counter-intuitive design decision
IMV.  If the main power is still there, I'd expect the VRAM Self
Refresh to use it instead of the Aux power.

