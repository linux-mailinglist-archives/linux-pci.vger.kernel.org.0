Return-Path: <linux-pci+bounces-21108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228F7A2F7F0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 19:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE293A26FF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BBB25E455;
	Mon, 10 Feb 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmod7NZH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB5B25E452;
	Mon, 10 Feb 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213478; cv=none; b=h0yBIbegZcWMWdLf1oBqO+fW69VezfUUoRNH+Th9Gqdb0Cb7Ge235UFMfv5JZkiGiT2pHU1T+gHlActGFzXS+6v598VMd9b//7nb+AAJ76xRsV4V65U2A53B4A4hGehWTOsbu1hdeCdYvurvw7udJlg8K43HH/xemhs8ClCzh7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213478; c=relaxed/simple;
	bh=vKwUfzZZsVXH9hNtIlfjBh7hnT/kWSNPj917d5FaKno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNjux0K94ZrIy0Fgz1gls2wuRIP6Acy5znjNEqloI0F0IQA53pSmF7V0VlVDEeeDdAXcW49M7/9SCGwqn67HpSW7FGA1xzWWwOkyceg/4aVt3vS7pAqJbQuc+jRi/2jeFX6AuyMcs2SY/8NCnb2K59HAqeSDIWl6J2y1DxQ0huQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmod7NZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1329DC4CED1;
	Mon, 10 Feb 2025 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739213478;
	bh=vKwUfzZZsVXH9hNtIlfjBh7hnT/kWSNPj917d5FaKno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dmod7NZHfmfXTYzQIYatAogcnlZKKzsEeQBK4AEqk2acknQ4ljDVIrMqKASskdH1L
	 04xbMAt+cACW3e5XakoZ8v8ZPtuWCVLwH0Oyh3w+M7gemcMSypUnKw+B7yB7Znd+ii
	 NuUk5zIRd3w9dKfvQB8XhIqCZylJHmQOmI9dZWEwnsxu9azb7g5CBdKi7BdYW84cm8
	 BOif943ltYn+XVIWvkW3CvUiuV3ZimWNMxs71u+Z23d472w9f8Htu+pJnAnPhYS4rt
	 UJ0wZKIN5tnPEOqj8j9yumLNLtpRdLQ0xT38I9RFZtkJWcIdBQ5Mxyu0/YbE5gCqlf
	 5gKhOLo/M61Qw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f3ac0f24ddso996856b6e.0;
        Mon, 10 Feb 2025 10:51:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX41+hlHPWMTzU4YvlSWo4dXy0v+yLIPzSmFWFi+FkEnLo2bZsnNN/9KMGT0mPVBfUH4hQAo2+YOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv0QLFIZNkFBi6q67tdku0st2II2Jz9DI1oT3aMJ1nTqo9jDxa
	XA5qrRxWEC3brTcfH6jlDvT6SfO5BJ14n2rlxAlby62UquUKOgDbShiynI+RxE9vcgrkvwN/tId
	PTnOW7h0fyUgvFa4Q1jCpXP/D3q0=
X-Google-Smtp-Source: AGHT+IHDdIHyYy8iVGVh+78ne5N+j0fzXD18WmH+kELAzrN2cmKB86xmsmBvCW/rDiJE710r9yfqE4OHgILKSmSOdvU=
X-Received: by 2002:a05:6808:1a1e:b0:3f3:b153:c231 with SMTP id
 5614622812f47-3f3c2ae0cf6mr307977b6e.17.1739213477364; Mon, 10 Feb 2025
 10:51:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210170715.GA8877@bhelgaas> <CAJZ5v0gN=Go7kg=hhEDCpOhbw7H0hQYow_TW7G1wZRXs4jAkVA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gN=Go7kg=hhEDCpOhbw7H0hQYow_TW7G1wZRXs4jAkVA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 10 Feb 2025 19:51:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jQT=hTi0RS4W34QX3ZXFBByTj+neX6wZ3Gt+pvc0B_7Q@mail.gmail.com>
X-Gm-Features: AWEUYZkpAJqJHVu3JirqxqHqL3_ke29U4SjGZSz9zG4DaAImeLZ5RRoG0pn0YmQ
Message-ID: <CAJZ5v0jQT=hTi0RS4W34QX3ZXFBByTj+neX6wZ3Gt+pvc0B_7Q@mail.gmail.com>
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 219765] New: Regression: VFIO
 NVIDIA GPU Passthrough Fails in Linux 6.13.0 (GPU Reset & Audio Controller Disappears)]
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, 
	linux-pm@vger.kernel.org, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 6:33=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Feb 10, 2025 at 6:07=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org=
> wrote:
> >
> > #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219765
> >
> > I don't see an obvious culprit between v6.12 and v6.13, suggested
> > bisection if possible.
> >
> > Workaround: boot with pcie_port_pm=3Doff
> >
> > Given the workaround, maybe it's worth trying a revert of this:
> >
> >   dc421bb3c0db ("PCI: Enable runtime PM of the host bridge")
>
> I would ask the reporter to revert it and see if that helps.
>
> The
>
> vfio-pci 0000:01:00.1: Unable to change power state from D0 to D3hot,
> device inaccessible
>
> message in the failing case is kind of unexpected.

And this message is unlikely to be related to commit dc421bb3c0db
because it indicates a failure to change device power states.

