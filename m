Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB7A66AF56
	for <lists+linux-pci@lfdr.de>; Sun, 15 Jan 2023 05:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjAOE1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Jan 2023 23:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjAOE1Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jan 2023 23:27:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A124C07;
        Sat, 14 Jan 2023 20:27:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8B09B80B26;
        Sun, 15 Jan 2023 04:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A70CC433D2;
        Sun, 15 Jan 2023 04:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673756840;
        bh=Q6nvido5P/2RRcXrr9kefDThXtXDCMRRSPwMe2E5gQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4fZhdaY6P3r8LFAoCHD0onu/5rpaE/XYCRk5E1Vi5cpe2AF6W8aeEDBEl7bDHCsM
         Cei6jt+r7b+DaG/4rl505KrD/FKG9Br7d9L7cfAbqZDcy3YCksyBp5PjHnMpLlgvCF
         B0yFS3F26xIs2ASLQ+r2S1eKbL/ufjkB8cObV0O7Mou06Vuf01r4Ajdg+tNQz6IPGA
         fZOEZ1Csm5X3btOcGT3quUgXDlKZw28UufUzRBV4OMyR91yh4lXPyoGcmw6C69TqBk
         uD9a5aWaOHABJ9ouFQdtGjuGuHjpGuRPYVsexuH3Mw7le+QYlJD4VOBo69jC9QINzN
         ae0/D3gDhhOGg==
Date:   Sun, 15 Jan 2023 09:57:12 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: qcom: Add support for modular builds
Message-ID: <20230115042712.GI6568@thinkpad>
References: <20221017114705.8277-1-johan+linaro@kernel.org>
 <Y8F98UTZNgQpX6UG@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8F98UTZNgQpX6UG@lpieralisi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 04:51:13PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Oct 17, 2022 at 01:47:03PM +0200, Johan Hovold wrote:
> > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > is useful for multi-platform kernels as well as during development.
> > 
> > There's no rush with this, but I figured I'd send an updated version
> > that has been rebased on 6.1-rc1 (where post_deinit() has been removed).
> > 
> > I also broke out the qcom_pcie_host_deinit() handler in a separate patch
> > as the host_deinit() callback has now been added to dwc core and can be
> > used to fixes some late-probe error handling.
> 
> Waiting for the dust to settle on patch 2, does it make sense to
> merge patch 1 on its own ?
> 

Yeah, that makes sense.

Thanks,
Mani

> Thanks,
> Lorenzo
> 
> > Johan
> > 
> > 
> > Changes in v3
> >  - rebase on 6.1-rc1 where post_deinit() has been removed
> >  - split out host-init error handling
> >  - add Stan's ack
> > 
> > Changes in v2
> >  - rebase on next-20220720 (adjust context)
> >  - add Rob and Mani's reviewed-by tags
> > 
> > 
> > Johan Hovold (2):
> >   PCI: qcom: Fix host-init error handling
> >   PCI: qcom: Add support for modular builds
> > 
> >  drivers/pci/controller/dwc/Kconfig     |  2 +-
> >  drivers/pci/controller/dwc/pcie-qcom.c | 39 +++++++++++++++++++++++---
> >  2 files changed, 36 insertions(+), 5 deletions(-)
> > 
> > -- 
> > 2.37.3
> > 

-- 
மணிவண்ணன் சதாசிவம்
