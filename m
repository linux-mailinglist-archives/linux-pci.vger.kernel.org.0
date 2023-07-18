Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D43758325
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjGRQ70 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 12:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjGRQ7J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 12:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E29926A5
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 09:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA9E261617
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 16:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D48C433C8;
        Tue, 18 Jul 2023 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689699426;
        bh=1itygYNn0m35G72y3enlnZGvcgzdg7PKQPB1H/XtOGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upue4qA4FBdXE77pRX9z36mTfdNWKo/onmn2eDrM4gd1HV//Y2lXjBtMDzkYQtijv
         MdHKtCLC0bDC9hQmVJE+ElxJhYCzAmCVUqxeL5FywsNq3b/jci+HsojO96R6QpQQBz
         Wq7SW214j0ze+miHXhvWwBB8/Now9orQ+dkDE3nhWuqY+85NoGaTokTc3EfH5uLGXu
         S0QE9mOL1QCqSrNn8cYh14pTyQRnNSFnbPjkS/wuFo4VLBXuQFiw1xvPSRrf1dkUYP
         QzCJInevWFy+XCe5CWru9ooDths5xUz6Od5OQ2cdvfAD68D6UCef9tQ+q7vqBwVgZy
         W7wYgBwe1isVw==
Received: by pali.im (Postfix)
        id 2567071F; Tue, 18 Jul 2023 18:57:03 +0200 (CEST)
Date:   Tue, 18 Jul 2023 18:57:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, Radu Rendec <rrendec@redhat.com>
Subject: Re: Future of pci-mvebu
Message-ID: <20230718165703.adgkqb4jadmnx73c@pali>
References: <20230717220317.q7hgtpppvruxiapx@pali>
 <20230718111952.GA475778@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718111952.GA475778@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 18 July 2023 06:19:52 Bjorn Helgaas wrote:
> [+cc Radu]
> 
> On Tue, Jul 18, 2023 at 12:03:17AM +0200, Pali Rohár wrote:
> > Hello, I have just one question. What do you want to do with pci-mvebu
> > driver? It is already marked as broken for 3 kernel releases and I do
> > not see any progress from anybody (and you rejected my fixes). How long
> > do you want it to have marked as broken?
> 
> I don't think "depends on BROKEN" necessarily means that we plan to
> remove the driver.  I think it just means that it's currently broken,
> but we hope to fix it eventually.
> 
> I think the problem here is the regular vs chained interrupt handlers,
> right?  Radu has been looking at that recently, too, so maybe we can
> have another go at it.
> 
> Bjorn

I guess that this is the main issue as all other fixes and improvements
are stalled. Just to remind that we have there shared interrupt source
(which can be requested by more HW drivers) and consumer is PCIe INTX
which is de-facto chained handler. And I have not seen anything for
shared interrupt source except request_irq(IRQF_SHARED) which you do not
want to use for shared interrupts anymore. Also setting of PCIe INTX
affinity is broken which worked fine with the previous kernel versions.
And you also rejected fixes for this regression.
