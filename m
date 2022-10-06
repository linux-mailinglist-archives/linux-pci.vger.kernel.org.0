Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E225F6B3A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiJFQHr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 12:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJFQHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 12:07:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA005FAEC;
        Thu,  6 Oct 2022 09:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAD2CB8060E;
        Thu,  6 Oct 2022 16:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E13C433C1;
        Thu,  6 Oct 2022 16:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665072462;
        bh=UgBb/TSUw7my6TY7l4G4qUWrT35p6b5DxWO5v2EXFUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bYRc9gY+RnaW3M+UVdNEDmoLAugBYy8K2qX0kpXPGQkv9N5tbL79ptUNR2mMT7szw
         QoVJUwxd885mPZ0VCF0KSbvDiSAs6BvjXT6jz9eyJSCygFvb7QlYVplbUs8/Q+Cjyr
         NuzuGZQN4iAn767Bn1IgR2AWGtPIq3PotbEN6AgX90ns466dTjErLVIxPjZVirBNU4
         l8WwEykmpRY0G9lwblaUww19ZUdVoLT4wvn+SUhVhm/JGRBFkhZJUD0EcllR5cgYJ7
         7edK6mnfNSGxnnhFSpD3c+6yc3NiePbLikMhys4hB+n7EE8T5j4lG7yK0ErHWO3I/X
         702ZHcrx8fTRQ==
Date:   Thu, 6 Oct 2022 11:07:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] PCI: qcom-ep: Fix disabling global_irq in error path
Message-ID: <20221006160741.GA2470032@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz53NnxEkS7hg8Vc@lpieralisi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 06, 2022 at 08:35:34AM +0200, Lorenzo Pieralisi wrote:
> On Wed, Oct 05, 2022 at 12:35:29PM -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 05, 2022 at 07:28:52PM +0530, Manivannan Sadhasivam wrote:
> > > After commit 6a534df3da88 ("PCI: qcom-ep: Disable IRQs during driver
> > > remove"), the global irq is stored in the "global_irq" member of pcie_ep
> > > structure. This eliminates the need of local "irq" variable but that
> > > commit didn't remove the "irq" variable usage completely and it is still
> > > used for disable_irq() in error path which is wrong since the variable is
> > > uninitialized.
> > > 
> > > Fix this by removing the local "irq" variable and using
> > > "pcie_ep->global_irq" for disable_irq() in error path.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Fixes: 6a534df3da88 ("PCI: qcom-ep: Disable IRQs during driver remove")
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > For today's "next" branch, I dropped 6a534df3da88 and the subsequent
> > patches.  Hopefully Lorenzo can squash this fix into 6a534df3da88.
> 
> Done - the pci/qcom branch successfully passed kbot's tests as well.

Thanks, picked this up yesterday :)

Bjorn
