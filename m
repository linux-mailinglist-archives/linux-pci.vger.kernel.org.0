Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3157284BB
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 18:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjFHQVL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjFHQVK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 12:21:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB18F11A
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 09:21:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E58764E7C
        for <linux-pci@vger.kernel.org>; Thu,  8 Jun 2023 16:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CDEC433EF;
        Thu,  8 Jun 2023 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686241267;
        bh=FHthtZffxCffCvm/Bs7ZlByPhsxAmcfpxghlBMAp83o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F+c5iUrTkQO4Kv7cL+bV8h1bjRc6GvCFitMoJpul0xHb8abesmRSBEKQT0FmdIGlL
         gerv4I5knjvvCIvPVkgHl+xZG8PVymiqIEFRkznBZbsat2Sdh8LvDjDDOoTVEWCHQT
         OqRmKZnV2/Ux1xwgkqYuYccot75RO8GDsPe7Gz6Wp7gqJn7HfvBdppnw/BfkqejhAR
         sGA7SLKfQ3DHYavOzBqLK/5/KVYOcdj4kuBniXFBnOVqSy4i6G3HUPW7eeFFxo+7JE
         oLbBLQ8P1eLJyz839OOosYz8esURaNUgextEueMXDVY3L3zyrexVwBnTNzFa3CtQlb
         Xawkqk6lzxjow==
Date:   Thu, 8 Jun 2023 11:21:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Dejean <dam.dejean@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: Old Asus doesn't seem to support MSI
Message-ID: <20230608162105.GA1195684@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02093788-DDD2-4CD7-A23D-00A3E92D089C@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

On Thu, Jun 08, 2023 at 09:57:32AM +0200, Damien Dejean wrote:
> Thanks for digging into this!
> 
> > It's also conceivable that MSI used to work in older kernels, but we
> > broke something by v5.10.  Do you know whether any old kernels ever
> > worked without "pci=nomsi”?
> 
> I remember trying older linux distributions (Debian oldstable,
> kernel 4.19) and some older Ubuntu(s) but I don’t remember any of
> them working. Plus, the Ubuntu wiki pages and various post replies
> to “… Linux is not working on my x73sl laptop” are always suggesting
> the pci=nomsi option, so I guess the problem exists since a while.

OK, more ideas:

1) Krzysztof found a slightly newer BIOS for your system [1].  It's
conceivable that could help.

2) If you happen to have Windows, AIDA64 [2] can tell us whether it
uses MSI.

3) I'm inclined to add the attached quirk, which disables MSI on any
machine with this chipset.  Should fix your ASUS X73SL, and could also
fix other platforms with the same chipset.  May slow down other
platforms where MSI *does* work.

4) If needed, we could make the quirk specific to ASUS X73SL.

Bjorn

[1] https://www.asus.com/us/supportonly/x73sl/helpdesk_bios/
[2] https://www.aida64.com/downloads


commit 240bbd06303f ("PCI: Disable MSI on SiS 671")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Jun 8 10:13:11 2023 -0500

    PCI: Disable MSI on SiS 671
    
    Damien reports that MSI doesn't work on the SiS 671 chipset, at least on
    this platform:
    
      DMI: ASUSTeK Computer Inc.  F70SL/F70SL     , BIOS 211     02/18/2009
      pci 0000:00:00.0: [1039:0671] type 00 class 0x060000
    
    This prevents devices, e.g., NVIDIA GeForce 9300M GS GPU and an Atheros
    mini PCIe wifi adapter, from working.  Disable MSI completely on any
    platform with this chipset.
    
    I assume MSI *does* work on Windows on this platform, so there may be a
    chipset driver or something that configures it.  It's possible that MSI
    does work on different platforms with SiS 671, so if anybody cares, we
    *could* make this specific to the ASUS F70SL.
    
    Link: https://lore.kernel.org/r/19F46F0C-E9C8-489E-8AA5-2A16E13A6FE9@gmail.com
    Reported-by: Damien Dejean <dam.dejean@gmail.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f4e2a88729fd..adc58ce82d76 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2585,6 +2585,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3336, quirk_disab
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3351, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3364, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8380_0, quirk_disable_all_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, 0x0671, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, 0x0761, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa5e3, quirk_disable_all_msi);
 
