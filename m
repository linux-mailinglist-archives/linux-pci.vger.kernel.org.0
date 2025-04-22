Return-Path: <linux-pci+bounces-26385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6D8A96801
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DBD1642CB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ADB433A6;
	Tue, 22 Apr 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIwB5WIV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13D8F50F;
	Tue, 22 Apr 2025 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322220; cv=none; b=EE5JgWdnFkma8n26fqFiYOpp6Enskr1QWuUBU9s1Fu20QVU2e1Pk8N2qlk3v8FFyhOCU1lxnLihz+9iWMe1a0mTHL50AUrSiqTrgxfPZMehSX8AUuJgjztLpaewAO/kLVP8FZCqaM481ytvQ6uoYG1EwWM5Or95+HsdLWFkqUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322220; c=relaxed/simple;
	bh=VOqgcuQXGdi3HGEckWBW0T3NXXHO43h2bQde17C8TQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RC7glCA954Bac9SLVDYKvep0kUHR82EtVKTN06YI3BO0GAN+20duajmItU5A5TpHPx5aKvPN/E8rTLE1whPEhdDv5pcRY68uIHudDREzoUcIepdu8rnLV3XThIARxU0KZ4+KU6Du0cpwUbbj1PKcbpU0HZ66tRBtrO4y2mXX6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIwB5WIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670DBC4CEEF;
	Tue, 22 Apr 2025 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745322219;
	bh=VOqgcuQXGdi3HGEckWBW0T3NXXHO43h2bQde17C8TQQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QIwB5WIVBHiAVyBY7oG2BnXK7Yy81JtRgE/8tw0AoKP399pDa5JTzt/wHYJCaEMIW
	 azGjeIs+QL+Z8QoaXYvBvp2b+UmNgeaXfR2xn8/Uy04XgCPeDQooPsh2g/Wiwi+TXc
	 qYg4WUa2MyxBbd+So8xO5NcDnQjBN4+FpM2xfo31ID5qKdiJeh8Bru9y0ogI45+0el
	 dojh2bzct7iUAfXTe7LVaesIpbEwKrb/OzJ7U8Qfrbp2c1w9cUV6sHd0DFk9RJpxfz
	 ht00n46ttF6piQ3GozCe+kF9pED8ymRNOuZi5piteE96bbejI4bVLNbYrYs5LiBWa+
	 QQXPmw79pIUSQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7302a769534so1046800a34.1;
        Tue, 22 Apr 2025 04:43:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY/ceg+NiGd0c0xZxudXqY+tQVe4pGY3qyR7A6s4oeaA++1K0auAQ1N1CmHAr4CahyAoFf/Ah/kgVB@vger.kernel.org, AJvYcCXmf8DnNn+qbIQ7HO3nAoFTXSE8hNhukoKJz3ykyedoOkuOFR2qLBNjwkxhfq00m7cVtInvY5hHxjGN@vger.kernel.org
X-Gm-Message-State: AOJu0YxxjWiSw8GEIqzrDjKTcT1hTbDJmQ+3Z8sA2xWFbjaFtpmh2Xu/
	n7OYAhqWzjQxrog3ZFjJYqrcAmsC9utlm+YvQxL2O1Y5AJKjKFJimDdeTiFMt05wRUBkyuCzU8+
	90jjGN18v2I7PE8wI3yj4I0jlPJc=
X-Google-Smtp-Source: AGHT+IFCxk8nVdfS637xkBJJXCBIB9GPonJFZH1TT3dr+j/gRAiqO7Guj+AeZwZk+zQH76AnqjiSFLnp1DRzHmJWUvg=
X-Received: by 2002:a05:6870:a54f:b0:2d5:b7b7:2d6e with SMTP id
 586e51a60fabf-2d5b7b7597bmr2501433fac.38.1745322218747; Tue, 22 Apr 2025
 04:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <62de9027-e4cd-4192-90e8-64f4c4a8fe4b@gmail.com> <aAc26NTVcXy1BCxU@wunner.de>
In-Reply-To: <aAc26NTVcXy1BCxU@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Apr 2025 13:43:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iWTd_ndpAr=q8QJC2MWSheq0UXVR6a1oyGSH063yzpFw@mail.gmail.com>
X-Gm-Features: ATxdqUHGwVu31OeFpdX-0QtgAs8fGoucoiud8bDZzbH4-6ZOyqeHzXALINqRgu4
Message-ID: <CAJZ5v0iWTd_ndpAr=q8QJC2MWSheq0UXVR6a1oyGSH063yzpFw@mail.gmail.com>
Subject: Re: Potential issue with pci_prepare_to_sleep if there's no platform
 support for D3cold transition
To: Lukas Wunner <lukas@wunner.de>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 8:28=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> [cc +=3D Rafael, linux-acpi]
>
> On Mon, Apr 21, 2025 at 10:05:59PM +0200, Heiner Kallweit wrote:
> > If there's no platform support for transition to D3cold, then
> > pci_set_power_state(dev, D3cold) still returns 0, even though
> > power state is transitioned to D3hot only. We called
> > pci_enable_wake(dev, D3cold, wakeup) before, therefore PME for
> > D3hot may not be enabled. Is this a bug?

On platforms using ACPI, no it isn't.

Internally, pci_enable_wake() evaluates _DSW and it doesn't
distinguish between D3hot and D3cold as per the spec.

> > Background:
> > In __pci_set_power_state we have the following:
> >
> > error =3D pci_set_low_power_state(dev, PCI_D3hot, locked);
> > if (pci_platform_power_transition(dev, PCI_D3cold))
> >       return error;
> >
> > The acpi_pci_set_power_state() stub returns -ENODEV.
> > Therefore, if error=3D0,  __pci_set_power_state() will
> > return 0 if pci_platform_power_transition() fails.
>
> pci_prepare_to_sleep() calls pci_target_state() right at the top.
>
> If wakeup is supported and enabled, pci_target_state() is supposed
> to find the deepest power state supporting wakeup.  If D3cold doesn't
> support wakeup, D3hot or a shallower state is returned.
>
> Hence I don't quite understand how the scenario you're describing
> could occur in practice.  Are you seeing actual issues and have tracked
> them down to incorrect handling in pci_prepare_to_sleep()?

