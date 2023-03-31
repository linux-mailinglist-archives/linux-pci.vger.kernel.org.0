Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23F6D21D2
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 15:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjCaNz7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 09:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjCaNz6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 09:55:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF14209;
        Fri, 31 Mar 2023 06:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0510FB82E8F;
        Fri, 31 Mar 2023 13:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C89C433EF;
        Fri, 31 Mar 2023 13:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680270950;
        bh=AY4Vj7brLyfc8mcHlnnDPBFL372vQ2K2Eu+eeiVFgEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mn5KEzt/zCHEHjmI1CMRw3yZ1ctrvM5Ac8vZBVgsk8xYO60grS+Q2I7AfPIAtkWtf
         SW/1CgV9R5XYxmRjAP8xCBQsIUatgHNh6CSQJECXrKCkxt9cDwyt+xhPcAQ5op9ZPY
         NrppV+jiIEyWVYgQWEvPjDFX1tfkt2ejAOFNJwQLxVAqM38NpRw4EUwTWBCXQQKQpa
         9QnqmvSgyyWWtRLCzG6iicIQmTrYGbkJYkh70Na/atT5F1lh5rSv6JHmgTvhMzSUX0
         MUah5n6UGpei2jSCDxPvlVkE+uoaq8KUyCk+r9PQiEZQtiBm9lkZCUScsnukO70UsM
         2GUra5cMhUKvQ==
Date:   Fri, 31 Mar 2023 19:25:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lucas Tanure <lucas.tanure@collabora.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv2 0/3] Add PCIe2 driver support for Rockchip
Message-ID: <ZCbmYqvRTRbKw8wj@matsya>
References: <20230314135555.44162-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314135555.44162-1-lucas.tanure@collabora.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14-03-23, 13:55, Lucas Tanure wrote:
> I am assisting with PCIe and networking bring-up for Rock Pi 5B (RK3588).
> We sent this series a few days ago:
> https://lore.kernel.org/all/20230310080518.78054-1-lucas.tanure@collabora.com/
> 
> >From that conversation we decided to send patches for Rockchip that don't
> require GIC/ITS implementation. We will send that in a separed series.
> Making easier for reviews and unblocking patches that don't require
> GIC/ITS implementation.
> 
> This is work based on prior work from XiaoDong Huang and
> Peter Geis fixing this issue specifically for Rockchip 356x.
> Plus comments of Robin Murphy about Non-Coherent properties.

Applied, thanks

-- 
~Vinod
