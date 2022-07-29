Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95E25849D3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jul 2022 04:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiG2Cgw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 22:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiG2Cgv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 22:36:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDC363912;
        Thu, 28 Jul 2022 19:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62445B82677;
        Fri, 29 Jul 2022 02:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4BCC433D6;
        Fri, 29 Jul 2022 02:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659062208;
        bh=cVG+ATCgcUfwL3lkHWG2UgB0F2FCWRxuUaK7fXxdEU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b3DfgOJ/48XvUjyLkvp4sM+3H+kdMfqje6D7jrV9svFvhRpP57dS1ramWfEBMpZnh
         n+Rg71eHPUQVCEqTpEwgvl2F9r8Y/GsLXqtnJXvJ7QqMEIohCA1VOJbYYFB//PaBf1
         5FvAbpvjG/gxMX3YkvLbatQOwjkOvoAIk9Qj+zlHDWCJvbIBwIodGeMCHL70Rbfuva
         yciGQ83UTAyyOxT4kP1RzU90saNROlCZxA7arsxcRk5QINL09Qkkgn8bEh4GM3v51Q
         IaIbwqyszRJqqrAeio9dEvulEHlbNJqwmiFlBCqEJzyUVoEATIZVNID1efOhKf75kL
         a9efKhVjxEzQw==
Date:   Thu, 28 Jul 2022 21:36:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 00/15] PCI: dwc: Add hw version and dma-ranges
 support
Message-ID: <20220729023645.GA423256@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:32PM +0300, Serge Semin wrote:
> This patchset is a second one in the series created in the framework of
> my Baikal-T1 PCIe/eDMA-related work:

> Serge Semin (15):
>   PCI: dwc: Add more verbose link-up message
>   PCI: dwc: Detect iATU settings after getting "addr_space" resource
>   PCI: dwc: Convert to using native IP-core versions representation
>   PCI: dwc: Add IP-core version detection procedure
>   PCI: dwc: Introduce Synopsys IP-core versions/types interface
>   PCI: intel-gw: Drop manual DW PCIe controller version setup
>   PCI: tegra194: Drop manual DW PCIe controller version setup
>   PCI: dwc: Add host de-initialization callback
>   PCI: dwc: Drop inbound iATU types enumeration - dw_pcie_as_type
>   PCI: dwc: Drop iATU regions enumeration - dw_pcie_region_type
>   PCI: dwc: Simplify in/outbound iATU setup methods
>   PCI: dwc: Add iATU regions size detection procedure
>   PCI: dwc: Verify in/out regions against iATU constraints
>   PCI: dwc: Check iATU in/outbound ranges setup methods status

I applied the above to pci/ctrl/dwc for v5.20, thanks!

>   PCI: dwc: Introduce dma-ranges property support for RC-host

I deferred this one for now because the current value isn't clear yet.
If we have a user for it, I'll be glad to add it.

Bjorn
