Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1D5BB7E5
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 12:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIQKpL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Sep 2022 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIQKpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Sep 2022 06:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B9E28E35;
        Sat, 17 Sep 2022 03:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C777613E9;
        Sat, 17 Sep 2022 10:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19650C433C1;
        Sat, 17 Sep 2022 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663411507;
        bh=fbo6apx3/5y9z8h4zv5NpW0vWKx/Ba2cv7UD5PP7tic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZ7EAXSIN3pXGIvEpuKusxkCKbCML12xjHmSfj6OFPqNcEHGz5BoVxgi8OTGcA7Lh
         hjcoWkOTCslDK7Ygr0jolsgEeoREienl1bcXF8svjlAsz9592ICCWBuTgiIjwzEG7k
         BuV4aizjkw+UaVHKjke73bsJKBUnvwbomaJ4c1xd72W1SI2RbO/91gCplGXBFgwOqE
         psKK8nsGPDHtc0HzXmvt9WLMvwHsNhy/gMmU4jSg2roWP9alLM8OEfOHVAb5Z5Jq5N
         E9/iqjM0SO0nh2ogdrQuV87gvCG6RGR8JNH9MXixQXt9yRE1DCqixl5SOcpESYj2F/
         PjzyaYTcX886Q==
Date:   Sat, 17 Sep 2022 12:44:58 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        willmcvicker@google.com
Subject: Re: [PATCH v5 20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <YyWlKs03F9EhyXxy@lpieralisi>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru>
 <YwzbARMkb/69+l2d@lpieralisi>
 <20220912000211.ct6asuhhmnatje5e@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912000211.ct6asuhhmnatje5e@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 12, 2022 at 03:02:11AM +0300, Serge Semin wrote:

[...]

> I prefer splitting the probe method up into a set of small and
> coherent methods. It IMO improves the code readability for just no
> price since the compiler will embed the single-time used static
> methods anyway.

I will get back to this thread at -rc7 - we will decide a merge
strategy then.

Lorenzo

> -Sergey
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > > +	if (IS_ERR(btpci))
> > > +		return PTR_ERR(btpci);
> > > +
> > > +	return bt1_pcie_add_port(btpci);
> > > +}
> > > +
> > > +static int bt1_pcie_remove(struct platform_device *pdev)
> > > +{
> > > +	struct bt1_pcie *btpci = platform_get_drvdata(pdev);
> > > +
> > > +	bt1_pcie_del_port(btpci);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct of_device_id bt1_pcie_of_match[] = {
> > > +	{ .compatible = "baikal,bt1-pcie" },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, bt1_pcie_of_match);
> > > +
> > > +static struct platform_driver bt1_pcie_driver = {
> > > +	.probe = bt1_pcie_probe,
> > > +	.remove = bt1_pcie_remove,
> > > +	.driver = {
> > > +		.name	= "bt1-pcie",
> > > +		.of_match_table = bt1_pcie_of_match,
> > > +	},
> > > +};
> > > +module_platform_driver(bt1_pcie_driver);
> > > +
> > > +MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
> > > +MODULE_DESCRIPTION("Baikal-T1 PCIe driver");
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.35.1
> > > 
