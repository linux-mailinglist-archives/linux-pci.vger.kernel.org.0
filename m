Return-Path: <linux-pci+bounces-37714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23615BC5796
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 16:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07D13C7C42
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CCF28469E;
	Wed,  8 Oct 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hXBvjDql"
X-Original-To: linux-pci@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster4-host10-snip4-4.eps.apple.com [57.103.65.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836A227E95
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934877; cv=none; b=EnDNSGPZ58IismMzVm81n8QMgnYAbQ7VhvtDMiCiBeVKbiu0eR0DxyGfYWMa9vCbMe5Oz91cI7hP8w04EVx979sMkT8DHsKUUZRoxUqkAlFtQJRCnbgQbiltnhk6nzz6bvoos7AkR1uKayC/eHJ4ifVtmjSRbMHKpMyyrERpm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934877; c=relaxed/simple;
	bh=9nVM8+eVYZFS+qvWMCCjTInimml7xtK7ll0/66iOhAM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mml/bwzwMUFyfVvcgR2YKF/rvAEqG2Qw00OtmBRnL19KqRejRDH+pHFv3FT1kgPjCED3O01i8GQO0oVdNxdUG97ri4+LD7jEFrzwWjuVRmexDEhRVn9j1bzkMDAVdtiXcOM0GckppBgbbn+5/0JCeqTzoMf+IpUwL7PRHJChPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hXBvjDql; arc=none smtp.client-ip=57.103.65.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-20-percent-0 (Postfix) with ESMTPS id E408D180226B;
	Wed,  8 Oct 2025 14:47:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=Hz96QNKL/WUmHBSf7yZr+YKfOAXk+udHFIUTjd9N0oA=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=hXBvjDqlWNAvCV6GY5jxxodMaqwBQY6LJxceCixH3K0Ms6MH/6UgSN+KptYKwyrbnxm7A9p0ftomyusS6kJg8ZgQi4hI7RsgARMZVKfQ0xBsEl/aRBVAIfMdX08QUGeH2wiLDMnJkMBqMht54U+BR9/23SlfORMwtQRUgRE4IK+mwLTdNVYgCHH8O99tFbpuiZs2pQnm02p4HXOZB5hLCNrTsfK+a39UxdD90oyDwGJmk3wqK/3dpzmisltRuOza1PRWhRsX8FF6FSjYwD2Opi3GPnQ9VaQG6EY12ibsBPME/+PagamOBu6DgegUtLcTO/yZnZqVfwtlMYgFjVzNRQ==
Received: from smtpclient.apple (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-20-percent-0 (Postfix) with ESMTPSA id CE7181802A0E;
	Wed,  8 Oct 2025 14:47:48 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v2 20/24] PCI: Refactor distributing available memory to
 use loops
From: john_chen_chn@icloud.com
In-Reply-To: <20250829131113.36754-21-ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Oct 2025 22:47:35 +0800
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F833CC81-7C60-48FC-A31C-B9999DCC6FA2@icloud.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
 <20250829131113.36754-21-ilpo.jarvinen@linux.intel.com>
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEwNCBTYWx0ZWRfXxpz/HBm7BKAZ
 2RTEzIvP/ohqAQtGqinfGtLSrm8cxQ7XwGDEY/mDu2PYFLU5+DE6wl2Fu28gOR5neBao2ebva9U
 Vb5gSZE4XLUPBWYWndLE/+SfTmiSAAPkZDVPSgLbSPI85a8KKn8O5W2f9Ebfyd3i8r3SluU0DfD
 DYQk5GsWKl8U0TdlwzqS1Aknd6fm6Fyu0UWM47M/Op5D49sVrClbIYpnS116Ro1ima/b5tAQrOp
 zjSU2jJnqfOpxkTG5lRv4Y57G0ksF3sKloZJW/7MNfQE9V6C8Mj7lg71SPGIuKVQGtfdn5cgg=
X-Proofpoint-GUID: FC3xdniGWII-p-UfSb-4grJ7fLA8mVvl
X-Proofpoint-ORIG-GUID: FC3xdniGWII-p-UfSb-4grJ7fLA8mVvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510080104

Hi Ilpo J=C3=A4rvinen,

This patch makes Thunderbolt unusable on my AMD Strix Halo platform.

Here's the dmesg output:

[ 4.212389] ------------[ cut here ]------------
[ 4.212391] WARNING: CPU: 6 PID: 272 at drivers/pci/pci.h:471 =
pci_bus_distribute_available_resources+0x6ad/0x6d0
[ 4.212400] Modules linked in: raid6_pq(+) hid_generic uas usb_storage =
scsi_mod usbhid hid scsi_common amdgpu amdxcp drm_panel_backlight_quirks =
gpu_sched drm_buddy drm_ttm_helper ttm drm_exec i2c_algo_bit =
drm_suballoc_helper drm_display_helper cec rc_core drm_client_lib =
drm_kms_helper sdhci_pci sdhci_uhs2 xhci_pci sp5100_tco xhci_hcd r8169 =
drm nvme sdhci watchdog realtek usbcore thunderbolt cqhci atlantic =
nvme_core mdio_devres psmouse libphy mmc_core nvme_keyring video =
i2c_piix4 macsec nvme_auth serio_raw mdio_bus i2c_smbus usb_common crc16 =
hkdf wmi
[ 4.212443] CPU: 6 UID: 0 PID: 272 Comm: irq/33-pciehp Not tainted =
6.17.0+ #1 PREEMPT(voluntary)
[ 4.212447] Hardware name: PELADN YO Series/YO1, BIOS 1.04 05/15/2025
[ 4.212449] RIP: 0010:pci_bus_distribute_available_resources+0x6ad/0x6d0
[ 4.212453] Code: ff e9 a2 48 c7 c7 b8 b7 83 a3 4c 89 4c 24 18 e8 a9 2a =
fb ff 4c 8b 4c 24 18 e9 ca fd ff ff 48 8b 05 60 53 47 01 e9 94 fe ff ff =
<0f> 0b e9 5d fe ff ff 48 8b 05 55 53 47 01 e9 81 fe ff ff e8 4b 87
[ 4.212455] RSP: 0018:ffffaffcc0d4f9a8 EFLAGS: 00010206
[ 4.212458] RAX: 00000000000000cd RBX: ffff9721a687f800 RCX: =
ffff9721a687c828
[ 4.212459] RDX: 0000000000000000 RSI: 00000000000000cd RDI: =
ffff97218bc8a3c0
[ 4.212461] RBP: ffff9721a687c828 R08: ffffaffcc0d4f9f8 R09: =
0000000000000001
[ 4.212462] R10: ffff97218bc8d700 R11: 0000000000000000 R12: =
ffffaffcc0d4f9f8
[ 4.212462] R13: ffffaffcc0d4f9f8 R14: 0000000000000000 R15: =
ffff97218bc8a000
[ 4.212464] FS: 0000000000000000(0000) GS:ffff973ee1ad9000(0000) =
knlGS:0000000000000000
[ 4.212465] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4.212467] CR2: 00005640b0f29360 CR3: 0000000ccb224000 CR4: =
0000000000f50ef0
[ 4.212469] PKRU: 55555554
[ 4.212470] Call Trace:
[ 4.212473] <TASK>
[ 4.212478] pci_bus_distribute_available_resources+0x590/0x6d0
[ 4.212483] pci_bridge_distribute_available_resources+0x62/0xb0
[ 4.212487] pci_assign_unassigned_bridge_resources+0x65/0x1b0
[ 4.212490] pciehp_configure_device+0x92/0x160
[ 4.212495] pciehp_handle_presence_or_link_change+0x1b5/0x350
[ 4.212498] pciehp_ist+0x147/0x1c0
[ 4.212502] irq_thread_fn+0x20/0x60
[ 4.212508] irq_thread+0x1cc/0x360
[ 4.212511] ? __pfx_irq_thread_fn+0x10/0x10
[ 4.212515] ? __pfx_irq_thread_dtor+0x10/0x10
[ 4.212518] ? __pfx_irq_thread+0x10/0x10
[ 4.212521] kthread+0xf9/0x240
[ 4.212525] ? __pfx_kthread+0x10/0x10
[ 4.212528] ret_from_fork+0x195/0x1d0
[ 4.212533] ? __pfx_kthread+0x10/0x10
[ 4.212536] ret_from_fork_asm+0x1a/0x30
[ 4.212540] </TASK>
[ 4.212541] ---[ end trace 0000000000000000 ]=E2=80=94

Perhaps there's something you forgot to modify while copying and
pasting, as shown below:

> On 29 Aug 2025, at 21:11, Ilpo J=C3=A4rvinen =
<ilpo.jarvinen@linux.intel.com> wrote:
>=20
> pci_bus_distribute_available_resources() and
> pci_bridge_distribute_available_resources() retain bridge window =
resources
> and related data needed for distributing the available window in
> independent variables for io, memory, and prefetchable memory windows. =
The
> code is essentially the same for all of them and therefore repeated =
three
> times with different variable names.
>=20
> Refactor pci_bus_distribute_available_resources() to take an array. =
This
> is complicated slightly by the function taking advantage of passing =
the
> struct as value, which cannot be done for arrays in C. Therefore, copy =
the
> data into a local array in the stack in the first loop.
>=20
> Variable names are (hopefully) improved slightly as well.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
> drivers/pci/setup-bus.c | 162 ++++++++++++++++++----------------------
> include/linux/pci.h     |   3 +-
> 2 files changed, 74 insertions(+), 91 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 720159bca54d..3bc329b1b923 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2059,15 +2059,16 @@ static void remove_dev_resource(struct =
resource *avail, struct pci_dev *dev,
> avail->start =3D min(avail->start + tmp, avail->end + 1);
> }
>=20
> -static void remove_dev_resources(struct pci_dev *dev, struct resource =
*io,
> - struct resource *mmio,
> - struct resource *mmio_pref)
> +static void remove_dev_resources(struct pci_dev *dev,
> + struct resource available[PCI_P2P_BRIDGE_RESOURCE_NUM])
> {
> + struct resource *mmio_pref =3D =
&available[PCI_BUS_BRIDGE_PREF_MEM_WINDOW];
> struct resource *res;
>=20
> pci_dev_for_each_resource(dev, res) {
> if (resource_type(res) =3D=3D IORESOURCE_IO) {
> - remove_dev_resource(io, dev, res);
> + remove_dev_resource(&available[PCI_BUS_BRIDGE_IO_WINDOW],
> +    dev, res);
> } else if (resource_type(res) =3D=3D IORESOURCE_MEM) {
>=20
> /*
> @@ -2081,10 +2082,13 @@ static void remove_dev_resources(struct =
pci_dev *dev, struct resource *io,
> */
> if ((res->flags & IORESOURCE_PREFETCH) &&
>    ((res->flags & IORESOURCE_MEM_64) =3D=3D
> -     (mmio_pref->flags & IORESOURCE_MEM_64)))
> - remove_dev_resource(mmio_pref, dev, res);
> - else
> - remove_dev_resource(mmio, dev, res);
> +     (mmio_pref->flags & IORESOURCE_MEM_64))) {
> + remove_dev_resource(&available[PCI_BUS_BRIDGE_PREF_MEM_WINDOW],
> +    dev, res);
> + } else {
> + remove_dev_resource(&available[PCI_BUS_BRIDGE_MEM_WINDOW],
> +    dev, res);
> + }
> }
> }
> }
> @@ -2099,45 +2103,39 @@ static void remove_dev_resources(struct =
pci_dev *dev, struct resource *io,
>  * shared with the bridges.
>  */
> static void pci_bus_distribute_available_resources(struct pci_bus =
*bus,
> -    struct list_head *add_list,
> -    struct resource io,
> -    struct resource mmio,
> -    struct resource mmio_pref)
> +    struct list_head *add_list,
> +    struct resource available_in[PCI_P2P_BRIDGE_RESOURCE_NUM])
> {
> + struct resource available[PCI_P2P_BRIDGE_RESOURCE_NUM];
> unsigned int normal_bridges =3D 0, hotplug_bridges =3D 0;
> - struct resource *io_res, *mmio_res, *mmio_pref_res;
> struct pci_dev *dev, *bridge =3D bus->self;
> - resource_size_t io_per_b, mmio_per_b, mmio_pref_per_b, align;
> + resource_size_t per_bridge[PCI_P2P_BRIDGE_RESOURCE_NUM];
> + resource_size_t align;
> + int i;
>=20
> - io_res =3D &bridge->resource[PCI_BRIDGE_IO_WINDOW];
> - mmio_res =3D &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
> - mmio_pref_res =3D &bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> + for (i =3D 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
> + struct resource *res =3D pci_bus_resource_n(bus, i);

Here should be: pci_resource_n(bridge, PCI_BRIDGE_RESOURCES + i);

>=20
> - /*
> - * The alignment of this bridge is yet to be considered, hence it =
must
> - * be done now before extending its bridge window.
> - */
> - align =3D pci_resource_alignment(bridge, io_res);
> - if (!io_res->parent && align)
> - io.start =3D min(ALIGN(io.start, align), io.end + 1);
> -
> - align =3D pci_resource_alignment(bridge, mmio_res);
> - if (!mmio_res->parent && align)
> - mmio.start =3D min(ALIGN(mmio.start, align), mmio.end + 1);
> + available[i] =3D available_in[i];
>=20
> - align =3D pci_resource_alignment(bridge, mmio_pref_res);
> - if (!mmio_pref_res->parent && align)
> - mmio_pref.start =3D min(ALIGN(mmio_pref.start, align),
> - mmio_pref.end + 1);
> + /*
> + * The alignment of this bridge is yet to be considered,
> + * hence it must be done now before extending its bridge
> + * window.
> + */
> + align =3D pci_resource_alignment(bridge, res);
> + if (!res->parent && align)
> + available[i].start =3D min(ALIGN(available[i].start, align),
> + available[i].end + 1);
>=20
> - /*
> - * Now that we have adjusted for alignment, update the bridge window
> - * resources to fill as much remaining resource space as possible.
> - */
> - adjust_bridge_window(bridge, io_res, add_list, resource_size(&io));
> - adjust_bridge_window(bridge, mmio_res, add_list, =
resource_size(&mmio));
> - adjust_bridge_window(bridge, mmio_pref_res, add_list,
> -     resource_size(&mmio_pref));
> + /*
> + * Now that we have adjusted for alignment, update the
> + * bridge window resources to fill as much remaining
> + * resource space as possible.
> + */
> + adjust_bridge_window(bridge, res, add_list,
> +     resource_size(&available[i]));
> + }
>=20
> /*
> * Calculate how many hotplug bridges and normal bridges there
> @@ -2161,7 +2159,7 @@ static void =
pci_bus_distribute_available_resources(struct pci_bus *bus,
> */
> list_for_each_entry(dev, &bus->devices, bus_list) {
> if (!dev->is_virtfn)
> - remove_dev_resources(dev, &io, &mmio, &mmio_pref);
> + remove_dev_resources(dev, available);
> }
>=20
> /*
> @@ -2173,16 +2171,9 @@ static void =
pci_bus_distribute_available_resources(struct pci_bus *bus,
> * split between non-hotplug bridges. This is to allow possible
> * hotplug bridges below them to get the extra space as well.
> */
> - if (hotplug_bridges) {
> - io_per_b =3D div64_ul(resource_size(&io), hotplug_bridges);
> - mmio_per_b =3D div64_ul(resource_size(&mmio), hotplug_bridges);
> - mmio_pref_per_b =3D div64_ul(resource_size(&mmio_pref),
> -   hotplug_bridges);
> - } else {
> - io_per_b =3D div64_ul(resource_size(&io), normal_bridges);
> - mmio_per_b =3D div64_ul(resource_size(&mmio), normal_bridges);
> - mmio_pref_per_b =3D div64_ul(resource_size(&mmio_pref),
> -   normal_bridges);
> + for (i =3D 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
> + per_bridge[i] =3D div64_ul(resource_size(&available[i]),
> + hotplug_bridges ?: normal_bridges);
> }
>=20
> for_each_pci_bridge(dev, bus) {
> @@ -2195,49 +2186,41 @@ static void =
pci_bus_distribute_available_resources(struct pci_bus *bus,
> if (hotplug_bridges && !dev->is_hotplug_bridge)
> continue;
>=20
> - res =3D &dev->resource[PCI_BRIDGE_IO_WINDOW];
> + for (i =3D 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
> + res =3D pci_bus_resource_n(bus, i);

Same here, should be: pci_resource_n(dev, PCI_BRIDGE_RESOURCES + i);

I have written a patch to resolve these issues:
=
https://lore.kernel.org/lkml/tencent_8C54420E1B0FF8D804C1B4651DF970716309@=
qq.com/

Thanks,
Yangyu Chen

>=20
> - /*
> - * Make sure the split resource space is properly aligned
> - * for bridge windows (align it down to avoid going above
> - * what is available).
> - */
> - align =3D pci_resource_alignment(dev, res);
> - resource_set_size(&io, ALIGN_DOWN_IF_NONZERO(io_per_b, align));
> -
> - /*
> - * The x_per_b holds the extra resource space that can be
> - * added for each bridge but there is the minimal already
> - * reserved as well so adjust x.start down accordingly to
> - * cover the whole space.
> - */
> - io.start -=3D resource_size(res);
> -
> - res =3D &dev->resource[PCI_BRIDGE_MEM_WINDOW];
> - align =3D pci_resource_alignment(dev, res);
> - resource_set_size(&mmio,
> -  ALIGN_DOWN_IF_NONZERO(mmio_per_b,align));
> - mmio.start -=3D resource_size(res);
> + /*
> + * Make sure the split resource space is properly
> + * aligned for bridge windows (align it down to
> + * avoid going above what is available).
> + */
> + align =3D pci_resource_alignment(dev, res);
> + resource_set_size(&available[i],
> +  ALIGN_DOWN_IF_NONZERO(per_bridge[i],
> + align));
>=20
> - res =3D &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> - align =3D pci_resource_alignment(dev, res);
> - resource_set_size(&mmio_pref,
> -  ALIGN_DOWN_IF_NONZERO(mmio_pref_per_b, align));
> - mmio_pref.start -=3D resource_size(res);
> + /*
> + * The per_bridge holds the extra resource space
> + * that can be added for each bridge but there is
> + * the minimal already reserved as well so adjust
> + * x.start down accordingly to cover the whole
> + * space.
> + */
> + available[i].start -=3D resource_size(res);
> + }
>=20
> - pci_bus_distribute_available_resources(b, add_list, io, mmio,
> -       mmio_pref);
> + pci_bus_distribute_available_resources(b, add_list, available);
>=20
> - io.start +=3D io.end + 1;
> - mmio.start +=3D mmio.end + 1;
> - mmio_pref.start +=3D mmio_pref.end + 1;
> + for (i =3D 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++)
> + available[i].start +=3D available[i].end + 1;
> }
> }
>=20
> static void pci_bridge_distribute_available_resources(struct pci_dev =
*bridge,
>      struct list_head *add_list)
> {
> - struct resource available_io, available_mmio, available_mmio_pref;
> + struct resource *res, available[PCI_P2P_BRIDGE_RESOURCE_NUM];
> + unsigned int i;
>=20
> if (!bridge->is_hotplug_bridge)
> return;
> @@ -2245,14 +2228,13 @@ static void =
pci_bridge_distribute_available_resources(struct pci_dev *bridge,
> pci_dbg(bridge, "distributing available resources\n");
>=20
> /* Take the initial extra resources from the hotplug port */
> - available_io =3D bridge->resource[PCI_BRIDGE_IO_WINDOW];
> - available_mmio =3D bridge->resource[PCI_BRIDGE_MEM_WINDOW];
> - available_mmio_pref =3D =
bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> + for (i =3D 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
> + res =3D pci_resource_n(bridge, PCI_BRIDGE_RESOURCES + i);
> + available[i] =3D *res;
> + }
>=20
> pci_bus_distribute_available_resources(bridge->subordinate,
> -       add_list, available_io,
> -       available_mmio,
> -       available_mmio_pref);
> +       add_list, available);
> }
>=20
> static bool pci_bridge_resources_not_assigned(struct pci_dev *dev)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 275df4058767..723e9cede69d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -119,7 +119,8 @@ enum {
> #define PCI_CB_BRIDGE_MEM_1_WINDOW (PCI_BRIDGE_RESOURCES + 3)
>=20
> /* Total number of bridge resources for P2P and CardBus */
> -#define PCI_BRIDGE_RESOURCE_NUM 4
> +#define PCI_P2P_BRIDGE_RESOURCE_NUM 3
> +#define PCI_BRIDGE_RESOURCE_NUM 4
>=20
> /* Resources assigned to buses behind the bridge */
> PCI_BRIDGE_RESOURCES,
> --=20
> 2.39.5
>=20
>=20


