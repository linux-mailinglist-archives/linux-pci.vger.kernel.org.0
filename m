Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E67457E50A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiGVRGa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 13:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiGVRGX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 13:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DBE9D1C3;
        Fri, 22 Jul 2022 10:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27EEC6223E;
        Fri, 22 Jul 2022 17:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C96C341C7;
        Fri, 22 Jul 2022 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658509570;
        bh=q9la5Pvkt4nvHLS1zli7k8bQETXq8yt10kCwXoUYLcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q0ETLucHjS9Gc5A0eSD5K5DB/4bdru/hjNjP7etHFwFE2n3lrTtR+6YzJaMtGgBIY
         PxSwBV2N4qE4Es8YTliTXdpqlOpskH11cWbtjao0QrLp0TU8SpWWs5zCx7YF7o0G6l
         VSIl6NtNXtFOW1WifbcY9Cbytx5JQl2ZcD8zWHBKOrt5jnjQYq78MqgbHOiPGIgsId
         95mV6piYD8YOhQbWBUF/4Az7QRCZRR8dBKmxilebwjxlrdZadFOVyauy/53oSb0E2b
         6FM5NJAiU+IS9A9BR+oo82+9wnFBWMgm5421ua6B0mYidEc0i69zwG4QHD7T6R3E9Q
         gESv7d/Fc+xWA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oEw6K-009O4D-A3;
        Fri, 22 Jul 2022 18:06:08 +0100
Date:   Fri, 22 Jul 2022 18:06:07 +0100
Message-ID: <87k085xekg.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
In-Reply-To: <20220722143905.GA1818909@bhelgaas>
References: <20220721222122.GA1754784@bhelgaas>
        <20220722143905.GA1818909@bhelgaas>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: helgaas@kernel.org, pali@kernel.org, johan+linaro@kernel.org, kishon@ti.com, songxiaowei@hisilicon.com, wangbinghui@hisilicon.com, thierry.reding@gmail.com, ryder.lee@mediatek.com, jianjun.wang@mediatek.com, linux-pci@vger.kernel.org, kw@linux.com, ley.foon.tan@intel.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, 22 Jul 2022 15:39:05 +0100,
Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> [+cc Marc, can you clarify when we need irq_dispose_mapping()?]

In general, interrupt controllers should not have to discard mappings
themselves, just like they rarely create mappings themselves. That's
usually a different layer that has created it (DT, for example).

The problem is that these mappings persist even if the interrupt has
been released by the driver (it called free_irq()), and the IRQ number
can be further reused. The client driver could dispose of the mapping
after having released the IRQ, but nobody does that in practice.

=46rom the point of view of the controller, there is no simple way to
tell when an interrupt is "unused". And even if a driver was
overzealous and called irq_dispose_mapping() on all the possible
mappings (and made sure no mapping could be created in parallel), this
could result in a bunch of dangling pointers should a client driver
still have the interrupt requested.

Fixing this is pretty hard, as IRQ descriptors are leaky (you can
either have a pointer to one, or just an IRQ number -- they are
strictly equivalent). So in general, being able to remove an interrupt
controller driver is at best fragile, and I'm trying not to get more
of this in the tree.

Hope this helps,

	M.

--=20
Without deviation from the norm, progress is not possible.
