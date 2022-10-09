Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CBA5F8AE6
	for <lists+linux-pci@lfdr.de>; Sun,  9 Oct 2022 13:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJIL3T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Oct 2022 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJIL3S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Oct 2022 07:29:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9362A972;
        Sun,  9 Oct 2022 04:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A71B2B80C69;
        Sun,  9 Oct 2022 11:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38947C433D6;
        Sun,  9 Oct 2022 11:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665314953;
        bh=vjwaWeOlMX3AXv00pHdrrZPTNy9wxfJuYCETlr7ieZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IqjlW8nBjloqFH8JHuTzphiAdHVa9RdwDlJRDQgTnGvYaZdcRLXm2xsio/D2DrUwj
         l92uUMBdLiJ1s0MyVONvHNNw33FYyJjvZMZeJlEIIOi/bE3OgMmw7uhGuQF1CuVa3V
         r6JDC8Evq4uAN09HpEUbpg5e3L5opcnA65oOdtV20W+pzRf/1Ig5roRmhi6EF6d8EZ
         PoCMdnGYHmaPR2oqjoOIePtVanPw0VpDdiojK3E0RF9ttFcj1TAZ23/0GA6D/lMm0e
         CRQj4aEH4FnIU4wJoc1A0fM/OY7aqJZKneLn9+VBYVAzXBVYBw4pYQyo+oBgj+MOXL
         QzSdtf0PVradw==
Received: by pali.im (Postfix)
        id 90B427C1; Sun,  9 Oct 2022 13:29:10 +0200 (CEST)
Date:   Sun, 9 Oct 2022 13:29:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
Message-ID: <20221009112910.ycwrwzogws2dtnaq@pali>
References: <20220818163756.qmyopspdn5xywe5s@pali>
 <20220818165220.GA2378685@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818165220.GA2378685@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 18 August 2022 11:52:20 Bjorn Helgaas wrote:
> On Thu, Aug 18, 2022 at 06:37:56PM +0200, Pali Rohár wrote:
> > On Thursday 18 August 2022 16:59:33 Andrew Lunn wrote:
> > > On Thu, Aug 18, 2022 at 03:50:09PM +0200, Pali Rohár wrote:
> > > > PING?
> > > 
> > > Pretty much anything sent during the merge window, and just before the
> > > merge window gets thrown away. Please rebase onto the current pci tree
> > > and repost.
> > 
> > Please write it pretty clear that you are not interested in those
> > patches, and not hiding this info behind asking me after month of
> > waiting for another work of rebase with sending them at eight o'clock
> > during full moon. It is pretty ridiculous how to say "go away". Thanks.
> 
> Nobody is saying "go away".  I apologize that I haven't had time to
> look at this yet.
> 
> It's still in patchwork [1], and if it still applies cleanly to
> v6.0-rc1, you don't need to do anything.  If it requires rebasing to
> apply cleanly, it will expedite things if you do that.
> 
> Bjorn
> 
> [1] https://patchwork.kernel.org/project/linux-pci/patch/20220714184130.5436-1-pali@kernel.org/

It applies cleanly on v6.0-rc1.
