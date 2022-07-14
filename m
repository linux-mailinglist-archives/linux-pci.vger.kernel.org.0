Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCA0574EB8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbiGNNK3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiGNNK1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 09:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8008A3C8C2;
        Thu, 14 Jul 2022 06:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B61E62032;
        Thu, 14 Jul 2022 13:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76882C34114;
        Thu, 14 Jul 2022 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657804225;
        bh=zLp/AR4ZE0g1bNDhIi5HWc7Co5fEvx2EAIPW5r/y1/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYaSDUY7Q+EFv6QVqj6S7nMY1JZGln25rYUefKCE2wHaj2APKXdckenaSG19kvi1b
         h1SB13pSbU1RtrIA2Cn3h7dkBB9dHhZnN+T5yzwJ8ViRUTibsJ6S68Wy49BduMOnkl
         B2LadR3JRmNFQFkKVlBSn6nYTpfegRGCUhu4u+tawUiDd/AOz2CxsFD2D7SHW7HY1L
         mYOLyqcZF/fD6LYtMd9Gk0vJayAxJN9vuJg82YywMdffflEBHBSSQbJ/OyHJP32zO4
         Ays0rindN21Qti++XyY3Ayhl8KAmoEm8VPJWRkkzEynATagP7IDHyXFcoWMOhTubzA
         pQjbMDE4BKhHw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBybt-0007Zh-T9; Thu, 14 Jul 2022 15:10:30 +0200
Date:   Thu, 14 Jul 2022 15:10:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Add support for modular builds
Message-ID: <YtAVxZJZmsxjytNp@hovoldconsulting.com>
References: <20220519094646.23009-1-johan+linaro@kernel.org>
 <cc7c90aa-6705-7493-2f58-5112f7d663a3@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc7c90aa-6705-7493-2f58-5112f7d663a3@mm-sol.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 03:19:49PM +0300, Stanimir Varbanov wrote:
> Hi Johan,
> 
> Please take a look why we made it built-in first [1].
> 
> If arguments there are still valid I don't see why to make it a module
> again.

Yeah, I've seen that patch, and many just like that one by the same
author, and I don't think the arguments spelled out there are valid.

Sure, the Kconfig symbol for this driver was bool at the time so the
remove() code could not have received much testing, but the patch
ignores the fact that preventing drivers to be built as modules is
detrimental to multi-platform builds (e.g. Android GKI).

As I mention in passing below, being able to build a driver as a module
is also really useful during development. Not least to be able to test
power-sequencing and making sure that you're not unknowingly relying on
boot firmware to have set things up for you.

> [1] https://lkml.org/lkml/2016/8/24/694
> 
> On 5/19/22 12:46, Johan Hovold wrote:
> > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > is useful for multi-platform kernels as well as during development.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/Kconfig     |  2 +-
> >  drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
> >  2 files changed, 34 insertions(+), 4 deletions(-)

Johan
