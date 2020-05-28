Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D217C1E54D0
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 05:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgE1D5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 23:57:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:61851 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgE1D5Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 23:57:24 -0400
IronPort-SDR: kkNArJ+smRrZ9sjhjx+bvXgPRL9jbTlNPwjW+0ptniy7p6zmZL0pGoSSYIm2+FIqx1rYfF7f5P
 lQDYgWMus1EA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 20:57:24 -0700
IronPort-SDR: 3S6L/iXfskcvbYhIzRmImXaUvfA2+HKW5UtcpSeXhdWNdrII+EDGo/MfL2BQhBOrSfj2BQ2edd
 z31UXpJcgA5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="414459895"
Received: from davidowe-mobl.amr.corp.intel.com (HELO [10.255.229.1]) ([10.255.229.1])
  by orsmga004.jf.intel.com with ESMTP; 27 May 2020 20:57:23 -0700
Subject: Re: [PATCH v1 1/1] PCI/ERR: Handle fatal error recovery for
 non-hotplug capable devices
To:     Yicong Yang <yangyicong@hisilicon.com>, bhelgaas@google.com
Cc:     jay.vosburgh@canonical.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <18609.1588812972@famine>
 <f4bbacd3af453285271c8fc733652969e11b84f8.1588821160.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <dbb211ba-a5f1-0e4f-64c9-6eb28cd1fb7f@hisilicon.com>
 <2569c75c-41a6-d0f3-ee34-0d288c4e0b61@linux.intel.com>
 <8dd2233c-a636-59fa-4c6e-5da08556d09e@hisilicon.com>
 <d59e5312-9f0b-f6b2-042a-363022989b8f@linux.intel.com>
 <d7a392e0-4be0-1afb-b917-efa03e2ea2fb@hisilicon.com>
 <f9a46300-ef4b-be19-b8cf-bcb876c75d62@linux.intel.com>
 <d59a5ec4-1a83-6cd4-805e-24e0a611cc3c@hisilicon.com>
 <9b2aecd8-b474-31b7-7cd2-1a8633a2485d@linux.intel.com>
 <a4bb15a1-2524-b4f7-524b-840ae41f9b49@hisilicon.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <7b15ffd4-ac9b-6753-63a7-dc6e2bfa30c8@linux.intel.com>
Date:   Wed, 27 May 2020 20:57:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a4bb15a1-2524-b4f7-524b-840ae41f9b49@hisilicon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/26/20 11:41 PM, Yicong Yang wrote:
>>> We should do slot reset if driver required, but it's different from the `slot reset` in pci_bus_error_reset().
>>> Previously we don't do a slot reset and call ->slot_reset() directly, I don't know the certain reason.
>> IIUC, your concern is whether it is correct to trigger reset for
>> pci_channel_io_normal case right ? Please correct me if my
>> assumption is incorrect.
> right.
> 
>> If its true, then why would report_error_detected() will return
>> PCI_ERS_*_NEED_RESET for pci_channel_io_normal case ? If
>> report_error_detected() requests reset in pci_channel_io_normal
>> case then I think we should give preference to it.
> If we get PCI_ERS_*_NEED_RESET, we should do slot reset, no matter it's a
> hotpluggable slot or not.

pci_slot_reset() function itself has dependency on hotplug ops. So
what kind of slot reset is needed for non-hotplug case?

static int pci_slot_reset(struct pci_slot *slot, int probe)
{
	int rc;

	if (!slot || !pci_slot_resetable(slot))
		return -ENOTTY;

	if (!probe)
		pci_slot_lock(slot);

	might_sleep();

	rc = pci_reset_hotplug_slot(slot->hotplug, probe);

	if (!probe)
		pci_slot_unlock(slot);

	return rc;
}

static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
{
	int rc = -ENOTTY;

	if (!hotplug || !try_module_get(hotplug->owner))
		return rc;

	if (hotplug->ops->reset_slot)
		rc = hotplug->ops->reset_slot(hotplug, probe);

	module_put(hotplug->owner);

	return rc;
}
   And we shouldn't do it here in reset_link(), that's
> two separate things.  The `slot reset` done in aer_root_reset() is only for *link
> reset*, as there may have some side effects to perform secondary bus reset directly
> for hotpluggable slot, as mentioned in commit c4eed62a2143, so it use slot reset
> to do the reset link things.
> 
> As for slot reset required by the driver, we should perform it later just before the
> ->slot_reset(). I noticed the TODO comments there and we should implement
> it if it's necessary.
I agree.
> 
> It lies in line 183, drivers/pcie/err.c:
> 
>      if (status == PCI_ERS_RESULT_NEED_RESET) {
>          /*
>           * TODO: Should call platform-specific
>           * functions to reset slot before calling
>           * drivers' slot_reset callbacks?
>           */
>          status = PCI_ERS_RESULT_RECOVERED;
>          pci_dbg(dev, "broadcast slot_reset message\n");
>          pci_walk_bus(bus, report_slot_reset, &status);
>      }
> 
> 
