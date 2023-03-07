Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6876AE479
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCGPVv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 10:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCGPV0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 10:21:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5427D0A7;
        Tue,  7 Mar 2023 07:19:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01AB7B818FF;
        Tue,  7 Mar 2023 15:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D1DC433EF;
        Tue,  7 Mar 2023 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678202330;
        bh=lQZ5rERaQRLgIyK7bi6stqZey4jwiIUgFUF4gu9goyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uX7gx9S3/Fv3Oe5xX8ftkcdY3CRsMQvYdGZKayDbGX/tXTxj/qovMiYjQN1LAXrad
         iUtV94FxViEBP86p27LIkgu7rebVu4T7Cm6d9P8a1XKB4f8BW+GLPzD6D1yQ+EDHIp
         LkjKcDBE9ZDh/Ml4VwVqMAoBMb5zR8sPvMJdayLBaQclOyycxfE7QQxvw6yAYq5vz1
         g+XRJG9M30q2yfmkgbgtyBUZRth62RzDAim7J3P7RqSBgNLLCLdEqqOtjhcdEl0rQS
         YELHzd+VS6ttWo/t5bqXF0z2Hn+llnokTPCOFsw83J7yVj2O0FnikSDWrvQo0zHFFl
         gcq1Ip2dgZfmA==
Date:   Tue, 7 Mar 2023 20:48:39 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        Sergey.Semin@baikalelectronics.ru, dmitry.baryshkov@linaro.org,
        linmq006@gmail.com, ffclaire1224@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 0/3] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20230307151839.GE5599@thinkpad>
References: <20221013175712.7539-1-vidyas@nvidia.com>
 <20230214130329.GC4981@thinkpad>
 <ccc4b7fe-db07-cddb-2d0b-b6a89d7b1155@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccc4b7fe-db07-cddb-2d0b-b6a89d7b1155@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 14, 2023 at 07:27:54PM +0530, Vidya Sagar wrote:
> 
> 
> On 2/14/2023 6:33 PM, Manivannan Sadhasivam wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, Oct 13, 2022 at 11:27:09PM +0530, Vidya Sagar wrote:
> > > This series attempts to fix the issue with core register (Ex:- DBI) accesses
> > > causing system hang issues in platforms where there is a dependency on the
> > > availability of PCIe Reference clock from the host for their core
> > > initialization.
> > > This series is verified on Tegra194 & Tegra234 platforms.
> > > 
> > > Manivannan, could you please verify on qcom platforms?
> > > 
> > 
> > Vidya, any plan to respin this series? The EPC rework series is now merged for
> > v6.3.
> 
> Yes. I'll send an updated series soon.
> Currently, I'm observing some regression with linux-next on Tegra platform
> for endpoint mode. I'll post the patches as soon as that is resolved.
> 

Ping!

Thanks,
Mani

> Thanks,
> Vidya Sagar
> 
> > 
> > Thanks,
> > Mani
> > 
> > > V5:
> > > * Addressed review comments from Bjorn
> > > * Changed dw_pcie_ep_init_complete() to dw_pcie_ep_init_late()
> > > * Skipped memory allocation if done already. This is to avoid freeing and then
> > >    allocating again during PERST# toggles from the host.
> > > 
> > > V4:
> > > * Addressed review comments from Bjorn and Manivannan
> > > * Added .ep_init_late() ops
> > > * Added patches to refactor code in qcom and tegra platforms
> > > 
> > > Vidya Sagar (3):
> > >    PCI: designware-ep: Fix DBI access before core init
> > >    PCI: qcom-ep: Refactor EP initialization completion
> > >    PCI: tegra194: Refactor EP initialization completion
> > > 
> > >   .../pci/controller/dwc/pcie-designware-ep.c   | 125 +++++++++++-------
> > >   drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
> > >   drivers/pci/controller/dwc/pcie-qcom-ep.c     |  27 ++--
> > >   drivers/pci/controller/dwc/pcie-tegra194.c    |   4 +-
> > >   4 files changed, 97 insertions(+), 69 deletions(-)
> > > 
> > > --
> > > 2.17.1
> > > 
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
