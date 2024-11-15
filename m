Return-Path: <linux-pci+bounces-16946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D209CFAD0
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 00:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C63B31824
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 23:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83922191F99;
	Fri, 15 Nov 2024 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfNIsmwB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47223190471;
	Fri, 15 Nov 2024 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711639; cv=none; b=OoKRSOWikPzNQwgFPM5bUN0XJj1zI3MvEYD+jWc0MYHX4nT0vIgQ9THTrouEM8OA9jud6mykTIYeayjhoFBGeFdImQESS5TzBLuqOD49EGztWU93RatYDzfTyLmwKPU/tiSG9ah6G0uPqGp9UE2OF8rHCTfwxN4N7wkZyx/O+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711639; c=relaxed/simple;
	bh=QjYUCesSzmPUEfzbC9zPe2WGXqZbFeekhkm5jj0rv0Q=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=s0F/6Mjbg3gwEyBBsPUNHDttQYPmFVFqa/40JwnoiRmo3mBc/NB97/dp9OljD4DymY0yuqUDCxAovfACjL3lRn8RrS5/a0fTZsEf7b32pFydejkZg+jhPo0fNsLGl0BMD3X9ff0z1WbME1dr82yFfEv5w4+gFyMB7TeOodm608o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfNIsmwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9D1C4CECF;
	Fri, 15 Nov 2024 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731711637;
	bh=QjYUCesSzmPUEfzbC9zPe2WGXqZbFeekhkm5jj0rv0Q=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=LfNIsmwBaETXBKpVfELWkaIeOXpsYlX4NcQGhoVkzjv9fPfycLfJ4QTq+dZnZyGI4
	 XfEdOZEf6pOERnUloDpfZFewiiojUBVeaYjk4JdD9hcSHcp5NfJEiO8efkka4cshSP
	 dAQ0EDDNG3DYfF2XqRfrmhKCJkFTk/q0otAZDR7phnkZHU/yIeZXI3/jwR4/uq7uxG
	 Xp03oVKuJYLxUYvFyUbcjDjRxvU0nMCm4KYUbxKeC8gxT/npCd3SFsDpAFq1Uo9qGJ
	 c4vg4T8KHpqCm2b/fzR+iYTZOGsVlY6Ec0pQQAwav8TFqFdceK3Q/fVE0bKC5RAMWi
	 7WptndJJWugjQ==
Message-ID: <8366cb0ba95b8b7d8608657e977614aa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZzcxIYKcZ-z6ubrZ@apocalypse>
References: <cover.1730123575.git.andrea.porta@suse.com> <914978925d34cfb5bee10fe92603f98763af48b0.1730123575.git.andrea.porta@suse.com> <cxwzmlzafgdu2uarcx7mdv4p32zig7efatcg4dzmctho6mvykl@dgwvf3ltcjmo> <ZyNK0RxJKdNCV11N@apocalypse> <ZzcxIYKcZ-z6ubrZ@apocalypse>
Subject: Re: [PATCH v3 01/12] dt-bindings: clock: Add RaspberryPi RP1 clock bindings
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vge
 r.kernel.org, linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
To: Andrea della Porta <andrea.porta@suse.com>
Date: Fri, 15 Nov 2024 15:00:35 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Andrea della Porta (2024-11-15 03:31:45)
> On 10:16 Thu 31 Oct     , Andrea della Porta wrote:
> > On 08:23 Tue 29 Oct     , Krzysztof Kozlowski wrote:
> > > > +  '#clock-cells':
> > > > +    description:
> > > > +      The index in the assigned-clocks is mapped to the output clo=
ck as per
> > > > +      definitions in include/dt-bindings/clock/raspberrypi,rp1-clo=
cks.h.
> > >=20
> > > You still describe how current driver matches assigned-clocks to your
> > > output clocks. That's not the property of clock-cells and that's not =
how
> > > assigned-clocks work.
> >=20
> > This description is taken by another upstream binding, please see
> > Documentation/devicetree/bindings/clock/renesas,5p35023.yaml
> >=20
> > Its purpose is to let the user know how clock-cell number specified
> > in assigned-clocks is mapped to the clock provided by this generator.
> > Since some of these clocks are shared among peripherals, their frequency
> > cannot be set by consumers, so it's the provider itself (i.e. the clock
> > device described with this binding) that should take care of them.
> > The renesas example has assigned-clocks specified though, please see be=
low.
> >=20
> > >=20
> > > There are no assigned clocks in your DTS, so this is really irrelevant
> > > (or not correct, choose).
> >=20
> > In the first revision of this patchset (please see [1] and following me=
ssages)
> > I had the assigned-clocks setup in the example while trying to explain =
their
> > purpose, but Conor said those didn't seem to be relevant, hence I dropp=
ed them.
> > Maybe I had to be more incisive on that.
> > So, I'd be inclined to retain the description as it is and reintroduce =
some
> > assigned-clocks in the example as in the renesas one, would it be ok fo=
r you?
>=20
> Since I'm on the verge of producing a new patchset revision, may I kindly=
 ask
> some comments on this? Is it ok for you?
>=20

Everyone knows how #clock-cells works. It shouldn't need a description
about how it works. It should just point at the header file with the
numbers if anything.

