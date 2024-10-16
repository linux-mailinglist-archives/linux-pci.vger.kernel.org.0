Return-Path: <linux-pci+bounces-14672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4329A1059
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324D21F21508
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 17:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1520FAAB;
	Wed, 16 Oct 2024 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsvDD8c7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5A187342;
	Wed, 16 Oct 2024 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098554; cv=none; b=PCYQZFsLpFQfydeiBHaqgvvESd0uMky2IHtbItQSXdNk9B2O8Cwugmyd67s8X7cK/zIWDGFNqCYmZUDXFV6x2OFQYwDMW5NFhXbXqD4L5mIohfMPwHzF5f2pnkRgsVqTDnI+1dXS08Z2o138RdBE37JSdWY+GO2wBvh4E06ViRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098554; c=relaxed/simple;
	bh=zBGxUWx1GfjqfZFR0036W4VfTQPzNpxmmZRzM+4GmLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLTUfP0w5sRRffj8t3Q/ZPiYA5uSQ9qxStrb6ekeSFz8Th04CsqfRtj/jCcGJTbGcqzvwkmaqGkp/bDFr3lKaNwlEEZJp3C91ZToREz0qfRRtXRV6wiMVGH6qAIxG2KqkpTd296kwBMLdeMZV19jaWpCHlZZW+UNHh9kM08ebeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsvDD8c7; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-716a601d931so1026a34.2;
        Wed, 16 Oct 2024 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729098552; x=1729703352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt1PQYKIF6f8Dk/eCC4rW66g/CyyRRQlc9MaNS21pYY=;
        b=TsvDD8c7VOWJP2qCwWEOC68dg6aao/JKXgMW9edGXgf0H1VIFMEzk1cP/MTtzFtwAT
         /9+fi9FZeKsGGZX36TfaAi3djJMQ1hHTOz0ADrZ1JrM8n5SYp6eQQh3puNirIyRu8BEQ
         GJRnXzx875dks3hAxcuBEUCajRwFiBdOguVz/I4j9+cSNbxIYth9HdH8KtRJOwz+zGED
         fY9tJUBNbJAUXXO4Xk963xLaxeS/75l7DAsalrFLQMy/ZmoRhhe/fDZ/nSh/h1J6IF9t
         CkhpoaDJQLRm8tvxXfz5BbHRGmfL9GTWUoGtP/Un041mMmQgAmtWDrZryI8InaGd4yn3
         1QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729098552; x=1729703352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tt1PQYKIF6f8Dk/eCC4rW66g/CyyRRQlc9MaNS21pYY=;
        b=MLhRhixbeaGA5puW116xKHjNoIdgBqMBHh8bF3LIkF5WKl50U1bMrXCClj540wlII+
         iBwB4vcoyea60SAxjgclakhZ+miMEzlPBI6U4yh4MYRXF7CiwKFfvyd8w5OTjfQr5HZ3
         LTFbkKSMxePNltWBwVaTz9se5dPX7SCRb3x1SQ3J1XA1HSgAnuXPNNHiIarjOmosYOJK
         FkAfGYwGqsLvbyfIYmpBQCCRY6mj5/PKM7WGEhCVV/lsxyMQuPqomy6KC9TDBO6DVdfH
         1zElzhqDB8M7FYlQg65JWQT612KprD4gux7WJxYHzfmIBXsd5Q6QTvKVgNVPprdRGEOi
         MDaw==
X-Forwarded-Encrypted: i=1; AJvYcCU3/NebC1x+RYsMQxuK4kSBfxxZG73wVzcNXUqr4kkZ8tv5a5mQpzlEtcyLuOu3xy6pfd9TASuA+8hzO4oG@vger.kernel.org, AJvYcCX6yB6M9N53hA/r/PmBkTG9Si27e29hseGe1poLcRGrhKAu7ZNoccZ7ZhbXuHuVVzwP3TgicdW1/Ref@vger.kernel.org, AJvYcCXdddVKMON66Z6TO9p+uATJ7QSRRMyBQjb9Harc0rzw0xHVfh9wwO2N20SoOZf63bjURvIBWExab8ri@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46abNZRUVP6Lxp9ginsXuObCO8AEomR2mtGztnGePzEXZiWxR
	/L4hHe3uNkSslc94bfkRm9ovGQREj8IUP/Vic6Bf/cePQElTIaFccK1O/7zoVRGkPoRtQW5yYPq
	OzLyolqiVNKELEhyDQNcMMEXVTCs=
X-Google-Smtp-Source: AGHT+IHF1PN8wxC7FB4mMJg4mPDfHIzjGcgYxIcan1x5MehzU5eimTl+bT6Yct73rijJlfuhs6j+M7807tozVGWovPs=
X-Received: by 2002:a05:6358:7e10:b0:1c3:7b8e:c35b with SMTP id
 e5c5f4694b2df-1c37b8ec4d4mr372993355d.19.1729098551989; Wed, 16 Oct 2024
 10:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69c2f4ac-896d-4cfc-8068-45bd58aef6dd@broadcom.com> <20241014172517.GA612835@bhelgaas>
In-Reply-To: <20241014172517.GA612835@bhelgaas>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Wed, 16 Oct 2024 13:09:00 -0400
Message-ID: <CANCKTBt17LCyvQQnOqMdu1KUY61bRKCYQC8=+HDYaddj-MAd2Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] PCI: brcmstb: Expand inbound size calculation helper
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Stanimir Varbanov <svarbanov@suse.de>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrea della Porta <andrea.porta@suse.com>, 
	Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 1:25=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Oct 14, 2024 at 10:10:11AM -0700, Florian Fainelli wrote:
> > On 10/14/24 09:57, Bjorn Helgaas wrote:
> > > On Mon, Oct 14, 2024 at 04:07:03PM +0300, Stanimir Varbanov wrote:
> > > > BCM2712 memory map can supports up to 64GB of system
> > > > memory, thus expand the inbound size calculation in
> > > > helper function up to 64GB.
> > >
> > > The fact that the calculation is done in a helper isn't important
> > > here.  Can you make the subject line say something about supporting
> > > DMA for up to 64GB of system memory?
> > >
> > > This is being done specifically for BCM2712, but I assume it's safe
> > > for *all* brcmstb devices, right?
> >
> > It is safe in the sense that all brcmstb devices with this PCIe control=
ler
> > will adopt the same encoding of the size, all of the currently supporte=
d
> > brcmstb devices have a variety of limitations when it comes to the amou=
nt of
> > addressable DRAM however. Typically we have a hard limit at 4GB of DRAM=
 per
> > memory controller, some devices can do 2GB x3, 4GB x2, or 4GB x1.
> >
> > Does that answer your question?
>
> I'd like something in the commit log to the effect that while we're
> doing this to support more system memory on BCM2712, this change is
> safe for other SoCs that don't support as much system memory.

Hello,

This setting configures the size of an RC's inbound window to system
memory.  Any inbound access outside of all of the
inbound windows will be discarded.

Some existing SoCs cannot support the 64GB size.  Configuring such an
SoC to 64GB
will effectively disable the entire window.

Regards,
Jim Quinlan
Broadcom STB/CM

