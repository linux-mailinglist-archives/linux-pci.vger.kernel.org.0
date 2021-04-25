Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939D036A802
	for <lists+linux-pci@lfdr.de>; Sun, 25 Apr 2021 17:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhDYPkm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Apr 2021 11:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230293AbhDYPkm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 25 Apr 2021 11:40:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DAC661168;
        Sun, 25 Apr 2021 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619365202;
        bh=vJQId1sKBjLTaFwG7YtTI4NnN2kP1/6h7OuKvaYH7tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObQ99q5AWRiK9wV2jNlINCQQ1yVNdDq3tvZlwTUSiIxFbe+f4Jp5NisWIWhZUfsMR
         XqstutyPx8m/yu3C1YgLQr7yWnF1kqlP5ah3SNB44laVj0z1gQ/tGfcZlJ0eAzGKKo
         BA4E44I96t0rkGDkpq4RIk40oH8P/qlN7mdNLNtJ3vHkPfmR8Ux4x8COkQIArb6rD1
         By4yXo5z6psUZx5UqtMbX3sr4cQVs74ZMg1ZPpgpJsWwj8jvIcq+EJ4GbsbUFdsTuu
         k9QLlh50uPM9gCRX8mCSDqQGxpX7VHsXzfoI3hDa/UNQbnR2BVvEyDxTGdZA0P9rgJ
         mkEexFxS/rx/g==
Received: by pali.im (Postfix)
        id B7C5689A; Sun, 25 Apr 2021 17:39:59 +0200 (CEST)
Date:   Sun, 25 Apr 2021 17:39:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Amey Narkhede' <ameynarkhede03@gmail.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kabel@kernel.org" <kabel@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "raphael.norwitz@nutanix.com" <raphael.norwitz@nutanix.com>
Subject: Re: How long should be PCIe card in Warm Reset state?
Message-ID: <20210425153959.3ydpjzyx5jp7uqzf@pali>
References: <20210310110535.zh4pnn4vpmvzwl5q@pali>
 <20210323161941.gim6msj3ruu3flnf@archlinux>
 <20210323162747.tscfovntsy7uk5bk@pali>
 <20210323165749.retjprjgdj7seoan@archlinux>
 <a8e256ece0334734b1ef568820b95a15@AcuMS.aculab.com>
 <alpine.DEB.2.21.2103301428030.18977@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2103301428030.18977@angie.orcam.me.uk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 30 March 2021 15:04:02 Maciej W. Rozycki wrote:
> On Thu, 25 Mar 2021, David Laight wrote:
> 
> > I can't see the value in the (nice bound) copy of the PCI 2.0 spec I have.
> > But IIRC it is 100ms (it might just me 500ms).
> > While this might seem like ages it can be problematic if targets have
> > to load large FPGA images from serial EEPROMs.
> 
>  AFAICT it is 100ms for the Conventional Reset before Configuration 
> Requests are allowed to be issued in the first place...

Hi Maciej! Now I see that we have talked about two different things.

My question is: How long should be card is reset state. And you
described timeouts after reset finish... which are different timeouts.

In case you know also timeout how long should card stay in reset state
then please let us know!
