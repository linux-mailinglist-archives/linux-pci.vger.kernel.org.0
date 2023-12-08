Return-Path: <linux-pci+bounces-705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8550C80AB36
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 18:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25C91C20A8B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09373B795;
	Fri,  8 Dec 2023 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGxycqgj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED83B787;
	Fri,  8 Dec 2023 17:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9017C433C9;
	Fri,  8 Dec 2023 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702057994;
	bh=WF3sxOQXZ3wLw83HJCehVvDgBYIVEarCTX/DeEoTsgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eGxycqgj63COmF0qtUQFBePJ0mPdT2BJNNnDWkCgHzbJ2siwtIgN1SHMUtVWygUGR
	 ppDKj0ShIsRzytOd4fDSO6nHoubQbLjF7lqT4IcYvpmlVxzeZHo1znch1/4reOSwMm
	 tPODYcSTifUfHzs/1ewcVh4pFM5iyntUJOwdiPUGixyMVuvqQkIirJ9RUZ3JA9I65n
	 QFsYz4sHOBnW9E8sU4hjCYRLTphTNG+d8LxV8R89PSHYcIJFcVhYLnzKOeAF4xvzXr
	 +8VH94qPGsSeZVClZprqW/ygYUhbBpfuZDdFZkk38/h1PfzlDyCHZLGruP2GpLEVip
	 iQuuY5jkbVeKQ==
Date: Fri, 8 Dec 2023 11:53:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: Fix deadlocks when enabling ASPM
Message-ID: <20231208175312.GA803148@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128081512.19387-1-johan+linaro@kernel.org>

On Tue, Nov 28, 2023 at 09:15:06AM +0100, Johan Hovold wrote:
> The pci_enable_link_state() helper is currently only called from
> pci_walk_bus(), something which can lead to a deadlock as both helpers
> take a pci_bus_sem read lock.
> 
> Add a new locked helper which can be called with the read lock held and
> fix up the two current users (the second is new in 6.7-rc1).
> 
> Note that there are no users left of the original unlocked variant after
> this series, but I decided to leave it in place for now (e.g. to mirror
> the corresponding helpers to disable link states).
> 
> Included are also a couple of related cleanups.
> 
> Johan
> 
> 
> Changes in v2
>  - fix up the function name in a kernel doc comment as reported by the
>    kernel test robot <lkp@intel.com>
> 
> 
> Johan Hovold (6):
>   PCI/ASPM: Add locked helper for enabling link state
>   PCI: vmd: Fix deadlock when enabling ASPM
>   PCI: qcom: Fix deadlock when enabling ASPM
>   PCI: qcom: Clean up ASPM comment
>   PCI/ASPM: Clean up disable link state parameter
>   PCI/ASPM: Add lockdep assert to link state helper
> 
>  drivers/pci/controller/dwc/pcie-qcom.c |  7 ++-
>  drivers/pci/controller/vmd.c           |  2 +-
>  drivers/pci/pcie/aspm.c                | 65 +++++++++++++++++++-------
>  include/linux/pci.h                    |  3 ++
>  4 files changed, 56 insertions(+), 21 deletions(-)

Applied to for-linus for v6.7, thanks, Johan!

