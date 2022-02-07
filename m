Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B1A4AC877
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 19:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiBGSXw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 13:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiBGST6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 13:19:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08402C0401DA;
        Mon,  7 Feb 2022 10:19:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DC7E6134E;
        Mon,  7 Feb 2022 18:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E27C340EE;
        Mon,  7 Feb 2022 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644257996;
        bh=Pn51NOBNr1hKEsHOlr0Wztr3o+6cLRvr8UUIea4mfNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vi7nyWHM6I2FbeXRzzUmIxGqGot0X4pDHvK+1sp9Q/rsT6ZKy37CrxN3HL5RwdZKP
         hYed5PNqtSLMDdKKBsbsnceFf28XsNxDEJ68rsmUdkxJDjxwr5fH3e97AAH3NwFWPf
         wcGpYPEXQqMC7MsyQiZ+o1ffmOZF5xvp9KOij9gNTPLj2aqQ84vqmLgryLcWFc0xVH
         gB2WIpQRBGfBQnyuqsxE8k52pjJ9n1DKxXgfpu5o7BDrTz9+BP8aanPgZjkcNkIQTZ
         1ZL1oFUCDxIbeKzAGVSoUVKF5CPFKgenlsaJseCALicG70jmrzlF9siVwmAq3c4phI
         kIo6Zn0iZwTqQ==
Date:   Mon, 7 Feb 2022 12:19:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, kw@linux.com, krzysztof.kozlowski@canonical.com,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1 10/10] PCI: tegra: Add Tegra234 PCIe support
Message-ID: <20220207181955.GA407458@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205162144.30240-11-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 05, 2022 at 09:51:44PM +0530, Vidya Sagar wrote:
> Add support for Synopsys DesignWare core IP based PCIe host controllers
> present in the Tegra234 SoC.

Can you please split this into two patches?

  - A patch that does the struct tegra194_pcie_of_data to struct
    tegra_pcie_of_data conversion but doesn't change any
    functionality, and

  - A patch that adds Tegra234 support?

It would be really helpful to be able to see the Tegra234 stuff by
itself.

Bjorn
