Return-Path: <linux-pci+bounces-13120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC09976DC5
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 17:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F18282C78
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8FB1B12F6;
	Thu, 12 Sep 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8fK0c9y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64FC13CFA5;
	Thu, 12 Sep 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155038; cv=none; b=qoKw1UH75GKK8iHqWMXCGHpXHsBc6xgTApwc+xBc97YMP4oHJAruTB/MmiIMYjnKzSvgNfU1QwAYYY50Alx06Epavgd9vl9XRNGEwTNiVcu68TJLRdjGHKdLjBNNRUGXnXuP7ObwJ/Qj/hvNdHJFTBbpjjC3kYDV9rXTvY/EcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155038; c=relaxed/simple;
	bh=EWwVrJVmryYGTBtgOws0yOatVwhpmA5hqy9SfXjiqfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h55Wn2bb9WjMVgesYayjU3c/7P5bUQZndBO0/B26a75dyO5zl78A6tNE/4Lnnnu8gkPOE9e0TRb+vhmPMwFVEj+N6MiAyxltTWsed409BqdoKdA6t4MKUzBaMXPOPUCdY4g5ntAkhsMe/cBnlDX9PWv1FgeVr0jEIVKdE2pzc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8fK0c9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE6AC4CEC5;
	Thu, 12 Sep 2024 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726155038;
	bh=EWwVrJVmryYGTBtgOws0yOatVwhpmA5hqy9SfXjiqfI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P8fK0c9y6ix8fMUhxOR7MisI6G2sr3+ZZ4oG6nwpUTlj9xqGOSfoewBR+74iRmcc3
	 Hk8xMokLs9LClWebyYSoFZupUe1VhrZKloc8VvqcSEUTQJ7OS0dD2Ig4aYV/LAcr0Q
	 F+V1GE0bAsPsO6y5OYTIgR4cV4q2gSjpZsIpw2tTZlGOazpItSGfFFFX2xgHyKD3Wp
	 0j9Fh5JsA4T3yFQ7XAZo9j35vRiitVeBgjAn8RIfiqWRXPwyRvtRXX65orW5OQERQ3
	 Q5Fo56dfH3RaexopNODCkr5NxZ0w3p63KBszgHIKgwBEwLUfAb9U2SU/ozRt4w5AwU
	 1ytilJRCTNnsA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2780827dbafso613725fac.1;
        Thu, 12 Sep 2024 08:30:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuOy6zoSsl+B/+zGAnIr7jnHRIpeYMo1wo+ZhLXrDouLcA92DkONYD89hqwE+8+MlNMsX49g1KP2Pd@vger.kernel.org, AJvYcCVQUKqzNpofZQ8APGTczpKxz3Nphq0LOnHGmaidjz4v0BfuIY+k2JwC3hr/vOqayyEIF2Jj3k21ah9xLR0=@vger.kernel.org, AJvYcCXMVbKgZQf0Bv+dioxtkD8WldXiIgBscEw6ETZCC9kcWp403VC/h+LSJiCwjCqhrKTYdMhyQXrJqTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyF8z9FvWJZUNUukQKTR2DzkuikCy+3qmlw5TEAe4g0w0S8gnN
	6Iesi3WPd6l5QzE8xvzNuWnGo7UP6Ksw2rjwS4gA6nJ/qrX0tzunWEtBVVQuC+ESoemm5faqh2r
	VRxEHN7ovNN2oiGN/Z13MXaVgb8Q=
X-Google-Smtp-Source: AGHT+IGSct7yC0a4i2wfvfgVBg/kZJYcrY9q5/H09FBQTm/EhXW40aB7X7f7r6fiGRSPc1YJa5zS9X+X2ogQ6i8Xk70=
X-Received: by 2002:a05:6871:58f:b0:268:2189:f0d with SMTP id
 586e51a60fabf-27c3f64f3b2mr2317817fac.33.1726155037502; Thu, 12 Sep 2024
 08:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com>
 <20240816204539.GA73302@bhelgaas> <CAJZ5v0j0ck2yKPzisggkdKTFz-AVKG7q+6WnBiiT_43VT4Fbvg@mail.gmail.com>
 <b0d8e51d-cf53-dc75-0e57-4e2e85a14827@quicinc.com> <CAJZ5v0jMSrkH7jCk0Ayb21vdXjCnYHHiSqdbifNFwq2OucEMtQ@mail.gmail.com>
 <bfdc6c20-926e-533b-a8e3-0d5a3ef8be8c@quicinc.com>
In-Reply-To: <bfdc6c20-926e-533b-a8e3-0d5a3ef8be8c@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Sep 2024 17:30:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gHw=BUGn7MkRaLnAQ9ki-YDOL3SpNxd0X9YmTVG-ofzw@mail.gmail.com>
Message-ID: <CAJZ5v0gHw=BUGn7MkRaLnAQ9ki-YDOL3SpNxd0X9YmTVG-ofzw@mail.gmail.com>
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

On Thu, Sep 12, 2024 at 2:13=E2=80=AFPM Krishna Chaitanya Chundru
<quic_krichai@quicinc.com> wrote:
>
>
>
> On 9/12/2024 5:27 PM, Rafael J. Wysocki wrote:
> > On Thu, Sep 12, 2024 at 1:52=E2=80=AFPM Krishna Chaitanya Chundru
> > <quic_krichai@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 9/12/2024 5:12 PM, Rafael J. Wysocki wrote:
> >>> On Fri, Aug 16, 2024 at 10:45=E2=80=AFPM Bjorn Helgaas <helgaas@kerne=
l.org> wrote:
> >>>>
> >>>> [+cc Rafael, Mayank, Markus (when people have commented on previous
> >>>> versions, please cc them on new versions).  I'm still hoping Rafael
> >>>> will have a chance to chime in]
> >>>>
> >>>> On Mon, Jul 08, 2024 at 10:19:40AM +0530, Krishna chaitanya chundru =
wrote:
> >>>>> The Controller driver is the parent device of the PCIe host bridge,
> >>>>> PCI-PCI bridge and PCIe endpoint as shown below.
> >>>>>
> >>>>>           PCIe controller(Top level parent & parent of host bridge)
> >>>>>                           |
> >>>>>                           v
> >>>>>           PCIe Host bridge(Parent of PCI-PCI bridge)
> >>>>>                           |
> >>>>>                           v
> >>>>>           PCI-PCI bridge(Parent of endpoint driver)
> >>>>>                           |
> >>>>>                           v
> >>>>>                   PCIe endpoint driver
> >>>>>
> >>>>> Now, when the controller device goes to runtime suspend, PM framewo=
rk
> >>>>> will check the runtime PM state of the child device (host bridge) a=
nd
> >>>>> will find it to be disabled.
> >>>>
> >>>> I guess "will find it to be disabled"  means the child (host bridge)
> >>>> has runtime PM disabled, not that the child device is disabled, righ=
t?
> >>>>
> >>>>> So it will allow the parent (controller
> >>>>> device) to go to runtime suspend. Only if the child device's state =
was
> >>>>> 'active' it will prevent the parent to get suspended.
> >>>>
> >>>> Can we include a hint like the name of the function where the PM
> >>>> framework decides this?  Maybe this is rpm_check_suspend_allowed()?
> >>>>
> >>>> rpm_check_suspend_allowed()  checks ".ignore_children", which sounds
> >>>> like it could be related, and AFAICS .ignore_children =3D=3D false h=
ere,
> >>>> so .child_count should be relevant.
> >>>>
> >>>> But I'm still confused about why we can runtime suspend a bridge tha=
t
> >>>> leads to devices that are not suspended.
> >>>
> >>> That should only be possible if runtime PM is disabled for those devi=
ces.
> >>>
> >>>>> Since runtime PM is disabled for host bridge, the state of the chil=
d
> >>>>> devices under the host bridge is not taken into account by PM frame=
work
> >>>>> for the top level parent, PCIe controller. So PM framework, allows
> >>>>> the controller driver to enter runtime PM irrespective of the state
> >>>>> of the devices under the host bridge. And this causes the topology
> >>>>> breakage and also possible PM issues like controller driver goes to
> >>>>> runtime suspend while endpoint driver is doing some transfers.
> >>>
> >>> Why is it a good idea to enable runtime PM for a PCIe controller?
> >>>
> >> PCIe controller can do certain actions like keeping low power state,
> >> remove bandwidth votes etc as part of runtime suspend as when we know
> >> the client drivers already runtime suspended.
> >
> > Surely they can, but enabling runtime PM for devices that have
> > children with runtime PM disabled and where those children have
> > children with runtime PM enabled is a bug.
> >
> we are trying to enable the runtime PM of host bridge here, so that we
> can enable runtime PM of the controller.

So this is a preliminary step.  That was unclear to me.

> If this change got accepted the child here(host bridge) runtime pm will
> be enabled then i think there will no issue in enabling the runtime pm
> of the controller then.
> >>>> What does "topology breakage" mean?  Do you mean something other tha=
n
> >>>> the fact that an endpoint DMA might fail if the controller is
> >>>> suspended?
> >>>>
> >>>>> So enable runtime PM for the host bridge, so that controller driver
> >>>>> goes to suspend only when all child devices goes to runtime suspend=
.
> >>>
> >>> This by itself makes sense to me.
> >>>
> >>>> IIUC, the one-sentence description here is that previously, the PCI
> >>>> host controller could be runtime suspended even while an endpoint wa=
s
> >>>> active, which caused DMA failures.  And this patch changes that so t=
he
> >>>> host controller is only runtime suspended after the entire hierarchy
> >>>> below it is runtime suspended?  Is that right?
> >>>>
> >>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> >>>>> ---
> >>>>> Changes in v4:
> >>>>
> >>>> (Note: v4 applies cleanly to v6.10-rc1 and to v6.11-rc1 with a small
> >>>> offset).
> >>>>
> >>>>> - Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggeste=
d by mayank)
> >>>>> - Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1=
-3d0460b49d60@quicinc.com/
> >>>>> Changes in v3:
> >>>>> - Moved the runtime API call's from the dwc driver to PCI framework
> >>>>>     as it is applicable for all (suggested by mani)
> >>>>> - Updated the commit message.
> >>>>> - Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enabl=
e-v2-1-a849b74091d1@quicinc.com
> >>>>> Changes in v2:
> >>>>> - Updated commit message as suggested by mani.
> >>>>> - Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-=
v1-1-d39660310504@quicinc.com
> >>>>> ---
> >>>>>
> >>>>> ---
> >>>>>    drivers/pci/probe.c | 4 ++++
> >>>>>    1 file changed, 4 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >>>>> index 8e696e547565..fd49563a44d9 100644
> >>>>> --- a/drivers/pci/probe.c
> >>>>> +++ b/drivers/pci/probe.c
> >>>>> @@ -3096,6 +3096,10 @@ int pci_host_probe(struct pci_host_bridge *b=
ridge)
> >>>>>         }
> >>>>>
> >>>>>         pci_bus_add_devices(bus);
> >>>>> +
> >>>>> +     pm_runtime_set_active(&bridge->dev);
> >>>>> +     devm_pm_runtime_enable(&bridge->dev);
> >>>>> +
> >>>>>         return 0;
> >>>>>    }
> >>>>>    EXPORT_SYMBOL_GPL(pci_host_probe);
> >>>
> >>> This will effectively prevent the host bridge from being
> >>> runtime-suspended at all IIUC, so the PCIe controller will never
> >>> suspend too after this change.
> >>>
> >> No we are having a different observations here.
> >> Without this change the PCIe controller driver can go to runtime suspe=
nd
> >> without considering the state of the client drivers i.e even when the
> >> client drivers are active.
> >> After adding this change we see the pcie controller is getting runtime
> >> suspended only after the client drivers are runtime suspended which is
> >> the expected behaviour.
> >
> > OK, but then when and how is it going to be resumed?
>
> sorry I am not expert of the pm framework here, what we observed is when
> client drivers are trying to resume using runtime_get we see the
> controller driver is also getting resume properly with this change.
> let me dig in and see in code on how this is happening.
>
> Bjorn has this view on this change in previous v2 version[1]
> "My expectation is that adding new functionality should only require
> changes in drivers that want to take advantage of it.  For example, if
> we add runtime PM support in the controller driver, the result should
> be functionally correct even if we don't update drivers for downstream
> devices.
>
> If that's not the way it works, I suggest that would be a problem in
> the PM framework.

You can say so, but that's how it goes.

If there are any devices with runtime PM disabled in a dependency
chain, the runtime PM framework cannot follow that chain as a whole.
If enabling runtime PM for a device leads to this situation, it is not
correct.

> The host bridge might be a special case because we don't have a
> separate "host bridge" driver; that code is kind of integrated with
> the controller drivers.  So maybe it's OK to do controller + host
> bridge runtime PM support at the same time, as long as any time we add
> runtime PM to a controller, we sure it's also set up for the host
> bridge"

I think that you can enable runtime PM for host bridge devices in
general, as long as they don't need to be resumed without resuming any
of their children.

If that's the case, resuming one of its children will also cause the
host bridge to resume and all should be fine, although you also need
to ensure that system-wide suspend handling is in agreement with this.

I would suggest calling pm_runtime_no_callbacks() for the host bridge devic=
e.

> [1] https://lore.kernel.org/all/20240307215505.GA632869@bhelgaas/

And this is the information to put into your patch changelog:

1. It is a property of the runtime PM framework that it can only
follow continuous dependency chains.  That is, if there is a device
with runtime PM disabled in a dependency chain, runtime PM cannot be
enabled for devices below it and above it in that chain both at the
same time.

2. Because of the above, in order to enable runtime PM for a PCIe
controller device, one needs to ensure that runtime PM is enabled for
all devices in every dependency chain between it and any PCIe endpoint
(as runtime PM is enabled for PCIe endpoints).

3. This means that runtime PM needs to be enabled for the host bridge
device, which is present in all of these dependency chains.

4. After this change, the host bridge device will be runtime-suspended
by the runtime PM framework automatically after suspending its last
child and it will be runtime-resumed automatically before resuming its
first child which will allow the runtime PM framework to track
dependencies between the host bridge device and all of its
descendants.

Thanks!

