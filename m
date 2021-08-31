Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1863FC218
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 07:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhHaFXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 01:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhHaFXe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Aug 2021 01:23:34 -0400
X-Greylist: delayed 317 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Aug 2021 22:22:40 PDT
Received: from mail.postlabmedia.com (mail.postlabmedia.com [IPv6:2607:5300:61:cb9:149:56:251:213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF04C061575
        for <linux-pci@vger.kernel.org>; Mon, 30 Aug 2021 22:22:40 -0700 (PDT)
Received: from [IPv6:2001:569:bf10:5a00::7] (node-1w7jr9stk61h8lkr6l03lc3yf.ipv6.telus.net [IPv6:2001:569:bf10:5a00::7])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail.postlabmedia.com (Postfix) with ESMTPSA id 0D7184272248;
        Tue, 31 Aug 2021 00:17:16 -0500 (CDT)
Authentication-Results: mail.postlabmedia.com; dmarc=fail (p=quarantine dis=none) header.from=jaundrew.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jaundrew.com; s=mail;
        t=1630387037; bh=LmjajPG3v+Sr3z7ZOdmijVoqytExkaDe3OtuHnpNWeE=;
        h=To:From:Subject:Date;
        b=bUj+Ae5BtrbfN0pEIwLpgWUK7e+9COXUOaWAhc5VTnp/HqYRMIMauVB6pOUfsU+C2
         BmXQ882oT0KhDs6f49WiazvP6GuD3HyP+rPj1vLKTRq97ECnVIA+OmHjpIOmkv9jD9
         XlyiC3+3IUzUKFpS29AIRkL2n/aB5lpiLsF0UC54=
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
From:   David Jaundrew <david@jaundrew.com>
Subject: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic Coprocessor
Message-ID: <e30f1c18-3189-774f-054e-8499ade9e398@jaundrew.com>
Date:   Mon, 30 Aug 2021 22:17:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch fixes another FLR bug for the Starship/Matisse controller:

AMD Starship/Matisse Cryptogrpahic Coprocessor PSPCPP

This patch allows functions on the same Starship/Matisse device (such as USB controller,sound card) to properly pass through to a guest OS using vfio-pc. Without this patch, the virtual machine does not boot and eventually times out.

Excerpt from lspci -nn showing crypto function on same device as USB and sound card (which are already listed in quirks.c):
0e:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
0e:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
0e:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse HD Audio Controller [1022:1487]

Fix tested successfully on an Asus ROG STRIX X570-E GAMING motherboard with AMD Ryzen 9 3900X.

--- a/drivers/pci/quirks.c      2021-08-30 21:19:25.365738689 -0700
+++ b/drivers/pci/quirks.c      2021-08-30 21:21:25.802031789 -0700
@@ -5208,6 +5208,7 @@
 /*
  * FLR may cause the following to devices to hang:
  *
+ * AMD Starship/Matisse Cryptographic Coprocessor PSPCPP 0x1486
  * AMD Starship/Matisse HD Audio Controller 0x1487
  * AMD Starship USB 3.0 Host Controller 0x148c
  * AMD Matisse USB 3.0 Host Controller 0x149c
@@ -5219,6 +5220,7 @@
 {
        dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1486, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
