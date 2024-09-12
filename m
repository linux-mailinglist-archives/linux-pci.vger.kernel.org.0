Return-Path: <linux-pci+bounces-13107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0D9976866
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 13:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662831F220CD
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7704219F430;
	Thu, 12 Sep 2024 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqOer7g3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A54185B5D;
	Thu, 12 Sep 2024 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142253; cv=none; b=Ab3k1e8dK1T78fshWNjjieSEY1I/2lD1r7bGSSMZ5g67iFXUBOSHJ5NdLRyYksFETty/A5JphjgIcFCDU9fv4uhuD2EsI+A6ELDN+DuZ0H0wLLDQ2OlVtHbcIWU9ifxvClzzHaBIV7vlzipH2MuZhwYLNgSR6CPT3cbe6JEDHN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142253; c=relaxed/simple;
	bh=dUXW/Wfp97X+7KVZAgCVhi9t3O3m0sqGlq3efucYFYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxLKh9gDZZ27Zm3d6ewaCrnHW+FNuooZQjSPcmNyK1qGBF08ns4FNpKHKzqqqMPSbY1FS1c1+QlQ7S03IirkZ7hiRNSCDWik9x+fXfWaRDH7/nIkdf1LpAKXckmL9JtxECXYgRBwppnqqzyoacs5i1PwpKM7Aqulrg9Xrtz3A5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqOer7g3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF77C4CEC5;
	Thu, 12 Sep 2024 11:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726142251;
	bh=dUXW/Wfp97X+7KVZAgCVhi9t3O3m0sqGlq3efucYFYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qqOer7g37vqVqQ57SAxnn+zqjAz0NnRw8o4AWzjl2Zaf4VjUjUn5+d0krmss6AYgp
	 9xLys/EI5ek477EM+nGlctMf93xgo3wnMGoO2Izm7/vJBcMo++wR4kmXprPxUn0k5X
	 IrNV0EG8nW6aV1dBgWqKr4WXnQyRoJioldfwbQmVt/zSdLRbytqAzbgOjLljsiqCVG
	 CoYv3KL+eJMmlxkvDsLpkLFN/FTbmZSvgaIF5M6f4+IFz+8MtwRyjO38cbf1HdOP2P
	 Stp1/v0VO5zQyUMkcVXRVT2fviKZ13SSJXcD+3WTetzV1UPQktU7F7jgeVQx03ZmlF
	 WV3QINzi1Jhog==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27bd815cbf1so416791fac.1;
        Thu, 12 Sep 2024 04:57:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUlfsIlk+WQdiiz3eW5Y8VYEbRU1/a9EgGaCpPH7TDTfH0ute5VlcWoBYyVUZTDd/eYVjlk0tNFQhj@vger.kernel.org, AJvYcCW5C3/Xe65yY/DTDxp6Dgej6Zvtw/14pI5JVg+oolWrbQTub1KpUDiYoezrGJpn6KIbXjDkEvuLuwXMJZg=@vger.kernel.org, AJvYcCXIHuR+64/EVpXU/sjsOwt9eU43irtJAnoC7aFOhzP2l2T7iy7uLYqal5dys1lcHpB/QTHOnT/kOyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NhmUFuur35IHr0os/28hx/rQxtizp4qOuYRROgefyygwEBMm
	T1gFUKm4wGovpJgRPSbsGxg+mcN4P9zYxO/0ZctWb3wQ6f4K+uxg4i9Y/2AmPPYV3wDf2jJf4bK
	wyekkjwX1efd26rA9opFY2iz7PCw=
X-Google-Smtp-Source: AGHT+IHYwqi8+7FVE0+YQWqGodjYIh9QYSBx7RsBTZ7qLtNETJa+BpPGqRuQNBbsJT7kah8GuHW8x3tGyLpdDHPQdqI=
X-Received: by 2002:a05:6870:80d1:b0:277:dd53:a44f with SMTP id
 586e51a60fabf-27be6b0965fmr3979688fac.6.1726142251143; Thu, 12 Sep 2024
 04:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com>
 <20240816204539.GA73302@bhelgaas> <CAJZ5v0j0ck2yKPzisggkdKTFz-AVKG7q+6WnBiiT_43VT4Fbvg@mail.gmail.com>
 <b0d8e51d-cf53-dc75-0e57-4e2e85a14827@quicinc.com>
In-Reply-To: <b0d8e51d-cf53-dc75-0e57-4e2e85a14827@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Sep 2024 13:57:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jMSrkH7jCk0Ayb21vdXjCnYHHiSqdbifNFwq2OucEMtQ@mail.gmail.com>
Message-ID: <CAJZ5v0jMSrkH7jCk0Ayb21vdXjCnYHHiSqdbifNFwq2OucEMtQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Enable runtime pm of the host bridge
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com, quic_skananth@quicinc.com, 
	quic_parass@quicinc.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Mayank Rana <quic_mrana@quicinc.com>, Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 1:52=E2=80=AFPM Krishna Chaitanya Chundru
<quic_krichai@quicinc.com> wrote:
>
>
>
> On 9/12/2024 5:12 PM, Rafael J. Wysocki wrote:
> > On Fri, Aug 16, 2024 at 10:45=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> >>
> >> [+cc Rafael, Mayank, Markus (when people have commented on previous
> >> versions, please cc them on new versions).  I'm still hoping Rafael
> >> will have a chance to chime in]
> >>
> >> On Mon, Jul 08, 2024 at 10:19:40AM +0530, Krishna chaitanya chundru wr=
ote:
> >>> The Controller driver is the parent device of the PCIe host bridge,
> >>> PCI-PCI bridge and PCIe endpoint as shown below.
> >>>
> >>>          PCIe controller(Top level parent & parent of host bridge)
> >>>                          |
> >>>                          v
> >>>          PCIe Host bridge(Parent of PCI-PCI bridge)
> >>>                          |
> >>>                          v
> >>>          PCI-PCI bridge(Parent of endpoint driver)
> >>>                          |
> >>>                          v
> >>>                  PCIe endpoint driver
> >>>
> >>> Now, when the controller device goes to runtime suspend, PM framework
> >>> will check the runtime PM state of the child device (host bridge) and
> >>> will find it to be disabled.
> >>
> >> I guess "will find it to be disabled"  means the child (host bridge)
> >> has runtime PM disabled, not that the child device is disabled, right?
> >>
> >>> So it will allow the parent (controller
> >>> device) to go to runtime suspend. Only if the child device's state wa=
s
> >>> 'active' it will prevent the parent to get suspended.
> >>
> >> Can we include a hint like the name of the function where the PM
> >> framework decides this?  Maybe this is rpm_check_suspend_allowed()?
> >>
> >> rpm_check_suspend_allowed()  checks ".ignore_children", which sounds
> >> like it could be related, and AFAICS .ignore_children =3D=3D false her=
e,
> >> so .child_count should be relevant.
> >>
> >> But I'm still confused about why we can runtime suspend a bridge that
> >> leads to devices that are not suspended.
> >
> > That should only be possible if runtime PM is disabled for those device=
s.
> >
> >>> Since runtime PM is disabled for host bridge, the state of the child
> >>> devices under the host bridge is not taken into account by PM framewo=
rk
> >>> for the top level parent, PCIe controller. So PM framework, allows
> >>> the controller driver to enter runtime PM irrespective of the state
> >>> of the devices under the host bridge. And this causes the topology
> >>> breakage and also possible PM issues like controller driver goes to
> >>> runtime suspend while endpoint driver is doing some transfers.
> >
> > Why is it a good idea to enable runtime PM for a PCIe controller?
> >
> PCIe controller can do certain actions like keeping low power state,
> remove bandwidth votes etc as part of runtime suspend as when we know
> the client drivers already runtime suspended.

Surely they can, but enabling runtime PM for devices that have
children with runtime PM disabled and where those children have
children with runtime PM enabled is a bug.

> >> What does "topology breakage" mean?  Do you mean something other than
> >> the fact that an endpoint DMA might fail if the controller is
> >> suspended?
> >>
> >>> So enable runtime PM for the host bridge, so that controller driver
> >>> goes to suspend only when all child devices goes to runtime suspend.
> >
> > This by itself makes sense to me.
> >
> >> IIUC, the one-sentence description here is that previously, the PCI
> >> host controller could be runtime suspended even while an endpoint was
> >> active, which caused DMA failures.  And this patch changes that so the
> >> host controller is only runtime suspended after the entire hierarchy
> >> below it is runtime suspended?  Is that right?
> >>
> >>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> >>> ---
> >>> Changes in v4:
> >>
> >> (Note: v4 applies cleanly to v6.10-rc1 and to v6.11-rc1 with a small
> >> offset).
> >>
> >>> - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested =
by mayank)
> >>> - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3=
d0460b49d60@quicinc.com/
> >>> Changes in v3:
> >>> - Moved the runtime API call's from the dwc driver to PCI framework
> >>>    as it is applicable for all (suggested by mani)
> >>> - Updated the commit message.
> >>> - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-=
v2-1-a849b74091d1@quicinc.com
> >>> Changes in v2:
> >>> - Updated commit message as suggested by mani.
> >>> - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1=
-1-d39660310504@quicinc.com
> >>> ---
> >>>
> >>> ---
> >>>   drivers/pci/probe.c | 4 ++++
> >>>   1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >>> index 8e696e547565..fd49563a44d9 100644
> >>> --- a/drivers/pci/probe.c
> >>> +++ b/drivers/pci/probe.c
> >>> @@ -3096,6 +3096,10 @@ int pci_host_probe(struct pci_host_bridge *bri=
dge)
> >>>        }
> >>>
> >>>        pci_bus_add_devices(bus);
> >>> +
> >>> +     pm_runtime_set_active(&bridge->dev);
> >>> +     devm_pm_runtime_enable(&bridge->dev);
> >>> +
> >>>        return 0;
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(pci_host_probe);
> >
> > This will effectively prevent the host bridge from being
> > runtime-suspended at all IIUC, so the PCIe controller will never
> > suspend too after this change.
> >
> No we are having a different observations here.
> Without this change the PCIe controller driver can go to runtime suspend
> without considering the state of the client drivers i.e even when the
> client drivers are active.
> After adding this change we see the pcie controller is getting runtime
> suspended only after the client drivers are runtime suspended which is
> the expected behaviour.

OK, but then when and how is it going to be resumed?

