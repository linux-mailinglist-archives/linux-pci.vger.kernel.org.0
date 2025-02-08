Return-Path: <linux-pci+bounces-21017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F903A2D5FC
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 13:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264BA3A8780
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3372451D2;
	Sat,  8 Feb 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1txwx7R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BF10E5;
	Sat,  8 Feb 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739016632; cv=none; b=Ra5AkgyOzyZUl1n1FiAWnUJY6JqWM8yimSZ46sTtBk58RoEtYqCJL4qPszViuqW1dsudAX/r2tDrw6rR3EayVxELqBn5+kinRfA8r5CKqlNghDs1WxOe5hr9Zo5t9okhYOnUXhS7vw9UJPDNz9aYpsBfjHQI/HTRJ4uVSh9AOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739016632; c=relaxed/simple;
	bh=6oZ5OWghXld3PvdlVB3z/5/NzoGFEbUv/gndN8DA9PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1aV639lt3asuVwqRqWrLjih+7l2tpn0Z2Glbgmha8HIOtOW1GfPOkjrtw3ZD4fRmND0CUy4z37wKi5B+LBC1cC+jVymbTE+8E+lX/8dXwGjXArUp/jZkcDlnlFDjcRu35rIlSMpom808FE4F6GWgKipn0u4Kay7ZI5RJ6CsYjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1txwx7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111C4C4CEE2;
	Sat,  8 Feb 2025 12:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739016632;
	bh=6oZ5OWghXld3PvdlVB3z/5/NzoGFEbUv/gndN8DA9PU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a1txwx7Rz9vQvHyhAdvFHeZ6lkokhOXDlJL8omqvwEKYX+38riZy8Xjas/SHNpg4+
	 XY0FJObJ9szhV2hZtu5LFxZsVBLtoe2Ickyk63Ed1lEy9C7xwRS8Hyh3R8ksXrV+ci
	 vn3t1Sev5NCCVvJfSs6eYuyp9CS7VP54GfsuX2aBRoda9neyN+mfXcvRow1yL0Inqr
	 /2xK95tBVdHHiURH+NhE98wyBJFBJWADMSoqDyxGdbnqMHgCvcJHou5CkJJNXoNFQI
	 xdTRSdY4iY4EWebk088ChTuvcI70T/wtpxGtGasNrMZYC18LP7DNm5ydTS7UsjLGcQ
	 MVvahGwyA7wmA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5fa2685c5c0so1172049eaf.3;
        Sat, 08 Feb 2025 04:10:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDGNMwHi7x9c3Esu0mJTCvEczkbvsH6UZYYutWldn8uQzGSlzt9IixLPxL8FQMv+ZT2jvqMWWvoN/Nh0M=@vger.kernel.org, AJvYcCWviU3Q4Apxen2INMQA6BQ0GgzqXoNNMhfa/wYBzYtEul5G70nmw3RtV8asnojHlJGVkWNpXDg8SuXMOJQ=@vger.kernel.org, AJvYcCX6T6CfvVib1Ya/cpt2AwrSd0vcwHP/A9CwkY+bZe0p1WJC327U/AK0XD1esfGDncHwSaWVr8RCPJo=@vger.kernel.org, AJvYcCXJTRdHbwA/9xUhbqrY83uwjwsdMTKqswLnIsMrtydsWD+6/17KsXtN7yI0Rx1UdPTiX6Q+CDeompaT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5gR2xQmhiwc0TOJYbU1JRdrA+VGVWzgB+WFkCDJfA91RtUGUS
	9JoomuWQ4gUepkm7xx8ui0rzafksRyJuz52cLMYI3SaQl10oyxtMLawLnemePW1iC/ILj1AQzjG
	SXJu1qDILjQ0VNiz1sm9fXF9ZLmg=
X-Google-Smtp-Source: AGHT+IFq6fmcRzmDyKnw2OvsUb4nru+t3ZEYcOH4DS7zxRquZD+pDngpr41ZsPvbiECMzLbO5HL5S1HnGi5n1h9xpLw=
X-Received: by 2002:a05:6820:827:b0:5fa:73ed:de8 with SMTP id
 006d021491bc7-5fc5e71b079mr4287646eaf.6.1739016631273; Sat, 08 Feb 2025
 04:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12619233.O9o76ZdvQC@rjwysocki.net> <1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com>
 <Z6YPpbRF_U0TxAbf@hovoldconsulting.com> <Z6YcjFBWAVVVANf2@hovoldconsulting.com>
 <CAJZ5v0iHjkfoh2A+hAmMCTG9_nBcJrsRYFD0Hp4ZChYUo7bFEg@mail.gmail.com>
 <Z6YviAFD4Az3EIBa@hovoldconsulting.com> <Z6Y0NlW40yHTIlzm@hovoldconsulting.com>
 <CAJZ5v0gBCQW2wwdB+4SyBXtqiis2k1Z2L8SOVKwcVbNxPHqvYA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gBCQW2wwdB+4SyBXtqiis2k1Z2L8SOVKwcVbNxPHqvYA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 8 Feb 2025 13:10:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gUcy4V-iztFumRZDUArQHiXE01vW3uC8Y01xnBD6Xi0Q@mail.gmail.com>
X-Gm-Features: AWEUYZl8o4c7RwAXBNYFREaNrw5dxg8_D3B3WawlN0Lh8IZl08GlNF1Jk9NXMxk
Message-ID: <CAJZ5v0gUcy4V-iztFumRZDUArQHiXE01vW3uC8Y01xnBD6Xi0Q@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
To: Johan Hovold <johan@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Kevin Xie <kevin.xie@starfivetech.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000090f20d062da05cec"

--00000000000090f20d062da05cec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 7:14=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Fri, Feb 7, 2025 at 5:26=E2=80=AFPM Johan Hovold <johan@kernel.org> wr=
ote:
> >
> > On Fri, Feb 07, 2025 at 05:06:32PM +0100, Johan Hovold wrote:
> > > On Fri, Feb 07, 2025 at 04:41:18PM +0100, Rafael J. Wysocki wrote:
> > > > On Fri, Feb 7, 2025 at 3:45=E2=80=AFPM Johan Hovold <johan@kernel.o=
rg> wrote:
> > > > > On Fri, Feb 07, 2025 at 02:50:29PM +0100, Johan Hovold wrote:
> > >
> > > > > Ok, so the driver data is never set and runtime PM is never enabl=
ed for
> > > > > this simple bus device, which uses pm_runtime_force_suspend() for=
 system
> > > > > sleep.
> > > >
> > > > This is kind of confusing.  Why use pm_runtime_force_suspend() if
> > > > runtime PM is never enabled and cannot really work?
> > >
> > > It's only done for some buses that this driver handles. The driver is
> > > buggy; I'm preparing a fix for it regardless of the correctness of th=
e
> > > commit that now triggered this.
> >
> > Hmm. The driver implementation is highly odd, but actually works as lon=
g
> > as the runtime PM status is left at 'suspended' (as
> > pm_runtime_force_resume() won't enable runtime PM unless it was enabled
> > before suspend).
> >
> > So we'd strictly only need something like the below if we are going to
> > keep the set_active propagation.
>
> I think you are right.
>
> > diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
> > index 5dea31769f9a..d8e029e7e53f 100644
> > --- a/drivers/bus/simple-pm-bus.c
> > +++ b/drivers/bus/simple-pm-bus.c
> > @@ -109,9 +109,29 @@ static int simple_pm_bus_runtime_resume(struct dev=
ice *dev)
> >         return 0;
> >  }
> >
> > +static int simple_pm_bus_suspend(struct device *dev)
> > +{
> > +       struct simple_pm_bus *bus =3D dev_get_drvdata(dev);
> > +
> > +       if (!bus)
> > +               return 0;
> > +
> > +       return pm_runtime_force_suspend(dev);
> > +}
> > +
> > +static int simple_pm_bus_resume(struct device *dev)
> > +{
> > +       struct simple_pm_bus *bus =3D dev_get_drvdata(dev);
> > +
> > +       if (!bus)
> > +               return 0;
> > +
> > +       return pm_runtime_force_resume(dev);
> > +}
> > +
> >  static const struct dev_pm_ops simple_pm_bus_pm_ops =3D {
> >         RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend, simple_pm_bus_run=
time_resume, NULL)
> > -       NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_=
force_resume)
> > +       NOIRQ_SYSTEM_SLEEP_PM_OPS(simple_pm_bus_suspend, simple_pm_bus_=
resume)
> >  };
> >
> >  #define ONLY_BUS       ((void *) 1) /* Match if the device is only a b=
us. */
>
> In the meantime, I've cut the attached (untested) patch that should
> take care of the pm_runtime_force_suspend() issue altogether.
>
> It changes the code to only set the device's runtime PM status to
> "active" if runtime PM is going to be enabled for it by the first
> pm_runtime_enable() call, which never happens for devices where
> runtime PM has never been enabled (because it is disabled for them
> once again in device_suspend_late()) and for devices subject to
> pm_runtime_force_suspend() during system suspend (because it disables
> runtime PM for them once again).

All right, this is not going to work.

I see two problems and both are related to pm_runtime_force_suspend/resume(=
).

The first problem is that pm_runtime_force_suspend() doesn't
distinguish devices for which runtime PM has never been enabled from
devices that have been runtime-suspended.  This clearly is a mistake
as demonstrated by the breakage at hand.

The second problem is that pm_runtime_force_resume() expects all
devices to be resumed to have both runtime PM status set to
RPM_SUSPENDED and power.needs_force_resume set.  AFAICS, checking
power.needs_force_resume alone should be sufficient there, but even
that is problematic because something needs to set the flag for
devices that are expected to be resumed.

Unfortunately, they both are not straightforward to address.  I have
ideas, but nothing clear yet.

For now, the power.set_active propagation can be restricted to the
parent of the device with DPM_FLAG_SMART_SUSPEND set that needs to be
resumed and that will just be sufficient ATM, so attached is a patch
doing this.

In the future, though, all of this needs to be addressed properly
because if one device in a dependency chain needs to be resumed,
whatever the reason, all of the devices depended on by it need to be
resumed as well.

--00000000000090f20d062da05cec
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="pm-sleep-restrict-set_active-propagation.patch"
Content-Disposition: attachment; 
	filename="pm-sleep-restrict-set_active-propagation.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m6w5k7t70>
X-Attachment-Id: f_m6w5k7t70

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIHwgICAyMSArKysrKysrKystLS0tLS0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKLS0t
IGEvZHJpdmVycy9iYXNlL3Bvd2VyL21haW4uYworKysgYi9kcml2ZXJzL2Jhc2UvcG93ZXIvbWFp
bi5jCkBAIC0xMTkxLDI0ICsxMTkxLDE4IEBACiAJcmV0dXJuIFBNU0dfT047CiB9CiAKLXN0YXRp
YyB2b2lkIGRwbV9zdXBlcmlvcl9zZXRfbXVzdF9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2LCBi
b29sIHNldF9hY3RpdmUpCitzdGF0aWMgdm9pZCBkcG1fc3VwZXJpb3Jfc2V0X211c3RfcmVzdW1l
KHN0cnVjdCBkZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3QgZGV2aWNlX2xpbmsgKmxpbms7CiAJaW50
IGlkeDsKIAotCWlmIChkZXYtPnBhcmVudCkgeworCWlmIChkZXYtPnBhcmVudCkKIAkJZGV2LT5w
YXJlbnQtPnBvd2VyLm11c3RfcmVzdW1lID0gdHJ1ZTsKLQkJaWYgKHNldF9hY3RpdmUpCi0JCQlk
ZXYtPnBhcmVudC0+cG93ZXIuc2V0X2FjdGl2ZSA9IHRydWU7Ci0JfQogCiAJaWR4ID0gZGV2aWNl
X2xpbmtzX3JlYWRfbG9jaygpOwogCi0JbGlzdF9mb3JfZWFjaF9lbnRyeV9yY3VfbG9ja2VkKGxp
bmssICZkZXYtPmxpbmtzLnN1cHBsaWVycywgY19ub2RlKSB7CisJbGlzdF9mb3JfZWFjaF9lbnRy
eV9yY3VfbG9ja2VkKGxpbmssICZkZXYtPmxpbmtzLnN1cHBsaWVycywgY19ub2RlKQogCQlsaW5r
LT5zdXBwbGllci0+cG93ZXIubXVzdF9yZXN1bWUgPSB0cnVlOwotCQlpZiAoc2V0X2FjdGl2ZSkK
LQkJCWxpbmstPnN1cHBsaWVyLT5wb3dlci5zZXRfYWN0aXZlID0gdHJ1ZTsKLQl9CiAKIAlkZXZp
Y2VfbGlua3NfcmVhZF91bmxvY2soaWR4KTsKIH0KQEAgLTEyODcsOSArMTI4MSwxMiBAQAogCQlk
ZXYtPnBvd2VyLm11c3RfcmVzdW1lID0gdHJ1ZTsKIAogCWlmIChkZXYtPnBvd2VyLm11c3RfcmVz
dW1lKSB7Ci0JCWRldi0+cG93ZXIuc2V0X2FjdGl2ZSA9IGRldi0+cG93ZXIuc2V0X2FjdGl2ZSB8
fAotCQkJZGV2X3BtX3Rlc3RfZHJpdmVyX2ZsYWdzKGRldiwgRFBNX0ZMQUdfU01BUlRfU1VTUEVO
RCk7Ci0JCWRwbV9zdXBlcmlvcl9zZXRfbXVzdF9yZXN1bWUoZGV2LCBkZXYtPnBvd2VyLnNldF9h
Y3RpdmUpOworCQlpZiAoZGV2X3BtX3Rlc3RfZHJpdmVyX2ZsYWdzKGRldiwgRFBNX0ZMQUdfU01B
UlRfU1VTUEVORCkpIHsKKwkJCWRldi0+cG93ZXIuc2V0X2FjdGl2ZSA9IHRydWU7CisJCQlpZiAo
ZGV2LT5wYXJlbnQpCisJCQkJZGV2LT5wYXJlbnQtPnBvd2VyLnNldF9hY3RpdmUgPSB0cnVlOwor
CQl9CisJCWRwbV9zdXBlcmlvcl9zZXRfbXVzdF9yZXN1bWUoZGV2KTsKIAl9CiAKIENvbXBsZXRl
Ogo=
--00000000000090f20d062da05cec--

