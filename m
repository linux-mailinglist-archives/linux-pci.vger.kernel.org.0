Return-Path: <linux-pci+bounces-41638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB5DC6F4F3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E10054E599A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7605B3A1C9;
	Wed, 19 Nov 2025 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrUO0Hpa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D2C272803
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561965; cv=none; b=odUxfY24A2wpEtkcf/GCwGVOLmg7sS89qbJDgHNjrfUO17GzcrcdlgrZUFQQGLlyS5NprCUj81Hy2lJL5VHHBO3hJBCwmxuNPTTiZ6RiFesLzS8M+tREUx1UwiSezsVxMwp6+F59Ty1sakXf4JRjgUlIyCxfK9kAjLw60bIqcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561965; c=relaxed/simple;
	bh=SzTAVfK4OtplbayynA16ApPzEv4MGcvbd7gWxl8nhiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3pIt4NpLTq2DZ2XC34382H8n5gc0Z5WXzQpAr05OLG3qwZCTQv3+3xY55IFBoJLWexKqqlvCbdWSA3WIYLOJXUr2wZOJESvDOCh7Ph8rQB80pyGax1utm+wnyYIZ7HQ6tEYhXwTo7MU5z9ejIByW2+3DiqNk8u7mPSO/lf0qHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrUO0Hpa; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso2152369a12.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 06:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763561962; x=1764166762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vr1dpfGNw8l/5vNvUXIIntV65WtBCu9bD5JykGnKkMc=;
        b=VrUO0HpaYbByd3tPUGvdg400crqxwJma9nVE+mFnFAEHPtbf+iH8NRZdVPiO0zwUOF
         /QRlh/KLuRf2WkumKnqZzmd1oq3r6uNfmNEKd4Mg/K6GWV1WQpFsDPDZVrtRiaDVjhaO
         DAK/TMRGln44sspYlYlrDNQEBGqDcYdAtZDr0p47I4J3HxrWzea/33OEHloXHD6l7/tU
         o6gXSWsK3Lr98HsLLP/mV834AL6tVtEwmJdie7Zda/kVEbHUftOtnaVF4ynoUK7/fHR1
         TmGAszOvCO9UOBWSYq6hXgbDDAkbJxfDXHdNHK0aylyff5plv0OfEyGkLDM2baiRKD9d
         ntrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561962; x=1764166762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vr1dpfGNw8l/5vNvUXIIntV65WtBCu9bD5JykGnKkMc=;
        b=L4rsFCGdV6VqDfHNovhVXm7gP6fqhEfVZMuhmizn59a6lInK7NVImkWglIlleqFHD2
         lubSpnZcs0roM8sSVv/7WBulP3roSNqT66CmNDzXmNEtlFZ08Fg4gOOZ1drrAi2So288
         U7uqyzGvqFra6s+Z+XZgDvgEAUIPU+aUfEMGFRLkHwQDid1PgL1UddutF2VmC10GVuMF
         mPhDfO3lKQvg+rfj2Z/HIloPjYB6epwrjyZkKb/DhlY+dmrse9+3kX7vPjgHg3ki6Sdy
         LC/EIky8aWZeftrDPE89LSHjCXO8NEAZ/Wd3tiz4kT9hHLxHOMF5B1qQV+yj3uWs61dR
         RvTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCMHpFxpj93Zhjr0jzgtsIumLQEiyyKJwFKfDe+aIeW3+PZnmnCAVE3swcjzJJltOxN+nZDSiffEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbeLcwMxDY4h4iz/KKH+/qJ/aDIsKHcGOAfDqIQ0oYiAa/wbyH
	4Cz10wdw23tEISXXCObxUaB0jykPXQKTShKWsTtb24A1rpOFXXNrLLRkV06roll+QAc4+SXTR71
	G1uPx0Wbiz+8xqsqj5V8RAyEGAOuO5MQu/jNX
X-Gm-Gg: ASbGncv6ZRaGtGb6dGsSsgFIE7swVB+1UNUgCuWhOZQNQJIgF9F8+SWP8JxzkIcRxj9
	Kmjm29rnVIzBKruhMZuG/0D74/yWHniQfTXcF31kq5zHuzsnYcjTuEz7yu0p5go+QVS6lz6gG3L
	NvHVfzavzUawLODgk4q7gaZ+DmTclzNPF//dtw11OsWDVUaJgj8ks6fTKVDOiaC1GWtX5Ku0GEr
	CCDA4hO22WKlmbVOpXDguA0v9k9U6lZXuln03InCwQrxuUK7ppdPRriApmuiXFJDU6J15gmoIxs
	Dbrj
X-Google-Smtp-Source: AGHT+IGBygbukpk6yduRHNozh26lUY1eqFn3jw+WTJaKmU8sdnCUFf/GONmfLjz9RpF1iPIA6SIUQM2yIzIvhwxifFM=
X-Received: by 2002:a05:6402:518a:b0:641:2a61:7da8 with SMTP id
 4fb4d7f45d1cf-64350e21ae8mr21299288a12.15.1763561961633; Wed, 19 Nov 2025
 06:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117181023.482138-2-linux.amoon@gmail.com> <20251118175010.GA2540980@bhelgaas>
In-Reply-To: <20251118175010.GA2540980@bhelgaas>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 19 Nov 2025 19:49:06 +0530
X-Gm-Features: AWmQ_bkeVnYjjZY7uh-tqm_7FCTPYOF6ZeL5xaIPxi_RSTSTk__wtl2eB_qRL6c
Message-ID: <CANAwSgRHuwoQjr95sXp-X97=L-X3vqUPxjR5=2jNtFZA+4gnwQ@mail.gmail.com>
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

Hi Bjorn / Shwan

Thanks for your review comments.

On Tue, 18 Nov 2025 at 23:20, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Nov 17, 2025 at 11:40:09PM +0530, Anand Moon wrote:
> > As per the RK3399 TRM (Part 2, 17.6.6.1.31), the Link Control register
> > (RC_CONFIG_LC) resides at an offset of 0xd0 within the Root Complex (RC)
> > configuration space, not at the offset of the PCI Express Capability List
> > (0xc0). Following changes correct the register offset to use
> > PCIE_RC_CONFIG_LC (0xd0) to configure link control.
> >
> > Additionally, this commit explicitly enables ASPM (Active State Power
> > Management) control and the CLKREQ# (Clock Request) mechanism as part of
> > the Link Control register programming when enabling bandwidth
> > notifications.
>
> Don't do two things at once in the same patch.  Fix the register
> offset in one patch.  Actually, as I mentioned at [1], there's a lot
> of fixing to do there, and I'm not even going to consider other
> changes until the #define mess is cleaned up.
>
Ok, got that.
> What I'd really like to see is at least two patches here: one that
> clearly makes no functional change -- don't try to fix anything, just
> make it 100% obvious that all the offsets stay the same.  Then make a
> separate patch that *only* changes any of the offsets that are wrong.
>
Ok, understood.
> I don't think there should even be an ASPM change.  The PCI core
> should be enabling L0s and L1 itself for DT systems like this.  And
> ASPM needs to be enabled only when both ends of the link support it,
> and only in a specific order.  The PCI core pays attention to that,
> but this patch does not.
>
Ok, I get it.

> Bjorn
>
> [1] https://lore.kernel.org/r/20251118005056.GA2541796@bhelgaas

According to the RK3399 Technical Reference Manual (TRM), and pci_regs.h
already includes the correct, pre-defined offsets for all PCI Express
device types
and their capabilities registers. To avoid overlapping register mappings,
we should explicitly remove the addition of manual offsets within the code.

Thanks
-Anand

Here is the example. Is this the correct approach?
---
 drivers/pci/controller/pcie-rockchip-host.c | 12 ++++++------
 drivers/pci/controller/pcie-rockchip.h      |  2 ++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c
b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..af438d59e788 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -32,18 +32,18 @@ static void rockchip_pcie_enable_bw_int(struct
rockchip_pcie *rockchip)
 {
        u32 status;

-       status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
PCI_EXP_LNKCTL);
+       status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC);
        status |= (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
-       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
PCI_EXP_LNKCTL);
+       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC);
 }

 static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
 {
        u32 status;

-       status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
PCI_EXP_LNKCTL);
+       status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC);
        status |= (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
-       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
PCI_EXP_LNKCTL);
+       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC);
 }

 static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
@@ -306,9 +306,9 @@ static int rockchip_pcie_host_init_port(struct
rockchip_pcie *rockchip)
        rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
PCI_EXP_LNKCTL);

        /* Set RC's RCB to 128 */
-       status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
PCI_EXP_LNKCTL);
+       status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC);
        status |= PCI_EXP_LNKCTL_RCB;
-       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
PCI_EXP_LNKCTL);
+       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC);

        /* Enable Gen1 training */
        rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
diff --git a/drivers/pci/controller/pcie-rockchip.h
b/drivers/pci/controller/pcie-rockchip.h
index 3e82a69b9c00..3313cd8c585f 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -157,6 +157,8 @@
 #define PCIE_EP_CONFIG_LCS             (PCIE_EP_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_RID_CCR         (PCIE_RC_CONFIG_BASE + 0x08)
 #define PCIE_RC_CONFIG_CR              (PCIE_RC_CONFIG_BASE + 0xc0)
+/* Link Control and Status Register */
+#define PCIE_RC_CONFIG_LC              (PCIE_RC_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP         (PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK     GENMASK(31, 20)

