Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1F51F397C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 13:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgFILVL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 07:21:11 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:54624 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgFILVL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 07:21:11 -0400
Received: from [192.168.5.236] (unknown [94.230.82.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPSA id 0D2A74404F9;
        Tue,  9 Jun 2020 14:21:08 +0300 (IDT)
Subject: Re: [RFC PATCH] pci: pci-mvebu: setup BAR0 to internal-regs
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris ackham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200608144024.1161237-1-sh@tkos.co.il>
 <20200608214335.156baaaa@windsurf>
From:   "Shmuel H." <sh@tkos.co.il>
Message-ID: <df64c0b9-cba7-c92e-c32d-804a75796f83@tkos.co.il>
Date:   Tue, 9 Jun 2020 14:21:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608214335.156baaaa@windsurf>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 6/8/20 10:43 PM, Thomas Petazzoni wrote:
> On Mon,  8 Jun 2020 17:40:25 +0300
> Shmuel Hazan <sh@tkos.co.il> wrote:
>
>> From: Shmuel H <sh@tkos.co.il>
>>
>> Set the port's BAR0 address to the SOC's internal registers address. By default, this register will point to 0xd0000000, which is not correct.
>>
>> Signed-off-by: Shmuel Hazan <sh@tkos.co.il>
>> ---
>> Sending again since I forgot to include a number of email addresses. 
>>
>> Without this patch the wil6210 driver fails on interface up as follows:
>>
>> # ip link set wlan0 up
>> [   46.142664] wil6210 0000:01:00.0 wlan0: wil_reset: Use firmware
>> <wil6210.fw> + board <wil6210.brd>
>> [   48.244216] wil6210 0000:01:00.0 wlan0: wil_wait_for_fw_ready:
>> Firmware not ready
>> ip: SIOCSIFFLAGS: Device timeout
> Do you have any idea why this particular would not work, while many
> other PCIe devices do ?

Unfortunately, there is almost no documentation about the purpose of
this register apart from this cryptic sentence:

     "BAR0 is dedicated to internal register access" (Marvell a38x
functional docs, section 19.8).

I can only assume that only specific devices trigger the need for the
PCIe controller to access the SoC's internal registers and therefore
will fail to operate properly.

>
>> With this patch, interface up succeeds:
>>
>> # ip link set wlan0 up
>> [   53.632667] wil6210 0000:01:00.0 wlan0: wil_reset: Use firmware
>> <wil6210.fw> + board <wil6210.brd>
>> [   53.666560] wil6210 0000:01:00.0 wlan0: wmi_evt_ready: FW ver.
>> 5.2.0.18(SW 18); MAC 40:0e:85:c0:77:5c; 0 MID's
>> [   53.676636] wil6210 0000:01:00.0 wlan0: wil_wait_for_fw_ready: FW
>> ready after 20 ms. HW version 0x00000002
>> [   53.686478] wil6210 0000:01:00.0 wlan0:
>> wil_configure_interrupt_moderation: set ITR_TX_CNT_TRSH = 500 usec
>> [   53.696191] wil6210 0000:01:00.0 wlan0:
>> wil_configure_interrupt_moderation: set ITR_TX_IDL_CNT_TRSH = 13 usec
>> [   53.706156] wil6210 0000:01:00.0 wlan0:
>> wil_configure_interrupt_moderation: set ITR_RX_CNT_TRSH = 500 usec
>> [   53.715855] wil6210 0000:01:00.0 wlan0:
>> wil_configure_interrupt_moderation: set ITR_RX_IDL_CNT_TRSH = 13 usec
>> [   53.725819] wil6210 0000:01:00.0 wlan0: wil_refresh_fw_capabilities:
>> keep_radio_on_during_sleep (0)
>>
>> Tested on Armada 38x based system.
>>
>> Another related bit of information is this U-Boot commit:
>>
>>   https://gitlab.denx.de/u-boot/u-boot/commit/193a1e9f196b7fb7e913a70936c8a49060a1859c
>>
>> It looks like some other devices are also affected the BAR0
>> initialization.
>> However, by default, u-boot won't initialize any PCI bus. Which
>> will cause the BAR0 register to stay on its default value. 
> Perhaps you want to include more of these details in the commit log.

Thanks, will do.

>
>> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
>> index 153a64676bc9..4a00e1b81b4f 100644
>> --- a/drivers/pci/controller/pci-mvebu.c
>> +++ b/drivers/pci/controller/pci-mvebu.c
>> @@ -203,6 +203,11 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
>>  	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(1));
>>  	mvebu_writel(port, ((size - 1) & 0xffff0000) | 1,
>>  		     PCIE_BAR_CTRL_OFF(1));
>> +	
>> +	/* Point BAR0 to the device's internal registers (internal-regs on 
>> +	 * a38x, orion and more) */
>> +	mvebu_writel(port, 0xf1000000, PCIE_BAR_LO_OFF(0));
> Some Armada 370/XP platforms really do use 0xd0000000 as the base
> address of the internal registers. This information is available in the
> DT. I think you could simply take the base address of the PCIe
> controller, round down to 1 MB (which is the size of the internal
> registers window) and that would give you the right address.

Thanks, that a great idea.

>
> However, it would be good to understand this a little bit better.
>
> Is this something you're seeing with mainline U-Boot only ? Or also
> with the vendor U-Boot ? Only with this specific PCIe device ?

The current mainline u-boot and the current vendor u-boot (based on
u-boot 2018.4) behave the same. However, the old vendor u-boot (based on
2013) does solve this problem and explicitly enables and initialize this
BAR for each PCI bus.

See for a reference the mvPexWinInit function on
u-boot-marvell/board/mv_ebu/common/mv_hal/pex/mvPexAddrDec.c on the old
2013 vendor u-boot:
   
   
https://github.com/MarvellEmbeddedProcessors/u-boot-marvell/blob/u-boot-2013.01/board/mv_ebu/common/mv_hal/pex/mvPexAddrDec.c#L109

As for PCIe devices, I only tested two devices so far:
    - Wilocity Wil6200 rev 2 (wil6210)
    - Qualcomm Atheros QCA6174 (ath10k_pci)

Both didn't work without this patch but seems to operate properly after
this patch.

For example, without this patch, the QCA6174 fails as follow:

# echo "0000:01:00.0" > /sys/bus/pci/drivers/ath10k_pci/bind
[  554.148214] ath10k_pci 0000:01:00.0: Direct firmware load for
ath10k/cal-pci-0000:01:00.0.bin failed with error -2
[  554.160871] ath10k_pci 0000:01:00.0: qca6174 hw3.2 target 0x05030000
chip_id 0x00340aff sub 14cd:9008
[  554.170181] ath10k_pci 0000:01:00.0: kconfig debug 1 debugfs 1
tracing 1 dfs 0 testmode 0
[  554.180286] ath10k_pci 0000:01:00.0: firmware ver
WLAN.RM.4.4.1-00140-QCARMSWPZ-1 api 6 features wowlan,ignore-otp,mfp
crc32 29eb8ca1
[  554.257017] ath10k_pci 0000:01:00.0: board_file api 2 bmi_id N/A
crc32 4ed3569e
[  555.845051] ath10k_pci 0000:01:00.0: failed to receive control
response completion, polling..
[  556.885048] ath10k_pci 0000:01:00.0: Service connect timeout
[  556.890746] ath10k_pci 0000:01:00.0: failed to connect htt (-110)
[  557.005731] ath10k_pci 0000:01:00.0: could not init core (-110)
[  557.011785] ath10k_pci 0000:01:00.0: could not probe fw (-110)

After this patch, the driver loads successfully (I also verified that
wifi scanning operates properly):

# echo "0000:01:00.0" > /sys/bus/pci/drivers/ath10k_pci/bind
[  203.945785] ath10k_pci 0000:01:00.0: pci irq msi oper_irq_mode 2
irq_mode 0 reset_mode 0
[  204.337879] ath10k_pci 0000:01:00.0: Direct firmware load for
ath10k/pre-cal-pci-0000:01:00.0.bin failed with error -2
[  204.349101] ath10k_pci 0000:01:00.0: Direct firmware load for
ath10k/cal-pci-0000:01:00.0.bin failed with error -2
[  204.371089] ath10k_pci 0000:01:00.0: qca6174 hw3.2 target 0x05030000
chip_id 0x00340aff sub 14cd:9008
[  204.380382] ath10k_pci 0000:01:00.0: kconfig debug 1 debugfs 1
tracing 1 dfs 0 testmode 0
[  204.390499] ath10k_pci 0000:01:00.0: firmware ver
WLAN.RM.4.4.1-00140-QCARMSWPZ-1 api 6 features wowlan,ignore-otp,mfp
crc32 29eb8ca1
[  204.475522] ath10k_pci 0000:01:00.0: board_file api 2 bmi_id N/A
crc32 4ed3569e
[  205.023716] ath10k_pci 0000:01:00.0: Unknown eventid: 3
[  205.044022] ath10k_pci 0000:01:00.0: Unknown eventid: 118809
[  205.049769] ath10k_pci 0000:01:00.0: Unknown eventid: 90118
[  205.055597] ath10k_pci 0000:01:00.0: htt-ver 3.60 wmi-op 4 htt-op 3
cal otp max-sta 32 raw 0 hwcrypto 1

>
> Thomas

-- 
- Shmuel Hazan

mailto:sh@tkos.co.il | tel:+972-523-746-435 | http://tkos.co.il

