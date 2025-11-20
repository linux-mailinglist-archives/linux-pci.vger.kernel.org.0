Return-Path: <linux-pci+bounces-41791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B9CC746E8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0FD3354778
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF03346E6B;
	Thu, 20 Nov 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfzT1UXQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F2346E46
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647117; cv=none; b=PAc7M5783vefyCQVquyVjRBBYhVvFQECJIliw8n+VN2tvY7J6BDw796L/yBDB78LPwLc0F+J23YLaBubcMxVBCNzpierdw3T3U0qM7etPmIZ4MBxXagoFECMO6t2RfOsMfbDtwrZADyP0Uu8jal9HU+7w14g1O9hFB8PgKHoG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647117; c=relaxed/simple;
	bh=2RY7CxCHQ+BEEWQIXEljo86D3mF4hfU9MCmSjpH4C80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn2eDnJs67Bo/GkGFgDqA15iCwD0E60bM4zT8JZjwg2OgR5mgB401kU5sF5yTiODCrtEbwkpWm+F3rGiv579Vui8L2QhOqK4MSGVG3FREWcOvvi86xHbyYGS9X7P2KDsLNN1vly6g4BtLMW7ATHX/pkmPrOIvaBHYrJpNsUNYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfzT1UXQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b713c7096f9so154931666b.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 05:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763647113; x=1764251913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DG3ChDDmMT3YrDzxPPea5PzvCSNp1XdHPGl33REZrIc=;
        b=DfzT1UXQIXVKMkAxibWKkJ350kVGpkfJrVxW0u4IW5ZpBffZO7IFArxrvSDmlyb61s
         vgX6s3lVzAWjX3f2zytpUsKmqD5+Co7B5BiGI8XvQ+NkiZlage9bphI4od/nGJVuoTgR
         K9d/buA/2Ei0r6lNIrPuqtbivMASWQqImRWaLWpIH/A1CpWTrrenYtWNMr3gTDoAB/Xn
         SpSNq3dwYTbntDA75UD4Ug071SeU364WNu4uAk6IyT28m9Z+KLqOMv008P1OP5U3ZkwG
         RGH9YgWT/nybkTJRUJ2YL1FxguLYja/2dmjTI9dkXzNcBCHCt/b6fdrVURIVXBl0i+iL
         7b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763647113; x=1764251913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DG3ChDDmMT3YrDzxPPea5PzvCSNp1XdHPGl33REZrIc=;
        b=pTL8h4AvjO/rk79CzQPjOUxz/akFkuKr1D9jdHIgbd/jt+Mj371PAOF6R31I+4zIST
         pBU52Ihoxn9KuJEXVk4eZ4OkDb4/r8IDjbCPaYCnNtQpr2B9bHlcW/Y5XlwG6KjeODPj
         m1EeelbznwN2bJJEMz8XuKOBXQ+82hnwk5XoDUTcJDNnIWkrrlsggzrAo8v8RyOoek18
         N9U9Q/S1Srw/Db1GDZZjgU203hqPUshHuOoP869GElt5sJei4sZYINZ5mChJvPAHwEFn
         5oZLkC3nHXvufTfCVOSskqoQEV9yeNdQAFl4x2osgW8MpINJ8dodyCCmXQf/kXRIL50g
         P7ug==
X-Forwarded-Encrypted: i=1; AJvYcCWado90vJhqBsFlvN0FqOcUMmwc/AU4372f9qwZYNs7IM5f8WoKRTVBkW3hho1lkbPHs1oIDhiLfo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgqLVVDoiJNl0G1R0/Zy/scW68nBnqYPv/NdLZxdKeEiCT6kv
	R3/E3s0vob7icBZwYf6j3WPlEnDgLEQx7X/wftvcG2Dh3cBEH8UN2g6LeUqKEn27TonKGiox2lp
	YcNwJsir0JB0XD2rmlIha1OL27OlxGUg=
X-Gm-Gg: ASbGncviihSvbFnMwr4LA7T5GPYtIx7w/O4MFAfbC8l/v0/6ScIuzxU3zesnwjTw7+L
	ywoLZ0CsLeVXeCsZQUjJgZj/Ozv7p/pcJwf9KIyQ0uqryqWgUE9MFGvxhDTY0mfUBathopNHh3g
	E8CBt7JGsNyFQ9WDdgzY/ma4KTTUCQJDmAWoMw8b7tTohRYxjnUja94MH6de3AjKw4oBYhrL2ZU
	VFQ+tTaPZKYDXf52qmon0vreX3HoVHH1y0G+t/TGYmd5WLH+P7LqTpQiSZyGMkIs/1EIQ==
X-Google-Smtp-Source: AGHT+IEVLfIBF85HV4ZlfgN4D/4VOtQPabMhTdTM/DaKaBk2/tnTiKXzg1B0RQb5cwyWvIZ3LTgBAP+D+hBXUmc9U8o=
X-Received: by 2002:a17:907:9447:b0:b40:8deb:9cbe with SMTP id
 a640c23a62f3a-b7654cf3b82mr376884266b.2.1763647112743; Thu, 20 Nov 2025
 05:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAwSgRHuwoQjr95sXp-X97=L-X3vqUPxjR5=2jNtFZA+4gnwQ@mail.gmail.com>
 <20251120034437.GA2625966@bhelgaas>
In-Reply-To: <20251120034437.GA2625966@bhelgaas>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 20 Nov 2025 19:28:14 +0530
X-Gm-Features: AWmQ_bnrXbdS4d1Wa8FR5sCLFCXhpJ7ae-_eHD85CbC5H6jhwpeTAoWyfYR2uDo
Message-ID: <CANAwSgStRZW322X3H_B4wK5CthFube_4MBUBw=U1BRjyRGeu9g@mail.gmail.com>
Subject: Re: [RFC v1 1/5] PCI: rockchip: Fix Link Control register offset and
 enable ASPM/CLKREQ
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Thanks for your input.

On Thu, 20 Nov 2025 at 09:14, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Nov 19, 2025 at 07:49:06PM +0530, Anand Moon wrote:
> > On Tue, 18 Nov 2025 at 23:20, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, Nov 17, 2025 at 11:40:09PM +0530, Anand Moon wrote:
> > > > As per the RK3399 TRM (Part 2, 17.6.6.1.31), the Link Control regis=
ter
> > > > (RC_CONFIG_LC) resides at an offset of 0xd0 within the Root Complex=
 (RC)
> > > > configuration space, not at the offset of the PCI Express Capabilit=
y List
> > > > (0xc0). Following changes correct the register offset to use
> > > > PCIE_RC_CONFIG_LC (0xd0) to configure link control.
> > ...
>
> > > Don't do two things at once in the same patch.  Fix the register
> > > offset in one patch.  Actually, as I mentioned at [1], there's a lot
> > > of fixing to do there, and I'm not even going to consider other
> > > changes until the #define mess is cleaned up.
>
> > > [1] https://lore.kernel.org/r/20251118005056.GA2541796@bhelgaas
> >
> > According to the RK3399 Technical Reference Manual (TRM), and pci_regs.=
h
> > already includes the correct, pre-defined offsets for all PCI Express
> > device types
> > and their capabilities registers. To avoid overlapping register mapping=
s,
> > we should explicitly remove the addition of manual offsets within the c=
ode.
>
> > Here is the example. Is this the correct approach?
>
> > -       status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> > PCI_EXP_LNKCTL);
> > +       status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC);
> >         status |=3D (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> > -       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> > PCI_EXP_LNKCTL);
> > +       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC);
>
> No.  The call should include PCI_EXP_LNKCTL because that's what we
> grep for when we want to see where Link Control is updated.
>
> See my example from [1] above:
>
>   rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_DEVCAP)
>   rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_LNKCTL)
>
> You should have a single #define for the offset of the PCIe
> Capability, e.g., ROCKCHIP_RP_PCIE_CAP.  Every access to registers in
> that capability would use ROCKCHIP_RP_PCIE_CAP and the relevant
> PCI_EXP_* offset, e.g., PCI_EXP_DEVCAP, PCI_EXP_DEVCTL,
> PCI_EXP_DEVSTA, PCI_EXP_LNKCAP, PCI_EXP_LNKCTL, PCI_EXP_LNKSTA, etc.
>
I apologize for not fully understanding the issue earlier. I did not
carefully review your email,
 which caused me to overlook the required changes.

So, as per the TRM

17.6.4.5.1 PCI Express Capability List Register
Propname=EF=BC=9APCI Express Capability List Register
Address=EF=BC=9A@0xc0

#define PCIE_EP_CONFIG_DID_VID          (PCIE_EP_CONFIG_BASE + 0x00)
#define PCIE_EP_CONFIG_LCS              (PCIE_EP_CONFIG_BASE + 0xd0)
#define PCIE_RC_CONFIG_RID_CCR          (PCIE_RC_CONFIG_BASE + 0x08)
#define PCIE_RC_CONFIG_CR               (PCIE_RC_CONFIG_BASE + 0xc0)
#define ROCKCHIP_RP_PCIE_CAP            (PCIE_RC_CONFIG_BASE + 0xc0)
/* Link Control and Status Register */
#define PCIE_RC_CONFIG_LC               (ROCKCHIP_RP_PCIE_CAP + 0xd0)
/* Device Control */
#define PCIE_RC_CONFIG_DC               (ROCKCHIP_RP_PCIE_CAP + 0xc8)
/* Slot Capability Register */
#define PCIE_RC_CONFIG_SC               (ROCKCHIP_RP_PCIE_CAP + 0xd4)
/* Link Control 2 Register */
#define PCIE_RC_CONFIG_LC2              (ROCKCHIP_RP_PCIE_CAP + 0xf0)
/* Linkwidth Control Register */
#define PCIE_RC_CONFIG_LWC              (ROCKCHIP_RP_PCIE_CAP + 0x50)

And then use these like this.

status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC + PCI_EXP_LNKCTL)=
;
status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DC + PCI_EXP_DEVCTL)=
;
status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_SC + PCI_EXP_DEVCAP)=
;
status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC2 + PCI_EXP_LNKCTL=
2);
status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LWC + PCI_EXP_LNKCTL=
);

If you agree that this approach correctly resolves the issue,
I would prefer to confirm now to prevent further iterative changes
that might confuse.

> Bjorn

Thanks
-Anand

