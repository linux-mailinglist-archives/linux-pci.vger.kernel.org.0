Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF23477FCF7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349139AbjHQR0D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 13:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353972AbjHQRZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 13:25:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83DA30E1;
        Thu, 17 Aug 2023 10:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7667561517;
        Thu, 17 Aug 2023 17:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A108DC433C7;
        Thu, 17 Aug 2023 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692293120;
        bh=fF6dQrfAN503mGBZ/KNEwnJeKClC1jwkmKFSCRmMNts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b5cZxS9lhR7U9asIjTR6t6zO4/CnDpn8SSQyZdcj5sgfE1y88Kfm3xZllgBW8kypY
         SyTe67pCojaO2Dp+kg31FfZFFFcd0EPCIEETfp7VnS1jtUIFLVeFx90KQ4amxXTQzx
         5T6BKIa6CTFKU1WfXgrYWR5aL+jH/dzenkEtHIkT9JbB9sipOtKN+dAVBRNtGbeNvK
         OqR8KqXwmr69RjNvE8zDZGflKD2ywNnGVIAHYY2UXm9S7dRaxcRctNEEXQYVegCtB7
         OV5C2wu/apMRql56Uo/QW8BiDfLDTADtki0ZRSLkus3EHqtkS8/PJoVOplhjNyvwVR
         KAvaAYoQFEu4w==
Date:   Thu, 17 Aug 2023 12:25:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        linux-pci@vger.kernel.org, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb_hw_switchtec: Fix shift-out-of-bounds in
 switchtec_ntb_mw_set_trans
Message-ID: <20230817172516.GA321366@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816083305.1426718-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 16, 2023 at 04:33:05PM +0800, Yajun Deng wrote:
> There is a kernel API ntb_mw_clear_trans() would pass 0 to both addr and
> size. This would make xlate_pos negative.
> 
> [   23.734156] switchtec switchtec0: MW 0: part 0 addr 0x0000000000000000 size 0x0000000000000000
> [   23.734158] ================================================================================
> [   23.734172] UBSAN: shift-out-of-bounds in drivers/ntb/hw/mscc/ntb_hw_switchtec.c:293:7
> [   23.734418] shift exponent -1 is negative
> 
> Ensuring xlate_pos is a positive or zero before BIT.

I assume Kurt or Logan will apply this and no need to repost for this,
but if you do repost for some reason, the timestamps and separator
lines above are clutter and don't contribute to understanding the
problem.

Also s/Ensuring/Ensure/

> Fixes: 1e2fd202f859 ("ntb_hw_switchtec: Check for alignment of the buffer in mw_set_trans()")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index d6bbcc7b5b90..21468d4fef64 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -288,7 +288,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>  	if (size != 0 && xlate_pos < 12)
>  		return -EINVAL;
>  
> -	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
> +	if (xlate_pos >= 0 && !IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
>  		/*
>  		 * In certain circumstances we can get a buffer that is
>  		 * not aligned to its size. (Most of the time
> -- 
> 2.25.1
> 
