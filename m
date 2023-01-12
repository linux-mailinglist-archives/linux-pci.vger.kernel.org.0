Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DCC6677F4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 15:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbjALOvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 09:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbjALOut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 09:50:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D5312609;
        Thu, 12 Jan 2023 06:37:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94181B81E69;
        Thu, 12 Jan 2023 14:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494E7C433D2;
        Thu, 12 Jan 2023 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673534243;
        bh=KsWxmfUVUayGypU/e5HMI6DL66/v8eYhpnNqIfHIaMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQCoJCrwuXwKJMtsZPjR+eKrgl6iJclHyvYxS3qR0gCWb5KiFT8zEAj5642Ng4HJu
         44hdWIQTTyxwFjfL4F8ECQSbRblOVZbbOSIpqjZIB1gD4bcB65pgEUZaABlf5RB61/
         54hqloZv5nwOOM66MnWOgPLbwfZxIf4kfUmCbGUvGE5ASITbwG+xTkFq/EuGExR0w5
         l1YONvvKCQaXs4qI9SAVeD/NDCkubtUc30fLu13Y0RFcFBKfIJ4mfIkmuo+Ixxvqg/
         fr7C5V0L9IqJb6lv6EFbwmGRyFf0V6snYNBDevP7hawgaJUlrw2QvbXDFYUojoyPAe
         fgdnF2tSfOBeQ==
Date:   Thu, 12 Jan 2023 15:37:16 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH rcu 17/27] drivers/pci/controller: Remove "select SRCU"
Message-ID: <Y8AbHEzbVv4ebeXU@lpieralisi>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-17-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105003813.1770367-17-paulmck@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 04, 2023 at 04:38:03PM -0800, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: <linux-pci@vger.kernel.org>
> ---
>  drivers/pci/controller/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

I assume I don't have to pick this up and it will go via
a separate route upstream, if I am wrong please let me know.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 1569d9a3ada0b..b09cdc59bfd02 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -258,7 +258,7 @@ config PCIE_MEDIATEK_GEN3
>  	  MediaTek SoCs.
>  
>  config VMD
> -	depends on PCI_MSI && X86_64 && SRCU && !UML
> +	depends on PCI_MSI && X86_64 && !UML
>  	tristate "Intel Volume Management Device Driver"
>  	help
>  	  Adds support for the Intel Volume Management Device (VMD). VMD is a
> -- 
> 2.31.1.189.g2e36527f23
> 
