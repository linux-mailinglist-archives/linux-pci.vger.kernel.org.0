Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870EB346516
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 17:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhCWQ14 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 12:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhCWQ1u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 12:27:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10AC261477;
        Tue, 23 Mar 2021 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616516870;
        bh=jdgaujTZa4YTW3pAKo+Bn89DEHg3n7EiLFOxCUbR6lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4tmDF26uCjRSu0Ex3pUvFEydYGXVbZ/vA+Y5lSbk9NxsurbG5ieY09DytyCveQ1j
         wco4Y58ZSVp7VnyyCt3wZAVRFLns/BwJkOgx/WkpHf4k7MTpvPocSn8Y1hlYc8r1bB
         O5dDMapZ7+V9ycKnrieorBsgwLHXlNnskKy/dGobRMfvDtwbXKrg2IdRr46Q5a0L9y
         Tu2FzuR+oyaYmmUutMMRV5tMtraK6iu4HkVOpFsBVdkZVxRgVLhBVBX+G5s0Fatwk1
         OS8paI9Dn/ndy/qC9/B+ApLwrVK9otVb23/AGq9HskHghCOubG7s4nnfDWL/G0ZWOI
         2vlCV5ePdIusg==
Received: by pali.im (Postfix)
        id A9BB392C; Tue, 23 Mar 2021 17:27:47 +0100 (CET)
Date:   Tue, 23 Mar 2021 17:27:47 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     alex.williamson@redhat.com, helgaas@kernel.org,
        lorenzo.pieralisi@arm.com, kabel@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        raphael.norwitz@nutanix.com
Subject: Re: How long should be PCIe card in Warm Reset state?
Message-ID: <20210323162747.tscfovntsy7uk5bk@pali>
References: <20210310110535.zh4pnn4vpmvzwl5q@pali>
 <20210323161941.gim6msj3ruu3flnf@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323161941.gim6msj3ruu3flnf@archlinux>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 23 March 2021 21:49:41 Amey Narkhede wrote:
> On 21/03/10 12:05PM, Pali Rohár wrote:
> > Hello!
> >
> > I would like to open a question about PCIe Warm Reset. Warm Reset of
> > PCIe card is triggered by asserting PERST# signal and in most cases
> > PERST# signal is controlled by GPIO.
> >
> > Basically every native Linux PCIe controller driver is doing this Warm
> > Reset of connected PCIe card during native driver initialization
> > procedure.
> >
> > And now the important question is: How long should be PCIe card in Warm
> > Reset state? After which timeout can be PERST# signal de-asserted by
> > Linux controller driver?
> >
> > Lorenzo and Rob already expressed concerns [1] [2] that this Warm Reset
> > timeout should not be driver specific and I agree with them.
> >
> > I have done investigation which timeout is using which native PCIe
> > driver [3] and basically every driver is using different timeout.
> >
> > I have tried to find timeouts in PCIe specifications, I was not able to
> > understand and deduce correct timeout value for Warm Reset from PCIe
> > specifications. What I have found is written in my email [4].
> >
> > Alex (as a "reset expert"), could you look at this issue?
> >
> > Or is there somebody else who understand PCIe specifications and PCIe
> > diagrams to figure out what is the minimal timeout for de-asserting
> > PERST# signal?
> >
> > There are still some issues with WiFi cards (e.g. Compex one) which
> > sometimes do not appear on PCIe bus. And based on these "reset timeout
> > differences" in Linux PCIe controller drivers, I suspect that it is not
> > (only) the problems in WiFi cards but also in Linux PCIe controller
> > drivers. In my email [3] I have written that I figured out that WLE1216
> > card needs to be in Warm Reset state for at least 10ms, otherwise card
> > is not detected.
> >
> > [1] - https://lore.kernel.org/linux-pci/20200513115940.fiemtnxfqcyqo6ik@pali/
> > [2] - https://lore.kernel.org/linux-pci/20200507212002.GA32182@bogus/
> > [3] - https://lore.kernel.org/linux-pci/20200424092546.25p3hdtkehohe3xw@pali/
> > [4] - https://lore.kernel.org/linux-pci/20200430082245.xblvb7xeamm4e336@pali/
> 
> I somehow got my hands on PCIe Gen4 spec. It says on page no 555-
> "When PERST# is provided to a component or adapter, this signal must be
> used by the component or adapter as Fundamental Reset.
> When PERST# is not provided to a component or adapter, Fundamental Reset is
> generated autonomously by the component or adapter, and the details of how
> this is done are outside the scope of this document."
> Not sure what component/adapter means in this context.
> 
> Then below it says-
> "In some cases, it may be possible for the Fundamental Reset mechanism
> to be triggered  by hardware without the removal and re-application of
> power to the component.  This is called a warm reset. This document does
> not specify a means for generating a warm reset."
> 
> Thanks,
> Amey

Hello Amey, PCIe Base document does not specify how to control PERST#
signal and how to issue Warm Reset. But it is documented in PCIe CEM,
Mini PCIe CEM and M.2 CEM documents (maybe in some other PCIe docs too).

It is needed look into more documents, "merge them in head" and then
deduce final meaning...
