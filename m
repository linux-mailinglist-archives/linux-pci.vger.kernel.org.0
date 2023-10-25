Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D117D78F2
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 01:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjJYXwF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 19:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbjJYXup (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 19:50:45 -0400
X-Greylist: delayed 591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 16:50:10 PDT
Received: from psionic.psi5.com (psionic.psi5.com [IPv6:2a02:c206:3008:6895::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2DC182
        for <linux-pci@vger.kernel.org>; Wed, 25 Oct 2023 16:50:10 -0700 (PDT)
Received: from [IPV6:2400:2410:b120:f200:8de:445b:204d:c308] (unknown [IPv6:2400:2410:b120:f200:8de:445b:204d:c308])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by psionic.psi5.com (Postfix) with ESMTPSA id 6D0483F10A;
        Thu, 26 Oct 2023 01:40:08 +0200 (CEST)
Message-ID: <7bf7628c-9d92-4c87-86db-b60c272f59be@debian.org>
Date:   Thu, 26 Oct 2023 08:40:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Enabling PCI_P2PDMA for distro kernels?
To:     Lukas Wunner <lukas@wunner.de>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Richter <sjr@debian.org>, 1015871@bugs.debian.org,
        linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Emanuele Rocca <ema@debian.org>
References: <20231025061927.smn5xnwpkasctpn7@pengutronix.de>
 <b909a5e6-841a-44e4-a21f-e3cddbf71816@deltatee.com>
 <20231025171126.GA9661@wunner.de>
Content-Language: en-US
From:   Simon Richter <sjr@debian.org>
In-Reply-To: <20231025171126.GA9661@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/26/23 02:11, Lukas Wunner wrote:

> This has recently been brought up internally at Intel and nobody could
> understand why there's a whitelist in the first place.  A long-time PCI
> architect told me that Intel silicon validation has been testing P2PDMA
> at least since the Lindenhurst days, i.e. since 2005.

My PCIe test box generates URE completions in the root complex when I 
try to address iGPU BARs from an FPGA, and texture fetches from the iGPU 
that use BAR addresses on the FPGA do not get forwarded (so I venture 
that is an URE as well).

CPU:  i3-3225 CPU @ 3.30GHz (fam: 06, model: 3a, stepping: 09)

pci 0000:00:00.0: [8086:0150] type 00 class 0x060000
pci 0000:00:01.0: [8086:0151] type 01 class 0x060400
pci 0000:00:02.0: [8086:0162] type 00 class 0x030000
pci 0000:00:14.0: [8086:1e31] type 00 class 0x0c0330
pci 0000:00:16.0: [8086:1e3a] type 00 class 0x078000
pci 0000:00:1a.0: [8086:1e2d] type 00 class 0x0c0320
pci 0000:00:1b.0: [8086:1e20] type 00 class 0x040300
pci 0000:00:1c.0: [8086:1e10] type 01 class 0x060400
pci 0000:00:1c.4: [8086:1e18] type 01 class 0x060400
pci 0000:00:1d.0: [8086:1e26] type 00 class 0x0c0320
pci 0000:00:1f.0: [8086:1e4a] type 00 class 0x060100
pci 0000:00:1f.2: [8086:1e00] type 00 class 0x01018f
pci 0000:00:1f.3: [8086:1e22] type 00 class 0x0c0500
pci 0000:00:1f.5: [8086:1e08] type 00 class 0x010185
pci 0000:01:00.0: [1172:1337] type 00 class 0xff0000
pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000

So there is at least one configuration that doesn't work. :P

    Simon
