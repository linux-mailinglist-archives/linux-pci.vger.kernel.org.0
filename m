Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3D0494852
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 08:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359022AbiATHdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 02:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359009AbiATHdF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 02:33:05 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF841C061574
        for <linux-pci@vger.kernel.org>; Wed, 19 Jan 2022 23:33:04 -0800 (PST)
Received: from smtp2.mailbox.org (unknown [91.198.250.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JfZ3y6C0JzQlGk;
        Thu, 20 Jan 2022 08:33:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <3a69de61-a2cd-2808-55df-72fed4392ce0@denx.de>
Date:   Thu, 20 Jan 2022 08:32:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] PCI/AER: Enable AER on all PCIe devices supporting
 it
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
References: <20220119182550.GB13301@dhcp-10-100-145-180.wdc.com>
 <20220119210002.GA963573@bhelgaas>
 <20220119211859.GC13301@dhcp-10-100-145-180.wdc.com>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220119211859.GC13301@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/19/22 22:18, Keith Busch wrote:
> On Wed, Jan 19, 2022 at 03:00:02PM -0600, Bjorn Helgaas wrote:
>> On Wed, Jan 19, 2022 at 10:25:50AM -0800, Keith Busch wrote:
>>> On Wed, Jan 19, 2022 at 10:22:00AM +0100, Stefan Roese wrote:
>>>> @@ -387,6 +387,10 @@ void pci_aer_init(struct pci_dev *dev)
>>>>   	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
>>>>   
>>>>   	pci_aer_clear_status(dev);
>>>> +
>>>> +	/* Enable AER if requested */
>>>> +	if (pci_aer_available())
>>>> +		pci_enable_pcie_error_reporting(dev);
>>>>   }
>>>
>>> Hasn't it always been the device specific driver's responsibility to
>>> call this function?
>>
>> So far it has been done by the driver, because the PCI core doesn't do
>> it.  But is there a reason it should be done by the driver?  It
>> doesn't seem necessarily device-specific.
> 
> I was thinking the device driver knows if it provides .err_handler
> callbacks in order to respond to AER handling, so it would know if it is
> ready for its device to enable error reporting. But I guess it doesn't
> really matter if the driver provides callbacks anyway.

That's my understanding as well.

Thanks,
Stefan
