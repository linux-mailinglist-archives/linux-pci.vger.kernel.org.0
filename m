Return-Path: <linux-pci+bounces-32100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E164B04BA3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 01:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F327B46EC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 23:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3068248C;
	Mon, 14 Jul 2025 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQMCHqqJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8C1F3BAC
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534009; cv=none; b=dLehPg88z1n26hlhpbcOc1s37IPZF698O1IOqKJp1IBftw/tfo4+68ApQ9CK1ow9fCUpAZB2OlHMPBMI5qfi++iAoNBdu3sD6Cp+MWF5FGjxhjnDMvwl2SH5QPlY4lrLs2Eij4gkgIUh5zz5FOG7WPpvGcCRm4NzoTYqP5LPVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534009; c=relaxed/simple;
	bh=vXneDlDeK56VVeo5rweumy4oJJMpJJ5K4H02OWVI+u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPxO2cv9BxhtNvqKfdXZQoakfO1+hz4kqP1tfGWYRR494o1UbMlnVJA1ydnlPRMAjTkqWfhHhvNDF/Vx5QQApySjGiFWqaRaMeAaEzQYtXcuLkld7k5n/XbVg9Xa/+T/JG5FIGZxhjWR2Oe2h99jARc8+FLcbDCCG11sdW28L2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQMCHqqJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752534008; x=1784070008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vXneDlDeK56VVeo5rweumy4oJJMpJJ5K4H02OWVI+u0=;
  b=cQMCHqqJq0D+jXE/DFySMQZOgJtxvitRzsH8N1GmxHYjKuoZ1FMeAClk
   tr0pOjsUKxjlcxlzlpi7wU7F3Vsur/b2v4TLRer6a1wvyDhL229osVTfs
   iKWgiVkFcw//hvSvdbnt7qGHUCK9yrr+muZMISCO/of7LzfM9/yHVsAQ3
   1LDGa2tLW7SUE/sDyfM2wIhcbjRmOD/3Xq05c3JdjyKerlJz4BjA8c1CC
   gefhNWJ5m5sf9KEti8hDY+CURB2NaUUr16Xl0Qf39zLUs40kOgVpvED1a
   dBPgDPcO1yNBFfmjMrJY6MWU812aFdZPnrffAL3g1zMSLaiGOoJI4y5EI
   Q==;
X-CSE-ConnectionGUID: XHr6DzMtR2O8Hrh3CpBkdw==
X-CSE-MsgGUID: PtNBjVFVQ5SMWH9uTjcyAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72315991"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="72315991"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 16:00:07 -0700
X-CSE-ConnectionGUID: alPrH+OeTuOrPSFl1lfJPg==
X-CSE-MsgGUID: 1GoyWPTGRVO1FEC4jAX5Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="156863444"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 16:00:07 -0700
Received: from [10.124.223.145] (unknown [10.124.223.145])
	by linux.intel.com (Postfix) with ESMTP id 3DDF720B571C;
	Mon, 14 Jul 2025 16:00:06 -0700 (PDT)
Message-ID: <b6c11a92-454c-44db-b072-e2291b37272c@linux.intel.com>
Date: Mon, 14 Jul 2025 16:00:05 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] PCI: Set native_pcie_hotplug up front based on
 pcie_ports_native
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg
 <westeri@kernel.org>, Alan Borzeszkowski
 <alan.borzeszkowski@linux.intel.com>, Gil Fine <gil.fine@linux.intel.com>,
 Rene Sapiens <rene.sapiens@intel.com>, linux-pci@vger.kernel.org
References: <cover.1752390101.git.lukas@wunner.de>
 <5eae82776d695e589b89aad500d8208b980347e5.1752390102.git.lukas@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <5eae82776d695e589b89aad500d8208b980347e5.1752390102.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/13/25 7:31 AM, Lukas Wunner wrote:
> Bjorn suggests to "set host->native_pcie_hotplug up front based on
> CONFIG_HOTPLUG_PCI_PCIE and pcie_ports_native, and pciehp_is_native()
> would collapse to just an accessor for host->native_pcie_hotplug".
>
> Unfortunately only half of this is possible:
>
> The check for pcie_ports_native can indeed be moved out of
> pciehp_is_native() and into acpi_pci_root_create().
>
> The check for CONFIG_HOTPLUG_PCI_PCIE however cannot be eliminated:
>
> get_port_device_capability() needs to know whether platform firmware has
> granted PCIe Native Hot-Plug control to the operating system.  If it has
> and CONFIG_HOTPLUG_PCI_PCIE is disabled, the function disables hotplug
> interrupts in case BIOS left them enabled.
>
> If host->native_pcie_hotplug would be set up front based on
> CONFIG_HOTPLUG_PCI_PCIE, it would later on be impossible for
> get_port_device_capability() to tell whether it can safely disable hotplug
> interrupts:  It wouldn't know whether Native Hot-Plug control was granted.

Since pcie_ports_native is a PCI driver specific override option, I am not
sure it is worth referring to this option in ACPI driver, just to reduce the
number of pcie_ports_native checks from 2 to 1.

> Link: https://lore.kernel.org/r/20250627025607.GA1650254@bhelgaas/
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>   drivers/acpi/pci_root.c    | 3 ++-
>   drivers/pci/pci-acpi.c     | 3 ---
>   drivers/pci/pcie/portdrv.c | 2 +-
>   3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 74ade4160314..f3de0dc9c533 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -1028,7 +1028,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>   		goto out_release_info;
>   
>   	host_bridge = to_pci_host_bridge(bus->bridge);
> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
> +	if (!pcie_ports_native &&
> +	    !(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
>   		host_bridge->native_pcie_hotplug = 0;
>   	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
>   		host_bridge->native_shpc_hotplug = 0;
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index ed7ed66a595b..b513826ea293 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -820,9 +820,6 @@ bool pciehp_is_native(struct pci_dev *bridge)
>   	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>   		return false;
>   
> -	if (pcie_ports_native)
> -		return true;
> -
>   	host = pci_find_host_bridge(bridge->bus);
>   	return host->native_pcie_hotplug;
>   }
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index d1b68c18444f..fa83ebdcfecb 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -223,7 +223,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>   	if (dev->is_pciehp &&
>   	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>   	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
> -	    (pcie_ports_native || host->native_pcie_hotplug)) {
> +	    host->native_pcie_hotplug) {
>   		services |= PCIE_PORT_SERVICE_HP;
>   
>   		/*

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


