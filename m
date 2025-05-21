Return-Path: <linux-pci+bounces-28210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD66ABF2CC
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 13:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927358E24C9
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94940263C72;
	Wed, 21 May 2025 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgPWPLGT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FCB263892;
	Wed, 21 May 2025 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747826863; cv=none; b=XT5wQ8jMsA5r8jxrKAWqYtw5S3u7n9KM3k9XQyQU1UxlUPWPnktKDRR1OD0gfLwVzioJsauEQFdCuDe7QyVt8CDScUDa7U7d0CZJO9h1BF4m+7o8aA2WWZ/ec9cUb1jlvYwJ9SmOhjcJj9cZBOpilXdKfoEjdMh2/b6AyExXDPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747826863; c=relaxed/simple;
	bh=aYjz5/seEUrXVor2bEyU7oBZ3j8vrqWOPEqPD8VZzrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibRgKo2f11GVQmhUegrmvJkSJ8ywG4pUHGeNK7It4H3HK/X0XekbWHR5JOw25XyBbsrA6URt5kKSpM59yFMR5U2bSInOFO01n2eyVrqmjbUeqUGIw5e3PyYvr8LAFS9ovZ6p1XT5YV7oxNvWrmeJGWYTIuWNuDWKuLUiTD6FFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgPWPLGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228E9C4CEED;
	Wed, 21 May 2025 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747826863;
	bh=aYjz5/seEUrXVor2bEyU7oBZ3j8vrqWOPEqPD8VZzrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fgPWPLGTOvxMGGiLFbLld28sdX79VsNRSkxZdUWDKE1TTR3ynnBKJsvp63tsmp8Mi
	 ThKWeM9lRIp5U6+yVtY9aAR3jSahN5/B81gujRH1XshBCktYCEMsQtlPS0SU4zwxfW
	 /bSQxa+9VU2vcxGrppfoy8FoZSyzuUNTUSsK3+gHRNNxlV/ET+dEHI3Rkz1oFvnxW1
	 R6U30jVCIyhUE6u0CxCf1kcePWddAz9XqFvF7APzuquvPWrPn4EdK2kuC9ZWXc8ShM
	 XM1tlN1GiBY8AxUh04eUJWW0yyF101d6AfA4MfETfWVDpAGpJvgacCncGU6dhs0hCG
	 P5iTn/qMOh3kg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-605fda00c30so3646266eaf.1;
        Wed, 21 May 2025 04:27:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVC7Uy0ASwpUw4UXl9Mpfg21s0LmDycB2jNjHtgvIoGRy09TVYyniBJSnBd/JNCEw6VgXhaKby4cLxW@vger.kernel.org, AJvYcCW0o76d0slzKNVtdlUv/8g8HAHwOeiPKLrTOUJVjYtY3Xd3+Jq26vn7dhxg2Vqn2cYjzRci+gpx2ys=@vger.kernel.org, AJvYcCXQrhyh0tBiFxuShvTmW5hzOpUxPWuYcqRp55v71UyTcNHX2xBs4OA3r+BmE+YomqbPAmPQXhxKT0Dlfbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQ9Ilpfxh+IoyH5qcjqDioou0k34Af70vKqdxruTkiIJW19WL
	qiDKfE/1qvpgURvTWTUWXMKfhtMkqTClpyrw8OXf/yJO/6DqVbj+ea1k3kDSQ6nP7TTQXYnHt9k
	kQb+RWUf1uF/enfop9IBwSZtRpIxJ4cc=
X-Google-Smtp-Source: AGHT+IEf67uWG+s0dmoXckHNwNhvBK96rzdHQHiTzqfpUpRP3+2APLbezdICnHJMQ0kPkt5kRPsd9b22whF+hm5HWKA=
X-Received: by 2002:a05:6820:1841:b0:602:7078:df55 with SMTP id
 006d021491bc7-609f374f802mr12234655eaf.5.1747826862342; Wed, 21 May 2025
 04:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aCsK743YSuahPtnH@black.fi.intel.com> <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>
 <aCxP6vQ8Ep9LftPv@black.fi.intel.com> <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
 <aCyj9nbnIRet93O-@black.fi.intel.com> <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com> <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com> <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com>
In-Reply-To: <aC2UzG-eycjqYQep@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 May 2025 13:27:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
X-Gm-Features: AX0GCFu3-VrwmffBAWxr3tXBf8i8Ncp98wmJM7kURUjcXyWXYba_x7RizRkpotQ
Message-ID: <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous device
To: Raag Jadav <raag.jadav@intel.com>, Mario Limonciello <superm1@kernel.org>
Cc: Denis Benato <benato.denis96@gmail.com>, rafael@kernel.org, mahesh@linux.ibm.com, 
	oohall@gmail.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de, 
	aravind.iddamsetty@linux.intel.com, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 10:54=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> =
wrote:
>
> On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello wrote:
> > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello wrote:
> > > > On 5/20/2025 12:22 PM, Denis Benato wrote:
> > > > > On 5/20/25 17:49, Mario Limonciello wrote:
> > > > > > On 5/20/2025 10:47 AM, Raag Jadav wrote:
> > > > > > > On Tue, May 20, 2025 at 10:23:57AM -0500, Mario Limonciello w=
rote:
> > > > > > > > On 5/20/2025 4:48 AM, Raag Jadav wrote:
> > > > > > > > > On Mon, May 19, 2025 at 11:42:31PM +0200, Denis Benato wr=
ote:
> > > > > > > > > > On 5/19/25 12:41, Raag Jadav wrote:
> > > > > > > > > > > On Mon, May 19, 2025 at 03:58:08PM +0530, Raag Jadav =
wrote:
> > > > > > > > > > > > If error status is set on an AER capable device, mo=
st likely either the
> > > > > > > > > > > > device recovery is in progress or has already faile=
d. Neither of the
> > > > > > > > > > > > cases are well suited for power state transition of=
 the device, since
> > > > > > > > > > > > this can lead to unpredictable consequences like re=
sume failure, or in
> > > > > > > > > > > > worst case the device is lost because of it. Leave =
the device in its
> > > > > > > > > > > > existing power state to avoid such issues.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > v2: Synchronize AER handling with PCI PM (Rafael)
> > > > > > > > > > > > v3: Move pci_aer_in_progress() to pci_set_low_power=
_state() (Rafael)
> > > > > > > > > > > >         Elaborate "why" (Bjorn)
> > > > > > > > > > > > v4: Rely on error status instead of device status
> > > > > > > > > > > >         Condense comment (Lukas)
> > > > > > > > > > > Since pci_aer_in_progress() is changed I've not inclu=
ded Rafael's tag with
> > > > > > > > > > > my understanding of this needing a revisit. If this w=
as a mistake, please
> > > > > > > > > > > let me know.
> > > > > > > > > > >
> > > > > > > > > > > Denis, Mario, does this fix your issue?
> > > > > > > > > > >
> > > > > > > > > > Hello,
> > > > > > > > > >
> > > > > > > > > > Unfortunately no, I have prepared a dmesg but had to re=
move the bootup process because it was too long of a few kb: https://pasteb=
in.com/1uBEA1FL
> > > > > > > > >
> > > > > > > > > Thanks for the test. It seems there's no hotplug event th=
is time around
> > > > > > > > > and endpoint device is still intact without any PCI relat=
ed failure.
> > > > > > > > >
> > > > > > > > > Also,
> > > > > > > > >
> > > > > > > > > amdgpu 0000:09:00.0: PCI PM: Suspend power state: D3hot
> > > > > > > > >
> > > > > > > > > Which means whatever you're facing is either not related =
to this patch,
> > > > > > > > > or at best exposed some nasty side-effect that's not hand=
led correctly
> > > > > > > > > by the driver.
> > > > > > > > >
> > > > > > > > > I'd say amdgpu folks would be of better help for your cas=
e.
> > > > > > > > >
> > > > > > > > > Raag
> > > > > > > >
> > > > > > > > So according to the logs Denis shared with v4
> > > > > > > > (https://pastebin.com/1uBEA1FL) the GPU should have been go=
ing to BOCO. This
> > > > > > > > stands for "Bus off Chip Off"
> > > > > > > >
> > > > > > > > amdgpu 0000:09:00.0: amdgpu: Using BOCO for runtime pm
> > > > > > > >
> > > > > > > > If it's going to D3hot - that's not going to be BOCO, it sh=
ould be going to
> > > > > > > > D3cold.
> > > > > > >
> > > > > > > Yes, because upstream port is in D0 for some reason (might be=
 this patch
> > > > > > > but not sure) and so will be the root port.
> > > > > > >
> > > > > > > pcieport 0000:07:00.0: PCI PM: Suspend power state: D0
> > > > > > > pcieport 0000:07:00.0: PCI PM: Skipped
> > > > > > >
> > > > > > > and my best guess is the driver is not able to cope with the =
lack of D3cold.
> > > > > >
> > > > > > Yes; if the driver is configured to expect BOCO (D3cold) if it =
doesn't get it, chaos ensues.
> > > > > >
> > > > > > I guess let's double check the behavior with CONFIG_PCI_DEBUG t=
o verify this patch is what is changing that upstream port behavior.
> > > > >
> > > > >
> > > > > This is the very same exact kernel, minus the patch in question: =
 https://pastebin.com/rwMYgG7C
> > > > >
> > > > >
> > > > > Both previous kernel and this one have CONFIG_PCI_DEBUG=3Dy.
> > > > >
> > > > > Removed the initial bootup sequence to be able to use pastebin.
> > > >
> > > > Thanks - this confirms that the problem is the root port not going =
to D3.
> > > > This new log shows:
> > > >
> > > > pcieport 0000:07:00.0: PCI PM: Suspend power state: D3hot
> > > >
> > > > So I feel we should fixate on solving that.
> > >
> > > Which means what you're looking for is error flag being set somewhere=
 in
> > > the hierarchy that is preventing suspend.
> >
> > Is the issue perhaps that this is now gated on both correctable and
> > uncorrectable errors?
> >
> > Perhaps should *correctable errors* be emitted with a warning and the
> > *uncorrectable errors* be fatal?
>
> That'd be more or less inline with hiding the issue, and it can also race
> with err_handler callback if driver has registered it.
>
> > > But regardless of it, my understanding is that root port suspend depe=
nds
> > > on a lot of factors (now errors flags being one of them with this pat=
ch)
> > > and endpoint driver can't possibly enforce or guarantee it - the best=
 it
> > > can do is try.
> > >
> > > What's probably needed is D3cold failure handling on driver side, but=
 I'm
> > > no PCI PM expert and perhaps Rafael can comment on it.
> > >
> > > Raag
> >
> > From the driver perspective it does have expectations that the parts ou=
tside
> > the driver did the right thing.  If the driver was expecting the root p=
ort
> > to be powered down at suspend and it wasn't there are hardware componen=
ts
> > that didn't power cycle and that's what we're seeing here.
>
> Which means the expectation set by the driver is the opposite of the
> purpose of this patch, and it's going to fail if any kind of error is
> detected under root port during suspend.

And IMV this driver's expectation is questionable at least.

There is no promise whatsoever that the device will always be put into
D3cold during system suspend.

Thanks!

