Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B28A3BC8B6
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGFJ4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 05:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhGFJ4r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jul 2021 05:56:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114F5C061574
        for <linux-pci@vger.kernel.org>; Tue,  6 Jul 2021 02:54:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p8so25362656wrr.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Jul 2021 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g0tC4MUw9+SlqVFCUMsi7lqIq0CVDtng7PTCdgO5oEU=;
        b=S+dyx3xgcpj4V3ANCC/A6Amv96T6RfsrHnI9Uz0FsZM7M1pQr864n7wdcaBDSg5Vbd
         lSGSdbe5aZ7zVjxxd8F3zNng8k7IdH9JrfTHCb6mrD9gTr8Xuf7RacFgLdU5FwOZMpDE
         /5SWAXvxFc6XhtmPg+H9EO6ov+vEG+E41XGQweMOGVHNECJ6mUL4VfMJ8L1FScR+leFe
         0WRWQ4MGc4yS43o/cqzD1xSwhjXiUjKMSdBvuTAKvIfDabwOnMUx3BlyDP7xrVSCBsPl
         YoqCvWxCZ8hn7ZglybVg4QTJlaFVIBsgzc8hxEma6a1XaJhJr1SyqaPdJ1wk96tEEFo/
         s4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=g0tC4MUw9+SlqVFCUMsi7lqIq0CVDtng7PTCdgO5oEU=;
        b=jrwkbq/Pfi5JQVIKuyY9fl7iLrW4hdTDGxrf4TLO9ZeLwWtuzh5Pi8T/giJwLEUtmu
         7N9lEkzUfkp8Mog9S+NofEQ5ZJqVdejk3I7/1xOb1Cguz9i9yu2aStrnumGDOiGSHBJ1
         EyMHmcPJYN3Qhq0eN/mxvmVk1nLXMil0mlkkG8RpARX3uXuoBQr+kMVJHqk61n9mRsPq
         pC489GPz2NtF/UQhierp8OdT4gPSHjDaYEk/dy3ppBmXDeZV9WSIHOWgt2duRihkG+dv
         JOjADL7Dll2dQAyORAzys4U1nEZKQ1cnjeBdfNtMSWn3DB50sNMhJkSpJ5fvkbmAQ0EE
         B0ag==
X-Gm-Message-State: AOAM5313/sOqmiuMLMdWr1tIJ/RMv/ovhVJtJ4IcVtqMNawQMXkpg3qx
        qrJOWKEYUFucV1yRtPv3yoR5aA==
X-Google-Smtp-Source: ABdhPJw1OVsLKqTJI+QcQyufAyhgXFbBXCF9GbXQs8fIfbWhEVMa+N/VRwbpAMfkQ9yGFvibeQJX3g==
X-Received: by 2002:adf:fb51:: with SMTP id c17mr21148359wrs.106.1625565246820;
        Tue, 06 Jul 2021 02:54:06 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:7257:ae4e:a17f:5800? ([2001:861:44c0:66c0:7257:ae4e:a17f:5800])
        by smtp.gmail.com with ESMTPSA id e23sm2264839wme.31.2021.07.06.02.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 02:54:06 -0700 (PDT)
Subject: Re: [PATCH 0/4] PCI: replace dublicated MRRS limit quirks
To:     Art Nikpal <email2tema@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Cc:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>,
        Gouwa Wang <gouwa@khadas.com>
References: <20210701154634.GA60743@bjorn-Precision-5520>
 <67a9e1fa.81a9.17a64c8e7f7.Coremail.chenhuacai@loongson.cn>
 <CAKaHn9KxRrBsn4b9fSO1eDzM3XdV2GzfwVX+cGw9uS_eKg75dw@mail.gmail.com>
 <CAAhV-H5M5Qf01DTD8ULGGGnv2kc2exRgXCLyNOOaqRL=dZ77xQ@mail.gmail.com>
 <CAKaHn9+iHk3UtovWU+WE2mXD9oTZD9UdxrYuLB2Odgbr91Gs-Q@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <1271fa28-dddd-01a3-5ad5-e3b4898f5482@baylibre.com>
Date:   Tue, 6 Jul 2021 11:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAKaHn9+iHk3UtovWU+WE2mXD9oTZD9UdxrYuLB2Odgbr91Gs-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 06/07/2021 08:06, Art Nikpal wrote:
>> But, Loongson platform has newer revision of hardware, and the MRRS
>> quirk has changed, please see:
>> https://patchwork.kernel.org/project/linux-pci/list/?series=509497
>> Huacai
> 
> OK! tnx for information ! maybe we can cooperate and make one
> universal quirk for all

In their Designware PCIe controller driver, amlogic sets the Max_Payload_Size & Max_Read_Request_Size to 256:
https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pci-meson.c#L260
https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pci-meson.c#L276
in their root port PCIe Express Device Control Register.

Looking at the Synopsys DW-PCIe Databook, Max_Payload_Size & Max_Read_Request_Size are used to decompose into AXI burst,
but it seems the Max_Payload_Size & Max_Read_Request_Size are set by default to 512 but the internal Max_Payload_Size_Supported
is set to 256, thus changing these values to 256 at runtime to match and optimize bandwidth.

It's said, "Reducing Outbound Decomposition" :
 - "Ensure that your application master does not generate bursts of size greater than or equal to Max_Payload_Size"
 - "Program your PCIe system with a larger value of Max_Payload_Size without exceeding Max_Payload_Size_Supported"
 - "Program your PCIe system with a larger value of Max_Read_Request without exceeding Max_Payload_Size_Supported:

So leaving 512 in Max_Payload_Size & Max_Read_Request leads to Outbound Decomposition which decreases PCIe link and degrades
the AXI bus by doubling the bursts, leading to this fix to avoid overflowing the AXI bus.

So it seems to be still needed, I assume this *should* be handled in the core somehow to propagate these settings to child endpoints to match
the root port Max_Payload_Size & Max_Read_Request sizes.

Maybe by adding a core function to set these values instead of using the dw_pcie_find_capability() & dw_pcie_write/readl_dbi() helpers
and set a state on the root port to propagate the value ?

Neil

> 
> On Tue, Jul 6, 2021 at 9:36 AM Huacai Chen <chenhuacai@gmail.com> wrote:
>>
>> Hi, Art,
>>
>> On Mon, Jul 5, 2021 at 4:35 PM Art Nikpal <email2tema@gmail.com> wrote:
>>>
>>>> Does that means keystone and Loongson has the same MRRS problem? And what should I do now?
>>>
>>> Look like yes ! and  amlogic has the same problem.
>>> I think somebody need to rewrite it all to one common quirk for this problem.
>>>
>>> If no one has any objection, I can try to remake it again.
>> But, Loongson platform has newer revision of hardware, and the MRRS
>> quirk has changed, please see:
>> https://patchwork.kernel.org/project/linux-pci/list/?series=509497
>>
>> Huacai
>>>
>>> On Fri, Jul 2, 2021 at 9:15 AM 陈华才 <chenhuacai@loongson.cn> wrote:
>>>>
>>>> Hi, Bjorn,
>>>>
>>>> &gt; -----原始邮件-----
>>>> &gt; 发件人: "Bjorn Helgaas" <helgaas@kernel.org>
>>>> &gt; 发送时间: 2021-07-01 23:46:34 (星期四)
>>>> &gt; 收件人: "Artem Lapkin" <email2tema@gmail.com>
>>>> &gt; 抄送: narmstrong@baylibre.com, yue.wang@Amlogic.com, khilman@baylibre.com, lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com, jbrunet@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, art@khadas.com, nick@khadas.com, gouwa@khadas.com, "Huacai Chen" <chenhuacai@loongson.cn>
>>>> &gt; 主题: Re: [PATCH 0/4] PCI: replace dublicated MRRS limit quirks
>>>> &gt;
>>>> &gt; [+cc Huacai]
>>>> &gt;
>>>> &gt; On Sat, Jun 19, 2021 at 02:39:48PM +0800, Artem Lapkin wrote:
>>>> &gt; &gt; Replace dublicated MRRS limit quirks by mrrs_limit_quirk from core
>>>> &gt; &gt; * drivers/pci/controller/dwc/pci-keystone.c
>>>> &gt; &gt; * drivers/pci/controller/pci-loongson.c
>>>> &gt;
>>>> &gt; s/dublicated/duplicated/ (several occurrences)
>>>> &gt;
>>>> &gt; Capitalize subject lines.
>>>> &gt;
>>>> &gt; Use "git log --online" to learn conventions and follow them.
>>>> &gt;
>>>> &gt; Add "()" after function names.
>>>> &gt;
>>>> &gt; Capitalize acronyms appropriately (NVMe, MRRS, PCI, etc).
>>>> &gt;
>>>> &gt; End sentences with periods.
>>>> &gt;
>>>> &gt; A "move" patch must include both the removal and the addition and make
>>>> &gt; no changes to the code itself.
>>>> &gt;
>>>> &gt; Amlogic appears without explanation in 2/4.  Must be separate patch to
>>>> &gt; address only that specific issue.  Should reference published erratum
>>>> &gt; if possible.  "Solves some issue" is not a compelling justification.
>>>> &gt;
>>>> &gt; The tree must be consistent and functionally the same or improved
>>>> &gt; after every patch.
>>>> &gt;
>>>> &gt; Add to pci_ids.h only if symbol used more than one place.
>>>> &gt;
>>>> &gt; See
>>>> &gt; https://lore.kernel.org/r/20210701074458.1809532-3-chenhuacai@loongson.cn,
>>>> &gt; which looks similar.  Combine efforts if possible and cc Huacai so
>>>> &gt; you're both aware of overlapping work.
>>>> &gt;
>>>> &gt; More hints in case they're useful:
>>>> &gt; https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/
>>>> &gt;
>>>> &gt; &gt; Both ks_pcie_quirk loongson_mrrs_quirk was rewritten without any
>>>> &gt; &gt; functionality changes by one mrrs_limit_quirk
>>>> Does that means keystone and Loongson has the same MRRS problem? And what should I do now?
>>>>
>>>> Huacai
>>>> &gt; &gt;
>>>> &gt; &gt; Added DesignWare PCI controller which need same quirk for
>>>> &gt; &gt; * drivers/pci/controller/dwc/pci-meson.c (PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3)
>>>> &gt; &gt;
>>>> &gt; &gt; This quirk can solve some issue for Khadas VIM3/VIM3L(Amlogic)
>>>> &gt; &gt; with HDMI scrambled picture and nvme devices at intensive writing...
>>>> &gt; &gt;
>>>> &gt; &gt; come from:
>>>> &gt; &gt; * https://lore.kernel.org/linux-pci/20210618063821.1383357-1-art@khadas.com/
>>>> &gt; &gt;
>>>> &gt; &gt; Artem Lapkin (4):
>>>> &gt; &gt;  PCI: move Keystone and Loongson device IDs to pci_ids
>>>> &gt; &gt;  PCI: core: quirks: add mrrs_limit_quirk
>>>> &gt; &gt;  PCI: keystone move mrrs quirk to core
>>>> &gt; &gt;  PCI: loongson move mrrs quirk to core
>>>> &gt; &gt;
>>>> &gt; &gt; --
>>>> &gt; &gt; 2.25.1
>>>> &gt; &gt;
>>>>
>>>>
>>>> </chenhuacai@loongson.cn></email2tema@gmail.com></helgaas@kernel.org>

