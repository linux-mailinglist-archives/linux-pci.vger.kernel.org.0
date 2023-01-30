Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123BD68141D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 16:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbjA3PIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 10:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbjA3PIH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 10:08:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082003433B;
        Mon, 30 Jan 2023 07:08:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D17C4B811D7;
        Mon, 30 Jan 2023 15:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183AEC433D2;
        Mon, 30 Jan 2023 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675091282;
        bh=TXYwQz3P9wX+ne/drYoFKAEOWvGVEQppCR3t73LPcl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MCSlzq02/v58dsK4hHRT9wxgy41LPPomC6APjOHm2oPDl+8GqWMyQEYQpEKZVlLib
         P9OXYiE/Xjv10AclI/DXrPHDdGQ/6GYqXIaGg6ZmIGsnrHaIwcEmk/M7U3gdZpMmh6
         3jfo/g65hwissPuEGiYnZ/ysUrf6rznQrbpsNCZ5hB5YfV9JpbcbL9XGy7e0pu4TTa
         QV1z5YNlXXnMg5BpI4+FukTZzukzqkQ2eSQzvaGcJTYWdBrPN+4zaIJzOGkQjBvpz5
         1V0sMNoOuZHUUKgFqKarV4hSEoQoGfqjfI6nppV4vudwNWTDJjz7mh2JKtujkf99IM
         c+pjYw1zhDhyw==
Date:   Mon, 30 Jan 2023 09:08:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] MAINTAINERS: Promote Krzysztof to PCI controller
 maintainer
Message-ID: <20230130150800.GA1672495@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230130100850.24994-1-lpieralisi@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 30, 2023 at 11:08:50AM +0100, Lorenzo Pieralisi wrote:
> Krzysztof has contributed significantly to the PCI controller
> subsystem recently through reviews, tooling and submissions.
> 
> Update the MAINTAINERS file to grant him the role he deserves.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Krzysztof Wilczyński <kw@linux.com>

Applied to for-linus for v6.2, thanks!  And thank you, Krzysztof!

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14c0b3e89c63..87e7a5e5a666 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16107,7 +16107,7 @@ F:	drivers/pci/controller/pci-v3-semi.c
>  
>  PCI ENDPOINT SUBSYSTEM
>  M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
> -R:	Krzysztof Wilczyński <kw@linux.com>
> +M:	Krzysztof Wilczyński <kw@linux.com>
>  R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  R:	Kishon Vijay Abraham I <kishon@kernel.org>
>  L:	linux-pci@vger.kernel.org
> @@ -16172,8 +16172,8 @@ F:	drivers/pci/controller/pci-xgene-msi.c
>  
>  PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
>  M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
> +M:	Krzysztof Wilczyński <kw@linux.com>
>  R:	Rob Herring <robh@kernel.org>
> -R:	Krzysztof Wilczyński <kw@linux.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  Q:	https://patchwork.kernel.org/project/linux-pci/list/
> -- 
> 2.39.1
> 
