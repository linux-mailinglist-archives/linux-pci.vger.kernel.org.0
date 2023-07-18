Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE16F75856E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 21:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGRTV6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 15:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGRTV5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 15:21:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D22198C
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 12:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F962616CE
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 19:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD498C433C8;
        Tue, 18 Jul 2023 19:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689708116;
        bh=ZN7UMcUlsP8PQYfN/5u1+kRnO9SRg83jTFoPhDvtMMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GD5xSS2c6YJBydRMSz+dG7woQEumDfjH5Ig+9S6vreuBxQNnTqB13na1M9D1ujqms
         +UCZBG1a6MSuQ7biY3faMBV4x4s+t5HKF7FEhXpclFMFB+6OkaEIhG6M0bY1DYD69t
         /QpzdLCX5FNNutDOoA9JDMPyzWKbIVgXeEbMCLvCOf10oPsTQhXFH4hRlslIOjc6rP
         a0zM+YTw57ay55JL/KmUsEETJlBTf/sIPAL7A18mMZfSHqw7qf4MjzC6pLI4NDwqfb
         +zmrsbK+xcDkzQeNnoec1oBYCah28Iyr9KsQuXF70mpyPNQz7b2z1zj98S5BJet1nj
         7Ia0DemTp3cFg==
Received: by pali.im (Postfix)
        id E4FEF71F; Tue, 18 Jul 2023 21:21:52 +0200 (CEST)
Date:   Tue, 18 Jul 2023 21:21:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, Radu Rendec <rrendec@redhat.com>
Subject: Re: Future of pci-mvebu
Message-ID: <20230718192152.b4ic3nptfpsrrtui@pali>
References: <20230718165703.adgkqb4jadmnx73c@pali>
 <20230718190252.GA489311@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718190252.GA489311@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 18 July 2023 14:02:52 Bjorn Helgaas wrote:
> On Tue, Jul 18, 2023 at 06:57:03PM +0200, Pali Rohár wrote:
> > On Tuesday 18 July 2023 06:19:52 Bjorn Helgaas wrote:
> > > On Tue, Jul 18, 2023 at 12:03:17AM +0200, Pali Rohár wrote:
> > > > Hello, I have just one question. What do you want to do with pci-mvebu
> > > > driver? It is already marked as broken for 3 kernel releases and I do
> > > > not see any progress from anybody (and you rejected my fixes). How long
> > > > do you want it to have marked as broken?
> > > 
> > > I don't think "depends on BROKEN" necessarily means that we plan to
> > > remove the driver.  I think it just means that it's currently broken,
> > > but we hope to fix it eventually.
> > > 
> > > I think the problem here is the regular vs chained interrupt handlers,
> > > right?  Radu has been looking at that recently, too, so maybe we can
> > > have another go at it.
> > 
> > I guess that this is the main issue as all other fixes and improvements
> > are stalled. 
> 
> If these other things don't depend on this IRQ issue, maybe we could
> still make progress on them?  Maybe post them again (rebasing to
> v6.5-rc1 if necessary)?  Often I forget or miss things, so it doesn't
> hurt to try again if you don't hear anything.

In past I (re)sent changes at least 3 times. And would not do it again.

> > Just to remind that we have there shared interrupt source
> > (which can be requested by more HW drivers) and consumer is PCIe INTX
> > which is de-facto chained handler. And I have not seen anything for
> > shared interrupt source except request_irq(IRQF_SHARED) which you do not
> > want to use for shared interrupts anymore. Also setting of PCIe INTX
> > affinity is broken which worked fine with the previous kernel versions.
> > And you also rejected fixes for this regression.
> 
> This sounds like the issue where we haven't figured out how to make
> both Marc and Thomas happy at the same time.  I don't know much about
> IRQs, but I'm still optimistic that it may be possible because I don't
> think there's anything really unique about mvebu here.
> 
> Bjorn

At I pointed out, nothing happened for 3 kernel releases and also
nothing happened since my last attempt there. I'm not going to waste
more time on it as I already saw results and I'm not going to repeat
them. Look at the current result - it does not work.
