Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1DC697DF3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 15:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBOOCU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 09:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBOOCT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 09:02:19 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:101:465::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE966311C4
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 06:02:17 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4PH0BV5W0jz9sQL;
        Wed, 15 Feb 2023 15:02:10 +0100 (CET)
Message-ID: <a4f879fd-8818-5dd2-92c9-cd435e17af99@denx.de>
Date:   Wed, 15 Feb 2023 15:02:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] PCI/AER: Remove deprecated documentation for
 pcie_enable_pcie_error_reporting()
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        bhelgaas@google.com, lukas@wunner.de,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20230214172831.GA3046378@bhelgaas>
 <17f976ba-060e-8ff4-fa9c-bf06e69aa87a@intel.com>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <17f976ba-060e-8ff4-fa9c-bf06e69aa87a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PH0BV5W0jz9sQL
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NEUTRAL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/14/23 18:37, Dave Jiang wrote:
> 
> 
> On 2/14/23 10:28 AM, Bjorn Helgaas wrote:
>> [+cc Stefan, Sathy, Jonathan]
>>
>> On Tue, Feb 14, 2023 at 09:48:55AM -0700, Dave Jiang wrote:
>>> With commit [1] upstream that enables AER reporting by default for 
>>> all PCIe
>>> devices, the documentation for pcie_enable_pcie_error_reporting() is no
>>> longer necessary. Remove references to the helper function.
>>>
>>> [1]: commit f26e58bf6f54 ("PCI/AER: Enable error reporting when AER 
>>> is native")
>>>
>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> Thanks!  I'll attach my work-in-progress patch from yesterday for your
>> comments.  I think we can go even a little further because I don't
>> think we need to encourage drivers to configure AER registers (if they
>> do, they almost certainly don't pay attention to ownership via _OSC),
>> and if they don't use pci_enable_pcie_error_reporting(), they
>> shouldn't use pci_disable_pcie_error_reporting() either.
>>
>>> ---
>>>   Documentation/PCI/pcieaer-howto.rst |   18 ------------------
>>>   1 file changed, 18 deletions(-)
>>>
>>> diff --git a/Documentation/PCI/pcieaer-howto.rst 
>>> b/Documentation/PCI/pcieaer-howto.rst
>>> index 0b36b9ebfa4b..a82802795a06 100644
>>> --- a/Documentation/PCI/pcieaer-howto.rst
>>> +++ b/Documentation/PCI/pcieaer-howto.rst
>>> @@ -135,15 +135,6 @@ hierarchy and links. These errors do not include 
>>> any device specific
>>>   errors because device specific errors will still get sent directly to
>>>   the device driver.
>>> -Configure the AER capability structure
>>> ---------------------------------------
>>> -
>>> -AER aware drivers of PCI Express component need change the device
>>> -control registers to enable AER. They also could change AER registers,
>>> -including mask and severity registers. Helper function
>>> -pci_enable_pcie_error_reporting could be used to enable AER. See
>>> -section 3.3.
>>> -
>>>   Provide callbacks
>>>   -----------------
>>> @@ -214,15 +205,6 @@ to mmio_enabled.
>>>   helper functions
>>>   ----------------
>>> -::
>>> -
>>> -  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>>> -
>>> -pci_enable_pcie_error_reporting enables the device to send error
>>> -messages to root port when an error is detected. Note that devices
>>> -don't enable the error reporting by default, so device drivers need
>>> -call this function to enable it.
>>> -
>>>   ::
>>>     int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>>
>>
>> commit d7b36abe72db ("Remove AER Capability configuration")
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Mon Feb 13 11:53:42 2023 -0600
>>
>>      Remove AER Capability configuration
> 
> The changes LGTM.
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> 
>>
>> diff --git a/Documentation/PCI/pcieaer-howto.rst 
>> b/Documentation/PCI/pcieaer-howto.rst
>> index 0b36b9ebfa4b..c98a229ea9f5 100644
>> --- a/Documentation/PCI/pcieaer-howto.rst
>> +++ b/Documentation/PCI/pcieaer-howto.rst
>> @@ -96,8 +96,8 @@ 
>> Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
>>   Developer Guide
>>   ===============
>> -To enable AER aware support requires a software driver to configure
>> -the AER capability structure within its device and to provide callbacks.
>> +To enable AER aware support requires a software driver to provide
>> +callbacks.
>>   To support AER better, developers need understand how AER does work
>>   firstly.
>> @@ -135,15 +135,6 @@ hierarchy and links. These errors do not include 
>> any device specific
>>   errors because device specific errors will still get sent directly to
>>   the device driver.
>> -Configure the AER capability structure
>> ---------------------------------------
>> -
>> -AER aware drivers of PCI Express component need change the device
>> -control registers to enable AER. They also could change AER registers,
>> -including mask and severity registers. Helper function
>> -pci_enable_pcie_error_reporting could be used to enable AER. See
>> -section 3.3.
>> -
>>   Provide callbacks
>>   -----------------
>> @@ -212,31 +203,6 @@ to reset the link. If error_detected returns 
>> PCI_ERS_RESULT_CAN_RECOVER
>>   and reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling 
>> goes
>>   to mmio_enabled.
>> -helper functions
>> -----------------
>> -::
>> -
>> -  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>> -
>> -pci_enable_pcie_error_reporting enables the device to send error
>> -messages to root port when an error is detected. Note that devices
>> -don't enable the error reporting by default, so device drivers need
>> -call this function to enable it.
>> -
>> -::
>> -
>> -  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>> -
>> -pci_disable_pcie_error_reporting disables the device to send error
>> -messages to root port when an error is detected.
>> -
>> -::
>> -
>> -  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);`
>> -
>> -pci_aer_clear_nonfatal_status clears non-fatal errors in the 
>> uncorrectable
>> -error status register.
>> -
>>   Frequent Asked Questions
>>   ------------------------
>> @@ -257,24 +223,6 @@ A:
>>     Fatal error recovery will fail if the errors are reported by the
>>     upstream ports who are attached by the service driver.
>> -Q:
>> -  How does this infrastructure deal with driver that is not PCI
>> -  Express aware?
>> -
>> -A:
>> -  This infrastructure calls the error callback functions of the
>> -  driver when an error happens. But if the driver is not aware of
>> -  PCI Express, the device might not report its own errors to root
>> -  port.
>> -
>> -Q:
>> -  What modifications will that driver need to make it compatible
>> -  with the PCI Express AER Root driver?
>> -
>> -A:
>> -  It could call the helper functions to enable AER in devices and
>> -  cleanup uncorrectable status register. Pls. refer to section 3.3.
>> -
>>   Software error injection
>>   ========================

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
