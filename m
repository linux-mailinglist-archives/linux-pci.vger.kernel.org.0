Return-Path: <linux-pci+bounces-42107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF7C89530
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 11:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 670D0358954
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E607306481;
	Wed, 26 Nov 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrHDnhGj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E7315D4E
	for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153239; cv=none; b=fwIxQz2/zoI72HukXmfMrNmXRdNQucTVSRWPAstVrv49/Rv9RDlaWmwYXz+089MSVZar9gMRWh/Qg5aOVEXJZXmaj3rXs/ZNDp3noeO3FOK+OR6GMkqCmw4+rp1GC7nArKSK0tfumM0fMrFZFqNegjVRmBUf5yXwCuEzbWHb7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153239; c=relaxed/simple;
	bh=WzHpdFPlxTExe2y0u5Ku2NwBsP4MnYWpnL6PHjuFiec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rrs46LMofjPR3sC1WR0a5kT88NHIPlPhpAu5xpFUzkRpzzQRpYLKHs+CvLzizT/N97nhMnGC2wDofsngk8iBWSe7G61iB7J/5v1/OeyuyRZVMokV6i4BCKOXoKURiKxc+yGOZ71xxDvFb3s3SiukJJ7ItGCtBV7ClJ74c0o5+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrHDnhGj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so9260206a12.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 02:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764153233; x=1764758033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foQtgXluHgTEmm+M28mbH0G/ymfZYd9e4+/49QIlVd8=;
        b=OrHDnhGjFOPnsXKjz/mPNF7oqm1skxj8DH8EmPBbEcNwLOWEj7LsSKBnj3Qrd6A2tD
         6JYK9+IRNWEsrBg3tPEgzx9TDvK6Bgj5yk3fB2wt/uJ+00vCcaEO57/fMP7cNNGn9+bJ
         AZwJ/j78qqxDW8aApGxq3lxEF6ZuheERd78N3cb3jD6fJwLDu9mcffTKgtjsdFawTTLL
         ZaBY/H7ncU5i9VMDXhvxnVFrUCHqVOI6DF3Xvis9KBVwa4fVv5elHPOlu+j7kt1ZNH+d
         4Pc6ykPj+8kyKJAoXEuvjPX1cpHRDDTB8hYpsNVei9MulKdB+4gVscXTb8T0pgIecGp7
         HxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764153233; x=1764758033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=foQtgXluHgTEmm+M28mbH0G/ymfZYd9e4+/49QIlVd8=;
        b=ugj6S/AG9ifRwVFFSB66ELCmcGFzn1fr79ELCM5Y4nmFnLw51XlzA68Bu6+yeb0pxv
         lxLKWHN3nGxQ8JlpUzkBNubqw9vICxPlWuZh/AU65ZsB/EuA70AkRV1ChQyieTOQwhH/
         piC7j3JGHc9zlNxmdyxW7hjJn32mdkM2MKTpYF775o6POXG5zHd9ZgQCSLyCpEMIfBP9
         zyStCF1Z/maX0iymROvwQFX1bdBnM99nwL9DcTYUmmn9Gb9marl8JSbr+P+2OAgyKqjq
         dNNLrgMRQ8Q8pGWTbmxvuBrISnvvaXjgOH585gmSX76rcrFJR9+j+Lm22dTE3bWgXHRU
         8cbw==
X-Forwarded-Encrypted: i=1; AJvYcCVwgPv4AF6/nMsYlDBcV1uaqXWiWTDZ4mGWf4jYDNOipGfXzd57s7SAcAMJKeeSw7RNvI3P3S1iSpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVa+iDCx4XL0m+iziaU/cILd5huX0yA7Ph2W0vtmo3TUEnebLG
	py6ZXW7ZzPS/tDbtmIadl4k38WTXrDywDNGhdnE8GekWxk4xmLL3iibUhXKe1OBT5OgE86BSXSf
	rnfF8nTxbby77BNx6Tnh4D4M07b39zzc=
X-Gm-Gg: ASbGncuAQTPbBXh3Hkm8WFnlhkcEhUxkzk6d+S6DcRLXKCaVEAep6nZAvn9NZNpR6M/
	aCiXIwctn8AzB8chxXT0uRUkONiclb9thmeR1hkYhEnesJufZKCo7nAPw9vLM8NIhWRfDPSVTFe
	P+5xaWalvOksOXOxADE4MJHuNAyuog0bcjvnHgATwzpvxMeoBz2OgLIxdcIKTMq56xFFMPWoc8X
	lkCWGFPq6sTjYG0sMWs4mjGKiLAtcAeujadMDupZD7yFfiWiWGQze+K0gnwuk/6xLS4D55sCScG
	wJdA
X-Google-Smtp-Source: AGHT+IHwEpZIkU4ztpi99N+Agj881yof+tktEGMPxvRvRn22BHFyRowGIui+kGeAB8yZdBx1EeG9uRV3hFSv93scQ+I=
X-Received: by 2002:a05:6402:1476:b0:641:7a6b:c84b with SMTP id
 4fb4d7f45d1cf-6455469c4ccmr15889378a12.27.1764153233256; Wed, 26 Nov 2025
 02:33:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAwSgRHuwoQjr95sXp-X97=L-X3vqUPxjR5=2jNtFZA+4gnwQ@mail.gmail.com>
 <20251120034437.GA2625966@bhelgaas> <CANAwSgStRZW322X3H_B4wK5CthFube_4MBUBw=U1BRjyRGeu9g@mail.gmail.com>
In-Reply-To: <CANAwSgStRZW322X3H_B4wK5CthFube_4MBUBw=U1BRjyRGeu9g@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 26 Nov 2025 16:03:37 +0530
X-Gm-Features: AWmQ_blLxnf_4M31Oxa4iWUXkTj660l08seBmojzspPm2hBEwSqSc-XGST03jow
Message-ID: <CANAwSgQMfu2E+oR0Yi9siKA-PZJ_nyDVCQF=Ua7REHcMRDo0Fg@mail.gmail.com>
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

Hi All,

On Thu, 20 Nov 2025 at 19:28, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Bjorn,
>
> Thanks for your input.
>
> On Thu, 20 Nov 2025 at 09:14, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Nov 19, 2025 at 07:49:06PM +0530, Anand Moon wrote:
> > > On Tue, 18 Nov 2025 at 23:20, Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
> > > > On Mon, Nov 17, 2025 at 11:40:09PM +0530, Anand Moon wrote:
> > > > > As per the RK3399 TRM (Part 2, 17.6.6.1.31), the Link Control reg=
ister
> > > > > (RC_CONFIG_LC) resides at an offset of 0xd0 within the Root Compl=
ex (RC)
> > > > > configuration space, not at the offset of the PCI Express Capabil=
ity List
> > > > > (0xc0). Following changes correct the register offset to use
> > > > > PCIE_RC_CONFIG_LC (0xd0) to configure link control.
> > > ...
> >
> > > > Don't do two things at once in the same patch.  Fix the register
> > > > offset in one patch.  Actually, as I mentioned at [1], there's a lo=
t
> > > > of fixing to do there, and I'm not even going to consider other
> > > > changes until the #define mess is cleaned up.
> >
> > > > [1] https://lore.kernel.org/r/20251118005056.GA2541796@bhelgaas
> > >
> > > According to the RK3399 Technical Reference Manual (TRM), and pci_reg=
s.h
> > > already includes the correct, pre-defined offsets for all PCI Express
> > > device types
> > > and their capabilities registers. To avoid overlapping register mappi=
ngs,
> > > we should explicitly remove the addition of manual offsets within the=
 code.
> >
> > > Here is the example. Is this the correct approach?
> >
> > > -       status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> > > PCI_EXP_LNKCTL);
> > > +       status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC);
> > >         status |=3D (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> > > -       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> > > PCI_EXP_LNKCTL);
> > > +       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC);
> >
> > No.  The call should include PCI_EXP_LNKCTL because that's what we
> > grep for when we want to see where Link Control is updated.
> >
> > See my example from [1] above:
> >
> >   rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_DEVCAP)
> >   rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_LNKCTL)
> >
> > You should have a single #define for the offset of the PCIe
> > Capability, e.g., ROCKCHIP_RP_PCIE_CAP.  Every access to registers in
> > that capability would use ROCKCHIP_RP_PCIE_CAP and the relevant
> > PCI_EXP_* offset, e.g., PCI_EXP_DEVCAP, PCI_EXP_DEVCTL,
> > PCI_EXP_DEVSTA, PCI_EXP_LNKCAP, PCI_EXP_LNKCTL, PCI_EXP_LNKSTA, etc.
> >
> I apologize for not fully understanding the issue earlier. I did not
> carefully review your email,
>  which caused me to overlook the required changes.
>
> So, as per the TRM
>
> 17.6.4.5.1 PCI Express Capability List Register
> Propname=EF=BC=9APCI Express Capability List Register
> Address=EF=BC=9A@0xc0
>
> #define PCIE_EP_CONFIG_DID_VID          (PCIE_EP_CONFIG_BASE + 0x00)
> #define PCIE_EP_CONFIG_LCS              (PCIE_EP_CONFIG_BASE + 0xd0)
> #define PCIE_RC_CONFIG_RID_CCR          (PCIE_RC_CONFIG_BASE + 0x08)
> #define PCIE_RC_CONFIG_CR               (PCIE_RC_CONFIG_BASE + 0xc0)
> #define ROCKCHIP_RP_PCIE_CAP            (PCIE_RC_CONFIG_BASE + 0xc0)
> /* Link Control and Status Register */
> #define PCIE_RC_CONFIG_LC               (ROCKCHIP_RP_PCIE_CAP + 0xd0)
> /* Device Control */
> #define PCIE_RC_CONFIG_DC               (ROCKCHIP_RP_PCIE_CAP + 0xc8)
> /* Slot Capability Register */
> #define PCIE_RC_CONFIG_SC               (ROCKCHIP_RP_PCIE_CAP + 0xd4)
> /* Link Control 2 Register */
> #define PCIE_RC_CONFIG_LC2              (ROCKCHIP_RP_PCIE_CAP + 0xf0)
> /* Linkwidth Control Register */
> #define PCIE_RC_CONFIG_LWC              (ROCKCHIP_RP_PCIE_CAP + 0x50)
>
> And then use these like this.
>
> status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC + PCI_EXP_LNKCT=
L);
> status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DC + PCI_EXP_DEVCT=
L);
> status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_SC + PCI_EXP_DEVCA=
P);
> status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC2 + PCI_EXP_LNKC=
TL2);
> status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LWC + PCI_EXP_LNKC=
TL);
>
> If you agree that this approach correctly resolves the issue,
> I would prefer to confirm now to prevent further iterative changes
> that might confuse.
>
I was making some changes to the system when my device stopped working,
The lspci utility started crashing with a segmentation fault.

$ sudo lspci -vvv
[sudo] password for alarm:
Segmentation fault         sudo lspci -vvv

# dmesg logs

[   21.225526] rockchip-pm-domain
ff310000.power-management:power-controller: sync_state() pending due
to ff660000.video-codec
[   34.935331] Internal error: synchronous external abort:
0000000096000210 [#1]  SMP
[   34.936027] Modules linked in: 8021q garp mrp stp llc af_alg
brcmfmac_wcc snd_soc_hdmi_codec hantro_vpu dw_hdmi_i2s_audio
dw_hdmi_cec rockchip_rga hci_uart v4l2_vp9 rockchipdrm brcmfmac
brcmutil btqca dw_hdmi_qp snd_soc_simple_card nvme v4l2_h264
snd_soc_audio_graph_card analogix_dp videobuf2_dma_sg v4l2_jpeg
snd_soc_es8316 btbcm snd_soc_simple_card_utils dw_mipi_dsi nvme_core
snd_soc_spdif_tx snd_soc_rockchip_i2s videobuf2_dma_contig
v4l2_mem2mem drm_dp_aux_bus bluetooth snd_soc_core dw_hdmi
videobuf2_memops drm_display_helper panfrost videobuf2_v4l2
snd_compress dwmac_rk videodev ecdh_generic cec snd_pcm_dmaengine
drm_shmem_helper ax88179_178a stmmac_platform drm_client_lib snd_pcm
ecc gpu_sched drm_dma_helper videobuf2_common usbnet rockchip_saradc
stmmac drm_kms_helper pwrseq_core snd_timer reset_gpio
phy_rockchip_pcie mc industrialio_triggered_buffer snd rockchip_dfi
rockchip_thermal coresight_cpu_debug soundcore rtc_rk808 kfifo_buf
pcs_xpcs coresight pcie_rockchip_host sha256 cfg80211 rfkill drm fuse
backlight
[   34.936326]  dm_mod ipv6
[   34.944344] CPU: 1 UID: 0 PID: 796 Comm: lspci Tainted: G   M
         6.18.0-rc7-dirty #1 PREEMPT
[   34.945187] Tainted: [M]=3DMACHINE_CHECK
[   34.945518] Hardware name: Radxa ROCK Pi 4B+ (DT)
[   34.945932] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   34.946545] pc : rockchip_pcie_rd_conf+0x178/0x27c [pcie_rockchip_host]
[   34.947138] lr : rockchip_pcie_rd_conf+0x170/0x27c [pcie_rockchip_host]
[   34.947722] sp : ffff8000848b3bc0
[   34.948015] x29: ffff8000848b3bc0 x28: ffff0000013e30c0 x27: 00000000000=
00000
[   34.948652] x26: 000000000000000f x25: ffff0000013e30c0 x24: 00000000000=
00040
[   34.949287] x23: 0000000000000040 x22: ffff8000848b3c44 x21: ffff8000848=
b3bf4
[   34.949920] x20: ffff800082100000 x19: 0000000000000004 x18: 00000000000=
00000
[   34.950555] x17: 0000000000000000 x16: ffffc37c34322808 x15: 00000000000=
00000
[   34.951188] x14: 0000000000000000 x13: 0000000000000000 x12: 00000000000=
00000
[   34.951821] x11: 0000000000000000 x10: 0000000000000000 x9 : 00000000000=
00000
[   34.952454] x8 : 0000000000000000 x7 : ffff0000084093c0 x6 : ffff000009c=
d7000
[   34.953087] x5 : ffff000009cd7800 x4 : ffff800085000000 x3 : 0000000000c=
00008
[   34.953722] x2 : 000000000080000a x1 : ffff800085c00008 x0 : ffff800085c=
0000c
[   34.954356] Call trace:
[   34.954576]  rockchip_pcie_rd_conf+0x178/0x27c [pcie_rockchip_host] (P)
[   34.955164]  pci_user_read_config_dword+0x7c/0x120
[   34.955598]  pci_read_config+0xe4/0x2a0
[   34.955944]  sysfs_kf_bin_read+0x7c/0xbc
[   34.956298]  kernfs_fop_read_iter+0xb0/0x1bc
[   34.956679]  vfs_read+0x230/0x320
[   34.956981]  __arm64_sys_pread64+0xac/0xd4
[   34.957350]  invoke_syscall+0x48/0x10c
[   34.957691]  el0_svc_common.constprop.0+0x40/0xe0
[   34.958113]  do_el0_svc+0x1c/0x28
[   34.958414]  el0_svc+0x34/0xec
[   34.958694]  el0t_64_sync_handler+0xa0/0xe4
[   34.959070]  el0t_64_sync+0x198/0x19c
[   34.959405] Code: 52800141 940000ae 7100127f 54fff801 (b9400294)
[   34.959940] ---[ end trace 0000000000000000 ]---
[   34.960349] note: lspci[796] exited with irqs disabled
[   34.960879] note: lspci[796] exited with preempt_count 1

Either I am doing something wrong, or it's broken; I am not getting
this to work.

Upon further investigation, the issue was narrowed down to a specific
modification
that I made locally,

According to section 17.6.6.1.32 of the manual, the Power Limit Value
and Power Limit Scale fields
are part of the Slot Capability Register, not the Device Capability Registe=
r.

This assumption led to the segmentation fault because the code was attempti=
ng to
access invalid memory addresses.

Do you think these are valid changes? Because this change caused a
freeze on the NVMe device.

$ git  diff drivers/pci/controller/pcie-rockchip-host.c
diff --git a/drivers/pci/controller/pcie-rockchip-host.c
b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..743a04e36a1c 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -270,10 +270,10 @@ static void rockchip_pcie_set_power_limit(struct
rockchip_pcie *rockchip)
                power =3D power / 10;
        }

-       status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
PCI_EXP_DEVCAP);
+       status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
PCI_EXP_SLTCAP);
        status |=3D FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
        status |=3D FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);
-       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
PCI_EXP_DEVCAP);
+       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
PCI_EXP_SLTCAP);
 }

Thanks
-Anand

