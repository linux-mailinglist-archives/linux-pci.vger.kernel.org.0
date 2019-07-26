Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFAF774FE
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2019 01:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfGZXdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jul 2019 19:33:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:22318 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfGZXds (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jul 2019 19:33:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 16:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,312,1559545200"; 
   d="scan'208";a="175767297"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2019 16:33:48 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 1371E580107;
        Fri, 26 Jul 2019 16:33:48 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 0/9] Add Error Disconnect Recover (EDR) support
To:     Keith Busch <kbusch@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        keith.busch@intel.com, Austin.Bolen@dell.com, Huong.Nguyen@dell.com
References: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190726215311.GA8720@localhost.localdomain>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <683fffda-7116-a67b-02ab-503c0efc6853@linux.intel.com>
Date:   Fri, 26 Jul 2019 16:31:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726215311.GA8720@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Austin , Huong

On 7/26/19 2:53 PM, Keith Busch wrote:
> On Fri, Jul 26, 2019 at 02:43:10PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> This patchset adds support for following features:
>>
>> 1. Error Disconnect Recover (EDR) support.
>> 2. _OSC based negotiation support for DPC.
>>
>> You can find EDR spec in the following link.
>>
>> https://members.pcisig.com/wg/PCI-SIG/document/12614
> Thank you for sticking with this. I've reviewed the series and I think
> this looks good for the next merge window.
>
> Acked-by: Keith Busch <keith.busch@intel.com>
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

