Return-Path: <linux-pci+bounces-12169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B695E2F6
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 12:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893DE1F21AA9
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 10:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7D813CFAA;
	Sun, 25 Aug 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jicOTSTP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380671B52;
	Sun, 25 Aug 2024 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724581362; cv=none; b=pOFHV2dQlETLhc1okqIGg0DkH0QLjKiaR6k/8EsF8nMjxYrn7OsQv8YGDtY1ckwopYxqtQjE1FLSaWfxZ2wmb9Ao+KNyOQIdJulApGVPefaiPGQSwLJFaj/pVWas6B3zA9Srcp0WGUtNslyOHK4Ecglgw9KSD8B4eWdST8r3MFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724581362; c=relaxed/simple;
	bh=U9c+1tEo8iaPP7w9/QwHNCukDIEV25pkwDTrpUMIA28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ew0hBsGR+H/HqLURiPSCwBy4C1oz+rTqJdsCIGe2qoxzDupMdmdu25l9hwW77q78Q669gcYO/YdS47l8xqgRmqq1VfvrM1FVsjLlzE6/fMD1A5PWsmJCasb12mE/1b3uREGqu/aMeMI/zJKezopFSegJu0VJHDIz3xbF/iWLTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jicOTSTP; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27020fca39aso2904415fac.0;
        Sun, 25 Aug 2024 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724581360; x=1725186160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFBoAdzAN3yBqf+GK7J1XKjWpe6qNxfX0bKoVml6nKo=;
        b=jicOTSTPQ+L373WMjNh/mGd2rvBQnfOXHv+D31ML3kSujQ1iFm8CBoWGyl2Y7MgqzW
         fcNh37g08fHSE/HctxTOjG+NdqEcwpdgl8O4rF0NaLh8d1w6SDBziSKkPtseHwFAR5qb
         kRFPzpHFCAjS4BlZMlXniP0UCOHyhmVWx74KtQjeBdWsgNakSUnRdQTfyeFIW4UrqBEq
         9kk5NMeidh9QEt5aiTa3PMaAvNyX3E2k6pmb3aAuU3OO4V9H1SsPQkbvobxuSxfnlBNr
         KXmWyqgSlt30vBUNMCo2MB9U7x9zLoSiEsuGeE3BiIH4mArjXoiRANDNft2ofnwfKjLD
         BgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724581360; x=1725186160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFBoAdzAN3yBqf+GK7J1XKjWpe6qNxfX0bKoVml6nKo=;
        b=GEE0h4TO4rX5cvgoCK4ye/kJRHNOYgM8dmbdNAW4tUdexu9Y3deL9J+Ib6KSoL41kY
         VNHExc80llXuaUEFicgxSjc5Ct8wnUPxk9ebufKNqI7Q/PVeGZj7M3z9EK0omPLUKqoq
         Mx9fJ2LDqyg/ZAOdvV202qMpX2RQRKdpP/Q7OzIhPdGTB7fY5u66F0P6DwfYTii/FoqB
         /n9Z7ojyU0Qtb8m+m8CBQsiWgmlauouKb4gOt/4HMrHa46Zf3X7ESlGclp510RwYRCUm
         k442AJG914JNQRZNrcW5LqfIeMVXr8//oYDatRewtyBwAvTsvrCgUcE1+HXxSWs6eyUI
         4cNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAkpGmsEI1F2gnDBn0d5Ilo+boyYSkdfmr7JF7WBqfCYg7kDBIrX3SBVEkOf3UrBvDSb99CZlk3ejd@vger.kernel.org, AJvYcCWLkqXfsnzaKaVOPgisASQH0rgwaomCyfqSZKYf01JJ4UvS/8mNAtnzAEkTHSOmHl6800PWZVYhHxWYuRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLt7KMq1EawTk2YrFfdcThFxb1TzM2kPaqVWx8IHpqyyZ+svBN
	F5/CFngUBNS9XS329jtqyqFFqwELBs36lt7UYpQUTYjlLgAYq1XrLDkZjnlT6WtVy5I9nCl557c
	UV8bYb5KzJTBBrIMe3pwBLQQPz2c=
X-Google-Smtp-Source: AGHT+IHLf90Z9f5GN0f+ZDX8mz4fks5k0C5pfdRV90Hz9zjCMGLJ14J1Wd79hdIDhVMah0PrWr11KlGv6vwDTxvWyFo=
X-Received: by 2002:a05:6870:b01e:b0:270:184b:ccf1 with SMTP id
 586e51a60fabf-273e667e99emr8218458fac.34.1724581359748; Sun, 25 Aug 2024
 03:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625104039.48311-1-linux.amoon@gmail.com> <20240625104039.48311-2-linux.amoon@gmail.com>
 <20240815162004.GF2562@thinkpad> <CANAwSgR-k1x1cBbLZ-OErSiEDcnkqs9uiBy77BEd2tz-CGC3OQ@mail.gmail.com>
 <20240821070533.wztutnvlpghzso6v@thinkpad>
In-Reply-To: <20240821070533.wztutnvlpghzso6v@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 25 Aug 2024 15:52:25 +0530
Message-ID: <CANAwSgQiXW3BTxpgLbL__nMQSt90cRbHR849_TqiesfpagiKVQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan

On Wed, 21 Aug 2024 at 12:35, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Sat, Aug 17, 2024 at 06:52:47PM +0530, Anand Moon wrote:
> > Hi Manivannan,
> >
> > On Thu, 15 Aug 2024 at 21:50, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
Trim the message.
> > > >
> > > > @@ -259,31 +184,15 @@ int rockchip_pcie_init_port(struct rockchip_p=
cie *rockchip)
> > > >        * Please don't reorder the deassert sequence of the followin=
g
> > > >        * four reset pins.
> > > >        */
> > >
> > > The comment above says that the resets should not be reordered. But y=
ou have
> > > reordered the resets.
> > >
> > As per the TRM [1], CRU_SOFTRST_CON8  clock reset unit has two groups
> > one with reset value 0x1 and the other 0x0, so this patch groups them
> > accordingly.
> >
> > [1] https://opensource.rock-chips.com/images/e/ee/Rockchip_RK3399TRM_V1=
.4_Part1-20170408.pdf
> >
> > If I only use reset_control_bulk_assert and
> > reset_control_bulk_deassert for all the reset
> > I get the below reset warning.
> >
>
> I think you misunderstood what I asked for. The comment says that the 4 r=
esets
> (mgmt-sticky, core, mgmt, pipe) should not be reordered. In your new grou=
p
> rockchip_pci_core_rsts(), you have reordered them. I was just asking you =
to keep
> the 4 resets sorted as per the comment.
>
Ok, I understood thanks.

Actually as per TRM [1]
17.5.2.2.2 System Reset
The PCIe has the following distinct reset, all of these are
configurable through software
driver. This section describes the function of each of the reset
inputs and the recommended
sequences in which these should be activated. All in all, after power
up, the software driver
should de-assert the reset of PCIe PHY, then wait the PLL locked by
polling the status, if PLL
has locked, then can de-assert the rest reset simultaneously.

[1] https://www.rockchip.fr/Rockchip%20RK3399%20TRM%20V1.3%20Part2.pdf

So I was trying to move all the reset to the common function for the asset
and then call the de-assert once the phy comes up
it is not working at this moment.


[    7.084698] rockchip-pcie f8000000.pcie: no vpcie12v regulator found
[    7.281392] NET: Registered PF_ALG protocol family
[    7.372972] 8021q: 802.1Q VLAN Support v1.8
[    7.830860] rockchip-pcie f8000000.pcie: PCIe link training gen1 timeout=
!
[    7.831528] rockchip-pcie f8000000.pcie: probe with driver
rockchip-pcie failed with error -110

Meanwhile, I found PCIe GRF from the TRM Part 1 is missing for this so, I
 will add this to this series in the next version, let see if there is
improvement

#define GRF_SOC_CON_5_PCIE     0x0e214
#define GRF_SOC_CON_9_PCIE     0x0e224

> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

Thanks
-Anand

