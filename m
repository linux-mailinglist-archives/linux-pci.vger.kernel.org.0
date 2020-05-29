Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFA51E8896
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 22:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgE2UJY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 16:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgE2UJR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2020 16:09:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA92C08C5C9;
        Fri, 29 May 2020 13:09:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d128so5325613wmc.1;
        Fri, 29 May 2020 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K6zyYUYt6PF/Nv/RjWcqFcwygaODB+1Z7lq1l6U49es=;
        b=BGuzq80mQgJKXFt/lK14OQlzdX5bPJAYFF6TPO6dBgN4kCq+coGYoBEXS2wUsK2YFf
         072B3YeHFYgIQYlivi9U4xZFcSo5jNMB+PeA/0acC/ToPJ+LjHo+X1lu9zHGPZdneV7b
         XEMlSFTxlGsUww7HS+spcSWVgIzaVFc+3EnpCDVv5w5TdIKIfkm66N9xnRge6ZCBmqpA
         dKdhfTOTHgOauxQtuqMXIjca19UUiJrp3dr77SKzW6JZtXmffVPJ/qsF3Zk3tJKp+eB2
         O8clHyygVy/bglPZsjDbPEnotTuJHBt9zKnwRf06k/3WgnsRVxKyjF7HOwmuF2MOakJh
         mlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K6zyYUYt6PF/Nv/RjWcqFcwygaODB+1Z7lq1l6U49es=;
        b=r6nOI85N/p3r/kjr2Bzzki6K3pYBDc+8filhQu8tOUf3H1zDv/81Q5E8BKbMAwU6Q1
         LKaFxQLtxjA7kaR/8GNH0tIvTN4KXAypZw07jfdNzdhv7ZkKmVVvXa5WIFpdMSmrQhAl
         sW9hIoQ1fRogFwQ79eOzqoDikhmnQqrRHn+ThMtG0v1yps9NMz1bnSgb48Xn0xr1fkXh
         1DNmGQNPIEXiuJlt7MuVYBphX3pdqsh3eyalON/K2UWixoAIl6bB2KtV9xoUZWqoCM9c
         Louuo6jSkjAtMutTVl7kdMrhdjYgU4TqJMpeTcZY9XouaGSo6jgBQkyjSJRN+VTw9BDP
         DCWA==
X-Gm-Message-State: AOAM531EqBq6aK6tkqXU4Zv/83tlQxA9Yqk8WHFL5AqGFlokAD+snaDY
        dz4BUBziL4tw5NGLJLMYgP1MyxAS
X-Google-Smtp-Source: ABdhPJz9uPNM7RGGdn5gYICVskGUtKBvhv2dCSJR4e/OBdya+lZxyJySZI8s0dnat+ze+shQOLu4eQ==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr4359907wmi.133.1590782954681;
        Fri, 29 May 2020 13:09:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:cfc:56dc:3d49:4699? (p200300ea8f2357000cfc56dc3d494699.dip0.t-ipconnect.de. [2003:ea:8f23:5700:cfc:56dc:3d49:4699])
        by smtp.googlemail.com with ESMTPSA id b185sm1308113wmd.3.2020.05.29.13.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 13:09:14 -0700 (PDT)
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20200529192143.GA448525@bjorn-Precision-5520>
 <2d3944ea-f46c-037b-2395-859c4240f1fb@gmail.com>
Message-ID: <bdc33be8-1db6-b147-cbc4-90fa0dc3d999@gmail.com>
Date:   Fri, 29 May 2020 22:09:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <2d3944ea-f46c-037b-2395-859c4240f1fb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29.05.2020 21:40, Heiner Kallweit wrote:
> On 29.05.2020 21:21, Bjorn Helgaas wrote:
>> [+cc Rafael, linux-kernel]
>>
>> On Fri, May 29, 2020 at 08:50:46PM +0200, Heiner Kallweit wrote:
>>> On 28.05.2020 23:44, Heiner Kallweit wrote:
>>>> For whatever reason with this change (and losing ASPM control) I also
>>>> loose the PCIe PME interrupts. This prevents my network card from
>>>> resuming from runtime-suspend.
>>>> Reverting the change brings back ASPM control and the PCIe PME irq's.
>>>>
>>>> Affected system is a Zotac MiniPC with a N3450 CPU:
>>>> PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port A #1 (rev fb)
>>>>
>>> I checked a little bit further and w/o ASPM control the root ports
>>> don't have the PME service bit set in their capabilities.
>>> Not sure whether this is a chipset bug or whether there's a better
>>> explanation. However more chipsets may have such a behavior.
>>
>> Hmm.  Is the difference simply changing the PCIEASPM config symbol, or
>> are you booting with command-line arguments like "pcie_aspm=off"?
>>
> Only difference is the config symbol. My command line is plain and simple:
> 
> Command line: initrd=\intel-ucode.img initrd=\initramfs-linux.img root=/dev/sda2 rw
> 
>> What's the specific PME bit that changes in the root ports?  Can you
>> collect the "sudo lspci -vvxxxx" output with and without ASPM?
>>
>> The capability bits are generally read-only as far as the PCI spec is
>> concerned, but devices have implementation-specific knobs that the
>> BIOS may use to change things.  Without CONFIG_PCIEASPM, Linux will
>> not request control of LTR, and that could cause the BIOS to change
>> something.  You should be able to see the LTR control difference in
>> the dmesg logging about _OSC.
>>
>>> W/o the "default y" for ASPM control we also have the situation now
>>> that the config option description says "When in doubt, say Y."
>>> but it takes the EXPERT mode to enable it. This seems to be a little
>>> bit inconsistent.
>>
>> We should probably remove the "if EXPERT" from the PCIEASPM kconfig.
>> But I would expect PME to work correctly regardless of PCIEASPM, so
>> removing "if EXPERT" doesn't solve the underlying problem.
>>
>> Rafael, does this ring any bells for you?  I don't remember a
>> connection between PME and ASPM, but maybe there is one.
>>
>>> To cut a long story short:
>>> At least on some systems this change has unwanted side effects.
> 
> lspci output w/ and w/o ASPM is attached incl. a diff.
> Here comes the _OSC difference.
> 
> w/o ASPM
> 
> [    0.386063] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments MSI HPX-Type3]
> [    0.386918] acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
> 
> w/ ASPM
> [    0.388141] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    0.393648] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability LTR]
> 
> It's at least interesting that w/o ASPM OS doesn't control PME and AER.
> 

This was the right entry point, also w/o ASPM control OS states to ACPI that it
needs ASPM and ClockPM. The following patch fixes the PME issue for me.
See also the _OSC part below.


diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 9e235c1a7..8df1fa728 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -38,10 +38,15 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
 	return 0;
 }
 
+#ifdef CONFIG_PCIEASPM
 #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
 				| OSC_PCI_ASPM_SUPPORT \
 				| OSC_PCI_CLOCK_PM_SUPPORT \
 				| OSC_PCI_MSI_SUPPORT)
+#else
+#define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
+				| OSC_PCI_MSI_SUPPORT)
+#endif
 
 static const struct acpi_device_id root_device_ids[] = {
 	{"PNP0A03", 0},
-- 
2.26.2


[    0.387527] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments MSI HPX-Type3]
[    0.393033] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability]
