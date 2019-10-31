Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA079EADD6
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 11:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfJaKvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 06:51:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:11209 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfJaKvV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Oct 2019 06:51:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 03:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="283852650"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 31 Oct 2019 03:51:20 -0700
Received: from [10.226.39.46] (unknown [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id D33025802C8;
        Thu, 31 Oct 2019 03:51:17 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <710257e49c4b3d07fa98b3e5a829b807f74b54d7.1571638827.git.eswara.kota@linux.intel.com>
 <20191025165352.GA30602@bogus>
 <72d46086-0918-a5af-d798-7488b55a8e07@linux.intel.com>
Message-ID: <24f17c73-6e90-ae7e-72a7-5223f0f5b5fd@linux.intel.com>
Date:   Thu, 31 Oct 2019 18:51:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <72d46086-0918-a5af-d798-7488b55a8e07@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/29/2019 4:34 PM, Dilip Kota wrote:
>
> On 10/26/2019 12:53 AM, Rob Herring wrote:
>> On Mon, Oct 21, 2019 at 02:39:18PM +0800, Dilip Kota wrote:
>>> Add YAML shcemas for PCIe RC controller on Intel Gateway SoCs
>>> which is Synopsys DesignWare based PCIe core.
>>>
[...]
>>>
>>
>> +
>> +  linux,pci-domain:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: PCI domain ID.
>> Just a value of 'true' is fine here.
> Ok.
dt_binding_check is failing for adding 'true' alone.
It is passing only if "$ref" is mentioned.

Regards,
Dilip

