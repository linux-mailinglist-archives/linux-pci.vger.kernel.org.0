Return-Path: <linux-pci+bounces-16607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43F09C640E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 23:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B47B1F22729
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 22:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBC821A717;
	Tue, 12 Nov 2024 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVwNhomQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6D21A707;
	Tue, 12 Nov 2024 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449310; cv=none; b=jw8FDydMtMnTUoW5ec78dDd5qIlyhTj0frvzQiapI4RClMuTwRZNHNyuEehqvN9JlOFfWKGU8iZZ99ROc+Ot9Vj6pWAOU1dJ186cJTOB8xbevqcsQo8BFzI0t3UL6ra2Kx5EyKH/WeB1h382SFgJSbdVctLThmkA0n5CSZ4sqHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449310; c=relaxed/simple;
	bh=bwOLoyFxYfjUqtJNi/9ZCqz09dTnm3t/9bGtqoLlI8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0Y8I01wtlYn7nu2tmnvN7ktw+OPNB5VXtgstSmU0G9iz/6oei5kDNjkgzFIYmBlzUR0GYT9Jj4MbDMmA4EvLJSQCLcvYlBfIHfyFhmt2NeUrGd0haWlFcTA00CmwRpX58NlZCs+Bv+DXrocBzHGd4cKMiAP9beYidb/ErYqzdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVwNhomQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731449309; x=1762985309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bwOLoyFxYfjUqtJNi/9ZCqz09dTnm3t/9bGtqoLlI8U=;
  b=IVwNhomQF4zWvejcrdwszuAZZGj5KqtQ/UmeU88Yw7IJ0RjbOHxFqm1v
   49CTwAyzSKjw+vliZjwNP3L/nXX/cqTLnxz7bJfwUkPjPWfwy3gpchnTR
   P/m2vH4I59QnoULZBzWDNBe5aQeGMW7T6BeGEuVwm0HgxrXE5oZqHq7BP
   dsIqY4o1SkbxPbOXO2Wf0l+X2M/neD7xmC6mhtSaB8gyPBvSFSDBH9LUr
   qukDURu/Vfum2vAV876J8t+lC97simAyWSK+sVOHcgCyMH19dVOr443Jx
   2lNPmnPpMXcBGg5ePayPlBPeO/52hGqXMbj32RaInN7kSbGwfvrDQfYoV
   g==;
X-CSE-ConnectionGUID: 3l5wpoqITy2Um7ytbQkcpg==
X-CSE-MsgGUID: 7DsUB2CqTSCk5Zrms4A9zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42722540"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="42722540"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 14:08:27 -0800
X-CSE-ConnectionGUID: QGh9vjHLSpKorf74bKXSXg==
X-CSE-MsgGUID: sKP0TcqbSXmgHwe8OkVCnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="91712794"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Nov 2024 14:08:16 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAz3W-0001lf-1j;
	Tue, 12 Nov 2024 22:08:14 +0000
Date: Wed, 13 Nov 2024 06:07:51 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v3 3/8] virtio: hookup irq_get_affinity callback
Message-ID: <202411130521.UOBdW8Rv-lkp@intel.com>
References: <20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8@kernel.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c9af98a7e8af266bae73e9d662b8341da1ec5824]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/driver-core-bus-add-irq_get_affinity-callback-to-bus_type/20241112-213257
base:   c9af98a7e8af266bae73e9d662b8341da1ec5824
patch link:    https://lore.kernel.org/r/20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8%40kernel.org
patch subject: [PATCH v3 3/8] virtio: hookup irq_get_affinity callback
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241113/202411130521.UOBdW8Rv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241113/202411130521.UOBdW8Rv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411130521.UOBdW8Rv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio.c:389: warning: Function parameter or struct member 'irq_veq' not described in 'virtio_irq_get_affinity'
>> drivers/virtio/virtio.c:389: warning: Excess function parameter 'irq_vec' description in 'virtio_irq_get_affinity'


vim +389 drivers/virtio/virtio.c

   379	
   380	/**
   381	 * virtio_irq_get_affinity - get IRQ affinity mask for device
   382	 * @_d: ptr to dev structure
   383	 * @irq_vec: interrupt vector number
   384	 *
   385	 * Return the CPU affinity mask for @_d and @irq_vec.
   386	 */
   387	static const struct cpumask *virtio_irq_get_affinity(struct device *_d,
   388							     unsigned int irq_veq)
 > 389	{
   390		struct virtio_device *dev = dev_to_virtio(_d);
   391	
   392		if (!dev->config->get_vq_affinity)
   393			return NULL;
   394	
   395		return dev->config->get_vq_affinity(dev, irq_veq);
   396	}
   397	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

