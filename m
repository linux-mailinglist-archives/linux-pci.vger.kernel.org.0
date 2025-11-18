Return-Path: <linux-pci+bounces-41497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A749C69069
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 12:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88BC0349E82
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A02F2F360E;
	Tue, 18 Nov 2025 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo+VfjF+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0902D59E8
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464611; cv=none; b=jJMp5us2BefMGiXCNp1RvsGdfQhFDlyl4AUD42VF3Nq0UpbXp0jgHUbv4tdrA0xKmz2uWBmp+r8TF1LffLCTiAHDfVFGzsDd9WBKC0WvMJzTU0M3+UPlySd3nMv5msHtMshhwnCH1BRFMgEoIbOm5q9FPUmtoLWNFai6EnyxoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464611; c=relaxed/simple;
	bh=NciOAruaUsOIMiB4AUT44IMQLQVHGuRwSg+HOJ8HSRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0Y7nr7Ai9SeuUk8vtOYkfScFfEJza9aDezBIuBNGFIYnkh0WfWI8VZ5Cso2i7GSfi392FEeBMilLLJuIOKfkNKwmneq/HyFA63mR2W14iYoNdB/oqqJMUE7rktCfSfyOI2JxvDJkybM9fnwiH0ib/q1MQsC8KmyDqfSuncEgJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo+VfjF+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so7082582a12.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 03:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763464608; x=1764069408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ICI58HqE+ly7YapWrb44Ml5uRJuKE+CUkOe4M7qjE5M=;
        b=fo+VfjF+9SvHmRNZui1BH/p7jcIp5YiB4yYWZKpWI9DHM1zlNYr0/+lTw/dD7lFstD
         rfsZhPekRMRaRx/3NIT5B7ZCdf1zhqTLZeUOPbWY5vGQ7VGM/RUlKGsEF85/U2Hu2Wpb
         MFUWut4XyRQtXD73K+3rhJQwPpVLmXkoy8UBP7rQqVU6x0EWmP1j6YFBXLP3Dqm3NSR1
         2EPEcetwsO8rxd57bBSUHpSv6oc1Gi4mpYkqoOyNDN80RbmkKzmf7u1qyQrSIguHobtY
         PXUqd2yIT6uSVmfQJGyPQWFuB0iqh+jtdLCVW6u+nxxYGO8m0OeIioeSPToqf/T0c5Jc
         0AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763464608; x=1764069408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICI58HqE+ly7YapWrb44Ml5uRJuKE+CUkOe4M7qjE5M=;
        b=CZ3jCw1+G6Ne2ORh/VCfEYsD6Tr5fFM2b+1R2si/SuMI4kWNZYwjx/sWBwoHVl0J/S
         xFWkghX1AoPqrZnA4frIz1hhqGJwTLNF3IOlhmD+gIC5Egaa1AT9CZO6ztxa/Akch8bK
         U57fq66ia38g9NwOeW+5d9iWog6iPgbpgKWrcoqjSDbg9jHjiOXOgAm/ilaC2iD1VqwA
         H5Hm/K+VUFMfcS+Yluy4abCthGipCAbpGf1h6B6KrxAuT8570Q7Lb5tH3mlpJcbIMjpS
         pqKahrDwCTtifKzXnz6i3pz/ULondbAb3meUDnLPic2Vrhij6lwkG9RSZFaLH2af+1mf
         ubSg==
X-Forwarded-Encrypted: i=1; AJvYcCVnINOvnTnzMKYypb1gLHtLuTba50FyhtfGDNFxL5ORT8LaJDjTcsVGTCxPezCbxa4rlinUEe+jDFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPhlJsOQsge12wbGfycOChQxpHLDbJyDQc6Tq82pKX3sx5s9Pu
	W8uBv9W12b6Dq4rKlkKk+8MSKaoWCENVUVNrKsghtyGtafpI1Bwuv/xheLk8PDq7eqmPcXzkXIR
	Yy7H7Gu405rLsJNr+4Ze6EeeF5VLuG2c=
X-Gm-Gg: ASbGnctaQnnuhXe7Vz2JegvLSCX4GBJlcZ9siqyduUFOohSukEoiAbocjXugLfCTRXx
	a++VifwaYSDLTQYUoOVOYkjH+pmF0r9aFnFUezNtjQV6f/elsMQOULOjE97/IfVJWxqDffznqK5
	PgkqoTrzoGP5GrGc1XLkyezIS1N6SRqTEfk+ekG2lAHelQ4KCBN7fTVdnbk6wIzqOWDNMSrMuMY
	n/wiOqps5Tr6az3vpyBW6pAB6Q88lecW2AanoAKCqOD6yDnaXgshyhVXQ4frv83FlhSGA==
X-Google-Smtp-Source: AGHT+IGk8eL0HoWbK04CZRhqLg9Zqyg4kUzMUvvqXtI9msvINBej1DvZVcQa01Y7VyQwGu9XDV2OL2RxowdJygXo/7w=
X-Received: by 2002:a05:6402:26d1:b0:640:ecaa:1973 with SMTP id
 4fb4d7f45d1cf-64350e8ccb6mr13827406a12.24.1763464607610; Tue, 18 Nov 2025
 03:16:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117181023.482138-3-linux.amoon@gmail.com> <20251118005056.GA2541796@bhelgaas>
In-Reply-To: <20251118005056.GA2541796@bhelgaas>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 18 Nov 2025 16:46:30 +0530
X-Gm-Features: AWmQ_bksxI4TM_0iWFBAZwf_P1h7XfT3sMIf2tlbZ560ebj9GBa7XRzaoXRCoWo
Message-ID: <CANAwSgSMiRrPp5G+guGQSsqArz7M750NAg8SQoorUQ7gJhUxHQ@mail.gmail.com>
Subject: Re: [RFC v1 2/5] PCI: rockchip: Fix Device Control register offset
 for Max payload size
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

Hi Bjorn

Thanks for your review comments.

On Tue, 18 Nov 2025 at 06:21, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Nov 17, 2025 at 11:40:10PM +0530, Anand Moon wrote:
> > As per 17.6.6.1.29 PCI Express Device Capabilities Register
> > (PCIE_RC_CONFIG_DC) reside at offset 0xc8 within the Root Complex (RC)
> > configuration space, not at the offset of the PCI Express Capability
> > List (0xc0). Following changes corrects the register offset to use
> > PCIE_RC_CONFIG_DC (0xc8) to configure Max Payload Size.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-rockchip-host.c | 4 ++--
> >  drivers/pci/controller/pcie-rockchip.h      | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> > index f0de5b2590c4..d51780f4a254 100644
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -382,10 +382,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
> >               rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
> >       }
> >
> > -     status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
> > +     status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DC + PCI_EXP_DEVCTL);
> >       status &= ~PCI_EXP_DEVCTL_PAYLOAD;
> >       status |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> > -     rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
> > +     rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DC + PCI_EXP_DEVCTL);
> >
> >       return 0;
> >  err_power_off_phy:
> > diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> > index 5d8a3ae38599..c0ec6c32ea16 100644
> > --- a/drivers/pci/controller/pcie-rockchip.h
> > +++ b/drivers/pci/controller/pcie-rockchip.h
> > @@ -157,6 +157,7 @@
> >  #define PCIE_EP_CONFIG_LCS           (PCIE_EP_CONFIG_BASE + 0xd0)
> >  #define PCIE_RC_CONFIG_RID_CCR               (PCIE_RC_CONFIG_BASE + 0x08)
> >  #define PCIE_RC_CONFIG_CR            (PCIE_RC_CONFIG_BASE + 0xc0)
> > +#define PCIE_RC_CONFIG_DC            (PCIE_RC_CONFIG_BASE + 0xc8)
>
> Per the RK3399 TRM:
>
>   DEVCAP              0xc4
>   DEVCTL and DEVSTA   0xc8
>   LNKCAP              0xcc
>   LNKCTL and LNKSTA   0xd0
>   SLTCAP              0xd4
>   SLTCTL and SLTSTA   0xd8
>
> That all makes good sense and matches the relative offsets in the PCIe
> Capability.
>
> I have no idea how we got from that to the mind-bendingly obtuse
> #defines here:
>
>   PCIE_RC_CONFIG_CR == PCIE_RC_CONFIG_BASE + 0xc0
>                     == 0xa00000 + 0xc0
>                     == 0xa000c0
>
>   PCIE_RC_CONFIG_DC == PCIE_RC_CONFIG_BASE + 0xc8
>                     == 0xa00000 + 0xc8
>                     == 0xa000c8
>
>   PCIE_RC_CONFIG_LC == PCIE_RC_CONFIG_BASE + 0xd0
>                     == 0xa00000 + 0xd0
>                     == 0xa000d0
>
>   PCIE_RC_CONFIG_SR == PCIE_RC_CONFIG_BASE + 0xd4
>                     == 0xa00000 + 0xd4
>                     == 0xa000d4
>
> And they're used like this:
>
>   PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP == 0xa000c0 + 0x0c
>                                      == 0xa000cc
>
>   PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL == 0xa000c0 + 0x10
>                                      == 0xa000d0
>
>   PCIE_RC_CONFIG_DC + PCI_EXP_DEVCTL == 0xa000c8 + 0x08
>                                      == 0xa000d0     <-- same as LNKCTL?
>
>   PCIE_RC_CONFIG_SR + PCI_EXP_DEVCAP == 0xa000d4 + 0x04
>                                      == 0xa000d8     <--
>
>   PCIE_RC_CONFIG_LC + PCI_EXP_LNKCTL == 0xa000d0 + 0x10
>                                      == 0xa000e0     <-- but LNKCTL was at 0xa000d0 above?
>
> And the mappings don't make any sense to me:
You are correct, PCIE_RC_CONFIG_DC + PCI_EXP_DEVCTL  results in an
incorrect offset.

As per my understanding
#define PCI_EXP_DEVCTL 0x08 /* Device Control */
#define  PCI_EXP_DEVCTL_PAYLOAD 0x00e0 /* Max_Payload_Size */
#define  PCI_EXP_DEVCTL_PAYLOAD_128B 0x0000 /* 128 Bytes */
#define  PCI_EXP_DEVCTL_PAYLOAD_256B 0x0020 /* 256 Bytes */
#define  PCI_EXP_DEVCTL_PAYLOAD_512B 0x0040 /* 512 Bytes */
#define  PCI_EXP_DEVCTL_PAYLOAD_1024B 0x0060 /* 1024 Bytes */

What I was thinking about was mapping it to a register to offset the
Max_Payload_Size (7:5) at PCIE_RC_CONFIG_DC (0xa000c8).

Sorry for the noise.
>
>   CR -> LNKCAP & LNKCTL
>   DC -> DEVCTL (ok, this one makes a *little* sense)
>   SR -> DEVCAP
>   LC -> LNKCTL (would make some sense except that we have CR above)
>
> This is all just really hard to read.  It looks like if we defined a
> single base address for the PCIe Capability, we shouldn't need all the
> _CR, _DC, _LC, _SR, etc #defines.  E.g., we could have
>
>   #define ROCKCHIP_RP_PCIE_CAP ...
#define ROCKCHIP_RP_PCIE_CAP (PCIE_RC_CONFIG_BASE + 0xc0)
Is this ok? But the current code uses the same.
>
>   rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_DEVCAP)
>   rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_LNKCTL)
>   ...
>
> with maybe some minor adjustment for 16-bit registers since Rockchip
> only seems to support 32-bit accesses (?)
>
> None of these registers are *Root Complex* registers; they're all part
> of a PCIe Capability, which applies to a Root *Port*.
>
Ok, I understood
> >  #define PCIE_RC_CONFIG_LC            (PCIE_RC_CONFIG_BASE + 0xd0)
> >  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
> >  #define PCIE_RC_CONFIG_THP_CAP               (PCIE_RC_CONFIG_BASE + 0x274)
> > --
> > 2.50.1
> >
Thanks
-Anand

