Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631255267AF
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 18:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiEMQ5h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 12:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiEMQ5g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 12:57:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBEB1408E
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 09:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDD81B8310C
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 16:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E19C34116;
        Fri, 13 May 2022 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652461052;
        bh=3LgAB7LXidCIIPCa2afVRTeOdsjPVUd09/+ADq6bqWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+d5yxeVs1u0LFwkEttogOcyjr092IoJp23roLZjwnWPBpmtBfVIpnWtgTCILyVgW
         4+ZuoAxuVk0ZGFobSFGV7a8Z0MnHD666rIALk97iHuKkth8LopUrqsIZ81GzbpccTY
         5c05g1iRkeb3ios9XzeLh5K9zGZe+5Ukt4qhoP6QGowWjE1PxQe6K4A7g2rGcyJFmY
         tBpKcKCLNsBop3hCrqFojVCdxVDcblegEyHiMiXZLxJZB4Tzm/pGC4hVknxOdnMBnB
         yA+IlVTwektG5ss89neRJeMEQhcj+h8cVDs7GOf3tx9joyWo6h05ui708UM2SVrMC6
         p0pUESGVuevbA==
Received: by pali.im (Postfix)
        id 46E742B90; Fri, 13 May 2022 18:57:29 +0200 (CEST)
Date:   Fri, 13 May 2022 18:57:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 06/18] PCI: pciehp: Enable DLLSC interrupt only if
 supported
Message-ID: <20220513165729.wuaatfr2drsjwoos@pali>
References: <20220220193346.23789-1-kabel@kernel.org>
 <20220220193346.23789-7-kabel@kernel.org>
 <20220509034216.GA26780@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220509034216.GA26780@wunner.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 09 May 2022 05:42:16 Lukas Wunner wrote:
> On Sun, Feb 20, 2022 at 08:33:34PM +0100, Marek Behún wrote:
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -788,6 +788,7 @@ static int pciehp_poll(void *data)
> > @@ -800,12 +801,17 @@ static void pcie_enable_notification(struct controller *ctrl)
> >  	 * next power fault detected interrupt was notified again.
> >  	 */
> >  
> > +	pcie_capability_read_dword(ctrl_dev(ctrl), PCI_EXP_LNKCAP, &link_cap);
> >  	/*
> > -	 * Always enable link events: thus link-up and link-down shall
> > -	 * always be treated as hotplug and unplug respectively. Enable
> > -	 * presence detect only if Attention Button is not present.
> > +	 * Enable link events if their support is indicated in Link Capability
> > +	 * register: thus link-up and link-down shall always be treated as
> > +	 * hotplug and unplug respectively. Enable presence detect only if
> > +	 * Attention Button is not present.
> >  	 */
> > -	cmd = PCI_EXP_SLTCTL_DLLSCE;
> > +	cmd = 0;
> > +	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
> > +		cmd |= PCI_EXP_SLTCTL_DLLSCE;
> 
> The Data Link Layer Link Active Reporting Capable bit is cached
> in ctrl_dev(ctrl)->link_active_reporting.  Please use that
> instead of re-reading it from the register.
> 
> According to PCIe r6.0, sec. 7.5.3.6, "For a hot-plug capable
> Downstream Port [...], this bit must be hardwired to 1b."
> 
> That has been part of the spec since PCIe r1.1, sec. 7.8.6.
> 
> PCIe r1.0 did not contain the sentence because it did not support
> DLLLARC (it defined bit 20 as RsvdP).
> 
> In other words, what you're doing here is add support for PCIe r1.0.
> I'm not opposed to that, but I'd assume that aardvark supports a
> more recent spec version.  More likely it doesn't comply with the spec?
> 
> What is the user-visible issue that you're experiencing without this
> commit?  Does aardvark somehow misbehave if the DLLLARC bit is set to 1?
> Since the bit is RsvdP, setting it shouldn't have any negative side
> effects.

I will let fixing those issues to Marek.

To answer your questions: Config space of Aardvark Root Port does not
conform to PCIe base spec. It does not implement DLLLARC, nor DLLSCE and
lot of other bits. Plus it has Type 0 header (not Type 1). And due to
these reasons, pci-aardvark.c driver implements "emulation" of the
Root Port and implements some of the functionality via custom aardvark
registers. So Root Port would be presented to kernel and also to
userspace as PCI Bridge device with Type 1 header and with PCIe
registers required by linux kernel.

During my testing of kernel hotplug code last year, I figured out that
kernel was waiting for event which never happened. And so it was needed
to "fix" kernel to not try to enable DLLSCE because it did nothing.

I asked more times Marvell for Aardvark documentation, so I could fix
these issues, but I have never received any response for it.

> 
> > --- a/drivers/pci/hotplug/pnv_php.c
> > +++ b/drivers/pci/hotplug/pnv_php.c
> > @@ -840,6 +840,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
> >  	struct pci_dev *pdev = php_slot->pdev;
> >  	u32 broken_pdc = 0;
> >  	u16 sts, ctrl;
> > +	u32 link_cap;
> >  	int ret;
> >  
> >  	/* Allocate workqueue */
> 
> pnv_php.c is a driver for PowerNV, yet this patch is for a series
> targeting an ARM PCIe controller.  That doesn't make sense,
> changes to pnv_php.c seem wrong here.
> 
> Thanks,
> 
> Lukas

At time when I prepared this patch (year ago) I changed that DLLSCE
pattern in all places because it looked like copy+paste code which
should be fixed too.
