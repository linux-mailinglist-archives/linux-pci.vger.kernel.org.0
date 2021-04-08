Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD7A35848A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 15:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDHNXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 09:23:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16099 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHNXT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 09:23:19 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGMMl6dbnz19L8T;
        Thu,  8 Apr 2021 21:20:51 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 21:22:52 +0800
Subject: Re: [PATCH 3/4] docs: Add documentation for HiSilicon PTT device
 driver
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <alexander.shishkin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>, <gregkh@linuxfoundation.org>,
        <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <prime.zeng@huawei.com>, <linux-doc@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <20210407185541.GA1853071@bjorn-Precision-5520>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <9ecc2177-1c3d-9899-923d-9514f652bb4e@hisilicon.com>
Date:   Thu, 8 Apr 2021 21:22:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210407185541.GA1853071@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/4/8 2:55, Bjorn Helgaas wrote:
> Move important info in the subject earlier, e.g.,
> 
>   docs: Add HiSilicon PTT device documentation
> 
> On Tue, Apr 06, 2021 at 08:45:53PM +0800, Yicong Yang wrote:
>> Document the introduction and usage of HiSilicon PTT device driver.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  Documentation/trace/hisi-ptt.rst | 316 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 316 insertions(+)
>>  create mode 100644 Documentation/trace/hisi-ptt.rst
>>
>> diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
>> new file mode 100644
>> index 0000000..215676f
>> --- /dev/null
>> +++ b/Documentation/trace/hisi-ptt.rst
>> @@ -0,0 +1,316 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +======================================
>> +HiSilicon PCIe Tune and Trace device
>> +======================================
>> +
>> +Introduction
>> +============
>> +
>> +HiSilicon PCIe tune and trace device (PTT) is a PCIe Root Complex
>> +integrated Endpoint (RCiEP) device, providing the capability
>> +to dynamically monitor and tune the PCIe link's events (tune),
>> +and trace the TLP headers (trace). The two functions are independent,
>> +but is recommended to use them together to analyze and enhance the
>> +PCIe link's performance.
> 
>> +On Kunpeng 930 SoC, the PCIe root complex is composed of several
>> +PCIe cores.
>> +Each core is composed of several root ports, RCiEPs, and one
>> +PTT device, like below. The PTT device is capable of tuning and
>> +tracing the link of the PCIe core.
> 
> s/root complex/Root Complex/ to match spec, diagram, RCiEP above
> s/root ports/Root Ports/ to match spec, etc (also below)
> 

thanks. will fix here and below in this doc.

> Can you connect "Kunpeng 930" to something in the kernel tree?
> "git grep -i kunpeng" shows nothing that's obviously relevant.
> I assume there's a related driver in drivers/pci/controller/?
> 

Kunpeng 930 is the product name of Hip09 platform. The PCIe
controller uses the generic PCIe driver based on ACPI.

> Is this one paragraph or two?  If one, reflow.  If two, add blank line
> between.
> 

will reflow here and below. it's one paragraph.

> IIUC, the diagram below shows two PCIe cores, each with three Root
> Ports and a PTT RCiEP.  Your text mentions "RCiEPs, and one PTT" which
> suggests RCiEPs in addition to the PTT, but the diagram doesn't show
> any, and if there are other RCiEPs, they don't seem relevant to this
> doc.  Maybe something like this?
> 
>   Each PCIe core includes several Root Ports and a PTT RCiEP ...
> 

will fix.

>> +::
>> +          +--------------Core 0-------+
>> +          |       |       [   PTT   ] |
>> +          |       |       [Root Port]---[Endpoint]
>> +          |       |       [Root Port]---[Endpoint]
>> +          |       |       [Root Port]---[Endpoint]
>> +    Root Complex  |------Core 1-------+
>> +          |       |       [   PTT   ] |
>> +          |       |       [Root Port]---[ Switch ]---[Endpoint]
>> +          |       |       [Root Port]---[Endpoint] `-[Endpoint]
>> +          |       |       [Root Port]---[Endpoint]
>> +          +---------------------------+
>> +
>> +The PTT device driver cannot be loaded if debugfs is not mounted.
>> +Each PTT device will be presented under /sys/kernel/debugfs/hisi_ptt
>> +as its root directory, with name of its BDF number.
>> +::
>> +
>> +    /sys/kernel/debug/hisi_ptt/<domain>:<bus>:<device>.<function>
>> +
>> +Tune
>> +====
>> +
>> +PTT tune is designed for monitoring and adjusting PCIe link parameters(events).
> 
> Add a space before "(".
> 

will add here and below.

>> +Currently we support events in 4 classes. The scope of the events
>> +covers the PCIe core with which the PTT device belongs to.
> 
> ... the PCIe core to which the PTT device belongs.

will fix.

>> +
>> +Each event is presented as a file under $(PTT root dir)/$(BDF)/tune, and
>> +mostly a simple open/read/write/close cycle will be used to tune
>> +the event.
>> +::
>> +    $ cd /sys/kernel/debug/hisi_ptt/$(BDF)/tune
>> +    $ ls
>> +    qos_tx_cpl    qos_tx_np    qos_tx_p
>> +    tx_path_rx_req_alloc_buf_level
>> +    tx_path_tx_req_alloc_buf_level
>> +    $ cat qos_tx_dp
>> +    1
>> +    $ echo 2 > qos_tx_dp
>> +    $ cat qos_tx_dp
>> +    2
>> +
>> +Current value(numerical value) of the event can be simply read
> 
> Add space before "(".
> 
>> +from the file, and the desired value written to the file to tune.
> 
>> +Tuning multiple events at the same time is not permitted, which means
>> +you cannot read or write more than one tune file at one time.
> 
> I think this is obvious from the model, so the sentence doesn't really
> add anything.  Each event is a separate file, and it's obvious that
> there's no way to write to multiple files simultaneously.
> 

from the usage we shown below this situation won't happen. I just worry
that users may have a program to open multiple files at the same time and
read/write simultaneously, so add this line here to mention the restriction.

>> +1. Tx path QoS control
>> +------------------------
>> +
>> +Following files are provided to tune the QoS of the tx path of the PCIe core.
> 
> "The following ..."
> will fix.
>> +- qos_tx_cpl: weight of tx completion TLPs
>> +- qos_tx_np: weight of tx non-posted TLPs
>> +- qos_tx_p: weight of tx posted TLPs
>> +
>> +The weight influences the proportion of certain packets on the PCIe link.
>> +For example, for the storage scenario, increase the proportion
>> +of the completion packets on the link to enhance the performance as
>> +more completions are consumed.
> 
> I don't believe you can directly influence the *proportions* of packet
> types.  The number and types of TLPs are determined by device driver
> MMIO accesses and device DMAs.  Maybe you can influence the
> *priority*?  I assume that regardless of these settings, the device
> always respects the transaction ordering rules in PCIe r5.0, sec 2.4,
> right?
> 

yes you're right. the word I used here is misleading and 'priority' is
precise. what we achieved won't violate the PCIe spec. the ordering
rules are always kept. When the ordering is kept, the packets with
larger weight will have more priority to be posted.

>> +The available tune data of these events is [0, 1, 2].
>> +Writing a negative value will return an error, and out of range
>> +values will be converted to 2. Note that the event value just
>> +indicates a probable level, but is not precise.
>> +
>> +2. Tx path buffer control
>> +-------------------------
>> +
>> +Following files are provided to tune the buffer of tx path of the PCIe core.
>> +
>> +- tx_path_rx_req_alloc_buf_level: watermark of RX requested
>> +- tx_path_tx_req_alloc_buf_level: watermark of TX requested
>> +
>> +These events influence the watermark of the buffer allocated for each
>> +type. RX means the inbound while Tx means outbound. For a busy
>> +direction, you should increase the related buffer watermark to enhance
>> +the performance.
> 
> Based on what you have written here, I would just write 2 to both
> files to enhance the performance in both directions.  But obviously
> there must be some tradeoff here, e.g., increasing Rx performance
> comes at the cost of Tx performane.
> 

the Rx buffer and Tx buffer are separate, so they won't influence
each other.

> Use "Rx" or "RX" (and "Tx" or "TX") consistently.  So far we have
> "tx", "TX", "Tx", as well as "RX" and "Tx" in the same sentence.
> 

will fix here and at other places in the doc.

>> +The available tune data of above events is [0, 1, 2].
>> +Writing a negative value will return an error, and out of range
>> +values will be converted to 2. Note that the event value just
>> +indicates a probable level, but is not precise.
>> +
>> +Trace
>> +=====
>> +
>> +PTT trace is designed for dumping the TLP headers to the memory, which
>> +can be used to analyze the transactions and usage condition of the PCIe
>> +Link. You can chose to filter the traced headers by either requester ID,
> 
> s/chose/choose/
> will fix.
>> +or those downstream of a set of root ports on the same core of the PTT
>> +device. It's also support to trace the headers of certain type and of
>> +certain direction.
> 
> s/support/supported/
> 
will fix.
>> +In order to start trace, you need to configure the parameters first.
>> +The parameters files is provided under $(PTT root dir)/$(BDF)/trace.
> 
> s/files is/files are/
> 
will fix.
>> +::
>> +    $ cd /sys/kernel/debug/hisi_ptt/$(BDF)/trace
>> +    $ ls
>> +    free_buffer     filter      buflet_nums     buflet_size
>> +    direction       type        data            trace_on
>> +    data_format
>> +
>> +1. filter
>> +---------
>> +
>> +You can configure the filter of TLP headers through the file. The filter
>> +is provided as BDF numbers of either root port or subordinates, which
>> +belong to the same PCIe core. You can get the filters available and
>> +currently configured by read the file, and write the desired BDF to the
>> +file to set the filters. There is no default filter, which means you
>> +must specifiy at least one filter before start tracing.
>> +Write invalid BDF(not in the available list) will return
>> +a failure.
> 
> s/by read/by reading/
> s/specifiy/specify/
> s/before start/before starting/
> s/Write invalid/Writing an invalid/
> s/BDF(not/BDF (not/
> 
> Reflow or separate paragraphs with blank lines.
> 
will fix these and reflow here.
>> +::
>> +    $ echo 0000:80:04.0 > filter
>> +    $ cat filter
>> +    #### Root Ports ####
>> +    0000:80:00.0
>> +    [0000:80:04.0]
>> +    #### Functions ####
>> +    0000:81:00.0
>> +    0000:81:00.1
>> +    0000:82:00.0
>> +
>> +Note that multiple root ports can be specified at one time, but only
>> +one Endpoint function can be specified in one trace.
>> +Specifying both root port and function at the same time is not supported.
>> +
>> +If no filter is available, read the filter will get the hint.
> 
> s/read the/reading the/
> 
will fix.
>> +::
>> +    $ cat filter
>> +    #### No available filter ####
>> +
>> +The filter can be dynamically updated, which means you can always
>> +get correct filter information when hotplug events happens, or
>> +manually remove/rescan the devices.
> 
> s/events happens/events happen/
> s/or manually remove/or when you manually remove/
> 
will fix.
>> +2. type
>> +-------
>> +
>> +You can trace the TLP headers of certain types by configure the file.
>> +Read the file will get available types and current setting, and write
>> +the desired type to the file to configure. The default type is
>> +`posted_request` and write types not in the available list will return
>> +a failure.
> 
> s/by configure/by configuring/
> s/Read the file/Reading the file/
> s/, and write the/. Write the/
> 
will fix.
>> +::
>> +    $ echo completion > type
>> +    $ cat type
>> +    all  posted_request  non-posted_request  [completion]
>> +
>> +3. direction
>> +------------
>> +
>> +You can trace the TLP headers from certain direction, which is relative
>> +to the root port or the PCIe core. Read the file to get available
>> +directions and current configurition, and write the desired direction
>> +to configure. The default value is `rx` and any invalid direction will
>> +return a failure. Note `rxtx_no_dma_p2p` means the headers of both
>> +directions, but not include P2P DMA access.
>> +::
>> +    $ echo rxtx > direction
>> +    $ cat direction
>> +    rx  tx  [rxtx]  rxtx_no_dma_p2p
>> +
>> +4. buflet_size
>> +--------------
>> +
>> +The traced TLP headers will be written to the memory allocated
>> +by the driver. The hardware accept 4 DMA address with same size,
>> +and write the buflet sequentially like below. If DMA addr 3 is
>> +finished and the trace is still on, it will return to addr 0.
>> +Driver will allocated each DMA buffer (we call it buflet).
>> +The finished buflet will be replaced with a new one, so
>> +a long time trace can be achieved.
> 
> s/hardware accept/hardware accepts/
> s/and write the/and writes the/
> s/will allocated/will allocate/
> 
will fix.
>> +::
>> +    +->[DMA addr 0]->[DMA addr 1]->[DMA addr 2]->[DMA addr 3]-+
>> +    +---------------------------------------------------------+
>> +
>> +You should both configure the buflet_size and buflet_nums to
>> +configure the `trace buffer` to receive the TLP headers. The
>> +total trace buffer size is buflet_size * buflet_nums. Note
>> +that the trace buffer will not be allocated immediately after you
>> +configure the parameters, but will be allocated right before
>> +the trace starts.
>> +
>> +This file configures the buflet size. Read the file will get
>> +available buflet size and size set currently, write the desired
>> +size to the file to configure. The default size is 2 MiB and any
>> +invalid size written will return a failure.
> 
> s/Read the file/Reading the file/
> s/currently, write the/currently; write the/
> 
will fix.
>> +::
>> +    $ cat buflet_size
>> +    [2 MiB]     4 MiB
>> +    $ echo 4 > buflet_size
>> +    $ cat buflet_size
>> +    2 MiB     [4 MiB]
>> +
>> +5. buflet_nums
>> +--------------
>> +
>> +You can write the desired buflet count to the file to configure,
>> +and read the file to get current buflet count. The default
>> +value is 64. And any positive value is valid. Note that big value
>> +may lead to DMA memory allocation failure, and you will not be
>> +able to start tracing. If it happens, you should consider adjusting
>> +buflet_nums or buflet_size.
> 
> s/And any positive/Any positive/
> 
will fix.
>> +::
>> +    $ cat buflet_nums
>> +    64
>> +    $ echo 128 > buflet_nums
>> +    $ cat buflet_nums
>> +    128
>> +
>> +6. data
>> +-------
>> +
>> +The file to access the traced data. You can read the file to get the
>> +binary blob of traced TLP headers. The format of the headers is
>> +4 Dword length and is just as defined by the PCIe Spec r4.0,
>> +Sec 2.2.4.1, or 8 Dword length with additional 4 Dword extra
>> +information.
>> +
>> +echo "" > data will free all the trace buffers allocated as well as
>> +the traced datas.
>> +
>> +7. trace_on
>> +-----------
>> +
>> +Start or end the trace by simple writing to the file, and monitor the
>> +trace status by reading the file.
> 
> s/by simple writing/by writing/
> 
will fix.
>> +::
>> +    $ echo 1 > trace_on     # start trace
>> +    $ cat trace_on          # get the trace status
>> +    1
>> +    $ echo 0 > trace_on     # manually end trace
>> +
>> +The read value of the trace_on will be auto cleared if the buffer
>> +allocated is full. 1 indicates the trace is running and 0 for
>> +stopped. Write any non-zero value to the file can start trace.
> 
> "Writing any non-zero value to the file starts tracing."
> 
will fix.
>> +8. free_buffer
>> +--------------
>> +
>> +File to indicate the trace buffer status and to manually free the
>> +trace buffer. The read value of 1 indicates the trace buffer has
>> +been allocated and exists in the memory, while 0 indicates there
>> +is no buffer allocated. Write 1 to the file to free the trace
>> +buffer as well as the traced datas.
> 
> s/datas/data/
> 
will fix.
>> +::
>> +    $ cat free_buffer
>> +    1                       # indicate the buffer exists
>> +    $ echo 1 > free_buffer  # free the trace buffer
>> +    $ cat free_buffer
>> +    0
>> +
>> +9. data_format
>> +--------------
>> +
>> +File to indicate the format of the traced TLP headers. User can also
>> +specify the desired format of traced TLP headers. Available formats
>> +are 4DW, 8DW which indicates the length of each TLP headers traced.
>> +::
>> +    $ cat data_format
>> +    [4DW]    8DW
>> +    $ echo 8 > data_format
>> +    $ cat data_format
>> +    4DW     [8DW]
>> +
>> +The traced TLP header format is different from the PCIe standard.
> 
> I'm confused.  Below you say the fields of the traced TLP header are
> defined by the PCIe spec.  But here you say the format is *different*.
> What exactly is different?
> 

For the Request Header Format for 64-bit addressing of Memory, defind in
PCIe spec 4.0, Figure 2-15, the 1st DW is like:

Byte 0 > [Fmt] [Type] [T9] [Tc] [T8] [Attr] [LN] [TH] ... [Length]

some are recorded in our traced header like below, which some are not.
that's what I mean the format of the header are different. But for a
certain field like 'Fmt', the meaning keeps same with what Spec defined.
that's what I mean the fields definition of our traced header keep same
with the Spec.

Seem what I described in the doc is a little ambigious.

Thanks for the review.

Thanks,
Yicong

>> +4DW format is like
>> +::
>> +    bits [31:30] [ 29:25 ][24][23][22][21][    20:11   ][    10:0    ]
>> +         |-----|---------|---|---|---|---|-------------|-------------|
>> +     DW0 [ Fmt ][  Type  ][T9][T8][TH][SO][   Length   ][    Time    ]
>> +     DW1 [                     Header DW1                            ]
>> +     DW2 [                     Header DW2                            ]
>> +     DW3 [                     Header DW3                            ]
>> +
>> +For 8DW format, the bit[31:11] of DW0 is always 0x1fffff, which can be
>> +used to distinguish the data format. 8DW format is like
>> +::
>> +    bits [                 31:11                 ][       10:0       ]
>> +         |---------------------------------------|-------------------|
>> +     DW0 [                0x1fffff               ][ Reserved (0x7ff) ]
>> +     DW1 [                       Prefix                              ]
>> +     DW2 [                     Header DW0                            ]
>> +     DW3 [                     Header DW1                            ]
>> +     DW4 [                     Header DW2                            ]
>> +     DW5 [                     Header DW3                            ]
>> +     DW6 [                   Reserved (0x0)                          ]
>> +     DW7 [                        Time                               ]
>> +
>> +All the fields of the traced TLP header is defined by the PCIe Specification.
>> +While 'Header DWx' means standard TLP header DWord x, and 'Time' is the
>> +timestamp of the traced header.
>> -- 
>> 2.8.1
>>
> 
> .
> 

