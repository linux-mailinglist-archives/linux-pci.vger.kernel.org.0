Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCB7717717
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 08:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjEaGrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 02:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjEaGrD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 02:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571EF194;
        Tue, 30 May 2023 23:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D314460B37;
        Wed, 31 May 2023 06:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666CAC433EF;
        Wed, 31 May 2023 06:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685515616;
        bh=1MgnMGATEiAciGWb2jevqAdqrZ+rOHHPvJ6CZvKEfAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svYRh3ICJHiEhn9GUa8ICEdbzrLkM5RqaXSk6TOfXBQG6Cc4ehQcczWcyJxA2OQGR
         Te5pqFkVo6DUecEGcw0Ex1oaff7AsWbZY633yygJmOnWRVYEQonL/cXkA9Fz+X1OWT
         sJjejD2XXZ88BWIA921iT8abR/1wbbMXlaycKu1pTLTR6E8WR+T5C16GCXw3z408az
         C8wmr4wZrO2KeBytS+ElFT1oCbUYprVSXhzkJJYHvmEmqBZwfttrfypHQLf3AnsCET
         Rv94uSYD1HBp0Z5jkodN6IXR6KEzEB3b8JfEOgAPjSEs971G4hOLP2eqjqV+b/6mpp
         0eX4TK8W85sDg==
Date:   Wed, 31 May 2023 12:16:42 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Owen Yang <ecs.taipeikernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@google.com>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] drivers: pci: quirks: Add suspend fixup for SSD on
 sc7280
Message-ID: <20230531064642.GC7968@thinkpad>
References: <20230525163448.v1.1.Id388e4e2aa48fc56f9cd2d413aabd461ff81d615@changeid>
 <20230529164856.GE5633@thinkpad>
 <ZHZnzqeFbwkGFUud@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHZnzqeFbwkGFUud@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 30, 2023 at 09:17:02PM +0000, Matthias Kaehlcke wrote:
> On Mon, May 29, 2023 at 10:18:56PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, May 25, 2023 at 04:35:12PM +0800, Owen Yang wrote:
> > > Implement this workaround until Qualcomm fixed the
> > >  correct NVMe suspend process.
> > > 
> > > Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> > > ---
> > > 
> > >  drivers/pci/quirks.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index f4e2a88729fd..b57876dc2624 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -5945,6 +5945,16 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
> > >  }
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
> > >  
> > > +/* In Qualcomm 7c gen 3 sc7280 platform. Some of the SSD won't enter
> > > + * the correct ASPM state properly. Therefore. Implement this workaround
> > > + * until Qualcomm fixed the correct NVMe suspend process*/
> > 
> > What is there to fix during suspend? Currently, Qcom PCIe driver just votes for
> > low interconnect bandwidth and keeps the resources (clocks, regulators) ON
> > during suspend. So there is no way the device would move to D3Cold.
> > 
> > Earlier Qcom reported that during suspend, link down event happens when the
> > resources are turned OFF without waiting for the link to enter L1ss. But as I
> > said above, we are _not_ turning OFF any resources.
> 
> Right, it makes little sense that the NVMe would move to D3Cold. And why does
> the issue only reproduces sometimes (with certain NVMes) and not consistently?
> 

Honestly, I don't have any idea why it is happening. The link should transition
to L1ss during suspend and we keep all resources ON.

Did ECS only observe this issue when ASPM is enabled (powersupersave)? If so,
then it is a NVMe firmware issue not Qualcomm.

> > I believe this patch is addressing an issue that is caused by an out-of-tree
> > patch.
> 
> I think ECS observed this with Chrome OS v5.15 kernel. On the PCI side this
> kernel only has backported changes from upstream  (mostly clean picks), no
> downstream patches, so it seems unlikely that the issue is caused by a
> downstream patch.

Okay, thanks for the clarification. Is it possible to reproduce it on mainline?
Just to rule out the upstream vs downstream difference elsewhere.

That should also be the case to submit a patch against mainline.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
