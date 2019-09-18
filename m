Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185CBB5D93
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2019 08:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfIRGtF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 02:49:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:50715 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfIRGtE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Sep 2019 02:49:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 23:49:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,519,1559545200"; 
   d="scan'208";a="193978467"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Sep 2019 23:49:02 -0700
Received: from [10.226.39.42] (unknown [10.226.39.42])
        by linux.intel.com (Postfix) with ESMTP id C29B758012D;
        Tue, 17 Sep 2019 23:48:58 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
 <CAFBinCC5SH5OSUqOkLQhE2o7g5OhSuB_PBjsv93U2P=FNS5oPw@mail.gmail.com>
 <20190906091950.GJ2680@smile.fi.intel.com> <20190917183306.GA24684@bogus>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <f0d8e899-e881-f1ee-22fc-a286796f093b@linux.intel.com>
Date:   Wed, 18 Sep 2019 14:48:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190917183306.GA24684@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 9/18/2019 2:33 AM, Rob Herring wrote:
> On Fri, Sep 06, 2019 at 12:19:50PM +0300, Andy Shevchenko wrote:
>> On Thu, Sep 05, 2019 at 10:31:29PM +0200, Martin Blumenstingl wrote:
>>> On Wed, Sep 4, 2019 at 12:11 PM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>>>> +  phy-names:
>>>> +    const: pciephy
>>> the most popular choice in Documentation/devicetree/bindings/pci/ is "pcie-phy"
>>> if Rob is happy with "pciephy" (which is already part of two other
>>> bindings) then I'm happy with "pciephy" as well
>> I'm not Rob, though I consider more practical to have a hyphenated variant.
> *-names is kind of pointless when there is only one entry and 'foo' in
> the values of 'foo-names' is redundant.

Ok, i will change it to:

     phy-name:
         const: pcie

Regards,
Dilip

>
> Rob
