Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFC654BAB9
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 21:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245594AbiFNTmH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 15:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbiFNTmG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 15:42:06 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93442899E;
        Tue, 14 Jun 2022 12:42:04 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id p128so10530393iof.1;
        Tue, 14 Jun 2022 12:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2jLRHj6azgOympWSUCJ+nKb7b1xZ7biLjgEasSl3aCI=;
        b=yVpBlXyTts4+Xy+IhhMLVMKDNYDzZUotfWk5dbjL/1WMaMRlYzsodPIBoYFF/gWJXU
         IrYT9oUKZkMxKPcRHsoRyulIMnb10DO8x3j1EAIvm3CeHLR5gHnxnQxnAGKbqeuQmuLc
         VHEhcvyxH6mLhT9WxDdM4B9CCgTda0Tpm2BKfeW89k3mc78/zIaNPj7QkH23EKYKH1+R
         ydvHsfALaKMw2tFIXGIdRYOUVrMlMawYNROBgrjCYDaYQEN2XxZcVuLFTXKkThc29+Ui
         DNVp2u2AmL6PutYnTPhfisAPk0cFKjNq/0kWzPVW5Y7J8yzQRx/ex7xWxuiJJ1zRURsf
         w3CA==
X-Gm-Message-State: AOAM530vbPA/PItvocLBP+u97LPr+kQ9K9unhA6pbMzBMLHhLOWO4Rp+
        STb/8dCkyAqVDZdiQZlGEw==
X-Google-Smtp-Source: ABdhPJz0AU7sUgMn5H2uebJW9hSTaCZaCz+pm4D6P6oSsm4HKOCKTgvByJQXqwASGo5hoNITZfJWQg==
X-Received: by 2002:a05:6638:1691:b0:333:f345:ef6c with SMTP id f17-20020a056638169100b00333f345ef6cmr3689545jat.7.1655235724134;
        Tue, 14 Jun 2022 12:42:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b13-20020a02380d000000b0033167715cf9sm5204583jaa.27.2022.06.14.12.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:42:03 -0700 (PDT)
Received: (nullmailer pid 2275774 invoked by uid 1000);
        Tue, 14 Jun 2022 19:42:02 -0000
Date:   Tue, 14 Jun 2022 13:42:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 4/7] PCI: renesas: Add R-Car Gen4 PCIe Endpoint support
Message-ID: <20220614194202.GA2209956-robh@kernel.org>
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com>
 <20220613115712.2831386-5-yoshihiro.shimoda.uh@renesas.com>
 <20220613215043.GB87830-robh@kernel.org>
 <TYBPR01MB5341FFE04E29E43772683A90D8AA9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341FFE04E29E43772683A90D8AA9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 14, 2022 at 11:58:46AM +0000, Yoshihiro Shimoda wrote:
> Hi Rob,
> 
> Thank you for your review!
> 
> > From: Rob Herring, Sent: Tuesday, June 14, 2022 6:51 AM
> > 
> > On Mon, Jun 13, 2022 at 08:57:09PM +0900, Yoshihiro Shimoda wrote:
> > > Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> > > Synopsys Designware PCIe.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---

[...]

> > > +	u32			num_lanes;
> > 
> > What's wrong with dw_pcie.num_lanes?
> 
> The dw_pcie.num_lanes is set after dw_pcie_ep_init() succeeded.
> However, this driver would like to refer the num_lanes before dw_pcie_ep_init()
> to initialize vendor-specific registers. In other words, this value is only
> needed at that timing. So, we can remove this from struct rcar_gen4_pcie_ep,
> and just get the num_lanes as a local variable.

AFAICT, you are just using it to set PCI_EXP_LNKCAP_MLW. That's a common 
register, so it should be able to set in the common code.


[...]

> > > +static struct platform_driver rcar_gen4_pcie_ep_driver = {
> > > +	.driver = {
> > > +		.name = "pcie-rcar-gen4-ep",
> > > +		.of_match_table = rcar_gen4_pcie_of_match,
> > > +	},
> > > +	.probe = rcar_gen4_pcie_ep_probe,
> > > +	.remove = rcar_gen4_pcie_ep_remove,
> > > +};
> > > +builtin_platform_driver(rcar_gen4_pcie_ep_driver);
> > 
> > Not a module or...
> > 
> > > +
> > > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe endpoint controller driver");
> > > +MODULE_LICENSE("GPL v2");
> > 
> > A module? Should be a module if possible.
> 
> Oops. I'll drop these MODULE_*.

No, is there some reason it can't be a module?

Rob

