Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E840F6B3C7D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 11:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCJKlD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 05:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJKlB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 05:41:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897C7E348C;
        Fri, 10 Mar 2023 02:40:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EF2861355;
        Fri, 10 Mar 2023 10:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6AAC433D2;
        Fri, 10 Mar 2023 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678444832;
        bh=DD48udtqkyZS6kvJb3EFINWyU+CCt8eEvkAUyiqzJhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOf77dI3dzwnNLmdgJtbKJYLrBZUvib2G5Kj7AT73no62YMgBGRCxOh15stIhMCgW
         Xn00l9zWCMxbiPXnwfsRsSv6XjILgm2AwEbkBmahSjVQIB87hNF7svEqZyTuAIpq+N
         EEv3US+uFq/2GJdyp/4Z8j12S4C1jFNvQK5Lacap0i5hRFDPtRy18Tb4SZO/lAzaxu
         u1xCLo+abO+J9+MkBq+rGvHbef4DDX5Wj02QikU8H8K9QvZDYXhYkAxpq8yFKLifFC
         98NmfJlmRzzSEXgHqir+8KBg2idEKlzX5TI320y7jGkMoHXts/owYSHH39qwAEwQa3
         WFXPPP5jMIHMA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: kirin: select REGMAP and REGMAP_MMIO
Date:   Fri, 10 Mar 2023 11:40:26 +0100
Message-Id: <167844411812.1209684.12017386820985241641.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <04636141da1d6d592174eefb56760511468d035d.1668410580.git.josh@joshtriplett.org>
References: <04636141da1d6d592174eefb56760511468d035d.1668410580.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 13 Nov 2022 23:23:26 -0800, Josh Triplett wrote:
> pcie-kirin uses regmaps, and needs to pull them in; otherwise, with
> CONFIG_PCIE_KIRIN=y and without CONFIG_REGMAP:
> 
> drivers/pci/controller/dwc/pcie-kirin.c:359:21: error: variable ‘pcie_kirin_regmap_conf’ has initializer but incomplete type
>   359 | static const struct regmap_config pcie_kirin_regmap_conf = {
> 
> Similarly, without CONFIG_REGMAP_MMIO, pcie-kirin produces a linker
> failure looking for __devm_regmap_init_mmio_clk.
> 
> [...]

Applied to controller/kirin, thanks!

[1/1] PCI: kirin: select REGMAP and REGMAP_MMIO
      https://git.kernel.org/pci/pci/c/3a2776e8a0e1

Thanks,
Lorenzo
