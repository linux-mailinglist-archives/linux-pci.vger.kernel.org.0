Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF0064F0E8
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 19:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiLPSZe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 13:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiLPSZd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 13:25:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430A553EF8;
        Fri, 16 Dec 2022 10:25:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E20C6B81DD8;
        Fri, 16 Dec 2022 18:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF4EC433D2;
        Fri, 16 Dec 2022 18:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671215126;
        bh=4XtEoEvMYyg+OLEZfHG9djBuFTM7o2ZQCFES+gxEroE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aD2KCvdg3kKv09BaCnVXMz09pfqHt+WN5mHE937fM/UB7lIsiumYRFq2gH3p2ubL0
         b+v9L0fuJZyXwbcykzfXKi1zWwno00rdfpGtd8WLU+TTNfE3LdHP9FredI46xwgi03
         kx1euGydfduw0D5ttm419X9ds07l5WaKr4vD5OaRGW/+5PeSIVWexnE0Zu7PjcOMR6
         88sF0++26Ul5MhBADAKPp/gstCMHmfrirVYMMelP8ecI4/BiYSBW60rE6wV9L1WQrs
         YayESk9QhiMXchYskO9jbZ4GHhk2HKLfMpH+CI3tBm2b52fBYX6psvP4Ko6ej2N9x8
         3+pL0cOPNLbWg==
Received: by pali.im (Postfix)
        id 22897711; Fri, 16 Dec 2022 19:25:24 +0100 (CET)
Date:   Fri, 16 Dec 2022 19:25:24 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] PCI: aardvark: switch to using
 devm_gpiod_get_optional()
Message-ID: <20221216182524.s6a4uihgavji7bti@pali>
References: <Y3KMEZFv6dpxA+Gv@google.com>
 <20221207143351.GA1439513@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207143351.GA1439513@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 07 December 2022 08:33:51 Bjorn Helgaas wrote:
> On Mon, Nov 14, 2022 at 10:42:25AM -0800, Dmitry Torokhov wrote:
> > Switch the driver to the generic version of gpiod API (and away from
> > OF-specific variant), so that we can stop exporting
> > devm_gpiod_get_from_of_node().
> > 
> > Acked-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> This is unrelated to other pending aardvark changes and will help
> unblock the API removal, so I applied this to pci/ctrl/aardvark for
> v6.2, thanks!

I'm disappointed that such unimportant change is prioritized and taken
before any other important changes which are fixing real issue and
waiting for applying about half of year.

> > ---
> > 
> > v2:
> >  - collected reviewed-by/acked-by tags
> >  - updated commit description to remove incorrect assumption of why
> >    devm_gpiod_get_from_of_node() was used in the first place
> > 
> > This is the last user of devm_gpiod_get_from_of_node() in the mainline
> > (next), it would be great to have it in so that we can remove the API in
> > the next release cycle.
> > 
> > Thanks!
> > 
> > 
> >  drivers/pci/controller/pci-aardvark.c | 23 +++++++++++------------
> >  1 file changed, 11 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index ba36bbc5897d..5ecfac23c9fc 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -1859,20 +1859,19 @@ static int advk_pcie_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > -	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
> > -						       "reset-gpios", 0,
> > -						       GPIOD_OUT_LOW,
> > -						       "pcie1-reset");
> > +	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> >  	ret = PTR_ERR_OR_ZERO(pcie->reset_gpio);
> >  	if (ret) {
> > -		if (ret == -ENOENT) {
> > -			pcie->reset_gpio = NULL;
> > -		} else {
> > -			if (ret != -EPROBE_DEFER)
> > -				dev_err(dev, "Failed to get reset-gpio: %i\n",
> > -					ret);
> > -			return ret;
> > -		}
> > +		if (ret != -EPROBE_DEFER)
> > +			dev_err(dev, "Failed to get reset-gpio: %i\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = gpiod_set_consumer_name(pcie->reset_gpio, "pcie1-reset");
> > +	if (ret) {
> > +		dev_err(dev, "Failed to set reset gpio name: %d\n", ret);
> > +		return ret;
> >  	}
> >  
> >  	ret = of_pci_get_max_link_speed(dev->of_node);
> > -- 
> > 2.38.1.431.g37b22c650d-goog
> > 
> > 
> > -- 
> > Dmitry
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
