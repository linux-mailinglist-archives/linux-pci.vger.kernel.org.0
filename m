Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB5E659BAD
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 20:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiL3TiP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 14:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiL3TiN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 14:38:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D0EB853;
        Fri, 30 Dec 2022 11:38:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC432B81D5E;
        Fri, 30 Dec 2022 19:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2239C433D2;
        Fri, 30 Dec 2022 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672429090;
        bh=+pWVJzShzMwkJ+U8dDoynTuuMtW1VClxWCtY5/oL2f0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HvXo8GnduZ4gPN1V71qknRKPmb5JOV4O7hizaRrs/8NMe2wChGbSi6PvB2vsiZiWJ
         OmWZfvUXwTf1u1ozAgrye+wa3r7OGhYG9daAF7a4BtYwvMLyH9O7LptTms76qy8mq1
         rwN/4r7FXAfCeCQ746HvyJWT2Ws9L6jmr31GJXnqqUs7BH98Cv+pTQ+lXi7kuBSmDC
         yRp9R22JIvz7B1gR7G57IrNKd69EECRUUy3p5d6ZjiZcEnW/fHO5UMofpGZ9GP+I2L
         9f+aRb8vB8ZwggVmS1iZOHLj//dNyS6W2IJmCnBHmvwkssfkJ3mVmeyVQzMPxUGSz1
         kwCDpmizyx44g==
Date:   Fri, 30 Dec 2022 13:38:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, lpieralisi@kernel.org, kw@linux.com,
        mani@kernel.org, kishon@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-vntb: fix doc warning in
 pci-epf-vntb.c
Message-ID: <20221230193807.GA698469@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222034324.3294639-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yang,

On Thu, Dec 22, 2022 at 11:43:24AM +0800, Yang Yingliang wrote:
> Fix the following make W=1 warning:
> 
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:645: warning: Function parameter or member 'num_mws' not described in 'epf_ntb_mw_bar_clear'

No big deal here, but I try to make subject lines and commit logs a
little more specific.  "Fix doc warning" doesn't give any real
information, but something like "Add num_mws kernel-doc" would.

No need to repeat "pci-epf-vntb" in the subject; one mention is
enough.

> Fixes: 8e4bfbe644a6 ("PCI: endpoint: pci-epf-vntb: fix error handle in epf_ntb_mw_bar_init()")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v1 -> v2:
>   Based on latest commit.

What is "latest commit"?  A SHA1 would make this unambiguous.

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 04698e7995a5..37134aead77c 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -594,6 +594,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>  /**
>   * epf_ntb_mw_bar_init() - Configure Memory window BARs
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
> + * @num_mws: the number of Memory window BARs that to be cleared

This patch happens to apply cleanly on 1b929c02afd3 ("Linux 6.2-rc1"),
but I think the hunk gets applied in the wrong place.

8e4bfbe644a6 ("PCI: endpoint: pci-epf-vntb: fix error handle in
epf_ntb_mw_bar_init()") added a "num_mws" parameter to
epf_ntb_mw_bar_clear() but failed to add kernel-doc for num_mws.

This patch adds kernel-doc for num_mws on *epf_ntb_mw_bar_init()*,
which doesn't have a num_mws parameter, so after applying it, I see
*two* kernel-doc warnings:

  $ make W=1 drivers/pci/endpoint/functions/pci-epf-vntb.o
  drivers/pci/endpoint/functions/pci-epf-vntb.c:602: warning: Excess function parameter 'num_mws' description in 'epf_ntb_mw_bar_init'
  drivers/pci/endpoint/functions/pci-epf-vntb.c:658: warning: Function parameter or member 'num_mws' not described in 'epf_ntb_mw_bar_clear'

>   * Returns: Zero for success, or an error code in case of failure
>   */
> -- 
> 2.25.1
> 
