Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D228AB620
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 12:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfIFKjr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 06:39:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:19708 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfIFKjr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Sep 2019 06:39:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 03:39:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="199493528"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2019 03:39:46 -0700
Received: from [10.226.38.242] (ekotax-mobl.gar.corp.intel.com [10.226.38.242])
        by linux.intel.com (Postfix) with ESMTP id 07DEA5800FE;
        Fri,  6 Sep 2019 03:39:43 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
 <54ec6a30-69d8-a4af-95fa-2f457d605142@linux.intel.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <e8ead144-dd4a-0ffc-6266-920f045250f3@linux.intel.com>
Date:   Fri, 6 Sep 2019 18:39:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <54ec6a30-69d8-a4af-95fa-2f457d605142@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Chuan Hua,

On 9/5/2019 10:23 AM, Chuan Hua, Lei wrote:
> Hi Dilip,
>
> On 9/4/2019 6:10 PM, Dilip Kota wrote:
>> The Intel PCIe RC controller is Synopsys Designware
>> based PCIe core. Add YAML schemas for PCIe in RC mode
>> present in Intel Universal Gateway soc.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>> changes on v3:
>>     Add the appropriate License-Identifier
>>     Rename intel,rst-interval to 'reset-assert-us'
> rst->interval to reset-assert-ms(should be typo error)

Sure, i will fix it. That's a typo error.
Thanks for pointing it.

Regards
Dilip


