Return-Path: <linux-pci+bounces-4367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3DA86EEF5
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 07:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3B9284AC7
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 06:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E311851;
	Sat,  2 Mar 2024 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmuZ7eow"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB69138E;
	Sat,  2 Mar 2024 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709361189; cv=none; b=tNoWo+gz1AS/cbZrGmtIOCAwJJMdt9nDSGsjAANj+txmc/heGhWtfEoH0YQALxw1zNGGdCcIUIgyhF0hBlXPPx7bWXKE3QDz1sf26YQ6BM/dHXEl0KYefqttXsB1Bw0C/owM9MAmn9t4AyBtQQBUwNTRCcNS+9co1qU2zkt8hLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709361189; c=relaxed/simple;
	bh=lA4yJKkSj4qyL9RLV97OYeq5BepsuYk8h8UNkJPrmfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+wBggWGV/L/TGdgWKQXGK3r8JfcEJ8/H4tKfhb1jYzZe7nwljPea03CMOzpWTSLZNGeoQybnsWbnodyrOXJwiDMUQ3g+NtWvyWooJvuiZRzlHniYpSNtAiJBwlKDltqztRm57hsusMXGboRwbePqjbKCiNjjBFKlTeB12uuCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmuZ7eow; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709361187; x=1740897187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lA4yJKkSj4qyL9RLV97OYeq5BepsuYk8h8UNkJPrmfQ=;
  b=VmuZ7eowenfb1oc3+ifaGuHWlk9owVWci1bF5Gp5uE2f25KSm2I4Qh/K
   9vyFxNhJJbaQ1JIf6pF82dx1pavnBJ8uahuFS7rUtd+9m8LKgwJmtJLcd
   e5nLr7BZrcCQ5rOtcPtlnmeTnHU22hkXadeR6KH7OCIDYUOfMogp062UE
   7sYT5SwjFxyUDtW+lACtivo5/1HhOmXpwq6i1sv9LcU5VcLYJaYhBYnYm
   09Qf95dQVExllVP3XUYQd26w9jxuvIpmOzlqiSrbIuGVtaVJK4MOamusT
   fzgJAXqHSGo6K77ER4Wti7b14p3+MImPYx/xEyjnBy+7g5x/zAmg1lYu5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7684356"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="7684356"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 22:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8796171"
Received: from doney-mobl.amr.corp.intel.com (HELO [10.209.53.18]) ([10.209.53.18])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 22:33:06 -0800
Message-ID: <6eb1f028-f606-4bd5-a64e-12802708323c@linux.intel.com>
Date: Fri, 1 Mar 2024 22:33:06 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] PCI/ASPM: Add notes about enabling PCI-PM L1SS to
 pci_enable_link_state(_locked)
Content-Language: en-US
To: Jian-Hong Pan <jhp@endlessos.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Johan Hovold <johan@kernel.org>, David Box <david.e.box@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@endlessos.org
References: <20240216062559.247479-3-jhp@endlessos.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240216062559.247479-3-jhp@endlessos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/15/24 10:26 PM, Jian-Hong Pan wrote:
> According to PCI Express Base Specification Revision 6.0, Section 5.5.4:
> "If setting either or both of the enable bits for PCI-PM L1 PM Substates,
> both ports must be configured as described in this section while in D0."
>
> Add notes into pci_enable_link_state(_locked) for kernel-doc. Hope these
> notify callers ensuring the devices in D0, if PCI-PM L1 PM Substates are
> going to be enabled.
>
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---

Looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> v3:
> - Fix as readable comments
>
> v4:
> - The same
>
>  drivers/pci/pcie/aspm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 7f1d674ff171..a39d2ee744cb 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1416,6 +1416,9 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>   * touch the LNKCTL register. Also note that this does not enable states
>   * disabled by pci_disable_link_state(). Return 0 or a negative errno.
>   *
> + * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
> + * PCIe r6.0, sec 5.5.4.
> + *
>   * @pdev: PCI device
>   * @state: Mask of ASPM link states to enable
>   */
> @@ -1432,6 +1435,9 @@ EXPORT_SYMBOL(pci_enable_link_state);
>   * can't touch the LNKCTL register. Also note that this does not enable states
>   * disabled by pci_disable_link_state(). Return 0 or a negative errno.
>   *
> + * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
> + * PCIe r6.0, sec 5.5.4.
> + *
>   * @pdev: PCI device
>   * @state: Mask of ASPM link states to enable
>   *

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


