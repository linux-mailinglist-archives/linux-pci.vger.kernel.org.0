Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF52748855
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 17:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjGEPtr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 11:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjGEPte (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 11:49:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A570B19BA;
        Wed,  5 Jul 2023 08:49:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A61161607;
        Wed,  5 Jul 2023 15:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A42CC433CA;
        Wed,  5 Jul 2023 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688572169;
        bh=Wk/EDtW10p6pp6WTwmzgYg6QrckaCsMdnVGkAU0iNaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E84fDqN41ael8RB8O2f19tkcvhuFrd6zuDsO1tXY+Z69XQqtcA8ljbDN3XG9xIvif
         b7leT2sE2Va1DD2f17avNwUaKmLa34lG+4mlM4x85RPbEOknw69N/pYzYezhSFqqup
         0KKeAOQsCvZy5uN4LSh+o5Cuu/ii46NBVP7cgrdoJfcSF79vYVfpa9zPF4oSC8QeIC
         XEIYuhbcxhv3IHSSnzV4/Pyj4lk+mtohnz6+vdgt9RJYCgiy69Qbpig58lUkHLagBQ
         3mTvoW1lDdZm3CXh2XjueeU6y+5BW3v9XYvGubIqP3WSEdI1gyDCiM2XQ4xtlhDH0t
         XX/gNQXDhk1xQ==
Date:   Wed, 5 Jul 2023 10:49:27 -0500
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
Subject: Re: [EXTERNAL] Re: [PATCH] PCI: j721e: Fix delay before PERST#
 deassert
Message-ID: <20230705154927.GA62511@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a245938e-2140-5f77-ab91-6cfbd3ddf66c@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 04, 2023 at 09:36:43PM +0530, Verma, Achal wrote:
> On 7/3/2023 9:51 PM, Bjorn Helgaas wrote:
> > In subject, "Fix" doesn't convey much information.  Does it increase?
> > Decrease?  How much time are we talking about?  PERST# deassert is at
> > one end of the delay; what event is at the other end?
> 
> How about "Increase delay to 100ms for PERST# deassert from moment
> power-rails achieve operating limits"

Maybe something like "Delay 100ms T_PVPERL from power stable to PERST#
inactive" to match the language in the spec?

> > Is this delay for the benefit of the Root Port or for the attached
> > Endpoint?  If the latter, my guess is that some Endpoints might
> > tolerate the current shorter delay, while others might require
> > more, and it doesn't sound like "TI's K3 SoC" would be relevant
> > here.
>
> Its for the endpoints, TI's EVB doesn't exhibit any issues with
> 100us delay but some customer reported the issue with shorter delay.

I wouldn't bother mentioning "some custom platform implemented using
TI's K3 SOCs" then, because the problem is that the driver didn't
observe T_PVPERL, so the problem will happen with some endpoints but
not others.

> > Numbers like 100ms that come from the PCIe specs should have #defines
> > for them.  If we don't have one already, can you add one, please?
>
> Sure, will do it in next revision but should this go in some generic PCI
> header file or just pci-j721e.c

I think it should be in drivers/pci/pci.h so all the controller
drivers can use the same thing.  Obviously none of them *currently*
use it, although there are a bunch of "msleep(100)" and a few comments
that mention T_PVPERL.

Bjorn
