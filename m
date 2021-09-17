Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BC440F611
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 12:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbhIQKoP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhIQKoP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Sep 2021 06:44:15 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A32C061574;
        Fri, 17 Sep 2021 03:42:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3658541E57;
        Fri, 17 Sep 2021 10:42:46 +0000 (UTC)
Subject: Re: [PATCH v3 04/10] PCI: apple: Add initial hardware bring-up
To:     Marc Zyngier <maz@kernel.org>, Sven Peter <sven@svenpeter.dev>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
References: <20210913182550.264165-1-maz@kernel.org>
 <20210913182550.264165-5-maz@kernel.org>
 <6eb53661-e11e-4634-9fa5-5e7e62d57a15@www.fastmail.com>
 <87lf3vblt6.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <9cf94456-d7ab-ac2b-fb12-019e40424793@marcan.st>
Date:   Fri, 17 Sep 2021 19:42:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87lf3vblt6.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17/09/2021 18.20, Marc Zyngier wrote:
> On Mon, 13 Sep 2021 21:48:47 +0100,
>> On Mon, Sep 13, 2021, at 20:25, Marc Zyngier wrote:
>>> +static inline void rmwl(u32 clr, u32 set, void __iomem *addr)
>>> +{
>>> +	writel_relaxed((readl_relaxed(addr) & ~clr) | set, addr);
>>> +}
>>
>> This helper is a bit strange, especially since it's always only used
>> with either clr != 0 or set != 0 but never (clr = 0 and set = 0) afaict.
>> Maybe create two instead for setting and clearing bits?
> 
> That's indeed nicer, and it makes the code more readable.

This seems to be a pattern in Corellium code; the cpufreq code is the 
same and I honestly found it quite hard to read when used for simple set 
or clear operations. I find set32/clear32 style helpers much more 
readable, so it's probably a good idea to make this change any time we 
upstream stuff derived from their tree.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
