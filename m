Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F372ED765
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 20:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbhAGTTg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 14:19:36 -0500
Received: from foss.arm.com ([217.140.110.172]:38138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbhAGTTg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 14:19:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 864DAD6E;
        Thu,  7 Jan 2021 11:18:50 -0800 (PST)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 117443F66E;
        Thu,  7 Jan 2021 11:18:50 -0800 (PST)
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        catalin.marinas@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <61558f73-9ac8-69fe-34c1-2074dec5f18a@arm.com>
Date:   Thu, 7 Jan 2021 13:18:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210107181416.GA3536@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 1/7/21 12:14 PM, Will Deacon wrote:
> On Mon, Jan 04, 2021 at 10:57:35PM -0600, Jeremy Linton wrote:
>> Given that most arm64 platform's PCI implementations needs quirks
>> to deal with problematic config accesses, this is a good place to
>> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
>> standard SMC conduit designed to provide a simple PCI config
>> accessor. This specification enhances the existing ACPI/PCI
>> abstraction and expects power, config, etc functionality is handled
>> by the platform. It also is very explicit that the resulting config
>> space registers must behave as is specified by the pci specification.
>>
>> Lets hook the normal ACPI/PCI config path, and when we detect
>> missing MADT data, attempt to probe the SMC conduit. If the conduit
>> exists and responds for the requested segment number (provided by the
>> ACPI namespace) attach a custom pci_ecam_ops which redirects
>> all config read/write requests to the firmware.
>>
>> This patch is based on the Arm PCI Config space access document @
>> https://developer.arm.com/documentation/den0115/latest
> 
> Why does firmware need to be involved with this at all? Can't we just
> quirk Linux when these broken designs show up in production? We'll need
> to modify Linux _anyway_ when the firmware interface isn't implemented
> correctly...


IMHO, The short answer is that having the quirk in the firmware keeps it 
centralized over multiple OSs and linux distro versions and avoids a lot 
of costly kernel->distro churning to backport/maintain quirks over a 
dozen distro versions.

There is also a long-term maintenance advantage since its hard for the 
kernel community as a  whole to have a good view of how long a 
particular model of machine is actually in use. For example, today we 
could ask are any of those xgene1's still in use and remove their 
quirks, but no one really has a clear view.

As far as working around the firmware, that is of course potentially 
problematic, but I think it is easier to say "fix the firmware if you 
want/need linux support" than it is to get people to fix their ECAM 
implementations. Hypothetically, if at some point there is a broken 
version of this interface in firmware, the kernel could choose to bypass 
it entirely and talk to whatever broken config space method the hardware 
implements. At which point we aren't any worse off than the situation 
today.

The flip side of this is that a fair number of these platforms have open 
source firmware as well, so it may be trivial to fix the firmware.

Thanks for looking a this!

