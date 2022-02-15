Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54974B72DC
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbiBOQMi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 11:12:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241497AbiBOQMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 11:12:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 647BE65176
        for <linux-pci@vger.kernel.org>; Tue, 15 Feb 2022 08:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644941537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yTu+Qfv1IpPv7AVu5hlJ/Sl4wvDv7oYgI9LSyTBR/g=;
        b=SbAIyqFuN230IwE/22qCixAFYv0ApC+ojCd7IbMepHOIvHgT/Cq66fH0BbozKigJ/syM82
        IYuyEpm5iR8mKerpBIWU/kiPULDQpVTC26lleXM3Cimfa8r8+4SHATGb0Gt3xLlyPWecgW
        COknCKJIhnXdoIabWYeFW+7kySahvvA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-Gzj1pq4xPkCt-EIuEr5MwA-1; Tue, 15 Feb 2022 11:12:16 -0500
X-MC-Unique: Gzj1pq4xPkCt-EIuEr5MwA-1
Received: by mail-ed1-f70.google.com with SMTP id cr7-20020a056402222700b0040f59dae606so93384edb.11
        for <linux-pci@vger.kernel.org>; Tue, 15 Feb 2022 08:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6yTu+Qfv1IpPv7AVu5hlJ/Sl4wvDv7oYgI9LSyTBR/g=;
        b=LmpI+sxgBw1uz6wlAOaZcPa3tRTBODlMtEMTo2fN8YTyMU4nRQ5AlCTRe7vQtxJRPM
         waZpqDLPm4Rp6X9ieNSK9YtB2ks9/1vvDGhfVEwt0N6ey/k6B0F438mdCDY8FkPRt22K
         aSBBWUSHXZP8qY5RqGIGJozbSnLRYeejFeRuSDd7soNaumw4EN1pdCHsty0sD/vGgkwR
         +KpHZ1WjIIp57Chl700/CMcvf+9B280pKPszmG3jXj+TabVr9wDLAcckdq0OTqip7DBe
         fi+pGt8/lwTOsfJNGoYPB7yTqsih/l7RjK4kwT/QnE9jKh24bKQA/GZJoIkJKsKrvo1j
         R3CQ==
X-Gm-Message-State: AOAM531Trj3IKmyA4Md/ha+eooAUAt0s1+qbAiSbBvr2VSd79VbGS0rm
        nQrxvTPe2nQ3N37AAKpCsJfndA5zc+LV0g6ihWS/7LNdPM6pIH95cCXItZUJSjx2WKnEZhV+l+/
        3OPd7zQ9nrrJUoChcHPx6
X-Received: by 2002:a50:8e4b:: with SMTP id 11mr4650941edx.445.1644941533366;
        Tue, 15 Feb 2022 08:12:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzftckYd5NKJC5MMKL5KSz/KVu2PoAWMB8ocFZSkMTrbX9sgdnbBvEL3rXT/dAeLNasexhiOQ==
X-Received: by 2002:a50:8e4b:: with SMTP id 11mr4650912edx.445.1644941533147;
        Tue, 15 Feb 2022 08:12:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id m28sm4256482ejn.50.2022.02.15.08.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 08:12:12 -0800 (PST)
Message-ID: <05332ea8-2849-e567-1db3-3bdee97c2193@redhat.com>
Date:   Tue, 15 Feb 2022 17:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC 0/2] x86/PCI: Ignore EFI memmap MMIO entries
Content-Language: en-US
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220214151759.98267-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220214151759.98267-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

On 2/14/22 16:17, Hans de Goede wrote:
> Hi All,
> 
> Here is a new attempt at fixing the issue where on some laptops
> there are EFI memmap MMIO entries covering the entire PCI bridge
> mem window, causing Linux to be unable to find free space to
> assign to unassigned BARs.
> 
> This is marked as RFC atm because I'm waiting for feedback from
> testers.

Unfortunately the troublesome 0xdfa00000-0xdfa0ffff region on
the Lenovo X1 carbon gen 2 is marked as MMIO by the EFI memmap,
so the approach from this series won't work.

Interestingly enough this RFC series does seem to help to fix
the suspend/resume on this x1c2, since for some reason merely
splitting the original:

BIOS-e820: [mem 0x00000000dceff000-0x00000000dfa0ffff] reserved

range into:

BIOS-e820: [mem 0x00000000dceff000-0x00000000df9fffff] reserved
BIOS-e820: [mem 0x00000000dfa00000-0x00000000dfa0ffff] MMIO

causes the PCI resource allocation code to pick slightly
different resources avoiding the troublesome overlap, see:
https://bugzilla.redhat.com/show_bug.cgi?id=2029207
for logs.

But I don't think we should rely in this, since from a
arch_remove_reservations() pov the troublesome overlap area
which is now marked as MMIO is fair game for PCI bars with
the change to allow MMIO areas for PCI bars, so things seem
to mostly work by sheer luck after this RFC series.

So now I have yet another plan to fix this (see below) I'll get
that tested and assuming it works post that as a proper patch.

Regards,

Hans



diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 490411dba438..573e1323f490 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -64,6 +64,8 @@ void pcibios_scan_specific_bus(int busn);
 
 /* pci-irq.c */
 
+struct pci_dev;
+
 struct irq_info {
 	u8 bus, devfn;			/* Bus, device and function */
 	struct {
@@ -232,3 +234,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
 # define x86_default_pci_init_irq	NULL
 # define x86_default_pci_fixup_irqs	NULL
 #endif
+
+#if defined CONFIG_PCI && defined CONFIG_ACPI
+extern bool pci_use_e820;
+#else
+#define pci_use_e820 true
+#endif
diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
index 9b9fb7882c20..e8dc9bc327bd 100644
--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/ioport.h>
 #include <asm/e820/api.h>
+#include <asm/pci_x86.h>
 
 static void resource_clip(struct resource *res, resource_size_t start,
 			  resource_size_t end)
@@ -28,6 +29,9 @@ static void remove_e820_regions(struct resource *avail)
 	int i;
 	struct e820_entry *entry;
 
+	if (!pci_use_e820)
+		return;
+
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		entry = &e820_table->entries[i];
 
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 052f1d78a562..7167934819b3 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/efi.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/init.h>
@@ -21,6 +22,7 @@ struct pci_root_info {
 
 static bool pci_use_crs = true;
 static bool pci_ignore_seg;
+bool pci_use_e820 = true;
 
 static int __init set_use_crs(const struct dmi_system_id *id)
 {
@@ -291,6 +293,28 @@ static bool resource_is_pcicfg_ioport(struct resource *res)
 		res->start == 0xCF8 && res->end == 0xCFF;
 }
 
+static bool resource_matches_efi_mmio_region(const struct resource *res)
+{
+	unsigned long long start, end;
+	efi_memory_desc_t *md;
+
+	if (!efi_enabled(EFI_MEMMAP))
+		return false;
+
+	for_each_efi_memory_desc(md) {
+		if (md->type != EFI_MEMORY_MAPPED_IO)
+			continue;
+
+		start = md->phys_addr;
+		end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+
+		if (res->start >= start && res->end <= end)
+			return true;
+	}
+
+	return false;
+}
+
 static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 {
 	struct acpi_device *device = ci->bridge;
@@ -300,9 +324,16 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 
 	status = acpi_pci_probe_root_resources(ci);
 	if (pci_use_crs) {
-		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
+		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
 			if (resource_is_pcicfg_ioport(entry->res))
 				resource_list_destroy_entry(entry);
+			if (resource_matches_efi_mmio_region(entry->res)) {
+				dev_info(&device->dev,
+					"host bridge window %pR is marked by EFI as MMIO\n",
+					entry->res);
+				pci_use_e820 = false;
+			}
+		}
 		return status;
 	}
 

