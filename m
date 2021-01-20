Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74602FD9AF
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 20:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391504AbhATT32 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 14:29:28 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:56615 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbhATT3Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2021 14:29:25 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B93C222727;
        Wed, 20 Jan 2021 20:28:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611170916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=funa0VDSjChNQlG3j9dG7FuPG03v086iMYT7iNUMC9I=;
        b=VJ2J/kWrEXengkVVYJf5GdKIDh/xQfdNBZQ04ik7wPGQwtIrFRJuNc9cQes6cOWobahgPY
        ZP3apLMd2zEy+z//XEw0eSwKYMzt/Co1sg31e8vXoafvlfy4yHT2M9uXXHcr09MWGj/Wny
        Y2x4Ubqsv5GXl2VeVSzanphVIp65sI8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jan 2021 20:28:36 +0100
From:   Michael Walle <michael@walle.cc>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to
 builtin_platform_driver()
In-Reply-To: <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
References: <20210120105246.23218-1-michael@walle.cc>
 <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <c3e35b90e173b15870a859fd7001a712@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[RESEND, fat-fingered the buttons of my mail client and converted
all CCs to BCCs :(]

Am 2021-01-20 20:02, schrieb Saravana Kannan:
> On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
>> 
>> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc> 
>> wrote:
>> >
>> > fw_devlink will defer the probe until all suppliers are ready. We can't
>> > use builtin_platform_driver_probe() because it doesn't retry after probe
>> > deferral. Convert it to builtin_platform_driver().
>> 
>> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
>> shouldn't it be fixed or removed?
> 
> I was actually thinking about this too. The problem with fixing
> builtin_platform_driver_probe() to behave like
> builtin_platform_driver() is that these probe functions could be
> marked with __init. But there are also only 20 instances of
> builtin_platform_driver_probe() in the kernel:
> $ git grep ^builtin_platform_driver_probe | wc -l
> 20
> 
> So it might be easier to just fix them to not use
> builtin_platform_driver_probe().
> 
> Michael,
> 
> Any chance you'd be willing to help me by converting all these to
> builtin_platform_driver() and delete builtin_platform_driver_probe()?

If it just moving the probe function to the _driver struct and
remove the __init annotations. I could look into that.

-michael
