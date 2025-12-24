Return-Path: <linux-pci+bounces-43701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42611CDCCE6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 17:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AD7B300A9F6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 16:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81C414F9FB;
	Wed, 24 Dec 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwi/UPsz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A83241686
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766592719; cv=none; b=C4LoJDjIHyYuI/3wI5RU5X5VjUtKXw1Lc3CV7XiSEjv4VeSBYywfzeV8dltC2Vczl6Hn5o8yiqdLd4lNk9Nyr7B18/1504CHA6glq6dkjjW9LXH5f30j6KJe+DhdR5C+TTBrg8aRDM2FiDm0UzHgr+3f0Qoyu/Cmd7o0pYDC0CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766592719; c=relaxed/simple;
	bh=kr/DgxJ2m4x8xh7w93LcGUX/UhIt4kM9hmRzY7gFpBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5N09wfHOa5CTb4OWdfNewg5an4ebZ1/7u5X5GWE0SANrr8rFpsNv90OzA+uzg4XcSxvFly09tePVcnUvSA9hHDeA/zQkjD4GISeZdfiGQaUztHyvC+F1PcAE2BGdSLKTuKvvf8DD5GdnwvMqsYtXFyeCdhPt68/swgjthMNLC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwi/UPsz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b76b5afdf04so899534966b.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 08:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766592716; x=1767197516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFryFaNSwdzD/vSDQgCvIb9qGKYtzkN+fGok+kNOoDo=;
        b=Wwi/UPszH2RmxxD0keu+5+VGNr6AG9AJmWZf0hGJBP0eyjxb2IGwKy4GkRnfC25TVT
         Q0G7cHXvr0gCsJLPWQKgXC4HDr2G/QHdeokLfOBMwUmXhJCKtxJvcRKJ8IEkAkXm36Vz
         r7kWrM6aikusKIhKtmj/ra9wXUCaiQQGes1R2MCWUxkgo6ked6Pl1JS1/r8BiHwFvIB9
         YuibQKGINtI8Am6q0nLcTASCG7zF68GTTODvWUPdWb1jFeKdjIXZT+wkTiq6CCJ9atMq
         CL0yHk8erXjZbrQWn9WJ8Jy5w3o7A4xs7gnFHNURi03wDDei7+LMtlyiB/2dhGSkBJnO
         gLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766592716; x=1767197516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rFryFaNSwdzD/vSDQgCvIb9qGKYtzkN+fGok+kNOoDo=;
        b=FR+MzNZhmPShKtJ7+UEedzBFKLvlvOb/oNtzu4JQMUcTIZrXXP4CyaWh/Eoh9vSOH7
         5SkJkQxOaa3bFtXYGHfKyjQl41O43tMFda008D0jXoOCyI8hz+PRJkF2uq+i1JdsWk3w
         3jFzcUwaRsBgUfISmvZjU3DSqCZrrdPIUCK/HNHvVxt7F0z2GSQh+l7XQGqmqEh8zYx3
         1vkDhhPtn01Rk2AAoUUV1NiluDSbz2sLXp6pq9VLqcoo7qv1hxCaNDv6lcTZv0CkjnX4
         n/pcYfoIef+m+Vu9mhMcz2x4sWL+TM+ZZnZB4IHPLd4cF1rOeNYnx4iJzyxA4U12gJ3G
         5Wkg==
X-Forwarded-Encrypted: i=1; AJvYcCXKyzNBfAX6jeuo6Yy6yrZcPyfbHrKJGODmUxoTgwSxQeVWOelVmZgRnSNhXzND9foGkTgY+70B8I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAF2NQKqhFq2EYwH31uCKtV8BJDFwJne1ibQNdKDLo59MZAsC
	ZE9p36AntZuKS7Yb57a9jR/dYPrk3sfgbdtZ94tFKBHTKIe4YPFZsx2TJ8GRCpDLt0nDHiWZWt7
	17yb4P4G+SX/GtbeIsowIplAHFGrhS04=
X-Gm-Gg: AY/fxX5xJ9aNNSrdWbky0kyv4Uc2zL7XuCQ2164RYBYNw+LgHu7TGo6sn3e2d77DA7X
	gGaIfytMTWyOviSjnDUvGtQLDYGRjj7hnM+ExykUM3FQ2/FYps6GNR90Teija+I7cz4+JTTIK/l
	cGbADWRVxmlsnuarecfzwGeKdPo2hJbk8m3W6sQ3XA0XIzfRJLWLf7oUURbzrHEtLqdBMVdET5n
	r7XR91ekJF2kzTlqtf7zXVXlzbwmyoi/NdEHvKbd6QCS3GmEDZMrnxQswPQs9zvW7g=
X-Google-Smtp-Source: AGHT+IF8JwCFITnsLBTkXmiS0L4MmwBGPqpepuJqg06icSWw77Trn5dPC9ARbJb2q7e916O74g9D6jFvUiAyqH6N2Ek=
X-Received: by 2002:a17:906:2082:b0:b80:3fb7:84f with SMTP id
 a640c23a62f3a-b803fb70d84mr1260286766b.38.1766592716002; Wed, 24 Dec 2025
 08:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763415705.git.geraldogabriel@gmail.com>
 <eaa9c75ca02a53f8bcc293b8bc73d013e26ec253.1763415706.git.geraldogabriel@gmail.com>
 <CANAwSgQ726J_vnDKEKd94Kq62kx8ToZzUGysz4r3tNAXvfAbGA@mail.gmail.com>
 <CAEsQvctSY7-RQEQF2TmJU2qKPZOe9TC5g-7Jat0LQKRHYz_6dQ@mail.gmail.com>
 <CANAwSgQPQUBi6VVb+hZNraMt71vnRpki+YK_at=Luo4aPVtOPg@mail.gmail.com> <0afea20b-be22-2404-5a8e-c798ed45f2fd@manjaro.org>
In-Reply-To: <0afea20b-be22-2404-5a8e-c798ed45f2fd@manjaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 24 Dec 2025 21:41:38 +0530
X-Gm-Features: AQt7F2q-4QkIrb7HCrmK7bnip5LMtE41U74PCnTtsggrekXUlmrVmrAckqk4Lqg
Message-ID: <CANAwSgS6UeR4PJnWDxxcQbdH8u_4uNiQxCTugQS35LcPvpiwMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: rockchip: limit RK3399 to 2.5 GT/s to prevent damage
To: Dragan Simic <dsimic@manjaro.org>
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Jonker <jbx6244@gmail.com>, linux-rockchip@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragan,

On Wed, 24 Dec 2025 at 18:25, Dragan Simic <dsimic@manjaro.org> wrote:
>
> Hello Anand,
>
> On Wednesday, December 24, 2025 09:04 CET, Anand Moon <linux.amoon@gmail.=
com> wrote:
> > On Wed, 24 Dec 2025 at 11:08, Geraldo Nascimento
> > <geraldogabriel@gmail.com> wrote:
> > > On Wed, Dec 24, 2025 at 2:18=E2=80=AFAM Anand Moon <linux.amoon@gmail=
.com> wrote:
> > > > On Tue, 18 Nov 2025 at 03:17, Geraldo Nascimento
> > > > <geraldogabriel@gmail.com> wrote:
> > > > > Shawn Lin from Rockchip has reiterated that there may be danger i=
n using
> > > > > their PCIe with 5.0 GT/s speeds. Warn the user if they make a DT =
change
> > > > > from the default and drive at 2.5 GT/s only, even if the DT
> > > > > max-link-speed property is invalid or inexistent.
> > > > >
> > > > > This change is corroborated by RK3399 official datasheet [1], whi=
ch
> > > > > says maximum link speed for this platform is 2.5 GT/s.
> > > > >
> > > > > [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399=
_Datasheet_V2.1-20200323.pdf
> > > > >
> > > > To accurately determine the operating speed, we can leverage the
> > > > PCIE_CLIENT_BASIC_STATUS0/1 fields.
> > > > This provides a dynamic mechanism to resolve the issue.
> > > >
> > > > [1] https://github.com/torvalds/linux/blob/master/drivers/pci/contr=
oller/pcie-rockchip-ep.c#L533-L595
> > >
> > > not to put you down but I think your approach adds unnecessary comple=
xity.
> > >
> > > All I care really is that the Kernel Project isn't blamed in the
> > > future if someone happens to lose their data.
> > >
> > Allow the hardware to negotiate the link speed based on the
> > available number of lanes.
> > I don=E2=80=99t anticipate any data loss, since PCIe will automatically
> > configure the device speed with link training..
>
> Please, note that this isn't about performing auto negotiation
> and following its results, but about "artificially" limiting the
> PCIe link speed to 2.5 GT/s on RK3399, because it's well known
> by Rockchip that 5 GT/s on RK3399's PCIe interface may cause
> issues and data corruption in certain corner cases.
>
It=E2=80=99s possible the link speed wasn=E2=80=99t properly tuned. On my o=
lder
development board,
which supports this configuration, I haven=E2=80=99t observed any data loss=
.

sudo lspci -vvv | grep Speed
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L1, Exit
Latency L1 <8us
                LnkSta: Speed 5GT/s, Width x1
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDi=
s-
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s unlimited, L1 <2us
                LnkSta: Speed 5GT/s, Width x1
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDi=
s-

Thanks
-Anand

