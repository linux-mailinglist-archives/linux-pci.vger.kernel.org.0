Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC4307731
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 14:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhA1Nfp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 08:35:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34734 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhA1Nfp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 08:35:45 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10SDYXEk017356;
        Thu, 28 Jan 2021 07:34:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611840873;
        bh=iprY/b77MgjOfCyrnzXeH/gJXeGLHaYSBChiH3K82ts=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uWVhpPjQ9lDIxmp8c4lf9BL1qmRYlMg5AmlEN4q9GdB6Xqp6R7Jy8Wc4/SrgIc1z0
         /q73XULz2x05FEm3g8lHhCMziq/qn8PN49Q3fmSg7S9XqOsEcS7CUwjkBzyTzHaiPo
         zK8GDib/elXLa7mAjJrl8Z7RWbIemy3Zc4UwyJnU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10SDYXwc019811
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jan 2021 07:34:33 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 Jan 2021 07:34:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 Jan 2021 07:34:33 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10SDYSbN048392;
        Thu, 28 Jan 2021 07:34:28 -0600
Subject: Re: [PATCH v9 01/17] Documentation: PCI: Add specification for the
 *PCI NTB* function device
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>
References: <20210119181106.GA2493893@bjorn-Precision-5520>
 <797ec9f2-34c3-5dc4-cc0a-d4f7cdf4afb0@ti.com>
 <20210128121147.GA23564@e121166-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f29d75ec-504f-3def-ff64-f420fcd3d10e@ti.com>
Date:   Thu, 28 Jan 2021 19:04:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128121147.GA23564@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 28/01/21 5:41 pm, Lorenzo Pieralisi wrote:
> On Fri, Jan 22, 2021 at 07:48:52PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Bjorn,
>>
>> On 20/01/21 12:04 am, Bjorn Helgaas wrote:
>>> On Mon, Jan 04, 2021 at 08:58:53PM +0530, Kishon Vijay Abraham I wrote:
>>>> Add specification for the *PCI NTB* function device. The endpoint function
>>>> driver and the host PCI driver should be created based on this
>>>> specification.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>
>>> A few typos below if there's opportunity for revisions.
>>
>> I'll fix them.
> 
> Hi Kishon,
> 
> if you have changes please send them along and I will re-merge the
> whole series.

I'll resend by tomorrow. Hope that's fine.

Thank You,
Kishon

> 
> Thanks,
> Lorenzo
> 
>>>> ---
>>>>  Documentation/PCI/endpoint/index.rst          |   1 +
>>>>  .../PCI/endpoint/pci-ntb-function.rst         | 351 ++++++++++++++++++
>>>>  2 files changed, 352 insertions(+)
>>>>  create mode 100644 Documentation/PCI/endpoint/pci-ntb-function.rst
>>>>
>>>> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
>>>> index 4ca7439fbfc9..ef6861128506 100644
>>>> --- a/Documentation/PCI/endpoint/index.rst
>>>> +++ b/Documentation/PCI/endpoint/index.rst
>>>> @@ -11,5 +11,6 @@ PCI Endpoint Framework
>>>>     pci-endpoint-cfs
>>>>     pci-test-function
>>>>     pci-test-howto
>>>> +   pci-ntb-function
>>>>  
>>>>     function/binding/pci-test
>>>> diff --git a/Documentation/PCI/endpoint/pci-ntb-function.rst b/Documentation/PCI/endpoint/pci-ntb-function.rst
>>>> new file mode 100644
>>>> index 000000000000..a57908be4047
>>>> --- /dev/null
>>>> +++ b/Documentation/PCI/endpoint/pci-ntb-function.rst
>>>> @@ -0,0 +1,351 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +=================
>>>> +PCI NTB Function
>>>> +=================
>>>> +
>>>> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
>>>> +
>>>> +PCI Non Transparent Bridges (NTB) allow two host systems to communicate
>>>> +with each other by exposing each host as a device to the other host.
>>>> +NTBs typically support the ability to generate interrupts on the remote
>>>> +machine, expose memory ranges as BARs and perform DMA.  They also support
>>>> +scratchpads which are areas of memory within the NTB that are accessible
>>>> +from both machines.
>>>> +
>>>> +PCI NTB Function allows two different systems (or hosts) to communicate
>>>> +with each other by configurig the endpoint instances in such a way that
>>>> +transactions from one system is routed to the other system.
>>>
>>> s/is/are/
>>>
>>>> +In the below diagram, PCI NTB function configures the SoC with multiple
>>>> +PCIe Endpoint (EP) instances in such a way that transaction from one EP
>>>> +controller is routed to the other EP controller. Once PCI NTB function
>>>
>>> s/transaction ... is/transactions ... are/
>>>
>>>> +configures the SoC with multiple EP instances, HOST1 and HOST2 can
>>>> +communicate with each other using SoC as a bridge.
>>>> +
>>>> +.. code-block:: text
>>>> +
>>>> +    +-------------+                                   +-------------+
>>>> +    |             |                                   |             |
>>>> +    |    HOST1    |                                   |    HOST2    |
>>>> +    |             |                                   |             |
>>>> +    +------^------+                                   +------^------+
>>>> +           |                                                 |
>>>> +           |                                                 |
>>>> + +---------|-------------------------------------------------|---------+
>>>> + |  +------v------+                                   +------v------+  |
>>>> + |  |             |                                   |             |  |
>>>> + |  |     EP      |                                   |     EP      |  |
>>>> + |  | CONTROLLER1 |                                   | CONTROLLER2 |  |
>>>> + |  |             <----------------------------------->             |  |
>>>> + |  |             |                                   |             |  |
>>>> + |  |             |                                   |             |  |
>>>> + |  |             |  SoC With Multiple EP Instances   |             |  |
>>>> + |  |             |  (Configured using NTB Function)  |             |  |
>>>> + |  +-------------+                                   +-------------+  |
>>>> + +---------------------------------------------------------------------+
>>>> +
>>>> +Constructs used for Implementing NTB
>>>> +====================================
>>>> +
>>>> +	1) Config Region
>>>> +	2) Self Scratchpad Registers
>>>> +	3) Peer Scratchpad Registers
>>>> +	4) Doorbell Registers
>>>> +	5) Memory Window
>>>> +
>>>> +
>>>> +Config Region:
>>>> +--------------
>>>> +
>>>> +Config Region is a construct that is specific to NTB implemented using NTB
>>>> +Endpoint Function Driver. The host and endpoint side NTB function driver will
>>>> +exchange information with each other using this region. Config Region has
>>>> +Control/Status Registers for configuring the Endpoint Controller. Host can
>>>> +write into this region for configuring the outbound ATU and to indicate the
>>>
>>> Expand "ATU" since this is the first mention.
>>>
>>>> +link status. Endpoint can indicate the status of commands issued be host in
>>>> +this region. Endpoint can also indicate the scratchpad offset, number of
>>>> +memory windows to the host using this region.
>>>
>>> s/be host/by host/
>>> s/offset, number/offset and number/
>>>
>>>> +The format of Config Region is given below. Each of the fields here are 32
>>>> +bits.
>>>
>>> s/Each ... are/All ... are/
>>>
>>>> +
>>>> +.. code-block:: text
>>>> +
>>>> +	+------------------------+
>>>> +	|         COMMAND        |
>>>> +	+------------------------+
>>>> +	|         ARGUMENT       |
>>>> +	+------------------------+
>>>> +	|         STATUS         |
>>>> +	+------------------------+
>>>> +	|         TOPOLOGY       |
>>>> +	+------------------------+
>>>> +	|    ADDRESS (LOWER 32)  |
>>>> +	+------------------------+
>>>> +	|    ADDRESS (UPPER 32)  |
>>>> +	+------------------------+
>>>> +	|           SIZE         |
>>>> +	+------------------------+
>>>> +	|   NO OF MEMORY WINDOW  |
>>>> +	+------------------------+
>>>> +	|  MEMORY WINDOW1 OFFSET |
>>>> +	+------------------------+
>>>> +	|       SPAD OFFSET      |
>>>> +	+------------------------+
>>>> +	|        SPAD COUNT      |
>>>> +	+------------------------+
>>>> +	|      DB ENTRY SIZE     |
>>>> +	+------------------------+
>>>> +	|         DB DATA        |
>>>> +	+------------------------+
>>>> +	|            :           |
>>>> +	+------------------------+
>>>> +	|            :           |
>>>> +	+------------------------+
>>>> +	|         DB DATA        |
>>>> +	+------------------------+
>>>> +
>>>> +
>>>> +  COMMAND:
>>>> +
>>>> +	NTB function supports three commands:
>>>> +
>>>> +	  CMD_CONFIGURE_DOORBELL (0x1): Command to configure doorbell. Before
>>>> +	invoking this command, the host should allocate and initialize
>>>> +	MSI/MSI-X vectors (i.e initialize the MSI/MSI-X capability in the
>>>
>>> s/i.e/i.e.,/
>>>
>>>> +	Endpoint). The endpoint on receiving this command will configure
>>>> +	the outbound ATU such that transaction to DB BAR will be routed
>>>> +	to the MSI/MSI-X address programmed by the host. The ARGUMENT
>>>
>>> s/transaction to/transactions to/
>>>
>>> Expand "DB BAR".  I assume this refers to "Doorbell BAR" (which itself
>>> is not defined).  How do we know which is the Doorbell BAR?
>>
>> right doorbell. That part is explained in the "Modeling Constructs"
>> section below.
>>>
>>> Also, "DB" itself needs to be expanded somehow for uses like below:
>>>
>>>> +	register should be populated with number of DBs to configure (in the
>>>> +	lower 16 bits) and if MSI or MSI-X should be configured (BIT 16).
>>>> +	(TODO: Add support for MSI-X).
>>>> +
>>>> +	  CMD_CONFIGURE_MW (0x2): Command to configure memory window. The
>>>> +	host invokes this command after allocating a buffer that can be
>>>> +	accessed by remote host. The allocated address should be programmed
>>>> +	in the ADDRESS register (64 bit), the size should be programmed in
>>>> +	the SIZE register and the memory window index should be programmed
>>>> +	in the ARGUMENT register. The endpoint on receiving this command
>>>> +	will configure the outbound ATU such that trasaction to MW BAR
>>>> +	will be routed to the address provided by the host.
>>>
>>> How do we know which is the MW BAR?  I assume "MW" refers to "Memory
>>> Window".
>>
>> right memory window. That's again explained in the "Modeling Constructs"
>> section below.
>>>
>>>> +
>>>> +	  CMD_LINK_UP (0x3): Command to indicate an NTB application is
>>>> +	bound to the EP device on the host side. Once the endpoint
>>>> +	receives this command from both the hosts, the endpoint will
>>>> +	raise an LINK_UP event to both the hosts to indicate the hosts
>>>> +	can start communicating with each other.
>>>
>>> s/raise an/raise a/
>>>
>>> I guess this "LINK_UP event" is something other than the PCIe DL_Up
>>> state, because each host has already been communicating with the
>>> endpoint.  Right?  Is this LINK_UP a software construct?
>>
>> Yeah. This is when an NTB client application is bound to the NTB device.
>> This is used for handshake between the applications running on the two
>> hosts.
>>
>> Thanks
>> Kishon
