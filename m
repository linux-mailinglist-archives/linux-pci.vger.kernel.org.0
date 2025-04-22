Return-Path: <linux-pci+bounces-26436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986ADA975D0
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 21:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 274407AC599
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B43248193;
	Tue, 22 Apr 2025 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of56gwkV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28559190696;
	Tue, 22 Apr 2025 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351139; cv=none; b=Zl+OOkOUyCzXdMN0q4ACWjwsEZspATKGF3vskAI5RFH0vS+PW5bFT6Wna4vsQovfR6hKWFHuYkpJ/5rurGFRobYeQaZeXffYqiJUVmqZ8tOUvSCqSmVFlgs6iHkfEHIKrVae2WCzM/w26ni9TuxM/pkdQk6KVu814t07H8QSRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351139; c=relaxed/simple;
	bh=CYM/V6cFxtbhItJzQgn9R/ajKEcZx1GHgJCUs1VS2Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OPyl8QTen1DtTbDk6AUP6R5u4SirVT0UcFLJGjeEoSEiSCPvhIVC+brCx/5b12CaibcVJ1bFb8zYkiGUrrQwdQyophDdYj2RowVpRkuuNtElbKhvznTGzv5Fx33hvCDRGJwyI93VRS6z7ODeu9ztU/K9QOB6jvllGricLMyPPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of56gwkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7951BC4CEEB;
	Tue, 22 Apr 2025 19:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745351138;
	bh=CYM/V6cFxtbhItJzQgn9R/ajKEcZx1GHgJCUs1VS2Hg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Of56gwkVVsiCgNc8CA3SHKfVW92MJceLnSR1igUuJSp18YRTuirAnZ5FM/riQ+cXi
	 0XhsrFi4z/ejDApAxG8Q0iwksx57rFT8HxRlWeIe7XaMWaRnxILB2O65+LsZHN4j2P
	 UZhgYM7p8ztC/OAy5RFXxXZXfjedv1U3qlk7mDegOfowtNaLPQGLNKDdPeCD5mcYcb
	 EM5GCSs+sqEsfHM8SV6HKHtDzqTaU/Jz7sFNG+fOy0Gbh4y3DVPzHFYqe48TFuHb9T
	 KT7idG6YtnLXyb1gFoi/g9PspJ+XbRJPDfHfD3r7U7fyWUL4j4IV43X+JWIW6VbaIs
	 YjojV+S3maNbQ==
Date: Tue, 22 Apr 2025 14:45:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	lukas@wunner.de, aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v2] PCI/PM: Avoid suspending the device with errors
Message-ID: <20250422194537.GA380850@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422135341.2780925-1-raag.jadav@intel.com>

On Tue, Apr 22, 2025 at 07:23:41PM +0530, Raag Jadav wrote:
> If an error is triggered before or during system suspend, any bus level
> power state transition will result in unpredictable behaviour by the
> device with failed recovery. Avoid suspending such a device and leave
> it in its existing power state.
> 
> This only covers the devices that rely on PCI core PM for their power
> state transition.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> 
> v2: Synchronize AER handling with PCI PM (Rafael)
> 
> More discussion on [1].
> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/

Thanks for the pointer, but the commit log for this patch needs to be
complete in itself.  "Unpredictable behavior" is kind of hand-wavy and
doesn't really help understand the problem.

>  drivers/pci/pci-driver.c |  3 ++-
>  drivers/pci/pcie/aer.c   | 11 +++++++++++
>  include/linux/aer.h      |  2 ++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f57ea36d125d..289a1fa7cb2d 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -884,7 +884,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
>  		}
>  	}
>  
> -	if (!pci_dev->state_saved) {
> +	/* Avoid suspending the device with errors */
> +	if (!pci_aer_in_progress(pci_dev) && !pci_dev->state_saved) {

This looks potentially racy, since hardware can set bits in
PCI_EXP_DEVSTA at any time.

The comment restates the C code, but doesn't say *why*.  The "why" is
important for ongoing maintenance.

>  		pci_save_state(pci_dev);
>  
>  		/*
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 508474e17183..b70f5011d4f5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -233,6 +233,17 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>  
> +bool pci_aer_in_progress(struct pci_dev *dev)
> +{
> +	u16 reg16;
> +
> +	if (!pcie_aer_is_native(dev))
> +		return false;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
> +	return !!(reg16 & PCI_EXP_AER_FLAGS);
> +}
> +
>  static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
>  	int rc;
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 947b63091902..68ae5378256e 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -48,12 +48,14 @@ struct aer_capability_regs {
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> +bool pci_aer_in_progress(struct pci_dev *dev);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
>  #endif
>  
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -- 
> 2.34.1
> 

