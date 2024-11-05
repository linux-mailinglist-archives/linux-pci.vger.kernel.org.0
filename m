Return-Path: <linux-pci+bounces-16078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6319BD665
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 21:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C7B22CED
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 20:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A40213EDB;
	Tue,  5 Nov 2024 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBu9kNBr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694BF20E023;
	Tue,  5 Nov 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836793; cv=none; b=RZydz5lWGIuINTZ03Y8FyyOB3h0qkvjt/wAkeOePLTadRMEAkuzkc7nT2/O/8t2vnF1gq6Rp7tcVmSGDTuUbBbpEVpr1zjwNjfap88hGELvygwtX2rPnaVGd2ccNn5NMAEAIEHnyF2vBqzZfo7SkoQAJCPPR09E6rlWpLLHkC0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836793; c=relaxed/simple;
	bh=EbMymFeRSoH9+NLlqY/J0qe19NUpw6JijuyIE3ui+mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sShtt70hQttU6gmevZFp9uk6TkEqFmzQm/SO+O0cyfraDCHw+//3KiEAAe8BvYN7ppJPNUdzGglQ2EPoF5KAihTD0NdrrmeJlSyhT43cNpr2SHBkByXcwCGKtxs3KuHWjIzUHYooRVLfrQnAuzcUSuwTubxOwvyuOp5YWIEJcSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBu9kNBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FB0C4CED1;
	Tue,  5 Nov 2024 19:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730836792;
	bh=EbMymFeRSoH9+NLlqY/J0qe19NUpw6JijuyIE3ui+mI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MBu9kNBrUTKT9ecai7ouX6RYn9md0wlU5WDnrV9IW3zEDKNFmFmRatRLGqM80+pj8
	 LnkK3UeO4+GsqBzcq7jqwG3H9xUkx5UD2Q3rfN5+xviimoekXKLs6RtQFYKHc93RAH
	 rXfzaEmWdKYVvi9/U1sVeak5C1QU8/kSdKG9IHy7+3DpR25He+Twu32oLoDQZuwjiL
	 Wuly0MaH9DdtfyCbPK1x2snn2xfgoolJKBJuBwjlaH0igbdcxy2HehR1JeY5Vlo4FH
	 vMyRbH7qyMXAzKPDYDQmpdikksbOuVe2ZoxFV3R2Ffca1UWh3ayPBuhxmPoF87JgnW
	 nu1ZuwJ7OWy1A==
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e29327636f3so5122840276.2;
        Tue, 05 Nov 2024 11:59:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1DXqJZAbCwMvOq/sQAc/ENjUCMefqovYNQRZqZYnPSzxutp7lwAdnBKCv9fdh+kSAzapysxn1V/Rg@vger.kernel.org, AJvYcCW9KC8YDhQ5KSn2yDbvZsrAk/vyyYrYGZvCjz81uzHtllWJWgU4LCIQUK9RMdoz7CIeFCqRy0jxbGwA@vger.kernel.org, AJvYcCXqJCRxe2eFJq7VBQmx6AEAcQ3awvjelNxWTIc2Bj1/gYoiiZxPmABgKBcXEuWHEqkFsDjrvnlPj82M7WaD@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQU+2oqLKAEgrEeT77neoSNU6qED+IUQCdNPp+ZnyvkgkrlDg
	BboTs3eZUbd9ZGv+CtWNBT2lphiGqXtxe2ISDHLpH9tQkNsWwzcNKhL07sVdFxJVDDAKieiACWP
	W7zufCMtcL3t5u+VPRr9n4gNn1Q==
X-Google-Smtp-Source: AGHT+IGJAaHDb+/VclImdFQD91atuq0Ptp9vTGB8pxv1hGMyNjDy9wa8nd83p4kPL0hlndsVs2uj4SHRnma9VOJG0nk=
X-Received: by 2002:a05:6902:2605:b0:e2b:cfb7:b0d9 with SMTP id
 3f1490d57ef6-e33025622a4mr15705888276.16.1730836791971; Tue, 05 Nov 2024
 11:59:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104172001.165640-1-herve.codina@bootlin.com>
 <20241104201507.GA361448-robh@kernel.org> <20241105184433.1798fe55@bootlin.com>
In-Reply-To: <20241105184433.1798fe55@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 5 Nov 2024 13:59:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-UhnaJ8TgV1PzCO5yO99NQq3ZZcagKvkvg0YgcxFXug@mail.gmail.com>
Message-ID: <CAL_JsqK-UhnaJ8TgV1PzCO5yO99NQq3ZZcagKvkvg0YgcxFXug@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add support for the root PCI bus device-tree node creation.
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:44=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Hi Rob,
>
> On Mon, 4 Nov 2024 14:15:07 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> ...
> > > With those modifications, the LAN966x PCI device is working on x86 sy=
stems.
> >
> > That's nice, but I don't have a LAN966x device nor do I want one. We
> > already have the QEMU PCI test device working with the existing PCI
> > support. Please ensure this series works with it as well.
> >
>
> I will check.
>
> Can you confirm that you are talking about this test:
>   https://elixir.bootlin.com/linux/v6.12-rc6/source/drivers/of/unittest.c=
#L4188
>
> The test needs QEMU with a specific setup and I found this entry point:
>   https://lore.kernel.org/all/fa208013-7bf8-80fc-2732-814f380cebf9@amd.co=
m/

Yes, that's it.

> Do you have an "official" QEMU setup on your side to run the test or any
> other pointers related to the QEMU command/setup you use?

No, it's just something based on what you linked. Here's what I have:

qemu-system-aarch64 -machine virt -cpu cortex-a72 -machine type=3Dvirt
-nographic -smp 1 -m 2048 -kernel ../linux.git/arch/arm64/boot/Image
--append console=3DttyAMA0 -device
pcie-root-port,port=3D0x10,chassis=3D9,id=3Dpci.9,bus=3Dpcie.0,multifunctio=
n=3Don,addr=3D0x3
-device pcie-root-port,port=3D0x11,chassis=3D10,id=3Dpci.10,bus=3Dpcie.0,ad=
dr=3D0x3.0x1
-device x3130-upstream,id=3Dpci.11,bus=3Dpci.9,addr=3D0x0 -device
xio3130-downstream,port=3D0x0,chassis=3D11,id=3Dpci.12,bus=3Dpci.11,multifu=
nction=3Don,addr=3D0x0
-device i82801b11-bridge,id=3Dpci.13,bus=3Dpcie.0,addr=3D0x4 -device
pci-bridge,chassis_nr=3D14,id=3Dpci.14,bus=3Dpci.13,addr=3D0x0 -device
pci-testdev,bus=3Dpci.12,addr=3D0x0

Of course, you'll need a few changes to use ACPI.

Rob

