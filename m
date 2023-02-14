Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92DA696426
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 14:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjBNNDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 08:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjBNNDt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 08:03:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C1223874;
        Tue, 14 Feb 2023 05:03:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED85A61636;
        Tue, 14 Feb 2023 13:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2758C433EF;
        Tue, 14 Feb 2023 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676379827;
        bh=Ah31oBpDRFH3gj+Pln1eAvPNgbibR+8IhW3nJlNAJ/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NOnVnOwjkpHpAEh8YY2F2IoXstPQmHwo79yS0DQZ4IbaqB/LgigG1rEgwVQkzxWIY
         Th1VZfzyUjR8t+Tv/TJu4yew37NJpTWae0jts3JYg1dh3kmpYDIsoKfctXJBXLYKDY
         gDFo7gbiDpjEulu4m/3FSEtRYS53+v2viHmKEnjqCB0YD95Szq6VHprYJ+TGCzqvPP
         rIMXf5QnK6jTHp9yuwm6T11fBQHX/uoaBoWzGyr6QuTNHyCymsFj5YsubQIPz5SWGG
         GiNGELjww7tAB5x9qlKSlidWC2RQdEZW5IZ+r8I8VJsEObt5Phka6/3iutFwRh/yQK
         ZFQ+jTvhVWKAQ==
Date:   Tue, 14 Feb 2023 18:33:29 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, dmitry.baryshkov@linaro.org,
        linmq006@gmail.com, ffclaire1224@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 0/3] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20230214130329.GC4981@thinkpad>
References: <20221013175712.7539-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221013175712.7539-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 at 11:27:09PM +0530, Vidya Sagar wrote:
> This series attempts to fix the issue with core register (Ex:- DBI) accesses
> causing system hang issues in platforms where there is a dependency on the
> availability of PCIe Reference clock from the host for their core
> initialization.
> This series is verified on Tegra194 & Tegra234 platforms.
> 
> Manivannan, could you please verify on qcom platforms?
> 

Vidya, any plan to respin this series? The EPC rework series is now merged for
v6.3.

Thanks,
Mani

> V5:
> * Addressed review comments from Bjorn
> * Changed dw_pcie_ep_init_complete() to dw_pcie_ep_init_late()
> * Skipped memory allocation if done already. This is to avoid freeing and then
>   allocating again during PERST# toggles from the host.
> 
> V4:
> * Addressed review comments from Bjorn and Manivannan
> * Added .ep_init_late() ops
> * Added patches to refactor code in qcom and tegra platforms
> 
> Vidya Sagar (3):
>   PCI: designware-ep: Fix DBI access before core init
>   PCI: qcom-ep: Refactor EP initialization completion
>   PCI: tegra194: Refactor EP initialization completion
> 
>  .../pci/controller/dwc/pcie-designware-ep.c   | 125 +++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  27 ++--
>  drivers/pci/controller/dwc/pcie-tegra194.c    |   4 +-
>  4 files changed, 97 insertions(+), 69 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
