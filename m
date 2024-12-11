Return-Path: <linux-pci+bounces-18179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014559ED784
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C56116851A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 20:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159E220B81C;
	Wed, 11 Dec 2024 20:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="UHBXB+K/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA620CCC2
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950466; cv=none; b=RfYgCVDTx8x/0TL/uhr/gEin3WJlZPkrDYk4Z70dJ6L1SUH1PeuQ8A2z55JzzgIy8Jwp+3dmX7VQRNP4rtrUheKCzSbzgOX8PzVsTEmNpzVQCN3zZP3F8jJFGWnJjtmDybuc6ziUldztNVUetkb4ZsN4B4QNKRXdbk7UM/WLpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950466; c=relaxed/simple;
	bh=lzTKxdg9CiwLG8Mb+IW6XOFzKRazhl7sBeUUxZG7AUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g272olKtyHVkVMc4J17j+z3p4SNJvpOlHrps0PNf4OcK8AWnRXpWCi03XkhIpAH2/61ImRRUzZKJesYd+D9Kt1UOChHzGdw1qwY++Ne9+zMn+9WAhxvjLDgnnoByRAErYn8Iv4ynNmhTZTi0d+3vLG79exaWbXfdDi+et91V8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=UHBXB+K/; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4afe1009960so1389989137.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 12:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1733950462; x=1734555262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dYliTF35nPNFNRmXPIOQ4ksdgvuWl/AzFHNeTIQ3J/I=;
        b=UHBXB+K/JmvoFXlqeKXFnhxUFPmcm4hU+HGtfvPT9QVzn3LpJGPZQi57NrMaMzTNWB
         eLQye3V2ULNKRgPVSlwLIsHaintS4g2mfHVaf/N6c9S9BOruc30Jx956+ZnU57mkp9pE
         WVm9FdCT2Tq54ydJNfrxnY0hsTzjZ5EaI63fOFA8gNiQbTc++785NmpP59JhuFbRzgp+
         9BOllmASrhhjTt2QoE9q93jBWsezme4apvQA4Gp7Un7FSddq1yPgkkbaP4WwUIyu1V1e
         ZbZGCWnyP3Y6xHZcw2B6e+LPuh1D05u3CKtBFwYwoyuSGQnAVAHHnGMrrqnLQ5dppIGS
         57KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950462; x=1734555262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYliTF35nPNFNRmXPIOQ4ksdgvuWl/AzFHNeTIQ3J/I=;
        b=sJi+TZwRSrH32WFBBrvZPZljEisT4TAMDvJuGoQwhmYtjv+oYjQjxvX/1bdu27EnQZ
         9IxEYcJTGTcFp7QJpoz3gdKg+MuFNYLiUxAY4orSu7LJ1ObNfdaEs4vgp6960CJWQdgZ
         83xqUMW7gu0R37QV9ZuRwY7321VOhutnx4Q7z8F39ty7Am7t5Ye3SAjQkfnpYczYEr/t
         hTf4VB3/a9Ocd2Ol1C2UFZs5v9cBmekw9qee2tE+HLgznYAMMFtV7tyfJGicKQP9LHaQ
         ixWbS3496EVUhUl+IxvELk2kUM2nReX7LeWecqm9fNDjUwzN1+Y1Ch08uTDxEDXl+QCQ
         HOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVS+gwHhkaRalOEU82cDrjAUUnUBu+WzudPAcBSoYLB0PQNvk8Fx/Xp+4HmwG9UXknfWYI6ZrAoZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLuVBIopgZhIEZ0ML0rektQbGAqY2a/tIsl2NVOlqcwIvJhrsO
	QzXaOVpA8JWEDVJiYjXw9jaKTTV6/HvVbySIlHJ14A4WznR+O2M8JfH59RhdBEbeWZXaxY1W5Jk
	pjjCTSfjgX4Ntmfzge6JoPGKMM09OsH0Vr8c4wA==
X-Gm-Gg: ASbGnctFhJ9onQm5sqyNIVjuKkui6r2Bhyn1feCdCFCViIIEKg+EeAJE9AAoK1l4Vme
	6w3ShcbTFmHXL43mgBUW++DvPrxidfPjrodEXK09TKRMXcD4TBnVH94L3eiwGKl4Muw==
X-Google-Smtp-Source: AGHT+IFDJ3hxR2NNeGvlMcd40FPBdx04p3qGo6Inh+bBqmvdcNtdNFdP1cY9W4nm5HsXXzcK6b0wp6lE6uUBauKHkAs=
X-Received: by 2002:a05:6102:50ac:b0:4af:d487:45f3 with SMTP id
 ada2fe7eead31-4b2478d8b65mr1386165137.23.1733950462194; Wed, 11 Dec 2024
 12:54:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025124515.14066-1-svarbanov@suse.de> <20241025124515.14066-9-svarbanov@suse.de>
 <4bbdf9ed-f429-411b-8f5f-e51857f0f9d0@broadcom.com> <f9f49030-0518-4e30-91a7-3c088c31180b@suse.de>
 <474e5e38-37a4-439b-b25a-fe60df03f25b@broadcom.com>
In-Reply-To: <474e5e38-37a4-439b-b25a-fe60df03f25b@broadcom.com>
From: Jonathan Bell <jonathan@raspberrypi.com>
Date: Wed, 11 Dec 2024 20:54:12 +0000
Message-ID: <CADQZjwci2SVN=AG178kj3yN=17nVixOHEZOjZCs9LSUihbby4Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] PCI: brcmstb: Adjust PHY PLL setup to use a
 54MHz input refclk
To: James Quinlan <james.quinlan@broadcom.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrea della Porta <andrea.porta@suse.com>, 
	Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 19:39, James Quinlan <james.quinlan@broadcom.com> wrote:
>
> On 12/10/24 08:42, Stanimir Varbanov wrote:
> > Hi Jim
> >
> > On 12/10/24 12:52 AM, James Quinlan wrote:
> >> On 10/25/24 08:45, Stanimir Varbanov wrote:
> >>> The default input reference clock for the PHY PLL is 100Mhz, except for
> >>> some devices where it is 54Mhz like bcm2712C1 and bcm2712D0.
> >>>
> >>> To implement this adjustments introduce a new .post_setup op in
> >>> pcie_cfg_data and call it at the end of brcm_pcie_setup function.
> >>>
> >>> The bcm2712 .post_setup callback implements the required MDIO writes that
> >>> switch the PLL refclk and also change PHY PM clock period.
> >>>
> >>> Without this RPi5 PCIex1 is unable to enumerate endpoint devices on
> >>> the expansion connector.
> >>>
> >>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> >>> ---
> >>> v3 -> v4:
> >>>    - Improved patch description (Florian)
> >>>
> >>>    drivers/pci/controller/pcie-brcmstb.c | 42 +++++++++++++++++++++++++++
> >>>    1 file changed, 42 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/
> >>> controller/pcie-brcmstb.c
> >>> index d970a76aa9ef..2571dcc14560 100644
> >>> --- a/drivers/pci/controller/pcie-brcmstb.c
> >>> +++ b/drivers/pci/controller/pcie-brcmstb.c
> >>> @@ -55,6 +55,10 @@
> >>>    #define PCIE_RC_DL_MDIO_WR_DATA                0x1104
> >>>    #define PCIE_RC_DL_MDIO_RD_DATA                0x1108
> >>>    +#define PCIE_RC_PL_PHY_CTL_15                0x184c
> >>> +#define  PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK        0x400000
> >>> +#define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK    0xff
> >>> +
> >>>    #define PCIE_MISC_MISC_CTRL                0x4008
> >>>    #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK    0x80
> >>>    #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK    0x400
> >>> @@ -251,6 +255,7 @@ struct pcie_cfg_data {
> >>>        u8 num_inbound_wins;
> >>>        int (*perst_set)(struct brcm_pcie *pcie, u32 val);
> >>>        int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> >>> +    int (*post_setup)(struct brcm_pcie *pcie);
> >>>    };
> >>>      struct subdev_regulators {
> >>> @@ -826,6 +831,36 @@ static int brcm_pcie_perst_set_generic(struct
> >>> brcm_pcie *pcie, u32 val)
> >>>        return 0;
> >>>    }
> >>>    +static int brcm_pcie_post_setup_bcm2712(struct brcm_pcie *pcie)
> >>> +{
> >>> +    const u16 data[] = { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030,
> >>> 0x5030, 0x0007 };
> >>> +    const u8 regs[] = { 0x16, 0x17, 0x18, 0x19, 0x1b, 0x1c, 0x1e };
> >>> +    int ret, i;
> >>> +    u32 tmp;
> >>> +
> >>> +    /* Allow a 54MHz (xosc) refclk source */
> >>> +    ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0,
> >>> SET_ADDR_OFFSET, 0x1600);
> >>> +    if (ret < 0)
> >>> +        return ret;
> >>> +
> >>> +    for (i = 0; i < ARRAY_SIZE(regs); i++) {
> >>> +        ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, regs[i],
> >>> data[i]);
> >>> +        if (ret < 0)
> >>> +            return ret;
> >>> +    }
> >>> +
> >>> +    usleep_range(100, 200);
> >>> +
> >>> +    /* Fix for L1SS errata */
> >>> +    tmp = readl(pcie->base + PCIE_RC_PL_PHY_CTL_15);
> >>> +    tmp &= ~PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK;
> >>> +    /* PM clock period is 18.52ns (round down) */
> >>> +    tmp |= 0x12;
> >>> +    writel(tmp, pcie->base + PCIE_RC_PL_PHY_CTL_15);
> >> Hi Stan,
> >>
> >> Can you please say more about where this errata came from?  I asked the
> >> 7712 PCIe HW folks and they said that there best guess was that it was a
> >> old workaround for a particular Broadcom Wifi endpoint.  Do you know its
> >> origin?
> > Unfortunately, I don't know the details. See the comments on previous
> > series version [1]. My observation shows that MDIO writes are
> > implemented in RPi platform firmware only for pcie2 (where RP1 south
> > bridge is connected) but not for pcie1 expansion connector.
>
> Well, I think my concern is more about the comment "Fix for L1SS errata"
> rather than the code.  If this is a bonafide errata it should have an
> identifier and some documentation somewhere. Declaring it to be an
> unknown errata provides little info.

I'm the originator of this thunk - erratum is perhaps the wrong description.
If the reference clock provided to the RC is 54MHz and not 100MHz, as
is the case on BCM2712, then many of the L1 sub-state timers run
slower which means state transitions are unnecessarily lengthened.

This change, and the MDIO manipulation above, should be applied
regardless of the RC instance and/or connected EP.

> Code-wise, you could use u32p_replace_bits(..., PM_CLK_PERIOD_MASK) to
> do the field value insertion.
>
> All the above being said, I have no objection since this code is
> specific to the RPi platform.
>
> Jim Quinlan  Broadcom STB/CM
>
> >
> > ~Stan
> >
> > [1] https://www.spinics.net/lists/linux-pci/msg160842.html
> >
>

Regards
Jonathan

