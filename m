Return-Path: <linux-pci+bounces-2006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B896C82A00C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 19:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5299D284607
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 18:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A884D594;
	Wed, 10 Jan 2024 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geKefePS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833984D12E;
	Wed, 10 Jan 2024 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7cc14b91230so3066906241.0;
        Wed, 10 Jan 2024 10:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704909933; x=1705514733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGS8rxlW8J08cvxQUR+pLZrZLbq/2MHwQf3nkmNV2JU=;
        b=geKefePSrSR0895IcValV1sCDNDQoLsvzgIaRzutdAd7qU8uNaQkuXwrx9BqwyFMJR
         R6W4uvzW6aaLDEpMOEjImrUyyTsYMsnIq0vbhMOtoqZWf2+tWcV9n+EU0X5OPjL9fNgZ
         ymDrRm8z7kzSIWmxf77wAengwpB1T9Pv1y9yPu8uZGSYhq7EkczPqP49LCS3L63Yy4/F
         qKl4KvxbqkKKhDA4hNZaaQ1mVPZ64LzoJKEbg7wgXCcPAoh16OuCo5Lfo84w5a7tvVGN
         VSn+GexcJYWrw1jFg89hcSFgHuRk1d5uckuloLPeLeN5ad08pfEfzDOpurT80ZoOfC+f
         OVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909933; x=1705514733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGS8rxlW8J08cvxQUR+pLZrZLbq/2MHwQf3nkmNV2JU=;
        b=cD8KpUhEXI9AZOYSkEXG+bY5TESHNW9pQyopWGOECGHl099xyF83rDzL49T6HlKxqO
         yygbQSFQ2Oy8jphRGZFTnGxzkxoceFnXRNgu7wQyF9Pnn9YRs+kYGJabb1+umj49S9YB
         6q8RXVmxtBH0DoAt27ZE2KAiWHjyj6YH3i/5WV24Mjb/n89LctRtI5jHN4iCskU6Pgql
         y1k7QvhPfbMSFnc78cUjy041bmC8dZcEtRUUDrELX16lYLhPAB053FgE1VDy+3NoH19H
         wUXD2pcnimA1kfplw9brzH1xglw8HFvahafQR1yiWAgTqmvJeK+l+1yfX36Q+ps/sa3m
         Rx5Q==
X-Gm-Message-State: AOJu0Yy6ETH+x7SuDgHFVMipwFssrZErcsngw7WrH0e/PeXEaf2T1bDt
	pHwZ2mfPpcHsn9GJ+J/ybz6td31WDp5xe1RcNmODjXnI
X-Google-Smtp-Source: AGHT+IE23LsAiAIKhQL4KDsQhexTV/OLZ248oekpaOPGxLxTENBqLtWU+Ubtj9IHXcdEFFm1TUxEZcQgSmkFU0g68wg=
X-Received: by 2002:a05:6122:328d:b0:4b7:185e:b866 with SMTP id
 cj13-20020a056122328d00b004b7185eb866mr668271vkb.9.1704909933279; Wed, 10 Jan
 2024 10:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ae49227b-5026-43a4-8e19-aeeb63865a6a@broadcom.com> <20231213195947.GA1056194@bhelgaas>
In-Reply-To: <20231213195947.GA1056194@bhelgaas>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Wed, 10 Jan 2024 13:05:21 -0500
Message-ID: <CANCKTBvaFBXAVTBtr4tpz5mYcyP1w84nAEGHbOnGJugogHx4fQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] PCI: brcmstb: Configure appropriate HW CLKREQ# mode
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Cyril Brulebois <kibi@debian.org>, 
	Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Phil Elwell <phil@raspberrypi.com>, 
	bcm-kernel-feedback-list@broadcom.com, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 2:59=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Dec 12, 2023 at 03:51:12PM -0800, Florian Fainelli wrote:
> > On 11/26/23 12:19, Cyril Brulebois wrote:
> > > Hi Jim,
> > >
> > > Jim Quinlan <james.quinlan@broadcom.com> (2023-11-13):
> > > > V8 -- Un-advertise L1SS capability when in "no-l1ss" mode (Bjorn)
> > > >     -- Squashed last two commits of v7 (Bjorn)
> > > >     -- Fix DT binding description text wrapping (Bjorn)
> > > >     -- Fix incorrect Spec reference (Bjorn)
> > > >           s/PCIe Spec/PCIe Express Mini CEM 2.1 specification/
> > > >     -- Text substitutions (Bjorn)
> > > >           s/WRT/With respect to/
> > > >           s/Tclron/T_CLRon/
> > > >
> > > > v7 -- Manivannan Sadhasivam suggested (a) making the property look =
like a
> > > >        network phy-mode and (b) keeping the code simple (not counti=
ng clkreq
> > > >        signal appearances, un-advertising capabilites, etc).  This =
is
> > > >        what I have done.  The property is now "brcm,clkreq-mode" an=
d
> > > >        the values may be one of "safe", "default", and "no-l1ss".  =
The
> > > >        default setting is to employ the most capable power savings =
mode.
> > >
> > > Still:
> > >
> > > Tested-by: Cyril Brulebois <cyril@debamax.com>
> >
> > Thanks Cyril! Bjorn, Lorenzo, any chance this can be applied soon? Than=
ks!
>
> Seems OK to me if Lorenzo or Krzysztof W. are OK with it.
>
Bjorn,

What is the status of this submission?  Stock Linux on RPi4 CM4
systems with a PCIe device  panic on boot until this commit is
applied.

Regards,
Jim Quinilan
Broadcom STB/CM

