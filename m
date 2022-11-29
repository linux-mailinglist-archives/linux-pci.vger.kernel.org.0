Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E95D63C73F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 19:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiK2Sfs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 13:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbiK2Sfr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 13:35:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424C04B982;
        Tue, 29 Nov 2022 10:35:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9D03B817C0;
        Tue, 29 Nov 2022 18:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651B3C433B5;
        Tue, 29 Nov 2022 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669746944;
        bh=fbQH4j08U1ful5CJFqNWUrgI0E0LWc7WjkdOchpGdgM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vDqzkdJbrOmenpuFzaWfjlmsDjJTMleGqzEcYW5cYhJg00PQwOuHwyOhijfE/MeeN
         wV+7mkJwwEYHTHcofg6H6WFnTdGogKE8cORv1Ge0LAAno7/r+j4cdU2V675ZSa4iFx
         YLqE2/iKpo0GK6bRNs8uXFOdcoLQXoBN20BwqGG+8C1oBCzrTxLItE+XF1QUIHoiEP
         2lqb0AQTSEi/OkK5d8CBC29jtNUpvdqhkLasStquq970/d3AamhOw8U05vm1Jg738C
         Z/Qvna6Hh3O7LGySyH/ukLRy7Q1HhAqcX7EKXkL2wGyVr6YeeF/mDaIK8f4KkeAjEg
         BTplrl5OuxQyw==
Date:   Tue, 29 Nov 2022 12:35:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 17/20] PCI: dwc: Introduce generic resources getter
Message-ID: <20221129183543.GA729294@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127011005.cjzcd6slb6ezy7ix@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 27, 2022 at 04:10:05AM +0300, Serge Semin wrote:
> On Wed, Nov 23, 2022 at 01:44:36PM -0600, Bjorn Helgaas wrote:
> > On Sun, Nov 13, 2022 at 10:12:58PM +0300, Serge Semin wrote:

> > Thanks for these new generic interfaces in the DWC core!  And thanks
> > for the changes in this patch to take advantage of them in the
> > pcie-designware drivers.
> > 
> > Do you plan similar changes to other drivers to take advantage of
> > these DWC-generic data and interfaces?  If you add generic things to
> > the DWC core but only take advantage of them in your driver, I don't
> > think they are really usefully generic.
> 
> Could you be more specific what generic things you are referring to? I
> am asking because the only part of the changes which is used in my
> low-level driver only is introduced in another patch of this series.

I asked because three of your patches mention "generic" things, but I
didn't see any changes to drivers except pcie-designware:

  PCI: dwc: Introduce generic platform clocks and reset
  PCI: dwc: Introduce generic resources getter
  PCI: dwc: Introduce generic controller capabilities interface

I hoped that we would be able to use these to remove some code from
existing drivers, but if they only improve maintainability of future
drivers, that's useful, too.

Bjorn
