Return-Path: <linux-pci+bounces-35123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63597B3BDD7
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 16:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8868A188FD4B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8657D322759;
	Fri, 29 Aug 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZRRb8Sn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59F322750;
	Fri, 29 Aug 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477836; cv=none; b=e3ynYpffXjJYfruoTJ26zMG2Yt958y2uFbv58KYcjJcKpgTW1SMT5nCPobyd+EzFuvv/bSPjTgL+XsKwDZ25SEHl1wbjBzk/g1KZtnM3P+evKBvn4MIggWbyjywijwq/p56xT++9u2I9s5OvY7vldAOrisrrErTGKFyFJgy94aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477836; c=relaxed/simple;
	bh=TDzlJGc+6ILCuh6eMUdOzByrZCcyRtrpmu6vYLBLqjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtmQ3ar2RPrmXP145/GG/GdnLTwJJMd0kFBFJkt8w6Xd8w8uDHW5Dcnsw4gvrs7qxgl+t5LINI7i1a/nersbhlNMakcobtK8ll7iv/CFSsG1rRLbBABQ7YXYAIjDLLng0h74Htdu3g4ny6ugkPMoj6RQ0F9gS4O8oKWIUxFQipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZRRb8Sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3814C4CEF0;
	Fri, 29 Aug 2025 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756477836;
	bh=TDzlJGc+6ILCuh6eMUdOzByrZCcyRtrpmu6vYLBLqjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hZRRb8Sn8s3O0oZTKYwSbJ+xtsnXMo10Ot0NK3PW3ZjFEHuw8FNVX2MAGnR5jMA3w
	 fDMenp+QIA9131BzKbN9KCiMN1jJ5sw+mUMt+upMGbD5Riazfpfcq0tN0XiG5k5YPA
	 flNRzqJ88Jb4kjJcjoHG1j7kdU4bmngN6UIGrH3FhoDvZGEUleB7ji5skRwgaB6WR6
	 NvYsox90K9K7p/XwdSHEdhEVpq6jtELIkCnoIug1pU8PJugGuYqvPEWTD/jQziFZuS
	 LUrzQ8EfBaGT87qVfAeNaDMvZQBXOjK4gWEikMAETltMoeNnxK0L6eIEpuzwZNO5HL
	 9Wu2jWlMEfqNw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61d106ce455so804205a12.1;
        Fri, 29 Aug 2025 07:30:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDNbbnZZ1OqocgrcBltXKH5RfdMZJUvXzofWQDLwXuptLyCkOQNuCjlWiwRYoOgT8NwwxrtpEis52j@vger.kernel.org, AJvYcCWd/99VVMX9sqWs+6ZMACl0RCyN2dSxpeJwVcffigYDxF7nJ+1k//GRJAxE5GobISl8BHBP+0tG7Ekm@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdCKpl65bSz5uMQjbpIuNPlJAvV59hq1cA7jddlK+lJLDYT1H
	/589FOgUe4vEGvvpYDxAflTGUKHLlfjKNpO+83HpBkfkPUAhUY5rUQNZb7ydyyleKQCZXB2chd0
	SJTrZ1C+aSNBroyTHlx2ys/ZC+jEdoQ==
X-Google-Smtp-Source: AGHT+IEPU9nMwzElQfU4CeXdP0ykOAyR78uSUbbsRNYdOsTatNAF/79WTSSgG8V0SgOJHD6JSf1l+adYoKfgoiK9r4c=
X-Received: by 2002:aa7:cc94:0:b0:61c:1d41:41bb with SMTP id
 4fb4d7f45d1cf-61c983b84d4mr8359447a12.16.1756477834611; Fri, 29 Aug 2025
 07:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818093504.80651-1-lpieralisi@kernel.org> <aKR5w1QIqYUO2upd@lpieralisi>
In-Reply-To: <aKR5w1QIqYUO2upd@lpieralisi>
From: Rob Herring <robh@kernel.org>
Date: Fri, 29 Aug 2025 09:30:21 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+y2dW0d3V93a3XDEhZUnw9Ky7MkvvVUzndPkur1TD=bg@mail.gmail.com>
X-Gm-Features: Ac12FXzlwvLlWrt40kOso0O-91Qm4-HVFGYuDi1LC46G0IWNeJtfRZcSAihy1qA
Message-ID: <CAL_Jsq+y2dW0d3V93a3XDEhZUnw9Ky7MkvvVUzndPkur1TD=bg@mail.gmail.com>
Subject: Re: [PATCH] PCI: of: Update parent unit address generation in of_pci_prop_intr_map()
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lizhi Hou <lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:19=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> On Mon, Aug 18, 2025 at 11:35:04AM +0200, Lorenzo Pieralisi wrote:
>
> [...]
>
> >  drivers/pci/of_property.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> > index 506fcd507113..09b7bc335ec5 100644
> > --- a/drivers/pci/of_property.c
> > +++ b/drivers/pci/of_property.c
> > @@ -279,13 +279,20 @@ static int of_pci_prop_intr_map(struct pci_dev *p=
dev, struct of_changeset *ocs,
> >                       mapp++;
> >                       *mapp =3D out_irq[i].np->phandle;
> >                       mapp++;
> > -                     if (addr_sz[i]) {
> > -                             ret =3D of_property_read_u32_array(out_ir=
q[i].np,
> > -                                                              "reg", m=
app,
> > -                                                              addr_sz[=
i]);
> > -                             if (ret)
> > -                                     goto failed;
> > -                     }
> > +
> > +                     /*
> > +                      * A device address does not affect the
> > +                      * device<->interrupt-controller HW connection fo=
r all
> > +                      * modern interrupt controllers; moreover, the ke=
rnel
> > +                      * (ie of_irq_parse_raw()) ignores the values in =
the
> > +                      * parent unit address cells while parsing the in=
terrupt-map
> > +                      * property because they are irrelevant for inter=
rupts mapping
> > +                      * in modern system.
>
> Rob,
>
> if you apply directly the line above should be "in modern systems" please=
.

But this should go via PCI tree.

Reviewed-by: Rob Herring <robh@kernel.org>

