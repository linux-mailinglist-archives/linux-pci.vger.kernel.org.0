Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EDA6CAB4A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 19:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjC0RCZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 13:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjC0RCH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 13:02:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C753F3A92;
        Mon, 27 Mar 2023 10:01:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D6142F4;
        Mon, 27 Mar 2023 10:02:38 -0700 (PDT)
Received: from [10.57.53.238] (unknown [10.57.53.238])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 932F03F6C4;
        Mon, 27 Mar 2023 10:01:52 -0700 (PDT)
Message-ID: <15102094-10d3-b160-59cc-d5b9b93ae1b3@arm.com>
Date:   Mon, 27 Mar 2023 18:01:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 7/8] PCI: dwc: Introduce configurable DMA mask
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>, Elad Nachman <enachman@marvell.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230313124016.17102-1-enachman@marvell.com>
 <20230313124016.17102-8-enachman@marvell.com>
 <20230317182323.GA2445959-robh@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230317182323.GA2445959-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-03-17 18:23, Rob Herring wrote:
> +Robin
> 
> On Mon, Mar 13, 2023 at 02:40:15PM +0200, Elad Nachman wrote:
>> From: Elad Nachman <enachman@marvell.com>
>>
>> Some devices, such as AC5 and AC5X have their physical DDR memory
>> start at address 0x2_0000_0000. In order to have the DMA coherent
>> allocation succeed later, a different DMA mask is required, as
>> defined in the DT file for such SOCs, using dma-ranges.
> 
> I'm afraid this is not right. 'dma-ranges' in the PCI host bridge node
> applies to PCI devices (i.e. child node), not the host bridge itself.
> It's 'dma-ranges' in the parent node of the host bridge that applies
> here. The core code will set masks (ranges really now) based on bus
> restrictions. The mask for the device should only be based on the
> device's limits (i.e. the device is 32-bit only).
> 
> I think you will need whatever solution comes out of this thread[1].

Right, "make the allocation succeed later" is entirely missing the point 
of this code. The only reason we're doing that allocation at all is to 
reserve a 32-bit bus address. If it fails, it means we can't reliably 
support endpoints with only a 32-bit MSI capability. Using a bigger mask 
in order to successfully reserve a >32-bit bus address basically 
*guarantees* that you can't support endpoints with only a 32-bit MSI 
capability.

Thanks Rob for digging up that thread; the original idea there should 
still be fine, but the alternative suggestion from Serge at the end is 
potentially even better for this situation where it's down to the SoC's 
memory map rather than the kernel config. It just needs somebody with 
sufficient motivation and resources to write and test a patch :)

Robin.

> 
> Rob
> 
> [1] https://lore.kernel.org/all/c014b074-6d7f-773b-533a-c0500e239ab8@arm.com/
