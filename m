Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA9369BA3B
	for <lists+linux-pci@lfdr.de>; Sat, 18 Feb 2023 14:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBRNXF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Feb 2023 08:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBRNXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Feb 2023 08:23:04 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A3193DD
        for <linux-pci@vger.kernel.org>; Sat, 18 Feb 2023 05:22:43 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.su@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VbvuUx7_1676726558;
Received: from 30.27.118.154(mailfrom:yang.su@linux.alibaba.com fp:SMTPD_---0VbvuUx7_1676726558)
          by smtp.aliyun-inc.com;
          Sat, 18 Feb 2023 21:22:40 +0800
Message-ID: <cc358ab3-0844-1341-7ae6-5af7110436f7@linux.alibaba.com>
Date:   Sat, 18 Feb 2023 21:22:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
From:   Yang Su <yang.su@linux.alibaba.com>
Subject: Re: [PATCH v2 1/3] PCI/PM: Observe reset delay irrespective of
 bridge_d3
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
 <eb37fa345285ec8bacabbf06b020b803f77bdd3d.1673769517.git.lukas@wunner.de>
In-Reply-To: <eb37fa345285ec8bacabbf06b020b803f77bdd3d.1673769517.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lucas,

I figue out the reason of pci_bridge_secondary_bus_reset() why not work 
for NVIDIA GPU T4

which bind vfio passthrough hypervisor. I used the original func 
pci_bridge_secondary_bus_reset()

not your patch, your patch remove bridge_d3 flag, the real reason is 
bridge_d3 flag.

> However, pci_bridge_wait_for_secondary_bus() bails out if the bridge_d3
> flag is not set.  That flag indicates whether a bridge is allowed to
> suspend to D3cold at *runtime*.
>
>   drivers/pci/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fba95486caaf..f43f3e84f634 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4964,7 +4964,7 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>   	if (pci_dev_is_disconnected(dev))
>   		return;
>   
> -	if (!pci_is_bridge(dev) || !dev->bridge_d3)
> +	if (!pci_is_bridge(dev))
>   		return;
>   
>   	down_read(&pci_bus_sem);

When I test the original func pci_bridge_secondary_bus_reset() in 
different machine node

which all consist of the same type NVIDIA GPU T4, I found 
pci_bridge_wait_for_secondary_bus()

bails out if the bridge_d3 flag is not set, but I still confused why 
same gpu some machine node not set

the bridge_d3 flag.

I find the linux kernel only two func will init bridge_d3 which is func 
pci_pm_init() and pci_bridge_d3_update().

If you know, please give me some hint.

On 2023/1/15 16:20, Lukas Wunner wrote:
> If a PCI bridge is suspended to D3cold upon entering system sleep,
> resuming it entails a Fundamental Reset per PCIe r6.0 sec 5.8.
>
> The delay prescribed after a Fundamental Reset in PCIe r6.0 sec 6.6.1
> is sought to be observed by:
>
>    pci_pm_resume_noirq()
>      pci_pm_bridge_power_up_actions()
>        pci_bridge_wait_for_secondary_bus()
>
> However, pci_bridge_wait_for_secondary_bus() bails out if the bridge_d3
> flag is not set.  That flag indicates whether a bridge is allowed to
> suspend to D3cold at *runtime*.
>
> Hence *no* delay is observed on resume from system sleep if runtime
> D3cold is forbidden.  That doesn't make any sense, so drop the bridge_d3
> check from pci_bridge_wait_for_secondary_bus().
>
> The purpose of the bridge_d3 check was probably to avoid delays if a
> bridge remained in D0 during suspend.  However the sole caller of
> pci_bridge_wait_for_secondary_bus(), pci_pm_bridge_power_up_actions(),
> is only invoked if the previous power state was D3cold.  Hence the
> additional bridge_d3 check seems superfluous.
>
> Fixes: ad9001f2f411 ("PCI/PM: Add missing link delays required by the PCIe spec")
> Tested-by: Ravi Kishore Koppuravuri<ravi.kishore.koppuravuri@intel.com>
> Signed-off-by: Lukas Wunner<lukas@wunner.de>
> Reviewed-by: Mika Westerberg<mika.westerberg@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc:stable@vger.kernel.org  # v5.5+
> ---
> Changes v1 -> v2:
>   * Add Reviewed-by tags (Mika, Sathyanarayanan)
>
>   drivers/pci/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fba95486caaf..f43f3e84f634 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4964,7 +4964,7 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>   	if (pci_dev_is_disconnected(dev))
>   		return;
>   
> -	if (!pci_is_bridge(dev) || !dev->bridge_d3)
> +	if (!pci_is_bridge(dev))
>   		return;
>   
>   	down_read(&pci_bus_sem);



Below is reply for your another email about the device invoke secondary 
bus reset.

Yes, as your previous email describes the endpoint can not reset its 
secondary bus.

> Normally pci_bridge_secondary_bus_reset() should never be executed for
> an endpoint device such as the Nvidia GPU T4.  It should only be executed
> for one of the bridges above the GPU.  An endpoint cannot reset its
> secondary bus, it doesn't have one.

As previous email I give the pci topology for the NVIDIA GPU T4, here I 
copy as below,

you say that means:

0000:17:00.0 = Root Port
0000:18:00.0 = Switch Upstream Port of PLX 9797
0000:19:04.0 = Switch Downstream Port of PLX 9797
0000:19:08.0 = Switch Downstream Port of PLX 9797
0000:4f:00.0 = Nvidia GPU T4

I apply your debug patch, the pci_info print the device is 0000:19:08.0 
which is the parent of

the endpoint device 0000:4f:00.0.

> pci_parent_bus_reset() invokes pci_bridge_secondary_bus_reset() on the
> parent of the device to be reset.  In this case that's the Switch Downstream
> Port 0000:19:08.0.  It finds the parent by following dev->bus->self.
>
> Perhaps you can apply the small debug patch below.  It should print a message
> when entering pci_bridge_secondary_bus_reset() and the message contains the
> pci_name() of the device for which the function is executed.  If this is
> not the Switch Downstream Port, you've found a bug.
>
> Usually a better way of finding the parent device is to call
> pci_upstream_bridge() instead of following dev->bus->self.  As you can
> see in the definition of pci_upstream_bridge() in include/linux/pci.h,
> this will find the parent of pci_phys_fn(dev).  So in virtualization
> scenarios, the result may indeed be different from dev->bus->self,
> but I still don't understand how.  You may want to try replacing
> dev->bus->self with pci_upstream_bridge(dev) in pci_parent_bus_reset()
> and see if that fixes the issue for you.
>
> Thanks,
>
> Lukas
>
> -- >8 --
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 19fe0ef0e583..f383e5d29bb1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5073,6 +5073,9 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>    */
>   int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>   {
> +	pci_info(dev, "%s\n", __func__);
> +	dump_stack();
> +
>   	pcibios_reset_secondary_bus(dev);
>   
>   	return pci_bridge_wait_for_secondary_bus(dev, "bus reset",



Thanks,

Yang



