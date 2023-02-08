Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF6768FA3A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 23:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjBHWXZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 17:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjBHWXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 17:23:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B017C298DB;
        Wed,  8 Feb 2023 14:23:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF92AB81F37;
        Wed,  8 Feb 2023 22:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A47AC433EF;
        Wed,  8 Feb 2023 22:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675894993;
        bh=OTzvcsJ+7/dblWvZKx0OO7rGkqobHrEhsSkHSFYQUeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CMTCSn9NLVq9SnuioEIW7nld5dGU6EYQNsWBNgVqAcaZUyloxU9EVuP/Qa0o13pkd
         B0XADOrQhPnRuX4Z//DGHrmcFUi/vVP7jaYx8B955g5Msag8gEW4BHWadctTjX/hjm
         WHvbflnndg9xNZ5rdvGPA8/ASkuUaHeSCg1e0vtBgxD6flaqaFsRo9MUlP+beKnBWh
         5c0wAxIqskNsY5dG/JDG2403gwPoYcxEE0Q9c+KFfioJoKd9L6taQI/B/D6WUJQfrH
         Gu1FQucseaD95r4B9oV7zzaSk4YWesnlDDw8jtBsMH/EGnANaC5b6GqN9Tze/BhVsl
         ZPuoGRGsF9QNQ==
Date:   Wed, 8 Feb 2023 16:23:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     ALOK TIWARI <alok.a.tiwari@oracle.com>,
        "M.H. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [External] : RE: [EXT] [PATCH v2 1/1] PCI: layerscape: Add EP
 mode support for ls1028a
Message-ID: <20230208222311.GA2490083@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0401MB2331634B29ED9EDAB032B73888DB9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 07, 2023 at 04:20:21PM +0000, Frank Li wrote:
> > Subject: Re: [External] : RE: [EXT] [PATCH v2 1/1] PCI: layerscape: Add EP
> > mode support for ls1028a
> > 
> >          { .compatible = "fsl,ls1046a-pcie-ep", .data = &ls1_ep_drvdata },
> > +       { .compatible = "fsl,ls1028a-pcie-ep", .data = &ls1_ep_drvdata },
> >         { .compatible = "fsl,ls1088a-pcie-ep", .data = &ls2_ep_drvdata },
> > 
> > can it be like this for better readability. ?
> 
> It is just chip name and follow name conversion, which already
> upstreamed and documented. 
>
> Why do you think it not is good readability? 

I thought maybe ALOK's point was to sort the list, which does make a
lot of sense.  But if you want to sort by the .data member, I would
think you would make .compatible a secondary sort key, which means
ls1028a would come before ls1046a, so you would end up with this
instead:

 static const struct of_device_id ls_pcie_ep_of_match[] = {
+       { .compatible = "fsl,ls1028a-pcie-ep", .data = &ls1_ep_drvdata },
        { .compatible = "fsl,ls1046a-pcie-ep", .data = &ls1_ep_drvdata },
        { .compatible = "fsl,ls1088a-pcie-ep", .data = &ls2_ep_drvdata },
        { .compatible = "fsl,ls2088a-pcie-ep", .data = &ls2_ep_drvdata },
        { .compatible = "fsl,lx2160ar2-pcie-ep", .data = &lx2_ep_drvdata },
        { },
 };

