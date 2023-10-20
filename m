Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F187D1516
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 19:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377908AbjJTRol (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Oct 2023 13:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377895AbjJTRok (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2023 13:44:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4B5A3;
        Fri, 20 Oct 2023 10:44:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204F6C433C9;
        Fri, 20 Oct 2023 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697823878;
        bh=tM18i9s5DyCKNvNL4uxB77beHUHrncqWw9WuGgi11Sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qN6wGAxbfAChNjoLr5JDLEMA1Yj+VXAm1mIrvIai0T7d3G6o655pNSQo+SYWECDNJ
         tkFS3gMulxYKpiNf3SesEVfzKyQjA/5DtMXpEuUMZ0dxODQ8d6kmjsSjqU1iGnX45t
         U+OBJowH14NvBAGCP93/5kVnK3CAzSZAQiJto8Fwnuewnn4E7yoXVAqHfIsJHL6ODQ
         SyDGio5RxL70E0jPTDGXylaFoJJ1Rmlb47upWX/MakTC510CcYcdjGU65YQmfWndaq
         11TYcwA+E728enME8ni+F/2VRXXMIZQlLNiisg1bXJ79Yg5/pHzqZprTUWY3fifPJk
         B54UYuQvwVrbw==
Date:   Fri, 20 Oct 2023 23:14:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     manivannan.sadhasivam@linaro.org, aisheng.dong@nxp.com,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        festevam@gmail.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kernel@pengutronix.de, kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 3/5] PCI: endpoint: pci-epf-test: add doorbell test
Message-ID: <20231020174428.GB46191@thinkpad>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-4-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911220920.1817033-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 11, 2023 at 06:09:18PM -0400, Frank Li wrote:

Subject could be,

PCI: endpoint: pci-epf-test: Add doorbell support

> Add three register: doorbell_bar, doorbell_addr, doorbell_data,
> doorbell_done. Call pci_epf_alloc_doorbell() all a doorbell address space.
> 
> Root complex(RC) side driver can trigger pci-epc-test's doorbell callback
> handler by write doorbell_data to mapped doorbell_bar's address space.
> 
> pci-epc-test will set doorbell_done in doorbell callback.
> 

How about,

Add doorbell support to the EPF test driver by introducing 3 new registers:

doorbell_bar
doorbell_addr
doorbell_data

The PCI RC driver can trigger the doorbell on the EP side by writing the
content of "doorbell_data" to the address specified by the "doorbell_addr"
register in the "doorbell_bar" BAR region.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>

You should also update Documentation/PCI/endpoint/pci-test-* files in a separate
commit with doorbell support.

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 59 ++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 1f0d2b84296a3..566549919b87b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -11,6 +11,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/msi.h>
>  #include <linux/slab.h>
>  #include <linux/pci_ids.h>
>  #include <linux/random.h>
> @@ -39,17 +40,21 @@
>  #define STATUS_IRQ_RAISED		BIT(6)
>  #define STATUS_SRC_ADDR_INVALID		BIT(7)
>  #define STATUS_DST_ADDR_INVALID		BIT(8)
> +#define STATUS_DOORBELL_SUCCESS		BIT(9)
>  
>  #define FLAG_USE_DMA			BIT(0)
>  
>  #define TIMER_RESOLUTION		1
>  
> +#define MAGIC_VERSION_MASK		GENMASK(7, 0)
> +
>  static struct workqueue_struct *kpcitest_workqueue;
>  
>  struct pci_epf_test {
>  	void			*reg[PCI_STD_NUM_BARS];
>  	struct pci_epf		*epf;
>  	enum pci_barno		test_reg_bar;
> +	enum pci_barno		doorbell_bar;
>  	size_t			msix_table_offset;
>  	struct delayed_work	cmd_handler;
>  	struct dma_chan		*dma_chan_tx;
> @@ -74,6 +79,9 @@ struct pci_epf_test_reg {
>  	u32	irq_type;
>  	u32	irq_number;
>  	u32	flags;
> +	u32	doorbell_bar;
> +	u32	doorbell_addr;
> +	u32	doorbell_data;
>  } __packed;
>  
>  static struct pci_epf_header test_header = {
> @@ -693,6 +701,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  	struct pci_epf_bar *epf_bar;
>  	int bar;
>  
> +	pci_epf_free_doorbell(epf);
> +
>  	cancel_delayed_work(&epf_test->cmd_handler);
>  	pci_epf_test_clean_dma_chan(epf_test);
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> @@ -808,9 +818,22 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static int pci_epf_test_doorbell(struct pci_epf *epf, int index)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +
> +	reg->status |= STATUS_DOORBELL_SUCCESS;
> +	pci_epf_test_raise_irq(epf_test, reg);
> +
> +	return 0;
> +}
> +
>  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
>  	.core_init = pci_epf_test_core_init,
>  	.link_up = pci_epf_test_link_up,
> +	.doorbell = pci_epf_test_doorbell,

I would like to pass this callback directly to the pci_epf_alloc_doorbell() API.
 Would that be feasible?

>  };
>  
>  static int pci_epf_test_alloc_space(struct pci_epf *epf)
> @@ -859,7 +882,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  		epf_bar = &epf->bar[bar];
>  		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
>  
> -		if (bar == test_reg_bar)
> +		if (bar == test_reg_bar || bar == epf_test->doorbell_bar)
>  			continue;
>  
>  		if (!!(epc_features->reserved_bar & (1 << bar)))
> @@ -900,9 +923,14 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	const struct pci_epc_features *epc_features;
>  	enum pci_barno test_reg_bar = BAR_0;
> +	enum pci_barno doorbell_bar = NO_BAR;
>  	struct pci_epc *epc = epf->epc;
>  	bool linkup_notifier = false;
>  	bool core_init_notifier = false;
> +	struct pci_epf_test_reg *reg;
> +	struct msi_msg *msg;
> +	u64 doorbell_addr;
> +	u32 align;
>  
>  	if (WARN_ON_ONCE(!epc))
>  		return -EINVAL;
> @@ -923,10 +951,39 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	epf_test->test_reg_bar = test_reg_bar;
>  	epf_test->epc_features = epc_features;
>  
> +	align = epc_features->align;
> +	align = align ? align : 128;
> +
> +	ret = pci_epf_alloc_doorbell(epf, 1);

This should be renamed as pci_epc_alloc_doorbell() as per comment on patch 1/3.
Also, the "msi_msg" pointer should be part of the EPC struct.

> +	if (!ret) {
> +		msg = epf->msg;
> +		doorbell_bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
> +
> +		if (doorbell_bar > 0) {
> +			epf_test->doorbell_bar = doorbell_bar;
> +			doorbell_addr = msg->address_hi;
> +			doorbell_addr <<= 32;
> +			doorbell_addr |= msg->address_lo;
> +			epf->bar[doorbell_bar].phys_addr = round_down(doorbell_addr, align);
> +			epf->bar[doorbell_bar].barno = doorbell_bar;
> +			epf->bar[doorbell_bar].size = align;
> +		} else {
> +			pci_epf_free_doorbell(epf);

This one too should be renamed. 

> +		}
> +	}
> +
>  	ret = pci_epf_test_alloc_space(epf);

This one too.

>  	if (ret)
>  		return ret;
>  
> +	reg = epf_test->reg[test_reg_bar];
> +	reg->magic |= FIELD_PREP(MAGIC_VERSION_MASK, 0x1);

Why are you writing this register? This register serves for the purpose of
testing BAR0.

- Mani

> +	if (doorbell_bar > 0) {
> +		reg->doorbell_addr = doorbell_addr & (align - 1);
> +		reg->doorbell_data = msg->data;
> +		reg->doorbell_bar = doorbell_bar;
> +	}
> +
>  	if (!core_init_notifier) {
>  		ret = pci_epf_test_core_init(epf);
>  		if (ret)
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
