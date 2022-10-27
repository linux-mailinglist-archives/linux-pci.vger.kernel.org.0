Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BE36102FB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 22:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiJ0UoY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 16:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbiJ0UoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 16:44:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B206900EC;
        Thu, 27 Oct 2022 13:44:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99A35624FB;
        Thu, 27 Oct 2022 20:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8134CC433D6;
        Thu, 27 Oct 2022 20:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666903443;
        bh=1WFnbnn3zbUPH00YtbahVjyY6AI44s2NkGuMdyiii/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FZtW/CM009MDAznzqWUrFuUnFIeWgFeBr7Gy/jl6Xhai3qvkIIjhTj3oygXgWy4L/
         ifs7aO4X0+1WunUcHEMeoB6T//oN4rQJbIQuNvAPNI3rVtJ+5Q2RWoWRrbf8nIe8OU
         WQ5DuZ1dUMegx0jgU2/IKvXe7bjMddjjmacBxD5dAdgtFwpcOseMojtsQCxjf1GulO
         6YfUeW8jmcntWTYst4y3M3FZ6FdBaL2vIHruGaLWl/me1pHa529DhZ9QWjqrQ0GWCa
         4a9UXXfV2IcmjWFD7wI2Lza1+o+OSv9y5YGnUJtU8GslUoqdLJp5jXz634iGoqnJE3
         MN2SiLKAHWk8A==
Date:   Thu, 27 Oct 2022 15:44:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Message-ID: <20221027204401.GA838114@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ba39e79-7fe5-a644-83da-c8fc05a1ca84@amd.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 27, 2022 at 02:56:19PM -0500, Limonciello, Mario wrote:
> On 10/27/2022 00:24, Lukas Wunner wrote:
> > ...

> > I think git.kernel.org links are preferred to 3rd party hosting services.
> 
> I wasn't aware of any such policy.  Within the last release it seemed to me
> Github was perfectly acceptable to use for links.
> 
> $ git log v6.0..v6.1-rc1 | grep "Link: https://github" | wc -l
> 107
> $ git log v6.0..v6.1-rc1 | grep "Link: https://git.kernel.org" | wc -l
> 2

I'm not aware of a formal policy, but I do prefer kernel.org links
because github is a 3rd party company that may not persist, may add
ads, etc.  I know github may *also* add value like fancier markup,
cross referencing, CI services, etc., but for commit logs, the
longevity of kernel.org is pretty persuasive to me.

There's a similar situation with mailing lists where many of the old
links to archives like marc.info, spinics.net, lkml.org, etc., are now
dead or not as useful for building tools (b4, for instance).

So no big deal, but I would probably silently convert them when
applying.  The current formats I use are:

  commits: https://git.kernel.org/linus/dff6139015dc
  files:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-acpi.c?id=v6.0#n976

Bjorn
