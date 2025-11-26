Return-Path: <linux-pci+bounces-42122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961C1C8A60D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B503A87FB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA9A302170;
	Wed, 26 Nov 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuEu2g8y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D6258CDC;
	Wed, 26 Nov 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167994; cv=none; b=W7fssO2B+tehO0V6pC79c6vR6j5twT+LeZh0f+kkvz10Kf1twqKWGu3lhQWWXs60jedjN0SWIWl4Qsjhen2M+zT6V0LDWQQUSJVRyh44AgBzFiw7KLVJ3c2vV5SS3EfrmMLvrPhrcoEVeusK6/7OPetLr/qEMvpvgGPtzcICX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167994; c=relaxed/simple;
	bh=Zr1qnmu/85/P0pQgfng0K/iBwkDRdkdh/KBRgYo3Rf0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=vEaybM7y6d3t/FBM5V565KBiGrVkwgRPDkeYVWaJs8VPWdxDU2exnFm4GgPvYbtgx+kak6te18CLxJMqUr3mGhmDUfdzR9h9y7NpxEDs9wuRGQy0Wnbvd13hF4Jm1PONfsl2i95U7lxm3tGjfrOPMvW0wb1o9EUlpYyROVRmI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuEu2g8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAF9C4CEF7;
	Wed, 26 Nov 2025 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764167993;
	bh=Zr1qnmu/85/P0pQgfng0K/iBwkDRdkdh/KBRgYo3Rf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LuEu2g8ywuzBYGtj5vJ7lyA/1MQltBVzvnUMBXjUer1VBT1VTX98llQivPJ7THuaY
	 Y1NmutF95LrFAoUH7JUl05Gr4LFR7R+P7ddzxUzDqKVdN2a5ujoX/zQD68HUkCiFK1
	 VPyO3pKrzpZvZc1704GoLRI5sKdR5mcAb2zqIKWGzrCPFcDd3CFE5cB9eEYIRUXNMQ
	 9ramDQaoG5s+IPrvPvF79osOwqmsJCso+++HDt7YnWG95yaFNW35wHaKcso/Wx8El9
	 dgCy4d6AXbsqLfxH0+JN4/9mm6nk08jkpobMscEXMsq7Jo3Z3lQD+ccQjcKA+lnMeF
	 Pk5ygyPcpvbJg==
Date: Wed, 26 Nov 2025 08:39:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v1 1/5] PCI: rockchip: Fix Link Control register offset and
 enable ASPM/CLKREQ
Message-ID: <20251126143952.GA2825566@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgQMfu2E+oR0Yi9siKA-PZJ_nyDVCQF=Ua7REHcMRDo0Fg@mail.gmail.com>

On Wed, Nov 26, 2025 at 04:03:37PM +0530, Anand Moon wrote:
> On Thu, 20 Nov 2025 at 19:28, Anand Moon <linux.amoon@gmail.com> wrote:
> > On Thu, 20 Nov 2025 at 09:14, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Nov 19, 2025 at 07:49:06PM +0530, Anand Moon wrote:
> > > > On Tue, 18 Nov 2025 at 23:20, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Mon, Nov 17, 2025 at 11:40:09PM +0530, Anand Moon wrote:
> > > > > > As per the RK3399 TRM (Part 2, 17.6.6.1.31), the Link Control register
> > > > > > (RC_CONFIG_LC) resides at an offset of 0xd0 within the Root Complex (RC)
> > > > > > configuration space, not at the offset of the PCI Express Capability List
> > > > > > (0xc0). Following changes correct the register offset to use
> > > > > > PCIE_RC_CONFIG_LC (0xd0) to configure link control.
> > > > ...
> > >
> > > > > Don't do two things at once in the same patch.  Fix the register
> > > > > offset in one patch.  Actually, as I mentioned at [1], there's a lot
> > > > > of fixing to do there, and I'm not even going to consider other
> > > > > changes until the #define mess is cleaned up.
> > >
> > > > > [1] https://lore.kernel.org/r/20251118005056.GA2541796@bhelgaas
> > > >
> > > > According to the RK3399 Technical Reference Manual (TRM), and pci_regs.h
> > > > already includes the correct, pre-defined offsets for all PCI Express
> > > > device types
> > > > and their capabilities registers. To avoid overlapping register mappings,
> > > > we should explicitly remove the addition of manual offsets within the code.
> > >
> > > > Here is the example. Is this the correct approach?
> > >
> > > > -       status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> > > > PCI_EXP_LNKCTL);
> > > > +       status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC);
> > > >         status |= (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> > > > -       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> > > > PCI_EXP_LNKCTL);
> > > > +       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LC);
> > >
> > > No.  The call should include PCI_EXP_LNKCTL because that's what we
> > > grep for when we want to see where Link Control is updated.
> > >
> > > See my example from [1] above:
> > >
> > >   rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_DEVCAP)
> > >   rockchip_pcie_read(rockchip, ROCKCHIP_RP_PCIE_CAP + PCI_EXP_LNKCTL)
> > >
> > > You should have a single #define for the offset of the PCIe
> > > Capability, e.g., ROCKCHIP_RP_PCIE_CAP.  Every access to registers in
> > > that capability would use ROCKCHIP_RP_PCIE_CAP and the relevant
> > > PCI_EXP_* offset, e.g., PCI_EXP_DEVCAP, PCI_EXP_DEVCTL,
> > > PCI_EXP_DEVSTA, PCI_EXP_LNKCAP, PCI_EXP_LNKCTL, PCI_EXP_LNKSTA, etc.
> > >
> > I apologize for not fully understanding the issue earlier. I did not
> > carefully review your email,
> >  which caused me to overlook the required changes.
> >
> > So, as per the TRM
> >
> > 17.6.4.5.1 PCI Express Capability List Register
> > Propname：PCI Express Capability List Register
> > Address：@0xc0
> >
> > #define PCIE_EP_CONFIG_DID_VID          (PCIE_EP_CONFIG_BASE + 0x00)
> > #define PCIE_EP_CONFIG_LCS              (PCIE_EP_CONFIG_BASE + 0xd0)
> > #define PCIE_RC_CONFIG_RID_CCR          (PCIE_RC_CONFIG_BASE + 0x08)
> > #define PCIE_RC_CONFIG_CR               (PCIE_RC_CONFIG_BASE + 0xc0)
> > #define ROCKCHIP_RP_PCIE_CAP            (PCIE_RC_CONFIG_BASE + 0xc0)
> > /* Link Control and Status Register */
> > #define PCIE_RC_CONFIG_LC               (ROCKCHIP_RP_PCIE_CAP + 0xd0)
> > /* Device Control */
> > #define PCIE_RC_CONFIG_DC               (ROCKCHIP_RP_PCIE_CAP + 0xc8)
> > /* Slot Capability Register */
> > #define PCIE_RC_CONFIG_SC               (ROCKCHIP_RP_PCIE_CAP + 0xd4)
> > /* Link Control 2 Register */
> > #define PCIE_RC_CONFIG_LC2              (ROCKCHIP_RP_PCIE_CAP + 0xf0)
> > /* Linkwidth Control Register */
> > #define PCIE_RC_CONFIG_LWC              (ROCKCHIP_RP_PCIE_CAP + 0x50)
> >
> > And then use these like this.
> >
> > status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC + PCI_EXP_LNKCTL);
> > status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DC + PCI_EXP_DEVCTL);
> > status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_SC + PCI_EXP_DEVCAP);
> > status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LC2 + PCI_EXP_LNKCTL2);
> > status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LWC + PCI_EXP_LNKCTL);
> >
> > If you agree that this approach correctly resolves the issue,
> > I would prefer to confirm now to prevent further iterative changes
> > that might confuse.
> >
> I was making some changes to the system when my device stopped working,
> The lspci utility started crashing with a segmentation fault.
> 
> $ sudo lspci -vvv
> [sudo] password for alarm:
> Segmentation fault         sudo lspci -vvv
> 
> # dmesg logs
> 
> [   21.225526] rockchip-pm-domain
> ff310000.power-management:power-controller: sync_state() pending due
> to ff660000.video-codec
> [   34.935331] Internal error: synchronous external abort:
> 0000000096000210 [#1]  SMP
> [   34.936027] Modules linked in: 8021q garp mrp stp llc af_alg
> brcmfmac_wcc snd_soc_hdmi_codec hantro_vpu dw_hdmi_i2s_audio
> dw_hdmi_cec rockchip_rga hci_uart v4l2_vp9 rockchipdrm brcmfmac
> brcmutil btqca dw_hdmi_qp snd_soc_simple_card nvme v4l2_h264
> snd_soc_audio_graph_card analogix_dp videobuf2_dma_sg v4l2_jpeg
> snd_soc_es8316 btbcm snd_soc_simple_card_utils dw_mipi_dsi nvme_core
> snd_soc_spdif_tx snd_soc_rockchip_i2s videobuf2_dma_contig
> v4l2_mem2mem drm_dp_aux_bus bluetooth snd_soc_core dw_hdmi
> videobuf2_memops drm_display_helper panfrost videobuf2_v4l2
> snd_compress dwmac_rk videodev ecdh_generic cec snd_pcm_dmaengine
> drm_shmem_helper ax88179_178a stmmac_platform drm_client_lib snd_pcm
> ecc gpu_sched drm_dma_helper videobuf2_common usbnet rockchip_saradc
> stmmac drm_kms_helper pwrseq_core snd_timer reset_gpio
> phy_rockchip_pcie mc industrialio_triggered_buffer snd rockchip_dfi
> rockchip_thermal coresight_cpu_debug soundcore rtc_rk808 kfifo_buf
> pcs_xpcs coresight pcie_rockchip_host sha256 cfg80211 rfkill drm fuse
> backlight
> [   34.936326]  dm_mod ipv6
> [   34.944344] CPU: 1 UID: 0 PID: 796 Comm: lspci Tainted: G   M
>          6.18.0-rc7-dirty #1 PREEMPT
> [   34.945187] Tainted: [M]=MACHINE_CHECK
> [   34.945518] Hardware name: Radxa ROCK Pi 4B+ (DT)
> [   34.945932] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   34.946545] pc : rockchip_pcie_rd_conf+0x178/0x27c [pcie_rockchip_host]
> [   34.947138] lr : rockchip_pcie_rd_conf+0x170/0x27c [pcie_rockchip_host]
> [   34.947722] sp : ffff8000848b3bc0
> [   34.948015] x29: ffff8000848b3bc0 x28: ffff0000013e30c0 x27: 0000000000000000
> [   34.948652] x26: 000000000000000f x25: ffff0000013e30c0 x24: 0000000000000040
> [   34.949287] x23: 0000000000000040 x22: ffff8000848b3c44 x21: ffff8000848b3bf4
> [   34.949920] x20: ffff800082100000 x19: 0000000000000004 x18: 0000000000000000
> [   34.950555] x17: 0000000000000000 x16: ffffc37c34322808 x15: 0000000000000000
> [   34.951188] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [   34.951821] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> [   34.952454] x8 : 0000000000000000 x7 : ffff0000084093c0 x6 : ffff000009cd7000
> [   34.953087] x5 : ffff000009cd7800 x4 : ffff800085000000 x3 : 0000000000c00008
> [   34.953722] x2 : 000000000080000a x1 : ffff800085c00008 x0 : ffff800085c0000c
> [   34.954356] Call trace:
> [   34.954576]  rockchip_pcie_rd_conf+0x178/0x27c [pcie_rockchip_host] (P)
> [   34.955164]  pci_user_read_config_dword+0x7c/0x120
> [   34.955598]  pci_read_config+0xe4/0x2a0
> [   34.955944]  sysfs_kf_bin_read+0x7c/0xbc
> [   34.956298]  kernfs_fop_read_iter+0xb0/0x1bc
> [   34.956679]  vfs_read+0x230/0x320
> [   34.956981]  __arm64_sys_pread64+0xac/0xd4
> [   34.957350]  invoke_syscall+0x48/0x10c
> [   34.957691]  el0_svc_common.constprop.0+0x40/0xe0
> [   34.958113]  do_el0_svc+0x1c/0x28
> [   34.958414]  el0_svc+0x34/0xec
> [   34.958694]  el0t_64_sync_handler+0xa0/0xe4
> [   34.959070]  el0t_64_sync+0x198/0x19c
> [   34.959405] Code: 52800141 940000ae 7100127f 54fff801 (b9400294)
> [   34.959940] ---[ end trace 0000000000000000 ]---
> [   34.960349] note: lspci[796] exited with irqs disabled
> [   34.960879] note: lspci[796] exited with preempt_count 1
> 
> Either I am doing something wrong, or it's broken; I am not getting
> this to work.
> 
> Upon further investigation, the issue was narrowed down to a
> specific modification that I made locally,
> 
> According to section 17.6.6.1.32 of the manual, the Power Limit
> Value and Power Limit Scale fields are part of the Slot Capability
> Register, not the Device Capability Register.
> 
> This assumption led to the segmentation fault because the code was
> attempting to access invalid memory addresses.
> 
> Do you think these are valid changes? Because this change caused a
> freeze on the NVMe device.

I'm not surprised that there might be issues related to registers in
the PCIe Capability.  I'm actually surprised that this driver works at
all, given the incredible mess.

So I'm not going to bother trying to fix this piecemeal as with the
patch below.  Every single access to DEVCAP/DEVCTL/DEVSTA,
SLTCAP/SLTCTL/SLTSTA, etc needs to be made rational.  There's a single
base address that works for all of them because the Rockchip register
layout matches the PCIe Capability layout.  I've already outlined in
detail what needs to be done.  I'll try to find time to actually
implement this, but it probably won't be for at least a few days.

> $ git  diff drivers/pci/controller/pcie-rockchip-host.c
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c
> b/drivers/pci/controller/pcie-rockchip-host.c
> index ee1822ca01db..743a04e36a1c 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -270,10 +270,10 @@ static void rockchip_pcie_set_power_limit(struct
> rockchip_pcie *rockchip)
>                 power = power / 10;
>         }
> 
> -       status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_DEVCAP);
> +       status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_SLTCAP);
>         status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
>         status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);
> -       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_DEVCAP);
> +       rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_SLTCAP);
>  }
> 
> Thanks
> -Anand

