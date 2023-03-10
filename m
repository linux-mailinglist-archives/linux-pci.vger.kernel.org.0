Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC36B3983
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 10:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCJJCm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 04:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCJJBK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 04:01:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C8104920;
        Fri, 10 Mar 2023 00:56:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4457B6116E;
        Fri, 10 Mar 2023 08:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98640C433EF;
        Fri, 10 Mar 2023 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678438591;
        bh=C4lIEcYHbP1LRvSAoPOxUsnZofcU+ia3egoUMcOO+wo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nhdgVttWC1VdAmu3PGOfgyzJ9e+urOPw10MfMbIhXda6MSZ2Ur4hE0kHH9KN6sgal
         sRjZyACngza8mlKp/NGf+m6lccOeM51Q1yTyvVJpT3LYNXwQnfRJd8yOnL27Ysp7M+
         vIC2q8cKd5cXmIVqSzBp5HywLXX5B8TolPIZztCrv+/XEEYlmfTGCDNKDmOJ8pItnQ
         YXL18zzNam5y/qL/tXy+39jLcgSihwIDHVLh3MRS8wfDEwQZfZMPo3AieGKslPOa31
         5KfkI6IDtfS6fMlmU0ONC3IkVJ7bYOjHitcGvNehBT/wQwRLbCPF63BOwxP77Eqsyt
         X+80tajDaa4AQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1paYY9-00GXmV-3R;
        Fri, 10 Mar 2023 08:56:29 +0000
MIME-Version: 1.0
Date:   Fri, 10 Mar 2023 08:56:28 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Lucas Tanure <lucas.tanure@collabora.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel@collabora.com,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/7] irqchip/gic-v3: Add a DMA Non-Coherent flag
In-Reply-To: <20230310080518.78054-2-lucas.tanure@collabora.com>
References: <20230310080518.78054-1-lucas.tanure@collabora.com>
 <20230310080518.78054-2-lucas.tanure@collabora.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a43dee4ef0e72c393dea6ce924347f81@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lucas.tanure@collabora.com, vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de, tglx@linutronix.de, lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, wqu@suse.com, piotr.oniszczuk@gmail.com, pgwipeout@gmail.com, kever.yang@rock-chips.com, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kernel@collabora.com, robin.murphy@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-03-10 08:05, Lucas Tanure wrote:
> The GIC600 integration in RK356x, used in rk3588, doesn't support
> any of the shareability or cacheability attributes, and requires
> both values to be set to 0b00 for all the ITS and Redistributor
> tables.
> 
> This is loosely based on prior work from XiaoDong Huang and
> Peter Geis fixing this issue specifically for Rockchip 356x.

No.

If we are going to do *anything* about this thing, it is by
describing the actual topology. And it has to work for both DT
and ACPI.

Alternatively, this is an erratum.

         M.
-- 
Jazz is not dead. It just smells funny...
