Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEF25578DB
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 13:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiFWLkX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 07:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiFWLkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 07:40:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5804BFE1;
        Thu, 23 Jun 2022 04:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 68745CE23ED;
        Thu, 23 Jun 2022 11:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F97C341C6;
        Thu, 23 Jun 2022 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655984418;
        bh=BmxksKeNg58/7CA7uGBVt3ccdcNZ8cDbQtYM5mthy+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNrBbXhUdRoc8jxh1gzVBdU69sEEXI/RDzd2gELfpnSu0aeYibtnMZ/YoONivFso3
         dfTXKuSPQXsvN4Ll249iVNgKfHswv9Lngy3attdXvSYNob+OO3xRbiTcyfoRrXt1ve
         7NKLgM5Kz4ZSxhS0Q9gA46YUO5rN3PNBDPEq2aFm2OJ/IoHgZ1VLVYPMV0Q1FvZntU
         13uM3So3/z0q3VcRFzs2qaZOq9M2XOvYuhTWqV11BdxndwDEKvuvD5jGwCct4aPmsE
         b9sVilA4bsWyBAfQMjfNQlgahdBWSkkwiszQ91J/uQ/Zc2+rFZ6uKIMNvy0Y+m5wnZ
         BEMl/6Qc39t8w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o4LC3-0007nN-C9; Thu, 23 Jun 2022 13:40:16 +0200
Date:   Thu, 23 Jun 2022 13:40:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for modular builds
Message-ID: <YrRRH3SSJPfMEJo2@hovoldconsulting.com>
References: <20220519094646.23009-1-johan+linaro@kernel.org>
 <20220526205304.GK54904-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526205304.GK54904-robh@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 26, 2022 at 03:53:04PM -0500, Rob Herring wrote:
> On Thu, May 19, 2022 at 11:46:46AM +0200, Johan Hovold wrote:
> > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > is useful for multi-platform kernels as well as during development.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/Kconfig     |  2 +-
> >  drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
> >  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Lorenzo, Bjorn H, any comments to this one?

Johan
