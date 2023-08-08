Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234A0774EA4
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 00:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjHHWty (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 18:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjHHWty (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 18:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163341FD8;
        Tue,  8 Aug 2023 15:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8AD662E00;
        Tue,  8 Aug 2023 22:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12891C433C7;
        Tue,  8 Aug 2023 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691534952;
        bh=vazB5ubdA1Xae9qWpSwshgsUyH+SQh5z62VSNnbq7aA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oaoP151C3Thr8C+TVhNJJF3Uh7I/I/tkRw6LH57T6uC4CJ45XHol+7CqPzxhm41CM
         h5Xb2UYDOJWFnQiSYOOkEa78Y7NXBjVXizlET2owFcyktNZluqVlGgXH7dL1F0QFv3
         7eY4AXTwgWjB2yzyjqQVJ2izoI7f/p3hVDiH+91W6kMI7DL2lTzp8vJDbWECaSUr+k
         3QO/856nhXkzPj8XLzpqIJdk3w4EPwhL8Nfp69hN2JfGKs4S4g+JRl0onx/XNNWkm7
         rgZ9C3vwbB1JBhwRwteiZXb5je6FJ3PEwWmRbMRAazUgz3kshmF5NI90KLYDhllBqP
         ZEufbfeSWwzyQ==
Date:   Tue, 8 Aug 2023 17:49:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Verma, Achal" <a-verma1@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [EXTERNAL] Re: [PATCH] PCI: cadence: Set the AFS bit in Device
 Capabilities 2 Register
Message-ID: <20230808224910.GA334895@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95cd3e2-8cc0-cc65-9d62-2edb23adc292@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 04, 2023 at 01:22:56PM +0530, Verma, Achal wrote:
> On 8/2/2023 9:49 PM, Bjorn Helgaas wrote:
> > In subject, "Advertise ARI Forwarding Supported".
> Ok
> > 
> > It's not obvious that "AFS" refers to ARI Forwarding Supported, and
> > the bit name is enough; we don't need to know that it's in Dev Cap 2.
> > "Advertise" shows that we're just *advertising* the functionality, not
> > *enabling* it.
> > 
> > On Wed, Aug 02, 2023 at 04:00:59PM +0530, Achal Verma wrote:
> > > J7 PCIe Root Complex has ARI Forwarding Support, means supporting
> > > forwarding of TLPs addressed to functions with function number greater than
> > > 7 but some PCIe instances on J7 have this bit cleared which results in
> > > failure of forwarding of TLPs destined for function number > 7.
> > > Setting the AFS bit in Device Capabilities 2 Register explicitly, resolves
> > > the issue and leads to successful access to function number > 7.
> > 
> > s/AFS/ARI Forwarding Supported/
> > 
> > > Some observations:
> > > 1. J7200-EVB has single PCIe instance(PCIe1) for which ARIFwd bit is not
> > >     set. Enumeration gracefully fails for funciton number greater than 7 but
> > >     later read/write access to these funcitons results in a crash.
> > 
> > By "ARIFwd bit" here, I assume you mean PCI_EXP_DEVCAP2_ARI in the Root
> > Port?  Maybe you can use the #define to make this more greppable.
> > 
> will replace with PCI_EXP_DEVCAP2_ARI
> > s/funciton/function/ (twice)
> > 
> > If we don't enumerate function numbers greater than 7, we shouldn't
> > have pci_dev structs for them, so why are there later read/write
> > config accesses to them?
> > 
> > If the Root Port doesn't advertise ARI Forwarding Supported,
> > bridge->ari_enabled will not be set, and we shouldn't even try to
> > enumerate functions greater than 7.  So it's not that enumeration
> > *fails*; it just doesn't happen at all.
> > 
> > > 2. On J721E-EVB, PCIe1 instance has ARIFwd bit set while it is cleared for
> > >     PCIe0 instance. This issue combined with errata i2086
> > >     (Unsupported Request (UR) Response Results in External Abort) results in
> > >     SERROR while scanning multi-function endpoint device.
> > 
> > Is the SERROR when scanning under PCIe0 or under PCIe1?
> > 
> > I'm not clear on what's happening here:
> > 
> >    1) Root Port advertises PCI_EXP_DEVCAP2_ARI, we set
> >       bridge->ari_enabled and scan functions > 7, we do a config read
> >       to function 8, get a UR response (as expected during enumeration)
> >       and that results in SERROR?
> > 
> >    2) Root Port *doesn't* advertise PCI_EXP_DEVCAP2_ARI, we don't set
> >       bridge->ari_enabled, so we don't try config read to function 8,
> >       and something blows up later?
> > 
> >    3) Something else?
> > 
> Hello Bjorn,
> 
> There are multiple issues which are leading to different behavior on
> different platforms.
> 
> 1. PCI_EXP_DEVCAP2_ARI is not set.
> 
> Consider scenario:
> J7200 (RC) --- J721E (EP with 1 PF and 4 VFs)
> 
> PF enumerates successfully on J7200 but bringing up 4 associated VFs (echo 4
> > /sys/bus/pci/devices/<device>/sriov_numvfs) doesn't workout. First VF gets
> devfn = 6 and then +1 for next one on wards. 6 and 7 are setup fine but 8
> and 9 fails and UR is received while accessing them. Accessing VFs > 7
> doesn't go through the ARI support check and directly calls
> pci_setup_device(). So, since PCI_EXP_DEVCAP2_ARI is not set, unable to
> access VFs > 7.
> 
> do_serror+0x34/0x88
> el1_error+0x8c/0x10c
> pci_generic_config_read+0x90/0xd0
> cdns_ti_pcie_config_read+0x14/0x28
> pci_bus_read_config_word+0x78/0xd0
> __pci_bus_find_cap_start+0x2c/0x78
> pci_find_capability+0x38/0x90
> set_pcie_port_type+0x2c/0x150
> pci_setup_device+0x90/0x728
> pci_iov_add_virtfn+0xe4/0x2e0
> sriov_enable+0x1f0/0x440
> pci_sriov_configure_simple+0x34/0x80
> sriov_numvfs_store+0xa4/0x190

Thanks!  Obviously you should make the Root Port advertise
PCI_EXP_DEVCAP2_ARI if you want to use that functionality.

But I think the fact that we add a device with fn > 7 when ARI is not
enabled is also an underlying defect in iov.c.  

sriov_init() already checks whether ARI is enabled, and I think we
should probably remember that somewhere and use it in
pci_iov_add_virtfn() to avoid adding VFs with fn > 7.

Bjorn
