Return-Path: <linux-pci+bounces-15145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517829AD36B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758CA1C22236
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB671D0499;
	Wed, 23 Oct 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzGPFcoF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C01D0420;
	Wed, 23 Oct 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706371; cv=none; b=pFu8nM4CQCa/xp71DiMVeW+KxDJoD6Y+IADK+VlXBrywA70ixrnivuGU4kHac0TdCfNxA99vlPyhbFOQctFPyEI+mSoDmfjMJPiWbPWCm35x8YRjULCBh2bXlhlTE1CETCqC7rjqTbJxlVtPMjA2ixHsLjMs7s34FnQcGHYxa7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706371; c=relaxed/simple;
	bh=cjzX0jTQee5FfQePq9zcsyQjuG5lIlyKCskZKxzBuCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RHYr2PWYSoUG4j7WAKmShc4BOcHh5JQZkjV8bUVenTuqzoGZCHdR6+4FrF9aJMl31/hG61eHS5J40dFF3rTwqByGMqsf/Fd/RTKSaoJEsH5OODxb/MPR6CgNWPTK+AYhwGnbTJd8QJoIbXrpUQKp16+vroEgaaDcVUzLWOiANd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzGPFcoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59993C4CEC6;
	Wed, 23 Oct 2024 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729706370;
	bh=cjzX0jTQee5FfQePq9zcsyQjuG5lIlyKCskZKxzBuCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hzGPFcoF1xsvePVXzi/+x3kpBYslriAo63a8iApJOnaqybyOotFSPKH/sYsKMACSQ
	 7LkKYCKRPVOCepkDhy0L0ZEtSMvy2gyv9cU8IQXaUeFJJCNYG77FJIrZho/J58avff
	 dWguJycTksNZ3JUjyH5bg0I6Rp3+H92coJEC4pNHHBZ/1fUiBBZ8pqAw+jGIrYSJmn
	 CkeoRXtx2lWdUX1LrW6f8ZvFscvTi4ImuQR7I2BQmouKCcdN99RDYCwjq+RrRFRwKw
	 knOfLzwg1fAzLWXByUZO2D8eyk7NBzGI0pIDXEiAaXdLple5mveosfOiqj5zb7aXY4
	 nXcaRM13ZQX8A==
Date: Wed, 23 Oct 2024 12:59:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, mario.limonciello@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 00/16] AMD NB and SMN rework
Message-ID: <20241023175928.GA921475@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023172150.659002-1-yazen.ghannam@amd.com>

On Wed, Oct 23, 2024 at 05:21:34PM +0000, Yazen Ghannam wrote:
> Hi all,
> 
> The theme of this set is decoupling the "AMD node" concept from the
> legacy northbridge support.
> 
> Additionally, AMD System Management Network (SMN) access code is
> decoupled and expanded too.
> 
> Patches 1-3 begin reducing the scope of AMD_NB.
> 
> Patches 4-9 begin moving generic AMD node support out of AMD_NB.
> 
> Patches 10-13 move SMN support out of AMD_NB and do some refactoring.
> 
> Patch 14 has HSMP reuse SMN functionality.
> 
> Patches 15-16 address userspace access to SMN.
> 
> I say "begin" above because there is more to do here. Ultimately, AMD_NB
> should only be needed for code used on legacy systems with northbridges.
> Also, any and all SMN users in the kernel need to be updated to use the
> central SMN code. Local solutions should be avoided.

Glad to see many of the PCI device IDs going away; thanks for working
on that!

The use of pci_get_slot() and pci_get_domain_bus_and_slot() is not
ideal since all those pci_get_*() interfaces are kind of ugly in my
opinion, and using them means we have to encode topology details in
the kernel.  But this still seems like a big improvement.

Bjorn

