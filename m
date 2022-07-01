Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA5563C69
	for <lists+linux-pci@lfdr.de>; Sat,  2 Jul 2022 00:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiGAWej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 18:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiGAWei (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 18:34:38 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C544B286FA;
        Fri,  1 Jul 2022 15:34:34 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-43-113-134.web.vodafone.de [109.43.113.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6F54F22239;
        Sat,  2 Jul 2022 00:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656714872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvSjY/1JTiP3TXChtqGONc3eG2xsPyhV6OUlpsTopfY=;
        b=Fi9PJIhOWOyEixkJNFWqqJp4TIfeEHYh8bfDLQya+6WOOYh0kd1RdNQg0ACD335XotuWr/
        v+FVwSMegCVrgtPQTC5fKXB9VEpyTpPfJyeXBDaOL2hBFzq5cjqU1vcpf4yoqf1PyFz9HT
        k/8IE8F9YGlWfZmb63xNk006xN5DfQk=
Date:   Sat, 02 Jul 2022 00:34:29 +0200
From:   Michael Walle <michael@walle.cc>
To:     Saravana Kannan <saravanak@google.com>,
        Mark Brown <broonie@kernel.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_next/master_bisection=3A_baseline=2Ebootrr=2Ei?= =?US-ASCII?Q?mx6q-pcie-pcie0-probed_on_kontron-pitx-imx8m?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGETcx-ToG1xAtKVuZqwQK7hvVbT+Q0J0m4oWVCtR55XiYqETQ@mail.gmail.com>
References: <62bdec26.1c69fb81.46bc5.2d67@mx.google.com> <Yr3vEDDulZj1Dplv@sirena.org.uk> <CAGETcx88M3Use8crFMTU=By3UVjjaJuP1_Ah7zsy_w=pNxc+6w@mail.gmail.com> <CAGETcx_s+ui9wWA7OawojPbY95bLZE5pSmpK-34_kLZTzjf9Ew@mail.gmail.com> <Yr67fvEPKmDTQfGz@sirena.org.uk> <CAGETcx-ToG1xAtKVuZqwQK7hvVbT+Q0J0m4oWVCtR55XiYqETQ@mail.gmail.com>
Message-ID: <BF02D8CE-877F-4533-AE4F-3C2E19E132B9@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2=2E Juli 2022 00:28:58 MESZ schrieb Saravana Kannan <saravanak@google=
=2Ecom>:
>On Fri, Jul 1, 2022 at 2:16 AM Mark Brown <broonie@kernel=2Eorg> wrote:
>>
>> On Thu, Jun 30, 2022 at 06:02:04PM -0700, Saravana Kannan wrote:
>>
>> > The patch attached to that email will probably fix this issue=2E I
>> > haven't dealt with Kernel CI bot before=2E Is there a way to get it t=
o
>> > test a patch?
>>
>> It is but I don't have access to do that - either the lab owner
>> (Michael, CCed here) or Guillaume (also CCed) should be able to help
>> there=2E
>
>I found a much simpler solution that I think should work=2E Snippet at
>the end of this email=2E
>https://lore=2Ekernel=2Eorg/lkml/CAGETcx-fLAXnG+1S4MHJwg9t7O6jj6Mp+q25bh=
=3D=3DC_Z1CLs-mg@mail=2Egmail=2Ecom/
>
>I'm waiting for Alexander in that thread to give it a shot=2E
>
>Michael/Guillaume, if you want to give it a shot too, that'll be nice :)
>
>Thanks,
>Saravana

Hi,

can do on Monday as I'm currently on the road without any real internet ac=
cess nor laptop=2E

-michael 
