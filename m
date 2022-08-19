Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5528599A26
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 12:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348206AbiHSKxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 06:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348191AbiHSKxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 06:53:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333F9E3976
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 03:53:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso7224659pjk.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=WTErJg7lyqkHsURYoeI0aP2aPTDnduHIB5TtvLZw7vA=;
        b=pJNbtYDufWER/TjKeZgxwECNMDIJLonwYuhG55vVwMIXeQ4dNvLrwerLx6vvRdTeI7
         WovCtd+/60qGyfNbX82ss+f6boa6xEDn7BkjHO6gttrjfJD5mkdgUbN93deaUD+DIA0b
         A/hg5arw9A3UmbcsQHnhgRh5tZp53eY0zwCB+vB2JlI1Exy1riDBrwPW+5W9k040aBUr
         4nJsP8x2uuTQiX/8XYMfM1BItUpjvGDu3APRDsQxzOcZ4ixMznqpmUOfxriIb1OTwW7/
         oGJCVCq0hq6FA9lqLd/xqBEQst4ZCHMN76Op0XDMzL7QGZGJ28fWueKsFcU6Lr+M2AM5
         Bx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=WTErJg7lyqkHsURYoeI0aP2aPTDnduHIB5TtvLZw7vA=;
        b=RVO7bDWLLbXm7cQT01Y0B5Arf1N+/hVAeG6MRGtdhk8rXIwb7Xc/eyiwHqU7tRhtB3
         pVhIEgpusMsQjpd7grecpQS2RUsFKDHAq5Vm6D0On60patsyR77jQUILVbwp3I4Ab6DR
         i4OGkhhkCPGEsoCBwuD6WrXi9oXGWyymppsdZaE//urnDyJi2l1fmn9c1VtgRovs1lF8
         wv3CGatIfB0v4zs9nng9jZI6T4EHBeh1H9FMQQEm4+15Df+r7Ry5B8/X6Uydy6/V1pVw
         hC9D8DdspYO16Pu2r/XyfdkSU8mvh8M5f2he7wIlj2xCZJCuHM9gswjNBUKVKocSGBYt
         NWkQ==
X-Gm-Message-State: ACgBeo2eEjA1vhSjmHWGj8HOwYY+L1haagQ+Eh9g3uj0MFYFZlQJ8foW
        VULl4ZHWBZIOhGNrTtxmRjvaP0Aae+gs
X-Google-Smtp-Source: AA6agR6wD+fyfgDnsnqk9XR4dUDLCOji5KOR1eIymM9GXERJLNBOTPfksjom+UylKQNVPf61xMjihw==
X-Received: by 2002:a17:902:ce84:b0:16f:1d69:ef7f with SMTP id f4-20020a170902ce8400b0016f1d69ef7fmr6770870plg.63.1660906383648;
        Fri, 19 Aug 2022 03:53:03 -0700 (PDT)
Received: from thinkpad ([117.217.188.127])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0052dce4edceesm3222560pfj.169.2022.08.19.03.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 03:53:03 -0700 (PDT)
Date:   Fri, 19 Aug 2022 16:22:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Shunsuke Mie <mie@igel.co.jp>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Fix
 pci_endpoint_test_{copy,write,read}() panic
Message-ID: <20220819105255.GD215264@thinkpad>
References: <20220816100617.90720-1-mie@igel.co.jp>
 <YvtxAN7E4nmZmL/X@kroah.com>
 <Yvuvpd9n59mp96p0@lpieralisi>
 <695ab9b3-8385-e8bd-0095-14b07de66b15@ti.com>
 <YvzNg5ROnxEApDgS@kroah.com>
 <632f447c-fe1a-e6aa-2fda-73669964fc92@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <632f447c-fe1a-e6aa-2fda-73669964fc92@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 04:08:13PM +0530, Kishon Vijay Abraham I wrote:
> +Mani
> 
> On 17/08/22 16:44, Greg Kroah-Hartman wrote:
> > On Wed, Aug 17, 2022 at 02:18:58PM +0530, Kishon Vijay Abraham I wrote:
> >> Hi Lorenzo,
> >>
> >> On 16/08/22 20:24, Lorenzo Pieralisi wrote:
> >>> On Tue, Aug 16, 2022 at 12:27:12PM +0200, Greg Kroah-Hartman wrote:
> >>>> On Tue, Aug 16, 2022 at 07:06:17PM +0900, Shunsuke Mie wrote:
> >>>>> Although dma_map_single() doesn't permit zero length mapping, the each
> >>>>> test functions called the function without zero checking.
> >>>>>
> >>>>> A panic was reported on arm64:
> >>>>>
> >>>>> [   60.137988] ------------[ cut here ]------------
> >>>>> [   60.142630] kernel BUG at kernel/dma/swiotlb.c:624!
> >>>>> [   60.147508] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> >>>>> [   60.152992] Modules linked in: dw_hdmi_cec crct10dif_ce simple_bridge rcar_fdp1 vsp1 rcar_vin videobuf2_vmalloc rcar_csi2 v4l
> >>>>> 2_mem2mem videobuf2_dma_contig videobuf2_memops pci_endpoint_test videobuf2_v4l2 videobuf2_common rcar_fcp v4l2_fwnode v4l2_asyn
> >>>>> c videodev mc gpio_bd9571mwv max9611 pwm_rcar ccree at24 authenc libdes phy_rcar_gen3_usb3 usb_dmac display_connector pwm_bl
> >>>>> [   60.186252] CPU: 0 PID: 508 Comm: pcitest Not tainted 6.0.0-rc1rpci-dev+ #237
> >>>>> [   60.193387] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
> >>>>> [   60.201302] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >>>>> [   60.208263] pc : swiotlb_tbl_map_single+0x2c0/0x590
> >>>>> [   60.213149] lr : swiotlb_map+0x88/0x1f0
> >>>>> [   60.216982] sp : ffff80000a883bc0
> >>>>> [   60.220292] x29: ffff80000a883bc0 x28: 0000000000000000 x27: 0000000000000000
> >>>>> [   60.227430] x26: 0000000000000000 x25: ffff0004c0da20d0 x24: ffff80000a1f77c0
> >>>>> [   60.234567] x23: 0000000000000002 x22: 0001000040000010 x21: 000000007a000000
> >>>>> [   60.241703] x20: 0000000000200000 x19: 0000000000000000 x18: 0000000000000000
> >>>>> [   60.248840] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0006ff7b9180
> >>>>> [   60.255977] x14: ffff0006ff7b9180 x13: 0000000000000000 x12: 0000000000000000
> >>>>> [   60.263113] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> >>>>> [   60.270249] x8 : 0001000000000010 x7 : ffff0004c6754b20 x6 : 0000000000000000
> >>>>> [   60.277385] x5 : ffff0004c0da2090 x4 : 0000000000000000 x3 : 0000000000000001
> >>>>> [   60.284521] x2 : 0000000040000000 x1 : 0000000000000000 x0 : 0000000040000010
> >>>>> [   60.291658] Call trace:
> >>>>> [   60.294100]  swiotlb_tbl_map_single+0x2c0/0x590
> >>>>> [   60.298629]  swiotlb_map+0x88/0x1f0
> >>>>> [   60.302115]  dma_map_page_attrs+0x188/0x230
> >>>>> [   60.306299]  pci_endpoint_test_ioctl+0x5e4/0xd90 [pci_endpoint_test]
> >>>>> [   60.312660]  __arm64_sys_ioctl+0xa8/0xf0
> >>>>> [   60.316583]  invoke_syscall+0x44/0x108
> >>>>> [   60.320334]  el0_svc_common.constprop.0+0xcc/0xf0
> >>>>> [   60.325038]  do_el0_svc+0x2c/0xb8
> >>>>> [   60.328351]  el0_svc+0x2c/0x88
> >>>>> [   60.331406]  el0t_64_sync_handler+0xb8/0xc0
> >>>>> [   60.335587]  el0t_64_sync+0x18c/0x190
> >>>>> [   60.339251] Code: 52800013 d2e00414 35fff45c d503201f (d4210000)
> >>>>> [   60.345344] ---[ end trace 0000000000000000 ]---
> >>>>>
> >>>>> To fix it, this patch adds checkings the payload length if it is zero.
> >>>>>
> >>>>> Fixes: 343dc693f7b7 ("misc: pci_endpoint_test: Prevent some integer overflows")
> >>>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> >>>>> ---
> >>>>>  drivers/misc/pci_endpoint_test.c | 6 +++---
> >>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> >>>>> index 8f786a225dcf..d45426a73396 100644
> >>>>> --- a/drivers/misc/pci_endpoint_test.c
> >>>>> +++ b/drivers/misc/pci_endpoint_test.c
> >>>>> @@ -364,7 +364,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
> >>>>>  	}
> >>>>>  
> >>>>>  	size = param.size;
> >>>>> -	if (size > SIZE_MAX - alignment)
> >>>>> +	if (size > SIZE_MAX - alignment || !size)
> >>>>>  		goto err;
> >>>>
> >>>> Can we test size first?  And do it in the ioctl handler in one place so
> >>>> you don't have to add it everywhere?
> >>>>
> >>>> Or have a "validate all parameters" function that you do it in one
> >>>> place?
> >>>>
> >>>> Also, all of these ioctl handlers are wrong, they are returning "0" to
> >>>> userspace if they fail, which is not correct at all.
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/pci/pcitest.c
> >>> This is bad, thanks Greg for spotting it.
> >>>
> >>> @Kishon, we have to fix it asap, please let me know if you
> >>> can post a patch promptly.
> >>
> >> The userspace tool (pcitest [1]) that calls these IOCTLS prints "NOT
> >> OKAY" on 0 and "OKAY" for 1.
> >>
> >> I'll change to negative value for error and still keep '0' for data
> >> mismatch error?
> > 
> > No, 0 as a return value from a system call means "success".  You can not
> > redefine it to mean something else for a tiny single kernel driver,
> > otherwise so much for consistency.
> > 
> > 0 is success, -ERROR_NUMBER is an error, please read the ioctl man page.
> 
> Thanks Greg!
> 
> Mani, Would you be able to post a patch fixing it? If not I'll post it
> mid next week.
> 

Will do!

Thanks,
Mani

> Regards,
> Kishon

-- 
மணிவண்ணன் சதாசிவம்
