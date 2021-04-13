Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB57A35DB54
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 11:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbhDMJd6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 05:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242062AbhDMJdz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 05:33:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF0B06120E;
        Tue, 13 Apr 2021 09:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618306414;
        bh=OHVmgNAc9Ko7jLmjLSwhOHjp8WsqcCvuAYRBedFlArY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1xnhiyqZl6eC8DimJm37LNdnIU4QhNirim+iOm1Z6NU+CcXS6hxPcVUE0mc16zoo
         aJcFA8yYdCKBOhbA2br4mZNEb2/QMOYn1Jwtud0K1CaUIGZXyE0dUbWwxoFo+dUG/8
         psCQwkZSmrFLhIlrG+V87zFmJr4Pxaxc4TCk51XyjC2g59uzPnj+fezbbWz7WVj2Wd
         Kp4fxLCysN4RSOkrF9JTa6Xpc8rh8nlgmw+1lfWpnXd1ExL3qbaqp4eOqhm/BUXFZk
         KHy0sljVQBnImxzKH1g+cFah8vaqnlusLl6PD8ctZNzOb7OAPVp+cs6nnwmtg/gD07
         FmqPhbwtcxQAw==
Received: by pali.im (Postfix)
        id 5DE9E860; Tue, 13 Apr 2021 11:33:31 +0200 (CEST)
Date:   Tue, 13 Apr 2021 11:33:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Subject: Re: PCI service interrupt handlers & access to PCI config space
Message-ID: <20210413093331.censd2l5qnskuepz@pali>
References: <20210410122845.nhenihbygmcjlegn@pali>
 <20210410142524.GA31187@wunner.de>
 <20210410151709.yb42uloq3aiwcoog@pali>
 <20210410162622.GA23381@wunner.de>
 <20210412022555.GA41644@C02WT3WMHTD6>
 <20210412140451.672makicwd6z6oln@pali>
 <20210412150920.GA13470@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412150920.GA13470@redsun51.ssa.fujisawa.hgst.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 13 April 2021 00:09:20 Keith Busch wrote:
> On Mon, Apr 12, 2021 at 04:04:51PM +0200, Pali Rohár wrote:
> > On Sunday 11 April 2021 20:25:55 Keith Busch wrote:
> > > On Sat, Apr 10, 2021 at 06:26:22PM +0200, Lukas Wunner wrote:
> > > > 
> > > > 1.5 sec is definitely too long.  This sounds like a quirk of this
> > > > specific hardware.  Try to find out if the hardware can be configured
> > > > differently to respond quicker.
> > > 
> > > While 1.5 sec is long, pcie spec's device control 2 register has an option to
> > > be even longer: up to 64 seconds for a config access timeout! I'm not sure of
> > > the reasoning to allow something that high, but I think the operating system
> > > would be not be too happy with that.
> > 
> > So what can we do in this case? On single core CPU it means that raw
> > spin lock would completely block any operation on CPU for 64 seconds.
> 
> I don't think it would work here. I'm just saying that while 1.5s config
> access is quite long, the spec provides an option where times exceeding
> that are expected.
> 
> I have never seen a device configured that way, though. The completion
> timeouts are usually set in milliseconds.
> 
> > Do you know what is the timeout for other registers?
> 
> The Device Control Register 2 timeout value is the setting for all
> non-posted requests.

Root Bridge of PCIe controller is seen by lspci as:

  DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ 10BitTagReq- OBFF Disabled, ARIFwd-
           AtomicOpsCtl: ReqEn- EgressBlck-

So it does not look like that Device Control 2 is configured with higher
delays.
