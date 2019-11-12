Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD03F97F9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 18:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKLR7s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 12:59:48 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4515 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfKLR7s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Nov 2019 12:59:48 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcaf3160001>; Tue, 12 Nov 2019 09:59:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Nov 2019 09:59:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 09:59:47 -0800
Received: from [10.25.72.34] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 17:59:44 +0000
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>,
        "Andrew Murray" <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
References: <20191111223235.GA38578@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <453c4de8-b669-e76c-a2ad-bcdf50a47b57@nvidia.com>
Date:   Tue, 12 Nov 2019 23:29:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191111223235.GA38578@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573581590; bh=919ksCuhsXbHZe3S3NQglQj//PS2gSt/6z9QKAl2Wy8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jqs37QmJ/4JNe7JSHiaUkWOY0W8aWOsVsxtoP2kOy47w3mc+X0k1HHzCmGPAjBb1B
         iQZsEbgQ/78S3YQsS+0HCjvGbpWc6LGtC9tDMWKSh62duhT2v+RLLq3T7YBdvDHmdm
         MSoOddKu0VXxAHzqZmB4Z8GuZioSqPQN04wXX64NsF57/PGS8e6bcD5neKdTPGPVc9
         Sq9476FvdbFXTo6tO2LeSi1VlbfuL7WubuxDNifEh4SJz9ZsTyXvBsPwYinIDxVY2N
         oXajuFoqpVIi6RFFrY9EX4kA85PjKDeUMxK56oTAB3VWWniGemfQspx26Q6g6/CKhY
         etVxlIskUTstg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/12/2019 4:02 AM, Bjorn Helgaas wrote:
> On Mon, Nov 11, 2019 at 11:31:18AM +0530, Vidya Sagar wrote:
>> On 11/6/2019 10:11 PM, Bjorn Helgaas wrote:
> 
>>> Based on Vidya's backtrace, I think the resume path with problems
>>> is this:
>>>
>>>     pci_pm_resume_noirq
>>>       pci_pm_default_resume_early
>>>         pci_power_up
>>>           if (platform_pci_power_manageable(dev))
>>>             platform_pci_set_power_state(dev, PCI_D0)  # <-- FW delay here?
>>>           pci_raw_set_power_state
>>>           pci_update_current_state
>>>             pci_device_is_present        # <-- config read returns CRS
>>>
>>> So I think your suggestion is that Vidya's firmware should be
>>> doing the delay inside platform_pci_set_power_state()?
>>>
>>> Vidya, you typically work on Tegra, so I assume this is on an
>>> arm64 system?  Does it have ACPI?  Do you have access to the
>>> firmware developers to ask about who they expect to do the delays?
>>
>> Yes. This is on arm64 (Tegra) and we don't have any ACPI or any
>> other firmware for that matter. PCIe is brought up directly in the
>> kernel.
> 
> I assume that your device is coming out of D3cold because apparently
> you're seeing a CRS status from the config read when
> pci_update_current_state() calls pci_device_is_present().  CRS status
> should only happen after reset or power-on from D3cold, and you're not
> doing a reset.
> 
> I'm pretty sure platform_pci_power_manageable() returns false on
> your system (can you confirm that?) because the only scenarios with
> platform power management are MID (Intel platform) and ACPI (which you
> don't have).
Yes. I can confirm that platform_pci_power_manageable() is false in case of
Tegra.

> 
> Maybe you have some other platform-specific mechanism that controls
> power to PCI devices, and it's not integrated into the
> platform_pci_*() framework?
> 
> Bjorn
> 

