Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB97C35C971
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 17:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbhDLPJq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 11:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238789AbhDLPJp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Apr 2021 11:09:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FC946128C;
        Mon, 12 Apr 2021 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618240167;
        bh=9GY641SfFXEeg/SSnRcX5i1m3wYS7xpCRvmOEJIXIvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9IikvuaVow9ti6GFnDrkeL7IoIORfo0NHCaYhTKNCGTLaMToih6tpvQVNw0wh2Rf
         swUO7hyZDEoQxRI1uDNE2WgsVnktay0FPQGu9jtgprbnX3WpOZ6v4ZgY7GYHjgRq75
         SvaYsVh2eQzsL9KAJ7JHYkyrhmH7CYRADhq9onYfvLDoy1qo7yqevfUYAv2QS9unkF
         E/T75uwVtcNTqjVb9jeWqZS2A2T22xM+2EmUH+t2QkFSoIfdreIleB5T8XZ3gOzeov
         u22SPW8kWU0XwQCuDBxQCyTAht6mThi432cu4dz1CRozzqCFR8mQxfxn8zSiVvX68P
         V09xakmQ0UzPQ==
Date:   Tue, 13 Apr 2021 00:09:20 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Subject: Re: PCI service interrupt handlers & access to PCI config space
Message-ID: <20210412150920.GA13470@redsun51.ssa.fujisawa.hgst.com>
References: <20210410122845.nhenihbygmcjlegn@pali>
 <20210410142524.GA31187@wunner.de>
 <20210410151709.yb42uloq3aiwcoog@pali>
 <20210410162622.GA23381@wunner.de>
 <20210412022555.GA41644@C02WT3WMHTD6>
 <20210412140451.672makicwd6z6oln@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412140451.672makicwd6z6oln@pali>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 12, 2021 at 04:04:51PM +0200, Pali Rohár wrote:
> On Sunday 11 April 2021 20:25:55 Keith Busch wrote:
> > On Sat, Apr 10, 2021 at 06:26:22PM +0200, Lukas Wunner wrote:
> > > 
> > > 1.5 sec is definitely too long.  This sounds like a quirk of this
> > > specific hardware.  Try to find out if the hardware can be configured
> > > differently to respond quicker.
> > 
> > While 1.5 sec is long, pcie spec's device control 2 register has an option to
> > be even longer: up to 64 seconds for a config access timeout! I'm not sure of
> > the reasoning to allow something that high, but I think the operating system
> > would be not be too happy with that.
> 
> So what can we do in this case? On single core CPU it means that raw
> spin lock would completely block any operation on CPU for 64 seconds.

I don't think it would work here. I'm just saying that while 1.5s config
access is quite long, the spec provides an option where times exceeding
that are expected.

I have never seen a device configured that way, though. The completion
timeouts are usually set in milliseconds.

> Do you know what is the timeout for other registers?

The Device Control Register 2 timeout value is the setting for all
non-posted requests.
