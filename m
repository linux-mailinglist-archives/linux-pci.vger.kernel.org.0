Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D678391D7F
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 19:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhEZRFZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 13:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhEZRFZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 13:05:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE61BC061574;
        Wed, 26 May 2021 10:03:53 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so694856pjt.1;
        Wed, 26 May 2021 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xT+yhDMO6OD6PyrpGSwTBHhXXY+UFBqPmmqeyFpyYak=;
        b=XJRfztxxVsOlkyAJsKviYFdmXuRK4CLEV1kX1I6wzGFHz3/rtW5wMJUoFAACteRS6c
         4XEM9mV03TjZo9VyZY853wc/kFVxfLK6KRmjb/M0wBWISEjiEVlqLiqUZpzaPUVmFqyK
         N4cfog47voF2fwohl93PtkX1OVz7/rdvsfUYV9zaSMBUsqnbre2rcDWaW7is4f54eWbv
         1jGPceZFrJqxs40KNLvcU2QJqUexjqH8BYj3Wbx+gQKnkP0vwtPjXgy8MXsNCmh3Oz2B
         LM0k5nkYijB4sKihCzrtEenXu6kgqLuaIfAsIaPA/DfhlD9a7G05jwNjds/UOl/hpW2s
         2b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xT+yhDMO6OD6PyrpGSwTBHhXXY+UFBqPmmqeyFpyYak=;
        b=Xbr30mL3SkGQfiU9FdzzL8v1mHwRfVEgtpnvCByaIrOD3GIsSouOqXqRUskq/0lTLT
         19PjTkY5Cu2jtcPvGmYK6WMNU4zZZN+AM6+8eXEcEEDFwpwYyu1dpfexOv4T/McSQx7q
         0h9vk7muzgEzOPySLjfuSUsx40eQg+olnFsv5zc+GbgotkTuZFLSwhnwMzzF14liUMeA
         tm8gDIs7lQxmfLrMkWkSeIvhu+hbuae34gnmLMRYP4SueUk5krnBYhK+2cNvFD73qotm
         eek5W2wzsvi+tfkv41Yh5X0ZXzde2ylX9fJ14Am+ufmfdxQ6EdWOxzm8gy8lgr/j1n60
         uUiQ==
X-Gm-Message-State: AOAM530091Isuiw0GA8RHdr2lWI88wAVlMK9+o8ncFkIhUDVtQwawcnm
        suh5a8m5WLuKOCgQ+9QfRnfTG214K6g=
X-Google-Smtp-Source: ABdhPJwTPAVoqHyyRBhaGpswHWLCYFQw/HReGBKI1/R2IICZj3SH/lx9JoyooOjE/tIWQAHwdwmvlQ==
X-Received: by 2002:a17:90a:4fc2:: with SMTP id q60mr2999927pjh.64.1622048632845;
        Wed, 26 May 2021 10:03:52 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t7sm14916711pju.4.2021.05.26.10.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 10:03:52 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] PCI: brcmstb: add shutdown call to driver
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210525211804.GA1228022@bjorn-Precision-5520>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2c046f34-8bf1-97ff-3440-7351c7b2d528@gmail.com>
Date:   Wed, 26 May 2021 10:03:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210525211804.GA1228022@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/25/21 2:18 PM, Bjorn Helgaas wrote:
> Capitalize "Add" in the subject.
> 
> On Tue, Apr 27, 2021 at 01:51:39PM -0400, Jim Quinlan wrote:
>> The shutdown() call is similar to the remove() call except the former does
>> not need to invoke pci_{stop,remove}_root_bus(), and besides, errors occur
>> if it does.
> 
> This doesn't explain why shutdown() is necessary.  "errors occur"
> might be a hint, except that AFAICT, many similar drivers do invoke
> pci_stop_root_bus() and pci_remove_root_bus() (several of them while
> holding pci_lock_rescan_remove()), without implementing .shutdown().

We have to implement .shutdown() in order to meet a certain power budget
while the chip is being put into S5 (soft off) state and still support
Wake-on-WLAN, for our latest chips this translates into roughly 200mW of
power savings at the wall. We could probably add a word or two in a v2
that indicates this is done for power savings.

As far as the crash goes, if we call brcm_pcie_remove() directly from
brcm_pcie_shutdown() we see the following (this is in 5.4, but I have no
reason to believe mainline is different):

# lspci
0001:00:00.0 PCI bridge: Broadcom Inc. and subsidiaries Device 7216 (rev 10)
0001:01:00.0 Network controller: Qualcomm Atheros AR9285 Wireless
Network Adapter (PCI-Express) (rev 01)
# reboot -f
[    8.465111] ------------[ cut here ]------------
[    8.469771] pcieport 0001:00:00.0: disabling already-disabled device
[    8.469817] WARNING: CPU: 3 PID: 1656 at drivers/pci/pci.c:1945
pci_disable_device+0x78/0xd0
[    8.484631] Modules linked in:
[    8.487695] CPU: 3 PID: 1656 Comm: reboot Not tainted
5.4.120-1.1pre-g231f2cfa989a #4
[    8.495537] Hardware name: BCX972160DV (DT)
[    8.499728] pstate: 60000005 (nZCv daif -PAN -UAO)
[    8.504527] pc : pci_disable_device+0x78/0xd0
[    8.508891] lr : pci_disable_device+0x78/0xd0
[    8.513254] sp : ffffffc014d33aa0
[    8.516572] x29: ffffffc014d33aa0 x28: ffffff809deac800
[    8.521894] x27: ffffff809e23a5b0 x26: ffffff809e23a490
[    8.527214] x25: 0000000000000000 x24: ffffff809cf9f000
[    8.532535] x23: ffffffc011d13090 x22: 0000000000000000
[    8.537856] x21: 0000000000000000 x20: ffffff809cf9f0b0
[    8.543175] x19: ffffff809cf9f000 x18: 000000000000000a
[    8.548495] x17: 0000000000000000 x16: 0000000000000000
[    8.553816] x15: 00000000000718d7 x14: 0720072007200720
[    8.559138] x13: 0720072007200720 x12: 0720072007200720
[    8.564458] x11: 0720072007200720 x10: 0720072007200720
[    8.569777] x9 : 0720072007200720 x8 : 656c62617369642d
[    8.575098] x7 : 79646165726c6120 x6 : ffffffc011dc3630
[    8.580417] x5 : 0000000000000038 x4 : 0000000000000000
[    8.585737] x3 : 0000000000000000 x2 : 0000000000000000
[    8.591058] x1 : 73b2329426297100 x0 : 0000000000000000
[    8.596379] Call trace:
[    8.598832]  pci_disable_device+0x78/0xd0
[    8.602852]  pcie_port_device_remove+0x3c/0x48
[    8.607304]  pcie_portdrv_remove+0x5c/0x8c
[    8.611408]  pci_device_remove+0x98/0xe8
[    8.615341]  device_release_driver_internal+0xb0/0x188
[    8.620487]  device_release_driver+0x28/0x34
[    8.624765]  pci_stop_bus_device+0x40/0xa8
[    8.628867]  pci_stop_root_bus+0x58/0x64
[    8.632797]  brcm_pcie_remove+0x24/0x70
[    8.636640]  brcm_pcie_shutdown+0x20/0x2c
[    8.640655]  platform_drv_shutdown+0x2c/0x38
[    8.644934]  device_shutdown+0x16c/0x1e0
[    8.648865]  kernel_restart_prepare+0x44/0x50
[    8.653229]  kernel_restart+0x20/0x68
[    8.656896]  __do_sys_reboot+0x158/0x200
[    8.660816]  __arm64_sys_reboot+0x2c/0x38
[    8.664833]  el0_svc_common.constprop.2+0xe8/0x168
[    8.669631]  el0_svc_handler+0x34/0x80
[    8.673388]  el0_svc+0x8/0x1fc
[    8.676447] ---[ end trace 778d7966a5ef8213 ]---
[    8.694539] pci_bus 0001:01: busn_res: [bus 01] is released
[    8.700279] pci_bus 0001:00: busn_res: [bus 00-ff] is released
[    8.710206] reboot: Restarting system


> 
> It is ... unfortunate that there's such a variety of implementations
> here.  I don't believe these driver differences are all necessary
> consequences of hardware differences.

Yes, that is a bit unfortunate, Rob's idea to consolidate the
implementation sounds good and we can definitively test that.

> 
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> ---
>>  drivers/pci/controller/pcie-brcmstb.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
>> index d3af8d84f0d6..a1fe1a2ada48 100644
>> --- a/drivers/pci/controller/pcie-brcmstb.c
>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>> @@ -1340,6 +1340,15 @@ static int brcm_pcie_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +static void brcm_pcie_shutdown(struct platform_device *pdev)
>> +{
>> +	struct brcm_pcie *pcie = platform_get_drvdata(pdev);
>> +
>> +	if (pcie->has_err_report)
>> +		brcm_unregister_die_notifiers(pcie);
>> +	__brcm_pcie_remove(pcie);
>> +}
>> +
>>  static const struct of_device_id brcm_pcie_match[] = {
>>  	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
>>  	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
>> @@ -1460,6 +1469,7 @@ static const struct dev_pm_ops brcm_pcie_pm_ops = {
>>  static struct platform_driver brcm_pcie_driver = {
>>  	.probe = brcm_pcie_probe,
>>  	.remove = brcm_pcie_remove,
>> +	.shutdown = brcm_pcie_shutdown,
>>  	.driver = {
>>  		.name = "brcm-pcie",
>>  		.of_match_table = brcm_pcie_match,
>> -- 
>> 2.17.1
>>


-- 
Florian
