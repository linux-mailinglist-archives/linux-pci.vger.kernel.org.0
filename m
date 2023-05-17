Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B161C70661E
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 13:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjEQLG0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 07:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjEQLGK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 07:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491457A98;
        Wed, 17 May 2023 04:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 968976457B;
        Wed, 17 May 2023 11:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25507C4339C;
        Wed, 17 May 2023 11:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684321540;
        bh=Q72kVKGAqEzTgRn6ZNEGuvKnBS2ZxckUN41TA3GqR84=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FmP3GEO7SWi+Pb2HwSw3Wz2raaGTlyrfSH8A+80cKRGdWYw8WYLO309ufoiUT38tQ
         /SpSlpmEcAerb0UVvwmmi72UnBVO+Bi+u7H2rVQRl9D1Ourxu7gj/YLsSu8KtCy+YM
         kezchvkccrzPk0lUlDFHtotlzRuxOqYcNRQymdJlL6WodoLvz34fLJuCzuEdmedMh6
         NneC3fSVpvXBVlrFwCdlP7uAR8PMfNr6RWwYEOVz+CT8gg0Ws1dAihLyQ8zLRavbta
         +42Cse/M6+Xfb1KigOW65c4jcsHk1+qEJrd47jAJIyVQxX5+DrHbuVzu5yHGK4Micy
         VG8eZZ0piI9PA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Kazior <michal.kazior@tieto.com>,
        Janusz Dziedzic <janusz.dziedzic@tieto.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 9/9] wifi: ath10k: Use RMW accessors for changing LNKCTL
References: <20230517105235.29176-1-ilpo.jarvinen@linux.intel.com>
        <20230517105235.29176-10-ilpo.jarvinen@linux.intel.com>
Date:   Wed, 17 May 2023 14:05:33 +0300
In-Reply-To: <20230517105235.29176-10-ilpo.jarvinen@linux.intel.com> ("Ilpo
        \=\?utf-8\?Q\?J\=C3\=A4rvinen\=22's\?\= message of "Wed, 17 May 2023 13:52:35
 +0300")
Message-ID: <87sfbvkyki.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> Don't assume that only the driver would be accessing LNKCTL. ASPM
> policy changes can trigger write to LNKCTL outside of driver's control.
>
> Use RMW capability accessors which does proper locking to avoid losing
> concurrent updates to the register value. On restore, clear the ASPMC
> field properly.
>
> Fixes: 76d870ed09ab ("ath10k: enable ASPM")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org

Acked-by: Kalle Valo <kvalo@kernel.org>

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
