Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9FB5ECCB1
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 21:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiI0TRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 15:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiI0TRL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 15:17:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD02E855A0;
        Tue, 27 Sep 2022 12:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7350061B4A;
        Tue, 27 Sep 2022 19:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B43C433C1;
        Tue, 27 Sep 2022 19:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664306229;
        bh=14+KBQc4SsSJHqLIhAFCeGfGElbLAMQl2/EREcO+egU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ShIieCLsxi4i+943JPjrZYrkYENyQtsEL0W9Uwdh40SFF5vFfr+UaoOf5JsEiQEDr
         MKxwNaOiCQdjwOH/Gv42j/tPhGCRv4fC1ZFgKb1rgsmtGqLQWi+065fxQliFi5GYpQ
         FYPeVMJnsB1a3Q1oTjLk9XNagxMqXlrwJtkbY4XYTGnb6UDaWMWK61uPMwssPDVitZ
         xccwzcY/4VpIUIQ1GD7RHVQ2l2zgocSsItLeknr70m//TKa42Hs4SBOQYEHiyTZR2l
         GS8YgxeEtMxRzf0jTityOZGes/PvfiXvfCGJXJyONDeISkdeJNhrPJtQwQtQZApzBj
         XuOoEnZdQ4Pgw==
Date:   Tue, 27 Sep 2022 14:17:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 1/2] PCI: Add PCI_PTM_CAP_RES macro
Message-ID: <20220927191708.GA1723152@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926111017.12655-2-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 04:40:16PM +0530, Vidya Sagar wrote:
> Add macro defining Responder capable bit in Precision Time Measurement
> capability register.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> V2:
> * Added "Reviewed-by: Jingoo Han <jingoohan1@gmail.com>"
> 
>  include/uapi/linux/pci_regs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 57b8e2ffb1dd..1c3591c8e09e 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1058,6 +1058,7 @@
>  /* Precision Time Measurement */
>  #define PCI_PTM_CAP			0x04	    /* PTM Capability */
>  #define  PCI_PTM_CAP_REQ		0x00000001  /* Requester capable */
> +#define  PCI_PTM_CAP_RES		0x00000002  /* Responder capable */
>  #define  PCI_PTM_CAP_ROOT		0x00000004  /* Root capable */
>  #define  PCI_PTM_GRANULARITY_MASK	0x0000FF00  /* Clock granularity */
>  #define PCI_PTM_CTRL			0x08	    /* PTM Control */
> -- 
> 2.17.1
> 
