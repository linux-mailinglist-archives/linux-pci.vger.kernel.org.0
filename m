Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADBD516DFE
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 12:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384385AbiEBKRw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 06:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384417AbiEBKRt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 06:17:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E9E23C;
        Mon,  2 May 2022 03:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5B2C61238;
        Mon,  2 May 2022 10:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D33C385A4;
        Mon,  2 May 2022 10:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651486460;
        bh=Ytg1tQ2oxulHa1Lh+RCOt+LqpTtcT9uXRgZ8Buq1CMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpmIMQ5eVc/hxV+PCQoHr4To19kotvQqy9Sf6WUumVcluu9KbVh3VRMBFCaHVM663
         Mit0v4iFrBvDWm4shFNDiy+QcSMDPdBnDRoZ4DBk5lsjjTlj1dNNIatlEf8VS5zhlI
         YIGGySaDOmEuQm7nK+cMqMdvif2aE6UIRQ7/xFshx9c0Z/2Qj39lHfdQsqGEGOqJuH
         E9EZuzGjTtNUexiZshZX2Qts/VrP0/zJ6Ppdl7Nfi+CfTRJvyAhNA4U1uJv7Zthnqm
         wt4qraGinyDsAOBvCWUaW3pRapIkfWLTDyFTXx0BLhoNjLZ6078GvB2b476D0lpp1P
         52Rrr7XWBI7Wg==
Date:   Mon, 2 May 2022 15:44:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        robh+dt <robh+dt@kernel.org>, krzk+dt <krzk+dt@kernel.org>,
        kishon <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "jesper.nilsson" <jesper.nilsson@axis.com>,
        "lars.persson" <lars.persson@axis.com>,
        bhelgaas <bhelgaas@google.com>,
        linux-phy <linux-phy@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi" <lorenzo.pieralisi@arm.com>, kw <kw@linux.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        kernel <kernel@axis.com>, Moon-Ki Jun <moonki.jun@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
Subject: Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
Message-ID: <Ym+u9yYrV9mxkyWX@matsya>
References: <4a6dd90c-3f8e-ad18-0136-88b75f4d9cf9@kernel.org>
 <20220418072049epcms2p463a9f01d8ae3e29f75b746a0dce934f1@epcms2p4>
 <CGME20220418072049epcms2p463a9f01d8ae3e29f75b746a0dce934f1@epcms2p1>
 <20220421235725epcms2p1fc34c904f960cba958fa692c6d5dad9c@epcms2p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220421235725epcms2p1fc34c904f960cba958fa692c6d5dad9c@epcms2p1>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-04-22, 08:57, Wangseok Lee wrote:
> > On 18/04/2022 09:20, Wangseok Lee wrote:

> > Maybe, quite probably. The reluctance to extend any existing code makes
> > me doubting this, but I admit that there are many differences.
> > 
> >> For these reasons, my opinion is that better to create
> >> a phy, controller both driver with a new file.
> >> Please let me know your opinion.
> > 
> > At the end it's mostly the decision of PCIe and phy subsystem
> > maintainers whether they want to have separate drivers for DWC PCIe
> > blocks in ARMv8 Samsung SoCs.
> > 
> > In any case, the driver code looks like copied-pasted from some vendor
> > sources, so you need to bring it to shape.

I think havong a common driver helps everyone, many vendors do that
already. If you have a technical issue of adding and maintaining a
common driver upstream we would be eager to understand and help with
that...

-- 
~Vinod
