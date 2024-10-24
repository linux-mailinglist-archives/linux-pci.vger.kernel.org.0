Return-Path: <linux-pci+bounces-15194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2AB9AE425
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 13:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C02E1F2474D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5132B1CFEA2;
	Thu, 24 Oct 2024 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jv9NaMRk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E401A0BC4;
	Thu, 24 Oct 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770523; cv=none; b=PEeYKYIFXxeMLAAcnn4D5AaGZJkPCMnJQd3BApVBdkDZsSRH0q6ewArP5UcsvRRkgZnNnLtuEQEvS23xYybn6wW/1hGDvU+A1KKjsHQrEHqbHAvfyP8JF9mxKSYvDVE3jaOS5UA7rwu8iNzl6M6sVcZi2cQng2Q2DS4f2lyTkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770523; c=relaxed/simple;
	bh=d+qe/+ODoW5q7XT1R1VfgK5+hBdUWlBAmc0IyODhTEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CskCdefWEBekP4KZanOuT8kxWmoujjFFfiqzNf1QyFlF4Y7LckclSsRz+L71nf2yub/ypZXeM3bwQlFYkQqs9fS0jxcPvR/zuAA0MiB7k0TxztMp2cXt7hAe9unTRrStR/c5ojFclYWtQQ7+9LyNkv6zkl7mzoKwVgNuEy8cmKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jv9NaMRk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729770521; x=1761306521;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=d+qe/+ODoW5q7XT1R1VfgK5+hBdUWlBAmc0IyODhTEU=;
  b=jv9NaMRkIVM+KcS9sb7u8LIIvIDxYkXI3Gy/94ZY6Sia71Sm/tf0k4ec
   Vj5pbISK3MXNgF1wkTvmY4kX9RKCZNMRCg6WlHzAGkCc1Ts/9NCwi0822
   CpRj9Q7j+6BJE3zvo4hI392fi68Mv/zK0aIIFWRTqhoFgZzmMCG3aJRzI
   xvpuDfIODQUjLbxrqy06wAkpH2CboieUHnZXLxU7gm/ckOiDkWHGUo/pz
   EO8AOYGJVsdxH+50BLWEPEC5cFwHcijEmyLBF9EbS7txmj5kHxJr9mcyK
   stM2hdnml2/ajY0b82bRTQcIGcCWq4L7uAP0HQ6MB6q0NUM9aosUHsyw+
   w==;
X-CSE-ConnectionGUID: leMACKUsREK04hfvB33ECA==
X-CSE-MsgGUID: lAzpuLPSTwi9HBvMR1zhRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46884354"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="46884354"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 04:48:40 -0700
X-CSE-ConnectionGUID: KZjPdK6kSvSUdStGO1YFkw==
X-CSE-MsgGUID: 9RK3dTjhQg26wkfpdI3qGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="111385152"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2024 04:48:29 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Boris Brezillon <bbrezillon@kernel.org>, Arnaud Ebalard
 <arno@natisbad.org>, Srujana Challa <schalla@marvell.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, Serge
 Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Kevin Cernekee <cernekee@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Philipp Stanner <pstanner@redhat.com>, Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jie Wang
 <jie.wang@intel.com>, Tero Kristo <tero.kristo@linux.intel.com>, Adam
 Guerin <adam.guerin@intel.com>, Shashank Gupta <shashank.gupta@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Bharat Bhushan
 <bbhushan2@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Johannes Berg <johannes.berg@intel.com>, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>, Gregory Greenman
 <gregory.greenman@intel.com>, Benjamin Berg <benjamin.berg@intel.com>,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>, Breno Leitao
 <leitao@debian.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, qat-linux@intel.com,
 linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org,
 alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v4 05/10] intel_th: pci: Replace deprecated PCI functions
In-Reply-To: <20241016124136.41540-6-pstanner@redhat.com>
References: <20241016124136.41540-1-pstanner@redhat.com>
 <20241016124136.41540-6-pstanner@redhat.com>
Date: Thu, 24 Oct 2024 14:48:27 +0300
Message-ID: <878qudvi0k.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Philipp Stanner <pstanner@redhat.com> writes:

> pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>
> Replace these functions with their successors, pcim_iomap() and
> pcim_request_all_regions().
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Regards,
--
Alex

