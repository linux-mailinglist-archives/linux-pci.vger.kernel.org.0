Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653C17C027F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjJJRX6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjJJRXw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 13:23:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8E5B0;
        Tue, 10 Oct 2023 10:23:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C44C433C9;
        Tue, 10 Oct 2023 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696958628;
        bh=TSj2de6BZUqT6Q880gh/gtYBmRWs6W7lYgtCRKx6Ag8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dgVF2qFuAYixvkDzJvLKt5XD8K4GFyiAmDm2ZEc3BKkL3RkH5qcHfTvxRK/LG81jN
         bM9CfeltEVlZGI3hG99F05by+x2gAEKJ4lI6bx3MiPjy99ClRQLRwvBZjuuHsnyuQW
         ZO8BphlSzPRPjNeNtrQqEemhb4/ijt71Rm27icQvXLEp+ASy0IBGcoigGrAP2Y8EL0
         AXwQXkkP0kdRHtdTVG3lQ8YOxUjGpjsW++vUaIs5tJBm4pBpeU0Nd0/RdZ+xExnmnZ
         +9NM6l4Xr8pUI3P9j/COoVhbFNfgVIeJAp3cb02AS40llxdLPqmB6d4zUr7nkLIaeC
         xqbfGLhhULBOQ==
Date:   Tue, 10 Oct 2023 12:23:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Siva Reddy Kallam <siva.kallam@samsung.com>,
        Surendranath Gurivireddy Balla <suren.reddy@samsung.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rob Herring <robh@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 0/4] pci: Fix some section mismatches
Message-ID: <20231010172346.GA984693@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231001170254.2506508-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 01, 2023 at 07:02:50PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> modpost checks about section mismatches are about to get stronger, see
> https://lore.kernel.org/linux-kbuild/20230930165204.2478282-1-u.kleine-koenig@pengutronix.de
> .
> 
> With the above patch applied, enabling the exynos and kirin drivers as
> modules result in a warning about their remove functions that is fixed
> here. The keystone driver is a bit special as it can only be enabled
> built-in and used __refdata on its driver struct. It also had a similar
> issue for .probe fixed in the last patch.
> 
> IMHO all four patches qualify for backporting to stable.

I added stable tags and applied to pci/enumeration for v6.7, thanks!

> Uwe Kleine-König (4):
>   PCI: exynos: Don't put .remove callback in .exit.text section
>   PCI: kirin: Don't put .remove callback in .exit.text section
>   PCI: keystone: Don't put .remove callback in .exit.text section
>   PCI: keystone: Don't put .probe callback in .init.text section

I updated the subjects to be "Don't discard ... callback" to try to
give a little more semantic context.

>  drivers/pci/controller/dwc/pci-exynos.c   | 4 ++--
>  drivers/pci/controller/dwc/pci-keystone.c | 8 ++++----
>  drivers/pci/controller/dwc/pcie-kirin.c   | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> -- 
> 2.40.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
