Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1466182595
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 00:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgCKXKZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 19:10:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:12133 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbgCKXKZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 19:10:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 16:10:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="322286118"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 11 Mar 2020 16:10:24 -0700
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id 3ADED58033E;
        Wed, 11 Mar 2020 16:10:24 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin.Bolen@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200311222352.GA200510@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <a4b4b4b0-3c56-51a0-4237-dd439fca3150@linux.intel.com>
Date:   Wed, 11 Mar 2020 16:07:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311222352.GA200510@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Re-sending the response in text mode.

On 3/11/20 3:23 PM, Bjorn Helgaas wrote:
> Is any synchronization needed here between the EDR path and the
> hotplug/enumeration path?
If we want to follow the implementation note step by step (in sequence) then
we need some synchronization between EDR path and enumeration path. But
if its OK the achieve the same end result by following steps out of sequence
then we don't need to create any dependency between EDR and enumeration
paths. Currently we follow the later approach.

For example, consider the case in flow chart where after sending success 
_OST,
firmware decides to stop the recovery of the device.

if we follow the flow chart as its then the steps should be,

1. clear the DPC status trigger
2. Send success code via _OST, and wait for return from _OST
3. if successful return then enumerate the child devices and reassign 
bus numbers.

In current approach the steps followed are,

1. Clear the DPC status trigger.
2. Send success code via _OST
2. In parallel, LINK UP event path will enumerate the child devices.
3. if firmware decides not to recover the device,  then LINK DOWN event 
will eventually
     remove them again.

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

