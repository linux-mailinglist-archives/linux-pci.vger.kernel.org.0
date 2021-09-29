Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9205A41BBA8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 02:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbhI2ASj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 20:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243350AbhI2ASi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 20:18:38 -0400
Received: from mail.postlabmedia.com (mail.postlabmedia.com [IPv6:2607:5300:61:cb9:149:56:251:213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F2C06161C
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 17:16:58 -0700 (PDT)
Received: from [IPv6:2001:569:be06:4100:6fa4:5af4:ae47:8b69] (node-1w7jr9ssfqwmqpwqubevua3qh.ipv6.telus.net [IPv6:2001:569:be06:4100:6fa4:5af4:ae47:8b69])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.postlabmedia.com (Postfix) with ESMTPSA id BD71E43D9FB6;
        Tue, 28 Sep 2021 19:16:54 -0500 (CDT)
Authentication-Results: mail.postlabmedia.com; dmarc=fail (p=quarantine dis=none) header.from=jaundrew.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jaundrew.com; s=mail;
        t=1632874615; bh=YhPMHKfhL6/mcHn0GYu1b9DsFbaJTjUMKr0tqHvjdV8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sEaqBVCfJ6nA2rhMP2nVwzkp/Jcv+1Qva9T4sD9CKnLRu8CjV2TY79eqvQyUHMQ0/
         +phhUY20KCW/+MuGMN/dHn9hud7uKOI9+cGbU2S1FLzLU+ZLsjh53Ld3smpzV0BzH0
         24Mvj76IKqz83IjsG0LxCIncjnsQL5hkO0IBCkVY=
Subject: Re: [PATCH] Avoid FLR for AMD Starship/Matisse Cryptographic
 Coprocessor
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20210928214558.GA736874@bhelgaas>
From:   David Jaundrew <david@jaundrew.com>
Message-ID: <9e85bcad-a73c-cccd-4522-a45e599309d7@jaundrew.com>
Date:   Tue, 28 Sep 2021 17:16:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928214558.GA736874@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch fixes another FLR bug for the Starship/Matisse controller:

AMD Starship/Matisse Cryptogrpahic Coprocessor PSPCPP

This patch allows functions on the same Starship/Matisse device (such as
USB controller,sound card) to properly pass through to a guest OS using
vfio-pc. Without this patch, the virtual machine does not boot and
eventually times out.

Excerpt from lspci -nn showing crypto function on same device as USB and
sound card (which are already listed in quirks.c):

0e:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD]
  Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
0e:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD]
  Matisse USB 3.0 Host Controller [1022:149c]
0e:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD]
  Starship/Matisse HD Audio Controller [1022:1487]

Fix tested successfully on an Asus ROG STRIX X570-E GAMING motherboard
with AMD Ryzen 9 3900X.

Signed-off-by: David Jaundrew <david@jaundrew.com>
---
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6d74386eadc2..0d19e7aa219a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5208,6 +5208,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
 /*
  * FLR may cause the following to devices to hang:
  *
+ * AMD Starship/Matisse Cryptographic Coprocessor PSPCPP 0x1486
  * AMD Starship/Matisse HD Audio Controller 0x1487
  * AMD Starship USB 3.0 Host Controller 0x148c
  * AMD Matisse USB 3.0 Host Controller 0x149c
@@ -5219,6 +5220,7 @@ static void quirk_no_flr(struct pci_dev *dev)
 {
        dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1486, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);

On 2021-09-28 2:45 p.m., Bjorn Helgaas wrote:
> On Mon, Aug 30, 2021 at 10:17:15PM -0700, David Jaundrew wrote:
>> This patch fixes another FLR bug for the Starship/Matisse controller:
>>
>> AMD Starship/Matisse Cryptogrpahic Coprocessor PSPCPP
>>
>> This patch allows functions on the same Starship/Matisse device (such as USB controller,sound card) to properly pass through to a guest OS using vfio-pc. Without this patch, the virtual machine does not boot and eventually times out.
>>
>> Excerpt from lspci -nn showing crypto function on same device as USB and sound card (which are already listed in quirks.c):
>> 0e:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
>> 0e:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
>> 0e:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse HD Audio Controller [1022:1487]
>>
>> Fix tested successfully on an Asus ROG STRIX X570-E GAMING motherboard with AMD Ryzen 9 3900X.
> This is missing a signed-off-by and the patch is corrupted somehow:
>
>   04:44:29 ~/linux (pci/virtualization)$ git am m/20210830_david_avoid_flr_for_amd_starship_matisse_cryptographic_coprocessor.mbx
>   Applying: Avoid FLR for AMD Starship/Matisse Cryptographic Coprocessor
>   error: corrupt patch at line 4
>   Patch failed at 0001 Avoid FLR for AMD Starship/Matisse Cryptographic Coprocessor
>
> Can you fix?  If you can add least supply a signed-off-by, I can apply
> it manually if necessary.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.11#n361
>
>> --- a/drivers/pci/quirks.c      2021-08-30 21:19:25.365738689 -0700
>> +++ b/drivers/pci/quirks.c      2021-08-30 21:21:25.802031789 -0700
>> @@ -5208,6 +5208,7 @@
>>  /*
>>   * FLR may cause the following to devices to hang:
>>   *
>> + * AMD Starship/Matisse Cryptographic Coprocessor PSPCPP 0x1486
>>   * AMD Starship/Matisse HD Audio Controller 0x1487
>>   * AMD Starship USB 3.0 Host Controller 0x148c
>>   * AMD Matisse USB 3.0 Host Controller 0x149c
>> @@ -5219,6 +5220,7 @@
>>  {
>>         dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
>>  }
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1486, quirk_no_flr);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
