Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706935F6117
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJFGfs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 02:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJFGfr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 02:35:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4648A696CB;
        Wed,  5 Oct 2022 23:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 857E0B81EA0;
        Thu,  6 Oct 2022 06:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ED8C433C1;
        Thu,  6 Oct 2022 06:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665038142;
        bh=Wbu3shF6t8LvrsmEHzefRcotejG/Z5j72dNtKsmroMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5FX1N4q/5udncTDUfc/4mBdtA31HRFcl3nAaLaG5eTkT3sepCeaG3sO1Wy9Ta44F
         2fI6eZf1Q9whdgx2zNPqtAeGgkZ8Omt1Fq87LLfQwwVQpO1s7Vg165rG60F+kOsq67
         Om8KcLqf8x6kgR0kIETfR5+SB1DPmYPGiwhcGPn4RRWym+gogHsQKWE6alWRrHKMay
         phdeQcsmCvMDy31GrzjfrEizgBTOYkRRtU/SIpjGvL7NB2ZeGrNm7qC37DVyIochlH
         xwNbH5A6hY0dINpMb+ZPkqOE/BDwAd72tKde3cDfZXBfX/DlLumq+M5O8mOSI89Qrb
         kMmp+VRU2jrYw==
Date:   Thu, 6 Oct 2022 08:35:34 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] PCI: qcom-ep: Fix disabling global_irq in error path
Message-ID: <Yz53NnxEkS7hg8Vc@lpieralisi>
References: <20221005135852.22634-1-manivannan.sadhasivam@linaro.org>
 <20221005173529.GA2304247@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005173529.GA2304247@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 05, 2022 at 12:35:29PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 05, 2022 at 07:28:52PM +0530, Manivannan Sadhasivam wrote:
> > After commit 6a534df3da88 ("PCI: qcom-ep: Disable IRQs during driver
> > remove"), the global irq is stored in the "global_irq" member of pcie_ep
> > structure. This eliminates the need of local "irq" variable but that
> > commit didn't remove the "irq" variable usage completely and it is still
> > used for disable_irq() in error path which is wrong since the variable is
> > uninitialized.
> > 
> > Fix this by removing the local "irq" variable and using
> > "pcie_ep->global_irq" for disable_irq() in error path.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: 6a534df3da88 ("PCI: qcom-ep: Disable IRQs during driver remove")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> For today's "next" branch, I dropped 6a534df3da88 and the subsequent
> patches.  Hopefully Lorenzo can squash this fix into 6a534df3da88.

Done - the pci/qcom branch successfully passed kbot's tests as well.

Lorenzo
