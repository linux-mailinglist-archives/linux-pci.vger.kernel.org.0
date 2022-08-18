Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706E7598F8F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 23:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239690AbiHRVay (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 17:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiHRVaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 17:30:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA91272D;
        Thu, 18 Aug 2022 14:30:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2000E616BE;
        Thu, 18 Aug 2022 21:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D943C433C1;
        Thu, 18 Aug 2022 21:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660858244;
        bh=PLUDvTC4dLxPvqujmb5K46XCmpAPihywS8euFcK5Hxw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XiXDeT5rsu12iCf36PVjtoQJnaL6Iiz6rp3e5+IiOey3Dul9XCyZQrxHpE9tTg6la
         HmLskfl+MxPLTSH02OVzxUZcsaBr9BwkQO8OhqgqOgfKUlUK/BL4QRKkEIRxUJsLzZ
         z00Yxoc3/wU1+++b+/b8zWRs3CfnGJJWsUa6ShaFnydkANjdS0uDUj+kmMGbecWi5Z
         CTLWHMRzSwbNVVTuBnvdfbf2S2RBeG+Eys4ZVawL4tM5JBBbfo90mQT2rmhRa5ZLZn
         yfwc/KAWlw4Bdr95N6UvMmUgd/wVoUOwg0EIKGKxcrHZ6TRpa5RaG4B0ZI1g6l/rwQ
         r3XQcBuiNmoWw==
Date:   Thu, 18 Aug 2022 16:30:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: Re: [PATCH v6 4/4] pcie: endpoint: pci-epf-vntb: add endpoint MSI
 support
Message-ID: <20220818213042.GA2394869@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818151127.2449064-5-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please pay attention to the style of previous subject lines and copy
them:

  $ git log --oneline drivers/pci/endpoint/functions/pci-epf-vntb.c | cat
  b8c0aa9b16bb NTB: EPF: Tidy up some bounds checks
  3305f43cb6a8 NTB: EPF: Fix error code in epf_ntb_bind()
  ae9f38adac26 PCI: endpoint: pci-epf-vntb: reduce several globals to statics
  8e4bfbe644a6 PCI: endpoint: pci-epf-vntb: fix error handle in epf_ntb_mw_bar_init()
  7b14a5e96128 NTB: EPF: set pointer addr to null using NULL rather than 0
  e35f56bb0330 PCI: endpoint: Support NTB transfer between RC and EP

Nobody has paid much attention to consistency here in the past, but we
will in the future.

Maybe "PCI: endpoint: Add NTB MSI support" or similar?

On Thu, Aug 18, 2022 at 10:11:27AM -0500, Frank Li wrote:
>                         ┌───────┐          ┌──────────┐
>                         │       │          │          │
>       ┌─────────────┐   │       │          │ PCI Host │
>       │ MSI         │◄┐ │       │          │          │
>       │ Controller  │ │ │       │          │          │
>       └─────────────┘ └─┼───────┼──────────┼─BAR0     │
>                         │ PCI   │          │ BAR1     │
>                         │ Func  │          │ BAR2     │
>                         │       │          │ BAR3     │
>                         │       │          │ BAR4     │
>                         │       ├─────────►│          │
>                         └───────┘          └──────────┘
> 
> Linux supports endpoint functions. PCI Host write BAR<n> space like write
> to memory. The EP side can't know memory changed by the host driver.

The diagram is pretty but I don't quite understand what this is
telling me.  I assume "PCI Func" is the "EP side"?  If so, label it
appropriately.

Is "PCI Host" referring to a host CPU?  I guess not, since you include
BARs in the box.

What are the arrows?  I assume one is an MMIO write to a BAR, since
you mention that below.

> PCI Spec has not defined a standard method to do that. Only define MSI(x)
> to let EP notified RC status change.
> 
> The basic idea is to trigger an IRQ when PCI RC writes to a memory
> address. That's what MSI controller provided. EP drivers just need to
> request a platform MSI interrupt, struct msi_msg *msg will pass down a
> memory address and data. EP driver will map such memory address to one of
> PCI BAR<n>.  Host just writes such an address to trigger EP side irq.

I think "PCI RC writes to memory" and "Host writes such an address"
are referring to the same write.  If so, use the same words both
times, not "PCI RC" once and "host" the other.

s/irq/IRQ/, as you did above.  I don't want to have to figure out
whether "irq" is the same as "IRQ", so spell it the same way all the
time.

> Add MSI support for pci-epf-vntb. pci-epf-vntb driver query if system
> have MSI controller. Setup doorbell address according to struct msi_msg.

s/pci-epf-vntb driver query/Query/
s/have/has an/
s/Setup/Set up/

> So PCIe host can write this doorbell address to triger EP side's irq.

I guess "PCIe host" is something else that means the same as "PCI RC"
or "host" above?  Use consistent terminology.  This doesn't seem like
something specific to PCIe.  If it's not, use "PCI" to be generic or
omit it altogether.

s/triger/trigger/
s/irq/IRQ/ again

> If no MSI controller exist, fall back to software polling.

s/exist/exists/

> @@ -253,7 +256,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  
>  	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
>  
> -	for (i = 1; i < ntb->db_count; i++) {
> +	for (i = 1; i < ntb->db_count && !ntb->epf_db_phy; i++) {

This loop condition is hard to read.  It would be simpler as:

  if (!ntb->epf_db_phy) {
    for (i = 1; i < ntb->db_count; i++) {
      ...
    }
  }

> @@ -520,35 +543,33 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  	struct device *dev = &ntb->epf->dev;
>  	int ret;
>  	struct pci_epf_bar *epf_bar;
> -	void __iomem *mw_addr;
> +	void __iomem *mw_addr = NULL;
>  	enum pci_barno barno;
> -	size_t size = 4 * ntb->db_count;
> +	size_t size;
>  
>  	epc_features = pci_epc_get_features(ntb->epf->epc,
>  					    ntb->epf->func_no,
>  					    ntb->epf->vfunc_no);
>  	align = epc_features->align;
> -
> -	if (size < 128)
> -		size = 128;
> -
> -	if (align)
> -		size = ALIGN(size, align);
> -	else
> -		size = roundup_pow_of_two(size);
> +	size = epf_ntb_db_size(ntb);
>  
>  	barno = ntb->epf_ntb_bar[BAR_DB];
> +	epf_bar = &ntb->epf->bar[barno];
>  
> -	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
> -	if (!mw_addr) {
> -		dev_err(dev, "Failed to allocate OB address\n");
> -		return -ENOMEM;
> +	if (!ntb->epf_db_phy) {
> +		mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
> +		if (!mw_addr) {
> +			dev_err(dev, "Failed to allocate OB address\n");
> +			return -ENOMEM;
> +		}
> +	} else {
> +		epf_bar->phys_addr = ntb->epf_db_phy;
> +		epf_bar->barno = barno;
> +		epf_bar->size = size;

I think inverted tests are hard to read, and setting mw_addr here
instead of at the declaration will make the cases more parallel, so
maybe omit the initialization above and do this:

  if (ntb->epf_db_phy) {
    mw_addr = NULL;
    epf_bar->phys_addr = ntb->epf_db_phy;
    ...
  } else {
    mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
    ...
  }

> +static void epf_ntb_epc_msi_init(struct epf_ntb *ntb)
> +{
> +	struct device *dev = &ntb->epf->dev;
> +	struct irq_domain *domain;
> +	int virq;
> +	int ret;
> +	int i;
> +
> +	domain = dev_get_msi_domain(ntb->epf->epc->dev.parent);
> +	if (!domain)
> +		return;
> +
> +	dev_set_msi_domain(dev, domain);
> +
> +	if (platform_msi_domain_alloc_irqs(&ntb->epf->dev,
> +		ntb->db_count,
> +		epf_ntb_write_msi_msg)) {
> +		dev_info(dev, "Can't allocate MSI, fall back to poll mode\n");
> +		return;
> +	}
> +
> +	dev_info(dev, "vntb use MSI as doorbell\n");
> +
> +	for (i = 0; i < ntb->db_count; i++) {
> +		virq = msi_get_virq(dev, i);
> +		ret = devm_request_irq(dev, virq,
> +			       epf_ntb_interrupt_handler, 0,
> +			       "ntb", ntb);
> +
> +		if (ret)
> +			dev_err(dev, "devm_request_irq() failure\n");

You don't return anything to indicate success or failure.  Does the
caller care if this fails?  A message is only for debugging; it's not
a way to tell the caller anything.

> +
> +		if (!i)
> +			ntb->msi_virqbase = virq;

I don't understand what you're doing here, but it looks weird to set
ntb->msi_virqbase even if devm_request_irq() fails.

> +	}
> +}
