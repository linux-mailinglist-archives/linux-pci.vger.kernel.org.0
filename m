Return-Path: <linux-pci+bounces-39523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F79EC1476C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 12:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 279E64FA301
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ED530F520;
	Tue, 28 Oct 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoGiyTXp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C130C36F;
	Tue, 28 Oct 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652069; cv=none; b=YciRZLsyV/SRnEpiTDVHrr+NcBBgbv27vrUnuwFzKzs5CXEqk0oO0P/DYrtk7TKWmI9rGU+oh5waaO3UXLk2XTFpbu3+1CkIi2wpZa6zPf5QvLwQPiPIgr1aWy47a3ZayFQRaveSJdLUa+c8x5aKJW0HU7Mq7hKVUmA7fereF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652069; c=relaxed/simple;
	bh=o3Ygv9zJiM4QaoVWp21tdWP+/a1mP1M4inHPBsgO0Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=L7oAPZYeAVBDBVvmf5xhb60zR0WJIpBXLRr4asVZOrnf9dFtdSlwDznG8dVOIi6yO8gaBgdKHzkPoc7n66Vcq7zJunIo9YlgfdB9e0W3O8iqXz3nCn3vFYmtybq2nDFw2nV3P/2xEwxuJHeNCaGRkvdIt05+1IYK5DCYhY4hJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoGiyTXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF46C4CEFD;
	Tue, 28 Oct 2025 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761652067;
	bh=o3Ygv9zJiM4QaoVWp21tdWP+/a1mP1M4inHPBsgO0Cg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FoGiyTXpyFdw86kawPliSOfWBZnCVOBF2RiTCyDIzqW5rSuS4IwbsQ4KZQaNQd8c7
	 N6skGdZR2F397zvhJNw31ZhTyokWrP8I5HnpOqdqYU5JqpQhc35GqWzYcP6TDvzIgY
	 3VgWuMK3CF7KML0MUpnrnwGLAqmqTb3twwv3HlzxuRMkyPGsaKoX1+wbvdRuBhcSVN
	 e3BIfpj7y9SiWAaTiHPx9ZQ77QialZO0xSWj+9lq3iHyb5AzdcvKi7H63oA7S5A1rX
	 h7473wjkesXMxV/8IyD2b5lkssWZ7LMRsUKKyjm8TfNoNNc0f+Dj9z5r3sAuNmrl0c
	 T+9JDsevrOx8A==
Date: Tue, 28 Oct 2025 06:47:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: kernel test robot <lkp@intel.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, unicorn_wang@outlook.com, kishon@kernel.org,
	18255117159@163.com, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH] PCI: cadence: Enable support for applying lane
 equalization presets
Message-ID: <20251028114746.GA1505797@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c1aedfeadc9a8ccd386c85028ee3f43eddf07c.camel@ti.com>

On Tue, Oct 28, 2025 at 10:56:33AM +0530, Siddharth Vadapalli wrote:
> On Tue, 2025-10-28 at 13:16 +0800, kernel test robot wrote:
> > Hi Siddharth,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on pci/next]
> > [also build test WARNING on pci/for-linus linus/master v6.18-rc3 next-20251027]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Vadapalli/PCI-cadence-Enable-support-for-applying-lane-equalization-presets/20251027-213657
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> > patch link:    https://lore.kernel.org/r/20251027133013.2589119-1-s-vadapalli%40ti.com
> > patch subject: [PATCH] PCI: cadence: Enable support for applying lane equalization presets
> > config: x86_64-buildonly-randconfig-002-20251028 (https://download.01.org/0day-ci/archive/20251028/202510281329.racaZPSI-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510281329.racaZPSI-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202510281329.racaZPSI-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/pci/controller/cadence/pcie-cadence-host.c: In function 'cdns_pcie_setup_lane_equalization_presets':
> > > > drivers/pci/controller/cadence/pcie-cadence-host.c:205:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >      205 |                 if (presets_ngts[0] != PCI_EQ_RESV) {
> >          |                    ^
> >    drivers/pci/controller/cadence/pcie-cadence-host.c:225:9: note: here
> >      225 |         case PCIE_SPEED_8_0GT:
> >          |         ^~~~
> 
> Fallthrough is intentional. The lane equalization presets are programmed
> starting from the Max Supported Link speed and we fallthrough until we get
> to 8.0 GT/s.

It's poorly documented, but use "fallthrough" here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/deprecated.rst?id=v6.17#n200

> > vim +205 drivers/pci/controller/cadence/pcie-cadence-host.c
> > 
> >    170	
> >    171	static void cdns_pcie_setup_lane_equalization_presets(struct cdns_pcie_rc *rc)
> >    172	{
> >    173		struct cdns_pcie *pcie = &rc->pcie;
> >    174		struct device *dev = pcie->dev;
> >    175		struct device_node *np = dev->of_node;
> >    176		int max_link_speed, max_lanes, ret;
> >    177		u32 lane_eq_ctrl_reg;
> >    178		u16 cap;
> >    179		u16 *presets_8gts;
> >    180		u8 *presets_ngts;
> >    181		u8 i, j;
> >    182	
> >    183		ret = of_property_read_u32(np, "num-lanes", &max_lanes);
> >    184		if (ret)
> >    185			return;
> >    186	
> >    187		/* Lane Equalization presets are optional, so error message is not necessary */
> >    188		ret = of_pci_get_equalization_presets(dev, &rc->eq_presets, max_lanes);
> >    189		if (ret)
> >    190			return;
> >    191	
> >    192		max_link_speed = of_pci_get_max_link_speed(np);
> >    193		if (max_link_speed < 0) {
> >    194			dev_err(dev, "%s: link-speed unknown, skipping preset setup\n", __func__);
> >    195			return;
> >    196		}
> >    197	
> >    198		/*
> >    199		 * Setup presets for data rates including and upward of 8.0 GT/s until the
> >    200		 * maximum supported data rate.
> >    201		 */
> >    202		switch (pcie_link_speed[max_link_speed]) {
> >    203		case PCIE_SPEED_16_0GT:
> >    204			presets_ngts = (u8 *)rc->eq_presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS - 1];
> >  > 205			if (presets_ngts[0] != PCI_EQ_RESV) {
> >    206				cap = cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_PL_16GT);
> >    207				if (!cap)
> >    208					break;
> >    209				lane_eq_ctrl_reg = cap + PCI_PL_16GT_LE_CTRL;
> >    210				/*
> >    211				 * For Link Speeds including and upward of 16.0 GT/s, the Lane Equalization
> >    212				 * Control register has the following layout per Lane:
> >    213				 * Bits 0-3: Downstream Port Transmitter Preset
> >    214				 * Bits 4-7: Upstream Port Transmitter Preset
> >    215				 *
> >    216				 * 'eq_presets_Ngts' is an array of u8 (byte).
> >    217				 * Therefore, we need to write to the Lane Equalization Control
> >    218				 * register in units of bytes per-Lane.
> >    219				 */
> >    220				for (i = 0; i < max_lanes; i++)
> >    221					cdns_pcie_rp_writeb(pcie, lane_eq_ctrl_reg + i, presets_ngts[i]);
> >    222	
> >    223				dev_info(dev, "Link Equalization presets applied for 16.0 GT/s\n");
> >    224			}
> >    225		case PCIE_SPEED_8_0GT:
> >    226			presets_8gts = (u16 *)rc->eq_presets.eq_presets_8gts;
> >    227			if ((presets_8gts[0] & PCI_EQ_RESV) != PCI_EQ_RESV) {
> >    228				cap = cdns_pcie_find_ext_capability(pcie, PCI_EXT_CAP_ID_SECPCI);
> >    229				if (!cap)
> >    230					break;
> >    231				lane_eq_ctrl_reg = cap + PCI_SECPCI_LE_CTRL;
> >    232				/*
> >    233				 * For a Link Speed of 8.0 GT/s, the Lane Equalization Control register has
> >    234				 * the following layout per Lane:
> >    235				 * Bits   0-3:  Downstream Port Transmitter Preset
> >    236				 * Bits   4-6:  Downstream Port Receiver Preset Hint
> >    237				 * Bit      7:  Reserved
> >    238				 * Bits  8-11:  Upstream Port Transmitter Preset
> >    239				 * Bits 12-14:  Upstream Port Receiver Preset Hint
> >    240				 * Bit     15:  Reserved
> >    241				 *
> >    242				 * 'eq_presets_8gts' is an array of u16 (word).
> >    243				 * Therefore, we need to write to the Lane Equalization Control
> >    244				 * register in units of words per-Lane.
> >    245				 */
> >    246				for (i = 0, j = 0; i < max_lanes; i++, j += 2)
> >    247					cdns_pcie_rp_writew(pcie, lane_eq_ctrl_reg + j, presets_8gts[i]);
> >    248	
> >    249				dev_info(dev, "Link Equalization presets applied for 8.0 GT/s\n");
> >    250			}
> >    251		}
> >    252	}
> >    253	

