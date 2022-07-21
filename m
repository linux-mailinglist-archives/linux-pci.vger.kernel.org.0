Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2B57D711
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 00:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiGUWsf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 18:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGUWsd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 18:48:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B088C751;
        Thu, 21 Jul 2022 15:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7B52B826A9;
        Thu, 21 Jul 2022 22:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9190C3411E;
        Thu, 21 Jul 2022 22:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658443709;
        bh=1UFENBlgwQq77rrpTbU6/vp8Zr5tSDD80m0Xs15SA6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OESy5lSYdbzOn9FyKllVt2zbDtGp5zTl3tz4jVhrJhm36rZU4nEOrT7IhsN/iftPm
         JaL8Itny2XVzALLJKVTFue2vUePipf5ylH2F+MqObmJM/HAR5bxzIHNa4WMm82m6rl
         5BYYyFyWty39LaqJ3MYVfn8OXgo7nlhWyj9OeJm6c4UwP9rdtj4VPihfy015SnjSpN
         989+Un8YGD+fW452eOQH9cRxkW89L88DGEWDCp+XGVEQI6GFGnuZsZ2mAOEtIZ/vOn
         JkJkzahTtFe71YZ8JNWYsAznF1Gan+hUGW1BaAE9IdNg/asqEF6jqnt/GF5H82JZZz
         szftlBAWNvuIg==
Received: by pali.im (Postfix)
        id BF5CA22EF; Fri, 22 Jul 2022 00:48:25 +0200 (CEST)
Date:   Fri, 22 Jul 2022 00:48:25 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Message-ID: <20220721224825.7aqcvcnzaht57mii@pali>
References: <20220721204607.xklzyklbgwcgepjm@pali>
 <20220721222122.GA1754784@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220721222122.GA1754784@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 21 July 2022 17:21:22 Bjorn Helgaas wrote:
> [+to Johan for qcom]
> [-cc Tom, email bounces]
> 
> On Thu, Jul 21, 2022 at 10:46:07PM +0200, Pali Rohár wrote:
> > On Thursday 21 July 2022 14:54:33 Bjorn Helgaas wrote:
> > > The j721e, kirin, tegra, and mediatek drivers all implement .remove().
> > > 
> > > They also set ".suppress_bind_attrs = true".  I think this means
> > > bus_add_driver() will not create the "bind" and "unbind" sysfs
> > > attributes for the driver that would allow users to users to manually
> > > attach and detach devices from it.
> > > 
> > > Is there a reason for this, or should these drivers stop setting
> > > .suppress_bind_attrs?
> > 
> > I have already asked this question during review of kirin driver:
> > https://lore.kernel.org/linux-pci/20211031205527.ochhi72dfu4uidii@pali/
> > 
> > Microchip driver wanted to change its type from bool to tristate
> > https://lore.kernel.org/linux-pci/20220420093449.38054-1-u.kleine-koenig@pengutronix.de/t/#u
> > and after discussion it seems that it is needed to do more work for this
> > driver.
> > 
> > > For example, Pali and Ley Foon *did* stop setting .suppress_bind_attrs
> > > when adding .remove() methods in these commits:
> > > 
> > >   0746ae1be121 ("PCI: mvebu: Add support for compiling driver as module")
> > >   526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
> > >   ec15c4d0d5d2 ("PCI: altera: Allow building as module")
> > 
> > I added it for both pci-mvebu.c and pci-aardvark.c. And just few days
> > ago I realized why suppress_bind_attrs was set to true and remove method
> > was not implemented.
> 
> With suppress_bind_attrs, the user can't manually unbind a device, so
> we can't get to mvebu_pcie_remove() that way, but since mvebu is a
> modular driver, I assume we can unload the module and *that* would
> call mvebu_pcie_remove().  Right?

Yes! It looks like that if module unloading is allowed then .remove
callback would be called despite suppress_bind_attrs was set.

> > Implementing remove method is not really simple, specially when pci
> > controller driver implements also interrupt controller (e.g. for
> > handling legacy interrupts).
> 
> Hmmm.  Based on your patches below, it looks like we need to call
> irq_dispose_mapping() in some cases, but I'm very confused about
> *which* cases.
> 
> I first thought it was for mappings created with irq_create_mapping(),
> but pci-aardvark.c never calls that, so there must be more to it.

From reading kernel code it looks like that mapping is created when
some other driver request shared INTx IRQ. So it is not done by
pci-aardvark.c but e.g. by wifi driver ath9k (which uses INTx).

> Currently only altera, iproc, mediatek-gen3, and mediatek call
> irq_dispose_mapping() from their .remove() methods.  (They all call
> irq_domain_remove() *before* irq_dispose_mapping().  Is that legal?
> Your patches do irq_dispose_mapping() *first*.)

Documentation says:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/irq/irqdomain.c?h=v5.18#n240

/**
 * irq_domain_remove() - Remove an irq domain.
 * @domain: domain to remove
 *
 * This routine is used to remove an irq domain. The caller must ensure
 * that all mappings within the domain have been disposed of prior to
 * use, depending on the revmap type.
 */

> altera, mediatek-gen3, and mediatek call irq_dispose_mapping() on IRQs
> that came from platform_get_irq().

I think that if IRQ is not used it could be disposed (no need to have it
mapped). So if this IRQ from platform_get_irq() is not shared then in
pci controller driver .remove callback for sure it is not used anymore.
So for non-shared IRQs this looks fine.

> qcom is a DWC driver, so all the IRQ stuff happens in
> dw_pcie_host_init().  qcom_pcie_remove() does call
> dw_pcie_host_deinit(), which calls irq_domain_remove(), but nobody
> calls irq_dispose_mapping().
> 
> I'm thoroughly confused by all this.

Beware that there are IRQs which pci controller uses as "client" and
then there may be also IRQs which pci controller driver allocates via
own IRQ chip driver and provides for other drivers (e.g. as chained irq
handler). So it is needed to distinguish between them. IRQs which
controller driver create via own IRQ chip driver have to be properly
cleaned when calling .remove driver. IRQ which controller driver get via
platform_get_irq() (or similar of method) is under parent driver control
and parent driver is responsible for proper dispose/cleanup.

> But I suspect that maybe I
> should drop the "make qcom modular" patch because it seems susceptible
> to this problem:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ctrl/qcom&id=41b68c2d097e

In pcie-qcom.c there is no irq reference. So maybe it is safe? But I do
not understand designware driver API design...

The best is probably to do runtime test. Boot kernel with pci=nomsi and
connect some PCIe card which supports legacy INTx interrupt. This should
force usage of INTx. Check that card driver is loaded and in file
/proc/interrupts is IRQ line for that driver. Then rmmod pci controller
driver and check that IRQ line in /proc/interrupts disappeared. And also
check that /sys/kernel/debug/irq/irqs/<num> does not exist.

Also another runtime test is to call rmmod and modprobe of pci
controller driver more times (with PCIe card connected) and check that
IRQ numbers assigned to card in /proc/interrupts are same. If after
rmmod + modprobe sequence are numbers increasing then there is some
IRQ-leak in .remove callback.

> > Here are waiting fixup patches for pci-mvebu.c and pci-aardvark.c which
> > fixes .remove callback. Without these patches calling 'rmmod driver' let
> > dangling pointer in kernel which may cause random kernel crashes. See:
> > 
> > https://lore.kernel.org/linux-pci/20220709161858.15031-1-pali@kernel.org/
> > https://lore.kernel.org/linux-pci/20220711120626.11492-1-pali@kernel.org/
> > https://lore.kernel.org/linux-pci/20220711120626.11492-2-pali@kernel.org/
> > 
> > So I would suggest to do more detailed review when adding .remove
> > callback for pci controller driver (or when remove suppress_bind_attrs)
> > and do more testings and checking if all IRQ mappings are disposed.
> 
> I'm not smart enough to do "more detailed review" because I don't know
> what things to look for :)  Thanks for all your work in sorting out
> these arcane details!
> 
> Bjorn

Anyway, this issue was discovered by Hajo Noerenberg as a "Side note:"
during debugging SATA controller:
https://bugzilla.kernel.org/show_bug.cgi?id=216094#c31

It looks like that on some machines rmmod cause immediate kernel crash
and on other machines it is hard to reproduce.
