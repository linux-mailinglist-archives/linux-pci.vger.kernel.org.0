Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B957636A04
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 20:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbiKWTou (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 14:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239327AbiKWTok (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 14:44:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDEFC6550;
        Wed, 23 Nov 2022 11:44:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9CA261EE2;
        Wed, 23 Nov 2022 19:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD71BC433D6;
        Wed, 23 Nov 2022 19:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669232678;
        bh=F02znBj6KNef3o7bHTzpkOxBET/7qugaTKwIDtKe1VI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ObHby0MtZRskNzZAC3jvRQ6u2Q/ljOGaBlx8GSy44q8Qw4TnjTA3WbCid+iwr1Obe
         75ZzNgNy4wUBqVBsJ6j7Clm1Y7h31pvZcr9nF577+sYc0t1GZ80+AaQEgz5hCAbPal
         ZNJ8rMv6w2WBCiP7h5q00J9xNu7Hzw2tS1Yj6bpZpz+qwU/dH9PvwKPxoMfEehannr
         0/9l1ttYnd134l7P/EFLZeIoSE1u/VC2O/L20xBvXzck3X5i6/dHFWPln3QodU175q
         3Z2pLBsRe8o+6lh8aZOXVNXcvmD+CsN4MRXXVpioiuVio61oGqD7LXhGTrVRbmnZbh
         G45ygzVp8RHOg==
Date:   Wed, 23 Nov 2022 13:44:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 17/20] PCI: dwc: Introduce generic resources getter
Message-ID: <20221123194436.GA277209@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113191301.5526-18-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

On Sun, Nov 13, 2022 at 10:12:58PM +0300, Serge Semin wrote:
> Currently the DW PCIe Root Port and Endpoint CSR spaces are retrieved in
> the separate parts of the DW PCIe core driver. It doesn't really make
> sense since the both controller types have identical set of the core CSR
> regions: DBI, DBI CS2 and iATU/eDMA. Thus we can simplify the DW PCIe Host
> and EP initialization methods by moving the platform-specific registers
> space getting and mapping into a common method. It gets to be even more
> justified seeing the CSRs base address pointers are preserved in the
> common DW PCIe descriptor. Note all the OF-based common DW PCIe settings
> initialization will be moved to the new method too in order to have a
> single function for all the generic platform properties handling in single
> place.
> 
> A nice side-effect of this change is that the pcie-designware-host.c and
> pcie-designware-ep.c drivers are cleaned up from all the direct dw_pcie
> storage modification, which makes the DW PCIe core, Root Port and Endpoint
> modules more coherent.

Thanks for these new generic interfaces in the DWC core!  And thanks
for the changes in this patch to take advantage of them in the
pcie-designware drivers.

Do you plan similar changes to other drivers to take advantage of
these DWC-generic data and interfaces?  If you add generic things to
the DWC core but only take advantage of them in your driver, I don't
think they are really usefully generic.

Bjorn
