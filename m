Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6448D7056EC
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjEPTR4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEPTR4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:17:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E447AB8;
        Tue, 16 May 2023 12:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B12EA63374;
        Tue, 16 May 2023 19:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC783C433EF;
        Tue, 16 May 2023 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684264674;
        bh=yr0uqH5L7lcw6Bon72OOti1I9caZ3nRhsMf6+olPitc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=M80Sd3FJPgGUW2mIUfNeFY2PFR3PUEibBoOnCrGE6B1x4FOQ6uT5DsZIx0iRtsKyv
         VK6p9g5aB81JFKLtm7UI5S33uSCeBwYAe6xCW6hRHllXnsN+ElmCc9I8fsxUx43UwO
         2sCnuQgbQ3tPrYrc/PWX1SK/PmHLwZS0Ql8HMeBZlzUVU8vhhI6oHoX1VwBv0sTzEx
         WXN+0a9nMlqDJHf3i/qUYEHB5PJm0h0feCj7AW2itoj67OUlGxrqYTZ/I/A/c7Kyoq
         FSB3B9NSfEI+1vHtrBrP3byMnMPGZmw7kv8PI01CBNOk0cw+Idn+4bMjsQ0GPxOCAL
         sUhFI/ucJBBmg==
Date:   Tue, 16 May 2023 14:17:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>, yangyicong@huawei.com,
        will@kernel.org, baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <ZGPW4JzOOUT4ksMf@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230516160304.00000544@Huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 16, 2023 at 04:03:04PM +0100, Jonathan Cameron wrote:
> 
> PCI folks, Question below directed at you. Please take a look.
> +CC linux-cxl because a similar question is going to bite us shortly
> if we want CXL PMUs to work well on RP or Switch ports.
> 
> > >> +static int dwc_pcie_ras_des_discover(struct dwc_pcie_pmu_priv *priv)
> > >> +{
> > >> +    int index = 0;
> > >> +    struct pci_dev *pdev = NULL;
> > >> +    struct dwc_pcie_rp_info *rp_info;
> > >> +
> > >> +    INIT_LIST_HEAD(&priv->rp_infos);
> > >> +
> > >> +    /* Match the rootport with VSEC_RAS_DES_ID */
> > >> +    for_each_pci_dev(pdev) {  
> > > 
> > > Does the PCI layer not offer a more robust mechanism for this?
> > > (PCI fixups come to mind, but I don't actually know whether that
> > > would be a viable approach or not.)   
> > 
> > I am afraid not yet. Jonathan try to add a PMU service but it is
> > not merged into mainline.
>
> I wouldn't read much into that 'failure'.  We never persisted with
> that driver because it was for an old generation of hardware.
> Mostly the aim with that was to explore the area of PCIe PMU in
> general rather than to get the support upstream. Some of the
> counters on that hardware were too small to be of much use anyway :)
> 
> Grabbing just relevant functions..
> 
> Bjorn, we need to figure out a way forwards for this sort of case
> and I'd appreciate your input on the broad brush question of 'how
> should it be done'?
> 
> This is a case where a PCIe port (RP here) correctly has the PCIe
> class code so binds to the pcie_port driver, but has a VSEC (others
> examples use DOE, or DVSEC) that provides extended functionality.
> The referred to PCIe PMU from our older Hisilicon platforms did it
> by adding another service driver - that probably doesn't extend
> well.
> 
> The approach used here is to separately walk the PCI topology and
> register the devices.  It can 'maybe' get away with that because no
> interrupts and I assume resets have no nasty impacts on it because
> the device is fairly simple.  In general that's not going to work.
> CXL does a similar trick (which I don't much like, but too late
> now), but we've also run into the problem of how to get interrupts
> if not the main driver.

Yes, this is a real problem.  I think the "walk all PCI devices
looking for one we like" approach is terrible because it breaks a lot
of driver model assumptions (no device ID to autoload module via udev,
hotplug doesn't work, etc), but we don't have a good alternative right
now.

I think portdrv is slightly better because at least it claims the
device in the usual way and gives a way for service drivers to
register with it.  But I don't really like that either because it
created a new weird /sys/bus/pci_express hierarchy full of these
sub-devices that aren't really devices, and it doesn't solve the
module load and hotplug issues.

I would like to have portdrv be completely built into the PCI core and
not claim Root Ports or Switch Ports.  Then those devices would be
available via the usual driver model for driver loading and binding
and for hotplug.

Bjorn
