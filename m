Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC86D1BD0C1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 01:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgD1XzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 19:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgD1XzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2020 19:55:24 -0400
Received: from mail.nic.cz (lists.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAE7C03C1AC
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2020 16:55:24 -0700 (PDT)
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 3EA0E142962;
        Wed, 29 Apr 2020 01:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1588118120; bh=56wYYB7dDi9LuSOaD5dYYC5MbwzP1EOWsBZzio7ZklU=;
        h=Date:From:To;
        b=tHB9rxB5r8BkFYTsrKTviEnfoCqEYZ+ZZn9Lzuvq9MSLyFk5UdQBxj855KMdmDwHq
         y88TotItWDvkU4oYTwNgefTYXFHUEVaf/ZuqAedVsyrfj6lUrHpQJAvRk/mBgtxgmE
         ujxJDmMpSkC8f2m3LavREv2jnZQNSDMLyOrwfdJE=
Date:   Wed, 29 Apr 2020 01:55:19 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 03/12] PCI: of: Return -ENOENT if max-link-speed
 property is not found
Message-ID: <20200429015519.7c8b71be@nic.cz>
In-Reply-To: <20200428160128.j36kbt73vbsk4b46@pali>
References: <20200424153858.29744-1-pali@kernel.org>
        <20200424153858.29744-4-pali@kernel.org>
        <CAL_JsqK6c0y4THRkBgmRtePKjqaV66ROEogRQNhcPP8yWWvbuA@mail.gmail.com>
        <20200427090032.yb5d6hhosofua46x@pali>
        <CAL_JsqLmL+HE7PQYaM-u2SNCNJu00XMLUzgoRtcqLesO-M92yQ@mail.gmail.com>
        <20200428160128.j36kbt73vbsk4b46@pali>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 28 Apr 2020 18:01:28 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> > How would you have an error? Your DT has a schema to check it, right?
> > (Hint: convert your binding) =20
>=20
> Schema is currently defined as human readable text file. So checking is
> possible but only manually.

I think that's what Rob meant by "Hint: convert your binding", that we
should convert the pci-aardvardk dt binding to yaml.
