Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3774EE234
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 21:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiCaUB0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 16:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241135AbiCaUB0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 16:01:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0A715DA90;
        Thu, 31 Mar 2022 12:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D834461AA9;
        Thu, 31 Mar 2022 19:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E470EC340F0;
        Thu, 31 Mar 2022 19:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648756777;
        bh=zM2exlrS01D5axfiZVJ+MH5mb56qdWV9g0I/2RV5CXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=by8vo9fmLJX/KGwbeseghvcQUpNBNjx/zm36SX1TrNyWctyoFztHD/hWgqixKe5gQ
         qCevEw+JfFQlxWNNiHg8ZDohTikJ6wVlcTXuVMzpsvOuocBDvNFNrugoC1emyn8zjY
         UKuBb0OUpYTL10e1qRsEFfDSbgGMbqRFLS1i7SDa5vLbnMSVgIm2w63NpldlaXejFB
         Z5lsc7yW7PG5vrgl5IRovHQ1ctUdSDIztZkeG/fxJDPGF8uoQvApvW1jI+7oAdTfV3
         xibElYvqpty957V6xHYyJOwbfrYxyZsxdbfweT2SMBxfzISeQnGUv+ekKvmtsXRBkG
         dtqxWX9YRSxag==
Date:   Thu, 31 Mar 2022 14:59:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org, Sanju.Mehta@amd.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5 1/2] PCI / ACPI: Assume `HotPlugSupportInD3` only if
 device can wake from D3
Message-ID: <20220331195935.GA29364@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729648c2-6e2c-7076-b5a1-3155ce4fa924@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 31, 2022 at 02:33:12PM -0500, Limonciello, Mario wrote:
> On 3/31/2022 14:04, Bjorn Helgaas wrote:
> > [+cc Rafael, Mika, linux-pm]
> > On Mon, Mar 28, 2022 at 03:55:18PM -0500, Mario Limonciello wrote:
> > ...

> >    On some platforms, e.g., AMD Yellow Carp, firmware may supply
> >    "HotPlugSupportInD3" even though _S0W tells us the device cannot
> >    wake from D3hot.  With the previous code, these devices could be put
> >    in D3hot and hotplugged devices would not be recognized.
> > 
> >    If _S0W exists and says the Root Port cannot wake itself from D3hot,
> >    return "false" to indicate that "dev" cannot handle hotplug events
> >    while in D3.
> > 
> >      1) "dev" has a _PS0 or _PR0 method, or
> > 
> >      2a) The Root Port above "dev" has _PRW and
> > 
> >      2b) If the Root Port above "dev" has _S0W, it can wake from D3hot or
> >          D3cold and
> > 
> >      2c) The Root Port above "dev" has a _DSD with a
> >          "HotPlugSupportInD3" property with value 1.
> 
> Very well, I'll incorporate into the commit message and scrap some of the
> old stuff.
> 
> > The _S0W part makes sense to me.  The _PRW part hasn't been explained
> > yet.  We didn't depend on it before, but we think it's safe to depend
> > on it now?
> 
> An earlier version of this patch actually was only checking this rather than
> _S0W alone.  It was suggested that both should be checked together by
> Rafael.
> 
> https://lore.kernel.org/linux-pci/CAJZ5v0grj=vE1wGJpMxh-Hy7=ommfFUh5hw++nmQdLVxVtCSWw@mail.gmail.com/
> 
> FWIW at least some earlier versions Rafael and Mika both agreed towards that
> direction (and presumably weren't worried about existing systems that this
> code was used for).

OK.  I think it's worth mentioning _PRW even if we don't have a good
explanation for it.  For someone bringing up a platform like this,
that will be a better hint than "adev->wakeup.flags.valid" alone.

> > In the commit log and comments, can we be more explicit about whether
> > "D3" means "D3hot" or "D3cold"?
> 
> The check for _S0W return is looking for "3", so it's really D3hot "or"
> D3cold.  In the problematic case on Yellow Carp, it was D3hot.  I'll add
> this detail.

Linux advertises OSC_SB_PR3_SUPPORT, so I think we are checking for
D3hot.  Of course, if a device can't wake from D3hot, it can't wake
from D3cold either.

You didn't *add* any D3 comments and only quoted the Microsoft doc, so
maybe nothing to change in this patch.  It's confusing to me that the
existing code, like acpi_pci_bridge_d3(), pci_bridge_d3_possible(),
pci_bridge_d3_force, etc., are all ambiguous.

Bjorn
