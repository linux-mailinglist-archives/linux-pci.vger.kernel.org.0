Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169094FE781
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbiDLR6H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiDLR6G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 13:58:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84F354693
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 10:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80F46B81FAE
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 17:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4339C385A5;
        Tue, 12 Apr 2022 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649786145;
        bh=6DUb+Auwo8PS9JJgZX7P0VYq8gYaKnuROll+O4J7rSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ah9OmWBqbo8yTqlmemU2iiZd7MYPNIvQarylPIP3e9FVsJboK2WUki58547OVaSnA
         ispF7eezOs5TrAVEgvBtfuQmsLGbc0sPXq4ObEAFgjUTjAEPOTrjVVyhY7/tRfIkJD
         ZcWkLCrEqn640eYLfSrwfSe7EQZJjH2UaxNXmaYs8LA498miNxEPXDoVwnepvTCRLF
         Sub29o+HTXoxAwFDlmI8pbQDkhHBNAeUjji9Fb9TB/j9Lsh+3uZNK4y31e9aAP2lGq
         F/crUjRWPM/Q7JdkP3vINVzsPkwPiMfGdqa+HbCpzR/u0IGZUMvksmjfcvGlXTq5Gz
         t646K5QnTkbZw==
Received: by pali.im (Postfix)
        id C81D9A75; Tue, 12 Apr 2022 19:55:41 +0200 (CEST)
Date:   Tue, 12 Apr 2022 19:55:41 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 17/18] PCI: aardvark: Run link training in separate worker
Message-ID: <20220412175541.gnrynogn3s2llari@pali>
References: <20220220193346.23789-1-kabel@kernel.org>
 <20220220193346.23789-18-kabel@kernel.org>
 <20220412152524.GB20749@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220412152524.GB20749@lpieralisi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 12 April 2022 16:25:24 Lorenzo Pieralisi wrote:
> On Sun, Feb 20, 2022 at 08:33:45PM +0100, Marek Behún wrote:
> > From: Pali Rohár <pali@kernel.org>
> > 
> > Link training and PCIe card reset routines in Aardvark contain several
> > delays, resulting in rather slow PCIe card probing. The worst case is
> > when there is no card connected: the driver tries link training at all
> > possible speeds and waits until all timers expire.
> > 
> > Since probe methods for all system devices are called sequentially, this
> > results in noticeably longer boot time.
> > 
> > Move card reset and link training code from driver probe function into
> > a separate worker, so that kernel can do something different while the
> > driver is waiting during reset or training.
> > 
> > On ESPRESSObin and Turris MOX this decreases boot time by 0.4s with
> > plugged PCIe card and by 2.2s if no card is connected.
> 
> I believe this is what the PROBE_PREFER_ASYNCHRONOUS flag in
> struct device_driver.probe_type flag is there for unless I am
> missing something obvious here.
> 
> Can you give it a try and report back please ?

Hello Lorenzo.

During testing patches 17 and 18 I saw that following race condition
https://lore.kernel.org/linux-pci/20210407144146.rl7x2h5l2cc3escy@pali/
(which cause kernel oops) was triggered more often.

I'm not sure if above race condition was fully fixed by the last
Krzysztof's patches or there is also other issue which cause oops.

As both patches 17 and 18 are just optimizations, I would suggest to
skip it for now, until all these issues are resolved or verified that
they are not triggered anymore.

I guess that at this time we can look at PROBE_PREFER_ASYNCHRONOUS flag
and decide how to implement this optimization.

Do you agree, or do you have other opinion?

> Thanks,
> Lorenzo
> 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 42 ++++++++++++++++++---------
> >  1 file changed, 28 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 8c9ac7766ac7..056f49d0e3a4 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/of_gpio.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/timer.h>
> > +#include <linux/workqueue.h>
> >  
> >  #include "../pci.h"
> >  #include "../pci-bridge-emul.h"
> > @@ -296,6 +297,8 @@ struct advk_pcie {
> >  	int link_gen;
> >  	bool link_was_up;
> >  	struct timer_list link_irq_timer;
> > +	struct delayed_work probe_card_work;
> > +	bool host_bridge_probed;
> >  	struct pci_bridge_emul bridge;
> >  	struct gpio_desc *reset_gpio;
> >  	struct clk *clk;
> > @@ -497,6 +500,21 @@ static void advk_pcie_train_link(struct advk_pcie *pcie)
> >  		dev_err(dev, "link never came up\n");
> >  }
> >  
> > +static void advk_pcie_probe_card_work(struct work_struct *work)
> > +{
> > +	struct delayed_work *dwork = container_of(work, struct delayed_work,
> > +						  work);
> > +	struct advk_pcie *pcie = container_of(dwork, struct advk_pcie,
> > +					      probe_card_work);
> > +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > +	int ret;
> > +
> > +	advk_pcie_train_link(pcie);
> > +	ret = pci_host_probe(bridge);
> > +	if (!ret)
> > +		pcie->host_bridge_probed = true;
> > +}
> > +
> >  /*
> >   * Set PCIe address window register which could be used for memory
> >   * mapping.
> > @@ -701,8 +719,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> >  	/* Disable remaining PCIe outbound windows */
> >  	for (i = pcie->wins_count; i < OB_WIN_COUNT; i++)
> >  		advk_pcie_disable_ob_win(pcie, i);
> > -
> > -	advk_pcie_train_link(pcie);
> >  }
> >  
> >  static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u32 *val)
> > @@ -2112,14 +2128,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
> >  	bridge->ops = &advk_pcie_ops;
> >  	bridge->map_irq = advk_pcie_map_irq;
> >  
> > -	ret = pci_host_probe(bridge);
> > -	if (ret < 0) {
> > -		irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
> > -		advk_pcie_remove_rp_irq_domain(pcie);
> > -		advk_pcie_remove_msi_irq_domain(pcie);
> > -		advk_pcie_remove_irq_domain(pcie);
> > -		return ret;
> > -	}
> > +	INIT_DELAYED_WORK(&pcie->probe_card_work, advk_pcie_probe_card_work);
> > +	schedule_delayed_work(&pcie->probe_card_work, 1);
> >  
> >  	return 0;
> >  }
> > @@ -2131,11 +2141,15 @@ static int advk_pcie_remove(struct platform_device *pdev)
> >  	u32 val;
> >  	int i;
> >  
> > +	cancel_delayed_work_sync(&pcie->probe_card_work);
> > +
> >  	/* Remove PCI bus with all devices */
> > -	pci_lock_rescan_remove();
> > -	pci_stop_root_bus(bridge->bus);
> > -	pci_remove_root_bus(bridge->bus);
> > -	pci_unlock_rescan_remove();
> > +	if (pcie->host_bridge_probed) {
> > +		pci_lock_rescan_remove();
> > +		pci_stop_root_bus(bridge->bus);
> > +		pci_remove_root_bus(bridge->bus);
> > +		pci_unlock_rescan_remove();
> > +	}
> >  
> >  	/* Disable Root Bridge I/O space, memory space and bus mastering */
> >  	val = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
> > -- 
> > 2.34.1
> > 
