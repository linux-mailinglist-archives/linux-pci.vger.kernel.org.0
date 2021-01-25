Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C83E30309D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 00:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbhAYXzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 18:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732014AbhAYTpW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 14:45:22 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376B8C06174A;
        Mon, 25 Jan 2021 11:44:38 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 55F2822ED8;
        Mon, 25 Jan 2021 20:44:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611603872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6If+MuA7xMjVjPkj+ScYzphIBDiMZs5ah103gQQWTRU=;
        b=Ynwg8u+t+4ehPbQ/ZynTIQmrV+t43/QDTOMm4j884O+3dbfozohojiqWzcwElFOaFmRTgv
        2ZSGJvv+2x3vaGckP6AO0wmdy5s3mb2Fn3t4zXO7s2wMJFgQOIKPN6UCf44FWmq7JnKnIP
        BVQw5Ta+4DdNG5wKOpDWu48T169HqYw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 Jan 2021 20:44:28 +0100
From:   Michael Walle <michael@walle.cc>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to
 builtin_platform_driver()
In-Reply-To: <CAGETcx-P-MxM+49XdUGBmg5YgnHS=fmz8uewywXvLSFKj=MqRQ@mail.gmail.com>
References: <20210120105246.23218-1-michael@walle.cc>
 <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc>
 <20210125165041.GA5979@e121166-lin.cambridge.arm.com>
 <CAGETcx-P-MxM+49XdUGBmg5YgnHS=fmz8uewywXvLSFKj=MqRQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <40251e6b610897639e2e08fec87c73b3@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2021-01-25 19:58, schrieb Saravana Kannan:
> On Mon, Jan 25, 2021 at 8:50 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> 
>> On Wed, Jan 20, 2021 at 08:28:36PM +0100, Michael Walle wrote:
>> > [RESEND, fat-fingered the buttons of my mail client and converted
>> > all CCs to BCCs :(]
>> >
>> > Am 2021-01-20 20:02, schrieb Saravana Kannan:
>> > > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
>> > > >
>> > > > On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
>> > > > wrote:
>> > > > >
>> > > > > fw_devlink will defer the probe until all suppliers are ready. We can't
>> > > > > use builtin_platform_driver_probe() because it doesn't retry after probe
>> > > > > deferral. Convert it to builtin_platform_driver().
>> > > >
>> > > > If builtin_platform_driver_probe() doesn't work with fw_devlink, then
>> > > > shouldn't it be fixed or removed?
>> > >
>> > > I was actually thinking about this too. The problem with fixing
>> > > builtin_platform_driver_probe() to behave like
>> > > builtin_platform_driver() is that these probe functions could be
>> > > marked with __init. But there are also only 20 instances of
>> > > builtin_platform_driver_probe() in the kernel:
>> > > $ git grep ^builtin_platform_driver_probe | wc -l
>> > > 20
>> > >
>> > > So it might be easier to just fix them to not use
>> > > builtin_platform_driver_probe().
>> > >
>> > > Michael,
>> > >
>> > > Any chance you'd be willing to help me by converting all these to
>> > > builtin_platform_driver() and delete builtin_platform_driver_probe()?
>> >
>> > If it just moving the probe function to the _driver struct and
>> > remove the __init annotations. I could look into that.
>> 
>> Can I drop this patch then ?
> 
> No, please pick it up. Michael and I were talking about doing similar
> changes for other drivers.

Yes please, I was just about to answer, but Saravana beat me.

-michael
