Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D745E60E0B4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 14:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiJZMdn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 08:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiJZMdm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 08:33:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9514073936;
        Wed, 26 Oct 2022 05:33:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56B00B8212F;
        Wed, 26 Oct 2022 12:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D92C433C1;
        Wed, 26 Oct 2022 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666787619;
        bh=1oQIC/cEy+BOnB6qVZCAUuyMhZUjMaoO2CL7d79n42k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkhUuZ4R24oHo5gcthD/4oPGb+VW8T8sm1LSjL0hHEzT9Bb/3OGFs7KrTYXf/o44O
         WQnOxrRYa9CK5XmryT2epofDD3UX1XH5KcB8wyoWNN7HmP2wtvbjoPXrAE7K8dHAVp
         IXEqBid+aksXgIJfJ7rUnq6QUw5JhIpuKj446uAPtnL1mktK9UognPJDBe9T7rkJ/A
         ysQaowqW9Xh5YaqXgYdF3p7Dtm2AByLJaOhH5CtpmOyVeDW/mSoX0nmoPyE3isAGSp
         dzEBGKMNiS0nNhIyLCw1uSSn36DodrC06ESR0XHRbydkqNFRsXLRRX6xqQFDUo4DwP
         JcQolSq6ACWOQ==
Date:   Wed, 26 Oct 2022 14:33:31 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <Y1kpG0l05uMueM9Y@lpieralisi>
References: <20221018164329.GA3808783@bhelgaas>
 <8670e757-7275-57eb-3f5c-0a21ba354e37@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8670e757-7275-57eb-3f5c-0a21ba354e37@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 26, 2022 at 12:39:13PM +0100, Jon Hunter wrote:
> Hi Lorenzo,
> 
> On 18/10/2022 17:43, Bjorn Helgaas wrote:
> > On Tue, Oct 18, 2022 at 07:21:54AM +0100, Jon Hunter wrote:
> > > Hi Bjorn,
> > > 
> > > On 13/09/2022 11:12, Vidya Sagar wrote:
> > > > Some of the platforms (like Tegra194 and Tegra234) have open slots and
> > > > not having an endpoint connected to the slot is not an error.
> > > > So, changing the macro from dev_err to dev_info to log the event.
> > > > 
> > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > ---
> > > >    drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 650a7f22f9d0..25154555aa7a 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -456,7 +456,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > >    	}
> > > >    	if (retries >= LINK_WAIT_MAX_RETRIES) {
> > > > -		dev_err(pci->dev, "Phy link never came up\n");
> > > > +		dev_info(pci->dev, "Phy link never came up\n");
> > > >    		return -ETIMEDOUT;
> > > >    	}
> > > 
> > > 
> > > Are you OK to take this change?
> > 
> > When this came up, Lorenzo was in the middle of a big move and I was
> > covering for him while he was unavailable.  But he's back, and I'm
> > sure he will resolve this soon.
> > 
> > Personally I'm OK either way.
> > 
> > Bjorn
> 
> 
> Can we come to a conclusion on this?
> 
> We have tests that fail when errors/warning messages are reported. We can
> choose to ignore these errors, but given that this is not an error in this
> case, we were thinking it is better to make it informational.

I understood.

We are at v6.1-rc2, this patch is not a fix, we will handle it for the
v6.2 merge window.

Thanks,
Lorenzo
