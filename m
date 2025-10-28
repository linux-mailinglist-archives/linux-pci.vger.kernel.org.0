Return-Path: <linux-pci+bounces-39492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62039C12EE9
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 06:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5C4F4E45C3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 05:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E22868BA;
	Tue, 28 Oct 2025 05:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u3LqWRoo"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39111713;
	Tue, 28 Oct 2025 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629225; cv=none; b=e7trlpA6U/hBKlpYo2nPM3h290mqyonMBJCfPIRMZE/Qk4YIskLHfdH36KbcZgmjzdl5VJlhyjExyo3kCWoZQe+ZPAxdc3GXzYR6mctDBtmF682e+eKRjX+3ndpDXx6DNEE4WOi8EfPvcZuCLhrfoJOuaeXTJz6075cfaPiuabA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629225; c=relaxed/simple;
	bh=je8crrh7Jiy0WCJ+ayAi26INZ9fV4S7iU5yQ5G/2e6A=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxA6wJsOPrJ5sJKtV6wPMsxIj8JQ3tV8iXbIL+vWHwYvuJDtSNe8b5cYYf2EeN+J0S3vRl61Uv2hVNfsaPxsPSGJiJMGHfgIF/W+vORs47PvEUG6R0MpF3oXKBzXP2I1ceLZ1fxB5HQpJdwvLjrIzLGEBIUYrSaoRsEapcXjKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u3LqWRoo; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59S5QRxC2560072;
	Tue, 28 Oct 2025 00:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761629187;
	bh=cjy1Ex0W5gS4I534vFvrmC1sUEVi11c2GdQ1Zz+Fi2Q=;
	h=Subject:From:To:CC:Date:In-Reply-To:References;
	b=u3LqWRooswCdwCZWJLiS4GrS4qMNPNAvYm/uDThx8KdyRX95WwuIEjWnavl8HOxHb
	 Sa5LMUcGZOPl0rTIDIAG/1XXbgHyUrTOtm0OvgDtzGzJ8ZmmrVzk/5oU2sBcBkCObT
	 Kz22ApyI0kX8pJ7qjJo1ZmZTIgKq52Qwo00jlPL8=
Received: from DFLE00.ent.ti.com (dfle00.ent.ti.com [10.64.6.17])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59S5QRqE1663623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 28 Oct 2025 00:26:27 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DFLE00.ent.ti.com
 (10.64.6.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 28
 Oct 2025 00:26:27 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 00:26:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Oct 2025 00:26:26 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59S5QMDK1822375;
	Tue, 28 Oct 2025 00:26:22 -0500
Message-ID: <e5c1aedfeadc9a8ccd386c85028ee3f43eddf07c.camel@ti.com>
Subject: Re: [PATCH] PCI: cadence: Enable support for applying lane
 equalization presets
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: kernel test robot <lkp@intel.com>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <unicorn_wang@outlook.com>,
        <kishon@kernel.org>, <18255117159@163.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Date: Tue, 28 Oct 2025 10:56:33 +0530
In-Reply-To: <202510281329.racaZPSI-lkp@intel.com>
References: <20251027133013.2589119-1-s-vadapalli@ti.com>
	 <202510281329.racaZPSI-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, 2025-10-28 at 13:16 +0800, kernel test robot wrote:
> Hi Siddharth,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on pci/next]
> [also build test WARNING on pci/for-linus linus/master v6.18-rc3 next-202=
51027]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Vadapall=
i/PCI-cadence-Enable-support-for-applying-lane-equalization-presets/2025102=
7-213657
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20251027133013.2589119-1-s-vadap=
alli%40ti.com
> patch subject: [PATCH] PCI: cadence: Enable support for applying lane equ=
alization presets
> config: x86_64-buildonly-randconfig-002-20251028 (https://download.01.org=
/0day-ci/archive/20251028/202510281329.racaZPSI-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251028/202510281329.racaZPSI-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202510281329.racaZPSI-lkp=
@intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
>    drivers/pci/controller/cadence/pcie-cadence-host.c: In function 'cdns_=
pcie_setup_lane_equalization_presets':
> > > drivers/pci/controller/cadence/pcie-cadence-host.c:205:20: warning: t=
his statement may fall through [-Wimplicit-fallthrough=3D]
>      205 |                 if (presets_ngts[0] !=3D PCI_EQ_RESV) {
>          |                    ^
>    drivers/pci/controller/cadence/pcie-cadence-host.c:225:9: note: here
>      225 |         case PCIE_SPEED_8_0GT:
>          |         ^~~~

Fallthrough is intentional. The lane equalization presets are programmed
starting from the Max Supported Link speed and we fallthrough until we get
to 8.0 GT/s.

Regards,
Siddharth.

>=20
>=20
> vim +205 drivers/pci/controller/cadence/pcie-cadence-host.c
>=20
>    170=09
>    171	static void cdns_pcie_setup_lane_equalization_presets(struct cdns_=
pcie_rc *rc)
>    172	{
>    173		struct cdns_pcie *pcie =3D &rc->pcie;
>    174		struct device *dev =3D pcie->dev;
>    175		struct device_node *np =3D dev->of_node;
>    176		int max_link_speed, max_lanes, ret;
>    177		u32 lane_eq_ctrl_reg;
>    178		u16 cap;
>    179		u16 *presets_8gts;
>    180		u8 *presets_ngts;
>    181		u8 i, j;
>    182=09
>    183		ret =3D of_property_read_u32(np, "num-lanes", &max_lanes);
>    184		if (ret)
>    185			return;
>    186=09
>    187		/* Lane Equalization presets are optional, so error message is no=
t necessary */
>    188		ret =3D of_pci_get_equalization_presets(dev, &rc->eq_presets, max=
_lanes);
>    189		if (ret)
>    190			return;
>    191=09
>    192		max_link_speed =3D of_pci_get_max_link_speed(np);
>    193		if (max_link_speed < 0) {
>    194			dev_err(dev, "%s: link-speed unknown, skipping preset setup\n", =
__func__);
>    195			return;
>    196		}
>    197=09
>    198		/*
>    199		 * Setup presets for data rates including and upward of 8.0 GT/s =
until the
>    200		 * maximum supported data rate.
>    201		 */
>    202		switch (pcie_link_speed[max_link_speed]) {
>    203		case PCIE_SPEED_16_0GT:
>    204			presets_ngts =3D (u8 *)rc->eq_presets.eq_presets_Ngts[EQ_PRESET_=
TYPE_16GTS - 1];
>  > 205			if (presets_ngts[0] !=3D PCI_EQ_RESV) {
>    206				cap =3D cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_PL_1=
6GT);
>    207				if (!cap)
>    208					break;
>    209				lane_eq_ctrl_reg =3D cap + PCI_PL_16GT_LE_CTRL;
>    210				/*
>    211				 * For Link Speeds including and upward of 16.0 GT/s, the Lane =
Equalization
>    212				 * Control register has the following layout per Lane:
>    213				 * Bits 0-3: Downstream Port Transmitter Preset
>    214				 * Bits 4-7: Upstream Port Transmitter Preset
>    215				 *
>    216				 * 'eq_presets_Ngts' is an array of u8 (byte).
>    217				 * Therefore, we need to write to the Lane Equalization Control
>    218				 * register in units of bytes per-Lane.
>    219				 */
>    220				for (i =3D 0; i < max_lanes; i++)
>    221					cdns_pcie_rp_writeb(pcie, lane_eq_ctrl_reg + i, presets_ngts[i=
]);
>    222=09
>    223				dev_info(dev, "Link Equalization presets applied for 16.0 GT/s\=
n");
>    224			}
>    225		case PCIE_SPEED_8_0GT:
>    226			presets_8gts =3D (u16 *)rc->eq_presets.eq_presets_8gts;
>    227			if ((presets_8gts[0] & PCI_EQ_RESV) !=3D PCI_EQ_RESV) {
>    228				cap =3D cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_SECP=
CI);
>    229				if (!cap)
>    230					break;
>    231				lane_eq_ctrl_reg =3D cap + PCI_SECPCI_LE_CTRL;
>    232				/*
>    233				 * For a Link Speed of 8.0 GT/s, the Lane Equalization Control =
register has
>    234				 * the following layout per Lane:
>    235				 * Bits   0-3:  Downstream Port Transmitter Preset
>    236				 * Bits   4-6:  Downstream Port Receiver Preset Hint
>    237				 * Bit      7:  Reserved
>    238				 * Bits  8-11:  Upstream Port Transmitter Preset
>    239				 * Bits 12-14:  Upstream Port Receiver Preset Hint
>    240				 * Bit     15:  Reserved
>    241				 *
>    242				 * 'eq_presets_8gts' is an array of u16 (word).
>    243				 * Therefore, we need to write to the Lane Equalization Control
>    244				 * register in units of words per-Lane.
>    245				 */
>    246				for (i =3D 0, j =3D 0; i < max_lanes; i++, j +=3D 2)
>    247					cdns_pcie_rp_writew(pcie, lane_eq_ctrl_reg + j, presets_8gts[i=
]);
>    248=09
>    249				dev_info(dev, "Link Equalization presets applied for 8.0 GT/s\n=
");
>    250			}
>    251		}
>    252	}
>    253=09

