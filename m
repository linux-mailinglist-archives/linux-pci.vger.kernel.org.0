Return-Path: <linux-pci+bounces-44214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32154CFF550
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 19:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FEB13000DF4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 18:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5AD350A11;
	Wed,  7 Jan 2026 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2up+POJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E3318B93
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767809651; cv=none; b=pHhtp5RsTdGp/UzftcIk+Rquxw7QQWyWQdJ5qr5AgbMXnORxgEYj2CRhnE3Hivd5HtfVcrAQWYSiJX2husgmvJcOJ/qfXYAtU+SlTBikMdhU78C7EpzAcEa3t7q4wEhrZ3qVGlJXu9jbaqn2GKxODUJ3rCueHpHrny+JQKTBO+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767809651; c=relaxed/simple;
	bh=Or6ZJEKCM1DQ+oX49ElTafjLQdHGJmX8pOss1V/kdWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4xHnNMJpSs0P0jb0/A/9VX71oDb3MjU9fYCjvR7EDR/kHz6zE/5Xd3wJIVVPEcsnjf8/3KiV5xkT/hvFdLHO5fU2T1Qa9J49kEeondfG7Ss74uiNGEyhanzyi4azaw8/+X4YZVOeW1oLBb4gDwWD3FJpJSv0EWBxcs6tQw8qN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2up+POJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176DDC2BCB1
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 18:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767809651;
	bh=Or6ZJEKCM1DQ+oX49ElTafjLQdHGJmX8pOss1V/kdWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e2up+POJUZRa/+5y+IZS/I7bn1n1OwPdh7AWqxQ4J1VKWc2jdw+nhQTkTslNwNb3C
	 ZnHEkJdF9HqaI+T4FcukWv/p9SsUi/31pnZutKFkIB/clz3Yzq89UIz4oTslbz5JBa
	 /nCa9uwpp2PypLPM3fEoUEJSiThXavywiR+5ZxsFu7sSY/nmHOLruRb60ZXO4uEAp1
	 OCj9tTdBfFqOANzYwBL/N1q3UX73XUiWpaf/SlRzBwarhUXOX8bwrzFxRtM6UQZEQf
	 INiVmr0AD1QwAx4dDqUccEdMGaRuIQlbkeaSRdmT1leB+IMxsAo6PMPZ69sojgkNqS
	 gVHXsW7XOECRw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3ec46e3c65bso1786415fac.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Jan 2026 10:14:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwohauFGlEG0HOn4vTZrVBPKbm/5hjkXj71+9OINvHrzuJOVvAhuDo3zhO/IbIpOEjIYbtIlZf7i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRgfEzhwlr8vQPLfrgvMc6ylaqdJZulXjHL5Las3EfR5elinZr
	5Pm0YSKYZ4lFqMLWMy90TBiOAk0AEVQx/7YvmlfSC5bxL2Hbl5dmGisLxyXWx8Ns+3XaGDX4Nlf
	tekuY+6Mnw0YHyxCVzSBgX7ynVe6Q634=
X-Google-Smtp-Source: AGHT+IFQFfboXe1ofeqeN7BTprvaQHSEdKPyzQ1xSOb+o/SRJ6Ob9srFcSYtEUYh5cJktnzuFPECDtSbWavR1FuObEI=
X-Received: by 2002:a05:6820:1686:b0:659:9a49:8fc8 with SMTP id
 006d021491bc7-65f55085439mr1281374eaf.65.1767809649966; Wed, 07 Jan 2026
 10:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205142831.4063891-1-haakon.bugge@oracle.com>
 <D49C0D9C-96F9-4D2A-974C-7B6E0CBFB235@oracle.com> <1C290028-E094-48E3-B2CC-29734CEBC97C@oracle.com>
In-Reply-To: <1C290028-E094-48E3-B2CC-29734CEBC97C@oracle.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 19:13:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hr12dZig=A1sDyDhFN32Yn05Vxd=+q6TuVgzVwurrjsg@mail.gmail.com>
X-Gm-Features: AQt7F2pgIqh6lHiQQ_62cf_60U9QZ-M0USWaCH3gr_Ftj9YTyulO66mTFpEBfA8
Message-ID: <CAJZ5v0hr12dZig=A1sDyDhFN32Yn05Vxd=+q6TuVgzVwurrjsg@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Do not fiddle with ExtTag and RO in program_hpx_type2
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>, 
	Casey Leedom <leedom@chelsio.com>, Ashok Raj <ashok.raj@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, dingtianhong <dingtianhong@huawei.com>, 
	Alexander Duyck <alexander.h.duyck@intel.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:59=E2=80=AFPM Haakon Bugge <haakon.bugge@oracle.co=
m> wrote:
>
> >
> >
> >> On 5 Dec 2025, at 13:28, H=C3=A5kon Bugge <Haakon.Bugge@oracle.com> wr=
ote:
> >>
> >> After commit 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if
> >> supported"), the kernel controls enablement of extended tags
> >> (ExtTag). Similar, after commit a99b646afa8a ("PCI: Disable PCIe
> >> Relaxed Ordering if unsupported"), the kernel controls the relaxed
> >> ordering bit (RO), in the sense that the kernel keeps the bit set (if
> >> already set) unless the RC does not support it.
> >>
> >> On some platforms, when program_hpx_type2() is called and the _HPX
> >> object's Type2 records are, let's say, dubious, we may end up
> >> resetting ExtTag and RO, although they were explicit set or kept set
> >> by the OSPM [1].
> >>
> >> The Advanced Configuration and Power Interface (ACPI) Specification
> >> version 6.6 has a provision that gives the OSPM the ability to
> >> control these bits any way. In a note in section 6.2.9, it is stated:
> >>
> >> "OSPM may override the settings provided by the _HPX object's Type2
> >> record (PCI Express Settings) or Type3 record (PCI Express Descriptor
> >> Settings) when OSPM has assumed native control of the corresponding
> >> feature."
> >>
> >> So, in order to preserve the increased performance of ExtTag and RO on
> >> platforms that support any of these, we make sure program_hpx_type2()
> >> doesn't reset them.
> >>
> >> [1] Operating System-directed configuration and Power Management
> >>
> >> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> >> Fixes: a99b646afa8a ("PCI: Disable PCIe Relaxed Ordering if unsupporte=
d")
> >> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> >
> > A gentle ping on this one.
>
> And a re-ping.

And I'm still hoping to receive some feedback from the PCI side on this.

Thanks!

