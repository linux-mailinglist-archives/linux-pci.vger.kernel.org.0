Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8957A7EF515
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 16:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjKQPWF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 10:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQPWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 10:22:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2F7A6
        for <linux-pci@vger.kernel.org>; Fri, 17 Nov 2023 07:22:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F375C433C8;
        Fri, 17 Nov 2023 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700234521;
        bh=0UKK8vTWjk/9aVzqK03YhqWQKTuR75Y8DkzQmVwxWoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CImgoJobDMWJ6+MtgLWIjxjvgnigKXjCQwc2Vfr0w1tvSdTSHBmx82IY7ZNu92nkS
         ZwY4eOE80dzJ258usPi24YPFY/HfRJ/Aq8cbcR9qwA/ZEuJpJWwK9VHdrVBFpULTsu
         yJR6P6iAZDx3kjjYnC8CmU6ycCD37Basr4FxqUkUg0Dh2/quOB+cYjYt/EWIGoRayU
         gqhCy5d20JtyvL4DhMmgvPx9DXQEzXCQua0+S5TFAqPbYzS+PS0btDYw/QIfEzxqC8
         LgNukoEGc/q3RiIzA1YBmWpKLzCdo2QUS3jNZC/GVw/l6JR7ajvxel9Iclbnf47SLC
         vDLccIe/IHX4A==
Date:   Fri, 17 Nov 2023 15:21:56 +0000
From:   Simon Horman <horms@kernel.org>
To:     Petr Machata <petrm@nvidia.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Ido Schimmel <idosch@nvidia.com>,
        Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 07/14] PCI: Add no PM reset quirk for NVIDIA
 Spectrum devices
Message-ID: <20231117152156.GB164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <fe4156c6b9d0f7e8478ae93137586ec88051013d.1700047319.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4156c6b9d0f7e8478ae93137586ec88051013d.1700047319.git.petrm@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ linux-pci@vger.kernel.org

On Wed, Nov 15, 2023 at 01:17:16PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a
> reset (i.e., they advertise NoSoftRst-). However, this transition does
> not have any effect on the device: It continues to be operational and
> network ports remain up. Advertising this support makes it seem as if a
> PM reset is viable for these devices. Mark it as unavailable to skip it
> when testing reset methods.
> 
> Before:
> 
>  # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
>  pm bus
> 
> After:
> 
>  # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
>  bus
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Thanks,

my understanding is that this matches the use-case for which
quirk_no_pm_reset was introduced.

> ---
>  drivers/pci/quirks.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ea476252280a..d208047d1b8f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3786,6 +3786,19 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
>  			       PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
>  
> +/*
> + * Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a reset
> + * (i.e., they advertise NoSoftRst-). However, this transition does not have
> + * any effect on the device: It continues to be operational and network ports
> + * remain up. Advertising this support makes it seem as if a PM reset is viable
> + * for these devices. Mark it as unavailable to skip it when testing reset
> + * methods.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcb84, quirk_no_pm_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf6c, quirk_no_pm_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf70, quirk_no_pm_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf80, quirk_no_pm_reset);
> +
>  /*
>   * Thunderbolt controllers with broken MSI hotplug signaling:
>   * Entire 1st generation (Light Ridge, Eagle Ridge, Light Peak) and part
> -- 
> 2.41.0
> 
