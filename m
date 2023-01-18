Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D40672923
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 21:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjARUPs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 15:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjARUPr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 15:15:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8295D7E4;
        Wed, 18 Jan 2023 12:15:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20827B81F01;
        Wed, 18 Jan 2023 20:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508D6C433EF;
        Wed, 18 Jan 2023 20:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674072943;
        bh=J4WWSguMR9lTheJDbGf665NqLi4YZhutquYw9Q/2MBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fKdR5/WNd7sHsQqLKMilgWYTwWn9dblHmb2+Ibnk12p4TVHXb26JhLviMWswH9toD
         j/Kz4/IkT9CRJ/+UJfp46aznGs2Sj19EOqJEnv8XNWnSev/NZXb8CWFX+40+bmN9oM
         dFhUbdwgXvwwyzB0wVtKVkbr8zXKclSeihSjD0z4SapQ0JYenshV9If33jZVEDinK6
         ToNdxR5tsdDqH7oKDP16SlLxetzh8EZ07mBsYhm3qTXVFmdlsIyzIfTLexLSNHGNEb
         EB/vilqNSVeVNIFb6DjilEJ38D44g+EwrRVXQIF1sdRZ3OWKpyeXbo+tbMv+sWC9RD
         T0GCy4GzsgLUw==
Date:   Wed, 18 Jan 2023 14:15:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, lpieralisi@kernel.org, kw@linux.com,
        mani@kernel.org, kishon@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: add kernel-doc for num_mws
 on epf_ntb_mw_bar_clear()
Message-ID: <20230118201541.GA254794@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103024907.293853-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 03, 2023 at 10:49:07AM +0800, Yang Yingliang wrote:
> Commit 8e4bfbe644a6 ("PCI: endpoint: pci-epf-vntb: fix error handle
> in epf_ntb_mw_bar_init()") added a "num_mws" parameter to
> epf_ntb_mw_bar_clear() but failed to add kernel-doc for num_mws.
> 
> This patch adds kernel-doc for num_mws on epf_ntb_mw_bar_clear().
> 
> Fixes: 8e4bfbe644a6 ("PCI: endpoint: pci-epf-vntb: fix error handle in epf_ntb_mw_bar_init()")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied to pci/misc for v6.3, thanks!

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 04698e7995a5..b7c7a8af99f4 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -652,6 +652,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  /**
>   * epf_ntb_mw_bar_clear() - Clear Memory window BARs
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
> + * @num_mws: the number of Memory window BARs that to be cleared
>   */
>  static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>  {
> -- 
> 2.25.1
> 
