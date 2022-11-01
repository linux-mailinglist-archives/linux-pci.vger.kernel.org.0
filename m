Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F486155EC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 00:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiKAXJX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 19:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiKAXIv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 19:08:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216B421261;
        Tue,  1 Nov 2022 16:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6510DB8200F;
        Tue,  1 Nov 2022 23:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2652C43140;
        Tue,  1 Nov 2022 23:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667343987;
        bh=h3TDzq6RA6ifBlLZvChfXTTeOPyO4gqSJIZXK2euXK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=slGnSOM0Br3V6UpWjbrEMY6F5klfQidpH7xl0QhiV8IjVAmtUCbyJe2QnisXlcCUH
         4pdb/PaHN20v61oPIdPKs0xIJGBJvY1iD/oo47UvgpNHkyV39LtS5hUxuHvXmwIaam
         7dMPDyo4Q99w+aVG7gaYYon9RX3rHWkTZHdAQyqER7m9Q7Wx0T+UADJQ7HwzwVKWn2
         MYbVBmRvbI9ufeB2BtJ0p1tCSJIoKSSzvrUmHmevx31s6SvGECdSqO7a9yOLHUuEOd
         xo839KPNi3PKkIm50MuSviEX2QuTCScVhFcstTxdDLeYEygQVnEVDJ+jehaSXYTMSC
         SWXBYSjLBWvPg==
Received: by pali.im (Postfix)
        id 2DB657F8; Wed,  2 Nov 2022 00:06:24 +0100 (CET)
Date:   Wed, 2 Nov 2022 00:06:24 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
Message-ID: <20221101230624.zsy22bxswl5o7d4k@pali>
References: <20220818163756.qmyopspdn5xywe5s@pali>
 <20220818165220.GA2378685@bhelgaas>
 <20221009112910.ycwrwzogws2dtnaq@pali>
 <54096629-fef0-8952-6a84-c1a12e38a442@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54096629-fef0-8952-6a84-c1a12e38a442@wanadoo.fr>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 09 October 2022 15:39:11 Christophe JAILLET wrote:
> Le 09/10/2022 à 13:29, Pali Rohár a écrit :
> > On Thursday 18 August 2022 11:52:20 Bjorn Helgaas wrote:
> > > On Thu, Aug 18, 2022 at 06:37:56PM +0200, Pali Rohár wrote:
> > > > On Thursday 18 August 2022 16:59:33 Andrew Lunn wrote:
> > > > > On Thu, Aug 18, 2022 at 03:50:09PM +0200, Pali Rohár wrote:
> > > > > > PING?
> > > > > 
> > > > > Pretty much anything sent during the merge window, and just before the
> > > > > merge window gets thrown away. Please rebase onto the current pci tree
> > > > > and repost.
> > > > 
> > > > Please write it pretty clear that you are not interested in those
> > > > patches, and not hiding this info behind asking me after month of
> > > > waiting for another work of rebase with sending them at eight o'clock
> > > > during full moon. It is pretty ridiculous how to say "go away". Thanks.
> > > 
> > > Nobody is saying "go away".  I apologize that I haven't had time to
> > > look at this yet.
> > > 
> > > It's still in patchwork [1], and if it still applies cleanly to
> > > v6.0-rc1, you don't need to do anything.  If it requires rebasing to
> > > apply cleanly, it will expedite things if you do that.
> > > 
> > > Bjorn
> > > 
> > > [1] https://patchwork.kernel.org/project/linux-pci/patch/20220714184130.5436-1-pali@kernel.org/
> > 
> > It applies cleanly on v6.0-rc1.
> > 
> 
> On linux-next, the diff applies, but with offsets on pci.c and pci.h.
> 
> CJ

This should not be an issue. Bjorn?
