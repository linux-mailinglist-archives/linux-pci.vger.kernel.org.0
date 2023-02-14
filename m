Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA017696B4F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 18:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjBNRVd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 12:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjBNRVW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 12:21:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC09B2364A;
        Tue, 14 Feb 2023 09:20:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9558CE1FCF;
        Tue, 14 Feb 2023 17:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECADC433D2;
        Tue, 14 Feb 2023 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676395254;
        bh=2rnYZIWvntoiAMAXipAB60LfQP8MvT54/ijVfPKhiMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=osxFZtRQZ3e8WBFLbfRcZ9lBiJBPcOv9KF5UEjxutLEmzld+H06GEuv+aULQRfHga
         TSdCu37hj2ix401iIq1mbxClKqMqgN3j+HiIuQLOsD3M5GAONsDwp2ByXsCw7FfG/d
         UbobfT5bpz63ReUqHkkPnlsGH6HNmINPzhSgOC7v3WQowYcn7HGwkyK/CHDhp6A/Vs
         USdkzsbI8ykxkB3gTeAKpjs+WYRT4kokkZlVZqAIOnN04fzZRYYwzduPtnkeUXhefW
         GvpKX1mlt9q3HRuBrZ9+UICcLTIAx+gylljc8KZ7VSMpcZ5VMq1RuGjsK/xhrKTDy9
         1tprqIGQ5LDQA==
Date:   Tue, 14 Feb 2023 11:20:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] kbuild, PCI: generic,versatile: comment out
 MODULE_LICENSE in non-modules
Message-ID: <20230214172053.GA3044917@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873578xnir.fsf@esperi.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 14, 2023 at 03:41:32PM +0000, Nick Alcock wrote:
> On 13 Feb 2023, Bjorn Helgaas spake thusly:
> > On Fri, Feb 10, 2023 at 04:47:42PM +0000, Nick Alcock wrote:

> >   - Please follow the subject line convention for each file.  They're
> >     mostly there after dropping "kbuild", but do capitalize the
> >     sentence that follows the prefix.  The prefix should always be
> >     "PCI/<driver-tag>: "

I misspoke about "PCI/<driver-tag>".  I use "PCI/<feature>" for things
like MSI, AER, ASPM, etc.  "PCI: <driver-tag>" is the usual pattern
for things specific to a driver, and it sounds like this is what
you've already done:

  $ git log --oneline drivers/pci/controller/pci-versatile.c
  6086987bdeb5 PCI: versatile: Remove redundant variable retval
  b64aa11eb2dd PCI: Set bridge map_irq and swizzle_irq to default functions
  669cbc708122 PCI: Move DT resource setup into devm_pci_alloc_host_bridge()
  d3bb94d06aae PCI: Drop unnecessary zeroing of bridge fields
  6a589900d050 PCI: Set default bridge parent device
  79cbde56f98b PCI: versatile: Drop flag PCI_ENABLE_PROC_DOMAINS
  3cf0eead9fb8 PCI: controller: Convert to devm_platform_ioremap_resource()
  a4b21b858b56 PCI: versatile: Use pci_host_probe() to register host
  331f63457165 PCI: of: Add inbound resource parsing to helpers
  2999dea8e94a PCI: versatile: Remove usage of PHYS_OFFSET
  f9f4fdaa3509 PCI: versatile: Use pci_parse_request_of_pci_ranges()
  0018b265adf7 PCI: versatile: Fix I/O space page leak

> ... If the rules for generating prefixes vary by subsystem this means
> I'll have to fight through God knows how many annoyed maintainers to get
> this incredibly trivial change in.)

I think your script generally does the right thing, and it's already
far more than most folks do, so thank you for that!

I normally do that sort of minimal fixup silently when applying
because there's no point in reposting when it's faster to make those
trivial edits myself.  In this case, removing MODULE_LICENSE instead
of commenting it out is just a little more than I like to do when
keeping your signed-off-by.

Bjorn
