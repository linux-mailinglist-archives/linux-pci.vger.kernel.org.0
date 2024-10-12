Return-Path: <linux-pci+bounces-14403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518F999B548
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 16:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25107B213A7
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 14:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8443317B51B;
	Sat, 12 Oct 2024 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvK3HQrt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB11E481;
	Sat, 12 Oct 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728741985; cv=none; b=rFR3RoY17rgsIf8njmrAdVq5JrgGRmPmAULUS7qHmKjTiWS4MsSUzq+jfP8oETfLloT9tirOkxuyTplmLZThck+7vIXYkQ8ty+TPFHnYWvIeJnlNA3nZzf08pK1pWjvBjhka7LSUF0+hG3rMri7DcyZ6sHu738YyCuy0zVT1l44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728741985; c=relaxed/simple;
	bh=/SWqvoR2YgdgWZrZIX2P4uQyPR1BQ2zzsQMJDk8pgqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwCt6FILWPteb9w5UR8ihkd9lWyAsd0/i/8cfyYrxj30jwvpqeGyfa/LPBxCT0nSC0hiRgr/oVVS+5KA3se8yRBeqMygYgtBnHmxM0K/c5+TzCXbFIAWI33TmL7Su4aIVW1l1ZUsvutxo9CdhZYaZEcVdusqVgxvKMD1q0Z2Qd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvK3HQrt; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e5d3662432so265973b6e.0;
        Sat, 12 Oct 2024 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728741983; x=1729346783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCmH1THNg8dg275jcyBMF4Et+cvhpnNYdSxL4UqUwOk=;
        b=BvK3HQrtpAnaZXsb34uw1rP8t8mJNdSDsR7gyM9Q3vbU696QJ8Iot0EC/JzTPhqv3M
         vgdmmluY485LPn4RijymvN6kKmI47DCPeKpoApFRAIwgjHIlsvr3IS/f1G5ETP2+yzWO
         4Ho7k0nV7FXDTBBQ2Cd5NBm/q3JpHBsvm94llLzgOiLuBmBdJCGrqhZhf64xrfirfGVP
         +fBKUgP+T2KaDmhzl8oPb58/1pBfcqrUAa7iGstD/rp5G6suZpR59AQkFNHN2hpdbL2M
         T2ii+DvplF7vKwYx71OKEm9zi2/HuCp/1Osc3CnUoMy4e5jxuCo3PZoXkg6Nf0etWeVt
         /dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728741983; x=1729346783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCmH1THNg8dg275jcyBMF4Et+cvhpnNYdSxL4UqUwOk=;
        b=q9RvS0nERMtILctN6yD/hv8SAtnCSrTVdluwZfDN2Ks+JkyJ4YL+4RoXYxCSelW02V
         5yB/L6iYhV+FYPxxJeISDkP8ndvgfF+z5HFc9VYyepJ83WnoktdWAjSPf2hrF2SoRY6Z
         OeI+VhTZiNSGpGpEguxHC7SOfubVsnVsUEVeE+wJyQAn+z+ypB4sTbzcRIWeaQj27UMf
         0avsJ0i5AkUN64Rev/j2izZvx+TEjpq59ffAyWIAoby1ADUws8fvsj9dJLt2ZgA1EEa/
         SVYwckw2J5nMTMNydahNYcHEjkw86C1zMA7Oh7Zqv6MzjxsrxYoQj9x7qvpgnuuLv+WD
         r7BA==
X-Forwarded-Encrypted: i=1; AJvYcCWERHoWVFvlLDkTl8JWa1IVGqB1WBj403DpR777Zw96EsUMy6oSGU/EBfs/qn8OAgAXQAiUkCgWZAdfwUk=@vger.kernel.org, AJvYcCWPhQtGs8rx6zuLhPZQJsXXS3iHxSD8v5dUjWbHKJIFupWcroE57wGb6W2zGVhK+oM4ozTJlJ3fR7kj@vger.kernel.org
X-Gm-Message-State: AOJu0YywOM6CiHDxtpl3ke1h4K3MZwz/RJYQmnYErBNENuOD9LsQVIwc
	/Qhoy/SOCurtNgaw6wJJ9wvlVjo7bfZZQIQVJyXx8UOZmFUX06mPCZCKXS1lMMyXoj+zPRzHhNE
	+w+sGDa0vOMNoK8roerYQwHZwAzU=
X-Google-Smtp-Source: AGHT+IG9lm56/n4kuGTTlNoEBLDFH6//5CsJJN4Wt2OniumOX20ofBjuoeRnU8ECwBLZIj5f0lDozZZPxSGxMcMqQTY=
X-Received: by 2002:a05:6808:bc9:b0:3dc:16b5:e3ac with SMTP id
 5614622812f47-3e4d753452dmr5685200b6e.7.1728741982665; Sat, 12 Oct 2024
 07:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012050611.1908-1-linux.amoon@gmail.com> <20241012050611.1908-3-linux.amoon@gmail.com>
 <20241012061834.ksbtcaw3c7iacnye@thinkpad> <CANAwSgTk2ynkuxBarvX--Qs_LTduFuSDCv3k_WNgj=za_81+kQ@mail.gmail.com>
 <20241012080019.cdgq63rwj6oi4bg7@thinkpad> <CANAwSgSCfM9TUe6j6OemyMbY_NsjLNgV=rCu9jXw7u_361bE+g@mail.gmail.com>
 <20241012120536.l7tp32ofvf6okijy@thinkpad>
In-Reply-To: <20241012120536.l7tp32ofvf6okijy@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 12 Oct 2024 19:36:08 +0530
Message-ID: <CANAwSgS-NsXdXMv7V+UG1aCnk7ea+mLcQE803NnLyB4-z_AMUg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

On Sat, 12 Oct 2024 at 17:35, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Sat, Oct 12, 2024 at 03:34:25PM +0530, Anand Moon wrote:
> > Hi Manivannan,
> >
> > On Sat, 12 Oct 2024 at 13:30, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Sat, Oct 12, 2024 at 12:55:32PM +0530, Anand Moon wrote:
> > > > Hi Manivannan,
> > > >
> > > > Thanks for your review comments.
> > > >
> > > > On Sat, 12 Oct 2024 at 11:48, Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > >
> > > > > On Sat, Oct 12, 2024 at 10:36:04AM +0530, Anand Moon wrote:
> > > > > > Refactor the reset control handling in the Rockchip PCIe driver=
,
> > > > > > introducing a more robust and efficient method for assert and
> > > > > > deassert reset controller using reset_control_bulk*() API. Usin=
g the
> > > > > > reset_control_bulk APIs, the reset handling for the core clocks=
 reset
> > > > > > unit becomes much simpler.
> > > > > >
> > > > >
> > > > > Same comments as previous patch.
> > > > >
> > > > I will explain more about this.
> > > > > > Spilt the reset controller in two groups as pre the RK3399 TRM.
> > > > >
> > > > > *per
> > > > >
> > > > > Also please state the TRM name and section for reference.
> > > > >
> > > > Yes
> > > > > > After power up, the software driver should de-assert the reset =
of PCIe PHY,
> > > > > > then wait the PLL locked by polling the status, if PLL
> > > > > > has locked, then can de-assert the reset simultaneously
> > > > > > driver need to De-assert the reset pins simultionaly.
> > > > > >
> > > > > >   PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N.
> > > > > >
> > > > > > - replace devm_reset_control_get_exclusive() with
> > > > > >       devm_reset_control_bulk_get_exclusive().
> > > > > > - replace reset_control_assert with
> > > > > >       reset_control_bulk_assert().
> > > > > > - replace reset_control_deassert with
> > > > > >       reset_control_bulk_deassert().
> > > > > >
> > > > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > > > ---
> > > > > > v7: replace devm_reset_control_bulk_get_optional_exclusive()
> > > > > >         with devm_reset_control_bulk_get_exclusive()
> > > > > >     update the functional changes.
> > > > > > V6: Add reason for the split of the RESET pins.
> > > > > > v5: Fix the De-assert reset core as per the TRM
> > > > > >     De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N=
/RESET_N
> > > > > >     simultaneously.
> > > > > > v4: use dev_err_probe in error path.
> > > > > > v3: Fix typo in commit message, dropped reported by.
> > > > > > v2: Fix compilation error reported by Intel test robot
> > > > > >     fixed checkpatch warning.
> > > > > > ---
> > > > > >  drivers/pci/controller/pcie-rockchip.c | 151 +++++------------=
--------
> > > > > >  drivers/pci/controller/pcie-rockchip.h |  26 +++--
> > > > > >  2 files changed, 49 insertions(+), 128 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/p=
ci/controller/pcie-rockchip.c
> > > > > > index 2777ef0cb599..9a118e2b8cbd 100644
> > > > > > --- a/drivers/pci/controller/pcie-rockchip.c
> > > > > > +++ b/drivers/pci/controller/pcie-rockchip.c
> > >
> > > [...]
> > >
> > > > > > @@ -256,31 +181,15 @@ int rockchip_pcie_init_port(struct rockch=
ip_pcie *rockchip)
> > > > > >        * Please don't reorder the deassert sequence of the foll=
owing
> > > > > >        * four reset pins.
> > > > >
> > > > > I don't think my earlier comment on this addressed. Why are you c=
hanging the
> > > > > reset order? Why can't you have the resets in below (older) order=
?
> > > > >
> > > > > static const char * const rockchip_pci_core_rsts[] =3D {
> > > > >         mgmt-sticky",
> > > > >         "core",
> > > > >         "mgmt",
> > > > >         "pipe",
> > > > > };
> > > >  I will add a comment on this above.
> >
> > I get your point, I missed your point.
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/pci/controller/pcie-rockchip.c?h=3Dv6.12-rc2#n275
> >
> > Actually I had these changes, but it got missed out in rebase.
> >
> > >
> > > Sorry, I don't get your response. My suggestion was to keep the reset=
s sorted as
> > > the original order (also indicated by my above snippet).
> >
> > I will go through all the suggestions and modify them accordingly.
> >
> > As per the RK3399 TRM
> > [2] https://rockchip.fr/Rockchip%20RK3399%20TRM%20V1.3%20Part2.pdf
> >
> > 17.5.2.2 Reset Application
> > 17.5.2.2.2 System Reset (describe all the core reset feature)
> > (name as per the dts mapping)
> > RESET_N: - core
> > MGMT_RESET_N:- mgmt
> > MGMT_STICKY_RESET_N:- mgmt-sticky
> > PIPE_RESET_N: - pipe
> > AXI_RESET_N - aclk
> > APB_RESET_N: pclk
> > PM_RESET_N: - pm
> > PCIE_PHY_RESET_N: - phy reset (used in the phy driver).
> >
> > This is the reason for the split of the clk and core reset.
> >
> > Further down in
> > 17.5.8 PCIe Operation
> > 17.5.8.1 PCIe Initialization Sequence
> > 17.5.8.1.1 PCIe as Root Complex
> >
> > 6. De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
> > simultaneously
> >
> > Should I follow this order ? or the above order.
> > static const char * const rockchip_pci_core_rsts[] =3D {
> >         "pipe",
> >         "mgmt-sticky",
> >          "mgmt",
> >          "core",
> > };
>
> Ok, thanks for clarifying. I was worried about the comment in the driver =
that
> warns against changing the order. But TRM rececommends a different order =
:/
>
> But since no one ever reported any issue, let's go with the existing orde=
r. If
> you want to follow TRM, then I'd like to get an Ack from Rockchip Enginee=
rs who
> knows the hardware better.
>
I will follow the existing code version,
I was confused with the name and description earlier.
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

Thanks
-Anand

