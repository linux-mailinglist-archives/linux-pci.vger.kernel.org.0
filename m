Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCC3C2170
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 15:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfI3NFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 09:05:47 -0400
Received: from foss.arm.com ([217.140.110.172]:53902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbfI3NFr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 09:05:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B17F11000;
        Mon, 30 Sep 2019 06:05:46 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD2783F706;
        Mon, 30 Sep 2019 06:05:44 -0700 (PDT)
Subject: Re: [PATCH 00/11] of: dma-ranges fixes and improvements
To:     Marek Vasut <marek.vasut@gmail.com>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
References: <20190927002455.13169-1-robh@kernel.org>
 <106d5b37-5732-204f-4140-8d528256a59b@gmail.com>
 <40bdf7cf-3bb1-24f8-844d-3eefbc761aba@arm.com>
 <807a4f96-cbda-da4d-a3f1-2bfe5788105b@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <107d3a83-7448-b5c8-4b38-9b376848a1fa@arm.com>
Date:   Mon, 30 Sep 2019 14:05:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <807a4f96-cbda-da4d-a3f1-2bfe5788105b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/09/2019 13:54, Marek Vasut wrote:
> On 9/30/19 2:52 PM, Robin Murphy wrote:
>> On 30/09/2019 13:40, Marek Vasut wrote:
>>> On 9/27/19 2:24 AM, Rob Herring wrote:
>>>> This series fixes several issues related to 'dma-ranges'. Primarily,
>>>> 'dma-ranges' in a PCI bridge node does correctly set dma masks for PCI
>>>> devices not described in the DT. A common case needing dma-ranges is a
>>>> 32-bit PCIe bridge on a 64-bit system. This affects several platforms
>>>> including Broadcom, NXP, Renesas, and Arm Juno. There's been several
>>>> attempts to fix these issues, most recently earlier this week[1].
>>>>
>>>> In the process, I found several bugs in the address translation. It
>>>> appears that things have happened to work as various DTs happen to use
>>>> 1:1 addresses.
>>>>
>>>> First 3 patches are just some clean-up. The 4th patch adds a unittest
>>>> exhibiting the issues. Patches 5-9 rework how of_dma_configure() works
>>>> making it work on either a struct device child node or a struct
>>>> device_node parent node so that it works on bus leaf nodes like PCI
>>>> bridges. Patches 10 and 11 fix 2 issues with address translation for
>>>> dma-ranges.
>>>>
>>>> My testing on this has been with QEMU virt machine hacked up to set PCI
>>>> dma-ranges and the unittest. Nicolas reports this series resolves the
>>>> issues on Rpi4 and NXP Layerscape platforms.
>>>
>>> With the following patches applied:
>>>         https://patchwork.ozlabs.org/patch/1144870/
>>>         https://patchwork.ozlabs.org/patch/1144871/
>>
>> Can you try it without those additional patches? This series aims to
>> make the parsing work properly generically, such that we shouldn't need
>> to add an additional PCI-specific version of almost the same code.
> 
> Seems to work even without those.

Great, thanks for confirming!

Robin.
