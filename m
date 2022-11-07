Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505AF620112
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiKGVZT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiKGVY7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:24:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C291C6166;
        Mon,  7 Nov 2022 13:24:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 686416133B;
        Mon,  7 Nov 2022 21:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB23C433D7;
        Mon,  7 Nov 2022 21:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667856290;
        bh=aDYUDBRKYJhW0QdBRWePo9Vh6t2wi/BTZhR4jWzocYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=spPPT0k0QQM4+Gf9GGqT0QYTSyWgX6KyJpOZfvUmJwv3p3cj3ZSXGANP/qVLZzcqc
         2NqSl8qqG377+wxiJo8aC4++dj2S1vI3MMgQ1nGdRRHvCVxiyq/NWq7AxjoD2hISTa
         COQ74f/07+7CIZVXH1nQfINb0lV/i/GdrDyWB9QH/ZJqssNijnXEJTytG1gWAFFFPS
         HlaGGSOnciOy6LKSu0gwvefAPUdBWA38VFkqZuW25BCuCltLBzAi9gl/Q+vx+tT5qu
         XMTFE/W20LhYE8PQBwYvTVozU2o3lDmLi1+jKifTudn59hhYv6xHjahU8z5IAx6542
         ZLga3sXGRGU4Q==
Date:   Mon, 7 Nov 2022 15:24:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yipeng Zou <zouyipeng@huawei.com>
Cc:     rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        tn@semihalf.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: use ACPI Method Name macro directly
Message-ID: <20221107212448.GA421592@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104032430.186424-1-zouyipeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 04, 2022 at 11:24:30AM +0800, Yipeng Zou wrote:
> It's convenience to find all at once, use METHOD_NAME__UID as path string.
> 
> Fixes: 169de969c018 ("PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform")
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>

Applied to pci/misc for v6.2, thanks!

I dropped the "Fixes:" tag because there's no reason to backport this
to any older kernels.

I assume you're doing the same for other instances?

  drivers/acpi/acpi_processor.c:          status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
  drivers/acpi/dock.c:                                    "_UID", NULL, &lbuf);
  drivers/acpi/processor_pdc.c:           status = acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
  drivers/perf/hisilicon/hisi_uncore_hha_pmu.c:                                          "_UID", NULL, &id);
  drivers/xen/xen-acpi-processor.c:               status = acpi_evaluate_integer(handle, "_UID", NULL, &tmp);

> ---
>  drivers/pci/pci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a46fec776ad7..068d6745bf98 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -67,7 +67,7 @@ static acpi_status acpi_match_rc(acpi_handle handle, u32 lvl, void *context,
>  	unsigned long long uid;
>  	acpi_status status;
>  
> -	status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
> +	status = acpi_evaluate_integer(handle, METHOD_NAME__UID, NULL, &uid);
>  	if (ACPI_FAILURE(status) || uid != *segment)
>  		return AE_CTRL_DEPTH;
>  
> -- 
> 2.17.1
> 
