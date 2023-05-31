Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B090718857
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 19:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjEaRVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 13:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEaRVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 13:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD650101;
        Wed, 31 May 2023 10:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C0BE637E5;
        Wed, 31 May 2023 17:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AF5C433D2;
        Wed, 31 May 2023 17:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685553705;
        bh=nTMXCgyHDtjRFmdEA9PM4ahOKoXAJkdDrxqWv4NyEfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bqFqPKw7hPRlxRApTZKF5DFOZYcivhUwItbSLoEQ++e+Errt6BvQdE1H7nhkOejdG
         iM2lJS26GQMRiZ7Wazuj2BBC1JxgpDYHEYU7UL2O57WfdR9zIYdGxBuJym5wK5ZUdI
         vXOsvIkKakvnZt+juuLaM9Cd6E6jsEaQm6yLyb5PYyRVqijKnEzxU5k8Ic1TZlbOPV
         r9+ck4Lq2dKAklL7dMpthOcRo7S6AnexiR8Fz7T1N9Cg58feEb2ffgRUveFmTTPy7r
         rPbCh0PFNOpKcaJlv5BmyVmI5Jt0LYE0rvm5PFBbUPKBJ6BdwR90fZtQZkJnBnGihI
         IAWOg4EubdC0g==
Date:   Wed, 31 May 2023 12:21:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhu YiXin <yzhu@maxlinear.com>
Cc:     lchuanhua@maxlinear.com, torvalds@linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pliem@maxlinear.com, qwu@maxlinear.com,
        Rahul Tanwar <rahul_tanwar@yahoo.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Update entry for PCIe driver for
 Intel LGM GW SoC
Message-ID: <ZHeCKKInjVpLBfda@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519044555.3750-2-yzhu@maxlinear.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rahul]

On Fri, May 19, 2023 at 12:45:55PM +0800, Zhu YiXin wrote:
> Rahul Tanwar is no longer at Maxlinear, so update the MAINTAINER's entry
> for the PCIe driver for Intel LGM GW SoC.
> 
> Signed-off-by: Zhu YiXin <yzhu@maxlinear.com>

Applied with acks from Rahul Tanwar and Lei Chuanhua to for-linus for
v6.4, thanks!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8d274efff10..6091bbb0e1d7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16383,7 +16383,7 @@ F:	Documentation/devicetree/bindings/pci/intel,keembay-pcie*
>  F:	drivers/pci/controller/dwc/pcie-keembay.c
>  
>  PCIE DRIVER FOR INTEL LGM GW SOC
> -M:	Rahul Tanwar <rtanwar@maxlinear.com>
> +M:	Chuanhua Lei <lchuanhua@maxlinear.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> -- 
> 2.17.1
> 
