Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6882567A5AE
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 23:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjAXW2L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 17:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbjAXW2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 17:28:08 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FA2193C9;
        Tue, 24 Jan 2023 14:28:01 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5D12E739;
        Tue, 24 Jan 2023 22:27:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5D12E739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674599273; bh=MTaO760PJgYwDFixyQndXwkcxJ6qlGsTUp+EUcJgaCs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XW1biFoIP9a4rIRf2cLd3puFe2cCFrQPnLjCIkaYxizp+J6e+ypbS83QROQV7RjZL
         x+AsBikpA3Vkk3ujbg62UV6QrSznWRdtlGR3w9N1P6p5SjPTaB1VvvVuFhl7bYnzao
         e+Pb9bvOHC00Tv7pEsztMhT9Z72Gat9MaqdsTs8TiPqfNYcDgG/+/KR+sn5dVczsue
         lu1v1+vuz/4hzlpLBA+KYbHbvLOlZ4/b/+Fc8THgu2Xt0YT87foyxCIQE79oboIidh
         ZhOk8JFsQO6mPuPHLHgprow+Ki52f77LDa52ffGAHq1nhkgYRnJAeU48pOJekm2FoI
         ARNZkhtCcl3AQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, openbmc@lists.ozlabs.org,
        alsa-devel@alsa-project.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Docs/subsystem-apis: Remove '[The ]Linux'
 prefixes from titles of listed documents
In-Reply-To: <20230122184834.181977-1-sj@kernel.org>
References: <20230122184834.181977-1-sj@kernel.org>
Date:   Tue, 24 Jan 2023 15:27:52 -0700
Message-ID: <87edrjftzr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SeongJae Park <sj@kernel.org> writes:

> Some documents that listed on subsystem-apis have 'Linux' or 'The Linux'
> title prefixes.  It's duplicated information, and makes finding the
> document of interest with human eyes not easy.  Remove the prefixes from
> the titles.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> Changes from v1
> (https://lore.kernel.org/lkml/20230114194741.115855-1-sj@kernel.org/)
> - Drop second patch (will post later for each subsystem)
>
>  Documentation/PCI/index.rst        | 6 +++---
>  Documentation/cpu-freq/index.rst   | 6 +++---
>  Documentation/crypto/index.rst     | 6 +++---
>  Documentation/driver-api/index.rst | 6 +++---
>  Documentation/gpu/index.rst        | 6 +++---
>  Documentation/hwmon/index.rst      | 6 +++---
>  Documentation/input/index.rst      | 6 +++---
>  Documentation/mm/index.rst         | 6 +++---
>  Documentation/peci/index.rst       | 6 +++---
>  Documentation/scheduler/index.rst  | 6 +++---
>  Documentation/scsi/index.rst       | 6 +++---
>  Documentation/sound/index.rst      | 6 +++---
>  Documentation/virt/index.rst       | 6 +++---
>  Documentation/watchdog/index.rst   | 6 +++---
>  14 files changed, 42 insertions(+), 42 deletions(-)

Applied, thanks.

jon
