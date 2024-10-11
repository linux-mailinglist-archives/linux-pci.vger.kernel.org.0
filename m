Return-Path: <linux-pci+bounces-14258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0C8999BFD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 07:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A125A1C226AF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 05:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0541CC174;
	Fri, 11 Oct 2024 05:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqDn6Jub"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF519413B;
	Fri, 11 Oct 2024 05:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728623766; cv=none; b=B7SJxVp/7z70sbjVEkDBQDg9c/7iO5f9L/ZhpDPLcfOjdTaAE1oGJU/Fy6F8TNQqCRBrYO6Yw10Yf05sz4X4j5MM3crVoj+q5X9dNpgzJcKqjRD0a2a0HOGG75NlZEFEkAmWf5hD7AEPzww8Rbsfl/Y871Q/nR0K/N/PMS61J5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728623766; c=relaxed/simple;
	bh=oXPKp2uZEnGUtYeEYnykIZVlicObW/XIzlul2tJetiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5YUyOLiC5UW8mLDUyF1yAyBZsnFu/vSKc42Xi45UYjywQ/TZj0jb7GmtJrPn1OCifh6qiPwvw6S1G66WH44Rtqtb63Ct1WVI5f7+z72SbJWTksvKYKBnAfhFXAWNCRftr0TCo9IV/PQplLxio8VUmvsWc/i7khRYb1pAgNwpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqDn6Jub; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728623765; x=1760159765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oXPKp2uZEnGUtYeEYnykIZVlicObW/XIzlul2tJetiM=;
  b=aqDn6Jub7ozeAIoxC89IEE0rH5sUrzxTa1FHevE35iqRvBgW9CR7FGdV
   BZpIHQffGs+82CPwX++P6Qx8pPmpqNwP7yaBOa2hwiVmTr0qOCj2+cplU
   hRcqaXXHPIkxCbAyJ6+pJNwTHOCHPArFwk3tK7yiqThLmQ93zwcUving4
   R1MFYqGf358jglqN1PLuJDgXbH9W2L/iRoY5IzE7QyaeWQY0eAfKMt6ag
   x9rgzz2RejXtsc8GPe+nRCZZ13gjKuODmRklSpNizP1CMAf82/k1wz2gv
   sMx+JK3x6MPIpGYlaV/X2DRTR+EQwb0E4kUV6vImvXSsIMIzQF6dHZ5gB
   A==;
X-CSE-ConnectionGUID: MpXxEBQlQSy67j8lPbZOrA==
X-CSE-MsgGUID: 5fk4wcPEQNy3YmIvUwiWJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="15635861"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="15635861"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:16:04 -0700
X-CSE-ConnectionGUID: OcOAqgggRkynTfXpGipgfQ==
X-CSE-MsgGUID: FrTbE1n2TLajNJFQH08VTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76716322"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Oct 2024 22:15:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sz80I-000Bq9-0p;
	Fri, 11 Oct 2024 05:15:54 +0000
Date: Fri, 11 Oct 2024 13:15:32 +0800
From: kernel test robot <lkp@intel.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 11/14] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <202410111247.L5n2NDAU-lkp@intel.com>
References: <c5b072393d2dc157d34f6dbeff6261d142d4de69.1728300190.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b072393d2dc157d34f6dbeff6261d142d4de69.1728300190.git.andrea.porta@suse.com>

Hi Andrea,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on clk/clk-next char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.12-rc2 next-20241010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-della-Porta/dt-bindings-clock-Add-RaspberryPi-RP1-clock-bindings/20241007-204440
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/c5b072393d2dc157d34f6dbeff6261d142d4de69.1728300190.git.andrea.porta%40suse.com
patch subject: [PATCH v2 11/14] misc: rp1: RaspberryPi RP1 misc driver
config: sparc-kismet-CONFIG_OF_IRQ-CONFIG_MISC_RP1-0-0 (https://download.01.org/0day-ci/archive/20241011/202410111247.L5n2NDAU-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20241011/202410111247.L5n2NDAU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410111247.L5n2NDAU-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for OF_IRQ when selected by MISC_RP1
   WARNING: unmet direct dependencies detected for OF_IRQ
     Depends on [n]: OF [=y] && !SPARC [=y] && IRQ_DOMAIN [=y]
     Selected by [y]:
     - MISC_RP1 [=y] && PCI [=y] && PCI_QUIRKS [=y]
   
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
     Depends on [n]: SPARSEMEM [=n]
     Selected by [y]:
     - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

