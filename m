Return-Path: <linux-pci+bounces-43703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E5BCDD198
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 22:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB52530191A9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 21:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1508D2E5427;
	Wed, 24 Dec 2025 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAR9x5QP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C628726A
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766613483; cv=none; b=kCH6MoohxuI+SZyzCPFXsAMPZ7LOZh+Vzr5hbkQ/c+f5TBeSe6XZEjp9ayEvf8Qh+QrPYzaXM3al0McvOEs1s5uCt7gL4qh00UZcEDf9hXo8gpMb4sYNgK5Ia1fmjE0pEhkWw7KeCq2yCp07Hy22Ogqv9kDXNUZEQlQga69ECWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766613483; c=relaxed/simple;
	bh=Od9O5Vjuadc3i8HfvSRNQiYd12oWVzXIE1EnhmoQklc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4+5V9qHc3rUHXgEpAO951cgvUlV1HYVQaEHrSAzDAtunhudT38pWwQf54fd8cXTpVspgCd9/JhOYZ1TphqG8dXaibjrQ7uLHRIlH1fHodWkvRDR6xvJsTYFx6JLLp8koTiZX389cff0Lssd+K46n+nXoPW+RP4Ex5L/LPt3aJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAR9x5QP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38107fadda2so46441511fa.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 13:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766613479; x=1767218279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpPhIVPLcl7AlcgaNncZR2f2MLRrtlVGy3ymmkGrT98=;
        b=hAR9x5QPkn3H1I5514al53eeDUjUI14ZQfM4JkMA2XD4qQlW1MR5sIhgGd+dX0Dtss
         AcTMX5JK4gSeT3t809BEpIo7xeXRznp5tYxj5ZXHZbxusnTsSJOEa+Ivn0N8CpubVyCS
         D9dXJ2SYC4la0zCGocP6iLRqMgPqEpzmz+KdhnLBtIrIEgExuWU3rfIc3zN4hdlH6Gga
         fqpF0qsNpJ87hWeUeyXBlvtGCnxUHtsxh/Pi1X+PZvwZfIpWcZcHy5YmKrzYsgtoLdjW
         4mplJ/Jjvg1A4VmhWJxMMByH0s16F/vJTF5rDJv3ZPTsGz7inm9FTjDx9T5i2eIfZJKy
         xu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766613479; x=1767218279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BpPhIVPLcl7AlcgaNncZR2f2MLRrtlVGy3ymmkGrT98=;
        b=jjMuopOGv7JJgr3Kaqe9Q4O8H95pD/kSzahksFRd6cKoHPQTBvRZXTc4faU8gVq0sR
         cTkNzcWWfRok4bNpaTqEbpShplCOJzR3QTIBs+qh9qmO20gWghPIeD1TBkkOB1jpgdl5
         B3PfLG7ApUFC4jXkvMNdWiMli2f5gtgjz19GZG4ElHtq1YSVrZTmzwr1Kta6wWefGNqf
         1BTd8JHKvArMPNHNQG9OgMpRPGSP3Zzcb8+cYjpSXoA3iwj2bKu/yKv15i4fduFwfAtO
         5nUGNTe0o20taHoohUcmQ5mAwhTorGA5PIcYhY030uyrxr4XSrPlBkIjmxHqHbWHZum0
         UAiw==
X-Forwarded-Encrypted: i=1; AJvYcCWEUJETPEQ3J7W5Zgje36sobZn3B3vjnhx1+hTlNkyL8eZBHPr1TOJvw4XCaeu7SOrLua2LPR48lyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTBP7R1U3h+ErcUS3ozA11PCc9ZEvcS7RfkK8klc0bNRp4BC0
	6+Mr3yeeSL8qE/ZKuPyx/dXt6L43wruFlk1F7w079ddO3qGXhd72KHVMPtf/V54p17WEuyKs2wq
	YWtp/K514u4tUrEbRkyuDt0CQDb8i1MQ=
X-Gm-Gg: AY/fxX6GlnqR6tY4qYKxUjQAfN3MGz3R61tl1Bfi3VH4VpDfdtlGOlCxVa8Jw1B+iw9
	x257LUPXO1QUBD7Hc0ZTIMqwlZTwXFZ16Z/1aeoLy9w0c/3P8yeotNlwhSM62vXf0IqkFYANo9f
	xFNlY0IU0A0lqN8q0iopIVGUFVS3Smb4GE3r+iiCrpoRY2hPxmMyqEAfh6Yu94Kf8jmNIEfH/iy
	FLMHIiY7uhLkZiLTFh0YnliDN/amo40NcdbC52Gm0FHDRoGTKtVucvbGu1nzhUIMTiAVcgOR/B0
	reWLUpQ=
X-Google-Smtp-Source: AGHT+IEkZq/SghbcemDD4gpQJkxuW1kec85kuxDcNZRjtvTDrMQzCzdvYYwzT+2kprBLyKYZnyXIlIOYdRbjndvcfbo=
X-Received: by 2002:a05:651c:549:b0:37b:8f05:13bb with SMTP id
 38308e7fff4ca-38121635cbbmr65292381fa.27.1766613478895; Wed, 24 Dec 2025
 13:57:58 -0800 (PST)
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
 <CANAwSgQPQUBi6VVb+hZNraMt71vnRpki+YK_at=Luo4aPVtOPg@mail.gmail.com>
 <0afea20b-be22-2404-5a8e-c798ed45f2fd@manjaro.org> <CANAwSgS6UeR4PJnWDxxcQbdH8u_4uNiQxCTugQS35LcPvpiwMQ@mail.gmail.com>
 <648aa5c0-9e58-2404-4250-e83b8a748601@manjaro.org>
In-Reply-To: <648aa5c0-9e58-2404-4250-e83b8a748601@manjaro.org>
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Wed, 24 Dec 2025 18:57:46 -0300
X-Gm-Features: AQt7F2qLlj1sHGE5kS7xlOSGgQLXJ9ioNCl22i1s4n8IwdgKKh2cem-68BhAFek
Message-ID: <CAEsQvct-AyhdOU9xhP0HnN8be+ut=tDBgUt0n3D4TT9ZMXnTbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: rockchip: limit RK3399 to 2.5 GT/s to prevent damage
To: Dragan Simic <dsimic@manjaro.org>
Cc: Anand Moon <linux.amoon@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Jonker <jbx6244@gmail.com>, linux-rockchip@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 1:52=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On Wednesday, December 24, 2025 17:11 CET, Anand Moon <linux.amoon@gmail.=
com> wrote:
> > On Wed, 24 Dec 2025 at 18:25, Dragan Simic <dsimic@manjaro.org> wrote:
> > > On Wednesday, December 24, 2025 09:04 CET, Anand Moon <linux.amoon@gm=
ail.com> wrote:
> > > > On Wed, 24 Dec 2025 at 11:08, Geraldo Nascimento
> > > > <geraldogabriel@gmail.com> wrote:
> > > > > On Wed, Dec 24, 2025 at 2:18=E2=80=AFAM Anand Moon <linux.amoon@g=
mail.com> wrote:
> > > > > > On Tue, 18 Nov 2025 at 03:17, Geraldo Nascimento
> > > > > > <geraldogabriel@gmail.com> wrote:
> > > > > > > Shawn Lin from Rockchip has reiterated that there may be dang=
er in using
> > > > > > > their PCIe with 5.0 GT/s speeds. Warn the user if they make a=
 DT change
> > > > > > > from the default and drive at 2.5 GT/s only, even if the DT
> > > > > > > max-link-speed property is invalid or inexistent.
> > > > > > >
> > > > > > > This change is corroborated by RK3399 official datasheet [1],=
 which
> > > > > > > says maximum link speed for this platform is 2.5 GT/s.
> > > > > > >
> > > > > > > [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK=
3399_Datasheet_V2.1-20200323.pdf
> > > > > > >
> > > > > > To accurately determine the operating speed, we can leverage th=
e
> > > > > > PCIE_CLIENT_BASIC_STATUS0/1 fields.
> > > > > > This provides a dynamic mechanism to resolve the issue.
> > > > > >
> > > > > > [1] https://github.com/torvalds/linux/blob/master/drivers/pci/c=
ontroller/pcie-rockchip-ep.c#L533-L595
> > > > >
> > > > > not to put you down but I think your approach adds unnecessary co=
mplexity.
> > > > >
> > > > > All I care really is that the Kernel Project isn't blamed in the
> > > > > future if someone happens to lose their data.
> > > > >
> > > > Allow the hardware to negotiate the link speed based on the
> > > > available number of lanes.
> > > > I don=E2=80=99t anticipate any data loss, since PCIe will automatic=
ally
> > > > configure the device speed with link training..
> > >
> > > Please, note that this isn't about performing auto negotiation
> > > and following its results, but about "artificially" limiting the
> > > PCIe link speed to 2.5 GT/s on RK3399, because it's well known
> > > by Rockchip that 5 GT/s on RK3399's PCIe interface may cause
> > > issues and data corruption in certain corner cases.
> > >
> > It=E2=80=99s possible the link speed wasn=E2=80=99t properly tuned. On =
my older
> > development board,
> > which supports this configuration, I haven=E2=80=99t observed any data =
loss.
> >
> > sudo lspci -vvv | grep Speed
> >                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L1, Exit
> > Latency L1 <8us
> >                 LnkSta: Speed 5GT/s, Width x1
> >                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Spe=
edDis-
> >                 LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,
> > Exit Latency L0s unlimited, L1 <2us
> >                 LnkSta: Speed 5GT/s, Width x1
> >                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Spe=
edDis-
>
> Let me clarify, please...  This limitation to 2.5 GT/s came straight from
> Rockchip a few years ago, described back then as an undisclosed errata.
> Recently, we got some more details from Rockchip that confirmed 5 GT/s
> as having issues in certain corner cases that cannot be validated by
> performing some field tests or by observing the PCIe behavior under load.
> Those corner cases with 5 GT/s, as described by Rockchip, are quite hard
> to reach, but the possibility is still real.
>
> To sum it up, yes, multiple people have reported 5 GT/s as "working for m=
e"
> on their RK3399-based boards and devices, but that unfortunately means
> nothing in this case, due to the specific nature of the underlying issue.
>

Not only that but the bandwidth actually earned is very small due to the
inherent limited interrupt processing capability of a single core, meaning
the 5 GT/s bandwidth / transfer speed is never fully utilized.

It's better than to force a slightly lower actual transfer speed than to ri=
sk
the liability of someone losing their data, period.

Regards,
Geraldo Nascimento

