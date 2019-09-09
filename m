Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4793BAD345
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2019 08:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfIIGwZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Sep 2019 02:52:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:16903 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730555AbfIIGwY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Sep 2019 02:52:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Sep 2019 23:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="188934357"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 08 Sep 2019 23:52:23 -0700
Received: from [10.226.39.8] (ekotax-mobl.gar.corp.intel.com [10.226.39.8])
        by linux.intel.com (Postfix) with ESMTP id E13FC5807FF;
        Sun,  8 Sep 2019 23:52:20 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
 <CAFBinCC5SH5OSUqOkLQhE2o7g5OhSuB_PBjsv93U2P=FNS5oPw@mail.gmail.com>
 <20190906091950.GJ2680@smile.fi.intel.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <c6c50a77-d55c-5f5c-ee76-01728dbc2ca3@linux.intel.com>
Date:   Mon, 9 Sep 2019 14:52:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190906091950.GJ2680@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/6/2019 5:19 PM, Andy Shevchenko wrote:
> On Thu, Sep 05, 2019 at 10:31:29PM +0200, Martin Blumenstingl wrote:
>> On Wed, Sep 4, 2019 at 12:11 PM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>>> +  phy-names:
>>> +    const: pciephy
>> the most popular choice in Documentation/devicetree/bindings/pci/ is "pcie-phy"
>> if Rob is happy with "pciephy" (which is already part of two other
>> bindings) then I'm happy with "pciephy" as well
> I'm not Rob, though I consider more practical to have a hyphenated variant.

I am okay to "pcie-phy". I will update it in next patch version.

Regards,
Dilip

>
