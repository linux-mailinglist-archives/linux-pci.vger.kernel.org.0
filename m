Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9120773C98
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjHHQH5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjHHQGa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5AB30C0;
        Tue,  8 Aug 2023 08:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E9A5625B1;
        Tue,  8 Aug 2023 15:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A60C433C7;
        Tue,  8 Aug 2023 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691507337;
        bh=9Gw7YkUPnAg7btMMMieMmpWn6NAWZtq2U7FvhrT+Ou4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DkRx7ur7t63MQWui1LUaRscobadwh67mmRwqorgioTPiGMkktPMx2DyHiNmCEXc/P
         nDtjAYSiq5ZhYJODACJrzBu0s0Qn4ItNx+eZmherR/eqsd5xCh+Pe4nSRcwjqLvDaz
         fBzo+dQhY2X8HOhT5uwGvhuZx/CotDHr1HG7Pnc1TAqlAC4i68FeziRHWirNQQFXiO
         YzoeHCCzmkkM3H3jnI2yTQDOGnGcrTqsuPXEstnnGhoDQUD0IU/VAPDPoU6kemcFhc
         rWGdXxERVpvkeGXTCev9Y8GGlsbOSb03PGN9UNrgLIudtyrbodQ9gcyx/5Brq6Uief
         hAZkFgmCJU52w==
Date:   Tue, 8 Aug 2023 10:08:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v18 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Message-ID: <20230808150854.GA304435@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rt2vwgmdsxvkb2jh4v6mpnjpfvql44o72nxf663wbnkcvkmift@o2dl5oa435k3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 03:15:33AM +0300, Serge Semin wrote:
> On Mon, Aug 07, 2023 at 06:40:34PM -0500, Bjorn Helgaas wrote:
> > On Tue, Aug 08, 2023 at 01:53:11AM +0300, Serge Semin wrote:
> > > On Tue, Aug 01, 2023 at 01:50:59AM +0000, Yoshihiro Shimoda wrote:
> > > > > From: Serge Semin, Sent: Tuesday, August 1, 2023 8:54 AM
> > > > > On Fri, Jul 21, 2023 at 04:44:40PM +0900, Yoshihiro Shimoda wrote:
> > > > > > To improve code readability, add dw_pcie_link_set_max_link_width().
> > > > > > ...
> > 
> > > > > > @@ -1009,49 +1049,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > > > > >  	val |= PORT_LINK_DLL_LINK_EN;
> > > > > >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > > > > >
> > > > > > -	if (!pci->num_lanes) {
> > > > > > -		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> > > > > > -		return;
> > > > > > -	}
> > > > > > -
> > > > > > -	/* Set the number of lanes */
> > > > > 
> > > > > > -	val &= ~PORT_LINK_FAST_LINK_MODE;
> > > > > 
> > > > > My series contains the patch which drops this line:
> > > > <snip URL>
> > > > > So either pick my patch up and add it to your series or still pick it up
> > > > > but with changing the authorship and adding me under the Suggested-by
> > > > > tag with the email-address I am using to review your series. Bjorn,
> > > > > what approach would you prefer? Perhaps alternative?
> 
> > I don't really see the argument here.  AFAICT, Yoshihiro's patch
> > (https://lore.kernel.org/r/20230721074452.65545-9-yoshihiro.shimoda.uh@renesas.com)
> > is a trivial refactoring to make dw_pcie_link_set_max_link_width(),
> > which might be reused elsewhere later, which seems perfectly fine.
> > 
> > It'd be fine with me to add a little detail in the commit log to
> > reference the Synopsys manual, which I don't have.  But doesn't seem
> > like a big deal to me.
> 
> More details are in one of my earlier comments to this patch which
> Yoshihiro promised to add to the patch log on the next patchset
> revision. You can read it here:
> https://lore.kernel.org/linux-pci/20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com/T/#m8ac364249f40c726da88316b67f11a6d55068ef0
> 
> > Dropping the PORT_LINK_FAST_LINK_MODE mask seems like a separate
> > question that should be in a separate patch.
> > https://lore.kernel.org/linux-pci/20230611192005.25636-6-Sergey.Semin@baikalelectronics.ru/
> > says it's redundant, so it sounds more like a cleanup than a fix.
> 
> That's the point of my comment. There is no need in copying that mask
> to the dw_pcie_link_set_max_link_width() method because first it's
> unrelated to the link-width setting, second it's redundant. There is
> my patch dropping the mask with the proper justification:
> https://lore.kernel.org/linux-pci/20230611192005.25636-6-Sergey.Semin@baikalelectronics.ru/
> It would be good to either merge it in before the Yoshihiro' series or
> add my patch to the Yoshihiro' patchset. But it's in the patchwork
> limbo now, neither you nor Lorenzo or Krzysztof were willing to merge
> it in. That's why I suggested to move the patch here with the denoted
> alterations. Could you give your resolution whether the suggested
> movement is ok or perhaps you or Lorenzo or Krzysztof consider merge
> it in as is?

If I understand Yoshihiro's patch, it pulls code out into
dw_pcie_link_set_max_link_width() without changing that code.  That
seems like the best approach to me because it's very easy to review.

If we want to remove a little redundant code later in a separate
patch, that's fine too but doesn't seem urgent.  I don't think they
need to be tied together.

Bjorn
