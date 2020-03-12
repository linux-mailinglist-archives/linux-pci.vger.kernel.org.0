Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84873182CAD
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 10:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgCLJps convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 12 Mar 2020 05:45:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgCLJps (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2020 05:45:48 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jCKPO-0006Ug-0T
        for linux-pci@vger.kernel.org; Thu, 12 Mar 2020 09:45:42 +0000
Received: by mail-pf1-f200.google.com with SMTP id v14so3377811pfm.21
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2020 02:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oA9VO01Ip+cddG2FMUod8bKCh4JTqI9rasuKGbBTz1g=;
        b=Ny03Wzs0Sh8YIoMKhhB3a5sekfrPxffC+9XZeXxUOXyW8lf+JxYlPzHnsEjaN9743t
         T7TcCyFTdq9m58b3yu9aL9J1stOJJX7u9zEckBedYbbrO/zLK3+aGpo29Xuzmi5hpHHh
         fx3+86IsIGHyA6UsdeOk2rFiMDsAPd3qU1pRV9AOShz0gn/9FrZ5T0JFJq/GXpUuQ6nA
         p8Jeu82Jg6l1WEkJdWIb1SFsR5TYJ6TUgs60pNrdzhLdu9MOTHJ8BOeiZ+qNEg3R1+6H
         ALuJidy2IDatultgTppYD7RvT3J1NQD+ETAJFbQaQ7SdodTUXvbZQ5xqiSy6CmIClBN6
         fg1w==
X-Gm-Message-State: ANhLgQ1EJVG5QPRfgTM4LmGkoOwtzia7loAQ49qiiuzTpyZS+Sq3P8/G
        y21TuF+rulNk9b56eT+/tEl9TBmoeiefuvBBQQjAZMYcoJ81IDRNDuLzi7736N9cnE+1nI9MjNq
        f1mqtSMoVlUrYxiByH8VRe0gm1JP0pQTZlC2lsQ==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr6729216plp.252.1584006340418;
        Thu, 12 Mar 2020 02:45:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvXNMGzz5SfvqPMiPW+sEjmuGUs5r9FtLwzIbR488NP6SzmN4arsH9asWYDBBcUGh0loMrCQQ==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr6729184plp.252.1584006340010;
        Thu, 12 Mar 2020 02:45:40 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id s206sm55776719pfs.100.2020.03.12.02.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 02:45:39 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] PCI/PM: Skip link training delay for S3 resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200312080424.GH2540@lahna.fi.intel.com>
Date:   Thu, 12 Mar 2020 17:45:32 +0800
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <ABD5242B-E118-4811-AA8A-DF7C2A3B2E8B@canonical.com>
References: <20200311045249.5200-1-kai.heng.feng@canonical.com>
 <20200311102811.GA2540@lahna.fi.intel.com>
 <2C20385C-4BA4-4D6D-935A-AFDB97FAB5ED@canonical.com>
 <20200312080424.GH2540@lahna.fi.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Mar 12, 2020, at 16:04, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> On Thu, Mar 12, 2020 at 12:23:46PM +0800, Kai-Heng Feng wrote:
>> Hi,
>> 
>>> On Mar 11, 2020, at 18:28, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
>>> 
>>> Hi,
>>> 
>>> On Wed, Mar 11, 2020 at 12:52:49PM +0800, Kai-Heng Feng wrote:
>>>> Commit ad9001f2f411 ("PCI/PM: Add missing link delays required by the
>>>> PCIe spec") added a 1100ms delay on resume for bridges that don't
>>>> support Link Active Reporting.
>>>> 
>>>> The commit also states that the delay can be skipped for S3, as the
>>>> firmware should already handled the case for us.
>>> 
>>> Delay can be skipped if the firmware provides _DSM with function 8
>>> implemented according to PCI firmwre spec 3.2 sec 4.6.8.
>> 
>> As someone who doesn't have access to the PCI spec...
>> Questions below.
>> 
>>> 
>>>> So let's skip the link training delay for S3, to save 1100ms resume
>>>> time.
>>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> drivers/pci/pci-driver.c | 3 ++-
>>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>> index 0454ca0e4e3f..3050375bad04 100644
>>>> --- a/drivers/pci/pci-driver.c
>>>> +++ b/drivers/pci/pci-driver.c
>>>> @@ -916,7 +916,8 @@ static int pci_pm_resume_noirq(struct device *dev)
>>>> 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>>>> 	pcie_pme_root_status_cleanup(pci_dev);
>>>> 
>>>> -	if (!skip_bus_pm && prev_state == PCI_D3cold)
>>>> +	if (!skip_bus_pm && prev_state == PCI_D3cold
>>>> +	    && !pm_resume_via_firmware())
>>> 
>>> So this would need to check for the _DSM result as well. We do evaluate
>>> it in pci_acpi_optimize_delay() (drivers/pci/pci-acpi.c) and that ends
>>> up lowering ->d3cold_delay so maybe check that here.
>> 
>> Do we need to wait for d3cold_delay here?
>> Or we can also skip that as long as pci_acpi_dsm_guid and FUNCTION_DELAY_DSM present?
> 
> Actually I think pci_bridge_wait_for_secondary_bus() already takes it
> into account. Have you checked if the BIOS has this _DSM implemented in
> the first place?

-[0000:00]-+-00.0  Intel Corporation Device 9b44
           +-1c.0-[03-3b]----00.0-[04-3b]--+-00.0-[05]----00.0  Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 2C 2018]
           |                               +-01.0-[06-3a]--
           |                               \-02.0-[3b]----00.0  Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 2C 2018]

00:1c.0 has _DSM implemented.
How do I check for the Thunderbolt device?
It doesn't seem to have a fixed _ADR so I don't know how to locate it in DSDT/SSDT table.

Log with additional debug message:
[  948.813025] ACPI: EC: interrupt unblocked
[  948.925017] pcieport 0000:00:01.0: pcie_wait_for_link_delay sleep 1100ms
[  949.065466] pcieport 0000:04:00.0: pcie_wait_for_link_delay sleep 1100ms
[  949.065468] pcieport 0000:04:02.0: pcie_wait_for_link_delay sleep 1100ms

00:01.0 is the port for discrete graphics.

Kai-Heng
