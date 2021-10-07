Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0DC4256D8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbhJGPpk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhJGPpj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 11:45:39 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7265C061570
        for <linux-pci@vger.kernel.org>; Thu,  7 Oct 2021 08:43:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C74BB3FA60;
        Thu,  7 Oct 2021 15:43:36 +0000 (UTC)
Subject: Re: [PATCH v5 00/14] PCI: Add support for Apple M1
To:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Android Kernel Team <kernel-team@android.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210929163847.2807812-1-maz@kernel.org>
 <20211004083845.GA22336@lpieralisi> <87czolrwgn.wl-maz@kernel.org>
 <CACRpkdZzdzJmatnYe2pcKCSW2=WJBa-DZQPib7aGW9m_GLrAwg@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <d9491159-670b-87c6-65b4-10f7c7ba62fe@marcan.st>
Date:   Fri, 8 Oct 2021 00:43:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZzdzJmatnYe2pcKCSW2=WJBa-DZQPib7aGW9m_GLrAwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/10/2021 03.30, Linus Walleij wrote:
> On Mon, Oct 4, 2021 at 11:05 AM Marc Zyngier <maz@kernel.org> wrote:
> 
>> Yes, that's absolutely fine. I hope we can resolve the issue on the
>> pinctrl binding pretty quickly, and get the arm-soc folks to pull the
>> DT changes in for 5.16 too.
> 
> I think I ACKed a patch for apple,npins = <> yesterday.

You reviewed it :)

It still needs some fixes to pass the schema linter though.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
