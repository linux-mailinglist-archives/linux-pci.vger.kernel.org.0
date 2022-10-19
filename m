Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A43604E0B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 19:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJSREV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 13:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiJSREF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 13:04:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37701C69C7;
        Wed, 19 Oct 2022 10:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E47AB8255F;
        Wed, 19 Oct 2022 17:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E218DC433C1;
        Wed, 19 Oct 2022 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666199042;
        bh=ZqP1ImOgc0zHc8fWYUFbsZ7wKZuxfrUuqdLLxT7GPjU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lzMPAZhGcB9OpsD9o+JvRVdbMXioI0pm3JbcJHVWs3dfBSyr40cmGyOva66V+SBCM
         X7K2KKK7esrM7d07hdgSgrKZrwWqO7xl89kafnQ4faAZFf+cemNganGCQpizGEnHak
         B7s+ZmnrFcKNR8X5eeHCHw5ds4M/uRoeOQRT+m6CHmW0UNkWQYjEIOB5wx+oT7obB8
         SODDn5RPu2A2hDv72LebqaygbjUuJGxJWorGuloSmoyjSgc6NwTo5rC39YZ67iqwU8
         BefX/CsE2TixqwevaW85e+I9yzQGxyofj6ugLsA3waf/+GOaKxdTW25ynIhpeUIp6S
         8zFMYQG5KAydA==
Date:   Wed, 19 Oct 2022 12:04:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update Kishon's email address in PCI
 endpoint subsystem
Message-ID: <20221019170400.GA25383@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220928102431.658-1-kishon@ti.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 28, 2022 at 03:54:31PM +0530, Kishon Vijay Abraham I wrote:
> Update Kishon's email address in PCI endpoint subsystem maintainer
> entry and mark him as reviewer.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Applied to for-linus for v6.1, thanks, Kishon!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffad3f1dfe9c..9dc9a4aa2301 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15684,9 +15684,9 @@ F:	Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
>  F:	drivers/pci/controller/pci-v3-semi.c
>  
>  PCI ENDPOINT SUBSYSTEM
> -M:	Kishon Vijay Abraham I <kishon@ti.com>
>  M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  R:	Krzysztof Wilczyński <kw@linux.com>
> +R:	Kishon Vijay Abraham I <kishon@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  Q:	https://patchwork.kernel.org/project/linux-pci/list/
> -- 
> 2.17.1
> 
