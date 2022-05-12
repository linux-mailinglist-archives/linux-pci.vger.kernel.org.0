Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C299F525559
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 21:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357852AbiELTGe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 15:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353630AbiELTGc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 15:06:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A813F32C;
        Thu, 12 May 2022 12:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11D9AB82910;
        Thu, 12 May 2022 19:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC36C385B8;
        Thu, 12 May 2022 19:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652382388;
        bh=wvLUTuIMgQTvcQXrs4U57mL2ISHtMlc8i3bkcudyddU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oHOnjfSblftFf7mckEYu4OwFmrcvKPCGxMPa1xLr4OEbpxYoTKN5NXMvEw/bIAQHh
         3pHwiKD4BsP8Fr2aAuNb1D/WTP4YfSlIx7W2QapLVYfwXDm4V1jfOkeMFqVp8cLDbk
         SC/uE2EVsWrnmFsjFWF0I9bWBoWxe8Uk1f2BzN5Dvmc+1ega5Wvi3w/ItRBcvlX6M6
         fch8iQKhO8uib8EqCcAfYkV9Yw56D+cExi+iggPBbG/xDrRaK/n4KbPwwydFA1DJge
         SvTA+BuGqUlTLO+Tu9iWkg22Y/hNKr4Vl8FNgcTzI7nmRGQkIprnA7sRnvFt0u6J5/
         y9hsMkZYbjkfw==
Date:   Thu, 12 May 2022 14:06:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        tjoseph@cadence.com, bhelgaas@google.com, robh@kernel.org,
        kishon@ti.com, kw@linux.com, mparab@cadence.com,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: cadence: Clear FLR in device capabilities
 register
Message-ID: <20220512190626.GA862290@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165228494389.11307.11313445181760109588.b4-ty@arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 05:02:35PM +0100, Lorenzo Pieralisi wrote:
> On Mon, 15 Nov 2021 23:39:16 -0800, Parshuram Raju Thombare wrote:
> > From: Parshuram Thombare <pthombar@cadence.com>
> > 
> > Clear FLR (Function Level Reset) from device capabilities
> > registers for all physical functions.
> > 
> > During FLR, the Margining Lane Status and Margining Lane Control
> > registers should not be reset, as per PCIe specification.
> > However, the controller incorrectly resets these registers upon FLR.
> > This causes PCISIG compliance FLR test to fail. Hence preventing
> > all functions from advertising FLR support if flag quirk_disable_flr
> > is set.
> > 
> > [...]
> 
> Applied to pci/cadence, thanks!
> 
> [1/1] PCI: cadence: Clear FLR in device capabilities register
>       https://git.kernel.org/lpieralisi/pci/c/d3dbd4d862

Obviously you've already seen the kbuild report:
  https://lore.kernel.org/r/202205120700.X76G7aC2-lkp@intel.com

but it looks like most of this patch got lost somehow :)  Happy to fix
it up for you if you want!

Bjorn
