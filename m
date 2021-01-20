Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F79E2FD99A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 20:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392481AbhATT1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 14:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392433AbhATT0a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2021 14:26:30 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12AAC0613C1;
        Wed, 20 Jan 2021 11:25:49 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 27EE622727;
        Wed, 20 Jan 2021 20:25:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611170746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Ob7KUwKuR0nwFPm6ISDKf74WkwKvOKiqWXqn3cjXq4=;
        b=miTTwPJ3DtMSDIJ557R+SQ07RWGLYMYbiHcOHy/FBwqEOPhREbpehfwHDCrQ1LUSLmRfIQ
        Gv/SFl3qrWmnvAEQl1eh+Mtx3U9pOR+3PjPlrugHpuLdvZxxeAhu0ZZNdKS317cRghifnO
        rcfP8XLVRxq17yPcSoiTiTE4L/tdBpY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jan 2021 20:25:45 +0100
From:   Michael Walle <michael@walle.cc>
To:     undisclosed-recipients:;
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to
 builtin_platform_driver()
In-Reply-To: <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
References: <20210120105246.23218-1-michael@walle.cc>
 <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <66e4bf55b2809893ad9c87458c170f99@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
