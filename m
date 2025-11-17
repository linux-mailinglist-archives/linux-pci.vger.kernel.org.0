Return-Path: <linux-pci+bounces-41355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14849C6248F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 04:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C29CE4E60F0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 03:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450952F12C7;
	Mon, 17 Nov 2025 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ReNdiVpe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09EC22FE11;
	Mon, 17 Nov 2025 03:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351839; cv=none; b=MCINf/VHnuJIYQ7oD6QsXbRjw+e6mqa5RX/X+wUUS/OVfozzsdtQus7O3Rk9C+RB1xS7DIKfhQBEq1ETUbTRQ4qxtYT9z58nf4aUmsHK9dWltUED+Fi/OkEVk1jASzVhjfX+HFwmO5WKsxE8fyPxOVKvZ+WlmMQMqAntNysFhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351839; c=relaxed/simple;
	bh=7GAsV4shDMmM/4Cr5HBvJqE82KAZ+Ys+ssRT6rBZE7o=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=DTO/K2bzS1azUhT4cTVD9PUam+CtlAHDAdjm4J1StZtA+Q7c5VRxhjR0LmoyEJLSgp/027uM2qsIioI0ug3U/+Nwngu0Pdf4HbRz7j+wtplZPRoYxNQtLz8+UTi4/itM4dyoa1i6l/t9CYo9bjD95MgUXzPn2JAq7YXwJ5d8ryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ReNdiVpe; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 8855841196;
	Mon, 17 Nov 2025 04:57:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1763351834; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BT04am3Kehc9aOs97jW5wTodqgxSkKf04K5hJUaJPzg=;
	b=ReNdiVpeKrbgcSVmskmDotomCmwdsUx3+lrrU0N+K8oOwEV3dkiVyZQcohUTzaGNKRKgtk
	hYQeg1FoGF3ALHk6FnHSjPCylwzuNmoOROB/sIR2JgkwXRLPXXJyUkt5FtZYGs+l++rLVv
	j27F0p/AQ+LZm5JvqnMmp5we99oF8L1vBwyYj3OerttrRhPqqNq28yIBRY7ClbHIy/yamE
	lR4bThz0szV2dhvXjmty4JyC/IAItlWzSNa3kC+Md03xB4Z+TEZSUL5NgqEoLHZzudlAPP
	3yKvBIVIkDFCwAh8mhmlshQ5zUoBjFMjc8AkyMspHhP18woVqWhU4LspaHFCRQ==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <8f3cc1c1-7bf7-4610-b7ce-79ebd6f05a6e@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
References: <cover.1763197368.git.geraldogabriel@gmail.com> <8f3cc1c1-7bf7-4610-b7ce-79ebd6f05a6e@rock-chips.com>
Date: Mon, 17 Nov 2025 04:57:11 +0100
Cc: "Geraldo Nascimento" <geraldogabriel@gmail.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>, linux-rockchip@lists.infradead.org
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <257951b7-c22e-9707-6aba-3dc5794306bb@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH 0/3] =?utf-8?q?PCI=3A?==?utf-8?q?_rockchip=3A?=
 =?utf-8?q?_5=2E0?= GT/s speed may be dangerous
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Shawn and Geraldo,

On Monday, November 17, 2025 04:42 CET, Shawn Lin <shawn.lin@rock-chips=
.com> wrote:
> =E5=9C=A8 2025/11/15 =E6=98=9F=E6=9C=9F=E5=85=AD 17:10, Geraldo Nasci=
mento =E5=86=99=E9=81=93:
> > In recent interactions with Shawn Lin from Rockchip it came to my
> > attention there's an unknown errata regarding 5.0 GT/s operational
> > speed of their PCIe core. According to Shawn there's grave danger
> > even if the odds are low. To contain any damage, let's cover the
> > remaining corner-cases where the default would lead to 5.0 GT/s
> > operation as well as add a comment to Root Complex driver core,
> > documenting this danger.
>=20
> I'm not sure just adding a warn would be a good choice. Could we tota=
lly
> force to use gen1 and add a warn if trying to use Gen2.

I think that forcing 2.5 GT/s with an appropriate warning message
is a good idea.  That would be like some quirk that gets applied
automatically, to prevent data corruption, while warning people
who attempt to "overclock" the PCIe interface.

> Meanwhile amend the commit message to add a reference
> of RK3399 official datesheet[1] which says PCIe on RK3399 should only
> support 2.5GT/s?
>=20
> [1]https://opensource.rock-chips.com/images/d/d7/Rockchip=5FRK3399=5F=
Datasheet=5FV2.1-20200323.pdf

Also, rewording the patch summary as follows below may be good,
because that would provide more details:

  PCI: rockchip: Warn about Gen2 5.0 GT/s on RK3399 being unsafe

Or, if we'll go with the automatic downgrading, like this:

  PCI: rockchip: Limit RK3399 to Gen1 2.5 GT/s to prevent breakage


