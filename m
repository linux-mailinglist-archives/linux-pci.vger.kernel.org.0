Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F122564BBE4
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 19:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiLMS1h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 13:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiLMS1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 13:27:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD991116C;
        Tue, 13 Dec 2022 10:27:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 961EDB815B1;
        Tue, 13 Dec 2022 18:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A02C433D2;
        Tue, 13 Dec 2022 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670956052;
        bh=PImCBB4GDpOQKKWDXCLi5kFg9bOLyxtK8mehh6q7gBI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jXdyUDq2SUF+xsiwAk/8ZpwJZdVBYhJu1JU32FyPZge44Pnyd6Buv+1zKRNFByLDN
         uVHaNbRKFx3SqJ1eP2YXSkSGAXRqjk2Q6HQMsBPLpjH+YY2SttNRvYduiDhcOFEeNw
         bhoN859aPHX8CIOXf5/dkWpcCJaUWUtVkQTd+N/fS/y63PLN19KpWDzoeAAJXHTM6U
         ddptvTWdpOvJCpLatc25r0zRI1fPjRtUdmipTAVlAb6RTd9KPFg5yWfrTeeYirFVbU
         DdcGMyFo/qTn8sKp7tnjWt2JwP5UtM74QaitBCNpxccUB3T1v/R+f7h9pFEY0oHcGd
         B16HWWK5WIQbw==
Date:   Tue, 13 Dec 2022 12:27:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Frank.Li@nxp.com, jdmason@kudzu.us, kishon@ti.com,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Subject: Re: [PATCH -next v2] PCI: endpoint: pci-epf-vntb: fix error handle
 in epf_ntb_mw_bar_init()
Message-ID: <20221213182730.GA193001@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625021516.431473-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 25, 2022 at 10:15:16AM +0800, Yang Yingliang wrote:
> In error case of epf_ntb_mw_bar_init(), memory window BARs should be
> cleared, so add 'num_mws' parameter in epf_ntb_mw_bar_clear() and
> calling it in error path to clear the BARs. Also add missing error
> code when pci_epc_mem_alloc_addr() fails.
> ...

> @@ -640,12 +650,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>   * @ntb: NTB device that facilitates communication between HOST and vHOST
>   *
>   */
> -static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
> +static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)

This change added a kernel-doc warning:

  drivers/pci/endpoint/functions/pci-epf-vntb.c:658: warning: Function parameter or member 'num_mws' not described in 'epf_ntb_mw_bar_clear'

Can you fix this, please?

I use this to check for kernel-doc warnings:

  $ find drivers/pci -type f -name \*.[ch] | xargs scripts/kernel-doc -none 
