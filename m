Return-Path: <linux-pci+bounces-29124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDD4AD0B16
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 04:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1852B189697E
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 02:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB8B17B418;
	Sat,  7 Jun 2025 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cnodktz0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85811713;
	Sat,  7 Jun 2025 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749264926; cv=none; b=cA81xJhjO8tqVxGpQ5d5VOL6IYPcOa+5oVPzVPCxxrc06HR7T7z302lf7ccb8ZFEdNj3XXlV4zasf4tQkxePvdzbvbfvhs7JFOGdwNSXkmYvpA7R8rKqFt2VOakoXd94NgRD7aMz/3seMIhoer+HwRHH0JG9Zq1U/h8a/eJ/H3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749264926; c=relaxed/simple;
	bh=J3kuwWx/dgZ9Iw6XWWRu56SG6jETIxQCXj2BzNl0DMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ma0i0QaHgPziu0r6CGqg28f1uXg1JDjihPxzU9ZCqZvfwvDj64ia6tiMnnjZ14BvdOEpt++aee3MCpKRloBtwAi1GBRIy19+dwHJ3/kIo1dXQLTSqaM5dQQvrKAX9UIapBna0qYzg7Ngjx5Ja2Ussrs01hwQ4BmgW714n//eKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cnodktz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63065C4CEEF;
	Sat,  7 Jun 2025 02:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749264925;
	bh=J3kuwWx/dgZ9Iw6XWWRu56SG6jETIxQCXj2BzNl0DMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cnodktz0uzAJM2o7owR6yp9p+LNAC7r9QimMGzii9uJSKBt4owpPRUwGDUyc+Cgxk
	 at2WEiAVc0ucuIZIkwGb6fLyGZbnVg5rR+UTtr6urvmyDoKeXG9mDI3Gdnyu6OuVhC
	 iLCnhJjsWUNgAFka96vStqahsac5wg3Pg+L4ZzULDG97MGKxZuYsMfl0DEop/4cj8k
	 faoxojozGg5FJxVq6ugNvkOXXEzDd/wHNJHALtQI1Vhu2AY4ao+wSiCV+2jmsUkIFf
	 UrkwjhhIAToWGRhhGRXl6+m3NB8XagFkhOruwzstR2Ki7GYwNkDyNgSb4zlgfF/Ifa
	 FBiTrTock7O2w==
Date: Fri, 6 Jun 2025 19:55:06 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] PCI: Add debugfs support for exposing PTM context
Message-ID: <20250607025506.GA16607@sol>
References: <20250505-pcie-ptm-v4-0-02d26d51400b@linaro.org>
 <20250505-pcie-ptm-v4-1-02d26d51400b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-pcie-ptm-v4-1-02d26d51400b@linaro.org>

On Mon, May 05, 2025 at 07:54:39PM +0530, Manivannan Sadhasivam wrote:
> Precision Time Management (PTM) mechanism defined in PCIe spec r6.0,
> sec 6.21 allows precise coordination of timing information across multiple
> components in a PCIe hierarchy with independent local time clocks.
> 
> PCI core already supports enabling PTM in the root port and endpoint
> devices through PTM Extended Capability registers. But the PTM context
> supported by the PTM capable components such as Root Complex (RC) and
> Endpoint (EP) controllers were not exposed as of now.
> 
> Hence, add the debugfs support to expose the PTM context to userspace from
> both PCIe RC and EP controllers. Controller drivers are expected to call
> pcie_ptm_create_debugfs() to create the debugfs attributes for the PTM
> context and call pcie_ptm_destroy_debugfs() to destroy them. The drivers
> should also populate the relevant callbacks in the 'struct pcie_ptm_ops'
> structure based on the controller implementation.
> 
> Below PTM context are exposed through debugfs:
> 
> PCIe RC
> =======
> 
> 1. PTM Local clock
> 2. PTM T2 timestamp
> 3. PTM T3 timestamp
> 4. PTM Context valid
> 
> PCIe EP
> =======
> 
> 1. PTM Local clock
> 2. PTM T1 timestamp
> 3. PTM T4 timestamp
> 4. PTM Master clock
> 5. PTM Context update
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/ABI/testing/debugfs-pcie-ptm |  70 +++++++
>  MAINTAINERS                                |   1 +
>  drivers/pci/pcie/ptm.c                     | 300 +++++++++++++++++++++++++++++
>  include/linux/pci.h                        |  45 +++++
>  4 files changed, 416 insertions(+)

There's a build error on mainline from this commit:

    drivers/pci/pcie/ptm.c:498:25: error: redefinition of 'pcie_ptm_create_debugfs'
      498 | struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
          |                         ^
    ./include/linux/pci.h:1915:2: note: previous definition is here
     1915 | *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
          |  ^
    drivers/pci/pcie/ptm.c:546:6: error: redefinition of 'pcie_ptm_destroy_debugfs'
      546 | void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
          |      ^
    ./include/linux/pci.h:1918:1: note: previous definition is here
     1918 | pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs) { }
          | ^

This is with CONFIG_DEBUG_FS=n && CONFIG_PCIE_PTM=y.

- Eric

