Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF777A51E1
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 20:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjIRSQx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 14:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRSQw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 14:16:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE19DB;
        Mon, 18 Sep 2023 11:16:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444B1C433C7;
        Mon, 18 Sep 2023 18:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695061006;
        bh=2Mf/KGXjOsLhdTJn0eQyev4ZjscAq6j6d9GO+qy7b14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZFKfOA27gDIN3NHNZ1+QfDEaw+ZsgZWlXgJ0VTQEgYIXysloU1UY26e6yS8EXEAF9
         JE/b75loLovE5AwV/J0DihYHt3CwzH9uvQwGrsbl2rilK2TJvVu2YmlUkn08IqzEkN
         6WlW7yiC256+krGc3NwsHLd8P5cyVjoGtbNRe/qOo0yjsi3ON/SCX/S/kGiUQLUHHm
         yas9aehqyAd9BPH5u7vuBsMB1DOpFs/lWpC9R6DQGvimGDdnRdLi67rgRwAcUk6VaO
         VFpIS4VWxXTWxFCr3NsaRRrDcnbGDvJ3fQpHfuPFL32Ns93Vf9EW5ulgEkWvyef/Xv
         gNaCsRGxJHAWQ==
Date:   Mon, 18 Sep 2023 13:16:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [RFC PATCH 1/1] ACPI / APEI: Fix for overwriting aer info when
 error status data have multiple sections
Message-ID: <20230918181644.GA197123@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1a4d76b89c44437b328fe8a6d3517dc@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Rafael, probably the logical place to apply this]

On Mon, Sep 18, 2023 at 01:07:45PM +0000, Shiju Jose wrote:
> >-----Original Message-----
> >From: Bjorn Helgaas <helgaas@kernel.org>
> > ...

> >On Sat, Sep 16, 2023 at 01:44:35AM +0800, shiju.jose@huawei.com wrote:
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> ghes_handle_aer() lacks synchronization with
> >> aer_recover_work_func(), so when error status data have multiple
> >> sections, aer_recover_work_func() may use estatus data for
> >> aer_capability_regs after it has been overwritten.
> >>
> >> The problem statement is here,
> >> https://lore.kernel.org/all/20230901225755.GA90053@bhelgaas/
> >>
> >> In ghes_handle_aer() allocates memory for aer_capability_regs from the
> >> ghes_estatus_pool and copy data for aer_capability_regs from the
> >> estatus buffer. Free the memory in aer_recover_work_func() after
> >> processing the data using the ghes_estatus_pool_region_free() added.
> >
> >Thanks for working this up!  I had it on my to-do list, but
> >obviously had not gotten to it yet.
> >
> >> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> >> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> >> ---
> >>  drivers/acpi/apei/ghes.c | 23 ++++++++++++++++++++++-
> >>  drivers/pci/pcie/aer.c   | 10 ++++++++++
> >>  include/acpi/ghes.h      |  1 +
> >>  3 files changed, 33 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
> >> ef59d6ea16da..63ad0541db38 100644
> >> --- a/drivers/acpi/apei/ghes.c
> >> +++ b/drivers/acpi/apei/ghes.c
> >> @@ -209,6 +209,20 @@ int ghes_estatus_pool_init(unsigned int num_ghes)
> >>  	return -ENOMEM;
> >>  }
> >>
> >> +/**
> >> + * ghes_estatus_pool_region_free - free previously allocated memory
> >> + *				   from the ghes_estatus_pool.
> >> + * @addr: address of memory to free.
> >> + * @size: size of memory to free.
> >> + *
> >> + * Returns none.
> >> + */
> >> +void ghes_estatus_pool_region_free(unsigned long addr, u32 size) {
> >> +	gen_pool_free(ghes_estatus_pool, addr, size); }
> >> +EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
> >> +
> >>  static int map_gen_v2(struct ghes *ghes)  {
> >>  	return
> >> apei_map_generic_address(&ghes->generic_v2->read_ack_register);
> >> @@ -564,6 +578,7 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
> >>  	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
> >>  		unsigned int devfn;
> >>  		int aer_severity;
> >> +		u8 *aer_info;
> >>
> >>  		devfn = PCI_DEVFN(pcie_err->device_id.device,
> >>  				  pcie_err->device_id.function);
> >> @@ -577,11 +592,17 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
> >>  		if (gdata->flags & CPER_SEC_RESET)
> >>  			aer_severity = AER_FATAL;
> >>
> >> +		aer_info = (void *)gen_pool_alloc(ghes_estatus_pool,
> >> +						  sizeof(struct aer_capability_regs));
> >> +		if (!aer_info)
> >> +			return;
> >> +		memcpy(aer_info, pcie_err->aer_info, sizeof(struct
> >> +aer_capability_regs));
> >
> >This is a very straightforward approach to fixing this, and it looks pretty
> >reasonable, although I'd rather not have to pull more GHES stuff into aer.c
> >(ghes.h and ghes_estatus_pool_region_free()).
> >
> >What I had in mind was to put a queue of aer_capability_regs on the PCI side
> >that could be used by both the APEI path and the native path.
> >
> >In the APEI path, platform firmware reads the error information from the
> >hardware, and it feeds into PCI AER via aer_recover_queue().
> >
> >In the native path, Linux should be reading reads the same error information
> >from the hardware, but it feeds into PCI AER quite differently, via
> >aer_process_err_devices() and handle_error_source().
> >
> >These paths are fundamentally doing the exact same thing, but the data
> >handling and dmesg logging are needlessly different.  I'd like to see them get a
> >little more unified, so the native path could someday also feed into
> >aer_recover_queue().
> >
> >Does that make any sense?
> 
> Thanks for letting us know.
> Make sense, solution with in the AER looks better. 

Thanks for considering this.  The AER rework I have in mind is a
longer-term project, so unless you have time and interest in doing
that, I think we should apply your patch since it's all ready to go.

You pointed to the problem statement, but I think it would be good to
include a brief outline directly in the commit log, e.g., something
like this:

  ghes_handle_aer() passes AER data to the PCI core for logging and
  recovery by calling aer_recover_queue() with a pointer to struct
  aer_capability_regs.

  The problem was that aer_recover_queue() queues the pointer directly
  without copying the aer_capability_regs data.  The pointer was to
  the ghes->estatus buffer, which could be reused before
  aer_recover_work_func() reads the data.

  To avoid this problem, allocate a new aer_capability_regs structure
  from the ghes_estatus_pool, copy the AER data from the ghes->estatus
  buffer into it, pass a pointer to the new struct to
  aer_recover_queue(), and free it after aer_recover_work_func() has
  processed it.

What's your take on this, Rafael?  The biggest change is in
drivers/acpi, so if you want to take it, feel free to add my:

  Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> >>  		aer_recover_queue(pcie_err->device_id.segment,
> >>  				  pcie_err->device_id.bus,
> >>  				  devfn, aer_severity,
> >>  				  (struct aer_capability_regs *)
> >> -				  pcie_err->aer_info);
> >> +				  aer_info);
> >>  	}
> >>  #endif
> >>  }
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c index
> >> e85ff946e8c8..388b614c11fd 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -29,6 +29,7 @@
> >>  #include <linux/kfifo.h>
> >>  #include <linux/slab.h>
> >>  #include <acpi/apei.h>
> >> +#include <acpi/ghes.h>
> >>  #include <ras/ras_event.h>
> >>
> >>  #include "../pci.h"
> >> @@ -996,6 +997,15 @@ static void aer_recover_work_func(struct work_struct
> >*work)
> >>  			continue;
> >>  		}
> >>  		cper_print_aer(pdev, entry.severity, entry.regs);
> >> +		/*
> >> +		 * Memory for aer_capability_regs(entry.regs) is being
> >allocated from the
> >> +		 * ghes_estatus_pool to protect it from overwriting when
> >multiple sections
> >> +		 * are present in the error status. Thus free the same after
> >processing
> >> +		 * the data.
> >> +		 */
> >> +		ghes_estatus_pool_region_free((unsigned long)entry.regs,
> >> +					      sizeof(struct aer_capability_regs));
> >> +
> >>  		if (entry.severity == AER_NONFATAL)
> >>  			pcie_do_recovery(pdev, pci_channel_io_normal,
> >>  					 aer_root_reset);
> >> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h index
> >> 3c8bba9f1114..40d89e161076 100644
> >> --- a/include/acpi/ghes.h
> >> +++ b/include/acpi/ghes.h
> >> @@ -78,6 +78,7 @@ static inline struct list_head
> >> *ghes_get_devices(void) { return NULL; }  #endif
> >>
> >>  int ghes_estatus_pool_init(unsigned int num_ghes);
> >> +void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
> >>
> >>  static inline int acpi_hest_get_version(struct acpi_hest_generic_data
> >> *gdata)  {
> >> --
> >> 2.34.1
> >>
> 
> Thanks,
> Shiju
