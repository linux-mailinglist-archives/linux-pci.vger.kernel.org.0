Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269D556B22C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 07:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbiGHFPQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 01:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGHFPO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 01:15:14 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2C076973;
        Thu,  7 Jul 2022 22:15:12 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o9gKC-00FpLV-D8; Fri, 08 Jul 2022 15:14:45 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Jul 2022 13:14:44 +0800
Date:   Fri, 8 Jul 2022 13:14:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Conor.Dooley@microchip.com
Cc:     palmer@rivosinc.com, palmer@dabbelt.com, arnd@arndb.de,
        Cyril.Jean@microchip.com, Daire.McNamara@microchip.com,
        Lewis.Hanly@microchip.com, aou@eecs.berkeley.edu,
        gregkh@linuxfoundation.org, kw@linux.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        lorenzo.pieralisi@arm.com, mturquette@baylibre.com,
        paul.walmsley@sifive.com, robh@kernel.org, bhelgaas@google.com,
        sboyd@kernel.org, wsa@kernel.org
Subject: Re: [RESEND PATCH v4] MAINTAINERS: add polarfire rng, pci and clock
 drivers
Message-ID: <Yse9RGTfRgqzzknt@gondor.apana.org.au>
References: <20220622225822.2166305-1-mail@conchuod.ie>
 <a39bad24-d2bb-ef3e-d57a-2ac4fa1156ef@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a39bad24-d2bb-ef3e-d57a-2ac4fa1156ef@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 07, 2022 at 01:30:27PM +0000, Conor.Dooley@microchip.com wrote:
> On 22/06/2022 23:58, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > Hardware random, PCI and clock drivers for the PolarFire SoC have been
> > upstreamed but are not covered by the MAINTAINERS entry, so add them.
> > Daire is the author of the clock & PCI drivers, so add him as a
> > maintainer in place of Lewis.
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Arnd, Palmer:
> Does the SoC tree make more sense for this patch?
> I am missing an ack from Herbert (but I don't think that's blocking
> for a MAINTAINERS update to my own entry?).

I'm not sure why an ack is needed from me since the entry doesn't
intersect with crypto at all.  But FWIW

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
