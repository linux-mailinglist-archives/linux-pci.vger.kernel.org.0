Return-Path: <linux-pci+bounces-8588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88853903EE9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 16:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2E52888D8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 14:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812A17D896;
	Tue, 11 Jun 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic5AivQK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDFC17334F;
	Tue, 11 Jun 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116430; cv=none; b=RF2tU31/iPu97IbcUeO8i+FMlQK48zm+ziNDx3cKKmihcxhLvY5rk+Slb92aGuEGEQsL+LVXl0Ok29wGGcY7l/R+7AajdYQkxeihYLlfUzPV3kIDSfcWEb2VUVLwcXhPCQjsqA1qriOMpLU/K0QVLDYe3O1msMoj7/ipNXbwbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116430; c=relaxed/simple;
	bh=1Gfmd22MdyE4c6kjHTg8DYBHk4MwC75KHF+vOLMBe68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0h2WfC341+XV4qEjD3N3lw/ekldaiPS+VVgyYv12TSB+e5dROj+kcDIsG3tElAMvuin4yVeZsVPfqmQsHpLJgr/mx3Ve8BV1rm599tss93bktk2NpDR1ltgL89+Wa/gn5QZ92DhOVAokkPry4xc7W9XmrzO3ZJ/vbJL6Xsw/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic5AivQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC74CC4AF49;
	Tue, 11 Jun 2024 14:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718116430;
	bh=1Gfmd22MdyE4c6kjHTg8DYBHk4MwC75KHF+vOLMBe68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ic5AivQKXA+Q+xBn4RPcoGjD8bR87ZDP31B8UM+OhdbAcTJJ6HRD2kAvvecf2dAH7
	 eCHaukta5Xy4hFl3OSBo6thu74CmTFMbR6pctVZFxg6ij+9pPmZF4sh67WvnMaaAl0
	 DC4sBBxQN+pPVA3TSQNJtlmnPR5MM+bXOEQZS8YzesR7/yhYGPtY6sk9iFWol8DdHp
	 D7Zqfrop1TeFwppVYREQbsTY7TDw/09U+K7zV5/vxb3469B+6Zr81tRsuGOA8vnpM3
	 jsM1R1+KzwX2yFSqL9voPwZu8cMZ3c9b+7bEZrgAVQ85gckvw6OcdawzZxO9NrfImf
	 DQopcU2rUtkPw==
Date: Tue, 11 Jun 2024 08:33:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	lukas@wunner.de, bhelgaas@google.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: pciehp: fix concurrent sub-tree removal deadlock
Message-ID: <ZmhgS-Zyg3-3NxNI@kbusch-mbp.dhcp.thefacebook.com>
References: <20240610220304.3162895-2-kbusch@meta.com>
 <202406111416.XIxUrEy4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406111416.XIxUrEy4-lkp@intel.com>

On Tue, Jun 11, 2024 at 02:19:09PM +0800, kernel test robot wrote:
> url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/PCI-pciehp-fix-concurrent-sub-tree-removal-deadlock/20240611-060555
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20240610220304.3162895-2-kbusch%40meta.com
> patch subject: [PATCH 1/2] PCI: pciehp: fix concurrent sub-tree removal deadlock
> config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240611/202406111416.XIxUrEy4-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240611/202406111416.XIxUrEy4-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406111416.XIxUrEy4-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/pci/of.c:16:
>    drivers/pci/pci.h: In function 'pci_dev_set_disconnected':
> >> drivers/pci/pci.h:416:9: error: implicit declaration of function 'pci_notify_disconnected'; did you mean 'pci_doe_disconnected'? [-Werror=implicit-function-declaration]
>      416 |         pci_notify_disconnected();
>          |         ^~~~~~~~~~~~~~~~~~~~~~~
>          |         pci_doe_disconnected
>    cc1: some warnings being treated as errors

Interesting, drivers/pci/of.c depends on CONFIG_OF, but not CONFIG_PCI.
Okay, I can stub the function in that case.

