Return-Path: <linux-pci+bounces-21806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962BDA3BDDE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 13:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D858C1652C6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 12:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C4E1E0DCE;
	Wed, 19 Feb 2025 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nq4npW0I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4B71DF756;
	Wed, 19 Feb 2025 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967288; cv=none; b=tWDZ+3wcisRx06Z0LnqL7mBKgsPPwAStfnm45NZbt3GX9cIZar5jF1yA/eaUjXtp1S7MRWudG3iIxSphc3j9QlGgr+FaTlXBHUGI9y3CVHnHvWWCJs/MZ3ogf7EjNAtfJMQ9IctIz26pt9/Jnm6ul9FwMwKW2NRsbd6paMNgLQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967288; c=relaxed/simple;
	bh=QfZ0v+dm0txxFuSXcQ7ZmFbhN0JkYUAe5JBaOr2VZpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUvSUvM7hV1BGvBV0yXwene767WFxSwh1SYV42a4Nmb56AVlGA+nQHDmPVusogUuwMDimYpqD8IVetqCSuTm5Jvur2kOAliRX+7VVSeCSCT2ikXRCE7LCjZMqMG/eId66rS4dpqyaHVFJ9nqRjNyuSynMt1XP4r7qLM/j4G9ni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq4npW0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E47BC4CEE7;
	Wed, 19 Feb 2025 12:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739967288;
	bh=QfZ0v+dm0txxFuSXcQ7ZmFbhN0JkYUAe5JBaOr2VZpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nq4npW0IvXTS1PaZ6aKnLlsx5RGuBxGgXQp8wd0+KQ09hGlgAU6/1yVWD+r7/yySh
	 RA313a6nk9gBtL3TDO6XitYzzYxSSNVOzhtXpHeRqGLAqIxmQ4/TKkx8EfFHc/wjWt
	 NdGyDKPmIBP5kbyKBfU8CKUORSq8zNo2Ko+LT2kDFnDDM3mSsDYWeL/LckEckiCPJk
	 AU7Q6kEtPcqFddrHSUjUMCK5C06m4xSWJy64Zfq0zyKAg4PIA7ldSdq5wLUHtKWSO1
	 mwxEzkDC/Jw8oiKNT6nxvtF/BBYj8lJuhqYzLXgs8fy58/Oagk+JQplKSRRBdRFA5z
	 rptmUWpnCfuVg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2bc71717d3fso3385130fac.2;
        Wed, 19 Feb 2025 04:14:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFeipiL9fVoUqQTc+75+1HU9+SkQAjzHn6c6hNYUqZQV/SpPKfiKrJRZx+sq0oTvyLfVB8JsqxM24v@vger.kernel.org, AJvYcCW9RPsr7eyDMvr8iC2ogimC7r7EjCK5ZVOaMx0Daeo45kOY0+b2dvkewKTjvsRTDewsJUceII5SGbU=@vger.kernel.org, AJvYcCWFLpcOhjMCq1kHG3Lfnx9XW3Ru1A+RyhDli5izEkFcvlSVIME+Ww1KJAkIHuZx7U1iFDMgaSdDXF0V@vger.kernel.org, AJvYcCXOXG3DpL+IauisV2yDALRaOAME94p0/XhmE78b9jO8yN80iM/lh/WxkxN1M8h0iPPUKQHaqby3uc+IXLj9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21OXwLIJ6Qp+6caR448D6meynS6GT3re8hkZx/q5XwJR71Qim
	Fl3QH8jPtx4Z2Qv+M0eElkAEK723XfP/Ol+On1rtb10zWRAHWsQZEyfsYp76nPvdchJRaP+hQOZ
	4bXKYu3ymxTE6FzmNKK9pWYIdMEU=
X-Google-Smtp-Source: AGHT+IEUoSI0Fc7zR7MYZAXaDjdzeTDLLlHNwLYh1YC5thY6NZqntwxqLdCiIDWf8q2/2/9HH6Nri6Ta1Dc3MsDn4F0=
X-Received: by 2002:a05:6870:af06:b0:2b8:e6f2:ba7e with SMTP id
 586e51a60fabf-2bd10236009mr2483334fac.12.1739967287437; Wed, 19 Feb 2025
 04:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1914558.tdWV9SEqCh@rjwysocki.net> <20250218222011.GA196831@bhelgaas>
In-Reply-To: <20250218222011.GA196831@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Feb 2025 13:14:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iT5j3S=VtRo+uHEaiM+fYah=mRr7c3vZnvguNnOY3TPQ@mail.gmail.com>
X-Gm-Features: AWEUYZnWiKdfQyoXdrKp3FO2qjuD_L6edyTQTacrmaW_C8alsdXkuKeuyqTt42A
Message-ID: <CAJZ5v0iT5j3S=VtRo+uHEaiM+fYah=mRr7c3vZnvguNnOY3TPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 11:20=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Tue, Feb 18, 2025 at 09:16:48PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > A recent discussion has revealed that using DPM_FLAG_SMART_SUSPEND
> > unconditionally is generally problematic because it may lead to
> > situations in which the device's runtime PM information is internally
> > inconsistent or does not reflect its real state [1].
> >
> > For this reason, change the handling of DPM_FLAG_SMART_SUSPEND so that
> > it is only taken into account if it is consistently set by the drivers
> > of all devices having any PM callbacks throughout dependency graphs in
> > accordance with the following rules:
> >
> >  - The "smart suspend" feature is only enabled for devices whose driver=
s
> >    ask for it (that is, set DPM_FLAG_SMART_SUSPEND) and for devices
> >    without PM callbacks unless they have never had runtime PM enabled.
> >
> >  - The "smart suspend" feature is not enabled for a device if it has no=
t
> >    been enabled for the device's parent unless the parent does not take
> >    children into account or it has never had runtime PM enabled.
> >
> >  - The "smart suspend" feature is not enabled for a device if it has no=
t
> >    been enabled for one of the device's suppliers taking runtime PM int=
o
> >    account unless that supplier has never had runtime PM enabled.
> >
> > Namely, introduce a new device PM flag called smart_suspend that is onl=
y
> > set if the above conditions are met and update all DPM_FLAG_SMART_SUSPE=
ND
> > users to check power.smart_suspend instead of directly checking the
> > latter.
> >
> > At the same time, drop the power.set_active flage introduced recently
> > in commit 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status
> > of parents and children") because it is now sufficient to check
> > power.smart_suspend along with the dev_pm_skip_resume() return value
> > to decide whether or not pm_runtime_set_active() needs to be called
> > for the device.
> >
> > Link: https://lore.kernel.org/linux-pm/CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQ=
GwNWeteJWqpW29BojhQ@mail.gmail.com/  [1]
> > Fixes: 7585946243d6 ("PM: sleep: core: Restrict power.set_active propag=
ation")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci

Thanks!

