Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6ED60D2C1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 19:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJYRt2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 13:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJYRt0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 13:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211316F76A
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 10:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CCC961A2F
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 17:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BACC433C1;
        Tue, 25 Oct 2022 17:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666720163;
        bh=SjYZtO7uVFtoWeOdmMMh+bSReDF4EywbfbhcErZPgdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Od1vQEKbiYR/PdWy+eA85DCcg+1GXycxv5tIHoVDVBGRXn08CvvsLh2GQw1nXRnAu
         iS7gZKWjb037bA3GG06gZAvyirLYKzRPPtObtfslYIx9cqGDjLdRdWdZR7Mr6KE6tv
         UDo60OSCg7T4aOcOu9sDBxu+3f4nHX6xd/8Yo0Op+P/ZTw0CO3Nvyr+kuprzNsz1bs
         WKjixwtNZzWjmRZj+aSPU1qV9zkXjn0nuGaXwV1sURIg44Q9dMrf/6QZimieqVhv3K
         nNX4ifOlJq4WooSQXP18kL78iCGBdStZr1RDfOLu3LSWqYhnWEWevdyx4s2JqQVGbf
         2c8vucs3lbXHg==
Date:   Tue, 25 Oct 2022 12:49:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zvika Vered <veredz72@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [Bug 216555] New: Kernel 4.19.135: pci_resource_start,
 pci_resource_len return wrong value
Message-ID: <20221025174921.GA660689@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005165358.GA2298432@bhelgaas>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 05, 2022 at 11:53:58AM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 05, 2022 at 01:00:58PM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216555
> >            Summary: Kernel 4.19.135: pci_resource_start, pci_resource_len
> >                     return wrong value
> 
> > I used 4.19.135(x64) + rootfs (buildroot) to boot an x86 SBC. 
> > This SBC is connected via PCIe to a customized PCIe IO card.
> > 
> > In the kernel module, I used pci_resource_start, pci_resource_len to find
> > start, length of 3 BARs. 
> > It worked fine. 
> > 
> > Then I used the same kernel, kernel module on another x86 SBC. 
> > In this SBC, pci_resource_start, pci_resource_len returned wrong data. 
> > I booted this SBC with Centos 8.2 (4.18) and also with vanilla 4.9.20. 
> > It worked fine. 
> > 
> > Is it possible that 4.19.135 has a BUG ?
> 
> It's unlikely that pci_resource_start() and pci_resource_len() are
> broken in 4.19.135, but I guess anything is possible.
> 
> Can you give any more details about why it seems broken?  Dmesg logs
> of a boot that fails and one that works, for instance?

I see that you attached a dmesg log and some more details to the
bugzilla, thank you!

I don't see "AdtIoInit" in the kernel tree, and I can't match the
[1172:0001] with anything.  Can you also attach the driver source to
the bugzilla?  

Bjorn
