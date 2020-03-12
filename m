Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B221827C1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 05:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgCLEXx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 12 Mar 2020 00:23:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49791 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbgCLEXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2020 00:23:53 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jCFNv-0006nD-95
        for linux-pci@vger.kernel.org; Thu, 12 Mar 2020 04:23:51 +0000
Received: by mail-pl1-f197.google.com with SMTP id y4so2591131plk.3
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 21:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r+xyaKNdvsLYdWd4l0whYqhAfZ5fJa+bTC8liwizQj8=;
        b=YEhQtSFbovQ1RgLnYliEv9jOxeOdXuiCtnRQU3vAJZdA1etwMu7bHHq/Om7v5gRvec
         7NjfZ0eD37oOyZGobiwLnXCpxqBWPSTTnyrcBl2SLvoMZZibOhmgT3/phPYT6+sUD75w
         5h9BhOt3rdRJ87gbNI0dW7MjXa4rmjKSB70GjmnlUn19c6GU1VucGl93Fmg1agwkHCWj
         Se/WllhZPzirQ9F96gnrl0QGb5KpqzSta7gOMKOddhXfHSParHpJ5yui0BZeUy44zX+v
         CwQiZImXc/dF4YkCDz0caHi2EpWR3IdL3jbPfk5U2YTeAEk4LbHoOW00jV7CqHZ/Kb7X
         RQMw==
X-Gm-Message-State: ANhLgQ0axHxQikX+h/yTWXHpqrMTOLvx7yuSrRW6XPneTIZNxaeZrOZK
        w96wx3sBJjkL3OHHsgqW2fnc4d1v+xdX7WODrb6IWInk/LdTTH6hlO21VNmxNV9gW2jabLDclyT
        K4voQqhCDqQPsKWknwRIOLSEujFaL1rugOn3ZLg==
X-Received: by 2002:a63:3f88:: with SMTP id m130mr5785974pga.337.1583987029947;
        Wed, 11 Mar 2020 21:23:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vueaYoQgVXSilktc/GG+jFUFlkXljaxle0Lwg0ZpJTmkVgE8jO6UlWoCcrzZ1mPAFpxNFKfXA==
X-Received: by 2002:a63:3f88:: with SMTP id m130mr5785959pga.337.1583987029555;
        Wed, 11 Mar 2020 21:23:49 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id e14sm2181297pfn.196.2020.03.11.21.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 21:23:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] PCI/PM: Skip link training delay for S3 resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200311102811.GA2540@lahna.fi.intel.com>
Date:   Thu, 12 Mar 2020 12:23:46 +0800
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2C20385C-4BA4-4D6D-935A-AFDB97FAB5ED@canonical.com>
References: <20200311045249.5200-1-kai.heng.feng@canonical.com>
 <20200311102811.GA2540@lahna.fi.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> On Mar 11, 2020, at 18:28, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> Hi,
> 
> On Wed, Mar 11, 2020 at 12:52:49PM +0800, Kai-Heng Feng wrote:
>> Commit ad9001f2f411 ("PCI/PM: Add missing link delays required by the
>> PCIe spec") added a 1100ms delay on resume for bridges that don't
>> support Link Active Reporting.
>> 
>> The commit also states that the delay can be skipped for S3, as the
>> firmware should already handled the case for us.
> 
> Delay can be skipped if the firmware provides _DSM with function 8
> implemented according to PCI firmwre spec 3.2 sec 4.6.8.

As someone who doesn't have access to the PCI spec...
Questions below.

> 
>> So let's skip the link training delay for S3, to save 1100ms resume
>> time.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/pci/pci-driver.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 0454ca0e4e3f..3050375bad04 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -916,7 +916,8 @@ static int pci_pm_resume_noirq(struct device *dev)
>> 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>> 	pcie_pme_root_status_cleanup(pci_dev);
>> 
>> -	if (!skip_bus_pm && prev_state == PCI_D3cold)
>> +	if (!skip_bus_pm && prev_state == PCI_D3cold
>> +	    && !pm_resume_via_firmware())
> 
> So this would need to check for the _DSM result as well. We do evaluate
> it in pci_acpi_optimize_delay() (drivers/pci/pci-acpi.c) and that ends
> up lowering ->d3cold_delay so maybe check that here.

Do we need to wait for d3cold_delay here?
Or we can also skip that as long as pci_acpi_dsm_guid and FUNCTION_DELAY_DSM present?

Kai-Heng

> 
>> 		pci_bridge_wait_for_secondary_bus(pci_dev);
>> 
>> 	if (pci_has_legacy_pm_support(pci_dev))
>> -- 
>> 2.17.1

