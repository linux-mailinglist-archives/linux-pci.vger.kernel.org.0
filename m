Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AC34B2FF2
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 22:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351975AbiBKV6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 16:58:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350580AbiBKV6a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 16:58:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E09AC71;
        Fri, 11 Feb 2022 13:58:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E56611C2;
        Fri, 11 Feb 2022 21:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEEDC340E9;
        Fri, 11 Feb 2022 21:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644616708;
        bh=oXg5rxwwUausbzZKfN+RufJo9Nkk/xAVMAtcyDF0/WM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fp310UIIKN84A4YeT/Tcs1AeYKNWTo+/UZPC+EFT2ECaEyXmPQeoqIdeoKjpu6ltu
         EdiV+R7W+4T2JxHH2CpEvNoy+XIyvSCvLD4F32wVza2+hjIjJyRSV+yfAcqxv6PARk
         lp5yk4vVHvnete5kHumveMBmLlEymdKtoT0GT3AvGMijPTwyIglClyyP+WSbRZFgF9
         +fpoZR8kv0a5lef7j0nkJpzXWfpoE7RneTVgkuZlRZHn6p2QaaRfK4znnmsC+uEnYM
         iY8KWMXSLfR5EdkXlIIPdUbhSJ8nhDUHhPcBOkj0f5l8q/wgvsfQ36/aJbk+axctcm
         W5JSlN40mF4XA==
Date:   Fri, 11 Feb 2022 15:58:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com,
        Andreas Noever <andreas.noever@gmail.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>
Subject: Re: [PATCH v3 06/12] PCI: Explicitly mark USB4 NHI devices as
 removable
Message-ID: <20220211215826.GA737975@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211193250.1904843-7-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 01:32:44PM -0600, Mario Limonciello wrote:
> USB4 class devices are also removable like Intel Thunderbolt devices.

Spec reference, please.

> Drivers of downstream devices use this information to declare functional
> differences in how the drivers perform by knowing that they are connected
> to an upstream TBT/USB4 port.
> 
> Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/probe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2693211d31cf..67ca33188cba 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1610,6 +1610,7 @@ static void pci_set_removable(struct pci_dev *dev)
>  	 * exposed as "removable" to userspace.
>  	 */
>  	if (vsec ||
> +	    dev->class == PCI_CLASS_SERIAL_USB_USB4 ||
>  	    pci_acpi_is_usb4(dev) ||
>  	    (parent &&
>  	    (parent->external_facing || dev_is_removable(&parent->dev))))
> -- 
> 2.34.1
> 
