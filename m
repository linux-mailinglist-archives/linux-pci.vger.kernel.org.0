Return-Path: <linux-pci+bounces-43356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1A3CCF4C1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 11:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF4D7300B9B9
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678FA2D24A0;
	Fri, 19 Dec 2025 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj7aBXzL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C252D061D;
	Fri, 19 Dec 2025 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138852; cv=none; b=XDqZDo7o6U97uw5u4bjwSQpW4CvKXvJcsWsudN+8xcgywseDey3lw1ZSgubeg6mG1U67y7JhhSdS3H1uzl8krp6HS3I2ofYktgSZr18W08mkX7u1uDR3XMGzOqE2NBzsfOaReHnFDHPI5QFwVXoU6ACLTshv4cqGQClbEVQPy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138852; c=relaxed/simple;
	bh=vHbCNHPepXvcPrXcbr6Mra7Oz2w4onzdgVlqRgM1Slc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A34/moLwn3NzNF7xsXIpnBxpsj/5nefrnW7M/8/Nf8cIaUdstdfaA91gkySrqZUiZuma5PAie70SuQ8zU265j/rdJq5v+Cl59GuAHD+6DWWTDeUSW8r2bic8Q8KO/sM4V/vZbBnm0KwPqdom6bD5yApflh/nl0GdBtdwB4iuVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj7aBXzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCC2C4CEF1;
	Fri, 19 Dec 2025 10:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766138851;
	bh=vHbCNHPepXvcPrXcbr6Mra7Oz2w4onzdgVlqRgM1Slc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qj7aBXzLy0hlGl7Fkhne8ygw2aEHFon8Q0EcKNyYNZ2nSfUPqVVzse2Ur0Q6HZXwa
	 cCRUyu6YXinpK8fM5vX6rKsCuHj0NKqAbOM/SvsKLkwvSmtR/OlaGyqP9x5Gvh1Ues
	 hw6ADrBpnv2a6fZ7S/LaKVX9yZaxb+L7jUPIf7zYWI2ov5joVezIylPTq42qUDNi8C
	 M+BIwXFPwF+AnkRUvoBuU4lFGQpwXSzCQy3ho3Naj4imsWGneO5bEpdDW0X4O4xkI6
	 rjtjOBsOP4maBg7SIoJwg3RqE6gj8EPrwihFCyk5h+/fUz5zIUgd2u9lIR1cUX0io8
	 8z3Csoh1CvgwQ==
Date: Fri, 19 Dec 2025 15:37:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [pci:controller/dwc 8/8]
 drivers/pci/controller/dwc/pcie-designware-host.c:1175:6: warning: variable
 'ret' is used uninitialized whenever 'if' condition is true
Message-ID: <3xh2gtngbn5ys5qkxnzfdbtolt3pw6clsmulv7qihgi35cmslk@ix2fadma65vk>
References: <202512191339.583iyg1a-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202512191339.583iyg1a-lkp@intel.com>

On Fri, Dec 19, 2025 at 01:15:28PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
> head:   c4a86e6600fa082d6646044fcce2183ad5e52283
> commit: c4a86e6600fa082d6646044fcce2183ad5e52283 [8/8] PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3 transition during suspend if link is not up
> config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20251219/202512191339.583iyg1a-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251219/202512191339.583iyg1a-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512191339.583iyg1a-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/pci/controller/dwc/pcie-designware-host.c:1175:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>     1175 |         if (!dw_pcie_link_up(pci))
>          |             ^~~~~~~~~~~~~~~~~~~~~
>    drivers/pci/controller/dwc/pcie-designware-host.c:1218:9: note: uninitialized use occurs here
>     1218 |         return ret;
>          |                ^~~
>    drivers/pci/controller/dwc/pcie-designware-host.c:1175:2: note: remove the 'if' if its condition is always false
>     1175 |         if (!dw_pcie_link_up(pci))
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     1176 |                 goto stop_link;
>          |                 ~~~~~~~~~~~~~~
>    drivers/pci/controller/dwc/pcie-designware-host.c:1173:9: note: initialize the variable 'ret' to silence this warning
>     1173 |         int ret;
>          |                ^
>          |                 = 0

Ammended the commit with the fix.

- Mani

>    1 warning generated.
> 
> 
> vim +1175 drivers/pci/controller/dwc/pcie-designware-host.c
> 
>   1168	
>   1169	int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>   1170	{
>   1171		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>   1172		u32 val;
>   1173		int ret;
>   1174	
> > 1175		if (!dw_pcie_link_up(pci))
>   1176			goto stop_link;
>   1177	
>   1178		/*
>   1179		 * If L1SS is supported, then do not put the link into L2 as some
>   1180		 * devices such as NVMe expect low resume latency.
>   1181		 */
>   1182		if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>   1183			return 0;
>   1184	
>   1185		if (pci->pp.ops->pme_turn_off) {
>   1186			pci->pp.ops->pme_turn_off(&pci->pp);
>   1187		} else {
>   1188			ret = dw_pcie_pme_turn_off(pci);
>   1189			if (ret)
>   1190				return ret;
>   1191		}
>   1192	
>   1193		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
>   1194					val == DW_PCIE_LTSSM_L2_IDLE ||
>   1195					val <= DW_PCIE_LTSSM_DETECT_WAIT,
>   1196					PCIE_PME_TO_L2_TIMEOUT_US/10,
>   1197					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
>   1198		if (ret) {
>   1199			/* Only log message when LTSSM isn't in DETECT or POLL */
>   1200			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
>   1201			return ret;
>   1202		}
>   1203	
>   1204		/*
>   1205		 * Per PCIe r6.0, sec 5.3.3.2.1, software should wait at least
>   1206		 * 100ns after L2/L3 Ready before turning off refclock and
>   1207		 * main power. This is harmless when no endpoint is connected.
>   1208		 */
>   1209		udelay(1);
>   1210	
>   1211	stop_link:
>   1212		dw_pcie_stop_link(pci);
>   1213		if (pci->pp.ops->deinit)
>   1214			pci->pp.ops->deinit(&pci->pp);
>   1215	
>   1216		pci->suspended = true;
>   1217	
>   1218		return ret;
>   1219	}
>   1220	EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
>   1221	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

-- 
மணிவண்ணன் சதாசிவம்

