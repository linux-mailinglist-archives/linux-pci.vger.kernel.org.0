Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55591584306
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 17:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiG1PYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 11:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiG1PYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 11:24:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F061B0C;
        Thu, 28 Jul 2022 08:24:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E700B82491;
        Thu, 28 Jul 2022 15:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A88C433D7;
        Thu, 28 Jul 2022 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659021860;
        bh=EsA74sOB2n98wUsKoE7FhRXKRQmfuntkL/X594nUluc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h+8lY04M+5g4HrnAtPnqR0ikmpbndvTE452QXSiiAODQQkQi+BucTIoVF+8tUYqFu
         vcuetjjmfSYXsc0QyGESgRqvpakmEYuWJ2kJN5KrZAQ4cywkMZzkim6DBEpkwUN0Se
         nNQWJAmssAKtjVPTdfTJ4NzLhKR8W0Eqa+jYLp9Z2kRkR3iCK1sT3E6XP2/+HAehHG
         xjRre/UwlV66FlM0bQhWN1ZkVlExpOKVrtcmUfN3G4o7n4L3yCthIo77DFX4Age58t
         RcBYJio2Mx3aM/Eno0tw7czz/ATWeFF/sS/cvLGjvg3OhpX/IgfkDduOf1PCOVy7xM
         cNOl+yvmFukJQ==
Date:   Thu, 28 Jul 2022 10:24:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH RESEND v4 03/15] PCI: dwc: Convert to using native
 IP-core versions representation
Message-ID: <20220728152418.GA302516@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624143947.8991-4-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:39:35PM +0300, Serge Semin wrote:
> Since DWC PCIe v4.70a the controller version can be read from the
> PORT_LOGIC.PCIE_VERSION_OFF register. Version is represented in the FourCC
> format [1]. It's standard versioning approach for the Synopsys DWC
> IP-cores. Moreover some of the DWC kernel drivers already make use of it
> to fixup version-dependent functionality (See DWC USB3, Stmicro STMMAC or
> recent DW SPI driver).

These references to other drivers might be useful, but without a
function name or file name, I can't easily find them.

> In order to preserve the standard version
> representation and prevent the data conversion back and forth, we suggest
> to preserve the native version representation in the DWC PCIe driver too
> in the same way as it has already been done in the rest of the DWC
> drivers. IP-core version reading from the CSR will be introduced in the
> next commit together with a simple macro-based API to use it.
> 
> [1] https://en.wikipedia.org/wiki/FourCC
