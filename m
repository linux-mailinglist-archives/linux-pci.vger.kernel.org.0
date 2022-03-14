Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CC44D8C9F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 20:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbiCNToN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 15:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242632AbiCNToK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 15:44:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8175D140AE;
        Mon, 14 Mar 2022 12:42:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0D7AB80F79;
        Mon, 14 Mar 2022 19:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B83C340E9;
        Mon, 14 Mar 2022 19:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647286975;
        bh=T+QpWCtYV8reizq0fYMHhwsVHRCeIp0TbwXXvGhjNnw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FCJ7MK7M70y/GMBTD3D8cIxOlVmH02z+fUKmkJZW7lCzhe+7xfGXIXmlAtS/noGYD
         R1k52pXbbkgB0vPrCVRs8o1Ga0bCxv1lRCm8R04kFGq91k0gUKlv1i7Ma6xQIm+/2d
         jHsnEh0IqqAQWLjaRnVQ/NkDdVwr95YGwApBbuZFL5n4BeL2jJ754euDN70W9RDh3d
         JrTObi0pffXd6Jf6yeMmnGWHgcz7NAbZ0RSzBLWpuzwild8JtlHJhhlH/20ilLCS05
         jdOMypmL97LHzRVA8vAZlXr7RhCn9cD4V78leE+IWYxHzG6/RKCbyaCnLpcrGo4B3D
         wmx2Wx2ACj0PQ==
Date:   Mon, 14 Mar 2022 14:42:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, micklorain@protonmail.com
Subject: Re: [PATCH v1 1/1] PCI: Enable INTx quirk for ATI PCIe-USB adapter
Message-ID: <20220314194253.GA515821@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314101448.90074-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 14, 2022 at 12:14:48PM +0200, Andy Shevchenko wrote:
> ATI PCIe-USB adapter advertises MSI, but it doesn't work if INTx is disabled.
> Enable the respective quirk as it's done for other ATI devices on this chipset,
> 
> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")

This is interesting because there must be a TON of these AMD/ATI SB600
USB devices in the field, and 306c54d0edb6 was merged in July 2020 and
appeared in v5.9.

So why would we only get a report now, in February 2022?  Is there
some change more recent than 306c54d0edb6 that exposed this problem?

> BugLink: https://lore.kernel.org/all/20200702143045.23429-1-andriy.shevchenko@linux.intel.com/
> Reported-by: micklorain@protonmail.com
> Tested-by: micklorain@protonmail.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/quirks.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 65f7f6b0576c..cc6a87a32b62 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3041,6 +3041,13 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
>  			PCI_DEVICE_ID_TIGON3_5715S,
>  			quirk_msi_intx_disable_bug);
>  
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4386, quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4387, quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4388, quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4389, quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438a, quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438b, quirk_msi_intx_disable_bug);
> +
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4390,
>  			quirk_msi_intx_disable_ati_bug);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4391,
> -- 
> 2.35.1
> 
