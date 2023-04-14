Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338F46E2A54
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 20:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjDNS6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 14:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDNS6Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 14:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0064213A;
        Fri, 14 Apr 2023 11:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ABC2649F6;
        Fri, 14 Apr 2023 18:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5956DC4339E;
        Fri, 14 Apr 2023 18:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681498694;
        bh=iAkYDbK0wlisGLIiMRkS+VLLMRmDmLs0h88rQ8N/FOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZUz4e5AZs6ZaT9Sq5DsfGrUtXXdqKglECewvkvEWQCN1tzt/JMl9kN8392ZjS+SyH
         WNqOCruCOi4Lv0cU5CyQYb/TMeB1BnzDU7PlBgTj4RURYcKe8WiduTb6/bXr8Lbk7x
         mb1Xqpa+823kXjk654SfgyH5+P3kHcrXYaqDMLwUYN2A/p9vOgVI6S3TcndylkaAiH
         GaQp5zGUo2MPwu6kSP+Nz6G1+Q8uPOr2/eF3Z6mv4mNels1v5D5QBzW50pNKitYCKB
         Nuxqr3UMLFoXtPLnuyeykZDXlFQOLxEMTH0bAmK/nG4wLgLbS0Bg8dEo55Jl83i4Ad
         obWbIFGTuqBSA==
Date:   Fri, 14 Apr 2023 13:58:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v12 03/19] PCI: Add PCI_HEADER_TYPE_MULTI_FUNC
Message-ID: <20230414185812.GA212427@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414061622.2930995-4-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 14, 2023 at 03:16:06PM +0900, Yoshihiro Shimoda wrote:
> Add PCI_HEADER_TYPE_MULTI_FUNC macro which is "Multi-Function Device"
> of Header Type Register.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  include/uapi/linux/pci_regs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 5d48413ac28f..a302b67d2834 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -80,6 +80,7 @@
>  #define  PCI_HEADER_TYPE_NORMAL		0
>  #define  PCI_HEADER_TYPE_BRIDGE		1
>  #define  PCI_HEADER_TYPE_CARDBUS	2
> +#define  PCI_HEADER_TYPE_MULTI_FUNC	0x80

We test this a few places already; if we add this new macro, shouldn't
we update those places to use it?

>  #define PCI_BIST		0x0f	/* 8 bits */
>  #define  PCI_BIST_CODE_MASK	0x0f	/* Return result */
> -- 
> 2.25.1
> 
