Return-Path: <linux-pci+bounces-33735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C407DB2099E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 15:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE811188EA9D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B692D77FE;
	Mon, 11 Aug 2025 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ8QqBX6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279882D131A;
	Mon, 11 Aug 2025 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917665; cv=none; b=TytllTcl7mye1rYSSxVwplXCNsGay+nZ6mYvZIiDdiIX9Iz/quX7emi7cY78WJ6nxhjbjYKqNMI0dAuG7xPReYk49xZNsMp2dwjGYUKZBhRLz2bqeQHKWxYSTWnyY2/XDaMafl+RILd/CfZnYXznNBD1OpjV5qWgnW82F3DCmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917665; c=relaxed/simple;
	bh=5Z2uz0t2/VXIOmspWJH+xwmPwCRPe8q6/e2tyOBrGCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPJLey3g4PiBzNgMIDBGCTJ37779ZkuSv8ylOvIYNCGq2W325txejL09n+isZQx9o3GFiHBS6rtCaiIlqqOBZ1CzxCrAOiebx/hmmBegE0jdG9Dcum6G5ZRghfRlIL9UQ215S0lOfXsf27bLDxl2t9an5XF5doS5sRLnaqqXJlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ8QqBX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0031BC4AF09;
	Mon, 11 Aug 2025 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754917665;
	bh=5Z2uz0t2/VXIOmspWJH+xwmPwCRPe8q6/e2tyOBrGCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nQ8QqBX6RBlLJlVyTOHKLCsUa6C5Aj590bRBaKddHaH9OcEIK0ZmP/xdqzbiD1/3S
	 FNRig7S7sL55DJwqBAuyKURG4076x7G0CMPiURJZVuJyS2vF0FP3er9tfhSp0w1LLc
	 q/6q9FGzA0EUx6KXG0NQoMPfPrfQdv8RBUdhdaJ7HX5/VMSBTgQdv1+NWQ/gHO8W8h
	 IaaYPusabmwxNbzrKx6I64KL/KRDfhWrugwTCGc+58mA+Y9NAr/1dHbzBvBlEQakVC
	 EN6JT/+EyMbKOkW+fb5O7FTStqH3fDMfCajZHlqZlwkywLqgly2gZzZb+DyWYoyDCM
	 waHvgI7jRDrmw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6156463fae9so8417044a12.0;
        Mon, 11 Aug 2025 06:07:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRgdHtK7BMp/C/x1AP4TKBi4OtB3cvi9AFgrZ9PuqQP2rJKyTnQA0cBFdon/11DCz17vEfYDNURx3k@vger.kernel.org, AJvYcCWv+5gVT/N4BtODWUWmai8ygmXoTewUZlf+mP4tT4ZiestFgNgy5FY206xnnICD0WzESPzY2jGYcNh7@vger.kernel.org, AJvYcCXnB5pRW1+FKCdT4kzEH0yS9SlNfEPAIgLHv6fZp9NEvtJPJIAbCiI/EkJ7plGEkUjY4hE7R8J/12XzIwWA@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ2MvFtggmSMZ0zdTfOMOxwWipOif91BY1v4VktmiKVYpBWLLF
	1Es+f/xdFRudJ4uHvracAwq6e6Emmn4jrk+8GzpUlIxYzXIVD+uLciD4OvJ92L2H3hF9hlYh+bf
	0u4V2zLRUCYCbMR8mGUiZOw4HNVVXiA==
X-Google-Smtp-Source: AGHT+IH0Jtu3zpqJ6aT6QeliyExaVNlY8+dlNVIs2rZVOSEssgBRkewOJVjUu8sHKIo9QSGuuYURdxqjt1keqshX6mM=
X-Received: by 2002:a17:907:9709:b0:af9:383e:45ab with SMTP id
 a640c23a62f3a-af9c6e254eamr1367138966b.2.1754917663483; Mon, 11 Aug 2025
 06:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801200728.3252036-2-robh@kernel.org> <175490917553.10504.5537940155167451079.b4-ty@kernel.org>
In-Reply-To: <175490917553.10504.5537940155167451079.b4-ty@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 11 Aug 2025 08:07:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL_jiOZcydPF6LXVKu6_z6Bp32g+wXWkNgrLocrg-xgrg@mail.gmail.com>
X-Gm-Features: Ac12FXxZ4YdwCRaVqztVa4prfTmPnxtwEewmpaR37yVm5AHopCS2vYWaGni7MeU
Message-ID: <CAL_JsqL_jiOZcydPF6LXVKu6_z6Bp32g+wXWkNgrLocrg-xgrg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: Add missing "#address-cells" to
 interrupt controllers
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:46=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
>
> On Fri, 01 Aug 2025 15:07:27 -0500, Rob Herring (Arm) wrote:
> > An interrupt-controller node which is the parent provider for
> > "interrupt-map" needs an "#address-cells" property. This fixes
> > "interrupt_map" warnings in new dtc.
> >
> >
>
> Applied, thanks!
>
> [1/1] dt-bindings: PCI: Add missing "#address-cells" to interrupt control=
lers
>       commit: ddb81c5c911227f0c2ef4cc94a106ebfb3cb2d56

Please read the commit message.

I've already applied this to my tree.

Rob

