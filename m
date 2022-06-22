Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C565554362
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351684AbiFVGw2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 02:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351663AbiFVGw1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 02:52:27 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF95936174;
        Tue, 21 Jun 2022 23:52:26 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25M6qKKr112391;
        Wed, 22 Jun 2022 01:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655880740;
        bh=+bU4UxbIroXkrCXvNHPVJdir+BiBbXJYyClRaqsCF5Y=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Q227rkS+NosDcG7riC1o6YJpq/5lD6MaS+OuSLt92FpTjjaAg2UOsqTBg7Jk5FHDW
         tNrK/yVbCu5lGFBZXUukr5CRDFJTlN4/nWXcOUaSmIymYJN2EBRNK5sYeZJNFTgKZp
         EdsBBlas3uKhpYOaY033ZkikWCMmM2F7LJY9G/OM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25M6qKel087375
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jun 2022 01:52:20 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 22
 Jun 2022 01:52:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 22 Jun 2022 01:52:19 -0500
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25M6qGkF060228;
        Wed, 22 Jun 2022 01:52:17 -0500
Message-ID: <ec2ee06c-b83d-b1f6-8cb4-0a32bccb5132@ti.com>
Date:   Wed, 22 Jun 2022 12:22:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V1] PCI: endpoint: Register release() for EPC device
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <nkristam@nvidia.com>, <sagar.tv@gmail.com>
References: <20220622053705.3283-1-vidyas@nvidia.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20220622053705.3283-1-vidyas@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya Sagar,

On 22/06/22 11:07, Vidya Sagar wrote:
> Register a dummy release function to avoid the below spew
> when the driver is unbinded for an endpoint device.
> 
> root@tegra-ubuntu:/sys/bus/platform/drivers/tegra194-pcie# echo "141a0000.pcie-ep" > unbind
> [   55.802704] ------------[ cut here ]------------
> [   55.802737] Device '141a0000.pcie-ep' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
> [   55.802956] WARNING: CPU: 2 PID: 477 at /home/vidyas/y/mlt/kernel/drivers/base/core.c:2321 device_release+0x7c/0x90
> [   55.831544] Modules linked in:
> [   55.834781] CPU: 2 PID: 477 Comm: bash Not tainted 5.19.0-rc3-next-20220620-00001-ge53d3cc05d82 #17
> [   55.844078] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (DT)
> [   55.850675] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   55.857957] pc : device_release+0x7c/0x90
> [   55.862265] lr : device_release+0x7c/0x90
> [   55.866558] sp : ffff80000c24bab0
> [   55.869965] x29: ffff80000c24bab0 x28: ffff0000872a5700 x27: 0000000000000000
> [   55.877410] x26: 0000000000000000 x25: 0000000000000000 x24: ffff000080a946bc
> [   55.884840] x23: ffff000080a946c0 x22: 0000000000000000 x21: ffff000083194400
> [   55.892275] x20: ffff000082076000 x19: ffff00008203ec00 x18: ffffffffffffffff
> [   55.899720] x17: 6620656220747375 x16: 6d20646e61206e65 x15: 62207473756d2064
> [   55.907179] x14: 6e61206e656b6f72 x13: 6d20646e61206e65 x12: 6b6f726220736920
> [   55.914651] x11: 2e7473722e746365 x10: 6a626f6b2f697061 x9 : 2d65726f632f6e6f
> [   55.922132] x8 : ffff800009ff2e40 x7 : ffff80000c24b8b0 x6 : 00000000fffff1fc
> [   55.929587] x5 : ffff0003fdf4ba08 x4 : 00000000fffff1fc x3 : ffff8003f44f1000
> [   55.937033] x2 : ffff0000872a5700 x1 : 45c50f22e593f400 x0 : 0000000000000000
> [   55.944501] Call trace:
> [   55.947037]  device_release+0x7c/0x90
> [   55.950995]  kobject_put+0x90/0x108
> [   55.954797]  device_unregister+0x20/0x30
> [   55.958877]  pci_epc_destroy+0x20/0x38
> [   55.962908]  devm_pci_epc_release+0x10/0x18
> [   55.967406]  release_nodes+0x3c/0x68
> [   55.971121]  devres_release_all+0x8c/0xc8
> [   55.975409]  device_unbind_cleanup+0x14/0x60
> [   55.979951]  device_release_driver_internal+0x100/0x180
> [   55.985508]  device_driver_detach+0x14/0x20
> [   55.989968]  unbind_store+0xd8/0xf0
> [   55.993732]  drv_attr_store+0x20/0x30
> [   55.997639]  sysfs_kf_write+0x48/0x58
> [   56.001489]  kernfs_fop_write_iter+0x118/0x1a0
> [   56.006239]  new_sync_write+0xd0/0x190
> [   56.010159]  vfs_write+0x1bc/0x390
> [   56.013831]  ksys_write+0x64/0xf0
> [   56.017483]  __arm64_sys_write+0x14/0x20
> [   56.021567]  invoke_syscall+0x40/0xf8
> [   56.025516]  el0_svc_common.constprop.3+0x6c/0xf8
> [   56.030511]  do_el0_svc+0x28/0xc8
> [   56.033920]  el0_svc+0x1c/0x58
> [   56.036936]  el0t_64_sync_handler+0x94/0xb8
> [   56.041049]  el0t_64_sync+0x15c/0x160
> [   56.044652] ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

There's already a patch  posted to fix this.

https://lore.kernel.org/all/20220622025031.51812-1-yoshihiro.shimoda.uh@renesas.com/

Regards,
Kishon
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 3bc9273d0a08..ae403aa54e72 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -746,6 +746,11 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
>  }
>  EXPORT_SYMBOL_GPL(devm_pci_epc_destroy);
>  
> +static void pci_epc_nop_release(struct device *dev)
> +{
> +	dev_vdbg(dev, "%s\n", __func__);
> +}
> +
>  /**
>   * __pci_epc_create() - create a new endpoint controller (EPC) device
>   * @dev: device that is creating the new EPC
> @@ -779,6 +784,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  	device_initialize(&epc->dev);
>  	epc->dev.class = pci_epc_class;
>  	epc->dev.parent = dev;
> +	epc->dev.release = pci_epc_nop_release;
>  	epc->ops = ops;
>  
>  	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
