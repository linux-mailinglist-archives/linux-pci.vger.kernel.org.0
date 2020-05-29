Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB2B1E8945
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 22:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgE2Uxk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgE2Uxk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2020 16:53:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85FDC03E969;
        Fri, 29 May 2020 13:53:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id n5so5437076wmd.0;
        Fri, 29 May 2020 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/UG1Epx8dO/D86868L2Rs84gPkwYZrXcfIa6Kc/U1CI=;
        b=JjLnR3E6ULzBZYyoeJ5K/NxGlk6IaSNp3r1a4Sd5gEczTimCywWe1Dpbp73/sQxyDa
         +DaNez5hZedEJAwccYwHXwEKJGPOQ6b3vvhIuWYOzqdtJ3NLnTwMWfqbuCfZI3K8OYAN
         zEgNqwgT/QXjjh2cNJmOpFRa+TpgwDL4pzIS/1sdmhlVvpENjyi5D2fOH1nW3RGKLo7r
         exIEC/47y1TGZMOL1xeRDOBeuQht3fytJJQVOL/VLs/UosZZSGLE08bJayPkhKkLPlMT
         f8/j5I16U24K+rm0A+kRPHGcUsQXS8NGV8zdnHz6muXgx0CsAubdogaabcur8mfchkT7
         7mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/UG1Epx8dO/D86868L2Rs84gPkwYZrXcfIa6Kc/U1CI=;
        b=rJVMNNMBF5vOkul3hOhbaxgDktWD3eWx/YHu1i1hXnpGx/uBA0F8YC86w7a8aQJ3Um
         CZ1Yn3CXrI7XJ6DODq/xR2MWolMm9ww2+k7Vknb4ynBaj/ATRGiY39WC8eLbes7MagfX
         TSyiy/PiZOuox9G8g8vC5d5Z6cgVGIUnXGKRbrwNJOZPWRSdLryIyV/xKHKnzl/aSTyy
         MlNDg8eG98hVcPyw17elKL2A+y1YLvJwsCp7zLsUyjsFkkdvyeo3bETBCsRUezrB2E+S
         2LrVcEy8fHR3ZPk8HNTS1Fs7a38/A9CFUbq1Ms24occpHjRG/B210Jepgo265FQxFrDr
         uyyw==
X-Gm-Message-State: AOAM533eEt8OCZW62YGsw/njVOMe/H+am/8WlnTNwpHgOV6Uu16WnmMl
        bIrWgFkYznQtQf6vsieMYDY=
X-Google-Smtp-Source: ABdhPJzlsn09+PamKu68TlkGNCZvyjpx57gSu1VunRQtHIl0DNZjnkga3W8iD+KvKy+8EcEvp2bmgQ==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr9530649wmj.149.1590785618374;
        Fri, 29 May 2020 13:53:38 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:cfc:56dc:3d49:4699? (p200300ea8f2357000cfc56dc3d494699.dip0.t-ipconnect.de. [2003:ea:8f23:5700:cfc:56dc:3d49:4699])
        by smtp.googlemail.com with ESMTPSA id n1sm11266224wrp.10.2020.05.29.13.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 13:53:37 -0700 (PDT)
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
References: <20200529202135.GA461617@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <bfdf07cf-7449-bb25-0d00-296f0be7794b@gmail.com>
Date:   Fri, 29 May 2020 22:53:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529202135.GA461617@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29.05.2020 22:21, Bjorn Helgaas wrote:
> [+cc Matthew]
> 
> On Fri, May 29, 2020 at 10:09:08PM +0200, Heiner Kallweit wrote:
>> On 29.05.2020 21:40, Heiner Kallweit wrote:
>>> On 29.05.2020 21:21, Bjorn Helgaas wrote:
>>>> On Fri, May 29, 2020 at 08:50:46PM +0200, Heiner Kallweit wrote:
>>>>> On 28.05.2020 23:44, Heiner Kallweit wrote:
>>>>>> For whatever reason with this change (and losing ASPM control) I also
>>>>>> loose the PCIe PME interrupts. This prevents my network card from
>>>>>> resuming from runtime-suspend.
>>>>>> Reverting the change brings back ASPM control and the PCIe PME irq's.
>>>>>>
>>>>>> Affected system is a Zotac MiniPC with a N3450 CPU:
>>>>>> PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port A #1 (rev fb)
>>>>>>
>>>>> I checked a little bit further and w/o ASPM control the root ports
>>>>> don't have the PME service bit set in their capabilities.
>>>>> Not sure whether this is a chipset bug or whether there's a better
>>>>> explanation. However more chipsets may have such a behavior.
>>>>
>>>> Hmm.  Is the difference simply changing the PCIEASPM config symbol, or
>>>> are you booting with command-line arguments like "pcie_aspm=off"?
>>>>
>>> Only difference is the config symbol. My command line is plain and simple:
>>>
>>> Command line: initrd=\intel-ucode.img initrd=\initramfs-linux.img root=/dev/sda2 rw
>>>
>>>> What's the specific PME bit that changes in the root ports?  Can you
>>>> collect the "sudo lspci -vvxxxx" output with and without ASPM?
>>>>
>>>> The capability bits are generally read-only as far as the PCI spec is
>>>> concerned, but devices have implementation-specific knobs that the
>>>> BIOS may use to change things.  Without CONFIG_PCIEASPM, Linux will
>>>> not request control of LTR, and that could cause the BIOS to change
>>>> something.  You should be able to see the LTR control difference in
>>>> the dmesg logging about _OSC.
>>>>
>>>>> W/o the "default y" for ASPM control we also have the situation now
>>>>> that the config option description says "When in doubt, say Y."
>>>>> but it takes the EXPERT mode to enable it. This seems to be a little
>>>>> bit inconsistent.
>>>>
>>>> We should probably remove the "if EXPERT" from the PCIEASPM kconfig.
>>>> But I would expect PME to work correctly regardless of PCIEASPM, so
>>>> removing "if EXPERT" doesn't solve the underlying problem.
>>>>
>>>> Rafael, does this ring any bells for you?  I don't remember a
>>>> connection between PME and ASPM, but maybe there is one.
>>>>
>>>>> To cut a long story short:
>>>>> At least on some systems this change has unwanted side effects.
>>>
>>> lspci output w/ and w/o ASPM is attached incl. a diff.
>>> Here comes the _OSC difference.
>>>
>>> w/o ASPM
>>>
>>> [    0.386063] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments MSI HPX-Type3]
>>> [    0.386918] acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
>>>
>>> w/ ASPM
>>> [    0.388141] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
>>> [    0.393648] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability LTR]
>>>
>>> It's at least interesting that w/o ASPM OS doesn't control PME and AER.
>>>
>>
>> This was the right entry point, also w/o ASPM control OS states to ACPI that it
>> needs ASPM and ClockPM. The following patch fixes the PME issue for me.
>> See also the _OSC part below.
>>
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 9e235c1a7..8df1fa728 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -38,10 +38,15 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_PCIEASPM
>>  #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
>>  				| OSC_PCI_ASPM_SUPPORT \
>>  				| OSC_PCI_CLOCK_PM_SUPPORT \
>>  				| OSC_PCI_MSI_SUPPORT)
>> +#else
>> +#define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
>> +				| OSC_PCI_MSI_SUPPORT)
>> +#endif
> 
> Yeah, that makes sense.  I can't remember the details, but I'm pretty
> sure there's a reason why we ask for the whole set of things.  Seems
> like it solved some problem.  I think Matthew Garrett might have been
> involved in that.
> 

ACPI_PCIE_REQ_SUPPORT was introduced with 415e12b23792 ("PCI/ACPI:
Request _OSC control once for each root bridge (v3)") in 2011.
It's linked to the following bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=20232

I can't say whether there's a chance that the proposed patch would
bring back the issue discussed at that time.

If somebody thinks that the proposed patch isn't the right solution,
then presumably the following needs to be touched.

	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
		decode_osc_support(root, "not requesting OS control; OS requires",
				   ACPI_PCIE_REQ_SUPPORT);
		return;
	}

	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
		| OSC_PCI_EXPRESS_PME_CONTROL;

