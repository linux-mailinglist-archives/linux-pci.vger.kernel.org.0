Return-Path: <linux-pci+bounces-37205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F13BA9780
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 16:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8422C164EA7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 14:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80C0308F36;
	Mon, 29 Sep 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh/wv5U+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF5305047
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154653; cv=none; b=d+U3w5BZHk14Wtm1sYVgyUsrrkQwruqNu+fgFkb9BCup5woODWIwEAMuMMqJ3SSrTOdc/WqfzmHGa+CpnG4ufQ6w7HE6ucc/8zRXRqG5Rc27eHOd3TtbJcLWa4Tk4qvmEGEmKDXBCQs2BW6HkXfn0O+B2ggA2YtY12kChdlRYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154653; c=relaxed/simple;
	bh=0dqbplPk5+xdd940bMeF8GS6INexn40MMj7UgHcMuYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkQks2t5uyEhziRrp6XTTO8pG2uUJo0hufu+/MkJ9GZUN9Uqv/7nj4xL2pmJtR6p8PhOjewJJI6Aan3DvjTxhVrFFt1YEd82qiI+VGmPvbp5dludmeRNdvaUwcnnZP6PAzK+S9gb0nmWg9CahcQaCPRgp0AmQY43nTnxIX8PifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh/wv5U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E00C16AAE
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 14:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759154653;
	bh=0dqbplPk5+xdd940bMeF8GS6INexn40MMj7UgHcMuYo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hh/wv5U+UHu8TgmC1Q86biB9ot8OrMNGUaMyP5tNt6djxPAn4XS1kcjxeiVbTjUmQ
	 1g9jt2ImDMdx94g5kp+17ng6oSJwOYqHM8K2+4TAEoU+Z3YWZdtO/xr/D+cG3+hHWD
	 bjf4Ul7YKJp+fogwLPsjIaYXgOevsljQ3dIMEWWLPRIVHdzp4dZJODu8ibOkVnCsE+
	 GMduY+QXyrzo54WqO3lzlj4ZIN+CVABNmBQpSR45+LZ09rjqIycHauLosyogKbpyJq
	 byIRgewu64kGjsw0h0q9P7gzafjaEwL/eZrrrmT38Pc/WJqoFzTwTMrXXa+UJHuwp2
	 3fIwIGz8XPfvw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3e25a4bfd5so240573066b.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 07:04:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUn9owuAAnryodpt//tjUkPWrbfiVgXJTQFWyyIpDBd6SUm9UD8IiuJB+aDutB8aohgMXgQln+gLE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYPUGOiVeO1mjeCzC/orTD6G55XudmDG4vYaWvmjbq0g0xzn3
	BCrafaYDAsBNHmDEDSgm72Ml9W4dLB1XEpDOC3F+qUVoHGJ3bPXs0FATQxcMC7zC8d0i3x5SEd7
	4ZAmg39K4YLgksva1ipsAw1PFsdwhzA==
X-Google-Smtp-Source: AGHT+IGQUkv8sSQJZtMXHXl3vj5TRLZ6dy5UjadMrQjUPv9UeUy0QibDfpGKzf8eHPJCT+VBs3ytFI88Kxw5hSp2UIU=
X-Received: by 2002:a17:907:2d0e:b0:afd:d9e4:51e9 with SMTP id
 a640c23a62f3a-b34bf6638a0mr1764243366b.65.1759154651818; Mon, 29 Sep 2025
 07:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNPq42O1Ml3ppF2M@swlinux02> <20250926211023.GA2128495@bhelgaas>
In-Reply-To: <20250926211023.GA2128495@bhelgaas>
From: Rob Herring <robh@kernel.org>
Date: Mon, 29 Sep 2025 09:03:59 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+HDgghAQps5M0jV7ELxR=M7pRCuEKwgSMcJQfS3Ecsrg@mail.gmail.com>
X-Gm-Features: AS18NWAmQA2tJ--eCc8Z2eodRbVjVdQj6lT7kiA7TgSr-wS6_p_6i5Ndf_AUHzk
Message-ID: <CAL_Jsq+HDgghAQps5M0jV7ELxR=M7pRCuEKwgSMcJQfS3Ecsrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] PCI: dwc: Skip failed outbound iATU and continue
To: Bjorn Helgaas <helgaas@kernel.org>, Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, alex@ghiti.fr, aou@eecs.berkeley.edu, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, ben717@andestech.com, inochiama@gmail.com, 
	thippeswamy.havalige@amd.com, namcao@linutronix.de, shradha.t@samsung.com, 
	randolph.sklin@gmail.com, tim609@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:10=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Sep 24, 2025 at 08:58:11PM +0800, Randolph Lin wrote:
> > On Tue, Sep 23, 2025 at 09:42:23AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Sep 23, 2025 at 07:36:43PM +0800, Randolph Lin wrote:
> > > > Previously, outbound iATU programming included range checks
> > > > based on hardware limitations. If a configuration did not meet
> > > > these constraints, the loop would stop immediately.
> > > >
> > > > This patch updates the behavior to enhance flexibility. Instead
> > > > of stopping at the first issue, it now logs a warning with
> > > > details of the affected window and proceeds to program the
> > > > remaining iATU entries.
> > > >
> > > > This enables partial configuration to complete in cases where
> > > > some iATU windows may not meet requirements, improving overall
> > > > compatibility.
> > >
> > > It's not really clear why this is needed.  I assume it's related
> > > to dropping qilai_pcie_outbound_atu_addr_valid().
> >
> > Yes, I want to drop the previous atu_addr_valid function.
> >
> > > I guess dw_pcie_prog_outbound_atu() must return an error for one
> > > of the QiLai ranges?  Which one, and what exactly is the problem?
> > > I still suspect something wrong in the devicetree description.
> >
> > The main issue is not the returned error; just need to avoid
> > terminating the process when the configuration exceeds the
> > hardware=E2=80=99s expected limits.
> >
> > There are two methods to fix the issue on the Qilai SoC:
> >
> > 1. Simply skip the entries that do not match the designware hardware
> > iATU limitations.  An error will be returned, but it can be ignored.
> > On the Qilai SoC, the iATU limitation is the 4GB boundary. Qilai SoC
> > only need to configure iATU support to translate addresses below the
> > "32-bits" address range. Although 64-bits addresses do not match the
> > designware hardware iATU limitations, there is no need to configure
> > 64-bits addresses, since the connection is hard-wired.
> >
> > 2. Set the devicetree only 2 viewport for iATU and force using
> > devicetree value.  This is a workaround in the devicetree, but the
> > fix logic is not easy to document.  Instead, we should enforce the
> > use of the viewport defined in the devicetree and modify the
> > designware generic code accordingly =E2=80=94 using the viewport values=
 from
> > the devicetree instead of reading them from the designware
> > registers.  Since only two viewports are available for iATU, we
> > should reserve one for the configuration registers and the other for
> > 32-bit address access.  Therefore, reverse logic still needs to be
> > added to the designware generic code.
> >
> > Method 2 adds excessive complexity to the designware generic code.
> > Instead, directly configuring the iATU and reporting an error when
> > the configuration exceeds the hardware iATU limitations is a simpler
> > and more effective approach to applying the fix.
>
> I don't know the DesignWare iATU design very well, so I don't know if
> this issue is something unique to Qilai or if it's something that
> could be handled via devicetree.

I believe it should probably be handled in the DT. The iATU is
programmed based on the bridge window resources which are in turn
based on DT ranges and dma-ranges. If there's a failure, then
ranges/dma-ranges is wrong. Or the driver could adjust the bridge
window resources before programming the iATU.

Please provide what the DT looks like (for ranges/dma-ranges) and
where problem entry is.

Rob

