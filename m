Return-Path: <linux-pci+bounces-5176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB6588C145
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 12:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AE72E8431
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 11:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35396CDA3;
	Tue, 26 Mar 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNZfpLnw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFCB6A8DE;
	Tue, 26 Mar 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453958; cv=none; b=dDAdieDl6/U+Tk8jJZn74fgdc4EuCWHSFnE8/D+MgtQoyFtMZM+NhgApFwRJDzSZ7xfxmZx9kSnqgSus8egEUYL2LUZnWEpBKDMy25BGs4TH1kt4asCQxQFvcIYZozq6YIbTitdySoJnFagzwinxltnMs9wRrRog8m1kkigE89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453958; c=relaxed/simple;
	bh=Ripkw0UBn+MHikzr9FuCjMa2Yr9EXFAnghPx/qmt+uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOR8JIGGftz214k5QYWyBDXZWm/sVsHrDOZMeCyzOutJAQmOiXea81ia+wnsWMy5nuIX/2Dupr652uyr2TrQnThVDE1BuDPTKzoy39y1ZqPFAsO8cH41toC5e/lfxNBtYmHyJ2pybEHaJMsI6c+S8Mj9Caleq9uO6qPKgqVKxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNZfpLnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630A5C433F1;
	Tue, 26 Mar 2024 11:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711453958;
	bh=Ripkw0UBn+MHikzr9FuCjMa2Yr9EXFAnghPx/qmt+uE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WNZfpLnwy9bLIcOMl0SW5GHK1t/cKSi/udvzFhR4g9KwWbAjFEOU/x0vSeRr64HuR
	 sYx3BDBXQhBXIPRUWGstgCIkpvyuD3wwG/S3JV1zbQga79jQCn2NAy12ZqVUctIqrY
	 zFyEGM2P3+juCZWncRN5D1irBdyeEVlxPIyIGxKHrRTtwltYHcib23cJRIjQ4VITE2
	 heTGVvwwvRFSJtt4fMGQWvBp0ORtF5FrzvyTJr09Cvv5C/+WiN0YaY+12/znYdzhBK
	 Y9WBjdCexD/zhveIgHDc4Ieq/IccOHz3W3V0RJgfnJ8ZoLrreP095DWUps78rWhXkU
	 9oNKVJUeRURrw==
Message-ID: <f13e9775-9dca-4a8f-b6bb-6d5a8f6dbccd@kernel.org>
Date: Tue, 26 Mar 2024 20:52:36 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pci:enumeration 28/28] drivers/mfd/intel-lpss-pci.c:57:49:
 error: 'PCI_IRQ_LEGACY' undeclared; did you mean 'NR_IRQS_LEGACY'?
Content-Language: en-US
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>
References: <202403261840.1RP419n5-lkp@intel.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <202403261840.1RP419n5-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/24 19:19, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
> head:   8694697a54096ae97eb38bf4144f2d96c64c68f2
> commit: 8694697a54096ae97eb38bf4144f2d96c64c68f2 [28/28] PCI: Remove PCI_IRQ_LEGACY
> config: i386-buildonly-randconfig-001-20240326 (https://download.01.org/0day-ci/archive/20240326/202403261840.1RP419n5-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240326/202403261840.1RP419n5-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403261840.1RP419n5-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/mfd/intel-lpss-pci.c: In function 'intel_lpss_pci_probe':
>>> drivers/mfd/intel-lpss-pci.c:57:49: error: 'PCI_IRQ_LEGACY' undeclared (first use in this function); did you mean 'NR_IRQS_LEGACY'?
>       57 |         ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
>          |                                                 ^~~~~~~~~~~~~~
>          |                                                 NR_IRQS_LEGACY
>    drivers/mfd/intel-lpss-pci.c:57:49: note: each undeclared identifier is reported only once for each function it appears in

Bjorn,

Not sure what is going on here. I did an allyesconfig build on x86_64 and did
not see such issue. Did the build bot missed some patches ?

And the above also reminds me that we could change NR_IRQS_LEGACY to
NR_IRQS_INTX too.

-- 
Damien Le Moal
Western Digital Research


