Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D59664508
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 16:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjAJPiO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 10:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjAJPiM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 10:38:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5D0AE70;
        Tue, 10 Jan 2023 07:38:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0417B81731;
        Tue, 10 Jan 2023 15:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CCCC433EF;
        Tue, 10 Jan 2023 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673365087;
        bh=Ae0S8Vw/l+xGMbOvlfmhz4OmrcFgB5X+e/tuUD64qhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LAWqU2ypxGwCgqobnWL36+/jv/dCMhLsYAZUHxhpU110wHlVuN2EUk7Vvz4RC6X/E
         xff/aw4iDInfuL3EQZFPF4bs+vnYhRE91JbuGx3spYd4ZeybMLbTfmYBnXZ9ttamZz
         EBFMnKR8DXo9vOEZ3xvmKBPXnc/doVhI7SSeJ3CmSuhz/QItKad0x4TkR3hPrvHPBM
         7crUXpv96kb6eqgL4UyOkoYbj4UF+4ApTdaf9wDnLXRcoPcchW7SB/YV39AY6IHiWn
         2Uc7SWjQwWCTRfQBhPtTw0y/LMAH8l79DjKdRw4/sTWEjbFXpFnT5oZrBF2CcO67S7
         HaKhi4i/GF4dg==
Date:   Tue, 10 Jan 2023 09:38:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Achal Verma <a-verma1@ti.com>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Milind Parab <mparab@cadence.com>
Subject: Re: [PATCH v2 2/2] PCI: j721e: Add support to build pci-j721e as
 module.
Message-ID: <20230110153805.GA1505901@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db93c472-f617-3207-af57-55b14de8e236@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 09, 2023 at 09:06:14PM +0530, Vignesh Raghavendra wrote:
> On 09/01/23 6:05 pm, Achal Verma wrote:
> > Discussed with Vignesh the current config dependency of pcie-cadence and pci-j721e modules,
> > it seems like for now to modularize these drivers with minimal changes is to use "select"
> > as they were used before in PCI_J721E_HOST and PCI_J721E_EP config options.
> 
> With this patch its now impossible to build PCI_J721E_HOST without
> pcie endpoint support (as PCI_ENDPOINT is now a dependency). I don't
> know a way to achieve this via Kconfig magic w/o splitting pci-j721e.c
> into EP/RC (like pcie-rcar* or pcie-rockchip*)
> 
> > Will push updated version with "depends on PCI_ENDPOINT" in PCI_J721E config to check
> > dependency on PCI_ENDPOINT before selecting PCIE_CADENCE_EP.
> > 
> 
> Please don't top post and respond inline:
> https://en.wikipedia.org/wiki/Posting_style#Interleaved_style

Apparently there was also email from Achal to Vignesh that didn't make
it to the archives, probably because it was HTML or other "fancy"
email.  See the thread overview here, which is missing something:
https://lore.kernel.org/all/20230108155755.2614147-1-a-verma1@ti.com/

It's best to use plain text email when possible.  See
http://vger.kernel.org/majordomo-info.html for details.

Bjorn
