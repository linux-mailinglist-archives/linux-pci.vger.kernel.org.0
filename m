Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776DF57608A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 13:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiGOLdK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 07:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGOLdJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 07:33:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4ADA4;
        Fri, 15 Jul 2022 04:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86A00622C1;
        Fri, 15 Jul 2022 11:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFFEC341C0;
        Fri, 15 Jul 2022 11:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657884788;
        bh=c1c93+tjC4WORlEUFvYHxmjrCrBFO9kZtjAHyKyLww0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARBWsnnFu2iA17XOMPlqDlZ3h+Dvvggd1uhc4cRrK60048Agu4QbEPBSWaN7A7jaM
         cWlEq6tsE8aQsjD29f4U1ecH+OkdlrvW0VMDEqnW9sbzqHmGCFlSBbiEe7Ms7YwTcR
         eRo0cAn0eIZq/GHG3UrUq/wEOPTt4PMHPzw2nbRfemo+LdcSbAD9WX2H1ii0F8kKdH
         Z+zhmvtWQffYI+dM6rQp7PFDDzld+/9zJaZlUAUh6L1Z3zkz8xW6tWx6rLry5cBwgk
         l+qzCjs4GshZm+Yn9xNaTnzbzPhJxXFhZVherD/tqChlrl/JC85IHem+ntQrBRXACF
         5fqt+pFCqHBUg==
Date:   Fri, 15 Jul 2022 17:03:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
Subject: Re: [PATCH v3 4/5] phy: Add ARTPEC-8 PCIe PHY driver
Message-ID: <YtFQb+2tpYsg25w/@matsya>
References: <YsW9m6hotDKacXe3@matsya>
 <YsPYc3YPuG56yTYM@matsya>
 <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
 <20220614013446epcms2p8c88ea65da49447f72fef6536c7f73fb6@epcms2p8>
 <20220706081036epcms2p6baf1d8afac994cd0d45c5e59029c8ce7@epcms2p6>
 <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p5>
 <20220714095955epcms2p5f5e9a3123a368069b5c661cdeb70485e@epcms2p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714095955epcms2p5f5e9a3123a368069b5c661cdeb70485e@epcms2p5>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14-07-22, 18:59, Wangseok Lee wrote:
> On 07-07-22, 01:52, Vinod Koul wrote:
> > On 06-07-22, 17:10, Wangseok Lee wrote:

> Sorry for late reply.
> 
> Above all, the IP blocks of phy-exynos-pcie.c and artpec8's pcie phy are
> different. As a result, the H/W architecture and operation sequence is
> very different. So it is very difficult to merge into a exynos pcie file.
> If possible, we would like to proceed with a new file. Is that possible?

Okay lets try that

-- 
~Vinod
