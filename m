Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641E6524108
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 01:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349308AbiEKX2C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 19:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245183AbiEKX2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 19:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67BE694AB;
        Wed, 11 May 2022 16:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6120261DC9;
        Wed, 11 May 2022 23:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751F9C340EE;
        Wed, 11 May 2022 23:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652311679;
        bh=siF8PIsP3XHsVSZH5Wv97Tl+fZ+3A6Kd5SrYh1Feyp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cmdoL7mS/UXMhq4bFqDfAewpfd7ifK2Y83cZJgqQAb5UvtYPro4j5Lf4DTm09oqMH
         5Tivg2wc2r6fMg7SSjY5/eHYp/DhPkwbtcFBoM9OPWI5jS4wRAgjt0n5CduKdlIsml
         RgCP7NLJCJZlQ4o5Yc9/2tpjejnHsv3jTRn2sG6sFm78MGBncAjhNFoHSha+Lr4qlR
         6FJ4c0OsGA9yowCGZzj9mKDLvuuK52Vx00IdduEhyFi+DgzqNY6FYEQMIZZVszJy2r
         c6h5iC2Zn9OB2DofxQiphWhzyBJSO4J6QFe8OY55YeLeK71aMUSIDEByxgHMOoCdj/
         jNDlLzEdn3/bQ==
Date:   Wed, 11 May 2022 18:27:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/AER: Handle Multi UnCorrectable/Correctable
 errors properly
Message-ID: <20220511232757.GA829078@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418150237.1021519-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 18, 2022 at 03:02:37PM +0000, Kuppuswamy Sathyanarayanan wrote:
> Currently the aer_irq() handler returns IRQ_NONE for cases without bits
> PCI_ERR_ROOT_UNCOR_RCV or PCI_ERR_ROOT_COR_RCV are set. But this
> assumption is incorrect.
> 
> Consider a scenario where aer_irq() is triggered for a correctable
> error, and while we process the error and before we clear the error
> status in "Root Error Status" register, if the same kind of error
> is triggered again, since aer_irq() only clears events it saw, the
> multi-bit error is left in tact. This will cause the interrupt to fire
> again, resulting in entering aer_irq() with just the multi-bit error
> logged in the "Root Error Status" register.
> 
> Repeated AER recovery test has revealed this condition does happen
> and this prevents any new interrupt from being triggered. Allow to
> process interrupt even if only multi-correctable (BIT 1) or
> multi-uncorrectable bit (BIT 3) is set.
> 
> Also note that, for cases with only multi-bit error is set, since this
> is not the first occurrence of the error, PCI_ERR_ROOT_ERR_SRC may have
> zero or some junk value. So we cannot cleanly process this error
> information using aer_isr_one_error(). All we are attempting with this
> fix is to make sure error interrupt processing can continue in this
> scenario.
> 
> This error can be reproduced by making following changes to the
> aer_irq() function and by executing the given test commands.
> 
>  static irqreturn_t aer_irq(int irq, void *context)
>          struct aer_err_source e_src = {};
> 
>          pci_read_config_dword(rp, aer + PCI_ERR_ROOT_STATUS,
> 				&e_src.status);
>  +       pci_dbg(pdev->port, "Root Error Status: %04x\n",
>  +		e_src.status);
>          if (!(e_src.status & AER_ERR_STATUS_MASK))
>                  return IRQ_NONE;
> 
>  +       mdelay(5000);
> 
>  # Prep injection data for a correctable error.
>  $ cd /sys/kernel/debug/apei/einj
>  $ echo 0x00000040 > error_type
>  $ echo 0x4 > flags
>  $ echo 0x891000 > param4
> 
>  # Root Error Status is initially clear
>  $ setpci -s <Dev ID> ECAP0001+0x30.w
>  0000
> 
>  # Inject one error
>  $ echo 1 > error_inject
> 
>  # Interrupt received
>  pcieport <Dev ID>: AER: Root Error Status 0001
> 
>  # Inject another error (within 5 seconds)
>  $ echo 1 > error_inject
> 
>  # You will get a new IRQ with only multiple ERR_COR bit set
>  pcieport <Dev ID>: AER: Root Error Status 0002
> 
> Currently, the above issue has been only reproduced in the ICL server
> platform.
> 
> [Eric: proposed reproducing steps]
> Fixes: 4696b828ca37 ("PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/")

4696b828ca37 only *moves* drivers/pci/pcie/aer/aerdrv.c to
drivers/pci/pcie/aer.c, so I don't think it's related.

I think the actual change of interest is e167bfcaa4cd ("PCI: aerdrv:
remove magical ROOT_ERR_STATUS_MASKS") [1].  It looks like we did
exactly what you propose before that commit.

I can update this unless you disagree.

[1] https://git.kernel.org/linus/e167bfcaa4cd

> Reported-by: Eric Badger <ebadger@purestorage.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v2:
>  * Added more details to the commit log.
>  * Rebased on v5.18-rc1.
> 
> Changes since v1:
>  * Added Fixes tag.
>  * Included reproducing steps proposed by Eric.
> 
>  drivers/pci/pcie/aer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9fa1f97e5b27..7952e5efd6cf 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -101,6 +101,11 @@ struct aer_stats {
>  #define ERR_COR_ID(d)			(d & 0xffff)
>  #define ERR_UNCOR_ID(d)			(d >> 16)
>  
> +#define AER_ERR_STATUS_MASK		(PCI_ERR_ROOT_UNCOR_RCV |	\
> +					PCI_ERR_ROOT_COR_RCV |		\
> +					PCI_ERR_ROOT_MULTI_COR_RCV |	\
> +					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
> +
>  static int pcie_aer_disable;
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>  
> @@ -1196,7 +1201,7 @@ static irqreturn_t aer_irq(int irq, void *context)
>  	struct aer_err_source e_src = {};
>  
>  	pci_read_config_dword(rp, aer + PCI_ERR_ROOT_STATUS, &e_src.status);
> -	if (!(e_src.status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV)))
> +	if (!(e_src.status & AER_ERR_STATUS_MASK))
>  		return IRQ_NONE;
>  
>  	pci_read_config_dword(rp, aer + PCI_ERR_ROOT_ERR_SRC, &e_src.id);
> -- 
> 2.25.1
> 
