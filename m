Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14883614A0C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 12:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKAL4l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 07:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKAL4k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 07:56:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266B3C43;
        Tue,  1 Nov 2022 04:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA2D7B81C9C;
        Tue,  1 Nov 2022 11:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81EBC433C1;
        Tue,  1 Nov 2022 11:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667303797;
        bh=3Gbw2UZZJhp39VIc/j5rzxNESBVTn6BHioH52Hr/85s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0X8TrGomHpyhbg89JghPX9JWhpRs2+olb67gQK12Z9tmwl3FzmWIUaOio3TNtQKx
         /2mJwBcfPwfzrUOVc2LruqdvMTkWax95l4sx/NycJo2uwl03tGOzoXgnJs1h0pwLvI
         mC8iA3tJmpC3ph+OYzHwvJEQG/f+Jh6tXPfq0TG86PkwujL6j6aqHHEo4Ne1vKx5Vl
         gOVKUJQ5HOShc6sPW3e0V7zQ9ZPKT44rGgRxngWB8GRj76jh0cdUOZk8w58JwuDB/V
         4vT13cuJiDSnhrehI1FPHLFFaANgIsGKHmltnIIpfz/x3x9glwQlfUB8Iuleb/p6cp
         F0zx+eMQkiJlg==
Date:   Tue, 1 Nov 2022 17:26:21 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
        helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: Re: [PATCH v14 2/7] PCI: endpoint: pci-epf-vntb: Fix indentation of
 the struct epf_ntb_ctrl
Message-ID: <20221101115621.GF54667@thinkpad>
References: <20221028155703.318928-1-Frank.Li@nxp.com>
 <20221028155703.318928-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221028155703.318928-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 28, 2022 at 11:56:58AM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
> Indentation of the struct epf_ntb_ctrl align with other struct
> 

"Align the indentation of struct epf_ntb_ctrl with other structs in the driver"

> Signed-off-by: Frank Li <frank.li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 28 +++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index c0115bcb3b5e..1863006cc36c 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -99,20 +99,20 @@ enum epf_ntb_bar {
>   *       NTB Driver               NTB Driver
>   */
>  struct epf_ntb_ctrl {
> -	u32     command;
> -	u32     argument;
> -	u16     command_status;
> -	u16     link_status;
> -	u32     topology;
> -	u64     addr;
> -	u64     size;
> -	u32     num_mws;
> -	u32	reserved;
> -	u32     spad_offset;
> -	u32     spad_count;
> -	u32	db_entry_size;
> -	u32     db_data[MAX_DB_COUNT];
> -	u32     db_offset[MAX_DB_COUNT];
> +	u32 command;
> +	u32 argument;
> +	u16 command_status;
> +	u16 link_status;
> +	u32 topology;
> +	u64 addr;
> +	u64 size;
> +	u32 num_mws;
> +	u32 reserved;
> +	u32 spad_offset;
> +	u32 spad_count;
> +	u32 db_entry_size;
> +	u32 db_data[MAX_DB_COUNT];
> +	u32 db_offset[MAX_DB_COUNT];

General question: Don't we need to take care of endianess here?

Thanks,
Mani

>  } __packed;
>  
>  struct epf_ntb {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
