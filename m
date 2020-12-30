Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15A12E7D0E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Dec 2020 23:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgL3W4w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 17:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgL3W4w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2020 17:56:52 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B57C061573;
        Wed, 30 Dec 2020 14:56:12 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k10so6114493wmi.3;
        Wed, 30 Dec 2020 14:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fRTS3Id9eleLhgnOpSCzs7YIho8S+XSbtACGnjJB5e0=;
        b=PeEPZIGXBiBNgxGXENxz/Ds3ZQsbSnihQPDzVK3FI+U2f6oVAKdbLq0Jbn+ZCDRAa/
         lNLckVmOjUzJc66SyXLS+RFysXvPeSiSd9i0tClNd0zDkNJTSjLhoNYurlJfB04xYJTb
         /bu4bA9+JggQo6wDEueTiO9oBw9PSFkdVI0YVLqwI92jsbhofseU9HvieAtnl8VIYxIr
         hzbxkuRLTvVkOQWIYsuaGgKppPPjP5rHsXtCkPOBBb8gz25GTuNaNPiDOo5SrtSzgN9H
         TEP6h2EspdvovI+xqKY1a5TithCLGI1uPzo3LTVbf0YKRuzX8IXsNmq947GuluvE41ZU
         rXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fRTS3Id9eleLhgnOpSCzs7YIho8S+XSbtACGnjJB5e0=;
        b=owHm4ZyabN5W34Ey803GoE2sSAMlxW8r1yhsfbYB/fZH3yU34aO1PxjlxxEqqdmPPq
         6mVsp8GYkMs2f4FTOSjbZe1/fNZnhvid+ZnLpXXFXFLI3AUzPvFkPKMlHRMKetGiD6WL
         UfGr9Nz8bvbv0H+Rk24hNaDCsH/QD4AP4r50nG+VbWkNf1GEHYLbnyov6TrH4F0c/xUg
         zvmNHf8YBi521oWRV6Czrf0tPgoRvCKw9KIDI7p6J+XSBC4geO08syiZzlk9cahbNdeV
         Y6iJBAdmPXbWtWOHXrIa1vJcJIYDeSsjuP5T4V2KQa5J66nEhAAI2tI4D3FJx2yVzmRY
         gjmw==
X-Gm-Message-State: AOAM533CS9u7m0OQwxNHtiPV3qgPuSrF6XC+i4FE6SFKmbPfsT3BQdng
        j3l1UfVcQPso8BkmuEjUOqXQQNT96g0=
X-Google-Smtp-Source: ABdhPJyfADlFq8aF0bGkckmZ9/26pOJpEMq4HjTAD3GImVYvoXk+P/aENfUZ7pJh12DHLVS9X2y2+w==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr9363773wmm.80.1609368970398;
        Wed, 30 Dec 2020 14:56:10 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:a1e5:2a55:c7d0:ad89? (p200300ea8f065500a1e52a55c7d0ad89.dip0.t-ipconnect.de. [2003:ea:8f06:5500:a1e5:2a55:c7d0:ad89])
        by smtp.googlemail.com with ESMTPSA id o7sm67482406wrw.62.2020.12.30.14.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 14:56:09 -0800 (PST)
Subject: Re: Time to re-enable Runtime PM per default for PCI devcies?
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Lukas Wunner <lukas@wunner.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <79940973-b631-90f9-dbc4-9579c6000816@gmail.com>
 <20201117163817.GA1397220@bjorn-Precision-5520>
 <CAJZ5v0ipMJ1gCB7okpROG_yAUi5Q8LknqeH+Jpdrjbb4D_vfuQ@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <9ca0fb46-9e65-31e2-103f-1c98ce8362c7@gmail.com>
Date:   Wed, 30 Dec 2020 23:56:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ipMJ1gCB7okpROG_yAUi5Q8LknqeH+Jpdrjbb4D_vfuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17.11.2020 17:57, Rafael J. Wysocki wrote:
> On Tue, Nov 17, 2020 at 5:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> [+to Rafael, author of the commit you mentioned,
>> +cc Mika, Kai Heng, Lukas, linux-pm, linux-kernel]
>>
>> On Tue, Nov 17, 2020 at 04:56:09PM +0100, Heiner Kallweit wrote:
>>> More than 10 yrs ago Runtime PM was disabled per default by bb910a7040
>>> ("PCI/PM Runtime: Make runtime PM of PCI devices inactive by default").
>>>
>>> Reason given: "avoid breakage on systems where ACPI-based wake-up is
>>> known to fail for some devices"
>>> Unfortunately the commit message doesn't mention any affected  devices
>>> or systems.
> 
> Even if it did that, it wouldn't have been a full list almost for sure.
> 
> We had received multiple problem reports related to that, most likely
> because the ACPI PM in BIOSes at that time was tailored for
> system-wide PM transitions only.
> 
>>> With Runtime PM disabled e.g. the PHY on network devices may remain
>>> powered up even with no cable plugged in, affecting battery lifetime
>>> on mobile devices. Currently we have to rely on the respective distro
>>> or user to enable Runtime PM via sysfs (echo auto > power/control).
>>> Some devices work around this restriction by calling pm_runtime_allow
>>> in their probe routine, even though that's not recommended by
>>> https://www.kernel.org/doc/Documentation/power/pci.txt
>>>
>>> Disabling Runtime PM per default seems to be a big hammer, a quirk
>>> for affected devices / systems may had been better. And we still
>>> have the option to disable Runtime PM for selected devices via sysfs.
>>>
>>> So, to cut a long story short: Wouldn't it be time to remove this
>>> restriction?
>>
>> I don't know the history of this, but maybe Rafael or the others can
>> shed some light on it.
> 
> The systems that had those problems 10 years ago would still have
> them, but I expect there to be more systems where runtime PM can be
> enabled by default for PCI devices without issues.
> 

As a proposal, maybe we can use the ACPI revision as an indicator for
whether ACPI implementation is new enough to not be affected by the old
problems. With the following simple patch runtime pm won't be disabled
per default for ACPI versions >= 6.0. AFAIK ACPI 6.0 was published in 2015.

On a side note:
It seems the sole motivation to disable runtime pm per default is ACPI
problems. So why do we disable runtime pm also on non-ACPI systems?
With the proposed patch runtime pm is enabled per default if
CONFIG_ACPI isn't defined.

---
 drivers/pci/pci-acpi.c | 5 +++++
 drivers/pci/pci.c      | 4 +++-
 drivers/pci/pci.h      | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 53502a751..265f5d2c4 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -27,6 +27,11 @@ const guid_t pci_acpi_dsm_guid =
 	GUID_INIT(0xe5c937d0, 0x3553, 0x4d7a,
 		  0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d);
 
+bool pci_acpi_forbid_runtime_pm(void)
+{
+	return acpi_gbl_FADT.header.revision < 6;
+}
+
 #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
 static int acpi_get_rc_addr(struct acpi_device *adev, struct resource *res)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9fecc25d..83b5a7e63 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3024,7 +3024,9 @@ void pci_pm_init(struct pci_dev *dev)
 	u16 status;
 	u16 pmc;
 
-	pm_runtime_forbid(&dev->dev);
+	if (pci_acpi_forbid_runtime_pm())
+		pm_runtime_forbid(&dev->dev);
+
 	pm_runtime_set_active(&dev->dev);
 	pm_runtime_enable(&dev->dev);
 	device_enable_async_suspend(&dev->dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5c5936509..c1d521fb2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -701,11 +701,16 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 
 #ifdef CONFIG_ACPI
 int pci_acpi_program_hp_params(struct pci_dev *dev);
+bool pci_acpi_forbid_runtime_pm(void);
 #else
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
 	return -ENODEV;
 }
+static inline bool pci_acpi_forbid_runtime_pm(void)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_PCIEASPM
-- 
2.29.2


