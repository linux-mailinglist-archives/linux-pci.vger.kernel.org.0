Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC33F030D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 13:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhHRLxw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Aug 2021 07:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhHRLxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Aug 2021 07:53:51 -0400
X-Greylist: delayed 563 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Aug 2021 04:53:17 PDT
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC69C061764;
        Wed, 18 Aug 2021 04:53:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5889A41F72;
        Wed, 18 Aug 2021 11:43:50 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] PCI: apple: Add driver for the Apple M1
To:     Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
 <20210815042525.36878-3-alyssa@rosenzweig.io> <87a6lj17d1.wl-maz@kernel.org>
 <8650c850-2642-4582-ae97-a95134bda3e2@www.fastmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <092a2de3-6760-6398-e4de-2b24d30ac856@marcan.st>
Date:   Wed, 18 Aug 2021 20:43:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8650c850-2642-4582-ae97-a95134bda3e2@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/08/2021 21.33, Sven Peter wrote:
> The magic comes from the original Corellium driver. It first masks everything
> except for the interrupts in the next line, then acks the interrupts it keeps
> enabled and then probably wants to wait for PORT_INT_LINK_UP (or any of the
> other interrupts which seem to indicate various error conditions) to fire but
> instead polls for PORT_LINKSTS_UP.

Let's not take any magic numbers from their drivers (or what macOS does, 
for that matter) without making an attempt to understand what they do, 
unless it becomes clear it's incomprehensible. This has already bit us 
in the past (the SError disable thing).

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
