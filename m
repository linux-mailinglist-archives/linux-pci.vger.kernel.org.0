Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548C755F1F0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 01:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiF1Xde (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 19:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiF1Xdd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 19:33:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3C8381BF;
        Tue, 28 Jun 2022 16:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBADDB82107;
        Tue, 28 Jun 2022 23:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234CFC341C8;
        Tue, 28 Jun 2022 23:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656459209;
        bh=Ca/0f6AeREbakoAqy6SPyv4sEMyJApt2trVyEDhvh7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GhWVaEussYZJjtSWH1W7aIJOMPR+X63GYax6aAPv3M8wHUKQfLVvhHo3JTOlKAsl6
         Hf5iD+U1eDp3GTpDthlIK3NW5q36qB15SHrLaSrf98bCKv2XFMLsno/97FE6R2GimZ
         Nq/y9nfy2/HxWnUSK8WmJ0sLjouyFkA0dodmaWwII2ct9GRi6avDCtXKt1H89bffmS
         XzCIlDDjDusDopGVzgVCPFSslcGu2t3D/fvLQgj5hS7DONgBZSLLUuxC3iYQIIpDoa
         L4tmc5+yO3OCLEeAipXJbT2US7rIu44AORO9slWcDrSpPQhs9+sqpVI0SMob6fE7iM
         fh1HVndLvgOlw==
Date:   Tue, 28 Jun 2022 18:33:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 11/18] PCI: dwc: Organize local variables usage
Message-ID: <20220628233327.GA1879296@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143428.8334-12-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:34:21PM +0300, Serge Semin wrote:
> There are several places in the common DW PCIe code with incoherent local
> variables usage: a variable is defined and initialized with a structure
> field, but the structure pointer is de-referenced to access that field
> anyway; the local variable is defined and initialized but either used just
> once or not used afterwards in the main part of the subsequent method.
> It's mainly concerns the pcie_port.dev field. Let's fix that in the
> relevant places.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on the v4 lap of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
>  drivers/pci/controller/dwc/pcie-designware.c      |  8 +++-----
>  2 files changed, 9 insertions(+), 11 deletions(-)

> @@ -633,7 +633,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  		}
>  
>  		if (pci->num_ob_windows <= atu_idx)
> -			dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
> +			dev_warn(dev, "Resources exceed number of ATU entries (%d)\n",

I dropped this hunk because of this:

  drivers/pci/controller/dwc/pcie-designware-host.c:634:13: error: ‘dev’ undeclared (first use in this function); did you mean ‘cdev’?
    634 |    dev_warn(dev, "Resources exceed number of ATU entries (%d)\n",

>  				 pci->num_ob_windows);
>  	}
>  
