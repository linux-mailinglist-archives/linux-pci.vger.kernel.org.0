Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9CD5999D6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 12:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347755AbiHSKij (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348138AbiHSKih (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 06:38:37 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A334454A;
        Fri, 19 Aug 2022 03:38:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27JAcHLH107763;
        Fri, 19 Aug 2022 05:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660905497;
        bh=sCPsEmLmfCmKeH0IMvDi/S5U7HxScDsSXsTCZygnMKw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=FNG0K7Rjr1b99V0YnTgWtmuu2OyNtsbV6pYOzT+Eh8ogY2AW8rGqiI0g6YO0Gvr58
         Ydu0HtIMQDlUS7OEgND9jeFRrgWeEfcY1o7YQEMsyLdSQ1uXbgXzTTeQdc94iQfgoE
         SOfbjG5u70KlyPRIMwoZX/eJ8Y5G46FyjwhtbK0w=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27JAcHuQ117551
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Aug 2022 05:38:17 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 19
 Aug 2022 05:38:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 19 Aug 2022 05:38:17 -0500
Received: from [172.24.147.145] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27JAcDeK115702;
        Fri, 19 Aug 2022 05:38:14 -0500
Message-ID: <632f447c-fe1a-e6aa-2fda-73669964fc92@ti.com>
Date:   Fri, 19 Aug 2022 16:08:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] misc: pci_endpoint_test: Fix
 pci_endpoint_test_{copy,write,read}() panic
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Shunsuke Mie <mie@igel.co.jp>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20220816100617.90720-1-mie@igel.co.jp>
 <YvtxAN7E4nmZmL/X@kroah.com> <Yvuvpd9n59mp96p0@lpieralisi>
 <695ab9b3-8385-e8bd-0095-14b07de66b15@ti.com> <YvzNg5ROnxEApDgS@kroah.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <YvzNg5ROnxEApDgS@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Mani

On 17/08/22 16:44, Greg Kroah-Hartman wrote:
> On Wed, Aug 17, 2022 at 02:18:58PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On 16/08/22 20:24, Lorenzo Pieralisi wrote:
>>> On Tue, Aug 16, 2022 at 12:27:12PM +0200, Greg Kroah-Hartman wrote:
>>>> On Tue, Aug 16, 2022 at 07:06:17PM +0900, Shunsuke Mie wrote:
>>>>> Although dma_map_single() doesn't permit zero length mapping, the each
>>>>> test functions called the function without zero checking.
>>>>>
>>>>> A panic was reported on arm64:
>>>>>
>>>>> [   60.137988] ------------[ cut here ]------------
>>>>> [   60.142630] kernel BUG at kernel/dma/swiotlb.c:624!
>>>>> [   60.147508] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>>>>> [   60.152992] Modules linked in: dw_hdmi_cec crct10dif_ce simple_bridge rcar_fdp1 vsp1 rcar_vin videobuf2_vmalloc rcar_csi2 v4l
>>>>> 2_mem2mem videobuf2_dma_contig videobuf2_memops pci_endpoint_test videobuf2_v4l2 videobuf2_common rcar_fcp v4l2_fwnode v4l2_asyn
>>>>> c videodev mc gpio_bd9571mwv max9611 pwm_rcar ccree at24 authenc libdes phy_rcar_gen3_usb3 usb_dmac display_connector pwm_bl
>>>>> [   60.186252] CPU: 0 PID: 508 Comm: pcitest Not tainted 6.0.0-rc1rpci-dev+ #237
>>>>> [   60.193387] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
>>>>> [   60.201302] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>> [   60.208263] pc : swiotlb_tbl_map_single+0x2c0/0x590
>>>>> [   60.213149] lr : swiotlb_map+0x88/0x1f0
>>>>> [   60.216982] sp : ffff80000a883bc0
>>>>> [   60.220292] x29: ffff80000a883bc0 x28: 0000000000000000 x27: 0000000000000000
>>>>> [   60.227430] x26: 0000000000000000 x25: ffff0004c0da20d0 x24: ffff80000a1f77c0
>>>>> [   60.234567] x23: 0000000000000002 x22: 0001000040000010 x21: 000000007a000000
>>>>> [   60.241703] x20: 0000000000200000 x19: 0000000000000000 x18: 0000000000000000
>>>>> [   60.248840] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0006ff7b9180
>>>>> [   60.255977] x14: ffff0006ff7b9180 x13: 0000000000000000 x12: 0000000000000000
>>>>> [   60.263113] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>>>>> [   60.270249] x8 : 0001000000000010 x7 : ffff0004c6754b20 x6 : 0000000000000000
>>>>> [   60.277385] x5 : ffff0004c0da2090 x4 : 0000000000000000 x3 : 0000000000000001
>>>>> [   60.284521] x2 : 0000000040000000 x1 : 0000000000000000 x0 : 0000000040000010
>>>>> [   60.291658] Call trace:
>>>>> [   60.294100]  swiotlb_tbl_map_single+0x2c0/0x590
>>>>> [   60.298629]  swiotlb_map+0x88/0x1f0
>>>>> [   60.302115]  dma_map_page_attrs+0x188/0x230
>>>>> [   60.306299]  pci_endpoint_test_ioctl+0x5e4/0xd90 [pci_endpoint_test]
>>>>> [   60.312660]  __arm64_sys_ioctl+0xa8/0xf0
>>>>> [   60.316583]  invoke_syscall+0x44/0x108
>>>>> [   60.320334]  el0_svc_common.constprop.0+0xcc/0xf0
>>>>> [   60.325038]  do_el0_svc+0x2c/0xb8
>>>>> [   60.328351]  el0_svc+0x2c/0x88
>>>>> [   60.331406]  el0t_64_sync_handler+0xb8/0xc0
>>>>> [   60.335587]  el0t_64_sync+0x18c/0x190
>>>>> [   60.339251] Code: 52800013 d2e00414 35fff45c d503201f (d4210000)
>>>>> [   60.345344] ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> To fix it, this patch adds checkings the payload length if it is zero.
>>>>>
>>>>> Fixes: 343dc693f7b7 ("misc: pci_endpoint_test: Prevent some integer overflows")
>>>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>>>>> ---
>>>>>  drivers/misc/pci_endpoint_test.c | 6 +++---
>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>>>>> index 8f786a225dcf..d45426a73396 100644
>>>>> --- a/drivers/misc/pci_endpoint_test.c
>>>>> +++ b/drivers/misc/pci_endpoint_test.c
>>>>> @@ -364,7 +364,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
>>>>>  	}
>>>>>  
>>>>>  	size = param.size;
>>>>> -	if (size > SIZE_MAX - alignment)
>>>>> +	if (size > SIZE_MAX - alignment || !size)
>>>>>  		goto err;
>>>>
>>>> Can we test size first?  And do it in the ioctl handler in one place so
>>>> you don't have to add it everywhere?
>>>>
>>>> Or have a "validate all parameters" function that you do it in one
>>>> place?
>>>>
>>>> Also, all of these ioctl handlers are wrong, they are returning "0" to
>>>> userspace if they fail, which is not correct at all.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/pci/pcitest.c
>>> This is bad, thanks Greg for spotting it.
>>>
>>> @Kishon, we have to fix it asap, please let me know if you
>>> can post a patch promptly.
>>
>> The userspace tool (pcitest [1]) that calls these IOCTLS prints "NOT
>> OKAY" on 0 and "OKAY" for 1.
>>
>> I'll change to negative value for error and still keep '0' for data
>> mismatch error?
> 
> No, 0 as a return value from a system call means "success".  You can not
> redefine it to mean something else for a tiny single kernel driver,
> otherwise so much for consistency.
> 
> 0 is success, -ERROR_NUMBER is an error, please read the ioctl man page.

Thanks Greg!

Mani, Would you be able to post a patch fixing it? If not I'll post it
mid next week.

Regards,
Kishon
