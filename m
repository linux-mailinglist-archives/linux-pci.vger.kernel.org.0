Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD077887A4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244886AbjHYMi7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244917AbjHYMi4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 08:38:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82341BE;
        Fri, 25 Aug 2023 05:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E62A61701;
        Fri, 25 Aug 2023 12:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C23C433C9;
        Fri, 25 Aug 2023 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692967133;
        bh=ESvZDqxMeDYukhpCcgd3OK4NJKlTKla20IUfykwwx8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BkHuQBkoksEB2GA3A0V7C2xF+mgzrNQ5tNCLLIQ68fO0vrFIAnG1JDxmS0CT9JsRH
         cX4pgbynbV73wLUSbQfS8m+00sI8voQkQf1gGM6qZ0N9Na0gQZoMzo2o4nFhkOfRz5
         7Ml3CDjD7OBWVeLkJf5fu4BKyALjz8UVPMUTRRwqoBl4ShjqF8tLeR2bko92dfm6l0
         7wO1jf2n0CT+6cfvXGFwy20emQEe21qTEmpmCdDgwjH3RfNO37klYNCLBtOGOqPxaX
         cXx55SGTzsHhYRmGvIe0m9p2MZ6r53ppE7kra1xOz0wSeoD8GLL3K2A91yKZE1/SYG
         4AL7yPab3AVKg==
Date:   Fri, 25 Aug 2023 18:08:43 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, Sergey.Semin@baikalelectronics.ru,
        dmitry.baryshkov@linaro.org, linmq006@gmail.com,
        ffclaire1224@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 0/3] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20230825123843.GD6005@thinkpad>
References: <20221013175712.7539-1-vidyas@nvidia.com>
 <20230214130329.GC4981@thinkpad>
 <ccc4b7fe-db07-cddb-2d0b-b6a89d7b1155@nvidia.com>
 <20230307151839.GE5599@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230307151839.GE5599@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 07, 2023 at 08:48:39PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 14, 2023 at 07:27:54PM +0530, Vidya Sagar wrote:
> > 
> > 
> > On 2/14/2023 6:33 PM, Manivannan Sadhasivam wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On Thu, Oct 13, 2022 at 11:27:09PM +0530, Vidya Sagar wrote:
> > > > This series attempts to fix the issue with core register (Ex:- DBI) accesses
> > > > causing system hang issues in platforms where there is a dependency on the
> > > > availability of PCIe Reference clock from the host for their core
> > > > initialization.
> > > > This series is verified on Tegra194 & Tegra234 platforms.
> > > > 
> > > > Manivannan, could you please verify on qcom platforms?
> > > > 
> > > 
> > > Vidya, any plan to respin this series? The EPC rework series is now merged for
> > > v6.3.
> > 
> > Yes. I'll send an updated series soon.
> > Currently, I'm observing some regression with linux-next on Tegra platform
> > for endpoint mode. I'll post the patches as soon as that is resolved.
> > 
> 
> Ping!
> 

Vidya, are you planning to continue working on this series? If you do not have
time, please let me know.

- Mani

> Thanks,
> Mani
> 
> > Thanks,
> > Vidya Sagar
> > 
> > > 
> > > Thanks,
> > > Mani
> > > 
> > > > V5:
> > > > * Addressed review comments from Bjorn
> > > > * Changed dw_pcie_ep_init_complete() to dw_pcie_ep_init_late()
> > > > * Skipped memory allocation if done already. This is to avoid freeing and then
> > > >    allocating again during PERST# toggles from the host.
> > > > 
> > > > V4:
> > > > * Addressed review comments from Bjorn and Manivannan
> > > > * Added .ep_init_late() ops
> > > > * Added patches to refactor code in qcom and tegra platforms
> > > > 
> > > > Vidya Sagar (3):
> > > >    PCI: designware-ep: Fix DBI access before core init
> > > >    PCI: qcom-ep: Refactor EP initialization completion
> > > >    PCI: tegra194: Refactor EP initialization completion
> > > > 
> > > >   .../pci/controller/dwc/pcie-designware-ep.c   | 125 +++++++++++-------
> > > >   drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
> > > >   drivers/pci/controller/dwc/pcie-qcom-ep.c     |  27 ++--
> > > >   drivers/pci/controller/dwc/pcie-tegra194.c    |   4 +-
> > > >   4 files changed, 97 insertions(+), 69 deletions(-)
> > > > 
> > > > --
> > > > 2.17.1
> > > > 
> > > 
> > > --
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
