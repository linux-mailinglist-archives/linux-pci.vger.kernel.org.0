Return-Path: <linux-pci+bounces-20929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B90A2CAF4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 19:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D49188A9B7
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32AE19DF62;
	Fri,  7 Feb 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+la3ER1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0858199EB7;
	Fri,  7 Feb 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738952080; cv=none; b=QadlWuDlLzNrMbJM+nZNzGjaF5JsOet2PPcYrvovTyPkU/rvSeGOYK8wKy4wLop/l/199Ogsmk6rkbJ2+qNp7BwffsbItu1tH8jGTy8rYn5kvo8Rb538htXcgcjIPlqO7mfK8tUaRKhLmBgNkqNnFSzvZxkPnhWXOKDiT1HDQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738952080; c=relaxed/simple;
	bh=2vRQARBPfRDe4Y7LUWzZxwe6nvtPE+deE1jVBXnCDRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gx0lu5ro3GfMw0AYsDP6jmo8VTfAmN4rG8OCfb97eetU9XrgiL8bz404H6kafQvLZuBlN7KhCeRwz/m7f+XpPq+Er9tNr7Idq/psKblnQQc6Iw7xSN8G8jfegPzmVNVGTTWavPbI77gwjipdwm+FztDhqhPY7vdRyVCxDX7wOlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+la3ER1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE80C4CEE5;
	Fri,  7 Feb 2025 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738952080;
	bh=2vRQARBPfRDe4Y7LUWzZxwe6nvtPE+deE1jVBXnCDRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z+la3ER1pTtRYJCGc5WodTYtCbhNFjnKTd2flqLFtAwWANwKZBmF8BvdDt0oEbzOA
	 eK7hXvvvk5T9nGy8/5YksIBna5j4vBuV38bVxbkkkzp/U1+rnNJkjmWBeiEA2cyHPN
	 LgKooOIU94q1ozAAkUQjklavjNyXb6bHSjnu0611vBoHlO6MGk9SnHz3yfYGOE/KQk
	 oa9MeUxI+Tgw4o3hQfA4YjAybLCZGZ4ETry86e0LRzFcWZaYtJA/dVlwvlP76yf14P
	 /OI1PLt6832NaQ0VvJE0SkZHkwpXLnAznr2erI1Jv94H+HRB+xysLdB/A/2rjBxcpl
	 5FGERo52uk+oQ==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5fa2a2bdde9so677304eaf.0;
        Fri, 07 Feb 2025 10:14:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUM3pzl5no+QXVQJZy0TIc7P/iduxd1qCMYxSispAnLCCvhBzXCTw7jeNyJ5F/6mfn4x2WjzieYuYg/wOE=@vger.kernel.org, AJvYcCVg5OJ5oKPgU79Viu9pQ0WVjo96EzA6qyw/r59efeF7Ueks7VN18smO8P6IgG19uCyHJrwB/BUU4WE9@vger.kernel.org, AJvYcCWIvToEI6mjr+YT2j2ub5n60MBwBIWaxvXG+Tb8xOppsxx3HWTNk4UtR2YrYzrzu4WnM5O4+J4Ef3isMKE=@vger.kernel.org, AJvYcCXq2rQJbYZjpRMUq9bqIhHgZR1taCYt2ykdmxrnsx4ngXBlLc7Z4ux4ldUbLifFqo0k++5RJ9oiquY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsVHlTxzulWqI6Fk+1SQyUcqOf3g8W56KNG27ZWVa0c84A+m22
	t0KMPqesunklxVLLS/QJY7UpeG8pUgpr4Fr2UO1JSSumG3uMECAIEpMJXvYg6b0engrubkSa/Ye
	yMWq/4kleN/8tTg1QO96yfzjgGGM=
X-Google-Smtp-Source: AGHT+IHGI0WXftuL7wk8a3wFGS2gQ6lju6Fy2RlUNGM9RMxSD4fsyY9blHC5wTJ99nQoBl2LvRdE2HLCP4IXR/lyXfg=
X-Received: by 2002:a05:6820:209:b0:5fa:61b9:3efb with SMTP id
 006d021491bc7-5fc5e70f19fmr2791995eaf.4.1738952079465; Fri, 07 Feb 2025
 10:14:39 -0800 (PST)
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
In-Reply-To: <Z6Y0NlW40yHTIlzm@hovoldconsulting.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Feb 2025 19:14:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gBCQW2wwdB+4SyBXtqiis2k1Z2L8SOVKwcVbNxPHqvYA@mail.gmail.com>
X-Gm-Features: AWEUYZlA78d4afzHjo-SK92VyRsVbR94MpDMbDNVuWS4dzSNsm4T_ttlhRpNfD0
Message-ID: <CAJZ5v0gBCQW2wwdB+4SyBXtqiis2k1Z2L8SOVKwcVbNxPHqvYA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Kevin Xie <kevin.xie@starfivetech.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000fa9276062d915482"

--000000000000fa9276062d915482
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 5:26=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Fri, Feb 07, 2025 at 05:06:32PM +0100, Johan Hovold wrote:
> > On Fri, Feb 07, 2025 at 04:41:18PM +0100, Rafael J. Wysocki wrote:
> > > On Fri, Feb 7, 2025 at 3:45=E2=80=AFPM Johan Hovold <johan@kernel.org=
> wrote:
> > > > On Fri, Feb 07, 2025 at 02:50:29PM +0100, Johan Hovold wrote:
> >
> > > > Ok, so the driver data is never set and runtime PM is never enabled=
 for
> > > > this simple bus device, which uses pm_runtime_force_suspend() for s=
ystem
> > > > sleep.
> > >
> > > This is kind of confusing.  Why use pm_runtime_force_suspend() if
> > > runtime PM is never enabled and cannot really work?
> >
> > It's only done for some buses that this driver handles. The driver is
> > buggy; I'm preparing a fix for it regardless of the correctness of the
> > commit that now triggered this.
>
> Hmm. The driver implementation is highly odd, but actually works as long
> as the runtime PM status is left at 'suspended' (as
> pm_runtime_force_resume() won't enable runtime PM unless it was enabled
> before suspend).
>
> So we'd strictly only need something like the below if we are going to
> keep the set_active propagation.

I think you are right.

> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
> index 5dea31769f9a..d8e029e7e53f 100644
> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c
> @@ -109,9 +109,29 @@ static int simple_pm_bus_runtime_resume(struct devic=
e *dev)
>         return 0;
>  }
>
> +static int simple_pm_bus_suspend(struct device *dev)
> +{
> +       struct simple_pm_bus *bus =3D dev_get_drvdata(dev);
> +
> +       if (!bus)
> +               return 0;
> +
> +       return pm_runtime_force_suspend(dev);
> +}
> +
> +static int simple_pm_bus_resume(struct device *dev)
> +{
> +       struct simple_pm_bus *bus =3D dev_get_drvdata(dev);
> +
> +       if (!bus)
> +               return 0;
> +
> +       return pm_runtime_force_resume(dev);
> +}
> +
>  static const struct dev_pm_ops simple_pm_bus_pm_ops =3D {
>         RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend, simple_pm_bus_runti=
me_resume, NULL)
> -       NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_fo=
rce_resume)
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(simple_pm_bus_suspend, simple_pm_bus_re=
sume)
>  };
>
>  #define ONLY_BUS       ((void *) 1) /* Match if the device is only a bus=
. */

In the meantime, I've cut the attached (untested) patch that should
take care of the pm_runtime_force_suspend() issue altogether.

It changes the code to only set the device's runtime PM status to
"active" if runtime PM is going to be enabled for it by the first
pm_runtime_enable() call, which never happens for devices where
runtime PM has never been enabled (because it is disabled for them
once again in device_suspend_late()) and for devices subject to
pm_runtime_force_suspend() during system suspend (because it disables
runtime PM for them once again).

--000000000000fa9276062d915482
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-runtime-cond-set-active.patch"
Content-Disposition: attachment; filename="pm-runtime-cond-set-active.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m6v342uq0>
X-Attachment-Id: f_m6v342uq0

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jICAgIHwgICAyMCArKysrKysrKysrKysrKysr
LS0tLQogZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYyB8ICAgNDEgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0KIGluY2x1ZGUvbGludXgvcG1fcnVudGltZS5oICAg
fCAgICA1ICsrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDkgZGVsZXRp
b25zKC0pCgotLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jCisrKyBiL2RyaXZlcnMvYmFz
ZS9wb3dlci9tYWluLmMKQEAgLTY1NSwxNCArNjU1LDI1IEBACiAJICogdGhpcyBkZXZpY2UgbGF0
ZXIsIGl0IG5lZWRzIHRvIGFwcGVhciBhcyAic3VzcGVuZGVkIiB0byBQTS1ydW50aW1lLAogCSAq
IHNvIGNoYW5nZSBpdHMgc3RhdHVzIGFjY29yZGluZ2x5LgogCSAqCi0JICogT3RoZXJ3aXNlLCB0
aGUgZGV2aWNlIGlzIGdvaW5nIHRvIGJlIHJlc3VtZWQsIHNvIHNldCBpdHMgUE0tcnVudGltZQot
CSAqIHN0YXR1cyB0byAiYWN0aXZlIiB1bmxlc3MgaXRzIHBvd2VyLnNldF9hY3RpdmUgZmxhZyBp
cyBjbGVhciwgaW4KLQkgKiB3aGljaCBjYXNlIGl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gdXBkYXRl
IGl0cyBQTS1ydW50aW1lIHN0YXR1cy4KKwkgKiBPdGhlcndpc2UsIHRoZSBkZXZpY2UgaXMgZ29p
bmcgdG8gYmUgcmVzdW1lZCwgc28gdHJ5IHRvIHVwZGF0ZSBpdHMKKwkgKiBQTS1ydW50aW1lIHN0
YXR1cyB1bmxlc3MgaXRzIHBvd2VyLnNldF9hY3RpdmUgZmxhZyBpcyBjbGVhciwgaW4gd2hpY2gK
KwkgKiBjYXNlIGl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gZG8gdGhhdC4KIAkgKi8KIAlpZiAoc2tp
cF9yZXN1bWUpIHsKIAkJcG1fcnVudGltZV9zZXRfc3VzcGVuZGVkKGRldik7CiAJfSBlbHNlIGlm
IChkZXYtPnBvd2VyLnNldF9hY3RpdmUpIHsKLQkJcG1fcnVudGltZV9zZXRfYWN0aXZlKGRldik7
CisJCS8qCisJCSAqIElmIFBNLXJ1bnRpbWUgaXMgbm90IGdvaW5nIHRvIGJlIGFjdHVhbGx5IGVu
YWJsZWQgZm9yIHRoZQorCQkgKiBkZXZpY2UgYnkgYSBzdWJzZXF1ZW50IHBtX3J1bnRpbWVfZW5h
YmxlZCgpIGNhbGwsIGl0IG1heQorCQkgKiBoYXZlIG5ldmVyIGJlZW4gZW5hYmxlZCBvciBwbV9y
dW50aW1lX2ZvcmNlX3N1c3BlbmQoKSBtYXkKKwkJICogaGF2ZSBiZWVuIHVzZWQuICBEb24ndCB1
cGRhdGUgdGhlIFBNLXJ1bnRpbWUgc3RhdHVlIGluCisJCSAqIHRoYXQgY2FzZSBhbmQgc2V0IHBv
d2VyLm5lZWRzX2ZvcmNlX3Jlc3VtZSBpbiBjYXNlCisJCSAqIHBtX3J1bnRpbWVfZm9yY2VfcmVz
dW1lKCkgd2lsbCBiZSBjYWxsZWQgZm9yIHRoZSBkZXZpY2UKKwkJICogc3Vic2VxdWVudGx5Lgor
CQkgKi8KKwkJaWYgKHBtX3J1bnRpbWVfY29uZF9zZXRfYWN0aXZlKGRldikgPiAwKQorCQkJZGV2
LT5wb3dlci5uZWVkc19mb3JjZV9yZXN1bWUgPSB0cnVlOworCiAJCWRldi0+cG93ZXIuc2V0X2Fj
dGl2ZSA9IGZhbHNlOwogCX0KIApAQCAtOTg4LDYgKzk5OSw3IEBACiAgRW5kOgogCWVycm9yID0g
ZHBtX3J1bl9jYWxsYmFjayhjYWxsYmFjaywgZGV2LCBzdGF0ZSwgaW5mbyk7CiAJZGV2LT5wb3dl
ci5pc19zdXNwZW5kZWQgPSBmYWxzZTsKKwlkZXYtPnBvd2VyLm5lZWRzX2ZvcmNlX3Jlc3VtZSA9
IGZhbHNlOwogCiAgVW5sb2NrOgogCWRldmljZV91bmxvY2soZGV2KTsKLS0tIGEvZHJpdmVycy9i
YXNlL3Bvd2VyL3J1bnRpbWUuYworKysgYi9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jCkBA
IC0xMjUzLDkgKzEyNTMsMTAgQEAKIEVYUE9SVF9TWU1CT0xfR1BMKHBtX3J1bnRpbWVfZ2V0X2lm
X2luX3VzZSk7CiAKIC8qKgotICogX19wbV9ydW50aW1lX3NldF9zdGF0dXMgLSBTZXQgcnVudGlt
ZSBQTSBzdGF0dXMgb2YgYSBkZXZpY2UuCisgKiBwbV9ydW50aW1lX3NldF9zdGF0dXNfaW50ZXJu
YWwgLSBTZXQgcnVudGltZSBQTSBzdGF0dXMgb2YgYSBkZXZpY2UuCiAgKiBAZGV2OiBEZXZpY2Ug
dG8gaGFuZGxlLgogICogQHN0YXR1czogTmV3IHJ1bnRpbWUgUE0gc3RhdHVzIG9mIHRoZSBkZXZp
Y2UuCisgKiBAY29uZDogQ2hhbmdlIHRoZSBzdGF0dXMgaWYgcnVudGltZSBQTSB3aWxsIGJlIGVu
YWJsZWQgYnkgdGhlIG5leHQgYXR0ZW1wdC4KICAqCiAgKiBJZiBydW50aW1lIFBNIG9mIHRoZSBk
ZXZpY2UgaXMgZGlzYWJsZWQgb3IgaXRzIHBvd2VyLnJ1bnRpbWVfZXJyb3IgZmllbGQgaXMKICAq
IGRpZmZlcmVudCBmcm9tIHplcm8sIHRoZSBzdGF0dXMgbWF5IGJlIGNoYW5nZWQgZWl0aGVyIHRv
IFJQTV9BQ1RJVkUsIG9yIHRvCkBAIC0xMjc1LDggKzEyNzYsMTIgQEAKICAqIG9mIHRoZSBAc3Rh
dHVzIHZhbHVlKSBhbmQgdGhlIHN1cHBsaWVycyB3aWxsIGJlIGRlYWN0aWNhdGVkIG9uIGV4aXQu
ICBUaGUKICAqIGVycm9yIHJldHVybmVkIGJ5IHRoZSBmYWlsaW5nIHN1cHBsaWVyIGFjdGl2YXRp
b24gd2lsbCBiZSByZXR1cm5lZCBpbiB0aGF0CiAgKiBjYXNlLgorICoKKyAqIElmIEBjb25kIGlz
IHNldCwgb25seSBjaGFuZ2UgdGhlIHN0YXR1cyBpZiBwb3dlci5kaXNhYmxlX2RlcHRoIGlzIGVx
dWFsIHRvIDEsCisgKiBvciBkbyBub3RoaW5nIGFuZCByZXR1cm4gKHBvd2VyLmRpc2FibGVfZGVw
dGggLSAxKSBvdGhlcndpc2UuCiAgKi8KLWludCBfX3BtX3J1bnRpbWVfc2V0X3N0YXR1cyhzdHJ1
Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBzdGF0dXMpCitzdGF0aWMgaW50IHBtX3J1bnRp
bWVfc2V0X3N0YXR1c19pbnRlcm5hbChzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJCSAgdW5zaWdu
ZWQgaW50IHN0YXR1cywgYm9vbCBjb25kKQogewogCXN0cnVjdCBkZXZpY2UgKnBhcmVudCA9IGRl
di0+cGFyZW50OwogCWJvb2wgbm90aWZ5X3BhcmVudCA9IGZhbHNlOwpAQCAtMTI5MiwxMCArMTI5
NywyNiBAQAogCSAqIFByZXZlbnQgUE0tcnVudGltZSBmcm9tIGJlaW5nIGVuYWJsZWQgZm9yIHRo
ZSBkZXZpY2Ugb3IgcmV0dXJuIGFuCiAJICogZXJyb3IgaWYgaXQgaXMgZW5hYmxlZCBhbHJlYWR5
IGFuZCB3b3JraW5nLgogCSAqLwotCWlmIChkZXYtPnBvd2VyLnJ1bnRpbWVfZXJyb3IgfHwgZGV2
LT5wb3dlci5kaXNhYmxlX2RlcHRoKQotCQlkZXYtPnBvd2VyLmRpc2FibGVfZGVwdGgrKzsKLQll
bHNlCisJaWYgKGRldi0+cG93ZXIucnVudGltZV9lcnJvcikgeworCQlpZiAoY29uZCkKKwkJCWVy
cm9yID0gLUVJTlZBTDsKKwkJZWxzZQorCQkJZGV2LT5wb3dlci5kaXNhYmxlX2RlcHRoKys7CisJ
fSBlbHNlIGlmIChkZXYtPnBvd2VyLmRpc2FibGVfZGVwdGgpIHsKKwkJLyoKKwkJICogSWYgY29u
ZCBpcyBzZXQsIG9ubHkgYXR0ZW1wdCB0byBjaGFuZ2UgdGhlIHN0YXR1cyBpZiB0aGUKKwkJICog
bmV4dCBpbnZvY2F0aW9uIG9mIHBtX3J1bnRpbWVfZW5hYmxlKCkgZm9yIHRoZSBkZXZpY2UgaXMK
KwkJICogZ29pbmcgdG8gYWN0dWFsbHkgZW5hYmxlIHJ1bnRpbWUgUE0gZm9yIGl0LgorCQkgKgor
CQkgKiBUaGlzIGlzIHVzZWQgaW4gYSBjb3JuZXIgY2FzZSBkdXJpbmcgc3lzdGVtLXdpZGUgcmVz
dW1lLgorCQkgKi8KKwkJaWYgKGNvbmQgJiYgZGV2LT5wb3dlci5kaXNhYmxlX2RlcHRoID4gMSkK
KwkJCWVycm9yID0gZGV2LT5wb3dlci5kaXNhYmxlX2RlcHRoIC0gMTsKKwkJZWxzZQorCQkJZGV2
LT5wb3dlci5kaXNhYmxlX2RlcHRoKys7CisJfSBlbHNlIHsKIAkJZXJyb3IgPSAtRUFHQUlOOwor
CX0KIAogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+cG93ZXIubG9jaywgZmxhZ3MpOwog
CkBAIC0xMzc2LDYgKzEzOTcsMTYgQEAKIAogCXJldHVybiBlcnJvcjsKIH0KKworaW50IHBtX3J1
bnRpbWVfY29uZF9zZXRfYWN0aXZlKHN0cnVjdCBkZXZpY2UgKmRldikKK3sKKwlyZXR1cm4gcG1f
cnVudGltZV9zZXRfc3RhdHVzX2ludGVybmFsKGRldiwgUlBNX0FDVElWRSwgdHJ1ZSk7Cit9CisK
K2ludCBfX3BtX3J1bnRpbWVfc2V0X3N0YXR1cyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVk
IGludCBzdGF0dXMpCit7CisJcmV0dXJuIHBtX3J1bnRpbWVfc2V0X3N0YXR1c19pbnRlcm5hbChk
ZXYsIHN0YXR1cywgZmFsc2UpOworfQogRVhQT1JUX1NZTUJPTF9HUEwoX19wbV9ydW50aW1lX3Nl
dF9zdGF0dXMpOwogCiAvKioKLS0tIGEvaW5jbHVkZS9saW51eC9wbV9ydW50aW1lLmgKKysrIGIv
aW5jbHVkZS9saW51eC9wbV9ydW50aW1lLmgKQEAgLTc1LDYgKzc1LDcgQEAKIGV4dGVybiBpbnQg
cG1fcnVudGltZV9nZXRfaWZfYWN0aXZlKHN0cnVjdCBkZXZpY2UgKmRldik7CiBleHRlcm4gaW50
IHBtX3J1bnRpbWVfZ2V0X2lmX2luX3VzZShzdHJ1Y3QgZGV2aWNlICpkZXYpOwogZXh0ZXJuIGlu
dCBwbV9zY2hlZHVsZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGRl
bGF5KTsKK2V4dGVybiBpbnQgcG1fcnVudGltZV9jb25kX3NldF9hY3RpdmUoc3RydWN0IGRldmlj
ZSAqZGV2KTsKIGV4dGVybiBpbnQgX19wbV9ydW50aW1lX3NldF9zdGF0dXMoc3RydWN0IGRldmlj
ZSAqZGV2LCB1bnNpZ25lZCBpbnQgc3RhdHVzKTsKIGV4dGVybiBpbnQgcG1fcnVudGltZV9iYXJy
aWVyKHN0cnVjdCBkZXZpY2UgKmRldik7CiBleHRlcm4gdm9pZCBwbV9ydW50aW1lX2VuYWJsZShz
dHJ1Y3QgZGV2aWNlICpkZXYpOwpAQCAtMjY4LDYgKzI2OSwxMCBAQAogewogCXJldHVybiAtRUlO
VkFMOwogfQorc3RhdGljIGlubGluZSBpbnQgcG1fcnVudGltZV9jb25kX3NldF9hY3RpdmUoc3Ry
dWN0IGRldmljZSAqZGV2KQoreworCXJldHVybiAxOworfQogc3RhdGljIGlubGluZSBpbnQgX19w
bV9ydW50aW1lX3NldF9zdGF0dXMoc3RydWN0IGRldmljZSAqZGV2LAogCQkJCQkgICAgdW5zaWdu
ZWQgaW50IHN0YXR1cykgeyByZXR1cm4gMDsgfQogc3RhdGljIGlubGluZSBpbnQgcG1fcnVudGlt
ZV9iYXJyaWVyKHN0cnVjdCBkZXZpY2UgKmRldikgeyByZXR1cm4gMDsgfQo=
--000000000000fa9276062d915482--

