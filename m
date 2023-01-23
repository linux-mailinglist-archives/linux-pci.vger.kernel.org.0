Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB46787E2
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 21:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjAWUej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 15:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAWUeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 15:34:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF0E04C;
        Mon, 23 Jan 2023 12:34:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E28661026;
        Mon, 23 Jan 2023 20:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795F8C433EF;
        Mon, 23 Jan 2023 20:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674506075;
        bh=FmnPLtlEEZLnIMIwawfGix9wzSwjvgWL7c11CtPG7VM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gF5F3tETTnRMP1JPBnu7Ptp/If+nrlkHmh1UvayGFWUyXYmpvpFIlY+pg0zyr7IvH
         EVxJOqmXmJX4Qp/NQU69I9zkedvW44RZCoOXej3wWBme0Mdka7wWgcqiXHBS0ZO9AT
         gCCeJ5Uq2QZnfqQa2fxLrDKyt14RL6D7czuJJnAOpLLNhbfPWA+yt32/GYape34E4O
         F5mvBPdKOsbsv8biqPPZmtLiy9WobD+Fa+Nr4SCWtPIUvLRWLgmYTlf3NVqXtdDuWD
         rOx+KcDSyNsyRQHtz5q6KnNbBnT517gw8xLmWe7kphfoQ/6r8WJFEAIN5ITvVAGWH0
         7e32wlfHKB2Xw==
Date:   Mon, 23 Jan 2023 14:34:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>,
        linux-mm@kvack.org, linux-watchdog@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        openbmc@lists.ozlabs.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-hwmon@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 1/1] Docs/subsystem-apis: Remove '[The ]Linux'
 prefixes from titles of listed documents
Message-ID: <20230123203434.GA979965@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230122184834.181977-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 22, 2023 at 06:48:34PM +0000, SeongJae Park wrote:
> Some documents that listed on subsystem-apis have 'Linux' or 'The Linux'
> title prefixes.  It's duplicated information, and makes finding the
> document of interest with human eyes not easy.  Remove the prefixes from
> the titles.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

PCI/index.rst change is fine with me:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

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
> 
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index c17c87af1968..e73f84aebde3 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -=======================
> -Linux PCI Bus Subsystem
> -=======================
> +=================
> +PCI Bus Subsystem
> +=================
>  
>  .. toctree::
>     :maxdepth: 2
