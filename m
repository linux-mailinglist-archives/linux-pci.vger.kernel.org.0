Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BEF69BA3D
	for <lists+linux-pci@lfdr.de>; Sat, 18 Feb 2023 14:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBRNXy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Feb 2023 08:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRNXy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Feb 2023 08:23:54 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1D918175
        for <linux-pci@vger.kernel.org>; Sat, 18 Feb 2023 05:23:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.su@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VbvzGtC_1676726627;
Received: from 30.27.118.154(mailfrom:yang.su@linux.alibaba.com fp:SMTPD_---0VbvzGtC_1676726627)
          by smtp.aliyun-inc.com;
          Sat, 18 Feb 2023 21:23:49 +0800
Message-ID: <5d5ee171-18e5-f1b8-d08a-0d88f8eb3a3f@linux.alibaba.com>
Date:   Sat, 18 Feb 2023 21:23:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
From:   Yang Su <yang.su@linux.alibaba.com>
Subject: Re: [PATCH v2 3/3] PCI/DPC: Await readiness of secondary bus after
 reset
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        shuo.tan@linux.alibaba.com
References: <cover.1673769517.git.lukas@wunner.de>
 <9f5ff00e1593d8d9a4b452398b98aa14d23fca11.1673769517.git.lukas@wunner.de>
In-Reply-To: <9f5ff00e1593d8d9a4b452398b98aa14d23fca11.1673769517.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lucas,

I do not understand why pci_bridge_wait_for_secondary_bus() can fix 
Intel's Ponte Vecchio HPC GPU

after a DPC-induced Hot Reset.


The func pci_bridge_wait_for_secondary_bus() also use 
pcie_wait_for_link_delay() which time depends on

the max device delay time of one bus, for the GPU which bus only one 
device, I think the time is 100ms as

the input parater in pcie_wait_for_link_delay().


pcie_wait_for_link() also wait fixed 100ms and then wait the device data 
link is ready. So another wait time

is pci_dev_wait() in your patch? pci_dev_wait() to receive the CRS from 
the device to check the device

whether is ready.


Please help me understand which difference work.


On 2023/1/15 16:20, Lukas Wunner wrote:
> pci_bridge_wait_for_secondary_bus() is called after a Secondary Bus
> Reset, but not after a DPC-induced Hot Reset.
>
> As a result, the delays prescribed by PCIe r6.0 sec 6.6.1 are not
> observed and devices on the secondary bus may be accessed before
> they're ready.
>
> One affected device is Intel's Ponte Vecchio HPC GPU.  It comprises a
> PCIe switch whose upstream port is not immediately ready after reset.
> Because its config space is restored too early, it remains in
> D0uninitialized, its subordinate devices remain inaccessible and DPC
> recovery fails with messages such as:
>
> i915 0000:8c:00.0: can't change power state from D3cold to D0 (config space inaccessible)
> intel_vsec 0000:8e:00.1: can't change power state from D3cold to D0 (config space inaccessible)
> pcieport 0000:89:02.0: AER: device recovery failed
>
> Fix it.
>
> Tested-by: Ravi Kishore Koppuravuri<ravi.kishore.koppuravuri@intel.com>
> Signed-off-by: Lukas Wunner<lukas@wunner.de>
> Reviewed-by: Mika Westerberg<mika.westerberg@linux.intel.com>
> Cc:stable@vger.kernel.org
> ---
> Changes v1 -> v2:
>   * Move PCIE_RESET_READY_POLL_MS macro below the newly introduced
>     PCI_RESET_WAIT from patch [2/3] and extend its code comment
>   * Mention errors seen on Ponte Vecchio in commit message (Bjorn)
>   * Avoid first person plural in commit message (Sathyanarayanan)
>   * Add Reviewed-by tag (Mika)
>
>   drivers/pci/pci.c      | 3 ---
>   drivers/pci/pci.h      | 6 ++++++
>   drivers/pci/pcie/dpc.c | 4 ++--
>   3 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 509f6b5c9e14..d31c21ea9688 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -167,9 +167,6 @@ static int __init pcie_port_pm_setup(char *str)
>   }
>   __setup("pcie_port_pm=", pcie_port_pm_setup);
>   
> -/* Time to wait after a reset for device to become responsive */
> -#define PCIE_RESET_READY_POLL_MS 60000
> -
>   /**
>    * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
>    * @bus: pointer to PCI bus structure to search
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ce1fc3a90b3f..8f5d4bd5b410 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -70,6 +70,12 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
>    * Reset (PCIe r6.0 sec 5.8).
>    */
>   #define PCI_RESET_WAIT		1000	/* msec */
> +/*
> + * Devices may extend the 1 sec period through Request Retry Status completions
> + * (PCIe r6.0 sec 2.3.1).  The spec does not provide an upper limit, but 60 sec
> + * ought to be enough for any device to become responsive.
> + */
> +#define PCIE_RESET_READY_POLL_MS 60000	/* msec */
>   
>   void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
>   void pci_refresh_power_state(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index f5ffea17c7f8..a5d7c69b764e 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -170,8 +170,8 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>   	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>   			      PCI_EXP_DPC_STATUS_TRIGGER);
>   
> -	if (!pcie_wait_for_link(pdev, true)) {
> -		pci_info(pdev, "Data Link Layer Link Active not set in 1000 msec\n");
> +	if (pci_bridge_wait_for_secondary_bus(pdev, "DPC",
> +					      PCIE_RESET_READY_POLL_MS)) {
>   		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>   		ret = PCI_ERS_RESULT_DISCONNECT;
>   	} else {


Thanks,


Yang

