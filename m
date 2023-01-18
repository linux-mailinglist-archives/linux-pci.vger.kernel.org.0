Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD8671A1A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 12:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjARLKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 06:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjARLJ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 06:09:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEC45D7CF
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 02:17:26 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i65so22312847pfc.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 02:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQeetLMmwhbkZhzTjSGxZuP+z80kL1pLPDlk7u2lHZg=;
        b=FSgocBv044IaFDw+4YBpsothX/Jjz2bDNUQyQoeQjaLaDup0NFBiF9rv/SMfV5zEI0
         0e2TKejrMfLgfdrlwrDz9rEuJrYAzVeFhnyYJ6104+Kg4ms6MXiLulPPtbQqhxxy/4Gq
         h4BtZhuCSfR30G7AUsMnk1ROJzUlTMGy6ehJiaSIQoIE5gpXyOmt/cuqH+7DqagmrIEQ
         gnjFEFHH6OI79z3eOjRKdP89UFLO3tewz0lGXK6sIxiMCWmDrmJieKTB/nkPW7cJKcK4
         5uvcPNTNsc7kUDFoVs3QlR/BDhtLnIpn7WiVKivEa1aR3B9f8T8EakVmTEGd6eOVvdvS
         VDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQeetLMmwhbkZhzTjSGxZuP+z80kL1pLPDlk7u2lHZg=;
        b=eynyiwh7RXcCn+b6DYCZLkBW7AKvezP5VUv8RhOIXYpLxmBTJRnb7TiBplG+cUlq2I
         ZcIGf6EklH9z9RfTUHVbvHMkKsxMW0A6HJDX0ftIOClpWTxXvZLgl/0YlLU96hd3Q7WB
         DVC6gRCbKmjHdVgIOwXsWzWGCVSgl+TvbmUpHCIQBaqW7QKCffSsf6mwqf/5Dw+eelzz
         2Trz8z4Vf+NbkvHs3Kr/dcdMP8NrlZyoef7doCPNjKTcrBEtl7WCPF+dwwazPa0/SgG3
         feyE2nyFiRO2qTaJT7SqqtekSgUkDYKGokO8MPNXJ2VV4GvvfsNP/1GR6zfcacgXEpug
         SRPg==
X-Gm-Message-State: AFqh2kqJUM3bWru5y0F8ZYh0Exsbtw10PMOANj8oYH4lrfqPKEp53xqs
        jPqPKNfsQ8gc8J9Og8JwQaJhfw==
X-Google-Smtp-Source: AMrXdXtMI0O5Xff2JQz11vEueijTgCy8F+DZvjFgH2o3CP2BFApVh4ULnOrlI6N4/gZqk5+2mixFZg==
X-Received: by 2002:a62:6492:0:b0:58d:90ae:495c with SMTP id y140-20020a626492000000b0058d90ae495cmr6366994pfb.11.1674037045841;
        Wed, 18 Jan 2023 02:17:25 -0800 (PST)
Received: from [10.16.128.218] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id u83-20020a627956000000b0058cda506a4fsm7327584pfc.145.2023.01.18.02.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 02:17:25 -0800 (PST)
Message-ID: <1b26c1e2-62e5-920f-f480-b66b1f903e65@igel.co.jp>
Date:   Wed, 18 Jan 2023 19:17:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/3] Deal with alignment restriction on EP side
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Li Chen <lchen@ambarella.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230117203215.GA144880@bhelgaas>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20230117203215.GA144880@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/01/18 5:32, Bjorn Helgaas wrote:
> On Fri, Jan 13, 2023 at 06:03:47PM +0900, Shunsuke Mie wrote:
>> Some PCIe EPC controllers have restriction to map PCIe address space to the
>> local memory space. The mapping is needed to access memory of other side.
>> On epf test, RC module prepares an aligned memory, and EP module maps the
>> region. However, a EP module which emulate a device (e.g. VirtIO, NVMe and
>> etc) cannot expect that a driver for the device prepares an aligned memory.
>> So, a EP side should deal with the alignment restriction.
>>
>> This patchset addresses with the alignment restriction on EP size. A
>> content as follows:
>> 1. Improve a pci epc unmap/map functions to cover the alignment restriction
>> with adding epc driver support as EPC ops.
>> 2. Implement the support function for DWC EPC driver.
>> 3. Adapt the pci-epf-test to the map/unmap function updated at first patch.
>>
>> I tested this changes on RENESAS board has DWC PCIeC.
>>
>> This is a RFC, and it has patches for testing only. Following changes are
>> not included yet:
>> 1. Removing alignment codes on RC side completely
>> 2. Adapting map/unmap() changes to pci-epf-ntb/vntb
>>
>> Best,
>> Shunsuke
>>
>> Shunsuke Mie (3):
>>    PCI: endpoint: support an alignment aware map/unmaping
>>    PCI: dwc: support align_mem() callback for pci_epc_epc
>>    PCI: endpoint: support pci_epc_mem_map/unmap API changes
> s/unmaping/unmapping/
>
> Capitalize subject lines ("Support ...").
>
> Would be nice to say something more specific than "support ... API
> changes."
I'll reflect this remarks.
>
> The last patch seems to be for a test case.  Some previous changes to
> it use the "PCI: pci-epf-test" prefix so it's distinct from the
> pci-epc-core changes.
I'll follow the previous changes.
>>   .../pci/controller/dwc/pcie-designware-ep.c   | 13 +++
>>   drivers/pci/endpoint/functions/pci-epf-test.c | 89 +++++--------------
>>   drivers/pci/endpoint/pci-epc-core.c           | 57 +++++++++---
>>   include/linux/pci-epc.h                       | 10 ++-
>>   4 files changed, 90 insertions(+), 79 deletions(-)
>>
>> -- 
>> 2.25.1
>>
Best,

Shunsuke

