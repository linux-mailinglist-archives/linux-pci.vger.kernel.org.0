Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086031969AD
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 22:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgC1Vzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 17:55:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:18384 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgC1Vzv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 17:55:51 -0400
IronPort-SDR: jMwL8oLlxZWXVG7CfpkbPbLKtH2C2TbT2r6LgAp8S8NEX2RdDQhKhMYpn1cUoVwb4YDk8GWq0C
 Miq+cjtVJ+vg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 14:55:51 -0700
IronPort-SDR: b6VcZ2A2a6MdrzFoVlo5Z9KXsPFNXA9DRFiw714UyVJBw/ATSfLQ9A9Mg03oADHPYV95I/J3lm
 sxnmRtzKaW/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="447822949"
Received: from ssafrin-mobl.ger.corp.intel.com (HELO [10.255.229.125]) ([10.255.229.125])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2020 14:55:50 -0700
Subject: Re: [PATCH v18 05/11] PCI/ERR: Remove service dependency in
 pcie_do_recovery()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200328213241.GA127815@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <110653ad-fd8f-8047-62de-dd9ce2cb9d5f@linux.intel.com>
Date:   Sat, 28 Mar 2020 14:55:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200328213241.GA127815@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/28/20 2:32 PM, Bjorn Helgaas wrote:
> On Sat, Mar 28, 2020 at 02:12:48PM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> On 3/23/20 5:26 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>
>>
>>> +void pcie_do_recovery(struct pci_dev *dev,
>>> +		      enum pci_channel_state state,
>>> +		      pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>>>    {
>>>    	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>>>    	struct pci_bus *bus;
>>> @@ -206,9 +165,12 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>>>    	pci_dbg(dev, "broadcast error_detected message\n");
>>>    	if (state == pci_channel_io_frozen) {
>>>    		pci_walk_bus(bus, report_frozen_detected, &status);
>>> -		status = reset_link(dev, service);
>>> -		if 		if (reset_link)
>> 			status = reset_link(dev);(status == PCI_ERS_RESULT_DISCONNECT
>>> +		status = reset_link(dev);
>> Above line needs to be replaced as below. Since there is a
>> possibility reset_link can NULL (eventhough currently its
>> not true).
>> 		if (reset_link)
>> 			status = reset_link(dev);
>> Shall I submit another version to add above fix on top of
>> our pci/edr branch ?
> 
> No, I can squash that in if needed.
> 
> But I don't actually think we *do* need it.  All the callers supply a
> valid reset_link function pointer, and if somebody changes or adds a
> new one that doesn't, I'd rather take the null pointer exception and
> find out about it than silently ignore it.
But the documentation says "If reset_link is not NULL, recovery function
will use it to reset the link." It considers NULL as a possible case.
So I think its better to allow that case with a pci_warn() message.
> 
> Bjorn
> 
