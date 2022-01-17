Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D9C49050A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jan 2022 10:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiAQJjc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 04:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbiAQJjc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 04:39:32 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928FDC061574
        for <linux-pci@vger.kernel.org>; Mon, 17 Jan 2022 01:39:31 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Jcn1D0ld6zQjvM;
        Mon, 17 Jan 2022 10:39:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <ae9add63-042f-07b0-ddcd-39dbb34224d2@denx.de>
Date:   Mon, 17 Jan 2022 10:39:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] PCI/AER: Enable AER on Endpoints as well
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
References: <20220117080348.2757180-1-sr@denx.de>
 <20220117080348.2757180-3-sr@denx.de> <20220117093000.p3a5lqjn4e5kfk3o@pali>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220117093000.p3a5lqjn4e5kfk3o@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/17/22 10:30, Pali Rohár wrote:
> On Monday 17 January 2022 09:03:48 Stefan Roese wrote:
>> Currently, the PCIe AER subsystem does not enable AER in the PCIe
>> Endpoints via the Device Control register. It's only done for the
>> Root Port and all PCIe Ports in between the Root Port and the
>> Endpoint(s). Some device drivers enable AER in their PCIe device by
>> directly calling pci_enable_pcie_error_reporting(). But in most
>> cases, AER is currently disabled in the PCIe Endpoints.
>>
>> This patch enables AER on PCIe Endpoints now as well in
>> set_device_error_reporting(). This will make the ad-hoc calls to
>> pci_enable_pcie_error_reporting() superfluous.
>>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> Cc: Pali Rohár <pali@kernel.org>
>> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
>> Cc: Naveen Naidu <naveennaidu479@gmail.com>
> 
> Reviewed-by: Pali Rohár <pali@kernel.org>
> 
>> ---
>> v2:
>> - New patch
>>
>>   drivers/pci/pcie/aer.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 9fa1f97e5b27..385e2033d7b5 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1216,7 +1216,8 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
>>   	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
>>   	    (type == PCI_EXP_TYPE_RC_EC) ||
>>   	    (type == PCI_EXP_TYPE_UPSTREAM) ||
>> -	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +	    (type == PCI_EXP_TYPE_DOWNSTREAM) ||
>> +	    (type == PCI_EXP_TYPE_ENDPOINT)) {
> 
> Hm... maybe another question to discussion: Why enabling of AER is
> limited just to above PCIe port types? Why we do not want to enable it
> for _all_ PCIe devices? Currently in the above list are missing Legacy
> endpoints (which probably do not support AER and so do not have AER
> capability in config space), Root Complex Integrated Endpoints (these
> should provide AER supports too, right?), PCIe to PCI/X Bridges (these
> may generate its own AER errors) and PCI to PCIe Bridges (these are
> maybe complicated as subtree behind such bridges are regular PCIe
> devices and so could fully support AER but on legacy PCI bus there is
> probably no access to extended config space where is AER). But in all of
> these cases, are there any issues with enabling AER via function
> pci_enable_pcie_error_reporting()? For me it looks like that in the
> worst case dev just does not have AER capability in config space or
> extended config space is not accessible (which is same as no AER
> capability).

I also had similar thoughts on this and was a bit unsure here. Perhaps
Bjorn can also comment. But...

... I noticed that AER is still disabled for hot-plugged PCIe devices.
As this code patch will not get called in this HP case. Right now I'm
testing with this patch here, which could be used instead of this one
from this mail:

     PCI/AER: Enable AER on all PCIe devices supporting it

     With this change, AER is now also enabled for hot-plugged PCIe devices
     as pci_aer_init() is also called upon hot-plugging of a PCIe device.
     When "pci=noaer" is selected, AER stays disabled of course.

     Signed-off-by: Stefan Roese <sr@denx.de>

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 385e2033d7b5..94107309ef2d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -387,6 +387,10 @@ void pci_aer_init(struct pci_dev *dev)
         pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, 
sizeof(u32) * n);

         pci_aer_clear_status(dev);
+
+       /* Enable AER if requested */
+       if (pci_aer_available())
+               pci_enable_pcie_error_reporting(dev);
  }

This has the same effect of enabling AER in each PCIe Endpoint and
also is available for hot-plugged Endpoints. If nobody objects, I'll
probably use this patch as patch 2/2 in the next patchset version.

Comments welcome as always.

Thanks,
Stefan
