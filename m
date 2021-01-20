Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D05F2FE033
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 04:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbhAUDwx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 22:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404368AbhATXy3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2021 18:54:29 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AB2C0613CF;
        Wed, 20 Jan 2021 15:53:48 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D75E522727;
        Thu, 21 Jan 2021 00:53:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611186825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbC26yrUSBeEpdGi0edZbsHLuIDHX8po3yB5+FOa+20=;
        b=oIjOfYEnvu/uhmimKD0tBrhgRlbrxb59Q+txl0qAblKBiHK2hbECe1FTHWyrZdpvHYbSl+
        8jBYl0ViNdmos6QQ/8ZlVz+/hgazuJ/BStuZ5HbkQf2APpzlQVht6qdkhfKiZ775YxN4OC
        nUNn9sMFWIP52XutqqWl1Sc2xQKuBMI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Jan 2021 00:53:44 +0100
From:   Michael Walle <michael@walle.cc>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to
 builtin_platform_driver()
In-Reply-To: <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
References: <20210120105246.23218-1-michael@walle.cc>
 <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc>
 <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <f706c0e4b684e07635396fcf02f4c9a6@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2021-01-20 20:47, schrieb Saravana Kannan:
> On Wed, Jan 20, 2021 at 11:28 AM Michael Walle <michael@walle.cc> 
> wrote:
>> 
>> [RESEND, fat-fingered the buttons of my mail client and converted
>> all CCs to BCCs :(]
>> 
>> Am 2021-01-20 20:02, schrieb Saravana Kannan:
>> > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
>> >>
>> >> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
>> >> wrote:
>> >> >
>> >> > fw_devlink will defer the probe until all suppliers are ready. We can't
>> >> > use builtin_platform_driver_probe() because it doesn't retry after probe
>> >> > deferral. Convert it to builtin_platform_driver().
>> >>
>> >> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
>> >> shouldn't it be fixed or removed?
>> >
>> > I was actually thinking about this too. The problem with fixing
>> > builtin_platform_driver_probe() to behave like
>> > builtin_platform_driver() is that these probe functions could be
>> > marked with __init. But there are also only 20 instances of
>> > builtin_platform_driver_probe() in the kernel:
>> > $ git grep ^builtin_platform_driver_probe | wc -l
>> > 20
>> >
>> > So it might be easier to just fix them to not use
>> > builtin_platform_driver_probe().
>> >
>> > Michael,
>> >
>> > Any chance you'd be willing to help me by converting all these to
>> > builtin_platform_driver() and delete builtin_platform_driver_probe()?
>> 
>> If it just moving the probe function to the _driver struct and
>> remove the __init annotations. I could look into that.
> 
> Yup. That's pretty much it AFAICT.
> 
> builtin_platform_driver_probe() also makes sure the driver doesn't ask
> for async probe, etc. But I doubt anyone is actually setting async
> flags and still using builtin_platform_driver_probe().

Hasn't module_platform_driver_probe() the same problem? And there
are ~80 drivers which uses that.

-michael
