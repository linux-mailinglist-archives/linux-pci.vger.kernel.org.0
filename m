Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641ED34EB7C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhC3PFW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 11:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231782AbhC3PFC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 11:05:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2004B61957;
        Tue, 30 Mar 2021 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617116701;
        bh=Uz3WI/FYY/TSpvPtpW5nBqc9OPXzLv/VYZ9gQpSx94g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+bvMQicFuv2CM1+lsqoT0kZZSHQXh+vIOtWPQwfmbNJgdPL+CFlSUCcaAkXY1uZ6
         rC6iVChQ7OlR0wuskwyUvHGi5YIxlkoV3q90gpZQZU2PmBXj/qGinsWJDHzw5r2hJV
         MGkjjiVeRyMcvmkvPx2bFtUKwHgJChckhylj6PbFGQ6NsHN5yD6pURXjAIDYqC4ur/
         hUKCpSpxOJXjdCPX7seipcU22Mo8QXzdt0EqswB3evGNyxXuZizmp0iZp0o8+ERPrt
         wiRI2c+ov3H0qJ8o8kYD16ctpspC2hDrF7WEKfEoLkehmZmDUrpMnEYdTK2r8kzigI
         GnmUeo1mlnPtQ==
Received: by pali.im (Postfix)
        id DD995EAA; Tue, 30 Mar 2021 17:04:58 +0200 (CEST)
Date:   Tue, 30 Mar 2021 17:04:58 +0200
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
Message-ID: <20210330150458.gzz44gczhraxc6bc@pali>
References: <20210310110535.zh4pnn4vpmvzwl5q@pali>
 <20210323161941.gim6msj3ruu3flnf@archlinux>
 <20210323162747.tscfovntsy7uk5bk@pali>
 <20210323165749.retjprjgdj7seoan@archlinux>
 <a8e256ece0334734b1ef568820b95a15@AcuMS.aculab.com>
 <alpine.DEB.2.21.2103301428030.18977@angie.orcam.me.uk>
 <20210330131018.gby4ze3u6mii23ls@pali>
 <alpine.DEB.2.21.2103301628180.18977@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2103301628180.18977@angie.orcam.me.uk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 30 March 2021 16:34:47 Maciej W. Rozycki wrote:
> On Tue, 30 Mar 2021, Pali Rohár wrote:
> 
> > >  If I were to implement this stuff, for good measure I'd give it a safety 
> > > margin beyond what the spec requires and use a timeout of say 2-4s while 
> > > actively querying the status of the device.  The values given in the spec 
> > > are only the minimum requirements.
> > 
> > Are you able to also figure out what is the minimal timeout value for 
> > PCIe Warm Reset?
> > 
> > Because we are having troubles to "decode" correct minimal timeout value
> > for this PCIe Warm Reset (not Function-level reset).
> 
>  The spec does not give any exceptions AFAICT as to the timeouts required 
> between the three kinds of a Conventional Reset (Hot, Warm, or Cold) and 
> refers to them collectively as a Conventional Reset across the relevant 
> parts of the document, so clearly the same rules apply.
> 
>   Maciej

There are specified more timeouts related to Warm reset and PERST#
signal. Just they are not in Base spec, but in CEM spec. See previous
Amey's email where are described some timeouts and also links in my
first email where I put other timeouts defined in specs relevant for
PERST# signal and therefore also for Warm Reset.
