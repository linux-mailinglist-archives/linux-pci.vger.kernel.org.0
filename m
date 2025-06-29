Return-Path: <linux-pci+bounces-31019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819BFAECAE0
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 03:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7165C3BA678
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC61BC41;
	Sun, 29 Jun 2025 01:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdYRfLDW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76943C01
	for <linux-pci@vger.kernel.org>; Sun, 29 Jun 2025 01:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751160333; cv=none; b=AEobW8D1tXHJEKtZUew9bj0UAjltRaH1Cv4rp4PNpdh80tObpr47IW08ISrsE8aJ10YbHhhyzY5B/yvR4bOo3l4bw88QcYQFaujVRANThD941wmt0eceVkwWkNxHpY4l4zCIImk8OYpuGhxDSnTITCJwq7Z/WTxnz9M2prb+cNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751160333; c=relaxed/simple;
	bh=dzjXf6jr/PkdHD3sJrMCq7ckqeJ/6zZ/DdZTjq/oL3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tspW+j/wr1cv46ZaIgoh3SQzFDaIkViAJdAHN+rQ7UVgx2JCt2QgTvR6Xs22ZoBIMbAzjX9vbcbUi48NmxA6sAB82hkZ5Y16SKw0qZwu5rmO88LnnijxtYnR1XkDUPn+7rN5XwxQcOkRwpETGP38c8a8u/wR1PZDDeE9tlnG23A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdYRfLDW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751160332; x=1782696332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dzjXf6jr/PkdHD3sJrMCq7ckqeJ/6zZ/DdZTjq/oL3Q=;
  b=FdYRfLDW3U+158T6cVq3aMyyLsoptTA0iZbfM1gJNTM1qT0FDBWM8bmA
   NqY2lMYTizsBjWMvTh8kGI+fcRyNvzmOWtgwBri8POT3bKwD9LfXF2+qx
   NvDMoT1LDV8Il//APPcRonRXaRIRgWeyyaAXnrkaoS5ekESDgwZM3NTkD
   gTLBDryXkqb3xoVBEdwoPQRgimJyCSxzvfkBpkaeH2qDdGtFAjngpEMsQ
   r4sFFu1UWRpiftxg50beNZaLAwSJm40Yw7F5/QFYuvxoZpEkL6vIXxMvV
   DvXtHnHBBv68aP3eNpG5bieSPEs5+PqZ/0jrCkm5KxrdF5nL29Rnuyj8S
   g==;
X-CSE-ConnectionGUID: j4jL8biLQJi7S6hf18LQLw==
X-CSE-MsgGUID: IDS0DcwGRYK3AAD/JpzLqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11478"; a="75972875"
X-IronPort-AV: E=Sophos;i="6.16,274,1744095600"; 
   d="scan'208";a="75972875"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 18:25:32 -0700
X-CSE-ConnectionGUID: j8j7rAI8QKuc1GaxRgZtAQ==
X-CSE-MsgGUID: vl266et4QWaOmjtFhEB7Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,274,1744095600"; 
   d="scan'208";a="152859661"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 28 Jun 2025 18:25:29 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVgnO-000XYs-2q;
	Sun, 29 Jun 2025 01:25:26 +0000
Date: Sun, 29 Jun 2025 09:24:35 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bhelgaas@google.com, ashishk@purestorage.com, macro@orcam.me.uk,
	msaggi@purestorage.com, sconnor@purestorage.com,
	Matthew W Carlis <mattc@purestorage.com>
Subject: Re: [PATCH 1/1] PCI: pcie_failed_link_retrain() return if dev is not
 ASM2824
Message-ID: <202506290953.x9ODOCCs-lkp@intel.com>
References: <20250627002652.22920-2-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627002652.22920-2-mattc@purestorage.com>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.16-rc3 next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-W-Carlis/PCI-pcie_failed_link_retrain-return-if-dev-is-not-ASM2824/20250628-042356
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250627002652.22920-2-mattc%40purestorage.com
patch subject: [PATCH 1/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250629/202506290953.x9ODOCCs-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250629/202506290953.x9ODOCCs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506290953.x9ODOCCs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/quirks.c:104:3: error: expected ')'
     104 |                 return ret;
         |                 ^
   drivers/pci/quirks.c:103:5: note: to match this '('
     103 |         if (!pci_match_id(ids, dev)
         |            ^
   1 error generated.


vim +104 drivers/pci/quirks.c

    46	
    47	/*
    48	 * Retrain the link of a downstream PCIe port by hand if necessary.
    49	 *
    50	 * This is needed at least where a downstream port of the ASMedia ASM2824
    51	 * Gen 3 switch is wired to the upstream port of the Pericom PI7C9X2G304
    52	 * Gen 2 switch, and observed with the Delock Riser Card PCI Express x1 >
    53	 * 2 x PCIe x1 device, P/N 41433, plugged into the SiFive HiFive Unmatched
    54	 * board.
    55	 *
    56	 * In such a configuration the switches are supposed to negotiate the link
    57	 * speed of preferably 5.0GT/s, falling back to 2.5GT/s.  However the link
    58	 * continues switching between the two speeds indefinitely and the data
    59	 * link layer never reaches the active state, with link training reported
    60	 * repeatedly active ~84% of the time.  Forcing the target link speed to
    61	 * 2.5GT/s with the upstream ASM2824 device makes the two switches talk to
    62	 * each other correctly however.  And more interestingly retraining with a
    63	 * higher target link speed afterwards lets the two successfully negotiate
    64	 * 5.0GT/s.
    65	 *
    66	 * With the ASM2824 we can rely on the otherwise optional Data Link Layer
    67	 * Link Active status bit and in the failed link training scenario it will
    68	 * be off along with the Link Bandwidth Management Status indicating that
    69	 * hardware has changed the link speed or width in an attempt to correct
    70	 * unreliable link operation.  For a port that has been left unconnected
    71	 * both bits will be clear.  So use this information to detect the problem
    72	 * rather than polling the Link Training bit and watching out for flips or
    73	 * at least the active status.
    74	 *
    75	 * Since the exact nature of the problem isn't known and in principle this
    76	 * could trigger where an ASM2824 device is downstream rather upstream,
    77	 * apply this erratum workaround to any downstream ports as long as they
    78	 * support Link Active reporting and have the Link Control 2 register.
    79	 * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
    80	 * request a retrain and check the result.
    81	 *
    82	 * If this turns out successful and we know by the Vendor:Device ID it is
    83	 * safe to do so, then lift the restriction, letting the devices negotiate
    84	 * a higher speed.  Also check for a similar 2.5GT/s speed restriction the
    85	 * firmware may have already arranged and lift it with ports that already
    86	 * report their data link being up.
    87	 *
    88	 * Otherwise revert the speed to the original setting and request a retrain
    89	 * again to remove any residual state, ignoring the result as it's supposed
    90	 * to fail anyway.
    91	 *
    92	 * Return 0 if the link has been successfully retrained.  Return an error
    93	 * if retraining was not needed or we attempted a retrain and it failed.
    94	 */
    95	int pcie_failed_link_retrain(struct pci_dev *dev)
    96	{
    97		static const struct pci_device_id ids[] = {
    98			{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
    99			{}
   100		};
   101		u16 lnksta, lnkctl2;
   102		int ret = -ENOTTY;
   103		if (!pci_match_id(ids, dev)
 > 104			return ret;
   105	
   106		if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
   107		    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
   108			return ret;
   109	
   110		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
   111		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
   112		if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
   113			u16 oldlnkctl2 = lnkctl2;
   114	
   115			pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
   116	
   117			ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
   118			if (ret) {
   119				pci_info(dev, "retraining failed\n");
   120				pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2),
   121						      true);
   122				return ret;
   123			}
   124	
   125			pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
   126		}
   127	
   128		if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
   129		    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
   130			u32 lnkcap;
   131	
   132			pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
   133			pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
   134			ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);
   135			if (ret) {
   136				pci_info(dev, "retraining failed\n");
   137				return ret;
   138			}
   139		}
   140	
   141		return ret;
   142	}
   143	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

