Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3B521544
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 10:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfEQIT7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 04:19:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11795 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfEQIT7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 04:19:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cde6eb40000>; Fri, 17 May 2019 01:20:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 May 2019 01:19:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 May 2019 01:19:58 -0700
Received: from [10.24.47.197] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 08:19:52 +0000
Subject: Re: [PATCH V6 02/15] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-3-vidyas@nvidia.com>
 <20190513072539.GA27708@infradead.org>
 <3a8cea93-2aeb-e5e2-4d56-f0c6449073c3@nvidia.com>
 <20190516133426.GC101793@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <bd08ccaa-c6ee-f966-91e4-bcd5d99d5cf2@nvidia.com>
Date:   Fri, 17 May 2019 13:49:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516133426.GC101793@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558081204; bh=7E+nwQQsltOhNZTMZRtiT6upSwPTXBC0GyTnK7lGcQc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PIZR+FdgqtUqHfH3RaSJwY5WHI0FbtL4N5qOhHWlKa2YHOp7bBX7cWzl4ZxjDJHrG
         b8kDPynQK0jrZZMrDPYUiDGSdFZsxeoBcfH8vVGuNP8JOXbBNEB47xTBrc2CP2LHlH
         f9bM30qiw4vC1GyoKCGovtTkgpIFS/7+toa5YKkljDcZ3fCpr4qkw5CT2nl07Nkuxh
         CYX8t/cEBvFWblrcfcpefgF177Ux3urnY9Wj/cMrbHKErCw3noqYqtuVs9AR4O5UVB
         ki6lW2NtnGaZI/R78Yi+XM+rpqojgnSAkh6j+a+YZfL4jGO6bHnfC97c81qtzqvufC
         u+mg3bAalPI4w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/16/2019 7:04 PM, Bjorn Helgaas wrote:
> On Tue, May 14, 2019 at 09:00:19AM +0530, Vidya Sagar wrote:
>> On 5/13/2019 12:55 PM, Christoph Hellwig wrote:
>>> On Mon, May 13, 2019 at 10:36:13AM +0530, Vidya Sagar wrote:
>>>> Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs to enable drivers
>>>> using these APIs be able to build as loadable modules.
>>>
>>> But this is a global setting.  If you root port is broken you need
>>> a per-rootport quirk instead.
>>>
>> There is nothing broken in Tegra194 root port as such, rather, this
>> is more of software configuration choice and we are going with
>> legacy interrupts than MSI interrupts (as Tegra194 doesn't support
>> raising PME interrupts through MSI and please note that this doesn't
>> mean root port is broken).
> 
> I think the port *is* broken.  PCIe r4.0, sec 6.1.6, says
> 
>    If the Root Port is enabled for edge-triggered interrupt signaling
>    using MSI or MSI-X, an interrupt message must be sent every time the
>    logical AND of the following conditions transitions from FALSE to
>    TRUE:
> 
>      * The associated vector is unmasked (not applicable if MSI does
>        not support PVM).
> 
>      * The PME Interrupt Enable bit in the Root Control register is set
>        to 1b.
> 
>      * The PME Status bit in the Root Status register is set.
> 
> The Tegra194 root port advertises MSI support, so the above should
> apply.
I had a discussion with our hardware engineers and we are of the opinion
that the root port is not really broken w.r.t MSI as spec doesn't clearly
say that if root port advertises MSI support, it must generate MSI interrupts
for PME. All that it says is, if MSI is enabled, then MSI should be raised
for PME events. Here, by 'enable', we understand that as enabling at
hardware level to generate MSI interrupt which is not the case with Tegra194.
In Tegra194, root port is enabled to generate MSI only for hot-plug events and
legacy interrupts are used for PME, AER. Having said that I'm fine to add a
quick based on Vendor-ID and Device-IDs of root port in Tegra194 to set
pdev->no_msi to '1'.

> 
>> Since Tegra194 has only Synopsys DesignWare core based host
>> controllers and not any other hosts, I think it is fine to call this
>> API in driver.
> 
> It's fine to add a per-device quirk to set pdev->no_msi or something
> similar.
> 
> Bjorn
> 

