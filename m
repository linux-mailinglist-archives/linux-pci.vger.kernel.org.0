Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DBB3D2C18
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhGVSFE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 14:05:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:44594 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhGVSFE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 14:05:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="275537704"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="275537704"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:45:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="470759917"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.213.166.173]) ([10.213.166.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:45:38 -0700
Subject: Re: [PATCH v2 1/2] PCI: vmd: Trigger secondary bus reset
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org
References: <20210720205009.111806-1-nirmal.patel@linux.intel.com>
 <20210720205009.111806-2-nirmal.patel@linux.intel.com>
 <YPe0k1bkj7v33vrM@infradead.org>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Message-ID: <058a3c39-b1de-4f8c-2f9a-bd454bc7c5a9@linux.intel.com>
Date:   Thu, 22 Jul 2021 11:45:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPe0k1bkj7v33vrM@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/20/2021 10:45 PM, Christoph Hellwig wrote:
> On Tue, Jul 20, 2021 at 01:50:08PM -0700, Nirmal Patel wrote:
>> +#define PCI_HEADER_TYPE_MASK 0x7f
>> +#define PCI_CLASS_BRIDGE_PCI 0x0604
> Please use the existing definitions from pci_regs.h / pci_ids.h.
Sure.
>
>> +#define DEVICE_SPACE (8 * 4096)
>> +#define VMD_DEVICE_BASE(vmd, device) ((vmd)->cfgbar + (device) * DEVICE_SPACE)
>> +#define VMD_FUNCTION_BASE(vmd, device, fn) ((vmd)->cfgbar + (device) * (DEVICE_SPACE + (fn*4096)))
> Plase turn thos into readable inline functions and avoid the overly long
> lines.
Sure.
>
>> +	/*
>> +	* Subdevice config space may or many not be mapped linearly using 4k config
>> +	* space.
>> +	*/
> Please avoid the overly long line, especially in a comment.
It is better to remove this confusing comment.


