Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAB317AEE8
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 20:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgCETYv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Mar 2020 14:24:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:41709 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgCETYv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Mar 2020 14:24:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 11:24:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="275222791"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 05 Mar 2020 11:24:49 -0800
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id 392715802A3;
        Thu,  5 Mar 2020 11:24:49 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v16 7/9] PCI/DPC: Export DPC error recovery functions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200305185946.GA99050@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <bcd48776-403d-3e6d-ec72-0b3b8376830d@linux.intel.com>
Date:   Thu, 5 Mar 2020 11:22:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305185946.GA99050@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/5/20 10:59 AM, Bjorn Helgaas wrote:
> On Thu, Mar 05, 2020 at 09:42:21AM -0800, Kuppuswamy Sathyanarayanan wrote:
>> Hi,
>>
>> On 3/5/20 8:37 AM, Christoph Hellwig wrote:
>>> Please fix your subject.  Nothing is being exported in this patch.
>> I will do it. I meant it as its being used outside dpc..
> I'll update this.  I have some other tweaks so I'll post an updated
> series soon.
In case if you haven't noticed, I have posted v17 version of it. please 
apply
your changes on top of it.

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

