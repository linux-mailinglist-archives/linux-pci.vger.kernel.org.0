Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61D4E82CD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 08:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfJ2Hxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 03:53:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:23959 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfJ2Hxc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 03:53:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 00:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="350904323"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 29 Oct 2019 00:53:29 -0700
Received: from [10.226.39.46] (ekotax-MOBL.gar.corp.intel.com [10.226.39.46])
        by linux.intel.com (Postfix) with ESMTP id 372E8580372;
        Tue, 29 Oct 2019 00:53:24 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com, robh@kernel.org,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <710257e49c4b3d07fa98b3e5a829b807f74b54d7.1571638827.git.eswara.kota@linux.intel.com>
 <CAFBinCCSX_kVB=W3O-WXDMD2_2_Rnv+kiehf37xDkjL8+QoyHQ@mail.gmail.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <42016b72-da39-7234-c3d3-f007636ff573@linux.intel.com>
Date:   Tue, 29 Oct 2019 15:53:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCCSX_kVB=W3O-WXDMD2_2_Rnv+kiehf37xDkjL8+QoyHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Martin,

On 10/25/2019 4:31 AM, Martin Blumenstingl wrote:
> Hi Dilip,
>
> thank you for the update
> two nit-picks below, apart from those it looks good to me
Thanks for reviewing it.
>
> On Mon, Oct 21, 2019 at 8:39 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
> [...]
>> +examples:
>> +  - |
>> +    pcie10:pcie@d0e00000 {
> why no space between pcie10 and pcie@d0e00000?
Agree, will fix it in the next patch version.
>
> [...]
>> +      status = "okay";
> examples should not use the status property, see commit 4da722ca19f30f
> ("dt-bindings: Remove "status" from examples")

Agree, will fix it in the next patch version.
(sorry for the late reply, i am back today from sick leave).

Regards,
Dilip

>
>
> Martin
