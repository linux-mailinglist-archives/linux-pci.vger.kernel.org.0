Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8276D6CA7E6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjC0Ok4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 10:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjC0Okz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 10:40:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67785A1
        for <linux-pci@vger.kernel.org>; Mon, 27 Mar 2023 07:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C15BB8109B
        for <linux-pci@vger.kernel.org>; Mon, 27 Mar 2023 14:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10AEC433EF;
        Mon, 27 Mar 2023 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679928051;
        bh=0TcOPi4Gcp3a+W41ZFYXoIeDL14JYnIHpJjl4ASlgYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r366261yijjNudqVP4llQiVqiweYgHI3OZHt61pEWUxGkrSCPChWvKKAr6Ysx5lDp
         3dcrN8DdIYs/+wq1aSO9DV/hVhJMPe7xPYQ3yggm1nljMCDo/3A8uN0jrUmJKs/eHg
         nLNFMER9z6uWxbJbeWu0ccOpLV0RUoXJCwIs3qkNjOe9/uRe13n+8lnp+NfQHNEH8W
         eqBxGrbYJJMEcoDSPxyzyxfFjWstEIA8SyspSA36aM5DkKS0oAMZschT6UHRIIDSTe
         dmut0Ev1y7y8d2gsVmBpedRuNKwVIeQ5mJ7g1arLxRbuPaWGzlU9nRbusF7Ge4vIJW
         2VR3bU+jyMA/Q==
Date:   Mon, 27 Mar 2023 09:40:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>, shuo.tan@linux.alibaba.com
Subject: Re: [PATCH] PCI/PM: Wait longer after reset when active link
 reporting is supported
Message-ID: <20230327144050.GA2835405@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327094250.GC33314@black.fi.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 27, 2023 at 12:42:50PM +0300, Mika Westerberg wrote:
> On Sun, Mar 26, 2023 at 08:22:07AM +0200, Lukas Wunner wrote:
> > On Wed, Mar 22, 2023 at 05:16:24PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Mar 21, 2023 at 11:50:31AM +0200, Mika Westerberg wrote:

> > > After ac91e6980563, we called pci_bridge_wait_for_secondary_bus() with
> > > timeouts of either:
> > > 
> > >   60s for reset (pci_bridge_secondary_bus_reset() or
> > >       dpc_reset_link()), or
> > > 
> > >    1s for resume (pci_pm_resume_noirq() or pci_pm_runtime_resume() via
> > >       pci_pm_bridge_power_up_actions())
> > > 
> > > If I'm reading this right, the main changes of this patch are:
> > > 
> > >   - For slow links (<= 5 GT/s), we sleep 100ms, then previously waited
> > >     up to 1s (resume) or 60s (reset) for the device to be ready.  Now
> > >     we will wait a max of 1s for both resume and reset.
> > > 
> > >   - For fast links (> 5 GT/s) we wait up to 100ms for the link to come
> > >     up and fail if it does not.  If the link did come up in 100ms, we
> > >     previously waited up to 1s (resume) or 60s (reset).  Now we will
> > >     wait up to 60s for both resume and reset.
> > > 
> > > So this *reduces* the time we wait for slow links after reset, and
> > > *increases* the time for fast links after resume.  Right?
> > 
> > Good point.  So now the wait duration hinges on the link speed
> > rather than reset versus resume.
> > ...

> I can update the patch accordingly.

If you do an update, is it possible to split into two patches so one
increases the time for resume for fast links and the other decreases
the time for reset on slow links?  I'm thinking about potential debug
efforts where it might be easier to untangle things if they are
separate.

Bjorn
