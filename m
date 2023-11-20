Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9ED7F0B64
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 05:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjKTE0m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Nov 2023 23:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTE0l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Nov 2023 23:26:41 -0500
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Nov 2023 20:26:36 PST
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6199F;
        Sun, 19 Nov 2023 20:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
        bh=PF8OjO8c7erf1om3rhrjk7pSuZlvp3jAiSRCfEz0K14=; b=hTQ/+wown69y+zfD5Kfn0m1xcf
        +GIGSHtANnev5XxSBf4rJRb9b0JqDxuaaqJF0X0SnSz6wQbF0ilbYxGR7/rN32EUwIYV3pwmMDmLO
        WvaYMMMQd8iDHG+K7DW/c21dLA+RyV2Cj0e7OM5eftRJfnkQD3njD67Epncc+uWBND1n6Y0qdVmOT
        lBqc95uKQvkPeft8zzQ5cNhFaAkZVQhN57tZHgJFaRujeoE4yRth9NZPyC+BFRhql5B60qZsSzBrr
        BRmNpd7qGwuH0N4BH7zgVAQCV5lo63Dlr4GCK3POWJH2qzZuzIQ1T7oHLYzadcIqwxp/vt8hDWKwH
        I4CnEyPg==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <tom@tom-fitzhenry.me.uk>)
        id 1r4vjj-00BoLo-LQ; Mon, 20 Nov 2023 04:18:16 +0000
User-agent: mu4e 1.10.8; emacs 29.1
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     vincenzopalazzodev@gmail.com
Cc:     bhelgaas@google.com, broonie@kernel.org, heiko@sntech.de,
        kw@linux.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, lpieralisi@kernel.org,
        robh@kernel.org, shawn.lin@rock-chips.com,
        skhan@linuxfoundation.org, strit@manjaro.org
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
In-Reply-To: <20230509153912.515218-1-vincenzopalazzodev@gmail.com>
Date:   Mon, 20 Nov 2023 15:15:30 +1100
Message-ID: <87a5r983ea.fsf@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-BlackCat-Spam-Score: 0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

My RockPro64 occasionally failed on boot with this crash dump, at least
since Linux 5.15. Since Linux 6.5, every boot fails in this manner.

I applied a similar patch[0] against Linux 6.6 that sleeps during probe,
and I'm now able to boot successfully each time.

0. https://gitlab.manjaro.org/manjaro-arm/packages/core/linux/-/blob/44e81d83b7e002e9955ac3c54e276218dc9ac76d/1005-rk3399-rp64-pcie-Reimplement-rockchip-PCIe-bus-scan-delay.patch
