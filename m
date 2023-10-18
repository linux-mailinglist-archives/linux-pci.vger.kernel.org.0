Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F405B7CE7E6
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 21:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjJRTkq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 15:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRTkp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 15:40:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC49AB
        for <linux-pci@vger.kernel.org>; Wed, 18 Oct 2023 12:40:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A266C433C8;
        Wed, 18 Oct 2023 19:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697658043;
        bh=AD3gKmA3hIb2CpgWMPjROlXy43PEK8I1C4nkD2KEPYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nXNtZvjSVJ0+N4K/wRvKKR32rNV4dUJoj3iX+UvQ+4bRlHwaBla5TvrVJIvbIkQb0
         icTKuw1pmSqwVqyA/IFL4IZvFawPotYbF5NGKi3okW92Uhyk2KY4GsbIXN82yLyZ4F
         5le9V2n8TTCJpMJBcSIGb6fXaH/pxga6Ofxz4zC1KJb7TZitsvWmLwMY5PrRgdNjnx
         r7q+Vm2X2zZ/4KjFHRb7jEKPO7a/IaxBAYZnpbMoHNrVmUjW0Rdewq/krANyk2wg7M
         I0WuRfcDRxp5qm/XXD7Eqyh5C+ErmRzr/UWV8YCzi87tJSaaLw+y4jD2yWYG1dnx1k
         sWFgfiPVZM0AA==
Date:   Wed, 18 Oct 2023 14:40:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, bhelgaas@google.com,
        alex.williamson@redhat.com, lukas@wunner.de, petrm@nvidia.com,
        jiri@nvidia.com, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 04/12] PCI: Add no PM reset quirk for NVIDIA
 Spectrum devices
Message-ID: <20231018194041.GA1370549@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017074257.3389177-5-idosch@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 10:42:49AM +0300, Ido Schimmel wrote:
> Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a
> reset (i.e., they advertise NoSoftRst-). However, this transition seems
> to have no effect on the device: It continues to be operational and
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

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Hopefully since these are NVIDIA parts and you work at NVIDIA, this is
stronger than "this transition *seems* to have no effect" :)

The spec actually says NoSoftRst- means internal state is "undefined"
after a D3hot->D0 transition, so preserving it would not be a defect
per spec.  The kernel assumption that NoSoftRst- means the device will
do a reset is perhaps a little too aggressive.

> ---
>  drivers/pci/quirks.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..23f6bd2184e2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3784,6 +3784,19 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
>  			       PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
>  
> +/*
> + * Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a reset
> + * (i.e., they advertise NoSoftRst-). However, this transition seems to have no
> + * effect on the device: It continues to be operational and network ports
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
> 2.40.1
> 
