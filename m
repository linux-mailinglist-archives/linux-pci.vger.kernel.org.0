Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5F459D287
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbiHWHoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 03:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241066AbiHWHoL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 03:44:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77B46068E;
        Tue, 23 Aug 2022 00:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73DB8B81979;
        Tue, 23 Aug 2022 07:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7401C433C1;
        Tue, 23 Aug 2022 07:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661240648;
        bh=bT8JLEYL7CvXHYG8IVYaH71kd/rfXTkG5EBbqkCKgcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKRGUQJq3omR1yzRzZOaVV2eBULrBmcDPW7XwoaCpoMcxVmrvV2Gw3YSZQ9pBfRvT
         1PklB5pXIui5jLCwuV5ZXQp1gPoAF+IPozsTdUyh6CT9BRyDD+46VppsMGu/PNk+gP
         RxO195aSkDBsVvRQ5spPNtBeQDyojLpRswUifvTuHUicbl5eD3w4hnCs1P6K+dJKkI
         8oySsofzRgl4jEOc8asrCre5bWwXQ3VM9Ms/PTUPjb9kpoaqbiuZkvUNBAl6b6qx4V
         Qs9KzEymFQK3PBX68huGrTvMrYG1c37LmBNkqt0s//7crbAbd13JMpsEYMJMJOrZhs
         3hye9ihvhV4lw==
Date:   Tue, 23 Aug 2022 09:43:59 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <mail@conchuod.ie>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: PCI: fu740-pci: fix missing
 clock-names
Message-ID: <YwSFPwOkPIVC02fM@lpieralisi>
References: <20220819231415.3860210-1-mail@conchuod.ie>
 <20220819231415.3860210-2-mail@conchuod.ie>
 <20220822192032.GA283027-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822192032.GA283027-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 22, 2022 at 02:20:32PM -0500, Rob Herring wrote:
> On Sat, 20 Aug 2022 00:14:10 +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > The commit b92225b034c0 ("dt-bindings: PCI: designware: Fix
> > 'unevaluatedProperties' warnings") removed the clock-names property as
> > a requirement and from the example as it triggered unevaluatedProperty
> > warnings. dtbs_check was not able to pick up on this at the time, but
> > now can:
> > 
> > arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dtb: pcie@e00000000: Unevaluated properties are not allowed ('clock-names' was unexpected)
> >         From schema: linux/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> > 
> > The property was already in use by the FU740 DTS and the clock must be
> > enabled. The Linux and FreeBSD drivers require the property to enable
> > the clocks correctly Re-add the property and its "clocks" dependency,
> > while making it required.
> > 
> > Fixes: b92225b034c0 ("dt-bindings: PCI: designware: Fix 'unevaluatedProperties' warnings")
> > Fixes: 43cea116be0b ("dt-bindings: PCI: Add SiFive FU740 PCIe host controller")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > v2022.08 of dt-schema is required.
> > ---
> >  .../devicetree/bindings/pci/sifive,fu740-pcie.yaml        | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Should I pick these bindings updates up ?

Lorenzo
