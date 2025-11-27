Return-Path: <linux-pci+bounces-42186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CA5C8D203
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 08:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9FA74E1474
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A9030EF75;
	Thu, 27 Nov 2025 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SseIs4Ty"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492CB2D948A
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228904; cv=none; b=BHWGePsRBsBUJu/8fneWn8l4ypa+rdg01aT7OQ3EXDniJJ1hKW6n+X2fg0FR36WNZolESMWwo4VXvEq6xtTR820a6Exhw9nusG6i5VlabGS7bnQpuGFPEkeKOmStWvNCfughEbbDmJqYNf/yEmyIdtDVyRsvQ4WRJTdJZ8dws+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228904; c=relaxed/simple;
	bh=YVjEenEWu4vQqKVFjDIxbzUHKcu0vhIMJbc1t2Su/Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qzeb1dNyH3+FmlWOeZx9ESrCGEQTMVRi/FZiNY2rR8QGt5um457A5U85g5Un1z3ebMNoavaQ/+uVwDoZu39AfnSGLmm9AxbTiNTftWry2PpIjjRfpttQE88ze9eGL8ois9p0v8C/pPOpcy6Vjj8kP645bbByffdfbXAzkC/z0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SseIs4Ty; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso1072408a12.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2025 23:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764228901; x=1764833701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOc8bVioEDPsVhFAy/alXJwNTsAwy2i0T4WmLxaiMdg=;
        b=SseIs4Tym0gLZo1vO37Hk5E6R7NFOAKOPSQUGzHrCco0XAAIVU4MCYCix3aDJQFs04
         eNBJF7dGveHVPWJRPsfbBahp3C4IlXUtJsBTYeLtgKGwOLWHA8UB1CmXDaf9CKCH26j1
         fXO5G/RLpLnZxVvLYOIJVdB2PNOB0sB18wHLSJsNXfrRBFo1NIb5L13lycknwbMEH1dB
         C5a1XPfYoXYoEs8v40uSvF0MFzY+XGD/8y/mKKiK1jI4jPA1dd0qt4u2+vlwRJOKtLdb
         2+4CrWrC7+fXSl9Rlv7hLF0v+twsdI5TXDiiy/9GpsdasmjOWFZSpXYTN/Vn0ZpvIUMH
         NHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764228901; x=1764833701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XOc8bVioEDPsVhFAy/alXJwNTsAwy2i0T4WmLxaiMdg=;
        b=vh1PiJN9NMraKuv9lbm789Dq3Z9a9Ww1944po0JNJL8T/daT/caTmyH3jG0OHGy4kN
         Gbg/ThWSM/OtaBnXz7/oGrSIdCuh65sGBbi5GgfqyJlVCpT6zBvM4m4pzdNI3Ygah27w
         lAbrhOnBta9yJTcHuiZs7qsT2eV5XnTFpL+z4Sfpf+VevNvLr7v42mYxEY2GzzzyxhXE
         sMverBKNLgE10mQL+TX0CUen9N6KRAZZhjjR8YAsDD+Ek4WX5h3jThZiq+wLb7Eu40xy
         5G8nfynlhL+tFfXh2OIWIi6qFMgP7V2Kshph+uJdUn9/wqbDzFnBw/Vy0g+PpH8/5D1U
         ni6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUl9apFS5S7dbeOmfTjS+lhqHYkc2ubJvZkJerpe8J/TsbYWkbPk4FYg+NIsSTy4C5NUwFuvc6b04E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbdoGwiHghqHOhy2Z8bXvg/nD7C/R4tddEJp9yQrW0+/ZtiBW
	FblUiVe3nu0vYzDgqa4n6tM+r9JuTmEWTVTZInIyygQTKIytf5oLi1NnHqLsAiEmn4x5Eysjzfb
	Fv+1vXCapbKbEWMMzI3LyTYAy4v+ws68=
X-Gm-Gg: ASbGncspV7Z/ua054vGj5qHDqCp/9MogZcJQt71+0J7oejzPlje+1kmVnVb69DIFILX
	uVqeudoGyGwzWlYp8o5SeNBpvX7AvUWFsQB1DkbfcH+I2HesRxvHJlLCN0KDuaz3DZTsFeFCmvt
	zoZqYapUTa2qDWmMHHFu3SF81wUjHYa58ORRAL4DA8DJiE07l6rnXTZSYtuK/IaUNwg1PS79yjo
	xbGJzNNp/AdBvOqBcDIHf1EpMLYo09/5zgw2NsjqKLnuubgPDr57kETXwgKTo9Fn9uTHQ==
X-Google-Smtp-Source: AGHT+IHPOdeEMfBR+WUymRANlVKWQFD7we577I8F5uQbbI9f0bbvODN9M5xLEdi2So3tYYmoaTQ3zhRnhIWC0ZXqayM=
X-Received: by 2002:a05:6402:42ca:b0:640:b373:205e with SMTP id
 4fb4d7f45d1cf-64554469ef2mr21373139a12.15.1764228900401; Wed, 26 Nov 2025
 23:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAwSgQMfu2E+oR0Yi9siKA-PZJ_nyDVCQF=Ua7REHcMRDo0Fg@mail.gmail.com>
 <20251126143952.GA2825566@bhelgaas>
In-Reply-To: <20251126143952.GA2825566@bhelgaas>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 27 Nov 2025 13:04:45 +0530
X-Gm-Features: AWmQ_bl6018YzrW-RoUh_-4bnsXeEE3J6hS-F7UW4_fWWC9nmEJAWat50gR65GI
Message-ID: <CANAwSgSGnSNUr5bKRimBs+aAi6XdvMJxB8Oc=z4Tz-5eLA+twA@mail.gmail.com>
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

Hi Bjorn

On Wed, 26 Nov 2025 at 20:09, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Nov 26, 2025 at 04:03:37PM +0530, Anand Moon wrote:
> > On Thu, 20 Nov 2025 at 19:28, Anand Moon <linux.amoon@gmail.com> wrote:
> > > On Thu, 20 Nov 2025 at 09:14, Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
> > > > On Wed, Nov 19, 2025 at 07:49:06PM +0530, Anand Moon wrote:
> > > > > On Tue, 18 Nov 2025 at 23:20, Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> > > > > > On Mon, Nov 17, 2025 at 11:40:09PM +0530, Anand Moon wrote:
> > > > > > > As per the RK3399 TRM (Part 2, 17.6.6.1.31), the Link Control=
 register
> > > > > > > (RC_CONFIG_LC) resides at an offset of 0xd0 within the Root C=
omplex (RC)
> > > > > > > configuration space, not at the offset of the PCI Express Cap=
ability List
> > > > > > > (0xc0). Following changes correct the register offset to use
> > > > > > > PCIE_RC_CONFIG_LC (0xd0) to configure link control.
> > > > > ...
> > > >
> > > > > > Don't do two things at once in the same patch.  Fix the registe=
r
> > > > > > offset in one patch.  Actually, as I mentioned at [1], there's =
a lot
> > > > > > of fixing to do there, and I'm not even going to consider other
> > > > > > changes until the #define mess is cleaned up.
> > > >
> > > > > > [1] https://lore.kernel.org/r/20251118005056.GA2541796@bhelgaas
> > > > >
> > > > > According to the RK3399 Technical Reference Manual (TRM), and pci=
_regs.h
> > > > > already includes the correct, pre-defined offsets for all PCI Exp=
ress
> > > > > device types
> > > > > and their capabilities registers. To avoid overlapping register m=
appings,
> > > > > we should explicitly remove the addition of manual offsets within=
 the code.
> > > >
> > > > > Here is the example. Is this the correct approach?
> > > >
> > > > > -       status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR=
 +
> > > > > PCI_EXP_LNKCTL);
> > > > > +       status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC=
);
> > > > >         status |=3D (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE)=
;
> > > > > -       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> > > > > PCI_EXP_LNKCTL);
> > > > > +       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC);
> > > >
> > > > No.  The call should include PCI_EXP_LNKCTL because that's what we
> > > > grep for when we want to see where Link Control is updated.
> > > >
> > > > See my example from [1] above:
> > > >
> > > >   rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_DEVCA=
P)
> > > >   rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_LNKCT=
L)
> > > >
> > > > You should have a single #define for the offset of the PCIe
> > > > Capability, e.g., ROCKCHIP_RP_PCIE_CAP.  Every access to registers =
in
> > > > that capability would use ROCKCHIP_RP_PCIE_CAP and the relevant
> > > > PCI_EXP_* offset, e.g., PCI_EXP_DEVCAP, PCI_EXP_DEVCTL,
> > > > PCI_EXP_DEVSTA, PCI_EXP_LNKCAP, PCI_EXP_LNKCTL, PCI_EXP_LNKSTA, etc=
.
> > > >
> > > I apologize for not fully understanding the issue earlier. I did not
> > > carefully review your email,
> > >  which caused me to overlook the required changes.
> > >
> > > So, as per the TRM
> > >
> > > 17.6.4.5.1 PCI Express Capability List Register
> > > Propname=EF=BC=9APCI Express Capability List Register
> > > Address=EF=BC=9A@0xc0
> > >
> > > #define PCIE_EP_CONFIG_DID_VID          (PCIE_EP_CONFIG_BASE + 0x00)
> > > #define PCIE_EP_CONFIG_LCS              (PCIE_EP_CONFIG_BASE + 0xd0)
> > > #define PCIE_RC_CONFIG_RID_CCR          (PCIE_RC_CONFIG_BASE + 0x08)
> > > #define PCIE_RC_CONFIG_CR               (PCIE_RC_CONFIG_BASE + 0xc0)
> > > #define ROCKCHIP_RP_PCIE_CAP            (PCIE_RC_CONFIG_BASE + 0xc0)
> > > /* Link Control and Status Register */
> > > #define PCIE_RC_CONFIG_LC               (ROCKCHIP_RP_PCIE_CAP + 0xd0)
> > > /* Device Control */
> > > #define PCIE_RC_CONFIG_DC               (ROCKCHIP_RP_PCIE_CAP + 0xc8)
> > > /* Slot Capability Register */
> > > #define PCIE_RC_CONFIG_SC               (ROCKCHIP_RP_PCIE_CAP + 0xd4)
> > > /* Link Control 2 Register */
> > > #define PCIE_RC_CONFIG_LC2              (ROCKCHIP_RP_PCIE_CAP + 0xf0)
> > > /* Linkwidth Control Register */
> > > #define PCIE_RC_CONFIG_LWC              (ROCKCHIP_RP_PCIE_CAP + 0x50)
> > >
> > > And then use these like this.
> > >
> > > status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC + PCI_EXP_L=
NKCTL);
> > > status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DC + PCI_EXP_D=
EVCTL);
> > > status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_SC + PCI_EXP_D=
EVCAP);
> > > status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC2 + PCI_EXP_=
LNKCTL2);
> > > status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LWC + PCI_EXP_=
LNKCTL);
> > >
> > > If you agree that this approach correctly resolves the issue,
> > > I would prefer to confirm now to prevent further iterative changes
> > > that might confuse.
> > >
> > I was making some changes to the system when my device stopped working,
> > The lspci utility started crashing with a segmentation fault.
> >
> > $ sudo lspci -vvv
> > [sudo] password for alarm:
> > Segmentation fault         sudo lspci -vvv
> >
> > # dmesg logs
> >
> > [   21.225526] rockchip-pm-domain
> > ff310000.power-management:power-controller: sync_state() pending due
> > to ff660000.video-codec
> > [   34.935331] Internal error: synchronous external abort:
> > 0000000096000210 [#1]  SMP
> > [   34.936027] Modules linked in: 8021q garp mrp stp llc af_alg
> > brcmfmac_wcc snd_soc_hdmi_codec hantro_vpu dw_hdmi_i2s_audio
> > dw_hdmi_cec rockchip_rga hci_uart v4l2_vp9 rockchipdrm brcmfmac
> > brcmutil btqca dw_hdmi_qp snd_soc_simple_card nvme v4l2_h264
> > snd_soc_audio_graph_card analogix_dp videobuf2_dma_sg v4l2_jpeg
> > snd_soc_es8316 btbcm snd_soc_simple_card_utils dw_mipi_dsi nvme_core
> > snd_soc_spdif_tx snd_soc_rockchip_i2s videobuf2_dma_contig
> > v4l2_mem2mem drm_dp_aux_bus bluetooth snd_soc_core dw_hdmi
> > videobuf2_memops drm_display_helper panfrost videobuf2_v4l2
> > snd_compress dwmac_rk videodev ecdh_generic cec snd_pcm_dmaengine
> > drm_shmem_helper ax88179_178a stmmac_platform drm_client_lib snd_pcm
> > ecc gpu_sched drm_dma_helper videobuf2_common usbnet rockchip_saradc
> > stmmac drm_kms_helper pwrseq_core snd_timer reset_gpio
> > phy_rockchip_pcie mc industrialio_triggered_buffer snd rockchip_dfi
> > rockchip_thermal coresight_cpu_debug soundcore rtc_rk808 kfifo_buf
> > pcs_xpcs coresight pcie_rockchip_host sha256 cfg80211 rfkill drm fuse
> > backlight
> > [   34.936326]  dm_mod ipv6
> > [   34.944344] CPU: 1 UID: 0 PID: 796 Comm: lspci Tainted: G   M
> >          6.18.0-rc7-dirty #1 PREEMPT
> > [   34.945187] Tainted: [M]=3DMACHINE_CHECK
> > [   34.945518] Hardware name: Radxa ROCK Pi 4B+ (DT)
> > [   34.945932] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [   34.946545] pc : rockchip_pcie_rd_conf+0x178/0x27c [pcie_rockchip_ho=
st]
> > [   34.947138] lr : rockchip_pcie_rd_conf+0x170/0x27c [pcie_rockchip_ho=
st]
> > [   34.947722] sp : ffff8000848b3bc0
> > [   34.948015] x29: ffff8000848b3bc0 x28: ffff0000013e30c0 x27: 0000000=
000000000
> > [   34.948652] x26: 000000000000000f x25: ffff0000013e30c0 x24: 0000000=
000000040
> > [   34.949287] x23: 0000000000000040 x22: ffff8000848b3c44 x21: ffff800=
0848b3bf4
> > [   34.949920] x20: ffff800082100000 x19: 0000000000000004 x18: 0000000=
000000000
> > [   34.950555] x17: 0000000000000000 x16: ffffc37c34322808 x15: 0000000=
000000000
> > [   34.951188] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000=
000000000
> > [   34.951821] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000=
000000000
> > [   34.952454] x8 : 0000000000000000 x7 : ffff0000084093c0 x6 : ffff000=
009cd7000
> > [   34.953087] x5 : ffff000009cd7800 x4 : ffff800085000000 x3 : 0000000=
000c00008
> > [   34.953722] x2 : 000000000080000a x1 : ffff800085c00008 x0 : ffff800=
085c0000c
> > [   34.954356] Call trace:
> > [   34.954576]  rockchip_pcie_rd_conf+0x178/0x27c [pcie_rockchip_host] =
(P)
> > [   34.955164]  pci_user_read_config_dword+0x7c/0x120
> > [   34.955598]  pci_read_config+0xe4/0x2a0
> > [   34.955944]  sysfs_kf_bin_read+0x7c/0xbc
> > [   34.956298]  kernfs_fop_read_iter+0xb0/0x1bc
> > [   34.956679]  vfs_read+0x230/0x320
> > [   34.956981]  __arm64_sys_pread64+0xac/0xd4
> > [   34.957350]  invoke_syscall+0x48/0x10c
> > [   34.957691]  el0_svc_common.constprop.0+0x40/0xe0
> > [   34.958113]  do_el0_svc+0x1c/0x28
> > [   34.958414]  el0_svc+0x34/0xec
> > [   34.958694]  el0t_64_sync_handler+0xa0/0xe4
> > [   34.959070]  el0t_64_sync+0x198/0x19c
> > [   34.959405] Code: 52800141 940000ae 7100127f 54fff801 (b9400294)
> > [   34.959940] ---[ end trace 0000000000000000 ]---
> > [   34.960349] note: lspci[796] exited with irqs disabled
> > [   34.960879] note: lspci[796] exited with preempt_count 1
> >
> > Either I am doing something wrong, or it's broken; I am not getting
> > this to work.
> >
> > Upon further investigation, the issue was narrowed down to a
> > specific modification that I made locally,
> >
> > According to section 17.6.6.1.32 of the manual, the Power Limit
> > Value and Power Limit Scale fields are part of the Slot Capability
> > Register, not the Device Capability Register.
> >
> > This assumption led to the segmentation fault because the code was
> > attempting to access invalid memory addresses.
> >
> > Do you think these are valid changes? Because this change caused a
> > freeze on the NVMe device.
>
> I'm not surprised that there might be issues related to registers in
> the PCIe Capability.  I'm actually surprised that this driver works at
> all, given the incredible mess.
>
> So I'm not going to bother trying to fix this piecemeal as with the
> patch below.  Every single access to DEVCAP/DEVCTL/DEVSTA,
> SLTCAP/SLTCTL/SLTSTA, etc needs to be made rational.  There's a single
> base address that works for all of them because the Rockchip register
> layout matches the PCIe Capability layout.  I've already outlined in
> detail what needs to be done.  I'll try to find time to actually
> implement this, but it probably won't be for at least a few days.
>

Alright, I'll wait for your update. I need to test some code changes.

Thanks
-Anand

