Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D6673ACE2
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 01:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFVXGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 19:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFVXGT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 19:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA032121;
        Thu, 22 Jun 2023 16:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2291461901;
        Thu, 22 Jun 2023 23:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC1FC433C0;
        Thu, 22 Jun 2023 23:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687475169;
        bh=pegMzDXZUMfrU4xRrjxoACjUG6/qK6YYOfic7NwK9pQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hCs5CNZZoiMELCn9nFEKCsyp66MGgCSd2Hzf8wePvkKGKs/N+DcO7GzoWqVgM/rZh
         iW+LAI5zdWRxLtq3a0bEgxjjIdjiy+s3XAiwQgU6SoRhvDy7tpbopbMg3wvZw4i2Ij
         3a8C11GppvO/fKDyUKbhbq2mndKZmjBz1K9wVlDoiASZBWjx51O+bYXKG176utoHSa
         hoVCcwBOZ4nGfc8mGbBkrjICYP5YjfuZUUihqLLFQEfn0BSO/WchgD+ZnlxSlcMg3c
         iMKpWlxW7wW7qQcn/92rhrrQg1ZpSJLOTkMoRLkKYLhG6I3gtvpTp4nKouZBXkEc9F
         b4r1Dh5HAjaZQ==
Date:   Thu, 22 Jun 2023 18:06:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
Message-ID: <20230622230607.GA155247@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b4b2c6c-8119-95fd-8958-dbbecc66510c@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 20, 2023 at 01:36:59PM -0500, Limonciello, Mario wrote:
> <snip>
> > > A variety of Intel chipsets don't support lane width switching
> > > or speed switching.  When ASPM has been enabled on a dGPU,
> > > these features are utilized and breakage ensues.
> > Maybe this helps explain all the completely unmaintainable ASPM
> > garbage in amdgpu and radeon.
> > 
> > If these devices are broken, we need quirks for them.
> 
> The problem is which device do you consider "broken"?
> The dGPU that uses these features when the platform advertises ASPM
> or the chipset which doesn't support the features that the device
> uses when ASPM is active?
> 
> With this problem I'm talking about the dGPU works fine on hosts
> that support these features.

Without more details about what's broken and when, I can't say.  What
I *think* is that a device that doesn't work per spec needs a quirk.
Typically it's a device that advertises a capability that doesn't work
correctly.

> > > > > I think the pragmatic way to approach it is to (essentially)
> > > > > apply the policy as BIOS defaults and allow overrides from
> > > > > that.
> > > >
> > > > Do you mean that when enumerating a device (at boot-time or
> > > > hot-add time), we would read the current ASPM config but not
> > > > change it?  And users could use the sysfs knobs to
> > > > enable/disable ASPM as desired?
> > >
> > > Yes.
> > >
> > Hot-added devices power up with ASPM disabled.  This policy would
> > mean the user has to explicitly enable it, which doesn't seem
> > practical to me.
>
> Could we maybe have the hot added devices follow the policy of
> the bridge they're connected to by default?
>
> > > > That wouldn't solve the problem Kai-Heng is trying to solve.
> > >
> > > Alone it wouldn't; but if you treated the i225 PCIe device
> > > connected to the system as a "quirk" to apply ASPM policy
> > > from the parent device to this child device it could.
> >
> > I want quirks for BROKEN devices.  Quirks for working hardware is a
> > maintenance nightmare.
>
> If you follow my idea of hot added devices the policy follows
> the parent would it work for the i225 PCIe device case?

That doesn't *sound* really robust to me because even if the default
config after hot-add works, the user can change things via sysfs, and
any configuration we set it to should work as well.  If there are
land-mines there, we need a quirk that prevents sysfs from running
into it.

Bjorn
