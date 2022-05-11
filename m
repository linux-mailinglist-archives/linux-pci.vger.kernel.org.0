Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5E6522F6F
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 11:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiEKJcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiEKJcJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 05:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D535134E53
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 02:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F92061C2E
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 09:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E33C340EB;
        Wed, 11 May 2022 09:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652261525;
        bh=ykMqjwlxfmbvbxIrsCjmziO8KoLa6shEseA1d71OtLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+5GyHb7ScXpfE6aPqpu3LaEakb6SCP4H9z8n25dneopvtApOxx53IJzbPFw1b8sK
         u4eJLTpc0Qzt4ODlYo6zgcqZBekRSuvZkX40+1Or6QzGrXx30tvvnSTKopvRgV7hbt
         TwtH284GPjoqejPnaCZybjwLAPkiwqT+cmPEqx3Udf7cu8Sk/ZVAZsM9u7YvjsGHCy
         ovD5CqTe2f5xMeyilfhCDsP8TYpz7OZtSb4K1Xa69t/AgD+72kn34SfE8rfsb+ONUg
         MMQBC/AHwlPHGnU/IWSQwkKGUuKg2lOlCFpsqwW0xt7TEB+J9tKZBhNZFS9DXPeqmc
         uh8AJD5pZAaOQ==
Received: by pali.im (Postfix)
        id 5950921A6; Wed, 11 May 2022 11:32:02 +0200 (CEST)
Date:   Wed, 11 May 2022 11:32:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3] PCI: imx6: Fix PERST# start-up sequence
Message-ID: <20220511093202.lc5eb4wq7ywdzxis@pali>
References: <20220404081509.94356-1-francesco.dolcini@toradex.com>
 <20220411165031.GA28780@lpieralisi>
 <20220509140919.GA7159@francesco-nb.int.toradex.com>
 <YnqlmMzOLSxjzHJi@lpieralisi>
 <20220511071350.GA9888@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511071350.GA9888@francesco-nb.int.toradex.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 11 May 2022 09:13:50 Francesco Dolcini wrote:
> On Tue, May 10, 2022 at 06:49:12PM +0100, Lorenzo Pieralisi wrote:
> > On Mon, May 09, 2022 at 04:09:19PM +0200, Francesco Dolcini wrote:
> > > Hello Lorenzo,
> > > 
> > > On Mon, Apr 11, 2022 at 05:50:41PM +0100, Lorenzo Pieralisi wrote:
> > > > [CC'ed Pali, who is working on PERST consolidation]
> > > > 
> > > > On Mon, Apr 04, 2022 at 10:15:09AM +0200, Francesco Dolcini wrote:
> > > > > Failure to do so could prevent PCIe devices to be working correctly,
> > > > > and this was experienced with real devices.
> > > 
> > > Just a gentle ping, any concern on the patch?
> > 
> > I was waiting to see if Pali has any comments on it, given that he
> > is working on consolidating PERST management.
> 
> Hello Pali,
> any concern on merging this patch?
> 
> Thanks a lot
> Francesco

Hello Francesco! I have no objections for your patch, it is fine to merge it.

Btw, I lost interest in consolidating PERST# management as now I know that it would not be accepted.
