Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C559051F81B
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 11:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiEIJav (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 05:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbiEIIzy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 04:55:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F17013F1E7;
        Mon,  9 May 2022 01:52:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652086318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F47FNB3UPmZkk3XgxnsY0dE6OJ5OY97nItlGqfv1nig=;
        b=MUrIGsX15rb+saRCqWwo7fGrHKkoPeYHsfDkuifsddStxXPK7vpsFeXPM+uJpMeqTJfiX0
        1wfvYcDEWGBYWqqS9x0s9UYuvpdoshqHwuPmU5LVr55f8b5tQdqSd7PhzQVd7JLteNO3Kp
        FZvdIIC4eE8GPD/RyItmNBom9EfEdBzWqZ/8FbxDmn3PRSy9tZD/10LWUQwVO199DbUjVA
        sGJhjPZheZFhX2UkM/V24VEiyCISV6tGDKc0/MzMrrUXEA8lD4rR1vwuUZK2ToZS4+FOMP
        6gx92yX0NOydhaxgBz9mOjrjjTnasPwhFwIlo6ru1SJHYaZ2YEH2lPPrPhqaaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652086318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F47FNB3UPmZkk3XgxnsY0dE6OJ5OY97nItlGqfv1nig=;
        b=25QTTNR1gr/qNxOFt4KgxJmy+X+P9qgMg06xzXZUPudpM6mbF6bIcMMOloHobP2e4k15Ss
        /FpS5Oy7H07w/4BQ==
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/6] irqchip/armada-370-xp: Implement SoC Error interrupts
In-Reply-To: <20220506185546.n5rl3chyyauy4bjt@pali>
References: <20220506134029.21470-1-pali@kernel.org>
 <20220506134029.21470-3-pali@kernel.org> <87mtfu7ccd.wl-maz@kernel.org>
 <20220506183051.wimo7p4nuqfnl2aj@pali> <8735hmijlu.wl-maz@kernel.org>
 <20220506185546.n5rl3chyyauy4bjt@pali>
Date:   Mon, 09 May 2022 10:51:57 +0200
Message-ID: <87sfpjytoy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Pali,

On Fri, May 06 2022 at 20:55, Pali Roh=C3=A1r wrote:
> On Friday 06 May 2022 19:47:25 Marc Zyngier wrote:
>> > I'm not rewriting driver or doing big refactor of it, as this is not in
>> > the scope of the PCIe AER interrupt support.
>>
>> Fair enough. By the same logic, I'm not taking any change to the
>> driver until it is put in a better shape. Your call.
>
> If you are maintainer of this code then it is expected from _you_ to
> move the current code into _better shape_ as you wrote and expect. And
> then show us exactly, how new changes in this driver should look like,
> in examples.

this is not how kernel development works.

Maintainers are not the servants who mop up the mess which random people
dump into the tree. They are gatekeepers and one of their duties is to
prevent that mess is created or existing mess is proliferated.

You are asking the maintainer to take your changes, deal with the
fallout and maintain them for a long time free of charge. So it's a very
reasonable request from a maintainer to ask for refactoring of existing
code before adding new functionality to it.

With such a request the refactoring becomes scope of your work, whether
you and your manager like it or not. If you don't want to do that extra
work, then don't expect maintainers to care about your fancy new
features.

Marc gave you very reasonable and consice directions how the code should
be reworked. He spent a lot of time explaining it to you. Again, free of
charge. Now you expect him to do your homework free of charge, so you
can get your feature merged? Nice try.

Thanks,

        Thomas
