Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8242A3E2E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 08:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgKCH6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 02:58:52 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35374 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgKCH6v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 02:58:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A37wWCg121425;
        Tue, 3 Nov 2020 01:58:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604390312;
        bh=9ur+xq0E036quUpkLpCo7JJNZVUnUVc2aT5Zysuzg/g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LcwWEOdfHJVS1z6a205bmF7N6abZiNqgufSHTJtn/CHbBCWnGfSc1JkEEl4buCJIh
         +TFeNtBTwI+2eRat7jYHeSXIjd5mxITkunYLOy2CXy7jjkhHfkcthqO9x9RQcgbRDD
         Xcj+ynYwn1mjO2tKjssrhKjRKIk3LX5oUHhbHQ+4=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A37wWGB069124
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 01:58:32 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 01:58:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 01:58:32 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A37wQED028806;
        Tue, 3 Nov 2020 01:58:26 -0600
Subject: Re: [PATCH v7 00/18] Implement NTB Controller using multiple PCI EP
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <alanmikhak@gmail.com>, <alan.mikhak@sifive.com>
References: <20200930153519.7282-1-kishon@ti.com>
 <fe2db298-2116-7f52-80bd-a3d01a9a1521@ti.com>
 <72ebe7db-86cd-6827-03ff-bde32c10dc7e@ti.com>
 <20201020131843.GA25784@e121166-lin.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <27b4ae15-03ce-e2f1-a0b5-65db7c7dd71e@ti.com>
Date:   Tue, 3 Nov 2020 13:28:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020131843.GA25784@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Alan

Hi Jon Mason, Allen Hubbe, Dave Jiang,

On 20/10/20 6:48 pm, Lorenzo Pieralisi wrote:
> On Tue, Oct 20, 2020 at 01:45:45PM +0530, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On 05/10/20 11:27 am, Kishon Vijay Abraham I wrote:
>>> Hi Jon Mason, Allen Hubbe, Dave Jiang,
>>>
>>> On 30/09/20 9:05 pm, Kishon Vijay Abraham I wrote:
>>>> This series is about implementing SW defined Non-Transparent Bridge (NTB)
>>>> using multiple endpoint (EP) instances. This series has been tested using
>>>> 2 endpoint instances in J7 connected to J7 board on one end and DRA7 board
>>>> on the other end. However there is nothing platform specific for the NTB
>>>> functionality.
>>>
>>> This series has two patches that adds to drivers/ntb/ directory.
>>> [PATCH v7 15/18] NTB: Add support for EPF PCI-Express Non-Transparent
>>> Bridge and [PATCH v7 16/18] NTB: tool: Enable the NTB/PCIe link on the
>>> local or remote side of bridge.
>>>
>>> If you can review and Ack the above patches, Lorenzo can queue it along
>>> with the rest of the series.

Would you be able to review and Ack the NTB parts of this series?
>>>
>>> Thanks for your help in advance.
>>
>> Gentle ping on this series.
> 
> I am not queueing any more patches for this merge window - we postpone
> this series to v5.11 and in the interim it would be good to define some
> possible users.

Alan, Do you have a system where you can test this series? It only needs
two endpoint instances on a single system.

Thanks
Kishon

> 
> Thanks,
> Lorenzo
> 
>> Thanks
>> Kishon
>>>
>>> Best Regards,
>>> Kishon
>>>
>>>>
>>>> This was presented in Linux Plumbers Conference. Link to presentation
>>>> and video can be found @ [1]
>>>>
>>>> RFC patch series can be found @ [2]
>>>> v1 patch series can be found @ [3]
>>>> v2 patch series can be found @ [4]
>>>> v3 patch series can be found @ [5]
>>>> v4 patch series can be found @ [6]
>>>> v5 patch series can be found @ [7]
>>>> v6 patch series can be found @ [8]
>>>>
>>>> Changes from v6:
>>>> 1) Fixed issues when multiple NTB devices are creating using multiple
>>>>    functions
>>>> 2) Fixed issue with writing scratchpad register
>>>> 3) Created a video demo @ [9]
>>>>
>>>> Changes from v5:
>>>> 1) Fixed a formatting issue in Kconfig pointed out by Randy
>>>> 2) Checked for Error or Null in pci_epc_add_epf()
>>>>
>>>> Changes from v4:
>>>> 1) Fixed error condition checks in pci_epc_add_epf()
>>>>
>>>> Changes from v3:
>>>> 1) Fixed Documentation edits suggested by Randy Dunlap <rdunlap@infradead.org>
>>>>
>>>> Changes from v2:
>>>> 1) Add support for the user to create sub-directory of 'EPF Device'
>>>>    directory (for endpoint function specific configuration using
>>>>    configfs).
>>>> 2) Add documentation for NTB specific attributes in configfs
>>>> 3) Check for PCI_CLASS_MEMORY_RAM (PCIe class) before binding ntb_hw_epf
>>>>    driver
>>>> 4) Other documentation fixes
>>>>
>>>> Changes from v1:
>>>> 1) As per Rob's comment, removed support for creating NTB function
>>>>    device from DT
>>>> 2) Add support to create NTB EPF device using configfs (added support in
>>>>    configfs to associate primary and secondary EPC with EPF.
>>>>
>>>> Changes from RFC:
>>>> 1) Converted the DT binding patches to YAML schema and merged the
>>>>    DT binding patches together
>>>> 2) NTB documentation is converted to .rst
>>>> 3) One HOST can now interrupt the other HOST using MSI-X interrupts
>>>> 4) Added support for teardown of memory window and doorbell
>>>>    configuration
>>>> 5) Add support to provide support 64-bit memory window size from
>>>>    DT
>>>>
>>>> [1] -> https://linuxplumbersconf.org/event/4/contributions/395/
>>>> [2] -> http://lore.kernel.org/r/20190926112933.8922-1-kishon@ti.com
>>>> [3] -> http://lore.kernel.org/r/20200514145927.17555-1-kishon@ti.com
>>>> [4] -> http://lore.kernel.org/r/20200611130525.22746-1-kishon@ti.com
>>>> [5] -> http://lore.kernel.org/r/20200904075052.8911-1-kishon@ti.com
>>>> [6] -> http://lore.kernel.org/r/20200915042110.3015-1-kishon@ti.com
>>>> [7] -> http://lore.kernel.org/r/20200918064227.1463-1-kishon@ti.com
>>>> [8] -> http://lore.kernel.org/r/20200924092519.17082-1-kishon@ti.com
>>>> [9] -> https://youtu.be/dLKKxrg5-rY
>>>>
>>>> Kishon Vijay Abraham I (18):
>>>>   Documentation: PCI: Add specification for the *PCI NTB* function
>>>>     device
>>>>   PCI: endpoint: Make *_get_first_free_bar() take into account 64 bit
>>>>     BAR
>>>>   PCI: endpoint: Add helper API to get the 'next' unreserved BAR
>>>>   PCI: endpoint: Make *_free_bar() to return error codes on failure
>>>>   PCI: endpoint: Remove unused pci_epf_match_device()
>>>>   PCI: endpoint: Add support to associate secondary EPC with EPF
>>>>   PCI: endpoint: Add support in configfs to associate two EPCs with EPF
>>>>   PCI: endpoint: Add pci_epc_ops to map MSI irq
>>>>   PCI: endpoint: Add pci_epf_ops for epf drivers to expose function
>>>>     specific attrs
>>>>   PCI: endpoint: Allow user to create sub-directory of 'EPF Device'
>>>>     directory
>>>>   PCI: cadence: Implement ->msi_map_irq() ops
>>>>   PCI: cadence: Configure LM_EP_FUNC_CFG based on epc->function_num_map
>>>>   PCI: endpoint: Add EP function driver to provide NTB functionality
>>>>   PCI: Add TI J721E device to pci ids
>>>>   NTB: Add support for EPF PCI-Express Non-Transparent Bridge
>>>>   NTB: tool: Enable the NTB/PCIe link on the local or remote side of
>>>>     bridge
>>>>   Documentation: PCI: Add configfs binding documentation for pci-ntb
>>>>     endpoint function
>>>>   Documentation: PCI: Add userguide for PCI endpoint NTB function
>>>>
>>>>  .../PCI/endpoint/function/binding/pci-ntb.rst |   38 +
>>>>  Documentation/PCI/endpoint/index.rst          |    3 +
>>>>  .../PCI/endpoint/pci-endpoint-cfs.rst         |   10 +
>>>>  .../PCI/endpoint/pci-ntb-function.rst         |  351 +++
>>>>  Documentation/PCI/endpoint/pci-ntb-howto.rst  |  160 ++
>>>>  drivers/misc/pci_endpoint_test.c              |    1 -
>>>>  drivers/ntb/hw/Kconfig                        |    1 +
>>>>  drivers/ntb/hw/Makefile                       |    1 +
>>>>  drivers/ntb/hw/epf/Kconfig                    |    6 +
>>>>  drivers/ntb/hw/epf/Makefile                   |    1 +
>>>>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  755 ++++++
>>>>  drivers/ntb/test/ntb_tool.c                   |    1 +
>>>>  .../pci/controller/cadence/pcie-cadence-ep.c  |   60 +-
>>>>  drivers/pci/endpoint/functions/Kconfig        |   12 +
>>>>  drivers/pci/endpoint/functions/Makefile       |    1 +
>>>>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2114 +++++++++++++++++
>>>>  drivers/pci/endpoint/functions/pci-epf-test.c |   13 +-
>>>>  drivers/pci/endpoint/pci-ep-cfs.c             |  176 +-
>>>>  drivers/pci/endpoint/pci-epc-core.c           |  130 +-
>>>>  drivers/pci/endpoint/pci-epf-core.c           |  105 +-
>>>>  include/linux/pci-epc.h                       |   39 +-
>>>>  include/linux/pci-epf.h                       |   28 +-
>>>>  include/linux/pci_ids.h                       |    1 +
>>>>  23 files changed, 3934 insertions(+), 73 deletions(-)
>>>>  create mode 100644 Documentation/PCI/endpoint/function/binding/pci-ntb.rst
>>>>  create mode 100644 Documentation/PCI/endpoint/pci-ntb-function.rst
>>>>  create mode 100644 Documentation/PCI/endpoint/pci-ntb-howto.rst
>>>>  create mode 100644 drivers/ntb/hw/epf/Kconfig
>>>>  create mode 100644 drivers/ntb/hw/epf/Makefile
>>>>  create mode 100644 drivers/ntb/hw/epf/ntb_hw_epf.c
>>>>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-ntb.c
>>>>
