Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D1F6030E7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Oct 2022 18:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJRQne (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Oct 2022 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRQnd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2022 12:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F354FE8C4B;
        Tue, 18 Oct 2022 09:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E5D861629;
        Tue, 18 Oct 2022 16:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57764C433D6;
        Tue, 18 Oct 2022 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666111411;
        bh=onIU6UaIPDJ4ITtA1n47wYHHewH84Cps093KvcKCmBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Wue3uBJfAC7a8RK23LasuJUGRQOwuSjdf19eLT0uRUPqsxK/bWH2wrpLTwDRqjx2F
         obRE16jOOkQCH9NUnA6AfGo2yucGITh/ej0VZQSvspQAHTHpurUwChpfQCY8vDFysu
         W6F0X3mdbkVzm/ISijLvlYAnRJIUkpPig6cA6fVL27drqt4Upro4IboikOZ7koUn3l
         DYv6OvDWcSoIVaTFb1oyqyFKbRtmMpH8fQxz3PTm1KIfFFLHBfrsG5gXk7HrIjO9x4
         Fr8kd6KvweaoccceVxr4u/eDMXPxpAibqQSFCAAwSfVYTkxgO7VpM0xJaPxnoyT0vN
         3QmEqzx8/hYhQ==
Date:   Tue, 18 Oct 2022 11:43:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <20221018164329.GA3808783@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49834f69-0e6c-70a6-ef70-5563fb5e9215@nvidia.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 18, 2022 at 07:21:54AM +0100, Jon Hunter wrote:
> Hi Bjorn,
> 
> On 13/09/2022 11:12, Vidya Sagar wrote:
> > Some of the platforms (like Tegra194 and Tegra234) have open slots and
> > not having an endpoint connected to the slot is not an error.
> > So, changing the macro from dev_err to dev_info to log the event.
> > 
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 650a7f22f9d0..25154555aa7a 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -456,7 +456,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >   	}
> >   	if (retries >= LINK_WAIT_MAX_RETRIES) {
> > -		dev_err(pci->dev, "Phy link never came up\n");
> > +		dev_info(pci->dev, "Phy link never came up\n");
> >   		return -ETIMEDOUT;
> >   	}
> 
> 
> Are you OK to take this change?

When this came up, Lorenzo was in the middle of a big move and I was
covering for him while he was unavailable.  But he's back, and I'm
sure he will resolve this soon.

Personally I'm OK either way.

Bjorn
