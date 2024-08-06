Return-Path: <linux-pci+bounces-11393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD1D949A35
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 23:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964FD1C21132
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69857824A3;
	Tue,  6 Aug 2024 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZQKUccB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F0374C4;
	Tue,  6 Aug 2024 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979882; cv=none; b=siCMllTsoDp/3HFcxPpAzYa5dZuXqRr+wfwrmRvnqidgAzdCS0GS9hacasKr0wA5FfFY/Q2PJIeuva4s9v3E2LcELVypt/mmtTtZixvcItrQJIuMybdeAPCoC7Z5im4uWvc9SrPcT++jDuTtB/Kp3eSfE52XsOoPXTLvCROqdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979882; c=relaxed/simple;
	bh=VXxnYAXbd0tH8wNBXyr5xoQiqrp06Fe5NipXt7zMffg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FMJQwOAw993DTASVYAJGdeiVUmJoCuNK/uiYh5besPpObJHKZ14srYIHXqBgR6s2WIXOx1YT8GsjOeNox1UsEixq+IYK5gez8ZIREOUOw11nQTlY9SrRcM2jmYG10ugZf/ZHwSUEkJ7uGFkXn9t4VrrXOXivNBx78B5rvt35+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZQKUccB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F69EC32786;
	Tue,  6 Aug 2024 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722979881;
	bh=VXxnYAXbd0tH8wNBXyr5xoQiqrp06Fe5NipXt7zMffg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gZQKUccBftAz4FMArWnleyNoM4GvWjaFRRteMBtBaZdXEPS8nK/E0Zo6S1m8GfSFY
	 ZXyTU62WJ1wPJe2qbjGfMw4GCHQXgYHhR78nu90h3jIANHnDG8Nanu1LyaAEjLg0e2
	 Cotomg9CDKJXsNc4AASSPqxINhh5QdXgTSeHHiOAC0xzV1IsHhLAtDuaSZB2LGJdVs
	 otiUHmW3bmOlWsi8uiH/oiVQN4JBrUPcrdEqqFkE8ZQpW3eYldD9ZQp4tcF21wAjAg
	 Gy9CSTb2NZGcMz8FDh4fC9YWfRYz7OSgFZO32uRwAPetmTmrCq5I4JjMoo29FQt2fH
	 0Kkc1szLgYw5Q==
Date: Tue, 6 Aug 2024 16:31:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/2] ACPI: extlog: Trace CPER PCI Express Error Section
Message-ID: <20240806213118.GA78822@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527144356.246220-3-fabio.m.de.francesco@linux.intel.com>

On Mon, May 27, 2024 at 04:43:41PM +0200, Fabio M. De Francesco wrote:
> Currently, extlog_print() (ELOG) only reports CPER PCIe section (UEFI
> v2.10, Appendix N.2.7) to the kernel log via print_extlog_rcd(). Instead,
> the similar ghes_do_proc() (GHES) prints to kernel log and calls
> pci_print_aer() to report via the ftrace infrastructure.
> 
> Add support to report the CPER PCIe Error section also via the ftrace
> infrastructure by calling pci_print_aer() to make ELOG act consistently
> with GHES.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 30 ++++++++++++++++++++++++++++++
>  drivers/pci/pcie/aer.c     |  2 +-
>  include/linux/aer.h        | 13 +++++++++++--
>  3 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e025ae390737..007ce96f8672 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -131,6 +131,32 @@ static int print_extlog_rcd(const char *pfx,
>  	return 1;
>  }
>  
> +static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
> +			      int severity)
> +{
> +	struct aer_capability_regs *aer;
> +	struct pci_dev *pdev;
> +	unsigned int devfn;
> +	unsigned int bus;
> +	int aer_severity;
> +	int domain;
> +
> +	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> +	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
> +		aer_severity = cper_severity_to_aer(severity);
> +		aer = (struct aer_capability_regs *)pcie_err->aer_info;
> +		domain = pcie_err->device_id.segment;
> +		bus = pcie_err->device_id.bus;
> +		devfn = PCI_DEVFN(pcie_err->device_id.device,
> +				  pcie_err->device_id.function);
> +		pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
> +		if (!pdev)
> +			return;
> +		pci_print_aer(pdev, aer_severity, aer);
> +		pci_dev_put(pdev);
> +	}

I'm 100% in favor of making error reporting work and look the same
across GHES and ELOG.  But I do have to gripe a bit...

It's already unfortunate that GHES and the native AER handling are
separate paths that lead to the same place (__aer_print_error()).

I'm sorry that we need to add a third path that again does
fundamentally the same thing.  The fact that they're separate means
all the design, reviewing, testing, and maintenance effort is diluted,
and error handling always gets too little love in the first place.
I think this is a recipe for confusion.

  ghes_do_proc                                        # GHES
    apei_estatus_for_each_section
      ...
      if (guid_equal(sec_type, &CPER_SEC_PCIE))
        ghes_handle_aer
          cper_severity_to_aer
          aer_recover_queue
            kfifo_in_spinlocked(&aer_recover_ring)    # add to queue
          aer_recover_work_func                       # another thread
            kfifo_get(&aer_recover_ring)              # remove from queue
            pci_print_aer
              __aer_print_error         <---

  aer_irq                                             # native AER
    kfifo_put(&aer_fifo)                              # add to queue
  aer_isr                                             # another thread
    kfifo_get(&aer_fifo)                              # remove from queue
    ...
    aer_isr_one_error
      aer_process_err_devices
        aer_print_error
          __aer_print_error             <---

  extlog_print                                        # extlog (x86 only)
    apei_estatus_for_each_section
      ...
      if (guid_equal(sec_type, &CPER_SEC_PCIE))
        extlog_print_pcie
          cper_severity_to_aer
          pci_get_domain_bus_and_slot
          pci_print_aer
            __aer_print_error           <---

And we also have CXL paths that lead to __aer_print_error(), although
it seems like they at least start in the native AER (and maybe GHES?)
path and branch out somewhere.  My head is spinning.

Do I *object* to this patch?  No, not really; it's a trivial change in
drivers/pci/, and Rafael can add my

  Acked-by: Bjorn Helgaas <bhelgaas@google.com>

as needed.  But I am afraid we're making ourselves a maintenance
headache.

> +}
> +
>  static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> @@ -179,6 +205,10 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			if (gdata->error_data_length >= sizeof(*mem))
>  				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
>  						       (u8)gdata->error_severity);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> +			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
> +
> +			extlog_print_pcie(pcie_err, gdata->error_severity);
>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ac6293c24976..794aa15527ba 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -801,7 +801,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
>  }
> -EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
> +EXPORT_SYMBOL_GPL(pci_print_aer);
>  
>  /**
>   * add_error_device - list device to be handled
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 4b97f38f3fcf..fbc82206045c 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -42,17 +42,26 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_log *log);
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> +void pci_print_aer(struct pci_dev *dev, int aer_severity,
> +		   struct aer_capability_regs *aer);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> +static inline void pci_print_aer(struct pci_dev *dev, int aer_severity,
> +				 struct aer_capability_regs *aer)
> +{ }
>  #endif
>  
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -		    struct aer_capability_regs *aer);
> +#if defined(CONFIG_ACPI_APEI_PCIEAER)
>  int cper_severity_to_aer(int cper_severity);
> +#else
> +static inline int cper_severity_to_aer(int cper_severity) { return 0; }
> +#endif
> +
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		       int severity, struct aer_capability_regs *aer_regs);
>  #endif //_AER_H_
> -- 
> 2.45.1
> 

