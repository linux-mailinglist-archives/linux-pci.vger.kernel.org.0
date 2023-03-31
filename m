Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D2E6D16C7
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 07:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCaF2n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 01:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaF2m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 01:28:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3170E11EAD
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 22:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE97462344
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 05:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACDEC433EF;
        Fri, 31 Mar 2023 05:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680240520;
        bh=1NE8NGJdqC/9zY+1xh+3iHwM7IcANqqeq3k1MHZUVXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxKdXjqr+fIaqUUNWwdcN/xmqeuKNK4SLgkbSlpZNxfk0mnQZVTtsK1si5RTHCMmy
         7SyAHbakCs6B5GYUatq57R4JtDnrOiumX0y62Y1ln5gquNorZk1V8ju+c6kRBCUMbY
         uXuHEpoJv9020/lm+7zVIVy5evmv5R1ILi+jZ+ZyRhwFS+JyE2yslmH9gW3LOzCPPH
         RT7UL4TaNktFsjgq4xv0IyHDJKeLnv2Qn86xZ5EEPy8AVP+Wj7Q6g9EN4/5p/5cSsR
         B+yehhpHmSHEX0G9iA7bObJBnBPDppYcMed6oQYFjr6vYJH5aZS62I5YNt4UGx6Qyr
         IUjaI3EHb4GSw==
Date:   Fri, 31 Mar 2023 10:58:27 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 11/17] PCI: epf-test: Cleanup request result handling
Message-ID: <20230331052827.GC4973@thinkpad>
References: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
 <20230330085357.2653599-12-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330085357.2653599-12-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:51PM +0900, Damien Le Moal wrote:
> Each of the test functions pci_epf_test_write(), pci_epf_test_read() and
> pci_epf_test_copy() return an int result which is used by
> pci_epf_test_cmd_handler() to set a success or error bit in the request
> status.
> 
> In the spirit of keeping the processing of each test case self-contained
> within its own test function, move the request status field update from
> pci_epf_test_cmd_handler() to each of these test functions and change
> these functions declaration to returning void.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 46 +++++++++----------
>  1 file changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index c2a14f828bdf..35bdb03f6ee1 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -325,8 +325,8 @@ static void pci_epf_test_print_rate(const char *ops, u64 size,
>  		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
>  }
>  
> -static int pci_epf_test_copy(struct pci_epf_test *epf_test,
> -			     struct pci_epf_test_reg *reg)
> +static void pci_epf_test_copy(struct pci_epf_test *epf_test,
> +			      struct pci_epf_test_reg *reg)
>  {
>  	int ret;
>  	bool use_dma;
> @@ -420,11 +420,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test,
>  	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
>  
>  err:
> -	return ret;
> +	if (!ret)
> +		reg->status |= STATUS_COPY_SUCCESS;
> +	else
> +		reg->status |= STATUS_COPY_FAIL;
>  }
>  
> -static int pci_epf_test_read(struct pci_epf_test *epf_test,
> -			     struct pci_epf_test_reg *reg)
> +static void pci_epf_test_read(struct pci_epf_test *epf_test,
> +			      struct pci_epf_test_reg *reg)
>  {
>  	int ret;
>  	void __iomem *src_addr;
> @@ -509,11 +512,14 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test,
>  	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
>  
>  err:
> -	return ret;
> +	if (!ret)
> +		reg->status |= STATUS_READ_SUCCESS;
> +	else
> +		reg->status |= STATUS_READ_FAIL;
>  }
>  
> -static int pci_epf_test_write(struct pci_epf_test *epf_test,
> -			      struct pci_epf_test_reg *reg)
> +static void pci_epf_test_write(struct pci_epf_test *epf_test,
> +			       struct pci_epf_test_reg *reg)
>  {
>  	int ret;
>  	void __iomem *dst_addr;
> @@ -604,7 +610,10 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test,
>  	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
>  
>  err:
> -	return ret;
> +	if (!ret)
> +		reg->status |= STATUS_WRITE_SUCCESS;
> +	else
> +		reg->status |= STATUS_WRITE_FAIL;
>  }
>  
>  static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
> @@ -655,7 +664,6 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  
>  static void pci_epf_test_cmd_handler(struct work_struct *work)
>  {
> -	int ret;
>  	u32 command;
>  	struct pci_epf_test *epf_test = container_of(work, struct pci_epf_test,
>  						     cmd_handler.work);
> @@ -683,27 +691,15 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  		pci_epf_test_raise_irq(epf_test, reg);
>  		break;
>  	case COMMAND_WRITE:
> -		ret = pci_epf_test_write(epf_test, reg);
> -		if (ret)
> -			reg->status |= STATUS_WRITE_FAIL;
> -		else
> -			reg->status |= STATUS_WRITE_SUCCESS;
> +		pci_epf_test_write(epf_test, reg);
>  		pci_epf_test_raise_irq(epf_test, reg);
>  		break;
>  	case COMMAND_READ:
> -		ret = pci_epf_test_read(epf_test, reg);
> -		if (!ret)
> -			reg->status |= STATUS_READ_SUCCESS;
> -		else
> -			reg->status |= STATUS_READ_FAIL;
> +		pci_epf_test_read(epf_test, reg);
>  		pci_epf_test_raise_irq(epf_test, reg);
>  		break;
>  	case COMMAND_COPY:
> -		ret = pci_epf_test_copy(epf_test, reg);
> -		if (!ret)
> -			reg->status |= STATUS_COPY_SUCCESS;
> -		else
> -			reg->status |= STATUS_COPY_FAIL;
> +		pci_epf_test_copy(epf_test, reg);
>  		pci_epf_test_raise_irq(epf_test, reg);
>  		break;
>  	default:
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
