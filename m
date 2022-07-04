Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2958565645
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 14:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiGDM67 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 08:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiGDM66 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 08:58:58 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7C760DC;
        Mon,  4 Jul 2022 05:58:58 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C793E22175;
        Mon,  4 Jul 2022 14:58:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656939536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nywE2HrLysWnN3UI4qxsDI2pyuwRY/B3fW0rahkLC9w=;
        b=Rg/urS2RdMA8OLtrXGUCO44DRooROvtEcajP7qjAHhP4nRV3AUzb7uc/iQwxqVLTTpfpg2
        f0fYNYkIQF1F3ThEL23H2dN6QCSAghDIbIz2d3aPb6RSMkGi6FMS/qEQ1jeZLavY6YyrzY
        j6IZlo6tMcMKw+QupH8Ct7XT8h8ca6o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Jul 2022 14:58:54 +0200
From:   Michael Walle <michael@walle.cc>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Thiery <heiko.thiery@gmail.com>
Subject: Re: next/master bisection: baseline.bootrr.imx6q-pcie-pcie0-probed on
 kontron-pitx-imx8m
In-Reply-To: <CAGETcx-ToG1xAtKVuZqwQK7hvVbT+Q0J0m4oWVCtR55XiYqETQ@mail.gmail.com>
References: <62bdec26.1c69fb81.46bc5.2d67@mx.google.com>
 <Yr3vEDDulZj1Dplv@sirena.org.uk>
 <CAGETcx88M3Use8crFMTU=By3UVjjaJuP1_Ah7zsy_w=pNxc+6w@mail.gmail.com>
 <CAGETcx_s+ui9wWA7OawojPbY95bLZE5pSmpK-34_kLZTzjf9Ew@mail.gmail.com>
 <Yr67fvEPKmDTQfGz@sirena.org.uk>
 <CAGETcx-ToG1xAtKVuZqwQK7hvVbT+Q0J0m4oWVCtR55XiYqETQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <de79bf0e80138d91a5df5fe4a323e508@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+ Heiko]

Am 2022-07-02 00:28, schrieb Saravana Kannan:
> On Fri, Jul 1, 2022 at 2:16 AM Mark Brown <broonie@kernel.org> wrote:
>> 
>> On Thu, Jun 30, 2022 at 06:02:04PM -0700, Saravana Kannan wrote:
>> 
>> > The patch attached to that email will probably fix this issue. I
>> > haven't dealt with Kernel CI bot before. Is there a way to get it to
>> > test a patch?
>> 
>> It is but I don't have access to do that - either the lab owner
>> (Michael, CCed here) or Guillaume (also CCed) should be able to help
>> there.
> 
> I found a much simpler solution that I think should work. Snippet at
> the end of this email.
> https://lore.kernel.org/lkml/CAGETcx-fLAXnG+1S4MHJwg9t7O6jj6Mp+q25bh==C_Z1CLs-mg@mail.gmail.com/
> 
> I'm waiting for Alexander in that thread to give it a shot.
> 
> Michael/Guillaume, if you want to give it a shot too, that'll be nice 
> :)

Heiko will give it a try on his kontron-pitx-imx8m board.

-michael
