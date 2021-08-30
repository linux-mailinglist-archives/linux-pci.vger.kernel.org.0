Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5467F3FBA0A
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 18:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhH3QYZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 12:24:25 -0400
Received: from foss.arm.com ([217.140.110.172]:44160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232785AbhH3QYX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 12:24:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 480F91FB;
        Mon, 30 Aug 2021 09:23:29 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46A0E3F766;
        Mon, 30 Aug 2021 09:23:28 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] PCI: brcmstb: Add ACPI config space quirk
To:     nicolas saenz julienne <nsaenz@kernel.org>,
        linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210826071557.29239-1-jeremy.linton@arm.com>
 <20210826071557.29239-3-jeremy.linton@arm.com>
 <44ad79081412af289c68e74cdecb6a2baa2e873c.camel@kernel.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <5c39cf29-a08f-48d1-b873-ce0fda763d66@arm.com>
Date:   Mon, 30 Aug 2021 11:23:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <44ad79081412af289c68e74cdecb6a2baa2e873c.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/30/21 3:36 AM, nicolas saenz julienne wrote:
> Hi Jeremy,
> sorry for the late reply, I've been on vacation.
> 
> On Thu, 2021-08-26 at 02:15 -0500, Jeremy Linton wrote:
> 
> [...]
> 
>> +static void __iomem *brcm_pcie_map_conf2(struct pci_bus *bus,
>> +					unsigned int devfn, int where)
>> +{
>> +	struct pci_config_window *cfg = bus->sysdata;
>> +	void __iomem *base = cfg->win;
>> +	int idx;
>> +	u32 up;
>> +
>> +	/* Accesses to the RC go right to the RC registers if slot==0 */
>> +	if (pci_is_root_bus(bus))
>> +		return PCI_SLOT(devfn) ? NULL : base + where;
>> +
>> +	/*
>> +	 * Assure the link is up before sending requests downstream. This is done
>> +	 * to avoid sending transactions to EPs that don't exist. Link flap
>> +	 * conditions/etc make this race more probable. The resulting unrecoverable
>> +	 * SERRORs will result in the machine crashing.
>> +	 */
>> +	up = readl(base + PCIE_MISC_PCIE_STATUS);
>> +	if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK))
>> +		return NULL;
>> +
>> +	if (!(up & PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK))
>> +		return NULL;
> 
> Couldn't this be integrated in the original brcm_pcie_map_conf()? IIUC there is
> nothing ACPI specific about it. It'd also make for less code duplication.

That is where I started with this, but it wasn't the linkup check/etc 
which caused me to hoist it but the fact that if ACPI quirks are enabled 
they end up statically built into the kernel. While if this host bridge 
is enabled, it can end up being a module, and the resulting mess I 
created trying to satisfy the CONFIG variations. I'm not much of a fan 
of copy/paste programming, but that IMHO ended up being the cleanest here.

