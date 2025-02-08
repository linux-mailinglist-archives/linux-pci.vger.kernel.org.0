Return-Path: <linux-pci+bounces-21030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BE0A2D7CD
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 18:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE6F1665B9
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B1A1F3BA3;
	Sat,  8 Feb 2025 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTomZv9W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009181F3B97;
	Sat,  8 Feb 2025 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739036594; cv=none; b=kUIWT80qZBXgmr0d0WuO6WLQq2EoY3CLdpLAfUUEh19QGOt4jlO7Dj98wV4uvex5+lPFWIqj8/6HihOMsoT3DzTCeJ/Lr3UPtNw6iDd7g9g8qUNEOOkNGkJMolPMeGlmdYv8V7qcHLpX0QyhTRv/h2jGaY5S/dAE/gkTbwBibII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739036594; c=relaxed/simple;
	bh=lIKYyBOT50x0aXMSizJXMZKtZohgjmQjMrcuGkhveI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlgJi/HoBqZ9iZjiELUJDktD2bDAC6Hl69nbPybpj4kYsILKmXKCRQUV/wPIbL+HCP7zu6B5OwQEX6M4fEXxgYB0eWVCqpC1T5Fjujje7bCgHfYNnEb4uognNdPrHY9HhAgIxcw7FG5S1pC4nIUqESrWVylfRjD0bDoSNzuOJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTomZv9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A47C4CEE7;
	Sat,  8 Feb 2025 17:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739036593;
	bh=lIKYyBOT50x0aXMSizJXMZKtZohgjmQjMrcuGkhveI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hTomZv9WOFE7bfAXxy3kYxxc1BQuRCxvwp4lP+LSRfO0b6I1K/4IsceqWwdIKMoH0
	 vnNIX/MKAHsjxXfaZ3dNjzejIZYHyFKbgVW0mjbzQXH8zEtvdtaSGdX7DOEAa+Q6Ud
	 XhuxnY62EBe9/HHANYxiS654XUMbnF+/RnFVKhC36kNAml2TlByuj5nZtlNf1H/ePd
	 sVaMiWkkvyLHarmNzJJ/WytMgVWIiea9ImcyCYPzY2oQ7b2nwylLDaY7W2PHV1yqWg
	 h662LNQWalaT/UjmDz7I5jW/V6pV80UHjZ7Uegnxrom31+X9OAT9jDFQmLHAXiEAoF
	 bNaGJMMbYQTZg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f2e370bb3aso900220eaf.0;
        Sat, 08 Feb 2025 09:43:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7ngoD0hhdP7iEt/mSL3XsHLBR+V6mpsvcxTsYzEzcoPD2tLi8CruIIhnJp/B+cW9QIKypvN//M9M=@vger.kernel.org, AJvYcCWleZUhSpCK87PG9JzIyCQT425fkSAfhO4+DA22wtfAsdlwemz1/pS+DMAH20BG4DVX6Mx1KNb6J5/I@vger.kernel.org, AJvYcCWwbVpm/kiCDJx4PNIQe8wq47FjGCMZF/h7L12RGII76eQ2YcCq2jA4uB5WAWWLPPH3HD2c9CZFLcJ9E3U=@vger.kernel.org, AJvYcCXGhYqtq32Y88k6S+7Z18LxdpdkV5S9tvJdGSDLuejoNypyB9soZ7+Ah2uwu9D8IKkHlNMr28u56t3JnVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+5+s8wEBsXJxg+r0g0SKsWsrexkIbaURNkiNa3z6bLLDdxaP
	lJ6iqo/cmYvrLUIEKfxX3XnX0Gu0Y1R00BqzEj/EVV6s5tVrT4PIlSKCZ7PaZJQBo6EHdm9tTEn
	WPnX9cmdvBWKPlfqTP6Y0dEprE8w=
X-Google-Smtp-Source: AGHT+IGTjh+FWxKTmvJkGFR+w5sxOteB5Y57gcLcsNzKCOdIExgatRbDvdM332c7SAsHg4ceollHaZ9FGyv03+fZ5Y0=
X-Received: by 2002:a05:6820:134e:b0:5fa:61b9:3e7e with SMTP id
 006d021491bc7-5fc5e6a7835mr4581042eaf.3.1739036592683; Sat, 08 Feb 2025
 09:43:12 -0800 (PST)
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
 <CAJZ5v0gUcy4V-iztFumRZDUArQHiXE01vW3uC8Y01xnBD6Xi0Q@mail.gmail.com> <Z6eJeo34N0q2ldQ9@hovoldconsulting.com>
In-Reply-To: <Z6eJeo34N0q2ldQ9@hovoldconsulting.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 8 Feb 2025 18:43:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iz7NNhoCTJ4j6GKjqEL5Wip1EJ1kpS71EutSxGVcWuVw@mail.gmail.com>
X-Gm-Features: AWEUYZkbJwAOHfNgPpL9loqovIUYqTzTXsxAEvtgs4JylCrcZzFsfQjJaX8eN_0
Message-ID: <CAJZ5v0iz7NNhoCTJ4j6GKjqEL5Wip1EJ1kpS71EutSxGVcWuVw@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 5:42=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Sat, Feb 08, 2025 at 01:10:19PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Feb 7, 2025 at 7:14=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
>
> > > > > > > On Fri, Feb 07, 2025 at 02:50:29PM +0100, Johan Hovold wrote:
>
> > > > > > > Ok, so the driver data is never set and runtime PM is never e=
nabled for
> > > > > > > this simple bus device, which uses pm_runtime_force_suspend()=
 for system
> > > > > > > sleep.
>
> > For now, the power.set_active propagation can be restricted to the
> > parent of the device with DPM_FLAG_SMART_SUSPEND set that needs to be
> > resumed and that will just be sufficient ATM, so attached is a patch
> > doing this.
>
> I can confirm that this fixes the simple-pm-bus regression (without
> reintroducing the pci warning) in case you want to get this to Linus
> for rc2:
>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>

-rc2 may be a bit too close, and I think I should add a check for
ignore_children to it, but yeah.

I'll send a full patch shortly, thanks!

