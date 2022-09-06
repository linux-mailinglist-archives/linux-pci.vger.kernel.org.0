Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6215AE618
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 12:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiIFK7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 06:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiIFK7R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 06:59:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B91B73929;
        Tue,  6 Sep 2022 03:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 158C9614AD;
        Tue,  6 Sep 2022 10:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA64C433D7;
        Tue,  6 Sep 2022 10:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662461955;
        bh=Y6ysaDQ8FK3MaBAYuWSY6YK+9wlf0Ci4KR8fqnRqWj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7KISYojHZxYAlQqAeSY0HAdRMg/++JusOJ6DEHdXxQK5NDMXNZP3bU8sSO5t1CqH
         2PMxn2DTMOj9QMEkB0mLOo+fA+cNBjRSx9wz1FLt/oWMkpCoCp+9ZfoaxZ6bp6j/Vq
         bRPJfRaUhxp3LrsQ+TEMDNEKptZgALrMpqXrnxwU=
Date:   Tue, 6 Sep 2022 12:59:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] misc: pci_endpoint_test: Fix
 pci_endpoint_test_{copy,write,read}() panic
Message-ID: <YxcoAKrZzL1YEqwf@kroah.com>
References: <20220906101555.106033-1-mie@igel.co.jp>
 <20220906101555.106033-2-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906101555.106033-2-mie@igel.co.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 07:15:55PM +0900, Shunsuke Mie wrote:
> The dma_map_single() doesn't permit zero length mapping. It causes a follow
> panic.
> 
> A panic was reported on arm64:
> 
> [   60.137988] ------------[ cut here ]------------
> [   60.142630] kernel BUG at kernel/dma/swiotlb.c:624!
> [   60.147508] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [   60.152992] Modules linked in: dw_hdmi_cec crct10dif_ce simple_bridge rcar_fdp1 vsp1 rcar_vin videobuf2_vmalloc rcar_csi2 v4l
> 2_mem2mem videobuf2_dma_contig videobuf2_memops pci_endpoint_test videobuf2_v4l2 videobuf2_common rcar_fcp v4l2_fwnode v4l2_asyn
> c videodev mc gpio_bd9571mwv max9611 pwm_rcar ccree at24 authenc libdes phy_rcar_gen3_usb3 usb_dmac display_connector pwm_bl
> [   60.186252] CPU: 0 PID: 508 Comm: pcitest Not tainted 6.0.0-rc1rpci-dev+ #237
> [   60.193387] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
> [   60.201302] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   60.208263] pc : swiotlb_tbl_map_single+0x2c0/0x590
> [   60.213149] lr : swiotlb_map+0x88/0x1f0
> [   60.216982] sp : ffff80000a883bc0
> [   60.220292] x29: ffff80000a883bc0 x28: 0000000000000000 x27: 0000000000000000
> [   60.227430] x26: 0000000000000000 x25: ffff0004c0da20d0 x24: ffff80000a1f77c0
> [   60.234567] x23: 0000000000000002 x22: 0001000040000010 x21: 000000007a000000
> [   60.241703] x20: 0000000000200000 x19: 0000000000000000 x18: 0000000000000000
> [   60.248840] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0006ff7b9180
> [   60.255977] x14: ffff0006ff7b9180 x13: 0000000000000000 x12: 0000000000000000
> [   60.263113] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> [   60.270249] x8 : 0001000000000010 x7 : ffff0004c6754b20 x6 : 0000000000000000
> [   60.277385] x5 : ffff0004c0da2090 x4 : 0000000000000000 x3 : 0000000000000001
> [   60.284521] x2 : 0000000040000000 x1 : 0000000000000000 x0 : 0000000040000010
> [   60.291658] Call trace:
> [   60.294100]  swiotlb_tbl_map_single+0x2c0/0x590
> [   60.298629]  swiotlb_map+0x88/0x1f0
> [   60.302115]  dma_map_page_attrs+0x188/0x230
> [   60.306299]  pci_endpoint_test_ioctl+0x5e4/0xd90 [pci_endpoint_test]
> [   60.312660]  __arm64_sys_ioctl+0xa8/0xf0
> [   60.316583]  invoke_syscall+0x44/0x108
> [   60.320334]  el0_svc_common.constprop.0+0xcc/0xf0
> [   60.325038]  do_el0_svc+0x2c/0xb8
> [   60.328351]  el0_svc+0x2c/0x88
> [   60.331406]  el0t_64_sync_handler+0xb8/0xc0
> [   60.335587]  el0t_64_sync+0x18c/0x190
> [   60.339251] Code: 52800013 d2e00414 35fff45c d503201f (d4210000)
> [   60.345344] ---[ end trace 0000000000000000 ]---
> 
> To fix it, this patch adds a checking the payload length if it is zero.
> 
> Fixes: 343dc693f7b7 ("misc: pci_endpoint_test: Prevent some integer overflows")
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
> Changes in v2:
> * Move a checking code to an introduced function in previous patch
> ---
> ---
>  drivers/misc/pci_endpoint_test.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3bd9f135cdac..a7193bf6a49f 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -335,6 +335,11 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
>  static int pci_endpoint_test_validate_xfer_params(struct device *dev,
>  		struct pci_endpoint_test_xfer_param *param, size_t alignment)
>  {
> +	if (!param->size) {
> +		dev_err(dev, "Data size is zero\n");

Again, do not allow userspace to spam the kernel log.

thanks,

greg k-h
