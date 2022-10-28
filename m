Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A756110F0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 14:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ1MN1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 08:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJ1MN1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 08:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C0DD3A6;
        Fri, 28 Oct 2022 05:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4185262406;
        Fri, 28 Oct 2022 12:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA3DC433D6;
        Fri, 28 Oct 2022 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666959205;
        bh=ljENQ8jydh0IcG06Xm/fdMGM4Az0YuRelUKmmofFzjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Plm1piARSo7IubRh36oP78LkgH4juDqvMHiWDWGE7asHDeRamzm0Gku59kcSFbUJK
         gSx30rrHdMUXu+6e0DqZU1POvpBAf+T1QbsZEan60w5zzWXQ7tQUTK+QvtYi93Ks4o
         a+eldyaB8d06aqy94fAv4IQ+j8pU3TvRWKZ0LV1+IVEP3F8OBhj2K2X6oFRagOw3uQ
         7n2RLV9EyzjSmxQUcPShLljXPkkjleE/KqtmrsTtBxRSAz3lrtG3twbKN9vXZWFhG+
         sIhqd1Mz4HMNDLtmReFJMx4LcJhqNp1cqyLzj9OfqgLXpHyY6/0GSwYhUhIzE4tvhG
         k5zRn+3P7eeMg==
Date:   Fri, 28 Oct 2022 17:43:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, ffclaire1224@gmail.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 08/21] phy: tegra: p2u: Set ENABLE_L2_EXIT_RATE_CHANGE
 in calibration
Message-ID: <Y1vHYduw4CQl5ssA@matsya>
References: <20221013183854.21087-1-vidyas@nvidia.com>
 <20221013183854.21087-9-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013183854.21087-9-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14-10-22, 00:08, Vidya Sagar wrote:
> Set ENABLE_L2_EXIT_RATE_CHANGE register bit to request UPHY PLL rate change
> to Gen1 during initialization. This helps in the below surprise link down
> cases,
>   - Surprise link down happens at Gen3/Gen4 link speed.
>   - Surprise link down happens and external REFCLK is cut off, which causes
> UPHY PLL rate to deviate to an invalid rate.

Applied, thanks

-- 
~Vinod
