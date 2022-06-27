Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C789C55C52A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiF0T5R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 15:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbiF0T5Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 15:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398AD1ADBE;
        Mon, 27 Jun 2022 12:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA516616C0;
        Mon, 27 Jun 2022 19:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0822BC34115;
        Mon, 27 Jun 2022 19:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656359834;
        bh=78sDUKZ2VOrx+wfjwEhAXMfNb3LhLyH+qU9P0nCrDEw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=G+e38rmaNU2+a2FAz/5SH7tIn5QnWfzk1Ey3zf+n55m1yWCIk2NJ8yX+mcp1YTRa6
         mxjb99zbyaUiQM+tDo4EZa4Ll7OnCapwIjrD8cr8CKhf2RIp/e8pdPLLAmy4n4Kkwc
         B08UkqUZf66lqsgJMPznsA8RhmUlCfASP9RihfprQKDlfsLusWbB8e8vjlx+cMRK3n
         fbCCn/G0Dra4LskaoqTPELJc1pBbOycoPk3Xhn2utgq2AuyKGuM9MXMbsKE0fT1WnB
         P43VM4VU7C2iHw5dqkSUHU1iPRqNKAWXRTSOXWvXSEAwgTM8PLcVUTj0Oa6YUsCwQK
         Xd3sv04H+/0VA==
Date:   Mon, 27 Jun 2022 14:57:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, jdmason@kudzu.us, Frank.Li@nxp.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: endpoint: Fix Kconfig dependency
Message-ID: <20220627195712.GA1772707@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624011911.164146-1-renzhijie2@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 09:19:11AM +0800, Ren Zhijie wrote:
> If CONFIG_NTB is not set and CONFIG_PCI_EPF_VNTB is y.
> 
> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:
> 
> drivers/pci/endpoint/functions/pci-epf-vntb.o: In function `epf_ntb_cmd_handler':
> pci-epf-vntb.c:(.text+0x95e): undefined reference to `ntb_db_event'
> pci-epf-vntb.c:(.text+0xa1f): undefined reference to `ntb_link_event'
> pci-epf-vntb.c:(.text+0xa42): undefined reference to `ntb_link_event'
> drivers/pci/endpoint/functions/pci-epf-vntb.o: In function `pci_vntb_probe':
> pci-epf-vntb.c:(.text+0x1250): undefined reference to `ntb_register_device'
> 
> The functions ntb_*() are defined in drivers/ntb/core.c, which need CONFIG_NTB setting y to be build-in.
> To fix this build error, add depends on NTB.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: ff32fac00d97("NTB: EPF: support NTB transfer between PCI RC and EP connection")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> Acked-by: Frank Li <frank.li@nxp.com>

Am I missing something? 

  02:54:01 ~/linux (next)$ git checkout -b wip/ren-endpoint-ntb v5.19-rc1
  Switched to a new branch 'wip/ren-endpoint-ntb'
  02:54:23 ~/linux (wip/ren-endpoint-ntb)$ b4 am -om/ https://lore.kernel.org/r/20220624011911.164146-1-renzhijie2@huawei.com
  Looking up https://lore.kernel.org/r/20220624011911.164146-1-renzhijie2%40huawei.com
  Analyzing 1 messages in the thread
  Checking attestation on all messages, may take a moment...
  ---
    [PATCH] PCI: endpoint: Fix Kconfig dependency
  ---
  Total patches: 1
  ---
   Link: https://lore.kernel.org/r/20220624011911.164146-1-renzhijie2@huawei.com
   Base: not specified
	 git am m/20220624_renzhijie2_pci_endpoint_fix_kconfig_dependency.mbx
  02:54:47 ~/linux (wip/ren-endpoint-ntb)$ git am m/20220624_renzhijie2_pci_endpoint_fix_kconfig_dependency.mbx
  Applying: PCI: endpoint: Fix Kconfig dependency
  error: patch failed: drivers/pci/endpoint/functions/Kconfig:29
  error: drivers/pci/endpoint/functions/Kconfig: patch does not apply
  Patch failed at 0001 PCI: endpoint: Fix Kconfig dependency
  hint: Use 'git am --show-current-patch' to see the failed patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".

Obviously I could fix this manually, but if there's something wrong
with your patch posting process, we should fix it.

> ---
> v2: Fix some commit message errors
> ---
>  drivers/pci/endpoint/functions/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> index 362555b024e8..9beee4f0f4ee 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -29,6 +29,7 @@ config PCI_EPF_NTB
>  config PCI_EPF_VNTB
>          tristate "PCI Endpoint NTB driver"
>          depends on PCI_ENDPOINT
> +        depends on NTB
>          select CONFIGFS_FS
>          help
>            Select this configuration option to enable the Non-Transparent
> -- 
> 2.17.1
> 
