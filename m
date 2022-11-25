Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9F0638DBF
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 16:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKYPvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Nov 2022 10:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiKYPvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2022 10:51:18 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3357247329;
        Fri, 25 Nov 2022 07:51:13 -0800 (PST)
Received: (Authenticated sender: thomas.petazzoni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A50931BF203;
        Fri, 25 Nov 2022 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669391472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPaT39sAq6bB/8jycs8Qu4XNOLXdQXN9CIa8CNq+0DU=;
        b=d/iWI35QnhWrUQmu3eK7MTp+CL19nh+Yxmv+C3PgagomoCjafmL46X4+idl8P6GeM7d7W/
        IuyPuItiyYGPs6TsLADAGD0fSGx6to8UDVu3P9UK3lyMkSj/644Y+Y5bjxkZyDmYKd2Qga
        DUF4/VbHFuiaCTiZ0UHRpzPT1DjliCWV4/upp90Fv1szfz/rUHVVRGz1w5qZJuqmV8DlmS
        cNOkK0+d9366JLreDe2UDAfAZ62wxQCkvsA9I3ZhrdFmqD0kW5jtdEEkWlnU2CmcNCVjUK
        Fkf7YKCimzEimQEb0AaOSeczhQyCpHoJCRmyNQeq1OscLIz4gU7xdWoeIXLmHA==
Date:   Fri, 25 Nov 2022 16:51:09 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Elad Nachman <enachman@marvell.com>,
        Raz Adashi <raza@marvell.com>, Yuval Shaia <yshaia@marvell.com>
Subject: Re: [PATCH v2 2/3] PCI: armada8k: Add AC5 SoC support
Message-ID: <20221125165109.6059d3a5@windsurf>
In-Reply-To: <VI1P190MB03173DB0A16402C8AB670D91950E9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
References: <20221124135829.2551873-1-vadym.kochan@plvision.eu>
        <20221124135829.2551873-3-vadym.kochan@plvision.eu>
        <20221124155817.5f372417@windsurf>
        <VI1P190MB03173DB0A16402C8AB670D91950E9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Fri, 25 Nov 2022 08:43:06 +0000
Vadym Kochan <vadym.kochan@plvision.eu> wrote:

> [quote]
> this is not needed, as by the time Linux is loaded, link has already been established (by boot loaders)
> 
> So this code is not needed.
> [/quote]

Not ideal to rely on the bootloader for this sort of initialization,
and if we want to do this change, perhaps it should be done in another
patch.

But again, the fact that "it works for Marvell because their vendor
U-Boot does the right thing prior to loading Linux" is not really a
very solid argument to drop kernel code :-/

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
