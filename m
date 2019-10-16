Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9978FD8508
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 02:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbfJPAsV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 20:48:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:12460 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfJPAsV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 20:48:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 17:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,301,1566889200"; 
   d="scan'208";a="194683484"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 15 Oct 2019 17:48:18 -0700
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, bhelgaas@google.com,
        dwmw2@infradead.org, neugebar@amazon.co.uk
Subject: Re: [PATCH 0/2] iommu/dmar: expose fault counters via sysfs
To:     Yuri Volchkov <volchkov@amazon.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20191015151112.17225-1-volchkov@amazon.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <005c9cae-be2a-80a7-6e78-ed535160350a@linux.intel.com>
Date:   Wed, 16 Oct 2019 08:45:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015151112.17225-1-volchkov@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/15/19 11:11 PM, Yuri Volchkov wrote:
> For health monitoring, it can be useful to know if iommu is behaving as
> expected. DMAR faults can be an indicator that a device:
>   - has been misconfigured, or
>   - has experienced a hardware hiccup and replacement should
>     be considered, or
>   - has been issuing faults due to malicious activity
> 
> Currently the only way to check if there were any DMAR faults on the
> host is to scan the dmesg output. However this approach is not very
> elegant. The information we are looking for can be wrapped out of the
> buffer, or masked (since it is a rate-limited print) by another
> device.
> 
> The series adds counters for DMAR faults and exposes them via sysfs.
> 

We now have an iommu API named iommu_register_fault_handler() to
register callbacks for dmar faults. How about monitoring the dmar
fault through this api so that your code could be generic and vendor
agnostic?

Best regards,
Baolu

> Yuri Volchkov (2):
>    iommu/dmar: collect fault statistics
>    iommu/dmar: catch early fault occurrences
> 
>   drivers/iommu/dmar.c        | 182 ++++++++++++++++++++++++++++++++----
>   drivers/iommu/intel-iommu.c |   1 +
>   drivers/pci/pci-sysfs.c     |  20 ++++
>   include/linux/intel-iommu.h |   4 +
>   include/linux/pci.h         |  11 +++
>   5 files changed, 201 insertions(+), 17 deletions(-)
> 
