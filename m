Return-Path: <linux-pci+bounces-42698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37309CA80BE
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76F3931861E3
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB4E3D3B3;
	Fri,  5 Dec 2025 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJVUuWiV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6D1B6D1A
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943103; cv=none; b=W0wcblq2vwZ/O8uoGJQAVlHOATulBRjvHS1VjJqD+Nu2c/8kjfsODmoAmoLOZa6GyrwvX6AoPPfg63llnNvKaTMHJP2YKcrFI5WtPIUmNKy+m5ey6JVkAAJBxYDC3vdL9Jio4rMiqOeBn+pba1uF7Xvi9cBwlK+N7cOZ3Fe6kNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943103; c=relaxed/simple;
	bh=LZShE+5oGM6dzJ5O4BH/G2vZR20NIcB6Y38rm346EWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnYs2VONKIeUYxGRHhQIycu8oMj1ABmOJgfM2SX2gFCZ62Nc8WJavIJ7GjP/3yW/aM8Z781t+FW5QUQb8aMEWbwgQHHdI1pcX99w+XxtWcVhTH8iTIpKpT9KBsVvU8aZWj/ymrz1o181ERnQRJtrIq7fbOoP8nNzt4LH+cDAwkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJVUuWiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BDDC4AF0B
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764943102;
	bh=LZShE+5oGM6dzJ5O4BH/G2vZR20NIcB6Y38rm346EWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WJVUuWiVbtSdew8OXH/EvWAwLN4T0AG1WL0rYqBetYjUTIZieDdlFbR4Xui8e3IIL
	 GUUYxtlzVsfITqpgMIm2aenKFyUNQ3ZwueKA1XXxOxn63/ciETHkPLtY/kLUkeeErd
	 KcSLaapAVvU/Va558j9LrmC+1j63EWUeTjy5Pz373efqKzOE+Oc99S4KB2Q3izWl9/
	 eZE5PGMeyXvFdGxJt4csfftqn9wDi3lF5u/mDii2CqCzk4YIHH971IDZGY18D4CmkY
	 HgTA1wDCsFX63QRLilVxSu3Z7zzV/YxUSZEiRj6v/p8IwF5tGGozpGlZ+30a0GwVN+
	 hNMFRz+v/rb7Q==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso3448673a12.1
        for <linux-pci@vger.kernel.org>; Fri, 05 Dec 2025 05:58:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUKr4Cj3WgSwj6mNc+moyUNKI6064lKBPypO8Z2z2nLkr8rXSkxJ9hjqo5m3m2rK1RL2iiZNXotoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYOsevh0nYS8fIWq+ETnqXn++yiOvH5OYcLSEoWT2n74oEGbrP
	jLfjDOG8VD6Vc1P2Ei438UKFx1bPvTPV1f5RIcv7u5/V68Gx2ruM2rAfsw8pUJ3hIbKtuFq6LmB
	MUZ3ge0wx7GgzTQaJeQzBONKXKi0rMw==
X-Google-Smtp-Source: AGHT+IFj7IYZAObfwZ/125eKIdXSf31gFFV6NtcE6OruMiZbOn5ppciv1VJr3lX1pOezbXFsILgw/7cff0xX0mcpaHw=
X-Received: by 2002:a05:6402:2219:b0:62f:9091:ff30 with SMTP id
 4fb4d7f45d1cf-647a69e3e89mr4681028a12.3.1764943101507; Fri, 05 Dec 2025
 05:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106182708.03cfb6c6@bootlin.com> <20251106175016.GA1960490@bhelgaas>
 <aQ28s57R0YfrqwdG@apocalypse> <20251107125828.18a034de@bootlin.com>
In-Reply-To: <20251107125828.18a034de@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 5 Dec 2025 07:58:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ_gCu_A2YqX4r2UMWssJ=4FprsM_Os3Zw=V8yCTGubdA@mail.gmail.com>
X-Gm-Features: AQt7F2r0HNuBdQmC_0MZ5QKG3yBW-kQ8XLP5zEy97eqMnTsBQFsB1b5aAna8aSY
Message-ID: <CAL_JsqJ_gCu_A2YqX4r2UMWssJ=4FprsM_Os3Zw=V8yCTGubdA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: of: Downgrade error message on missing of_root node
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mbrugger@suse.com, guillaume.gardet@arm.com, 
	tiwai@suse.com, Lizhi Hou <lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 5:58=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> Hi Andrea, Bjorn,
>
> On Fri, 7 Nov 2025 10:32:35 +0100
> Andrea della Porta <andrea.porta@suse.com> wrote:
>
> > Hi Bjorn,
> >
> > On 11:50 Thu 06 Nov     , Bjorn Helgaas wrote:
> > > On Thu, Nov 06, 2025 at 06:27:08PM +0100, Herve Codina wrote:
> > > > On Thu, 6 Nov 2025 16:21:47 +0100
> > > > Andrea della Porta <andrea.porta@suse.com> wrote:
> > > > > On 13:18 Thu 06 Nov     , Herve Codina wrote:
> > > > > > On Thu, 6 Nov 2025 12:04:07 +0100
> > > > > > Andrea della Porta <andrea.porta@suse.com> wrote:
> > > > > > > On 18:23 Wed 05 Nov     , Bjorn Helgaas wrote:
> > > > > > > > On Wed, Nov 05, 2025 at 07:33:40PM +0100, Andrea della Port=
a wrote:
> > > Patch at https://lore.kernel.org/r/955bc7a9b78678fad4b705c428e8b45aeb=
0cbf3c.1762367117.git.andrea.porta@suse.com,
> > > added back for reference:
> > >
> > >   diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > >   index 3579265f1198..872c36b195e3 100644
> > >   --- a/drivers/pci/of.c
> > >   +++ b/drivers/pci/of.c
> > >   @@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_ho=
st_bridge *bridge)
> > >
> > >       /* Check if there is a DT root node to attach the created node =
*/
> > >       if (!of_root) {
> > >   -               pr_err("of_root node is NULL, cannot create PCI hos=
t bridge node\n");
> > >   +               pr_info("Missing DeviceTree, cannot create PCI host=
 bridge node\n");
> > >               return;
> > >       }
> > >
> > > > > > > > > When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error
> > > > > > > > > message is generated if no 'of_root' node is defined.
> > > > > > > > >
> > > > > > > > > On DT-based systems, this cannot happen as a root DT node
> > > > > > > > > is always present. On ACPI-based systems, this is not a
> > > > > > > > > true error because a DT is not used.
> > > > > > > > >
> > > > > > > > > Downgrade the pr_err() to pr_info() and reword the messag=
e
> > > > > > > > > text to be less context specific.
> > > > > > > >
> > > > > > > > of_pci_make_host_bridge_node() is called in the very generi=
c
> > > > > > > > pci_register_host_bridge() path.  Does that mean every boot
> > > > > > > > of a kernel with CONFIG_PCI_DYNAMIC_OF_NODES on a non-DT
> > > > > > > > system will see this message?
> > > > > > >
> > > > > > > This is the case, indeed. That's why downgrading to info seem=
s
> > > > > > > sensible.
> > > > > > >
> > > > > > > > This message seems like something that will generate user
> > > > > > > > questions.  Or is this really an error, and we were suppose=
d
> > > > > > > > to have created of_root somewhere but it failed?  If so, I
> > > > > > > > would expect a message where the of_root creation failed.
> > >
> > > I think we should just remove the message completely.  I don't want
> > > users to enable CONFIG_PCI_DYNAMIC_OF_NODES out of curiosity or
> > > willingness to test, and then ask about this message.

No, please keep it. Anyone that enables CONFIG_PCI_DYNAMIC_OF_NODES
should know what they are doing. I was thinking it should be hidden
behind EXPERT perhaps.

> >
> > Agreed. This would be the easy solution, the other being creating the
> > empty DT so that the message will never be printed. But this require so=
me
> > careful thought. The latter solution will be needed if we'll ever want =
to
> > make drivers like RP1 or lan96xx (which uses the runtime overlay) to wo=
rk.
> >
> > >
> > > "You can avoid the message by also enabling CONFIG_OF_EARLY_FLATTREE"
> > > is not a very satisfactory answer.
> >
> > Unfortunately this would work on x86, but not on arm. And who knows on
> > other platforms.
> >
> > >
> > > A message at the point of *needing* this, i.e., when loading an
> > > overlay fails for lack of this dynamic DT, is fine.
> >
> > It seems fine to me.
> >
>
> Ok, even if I would prefer having an empty (or not) of_node available on =
all
> platforms, what is proposed makes sense especially in regards to potentia=
l
> users questions.

Having a DT always available was the original intent, but the arm64
maintainers resisted so that's a fight for another day when someone
really wants to use this on an ACPI system. Now riscv has done the
same thing unfortunately.

Rob

