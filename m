Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0694551ED3A
	for <lists+linux-pci@lfdr.de>; Sun,  8 May 2022 13:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiEHLYH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 May 2022 07:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiEHLXw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 May 2022 07:23:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D824EBC06
        for <linux-pci@vger.kernel.org>; Sun,  8 May 2022 04:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E528B8085B
        for <linux-pci@vger.kernel.org>; Sun,  8 May 2022 11:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4C0C385AC;
        Sun,  8 May 2022 11:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652008800;
        bh=ViD5+uHbZqMQqaRmWo5W6o24alINySE4RJfRCtxuQ4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aoorc29jf+HuKQeIGFvSBPoSMdTkLdx3XjPyEpCDmi4GB3yaH6oFMx3wLcNN0W9zm
         zDUAHLNddAnYO4BGUKQfOe5ZmOYefv8oheOQcy3KdCJyNd3xy/LbL4PixYG25eJ0uJ
         e7o0/lZzfKa5R6rUTY8fO+CmHOp6nktWJqrS1BgOkL/U3NiIPDlvitdSceFUFe8mwr
         Aj2zsU0L8GOzzkcUgh0ueoA3WLN+QExd6tQL+yGQfKFIUH50QKjg3ByLM1Puj0VlFi
         u437gxhMJrestbdzVHQMt1NoXJo2MTMEbvc4vFTIn+yGJfqd2gf66cAHJLMyXflFTi
         2wNycEa685u6w==
Date:   Sun, 8 May 2022 14:19:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Message-ID: <YnenXMZk/m+GlWcV@unreal>
References: <87a6bxm5vm.fsf@epam.com>
 <20220506201722.GA555374@bhelgaas>
 <20220507013436.GB63055@ziepe.ca>
 <87levdljw3.fsf@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87levdljw3.fsf@epam.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 07, 2022 at 10:25:16AM +0000, Volodymyr Babchuk wrote:
> 
> 
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Fri, May 06, 2022 at 03:17:22PM -0500, Bjorn Helgaas wrote:
> >
> >> > Modules linked in: xt_MASQUERADE iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
> >> > nf_defrag_ipv4 libcrc32c iptable_filter crct10dif_ce nvme nvme_core at24
> >> > pci_endpoint_test bridge pdrv_genirq ip_tables x_tables ipv6
> >> >  CPU: 3 PID: 287 Comm: sh Not tainted 5.10.41-lorc+ #233
> >> >  Hardware name: XENVM-4.17 (DT)
> >                 ^^^^^^^^^^^^^^^^^
> >
> >> So this means the VF must have an SR-IOV capability, which sounds a
> >> little dubious.  From PCIe r6.0:
> >
> > Enabling SRIOV from within a VM is "exciting" - I would not be
> > surprised if there was some wonky bugs here.
> 
> Well, yes. But in this case, this VM has direct access to the PCIe
> controller. So it should not cause any troubles. I'll try baremetal
> setup, though. 

If I remember correctly, the VM software that runs on hypervisor needs
to filter PCI capabilities even for pass-through devices.

The vfio kernel module did this for QEMU, so something similar I would
expect from XEN too.

Thanks

> 
> 
> -- 
> Volodymyr Babchuk at EPAM
