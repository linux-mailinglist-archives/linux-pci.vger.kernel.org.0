Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7170F6066DF
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 19:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJTRSA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJTRRx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 13:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C31E0996;
        Thu, 20 Oct 2022 10:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 072B661CD3;
        Thu, 20 Oct 2022 17:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4F2C433C1;
        Thu, 20 Oct 2022 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666286268;
        bh=1rp6r0y4uMJZEDwYCK7LlaG7tkovwCKcpoYZi+svkvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BHWtPIThNHNWJkMHYj+qfboxeq2h8Jd4t7AvVxcs2vf23nVosXm1bzJlgx3tWVUex
         MJLk0OBtTYqYHNMCRZT8ZW+Ljp3HrznaR2wmUVnC5D/5vnXj+sZm+sPgmPEIq29Obn
         R0sLdstA4kZBnKOohQei2Om5V+u89uaQznkEOOpU1hlE49xVtv8Tzf3JeYziH2XvwG
         05DEJB3fvKlyfHe3zJOMoFfqcInbTAbWMGjhPAJfLos9uIQFKKzkUsh3dYat9Vv3t2
         yc+7e5Vz8pOzB3M2DQTJQU7KWXJkXDmjFOF+lxs5XQng96/+NFcjhsIskWs3BYl/cF
         Cnz1QgSmqupXQ==
Received: by pali.im (Postfix)
        id 678B080E; Thu, 20 Oct 2022 19:17:45 +0200 (CEST)
Date:   Thu, 20 Oct 2022 19:17:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>,
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
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI: Remove unnecessary of_irq.h includes
Message-ID: <20221020171745.jxne3unbiq5qt2vq@pali>
References: <Y1D2ubkwXqwx9LWD@wendy>
 <20221020134547.GA94120@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020134547.GA94120@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 20 October 2022 08:45:47 Bjorn Helgaas wrote:
> [+cc Pali, heads-up for trivial addition of <linux/irqdomain.h> to
> pci-mvebu.c]
...
> pci-mvebu.c also relies on getting <linux/irqdomain.h> via
> <linux/of_irq.h>, but it actually depends on of_irq.h, so I'll just
> add an irqdomain.h include there.
> 
> Bjorn
> 

Ok, that is fine!
