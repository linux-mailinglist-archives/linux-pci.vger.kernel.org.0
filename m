Return-Path: <linux-pci+bounces-21601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF1DA380FA
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 11:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AD71894723
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 10:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9921A436;
	Mon, 17 Feb 2025 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTnPBV0I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D6217711;
	Mon, 17 Feb 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789794; cv=none; b=M8aGGBBBWh9s/K0rEFFV4eMQF4rS7eTsvktLKhfAuLXcrGLDDYN86dORisrcF4Q+40rZ5C2XjC7ys+/KrwbkM/gbLO6WRX36fi+uW9mPtlSSmJyFVyCbTQRAVfffaX+re+02f5yw/rU/izwQvrUEZSF9Wx3O6/PU6TsBxNRjS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789794; c=relaxed/simple;
	bh=hDLOgY+mA75Ymn1iBk9Z4iLCk4JLS5jTuILN+eQ4yqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3rpXXu/RKjmu0tclFka90+E0iPYd48dQ5HcoFA3cJjXn59Zr3GVld7PF2AQf3qeP1c5ZJHcs2i340eRYZ1eUz82cGguoNy58977xBEtldf7wpsyUE1qv8+ticYm305iyR8YUdQ4J6WSzWkMu5IAkMXze38+IU9xQCe5wCvbw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTnPBV0I; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739789792; x=1771325792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hDLOgY+mA75Ymn1iBk9Z4iLCk4JLS5jTuILN+eQ4yqo=;
  b=lTnPBV0IU4esVwvCGq4KRZo+9bXio1nrGTEUv4NX6IZDNQhT5Py21+RG
   YNHAKJbkSQzp5e9xDCehLqnw31RCIOBkLsW1u46nO27yj8S1tK+PjOlNC
   U7qgblQJSDzvL2aOYeZ4A9fbC/nugJGpZ9CsILCBLeceUlFvq3aIc1Bk5
   R/jeAvgo/zZMZZkYNFK7uwOQCGO/kjht2j+9sKxGUF6rsqvhIRahlJs6b
   qdZN9bE5kUhTvp//zPh0rDFQWx2oEVX2il+d9aGOWnhecsDVM6fZat/jW
   nRmM1GDvR/DiW1nbjxA9SIPVQ2vP5qKzC/k3HzDa8nT9AiBrzZhIs6r+9
   g==;
X-CSE-ConnectionGUID: KZcytm0MRSaymEoNWZXFJw==
X-CSE-MsgGUID: SVhxAqNqShOzkIdQRQPAlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="39695321"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="39695321"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 02:56:31 -0800
X-CSE-ConnectionGUID: Y7CuIuy7RWWBpOkgyg8jpA==
X-CSE-MsgGUID: aFmpx/LzTN6y0ale2QzYlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119012041"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Feb 2025 02:56:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjynV-001D0p-0I;
	Mon, 17 Feb 2025 10:56:21 +0000
Date: Mon, 17 Feb 2025 18:55:43 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	quic_jjohnson@quicinc.com, quic_pyarlaga@quicinc.com,
	quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
	quic_mrana@quicinc.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 6/8] bus: mhi: host: Add support for Bandwidth scale
Message-ID: <202502171823.5VC7a1E6-lkp@intel.com>
References: <20250217-mhi_bw_up-v1-6-9bad1e42bdb1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-mhi_bw_up-v1-6-9bad1e42bdb1@oss.qualcomm.com>

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0ad2507d5d93f39619fc42372c347d6006b64319]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Chaitanya-Chundru/PCI-update-current-bus-speed-as-part-of-pci_bus_add_devices/20250217-144050
base:   0ad2507d5d93f39619fc42372c347d6006b64319
patch link:    https://lore.kernel.org/r/20250217-mhi_bw_up-v1-6-9bad1e42bdb1%40oss.qualcomm.com
patch subject: [PATCH 6/8] bus: mhi: host: Add support for Bandwidth scale
config: x86_64-buildonly-randconfig-006-20250217 (https://download.01.org/0day-ci/archive/20250217/202502171823.5VC7a1E6-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250217/202502171823.5VC7a1E6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502171823.5VC7a1E6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bus/mhi/host/init.c:682:6: warning: variable 'doorbell' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     682 |         if (mhi_cntrl->get_misc_doorbell)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/mhi/host/init.c:685:6: note: uninitialized use occurs here
     685 |         if (doorbell > 0) {
         |             ^~~~~~~~
   drivers/bus/mhi/host/init.c:682:2: note: remove the 'if' if its condition is always true
     682 |         if (mhi_cntrl->get_misc_doorbell)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     683 |                 doorbell = mhi_cntrl->get_misc_doorbell(mhi_cntrl, MHI_ER_BW_SCALE);
   drivers/bus/mhi/host/init.c:548:22: note: initialize the variable 'doorbell' to silence this warning
     548 |         int i, ret, doorbell;
         |                             ^
         |                              = 0
   1 warning generated.


vim +682 drivers/bus/mhi/host/init.c

   544	
   545	int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
   546	{
   547		u32 val;
   548		int i, ret, doorbell;
   549		struct mhi_chan *mhi_chan;
   550		struct mhi_event *mhi_event;
   551		void __iomem *base = mhi_cntrl->regs;
   552		struct device *dev = &mhi_cntrl->mhi_dev->dev;
   553		struct {
   554			u32 offset;
   555			u32 val;
   556		} reg_info[] = {
   557			{
   558				CCABAP_HIGHER,
   559				upper_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
   560			},
   561			{
   562				CCABAP_LOWER,
   563				lower_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
   564			},
   565			{
   566				ECABAP_HIGHER,
   567				upper_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
   568			},
   569			{
   570				ECABAP_LOWER,
   571				lower_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
   572			},
   573			{
   574				CRCBAP_HIGHER,
   575				upper_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
   576			},
   577			{
   578				CRCBAP_LOWER,
   579				lower_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
   580			},
   581			{
   582				MHICTRLBASE_HIGHER,
   583				upper_32_bits(mhi_cntrl->iova_start),
   584			},
   585			{
   586				MHICTRLBASE_LOWER,
   587				lower_32_bits(mhi_cntrl->iova_start),
   588			},
   589			{
   590				MHIDATABASE_HIGHER,
   591				upper_32_bits(mhi_cntrl->iova_start),
   592			},
   593			{
   594				MHIDATABASE_LOWER,
   595				lower_32_bits(mhi_cntrl->iova_start),
   596			},
   597			{
   598				MHICTRLLIMIT_HIGHER,
   599				upper_32_bits(mhi_cntrl->iova_stop),
   600			},
   601			{
   602				MHICTRLLIMIT_LOWER,
   603				lower_32_bits(mhi_cntrl->iova_stop),
   604			},
   605			{
   606				MHIDATALIMIT_HIGHER,
   607				upper_32_bits(mhi_cntrl->iova_stop),
   608			},
   609			{
   610				MHIDATALIMIT_LOWER,
   611				lower_32_bits(mhi_cntrl->iova_stop),
   612			},
   613			{0, 0}
   614		};
   615	
   616		dev_dbg(dev, "Initializing MHI registers\n");
   617	
   618		/* Read channel db offset */
   619		ret = mhi_get_channel_doorbell_offset(mhi_cntrl, &val);
   620		if (ret)
   621			return ret;
   622	
   623		if (val >= mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB)) {
   624			dev_err(dev, "CHDB offset: 0x%x is out of range: 0x%zx\n",
   625				val, mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB));
   626			return -ERANGE;
   627		}
   628	
   629		/* Setup wake db */
   630		mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
   631		mhi_cntrl->wake_set = false;
   632	
   633		/* Setup channel db address for each channel in tre_ring */
   634		mhi_chan = mhi_cntrl->mhi_chan;
   635		for (i = 0; i < mhi_cntrl->max_chan; i++, val += 8, mhi_chan++)
   636			mhi_chan->tre_ring.db_addr = base + val;
   637	
   638		/* Read event ring db offset */
   639		ret = mhi_read_reg(mhi_cntrl, base, ERDBOFF, &val);
   640		if (ret) {
   641			dev_err(dev, "Unable to read ERDBOFF register\n");
   642			return -EIO;
   643		}
   644	
   645		if (val >= mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings)) {
   646			dev_err(dev, "ERDB offset: 0x%x is out of range: 0x%zx\n",
   647				val, mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings));
   648			return -ERANGE;
   649		}
   650	
   651		/* Setup event db address for each ev_ring */
   652		mhi_event = mhi_cntrl->mhi_event;
   653		for (i = 0; i < mhi_cntrl->total_ev_rings; i++, val += 8, mhi_event++) {
   654			if (mhi_event->offload_ev)
   655				continue;
   656	
   657			mhi_event->ring.db_addr = base + val;
   658		}
   659	
   660		/* Setup DB register for primary CMD rings */
   661		mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
   662	
   663		/* Write to MMIO registers */
   664		for (i = 0; reg_info[i].offset; i++)
   665			mhi_write_reg(mhi_cntrl, base, reg_info[i].offset,
   666				      reg_info[i].val);
   667	
   668		ret = mhi_write_reg_field(mhi_cntrl, base, MHICFG, MHICFG_NER_MASK,
   669					  mhi_cntrl->total_ev_rings);
   670		if (ret) {
   671			dev_err(dev, "Unable to write MHICFG register\n");
   672			return ret;
   673		}
   674	
   675		ret = mhi_write_reg_field(mhi_cntrl, base, MHICFG, MHICFG_NHWER_MASK,
   676					  mhi_cntrl->hw_ev_rings);
   677		if (ret) {
   678			dev_err(dev, "Unable to write MHICFG register\n");
   679			return ret;
   680		}
   681	
 > 682		if (mhi_cntrl->get_misc_doorbell)
   683			doorbell = mhi_cntrl->get_misc_doorbell(mhi_cntrl, MHI_ER_BW_SCALE);
   684	
   685		if (doorbell > 0) {
   686			ret = mhi_init_bw_scale(mhi_cntrl, doorbell);
   687			if (!ret)
   688				mhi_cntrl->bw_scale_db = base + val + (8 * doorbell);
   689			else
   690				dev_warn(dev, "BW scale setup failure\n");
   691		}
   692		return 0;
   693	}
   694	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

