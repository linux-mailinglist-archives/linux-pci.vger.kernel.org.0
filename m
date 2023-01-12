Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BEE6686C7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 23:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbjALWVw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 17:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240218AbjALWVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 17:21:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8873DBE9;
        Thu, 12 Jan 2023 14:13:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4BF3DCE1FB1;
        Thu, 12 Jan 2023 22:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B72C433EF;
        Thu, 12 Jan 2023 22:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673561598;
        bh=IyvF0BxsMmhma6RD34MZNc77IvFpsK+etkEmiGHVLnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kVwVQqMiR9G52IokCOKWkEbQwIS7Asg0wyGtvtYj4f+cxfudAAG6QOohjCOpXVPN8
         VhQS7Q/zmDboFHdNoRpb5rpH6RLqqOY9CgDqCv1GMdxf2Lfz6cCIbX5IC1tz6hK4Np
         nSEILuDZ/vU+9BhZE6H0BIwXl8rlxOyUb4L7ThTjhyqz2GRhJPQCVCqVrnXcjVwjOa
         51sZSJY1J2jEW8R1m0NtrwX/hEFto+XYw0TAvXflfYs2+Uz/hJxTTtvBKS3tfSuSkD
         xRIihpdYVAAKR2VkTfyfJjAMGUmYdjNug2/IkgDPtKv3iFzH0L2ugiWu3PH1XWzinw
         1aC0ekzyzLlRA==
Date:   Thu, 12 Jan 2023 16:13:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiantao Zhang <water.zhangjiantao@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhangjianrong5@huawei.com,
        suzhuangluan@hisilicon.com, caiyadong@huawei.com,
        guhengsheng@hisilicon.com, songxiaowei@hisilicon.com
Subject: Re: [PATCH] PCI: Exit restore process when device is still powerdown
Message-ID: <20230112221316.GA1797087@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222124104.69607-1-water.zhangjiantao@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 22, 2022 at 12:41:04PM +0000, Jiantao Zhang wrote:
> We get this stack when the rp doesn't power up in resume noirq:

s/rp/Root Port/

"resume noirq" seems to refer to a function, so please mention the
exact function name.

>     dump_backtrace.cfi_jt+0x0/0x4
>     dump_stack_lvl+0xb4/0x10c
>     show_regs_before_dump_stack+0x1c/0x30
>     arm64_serror_panic+0x110/0x1a8
>     do_serror+0x16c/0x1cc
>     el1_error+0x8c/0x10c
>     do_raw_spin_unlock+0x74/0xdc
>     pci_bus_read_config_word+0xdc/0x1dc
>     pci_restore_msi_state+0x2f4/0x36c
>     pci_restore_state+0x13f0/0x1444
>     pci_pm_resume_noirq+0x158/0x318
>     dpm_run_callback+0x178/0x5e8
>     device_resume_noirq+0x250/0x264
>     async_resume_noirq+0x20/0xf8
>     async_run_entry_fn+0xfc/0x364
>     process_one_work+0x37c/0x7f4
>     worker_thread+0x3e8/0x754
>     kthread+0x168/0x204
>     ret_from_fork+0x10/0x18
> The ep device uses msix, the restore process will write bar space
> in __pci_msix_desc_mask_irq, which will result in accessing the
> powerdown area when the rp doesn't power on.

s/ep/endpoint/
s/msix/MSI-X/ to match spec usage
s/bar/BAR/
Add "()" after function names, e.g., __pci_msix_desc_mask_irq()
s/rp/Root Port/

> It makes sense we should do nothing when the device is still powerdown.
> 
> Signed-off-by: Jianrong Zhang <zhangjianrong5@huawei.com>
> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fba95486caaf..279f6e8c5a00 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1764,7 +1764,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
>   */
>  void pci_restore_state(struct pci_dev *dev)
>  {
> -	if (!dev->state_saved)
> +	if (!dev->state_saved || dev->current_state == PCI_UNKNOWN)
>  		return;

This doesn't seem right to me because it seems like we're covering up
a problem elsewhere.

If we need access to the endpoint to restore state, shouldn't we
ensure that the endpoint is powered up before we try to access it?

We depend on the state being restored, so if we skip the restore here,
where *will* it happen?

Bjorn
