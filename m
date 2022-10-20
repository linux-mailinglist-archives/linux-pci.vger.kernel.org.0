Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C978606215
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 15:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJTNqL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 09:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJTNqG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 09:46:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCECC11874B;
        Thu, 20 Oct 2022 06:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D34C4CE252D;
        Thu, 20 Oct 2022 13:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AC2C433C1;
        Thu, 20 Oct 2022 13:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666273549;
        bh=gEzBsG2afAcJArkvwrtS1d1ZrUezVmRH4opGNtVPXAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VJGp3AgHy1aLrltfoH3ZUIY2vPiG8odz2T6+x6jMCxcJgZCwTqS9qB3icoBC8o4E8
         E1gfpoW8H0h3qQq/0/EZYuKYCvQC8HL2tkyrpL4XwUeqKy9JVjs4nQoNI/bL0fqMMC
         fht4bNrhgVpd8SagpFnXZ9RE9junpC95FZ9mZIXzSFLwxrvemWT4v9YJzydgYmRwr9
         Dq/0vR7MpzhoHTTfYTeffDWxoum67vJnPgSuWd0+edba3zhaABe6sytQ7LWcvC1QV0
         OeDSrpxLauYQmP8C3WM0IafIX95qvt1v+oz6aA+EnOZHYUsc8+crMpW+Mx2cnmWOWH
         H+9jYGQE6tu6w==
Date:   Thu, 20 Oct 2022 08:45:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     kernel test robot <lkp@intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        llvm@lists.linux.dev, Minghuan Lian <minghuan.Lian@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
        Toan Le <toan@os.amperecomputing.com>,
        linux-riscv@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ray Jui <rjui@broadcom.com>, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org, Mingkai Hu <mingkai.hu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>, Michal Simek <monstr@monstr.eu>,
        kbuild-all@lists.01.org, Scott Branden <sbranden@broadcom.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, Tom Joseph <tjoseph@cadence.com>,
        linuxppc-dev@lists.ozlabs.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH] PCI: Remove unnecessary of_irq.h includes
Message-ID: <20221020134547.GA94120@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1D2ubkwXqwx9LWD@wendy>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Pali, heads-up for trivial addition of <linux/irqdomain.h> to
pci-mvebu.c]

On Thu, Oct 20, 2022 at 08:20:25AM +0100, Conor Dooley wrote:
> On Thu, Oct 20, 2022 at 03:08:50PM +0800, kernel test robot wrote:
> > Hi Bjorn,
> > 
> > I love your patch! Yet something to improve:
> > 
> > >> drivers/pci/controller/pcie-microchip-host.c:473:31: error: incomplete definition of type 'struct irq_domain'
> >            struct mc_pcie *port = domain->host_data;
> 
> That's what I get for only visually inspecting the patch before Acking
> it.. Un-ack I suppose.

No problem!

I think what happened is the pcie-microchip-host.c uses
irq_domain_add_linear() so it needs <linux/irqdomain.h>, but it
currently gets it via <linux/of_irq.h>, which it doesn't otherwise
need.

I added a preparatory patch to include <linux/irqdomain.h> explicitly,
but I haven't been able to cross-build either riscv or ia64 to verify
this fix.  I'll wait a few days and post an updated series for the
0-day bot to test.

Same situation for pcie-altera-msi.c.

pci-mvebu.c also relies on getting <linux/irqdomain.h> via
<linux/of_irq.h>, but it actually depends on of_irq.h, so I'll just
add an irqdomain.h include there.

Bjorn

