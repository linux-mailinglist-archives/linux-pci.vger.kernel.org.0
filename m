Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8CE7878D2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbjHXTlV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243196AbjHXTku (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAFB2113;
        Thu, 24 Aug 2023 12:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FD59676AD;
        Thu, 24 Aug 2023 19:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623FBC433C9;
        Thu, 24 Aug 2023 19:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905956;
        bh=IBIjENUwt+t9a5oKPAzomGd+RY2GI6cSJlWh+Ri7FgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxSvgNdYQ810IL4MMhCxucvsdrdd9lCe6q3FFZBVQvnEGMnR/Ec2FEJ1m522XBYg8
         kQolHoOojKqP4xc6NKgVewX1O5QJUlSfyu094MHfnEU20JZIHuw9DiGDOaHKX7948W
         7rc+lcst7v+FuLKYXWop+sruuf6V/ssKuRw2lDRRBSZaDRzfJU9e0x4lrVqb4Ygna6
         olel0tpzPVvEejxyQiFEU31+kkx65iBeVuGuiyj+HeYGLE8o7PWL9ym3fMUB/j6RHA
         YoiJafxjAhz0Fj3vOY81hkWBed9dvfaRXuV8S2SG4RTlCcqedZAQRQtCDJhMvXvU7Q
         s9Z+jYEckmMZA==
Received: by pali.im (Postfix)
        id 866539D2; Thu, 24 Aug 2023 21:39:13 +0200 (CEST)
Date:   Thu, 24 Aug 2023 21:39:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 01/12] PCI: mvebu: Remove unused struct mvebu_pcie.busn
Message-ID: <20230824193913.fp7njruq6zl3pg4d@pali>
References: <20230824193712.542167-1-helgaas@kernel.org>
 <20230824193712.542167-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824193712.542167-2-helgaas@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Duplicate of https://lore.kernel.org/linux-pci/20220905192310.22786-5-pali@kernel.org/ ?

On Thursday 24 August 2023 14:37:01 Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The busn member of struct mvebu_pcie is unused, so drop it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-mvebu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index c931b1b07b1d..60810a1fbfb7 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -87,7 +87,6 @@ struct mvebu_pcie {
>  	struct resource io;
>  	struct resource realio;
>  	struct resource mem;
> -	struct resource busn;
>  	int nports;
>  };
>  
> -- 
> 2.34.1
> 
