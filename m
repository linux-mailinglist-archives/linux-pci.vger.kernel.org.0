Return-Path: <linux-pci+bounces-25243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E313A7A91A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 20:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D6D1895E0F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 18:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE412253330;
	Thu,  3 Apr 2025 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBEfLS5p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C054824E012;
	Thu,  3 Apr 2025 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704123; cv=none; b=f7x0/lxsdoeaO6r/HrZNRFqV9oXsqzpexDr/g7RFXFYlJjo+upZr8YbBOaMpi9vzXk0g05IGQcKGfHMT7QNW53XS+f2PUpCNl8IwefonyOlcidKqYi3LLhQFEsTWEdzNiuCWLLWnGZggYumQdN04Jk6kFVTgJaTySVK4HhnS1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704123; c=relaxed/simple;
	bh=IHvXA/4ffeiIOCG6zsvNkcvaxlsrzA7Y1aHdH6cANCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr3n2gtqzdrgXUYGBpELegmv007/qY79bUTwWTr7fR5IK6FsaVgHN0K1PqPpAt2uOEepZm/dSv+OAU9JWc+GihiLEPKI0oY0W8lWMIwgeXO3/i5fEVshtebRNHbnrxfTUq9SLlJDhUplG5g5eNDLn0LP/3PosibTIyz1TcdAdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBEfLS5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED0DC4AF0B;
	Thu,  3 Apr 2025 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743704123;
	bh=IHvXA/4ffeiIOCG6zsvNkcvaxlsrzA7Y1aHdH6cANCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fBEfLS5pKLgOq5wdDD9ngMrdMHzFXELzKtddY+e61np67N9CTcG0zNfLITOjRCP6O
	 087dp2dAslrH+AOZIqccVFUCpDFZrWCzxtXsXSCagoch0CWdahQ76j+5mwtn01o1pW
	 bBW6mNNEgFKDbb+3FVCUB5g2ZcrUnkuxyfb/VqoP0F8e+07P0YYxlKM8iwBF5YRIoY
	 iw68bPwd2VS6d6EbH/2Mfr/rSyXjKtxoMwN2sSlT/rlN3GrBAjP0jouVJ+tVpCulah
	 NwUUL2GT1Fol9OqhxE9rznWTSid/ptgfk5PzwTZxRN7AcnaS9mZVkvTTSbqxAVjlO1
	 kwUGuYwmGlRFg==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c13802133so347076a34.3;
        Thu, 03 Apr 2025 11:15:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnbb+glfytaPFyVgYxFI96XaAMu4w0rgm3YB2+HTjkuq6y7zM/YNUVYw/10uDssZA4nqeT5dZBZ5ny@vger.kernel.org, AJvYcCXONoM3ODlCwtb93AWaKqFk4bsu2Vj1Ds+7UzTrNd1iFIvQGxZuR9vEDRUj+BvrHEfaKXO0R+1N4MB6@vger.kernel.org
X-Gm-Message-State: AOJu0YxOn3hk+CGRVIENn0v1QMGe1Il86gKeht38Qw51aHNQm2xNawlw
	OM06FAKJP/+QUIcJREWWbYObA2iO3GrY6KfP0A7LOziF+YO+h4vUcv84QnnZ+VY7pjMPizwTILO
	YXWe8F2uxbjClUxf2MqUT0WsP8YQ=
X-Google-Smtp-Source: AGHT+IGrK2wpNc2eDmJ11ljJ/U6Ot5pRbJzbsDnWyAxDlhKPPT5nv5jHvdx5iRteP505Sf/T8C/Mb2YQFbcuL7ovc1E=
X-Received: by 2002:a05:6830:6e97:b0:72b:9387:84b2 with SMTP id
 46e09a7af769-72e36973f5fmr392572a34.27.1743704122428; Thu, 03 Apr 2025
 11:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401153225.96379-4-anshuman.gupta@intel.com>
 <20250401201349.GA1676401@bhelgaas> <CAJZ5v0irNFX6dFrStinNXamrhP143=yjjfx4iK0pY+-dTEkviw@mail.gmail.com>
 <CY5PR11MB6211021207DE5ECAA43BF26595AE2@CY5PR11MB6211.namprd11.prod.outlook.com>
 <CAJZ5v0inCpM2UhzZ_pD52S0Hf8aaEMa40CyE-dwzVmO1n3PMwA@mail.gmail.com> <MN0PR11MB6207F55ABAA2187609BB872695AE2@MN0PR11MB6207.namprd11.prod.outlook.com>
In-Reply-To: <MN0PR11MB6207F55ABAA2187609BB872695AE2@MN0PR11MB6207.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Apr 2025 20:15:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gKBYa_N-dA1JwF0yVbc6XSmQEy1LpVytDM7uc9kbZ8fA@mail.gmail.com>
X-Gm-Features: AQ5f1Jp4RPnbi6Bs3PiB6NEgqUjb48BxQsVIREqIl0ymQIEeIELbrdMMQIZxQPk
Message-ID: <CAJZ5v0gKBYa_N-dA1JwF0yVbc6XSmQEy1LpVytDM7uc9kbZ8fA@mail.gmail.com>
Subject: Re: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
To: "Gupta, Anshuman" <anshuman.gupta@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, 
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>, 
	"De Marchi, Lucas" <lucas.demarchi@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, 
	"Nilawar, Badal" <badal.nilawar@intel.com>, "Gupta, Varun" <varun.gupta@intel.com>, 
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>, "Shankar, Uma" <uma.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 6:09=E2=80=AFPM Gupta, Anshuman <anshuman.gupta@inte=
l.com> wrote:
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Thursday, April 3, 2025 7:04 PM
> > To: Gupta, Anshuman <anshuman.gupta@intel.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Bjorn Helgaas
> > <helgaas@kernel.org>; intel-xe@lists.freedesktop.org; linux-
> > acpi@vger.kernel.org; linux-pci@vger.kernel.org; lenb@kernel.org;
> > bhelgaas@google.com; ilpo.jarvinen@linux.intel.com; De Marchi, Lucas
> > <lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; Nil=
awar,
> > Badal <badal.nilawar@intel.com>; Gupta, Varun <varun.gupta@intel.com>;
> > ville.syrjala@linux.intel.com; Shankar, Uma <uma.shankar@intel.com>
> > Subject: Re: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
> >
> > On Thu, Apr 3, 2025 at 1:30=E2=80=AFPM Gupta, Anshuman
> > <anshuman.gupta@intel.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > Sent: Wednesday, April 2, 2025 4:54 PM
> > > > To: Bjorn Helgaas <helgaas@kernel.org>; Gupta, Anshuman
> > > > <anshuman.gupta@intel.com>
> > > > Cc: intel-xe@lists.freedesktop.org; linux-acpi@vger.kernel.org;
> > > > linux- pci@vger.kernel.org; rafael@kernel.org; lenb@kernel.org;
> > > > bhelgaas@google.com; ilpo.jarvinen@linux.intel.com; De Marchi, Luca=
s
> > > > <lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>;
> > > > Nilawar, Badal <badal.nilawar@intel.com>; Gupta, Varun
> > > > <varun.gupta@intel.com>; ville.syrjala@linux.intel.com; Shankar, Um=
a
> > > > <uma.shankar@intel.com>
> > > > Subject: Re: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
> > > >
> > > > On Tue, Apr 1, 2025 at 10:13=E2=80=AFPM Bjorn Helgaas <helgaas@kern=
el.org>
> > wrote:
> > > > >
> > > > > On Tue, Apr 01, 2025 at 09:02:16PM +0530, Anshuman Gupta wrote:
> > > > > > Adding a notifier to notify all PCIe child devices about the
> > > > > > block main power removal. It is needed because theoretically
> > > > > > multiple PCIe Endpoint devices on same Root Port can request fo=
r
> > > > > > AUX power and _DSM method can return with 80000000h signifies
> > > > > > that the hierarchy connected via the slot cannot support main
> > > > > > power removal when in D3Cold.
> > > > >
> > > > > I wish the spec used different language here.  "D3cold" *means*
> > > > > "main power is removed" (PCIe r6.0, sec 5.3.1.4.2), so it doesn't
> > > > > make sense to say that "the slot cannot support main power remova=
l
> > > > > when in D3cold".  If a device is in D3cold, its main power has
> > > > > been removed by definition.
> > > > >
> > > > > I suppose the spec is trying to say if the driver has called this
> > > > > _DSM with 80000000h, it means the platform must not remove main
> > > > > power from the device while the system is in S0?  Is that what yo=
u
> > > > > think it means?
> > > > >
> > > > > The 2h return value description says it "indicates that the
> > > > > platform will not remove main power from the slot while the syste=
m is in
> > S0,"
> > > > > so I guess that must be it.
> > > > >
> > > > > In this series, pci_acpi_aux_power_setup() only supplies a 16-bit
> > > > > aux_pwr_limit value, so the driver cannot *request* that the
> > > > > platform not remove main power.
> > > > >
> > > > > So I guess the only scenario where the _DSM returns 80000000h is
> > > > > when the platform itself or other devices prevent the removal of
> > > > > main power.  And the point of the notifier is to tell devices tha=
t
> > > > > their main power will never be removed while the system is in S0.
> > > > > Is that right?
> > > > >
> > > > > > This may disrupt functionality of other child device.
> > > > >
> > > > > What sort of disruption could happen?  I would think that if the
> > > > > _DSM returns 80000000h, it just means the device will not have
> > > > > main power removed, so it won't see that power state transition.
> > > > > The only "disruption" would be that we're using more power.
> > > > >
> > > > > > Let's notify all PCIe devices requested Aux power resource and
> > > > > > Let PCIe End Point driver handle it in its callback.
> > > > >
> > > > > Wrap to fill 75 columns.
> > > > >
> > > > > s/Adding/Add/
> > > > > s/Let's notify/Notify/
> > > > > s/and Let/and let/
> > > > > s/End Point/Endpoint/ (several places here and below)
> > > > >
> > > > > > Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> > > > > > ---
> > > > > >  drivers/pci/pci-acpi.c   | 34 +++++++++++++++++++++++++++++++-=
--
> > > > > >  include/linux/pci-acpi.h | 13 +++++++++++++
> > > > > >  2 files changed, 44 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > > > > index
> > > > > > 04149f037664..d1ca1649e6e8 100644
> > > > > > --- a/drivers/pci/pci-acpi.c
> > > > > > +++ b/drivers/pci/pci-acpi.c
> > > > > > @@ -1421,6 +1421,32 @@ static void
> > > > > > pci_acpi_optimize_delay(struct
> > > > pci_dev *pdev,
> > > > > >       ACPI_FREE(obj);
> > > > > >  }
> > > > > >
> > > > > > +static BLOCKING_NOTIFIER_HEAD(pci_acpi_aux_power_notify_list);
> > > > > > +
> > > > > > +/**
> > > > > > + * pci_acpi_register_aux_power_notifier - Register driver
> > > > > > +notifier
> > > > > > + * @nb: notifier block
> > > > > > + *
> > > > > > + * This function shall be called by PCIe End Point device
> > > > > > +requested the Aux
> > > > > > + * power resource in order to handle the any scenario
> > > > > > +gracefully when other
> > > > > > + * child PCIe devices Aux power request returns with No main
> > > > > > +power
> > > > removal.
> > > > > > + * PCIe devices which register this notifier shall handle No
> > > > > > +main power
> > > > > > + * removal scenario accordingly.
> > > > >
> > > > > This would actually be called by the *driver* (not by the device)=
.
> > > >
> > > Hi Rafael,
> > > Thanks for review.
> > > > Apart from this, there seems to be a design issue here because it
> > > > won't notify every driver that has requested the Aux power, just th=
e
> > > > ones that have also registered notifiers.
> > > IMHO that is what intended, if any device has functional impact in ou=
r
> > > case it is INTEL GPU has functional impact if other PCIe device's (on
> > > same root port) Aux Power request returns with 0x2. We need to handle
> > such case to handle it gracefully.
> > > >
> > > > So this appears to be an opt-in from getting notifications on Aux
> > > > power request rejection responses to requests from other drivers
> > > > requesting Aux power for the same Root Port, but the changelog of
> > > > the first patch already claimed that the aggregation of requests wa=
s
> > > > not supported.  So if only one driver will be allowed to request th=
e
> > > > Aux power for the given Root Port, why would the notifiers be neces=
sary
> > after all?
> > > >
> > > Please guide us, if we remove the above limitation from the commit lo=
g.
> > > Then do we have any design issue with notifier approach ?
> >
> > Exactly like I said: If you only allow one driver to use the _DSM to re=
quest the
> > Aux power from a given Root Port, it will have all of the information a=
nd does
> > not need to be notified about any changes.  Since no one else is allowe=
d to use
> > this interface for that Root Port, no one else will need a notifier eit=
her.  For this
> > to work, you need some mechanism allowing drivers to claim the interfac=
e so
> > no one else can use it (on a per Root Port basis) which is currently mi=
ssing
> > AFAICS.
>
> IMHO such kind of mechanism will require to add Root Port specific data s=
tructure to claim
> the interface. But real problem is the criteria  to claim the interface.
> Is first PCIe Non-Bridge Endpoint Function 0 driver can be criteria  to c=
laim the
> Interface. Or first come and first serve approach ?

IMV, the first PCIe Non-Bridge Endpoint Function 0 driver approach
would be sort of fragile and cumbersome to enforce.

First come, first serve is much simpler and should be sufficient for now AF=
AICS.

> > I think that this is the option you want to pursue.
> >
> We will prefer to stick with this option, if it can guaranty that XeKMD w=
ill the only driver
> allowed to request Aux power to enable VRSR.
>
> > OTOH, if you want to allow multiple drivers to use this interface for t=
he same
> > Root Port, you need to aggregate the requests (as required by the spec =
IIUC) in
> > the first place, or else the users can override each other's request.  =
In that case
>
> INHO how Linux Kernel will aggregate the Aux Power request, without knowi=
ng the
> total Aux power budget. AFAIU aggregated Aux power request without knowle=
dge of total
> power budget can also be denied by BIOS[1].
> Therefore how aggregation can be useful ?

Say two drivers request the Aux power from the same Root Port and each
of them passes a limit sufficient for its device.  Without
aggregation, what guarantees that the last limit passed will be
sufficient for both devices?

Also see the spec provision regarding retries below.

> [1]As per r3.3 Section 4.6.10
> Platform Firmware Budgeting of Aux Power Availability:
> Platform firmware must not grant more power than what is available within=
 the system. For
> example, a board may be designed with four CEM slots (one x16 slot, one x=
4 slot, and two x1
> slots). The board may implement a power delivery circuit capable of suppl=
ying 2 W of power for
> the 3.3 Vaux rail supplying all 4 slots. The 3.3 Vaux pins on each CEM sl=
ot can supply 1 W each.
> Platform firmware may use the retry mechanism to prioritize requests from=
 devices in preferred
> slots in the following manner:
>
> -> Requests from a device in the highest priority slot (e.g., x16) are gr=
anted immediately, if
> available.
>
> -> Requests from devices in lower priority slots (e.g., x2, x1) are initi=
ally rejected, with a retry
> interval inversely proportional to the slot priority. For instance, if th=
e x2 slot is higher priority
> than the x1 slots, so the retry interval for the x2 slot may be 4 seconds=
, and the x1 slots may be
> 8 and 10 seconds.
>
> ->As requests are granted, the granted values are subtracted from the ava=
ilable budget.
>  Retried requests are granted based on the remaining power budget or deni=
ed if insufficient
> power budget is available. Another retry is not permitted.
>
> -> When there is insufficient power budget for a request, firmware may ch=
oose to keep main
> power on and return no power removal (2h).

This means that the platform firmware is supposed to do its own
aggregation, but at the system (board) level, not at the Root Port
level.

The algorithm is described above and my understanding of it is that
once a request has been granted, it cannot be retracted later.  Also
it appears to assume a 1:1 correspondence between PCIe slots and Root
Ports.

The guys who haven't been granted their requests at once may be asked
to try again later and there may not be enough Aux power for the last
guys at all, so they will not get it and they will stay on the main
power.  And again, this appears to be at the Root Port granularity.

