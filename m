Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088CE59A6EE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351680AbiHSUF7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 16:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351558AbiHSUF6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 16:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2FBEC4D3;
        Fri, 19 Aug 2022 13:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BA6F61698;
        Fri, 19 Aug 2022 20:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6320C433D7;
        Fri, 19 Aug 2022 20:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660939556;
        bh=1Yow+Fhn+rlSsjYHJEZ/n6C+LBI5GQMFX7tXobAvLT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KWBjuN3rDyoh/R6XF6YBGZoG/zBb9FuATBJj5sLwozDb2/1l4DeNOtETxLWlb+GHO
         NqsUkHylhS9oDD0DKE7C9HTlZ2RuWtpuXRzPHkcQylyN6b+DrDlA7pok3R9wGG+f0r
         LJRxr5PXfIz5Za/s2Y6ne2DPiIynLT/1Vah6h0edglIOeb0QYL35wSen3TrZGxshe4
         zyg3jDYGSh5zOy6g4oCdG/tv9VHVtBiNO1jFm+Kurtin11XGNm9u2HTXQnnlX3cHyp
         b6/AexOigq56McDJo7abLWjYiNpmDFxFPh386az0JN1jLzqGuHlw+ZGXspvJqVSJFT
         Y08wbEoCz6sbw==
Date:   Fri, 19 Aug 2022 15:05:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bhelgaas@google.com, lpieralisi@kernel.org, kishon@ti.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: Re: [PATCH] MAINTAINERS: Add myself as the reviewer for PCI Endpoint
 Subsystem
Message-ID: <20220819200555.GA2502055@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819020817.197844-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 07:38:17AM +0530, Manivannan Sadhasivam wrote:
> I've been reviewing the patches related to PCI Endpoint Subsystem for
> some time. So I'd like to add myself as the reviewer to get immediate
> attention to the patches.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks, applied to for-linus for v6.0.

Updated subject line to:

  MAINTAINERS: Add Manivannan Sadhasivam as PCI Endpoint reviewer

since "add myself" doesn't mean anything without reading the whole
commit log.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 21081f72776d..58a163c2e5dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15682,6 +15682,7 @@ PCI ENDPOINT SUBSYSTEM
>  M:	Kishon Vijay Abraham I <kishon@ti.com>
>  M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  R:	Krzysztof Wilczyński <kw@linux.com>
> +R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  Q:	https://patchwork.kernel.org/project/linux-pci/list/
> -- 
> 2.25.1
> 
