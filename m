Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05789520471
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 20:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbiEIS0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbiEIS0W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 14:26:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0D75C37C
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 11:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F325B818EB
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 18:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BADC385B2;
        Mon,  9 May 2022 18:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652120545;
        bh=ZywGLT77izhmCWQgflfk6iNiNTQWmozB2XEuegpVAKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jo+AMuwlbd9D87EeubHZOqC2IxRX5OQOnKPKzIG/9DAxD/u7/kkIZIJ5bTAcjeQhv
         gvJ3YUdoFph495wn+XYYCt59yVoOMH+ycFTnAGOjmg/BpLzpgNWQ4tz086AkBbZqCg
         DZ4+RTLfZzvErzN2at69EhLRNfrYDbGtJ3Pp4onJw6NvZQy4M9z1SVGq5sCFeBxiCZ
         F7D7v3+0Fj4J8uR9+57B/ssrSJSvxbp+JHd28AyNmkc+8gDRSV7HASl1PDDZmazb4j
         AD0dZYep16K6mCoqb6bxUMLTIrQQ9PUc+wHmuLmqOYqnrxhsIUGnhijqaFvLZouL1d
         aVVSsPFxAQ0Og==
Date:   Mon, 9 May 2022 12:22:21 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Message-ID: <Ynlb3X+rqoNFTR0t@kbusch-mbp>
References: <87a6bxm5vm.fsf@epam.com>
 <20220506201722.GA555374@bhelgaas>
 <20220507013436.GB63055@ziepe.ca>
 <87levdljw3.fsf@epam.com>
 <YnenXMZk/m+GlWcV@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnenXMZk/m+GlWcV@unreal>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 08, 2022 at 02:19:56PM +0300, Leon Romanovsky wrote:
> On Sat, May 07, 2022 at 10:25:16AM +0000, Volodymyr Babchuk wrote:
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > On Fri, May 06, 2022 at 03:17:22PM -0500, Bjorn Helgaas wrote:
> > >
> > >> > Modules linked in: xt_MASQUERADE iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
> > >> > nf_defrag_ipv4 libcrc32c iptable_filter crct10dif_ce nvme nvme_core at24
> > >> > pci_endpoint_test bridge pdrv_genirq ip_tables x_tables ipv6
> > >> >  CPU: 3 PID: 287 Comm: sh Not tainted 5.10.41-lorc+ #233
> > >> >  Hardware name: XENVM-4.17 (DT)
> > >                 ^^^^^^^^^^^^^^^^^
> > >
> > >> So this means the VF must have an SR-IOV capability, which sounds a
> > >> little dubious.  From PCIe r6.0:
> > >
> > > Enabling SRIOV from within a VM is "exciting" - I would not be
> > > surprised if there was some wonky bugs here.
> > 
> > Well, yes. But in this case, this VM has direct access to the PCIe
> > controller. So it should not cause any troubles. I'll try baremetal
> > setup, though. 
> 
> If I remember correctly, the VM software that runs on hypervisor needs
> to filter PCI capabilities even for pass-through devices.
> 
> The vfio kernel module did this for QEMU, so something similar I would
> expect from XEN too.

AIUI, some kind of translation from GPA to HPA needs to happen, but I'm not
sure how that would occur for the VF's enabled within the guest when the host
doesn't know about those functions.
