Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB076B5404
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 23:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCJWNl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 17:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCJWNl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 17:13:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70725EBDAD
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 14:13:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 081F261D5F
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 22:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9E9C433EF;
        Fri, 10 Mar 2023 22:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678486418;
        bh=1iYjuTj5ubI6FTGBw/s1BxXUJUtDzUzCOYbIrbl6EFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SKck0Li40sIMj5gjiB/5MlDYTRQSNpZuVA8Jr+DEHL+lvZ095rMCMIB/I6yxKPrhl
         Yl3E0CrPNYg4GWEQL5NBYoQgfVjTAA4oorn5PPRmIdVJkpwZBHZCQUmtSh+z/EJF05
         dUrxs0fZJ7GUe/dB/LqNIsVkLIgcMeprjJwBC97Wj9GBD9HKUpZx8CbD1XVG52UocX
         NKV/8jEx8IM3QWFikVQUF9NNG8ybjkXSA5vOsBSXA93BpDUzdy59L3bOse2x6xqYKU
         Aj5rwV6bdh9qck5NOm2lj2IrGw//kXEnRM0pjB2g60CujZVHFKpNmHDq+bu8jVbefi
         O/ewQqgK44Www==
Date:   Fri, 10 Mar 2023 16:13:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj Natikar <bnatikar@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Message-ID: <20230310221336.GA1282150@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1bd2cd-ea0e-7f2f-3d4a-62e9dea892b8@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 09, 2023 at 06:57:38PM -0600, Mario Limonciello wrote:
> On 3/9/23 16:30, Bjorn Helgaas wrote:
> > On Thu, Mar 09, 2023 at 12:32:41PM -0600, Limonciello, Mario wrote:
> > > On 3/9/2023 12:25, Bjorn Helgaas wrote:
> > > ...
> > 
> > > > > > https://gitlab.freedesktop.org/agd5f/linux/-/commit/07494a25fc8881e122c242a46b5c53e0e4403139
> > > > 
> > > > That nbio_v7.2.c patch and this patch don't look anything alike.  It
> > > > looks like the nbio_v7.2.c patch might run once?  Could *this* be done
> > > > once at enumeration-time, too?
> > > 
> > > They don't look anything alike because they're attacking the problem from
> > > different angles.
> > 
> > Why do we need different angles?
> 
> The GPU driver approach only works if the GPU is enabled.  If the GPU could
> never be disabled then it alone would be sufficient.
> 
> > > The NBIO patch fixes the initialization value for the internal registers.
> > > This is what the BIOS "should" have done.  When the internal registers are
> > > configured properly then the behavior the kernel expects works as well.
> > > 
> > > The NBIO patch will run both at amdgpu startup as well as when resuming from
> > > suspend.
> > 
> > If initializing something as BIOS should have done makes the hardware
> > work correctly, isn't once enough?  Why does the NBIO patch need to
> > run at resume-time?
> 
> During suspend some internal registers are in a power domain that the state
> will be lost.  These are typically restored by the BIOS to the values
> defined in initialization tables before handing control back to the OS.

I don't quite get this.  I thought I read that if BIOS had initialized
the hardware correctly, a D0->D3hot->D0 transition would work without
any issues.  Linux can do this with PMCSR writes and BIOS isn't
involved at all.

Bjorn
