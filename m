Return-Path: <linux-pci+bounces-6162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6666F8A255B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 06:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB38328655F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 04:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF26CA6F;
	Fri, 12 Apr 2024 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhci9/a+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932FD8C15;
	Fri, 12 Apr 2024 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897614; cv=none; b=HkLWH/3BPAOVeLMAW1Vn39XJxc4NJvFlLZKnzwt1NT+EJwGBzUm+pcyGdCN0zmI/bBdrj/9AMJXJPR+XOVihjlStQ9DhQNIs5NhHLEHWDCxMcsC9OlOV8BkCYAo3obYSf3b0MqldljlGA4p3zG8KScFQo9IIUFPUeM2XbsGL8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897614; c=relaxed/simple;
	bh=zCnr+1q1U/qlElA2Lk28i9YQMJYY5O+HfAkEoc0YqSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkFy4Y0xsXnEL8V5c/B85F88O9KoyhTg7B6MQeAKvc8lMg8V+ZgthFxTG2ekL48nd3k5pXVdNa5Rrfxjt79WsaxkRMm958Qepurmq16VnAzzqSMaOhcbl/NM/BnAn5LZemiHQg8NfxssZGbk9GCRrMc6z2ucdZ9Nc/bv12hA/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhci9/a+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712897612; x=1744433612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zCnr+1q1U/qlElA2Lk28i9YQMJYY5O+HfAkEoc0YqSg=;
  b=lhci9/a+f66NsNHYMkvTcYwdkX5scIyvlBA294pmFvGyzVcX1fp5NANF
   BqHS2NSIrhpjZGMdGwCBAOmf4KCWv3xsZ4hHSN3sduwNHrlQgMxYYQlWp
   dfz7ksXYC6tw5tHHAVoeRWl51MA8qyurgzCRgpH1RrXxVuONIBMXx2OQw
   3BeXJZXzZAM+f4n1+ivWvjO+Wx2+D6o4uTXzjVJrNNj0s6CJ5Eb5b3U22
   9sDvH9Uvmicb1H+bvuHuvHwErrVEcm9Y6WilyqzuCTOTWs2sBMOreypq9
   HGcM4Pnq8OPSQMmJQgp4XWAW8FfIQ1QdM6BeHPHxxGw7MPD5pBMHBFE8l
   A==;
X-CSE-ConnectionGUID: qKSboLRPTV6RfPoXiz5s9A==
X-CSE-MsgGUID: fO2EWBrtRVSnDzBeGq1hSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="33736938"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="33736938"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 21:53:31 -0700
X-CSE-ConnectionGUID: yMJ8iJF+QHayfq3I5O+ucQ==
X-CSE-MsgGUID: F7nYeuayTWeY/2yS5L4L/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="25781519"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Apr 2024 21:53:30 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rv8ul-0009Nz-2S;
	Fri, 12 Apr 2024 04:53:27 +0000
Date: Fri, 12 Apr 2024 12:53:22 +0800
From: kernel test robot <lkp@intel.com>
To: parker@finest.io, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH 2/2] serial: exar: adding CTI PCI/PCIe serial port
 support to 8250_exar
Message-ID: <202404121251.hu0SvXG8-lkp@intel.com>
References: <9ffdef053f455c87f705dff169346bc10d307787.1712846026.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ffdef053f455c87f705dff169346bc10d307787.1712846026.git.pnewman@connecttech.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus pci/next pci/for-linus linus/master v6.9-rc3 next-20240411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/parker-finest-io/serial-exar-add-missing-CTI-Exar-PCI-IDs-to-include-linux-pci_ids-h/20240412-011902
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/9ffdef053f455c87f705dff169346bc10d307787.1712846026.git.pnewman%40connecttech.com
patch subject: [PATCH 2/2] serial: exar: adding CTI PCI/PCIe serial port support to 8250_exar
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20240412/202404121251.hu0SvXG8-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240412/202404121251.hu0SvXG8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404121251.hu0SvXG8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_exar.c:672: warning: Function parameter or struct member 'eeprom_offset' not described in 'cti_read_osc_freq'


vim +672 drivers/tty/serial/8250/8250_exar.c

   661	
   662	/**
   663	 * cti_read_osc_freq() - Read the UART oscillator frequency from EEPROM
   664	 * @priv: Device's private structure
   665	 *
   666	 * CTI XR17x15X and XR17V25X cards have the serial boards oscillator frequency
   667	 * stored in the EEPROM. FPGA and XR17V35X based cards use the PCI/PCIe clock.
   668	 *
   669	 * Return: frequency on success, negative error code on failure
   670	 */
   671	static int cti_read_osc_freq(struct exar8250 *priv, uint8_t eeprom_offset)
 > 672	{
   673		int osc_freq;
   674	
   675		if (!priv)
   676			return -EINVAL;
   677	
   678		osc_freq = (exar_ee_read(priv, eeprom_offset));
   679		osc_freq |= (exar_ee_read(priv, (eeprom_offset + 1)) << 16);
   680	
   681		//check if EEPROM word was blank
   682		if ((osc_freq == 0xFFFF) || (osc_freq == 0x0000))
   683			return -EIO;
   684	
   685		pci_dbg(priv->pcidev, "osc_freq from EEPROM %d\n", osc_freq);
   686	
   687		return osc_freq;
   688	}
   689	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

