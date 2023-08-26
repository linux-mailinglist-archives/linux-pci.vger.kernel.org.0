Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9207896E0
	for <lists+linux-pci@lfdr.de>; Sat, 26 Aug 2023 15:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjHZNLM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Aug 2023 09:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjHZNLK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Aug 2023 09:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E581BCD;
        Sat, 26 Aug 2023 06:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A6661520;
        Sat, 26 Aug 2023 13:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73A6C433C8;
        Sat, 26 Aug 2023 13:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693055467;
        bh=k1KBNma+mj9R6FSjzC6LtY+2F3uIa1IqFiWhk15mOYs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vuu19/SERi1EBgk27a3l85/2K+GMkEwHBqiiCXXqg7sU/pZ246pcBNXqH8DjCKgse
         qFNjioHYAAQq7i2QNUY6PZKniqvR0sjakPuifbKDY6ar3B2Vtl/mkW04Sumj8xY4Kj
         OM3ciKR7d9S4xjbkiBZwjqx5rVPLABNPTWdzSUiZ50OPuHGa3bfr0PURx957FlSoq/
         pTOM6yrWvuOf1j+qodQjKqZTh9oBPp7ntXn40NALfmFFfuY2nFC9/CfMFghH+pqL9c
         GYtyp5CNNX2KFFGv9Xr4dukWnMJxCuFl5fFv4Bx/nETtaoJRIYbGwytde4Y4hWeE/8
         vgo/wU7r9PmTw==
Date:   Sat, 26 Aug 2023 08:11:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        koba.ko@canonical.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
Message-ID: <20230826131105.GA691555@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230825063948.GY3465@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 09:39:48AM +0300, Mika Westerberg wrote:
> On Fri, Aug 25, 2023 at 01:43:08PM +0800, Kai-Heng Feng wrote:
> > On Fri, Aug 25, 2023 at 1:29 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > On Thu, Aug 24, 2023 at 09:46:00PM +0800, Kai-Heng Feng wrote:
> > > > On Thu, Aug 24, 2023 at 7:57 PM Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:

> > I think what Bjorn suggested is to keep AER enabled for D3hot, and
> > only disable it for D3cold and S3.
> > 
> > > > Unless there are cases when device firmware behave differently to
> > > > D3hot? Then maybe it's better to disable AER for both D3hot, D3cold
> > > > and system S3.
> > >
> > > Yes, this makes sense.
> > 
> > I agree that differentiate between D3hot and D3cold unnecessarily make
> > things more complicated, but Bjorn suggested errors reported by AER
> > under D3hot should still be recorded.
> > Do you have more compelling data to persuade Bjorn that AER should be
> > disabled for both D3 states?
> 
> Is there even an AER error that can happen when a device is in D3hot
> (link is in L1) or D3cold (link is in L2/3)? I'm not an expert in AER
> but AFAICT these errors are reported when the device is in active state
> not when it is in low power state.

I don't think a device in D3cold can signal its own errors.  But the
link transition to L2/L3 as a device goes to D3cold may cause the
bridge above to log an error.  And of course a config access to a
device in D3cold will probably result in an Unsupported Request being
logged by the bridge above it.  I think these are the sorts of errors
we do need to avoid or ignore somehow.

But Configuration and Message requests definitely happen in D3hot, and
they can cause errors reported via AER.  The spec (r6.0, sec 2.2.8)
recommends that Messages be handled the same in D0-D3hot.

PTM is an example of where we had errors being reported at suspend/
resume because we had it configured incorrectly.  If we disabled AER
in D3hot we might not learn about that kind of configuration problem.
That's what makes me think there's some value in keeping AER enabled
in D3hot.

Bjorn
