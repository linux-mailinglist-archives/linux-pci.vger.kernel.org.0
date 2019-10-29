Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32E5E9376
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 00:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfJ2XUI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 19:20:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:35939 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfJ2XUH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 19:20:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 16:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="scan'208";a="401318178"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2019 16:20:06 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id A68AF580517;
        Tue, 29 Oct 2019 16:20:05 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 5/8] PCI/AER: Allow clearing Error Status Register in
 FF mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <20191029230346.GA123765@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <4edd3d32-7f7e-fc25-b67b-40c202b7af3d@linux.intel.com>
Date:   Tue, 29 Oct 2019 16:17:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191029230346.GA123765@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/29/19 4:03 PM, Bjorn Helgaas wrote:
> On Tue, Oct 29, 2019 at 12:58:14PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> On 10/28/19 4:22 PM, Bjorn Helgaas wrote:
>>> On Thu, Oct 03, 2019 at 04:39:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> @@ -430,9 +424,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>>>>    	if (!pos)
>>>>    		return -EIO;
>>>> -	if (pcie_aer_get_firmware_first(dev))
>>>> -		return -EIO;
>>>> -
>>>>    	port_type = pci_pcie_type(dev);
>>>>    	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>>>>    		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
>>>> @@ -455,7 +446,8 @@ void pci_aer_init(struct pci_dev *dev)
>>>>    	if (dev->aer_cap)
>>>>    		dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
>>>> -	pci_cleanup_aer_error_status_regs(dev);
>>>> +	if (!pcie_aer_get_firmware_first(dev))
>>>> +		pci_cleanup_aer_error_status_regs(dev);
>>> This effectively moves the "if (pcie_aer_get_firmware_first())" check
>>> from pci_cleanup_aer_error_status_regs() into one of the callers.  But
>>> there are two other callers: pci_aer_init() and pci_restore_state().
>>> Do they need the change, or do you want to cleanup the AER error
>>> registers there, but not here?
>> Good catch. I have added this check to pci_aer_init(). But it needs
>> to be added to pci_restore_state() as well. Instead of moving the
>> checks to the caller, If you agree, I could change the API to
>> pci_cleanup_aer_error_status_regs(struct pci_dev *dev, bool
>> skip_ff_check) and let the caller decide whether they want skip the
>> check or not.
> If all callers of pci_cleanup_aer_error_status_regs() would have to
> check pcie_aer_get_firmware_first(), I don't understand why you're
> moving the check at all.

We need exception for the call made from DPC driver. If 
pcie_aer_get_firmware_first()
call is made from DPC driver during EDR mode execution, then FF mode 
check needs
to be skipped.

>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

