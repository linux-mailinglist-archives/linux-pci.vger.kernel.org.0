Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8C9554DEF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 16:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349994AbiFVOw2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 10:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiFVOw1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 10:52:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AB03DDE2;
        Wed, 22 Jun 2022 07:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AD9FB81F54;
        Wed, 22 Jun 2022 14:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D61C34114;
        Wed, 22 Jun 2022 14:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655909543;
        bh=uEQT3cFgGFRDHzj662KuPlWgg7A+Oe4RWTTdqfcTCi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7a+0gR+B3chebFU3urXcg713v/4XalaUaBAEym+qyDR0r/V12O/xsCEiRBbqseSf
         zaHuRVN2+wOheNlByC56feBzGNny/P0lb1mtpp1AoTWsKAEfrgKIvlHgerQWu7btMv
         kPDAgz3ILXp9qA/Ovby5YpBDcWtvY5GimAd8grs9mQim/SR/ByKjuiCgDKs8feB7+m
         3z6+ImYuIwIjWx+NpD9z/stKgj/cz4GGYfrUth8md3/sNMjOmleGdUZ19KYmTTjomH
         NdZ08g9qcHhkgxJaYzC8EjiSjqVbrxfp/7ToyGPJGlI+mxRlfT605COWQqqFNhE4Dp
         Qs9dov19gQ2+w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o41iO-00074m-Js; Wed, 22 Jun 2022 16:52:20 +0200
Date:   Wed, 22 Jun 2022 16:52:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, svarbanov@mm-sol.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, p.zabel@pengutronix.de, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH v2] PCI: qcom: fix IPQ8074 Gen2 support
Message-ID: <YrMspGTROJUFYQrN@hovoldconsulting.com>
References: <20220621112330.448754-1-robimarko@gmail.com>
 <20220621203211.GA1330530@bhelgaas>
 <YrK7b1GaEMuANGtR@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrK7b1GaEMuANGtR@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 22, 2022 at 08:49:19AM +0200, Johan Hovold wrote:
> On Tue, Jun 21, 2022 at 03:32:11PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jun 21, 2022 at 01:23:30PM +0200, Robert Marko wrote:
> > > IPQ8074 has one Gen2 and one Gen3 port, currently the Gen2 port will
> > > cause the system to hang as its using DBI registers in the .init
> > > and those are only accesible after phy_power_on().
> > 
> > Is the fact that IPQ8074 has both a Gen2 and a Gen3 port relevant to
> > this patch?  I don't see the connection.
> > 
> > I see that qcom_pcie_host_init() does:
> > 
> >   qcom_pcie_host_init
> >     pcie->cfg->ops->init(pcie)
> >     phy_power_on(pcie->phy)
> >     pcie->cfg->ops->post_init(pcie)
> > 
> > and that you're moving DBI register accesses from
> > qcom_pcie_init_2_3_3() to qcom_pcie_post_init_2_3_3().
> > 
> > But I also see DBI register accesses in other .init() functions:
> > 
> >   qcom_pcie_init_2_1_0
> >   qcom_pcie_init_1_0_0      (oddly out of order)
> >   qcom_pcie_init_2_3_2
> >   qcom_pcie_init_2_4_0
> > 
> > Why do these accesses not need to be moved?  I assume it's because
> > pcie->phy is an optional PHY and phy_power_on() does nothing on those
> > controllers?
> 
> At least the QMP PHY driver does not implement the PHY power_on op and
> instead fires everything up already at phy_init(). That may explain the
> difference in behaviour here.

That was due to a bug in -next which as since been fixed by commit

	5bef2838f1a0 ("phy: qcom-qmp: fix PCIe PHY support")

which again do all PHY init at phy_power_on() instead of at phy_init().

Note also that before commit cc1e06f033af ("phy: qcom: qmp: Use
power_on/off ops for PCIe") everything was done at init.

Johan
