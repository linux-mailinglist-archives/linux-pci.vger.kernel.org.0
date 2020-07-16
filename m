Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0982D221C39
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 07:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgGPF53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 01:57:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:21083 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgGPF53 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jul 2020 01:57:29 -0400
IronPort-SDR: SN3YeReBx3/xvVTO9vtz3DLFwtLxgdD6TGLhsWMTzy1ji330TepabSKX8fTFvATBp3BEXqUucI
 yv1RCEZlOT5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="148474320"
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="148474320"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 22:57:28 -0700
IronPort-SDR: MPGHtP5Mo5iznd3fSSzeBdWK+RCVI7u0o8wdolS9IgjK2FVvrdKLhk/4gEdIoKoGrZUhrty3v5
 QHnj9VIglqvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="269157167"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2020 22:57:27 -0700
Received: from [10.249.231.152] (abudanko-mobl.ccr.corp.intel.com [10.249.231.152])
        by linux.intel.com (Postfix) with ESMTP id 26BED580821;
        Wed, 15 Jul 2020 22:57:24 -0700 (PDT)
Subject: Re: [PATCH V3 3/3] platform/x86: Intel PMT Telemetry capability
 driver
To:     david.e.box@linux.intel.com, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>
References: <20200508021844.6911-1-david.e.box@linux.intel.com>
 <20200714062323.19990-4-david.e.box@linux.intel.com>
 <727a75a0-3fb5-769a-cf1f-70a2a0bab0c8@linux.intel.com>
 <245ecc65a839bd69413045ae5ee307ba03ca0869.camel@linux.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8a580318-9bd4-1146-f2e9-6cb851828762@linux.intel.com>
Date:   Thu, 16 Jul 2020 08:57:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <245ecc65a839bd69413045ae5ee307ba03ca0869.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 16.07.2020 2:59, David E. Box wrote:
> On Wed, 2020-07-15 at 10:39 +0300, Alexey Budankov wrote:
>> Hi David,
>>
>> On 14.07.2020 9:23, David E. Box wrote:
> 
> ...
> 
>>>
>>> +static int pmt_telem_open(struct inode *inode, struct file *filp)
>>> +{
>>> +	struct pmt_telem_priv *priv;
>>> +	struct pmt_telem_entry *entry;
>>> +	struct pci_driver *pci_drv;
>>> +	struct pci_dev *pci_dev;
>>> +
>>> +	if (!capable(CAP_SYS_ADMIN))
>>
>> Thanks for supplying these patches.
>> Are there any reasons not to expose this feature to CAP_PERFMON
>> privileged
>> processes too that currently have access to performance monitoring
>> features
>> of the kernel without root/CAP_SYS_ADMIN credentials? This could be
>> done by
>> pefmon_capable() function call starting from v5.8+.
> 
> The new capability is well suited for this feature. I'll make the
> change. Thanks.

I appreciate your cooperation. Thanks!

Alexei
