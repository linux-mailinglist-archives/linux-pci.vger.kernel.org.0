Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0573AC60
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 00:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjFVWKc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 18:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFVWKb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 18:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE9A1FF5;
        Thu, 22 Jun 2023 15:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74A77618C4;
        Thu, 22 Jun 2023 22:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903F5C433C8;
        Thu, 22 Jun 2023 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687471829;
        bh=Ke/TK6For1fPBUENdncOwbByNc7GJYM1Ix6ru4BSrcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r/zgV1WnCYrMoedTMcuJEVB4haogeQSZK2ir4Y71ITbROdx+6RrAus63venoBPG5G
         aVmPYa/O7N0H4VwivYHptCkg6uuakE3eK+xjYZwVuj7TcTyXoWgcp/6ONuJJNhLKdy
         XxdwUc6QerH+nmlocQMfZXIFWACEbX/3LeTa6Szsal6ocNdk0rRCch7q4hyMoEg6+a
         A9ZPhorPeaqhJhmixicxtB3ywA1osWmbhdAORjS74wszSXm7aG+gnVhAwwcAcPFETT
         mXtln1D01q+C4lNPOppR/FevOLWf8CnHEd/PpSEPj/GkND9AYqkaL5wiQM3hkd1gWy
         nA81a8VEpCfHA==
Date:   Thu, 22 Jun 2023 17:10:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Call _REG when transitioning D-states
Message-ID: <20230622221028.GA138247@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03e5d343-848c-02c7-2deb-917d1b93ce8c@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 21, 2023 at 05:52:52PM -0500, Limonciello, Mario wrote:
> 
> On 6/21/2023 5:28 PM, Bjorn Helgaas wrote:
> > On Tue, Jun 20, 2023 at 09:04:51AM -0500, Mario Limonciello wrote:
> > > Section 6.5.4 of the ACPI 6.4 spec describes how AML is unable to access
> > > an OperationRegion unless `_REG` has been called.
> > > 
> > > "The OS runs _REG control methods to inform AML code of a change in the
> > > availability of an operation region. When an operation region handler
> > > is unavailable, AML cannot access data fields in that region.
> > > (Operation region writes will be ignored and reads will return
> > > indeterminate data.)"
> > > 
> > > The PCI core does not call `_REG` at anytime, leading to the undefined
> > > behavior mentioned in the spec.

> I double checked a BIOS debug log which shows ACPI calls
> to confirm and didn't see a single _REG call for any device
> before this patch across a boot/suspend/resume cycle.

OK, thanks, I didn't see one either, which surprised me.

Based on the weird exception in sec 6.5.4:

  Since the [PCI_Config operation region on a PCI root bus containing
  a _BBN object] is permanently available, no _REG methods are
  required, nor will OSPM evaluate any _REG methods that appear in the
  same scope as the operation region declaration(s) of this type.

it seems like when we add a PCI host bridge, we should evaluate any
_REG in the host bridge scope if it does not include _BBN.

The example:

  It should be noted that PCI Config Space Operation Regions are ready
  as soon the host controller or bridge controller has been programmed
  with a bus number. PCI1’s _REG method would not be run until the
  PCI-PCI bridge has been properly configured.

suggests that when we set a PCI-PCI bridge's secondary bus number, we
should evaluate any _REG in its scope.

  At the same time, the OS will also run ETH0’s _REG method since its
  PCI Config Space would be also available. The OS will again run
  ETH0’s _REG method when the ETH0 device is started.

So evidently we should evaluate ETH0._REG once after setting PCI1's
secondary bus number, and again when "ETH0 is started."  I have no
idea what "started" means.

> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> For the new patch.

Thanks for taking a look at it!

I think we're missing some other _REG stuff, but it seems like what
this patch adds does match the per-endpoint power management requires,
so I applied these to pci/pm for v6.5.

Bjorn
