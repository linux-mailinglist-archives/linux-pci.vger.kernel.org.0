Return-Path: <linux-pci+bounces-2120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E81C982C41E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 17:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5771F24645
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 16:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247F01B587;
	Fri, 12 Jan 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raoXKiHL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056921B583;
	Fri, 12 Jan 2024 16:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCEBC433F1;
	Fri, 12 Jan 2024 16:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705078778;
	bh=gRmE0uSHe6qkMFSB6r/agyZMWWhTO58EVZ1pZeZ1v5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=raoXKiHLIFd4doYn61RkJqFc4ZoqGVWZU9bYcnidJHW2dCfE2/a25WsfNOrE0Is87
	 2kwvfu1l4GW3FW++gau4piUzZgFWQgmc8GK8L9jHF53VI5xa0XDsfyw2KDpu1UxqpH
	 ZZDN3B56ZwzIsIBXWYWEruJ43jhM8TWu2gfdtOTweaa4A9gd/vORTHwQRRJ6SSFIhE
	 aWcxqbOWlPu4zUiYPn4GgQN8GNNVNVXkhAP+Ob9PYsvmOZwuhQpFOw9DbBAVPzfyn1
	 TMGoxz2MnOskeIsLM2+ZFacwKC+PJrrZc6VrkNUUo78y0UlRCD00J+nS/p2gYcKHE6
	 0BBvKQ5icbn8w==
Date: Fri, 12 Jan 2024 10:59:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, will@kernel.org, frowand.list@gmail.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2 2/2] PCI: Add support for "preserve-boot-config"
 property
Message-ID: <20240112165936.GA2272366@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110030725.710547-3-vidyas@nvidia.com>

On Wed, Jan 10, 2024 at 08:37:25AM +0530, Vidya Sagar wrote:
> Add support for "preserve-boot-config" property that can be used to
> selectively (i.e. per host bridge) instruct the kernel to preserve the
> boot time configuration done by the platform firmware.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Addressed issues reported by kernel test robot <lkp@intel.com>

I don't think the lkp Reported-by adds useful information in this
case.  I have no idea what lkp actually reported, but I don't think it
reported a bug that is fixed by this patch.

