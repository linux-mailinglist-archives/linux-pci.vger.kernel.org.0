Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622D2523A80
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbiEKQlf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 12:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344888AbiEKQld (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 12:41:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E97746B1E;
        Wed, 11 May 2022 09:41:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C4AAED1;
        Wed, 11 May 2022 09:41:31 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 682E63F73D;
        Wed, 11 May 2022 09:41:29 -0700 (PDT)
Date:   Wed, 11 May 2022 17:41:25 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Saravana Kannan <saravanak@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/2] PCI: dra7xx: Fix link removal on probe error
Message-ID: <YnvnNUrsCOUxMu8A@lpieralisi>
References: <20211214221450.589884-1-luca@lucaceresoli.net>
 <CAL_Jsq+GQTcx1EGKHug2ZcDZufrKM-4k6PB0vQeTCTG42MHzvA@mail.gmail.com>
 <59a23c89-0810-eb28-acd9-7051ac34d438@lucaceresoli.net>
 <4579940c-27dc-733e-4022-ebea4671c839@lucaceresoli.net>
 <CAL_JsqJ5nr6xJoTv3A6UPMMDXhWKcwSEUA3ux3kK8OMWQxdc6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ5nr6xJoTv3A6UPMMDXhWKcwSEUA3ux3kK8OMWQxdc6w@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 15, 2022 at 10:02:00AM -0600, Rob Herring wrote:
> +Saravana
> 
> On Tue, Jan 11, 2022 at 4:35 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
> >
> > Hi Rob,
> >
> > On 16/12/21 10:08, Luca Ceresoli wrote:
> > > Hi Rob,
> > >
> > > thanks for the quick feedback!
> > >
> > > On 14/12/21 23:42, Rob Herring wrote:
> > >> On Tue, Dec 14, 2021 at 4:15 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
> > >>>
> > >>> If a devm_phy_get() calls fails with phy_count==N (N > 0), then N links
> > >>> have already been added by device_link_add() and won't be deleted by
> > >>> device_link_del() because the code calls 'return' and not 'goto err_link'.
> > >>>
> > >>> Fix in a very simple way by doing all the devm_phy_get() calls before all
> > >>> the device_link_add() calls.
> > >>>
> > >>> Fixes: 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
> > >>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> > >>> ---
> > >>>  drivers/pci/controller/dwc/pci-dra7xx.c | 2 ++
> > >>>  1 file changed, 2 insertions(+)
> > >>>
> > >>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> > >>> index f7f1490e7beb..2ccc53869e13 100644
> > >>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> > >>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> > >>> @@ -757,7 +757,9 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
> > >>>                 phy[i] = devm_phy_get(dev, name);
> > >>>                 if (IS_ERR(phy[i]))
> > >>>                         return PTR_ERR(phy[i]);
> > >>> +       }
> > >>>
> > >>> +       for (i = 0; i < phy_count; i++) {
> > >>>                 link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> > >>
> > >> I think this should happen automatically now with fw_devlink being
> > >> enabled by default. Can you try?
> > >
> > > Do you mean removal should be done automatically? I think they are not
> > > due to the DL_FLAG_STATELESS flag.
> >
> > I would love to have feedback because, as said, I think my patch is
> > correct, but if I'm wrong (which might well be) I have to drop patch 1
> > and rewrite patch 2 in a slightly more complex form.
> 
> I mean that why do you need explicit dependency tracking here when
> dependencies on a PHY should happen automatically now. IOW, what is
> special about this driver and dependency?

Any update on this patch ? I think patch 2 can be merged, please
let me know if this one can be dropped.

Thanks,
Lorenzo
