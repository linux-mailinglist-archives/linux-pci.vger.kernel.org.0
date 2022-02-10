Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B8A4B14D1
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 19:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243996AbiBJR7s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 12:59:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245439AbiBJR7s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 12:59:48 -0500
X-Greylist: delayed 382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 09:59:48 PST
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA7F2D;
        Thu, 10 Feb 2022 09:59:48 -0800 (PST)
Message-ID: <b6032dd3-eb49-50dc-5847-484d8cc35195@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644515602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jGGXtZuM+egD69FXEvOYIvlU7UKlZOrjM0E5mMf6D8=;
        b=WqmTzxxG9nAZftgELIJe0xs5GpfBkJeFazaVzCiTTY+BXZES5aog1sKX0YTch2Fu0bdDvM
        6Dt6wOxvNsZMMQps89B6WK1/RQ3fZhSPqPJZfxdqhRk3oBTFmIOv5V54ofuBOa109mNonk
        yixSs4rj9Cn7hrw9EkbRr1YHBqPHpag=
Date:   Thu, 10 Feb 2022 10:52:59 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220209213638.GA587920@bhelgaas>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220209213638.GA587920@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/9/2022 2:36 PM, Bjorn Helgaas wrote:
> On Tue, Dec 07, 2021 at 02:15:04PM +0100, Rafael J. Wysocki wrote:
>> On Tue, Dec 7, 2021 at 12:12 AM Keith Busch <kbusch@kernel.org> wrote:
>>> On Fri, Dec 03, 2021 at 11:15:41AM +0800, Kai-Heng Feng wrote:
>>>> When Samsung PCIe Gen4 NVMe is connected to Intel ADL VMD, the
>>>> combination causes AER message flood and drags the system performance
>>>> down.
>>>>
>>>> The issue doesn't happen when VMD mode is disabled in BIOS, since AER
>>>> isn't enabled by acpi_pci_root_create() . When VMD mode is enabled, AER
>>>> is enabled regardless of _OSC:
>>>> [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
>>>> ...
>>>> [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146
>>>>
>>>> Since VMD is an aperture to regular PCIe root ports, honor ACPI _OSC to
>>>> disable PCIe features accordingly to resolve the issue.
>>>
>>> At least for some versions of this hardare, I recall ACPI is unaware of
>>> any devices in the VMD domain; the platform can not see past the VMD
>>> endpoint, so I throught the driver was supposed to always let the VMD
>>> domain use OS native support regardless of the parent's ACPI _OSC.
>>
>> This is orthogonal to whether or not ACPI is aware of the VMD domain
>> or the devices in it.
>>
>> If the platform firmware does not allow the OS to control specific
>> PCIe features at the physical host bridge level, that extends to the
>> VMD "bus", because it is just a way to expose a hidden part of the
>> PCIe hierarchy.
> 
> I don't understand what's going on here.  Do we understand the AER
> message flood?  Are we just papering over it by disabling AER?
> 
> If an error occurs below a VMD, who notices and reports it?  If we
> disable native AER below VMD because of _OSC, as this patch does, I
> guess we're assuming the platform will handle AER events below VMD.
> Is that really true?  Does the platform know how to find AER log
> registers of devices below VMD?
ACPI (and the specific UEFI implementation) might remain unaware of
VMD domains. It's possible that the system management mode (SMM)
controller which typically handles firmware-first errors would be
capable of handling VMD errors in the vendor-specific manner.
However if _OSC hadn't taken into account VMD ports, SMM wouldn't
be capable of handling those errors and silently disabling AER on
VMD domains is a bad idea.

The bugzilla made it sound like a specific platform/drive combination.
What about a DMI match to mask the Corrected Physical Layer bits?

> 
>> The platform firmware does that through ACPI _OSC under the host
>> bridge device (not under the VMD device) which it is very well aware
>> of.
