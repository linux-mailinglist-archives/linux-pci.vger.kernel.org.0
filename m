Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8692657C049
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 00:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiGTWt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 18:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTWt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 18:49:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71744BD23;
        Wed, 20 Jul 2022 15:49:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A410B82210;
        Wed, 20 Jul 2022 22:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B83C341C7;
        Wed, 20 Jul 2022 22:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658357394;
        bh=wm6ESMTbVWaQFxoYSU0eNDc8L5I3qxSFttoQ2sekA18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V7VEETcNcC2V8IC4N1c+2jGBRjywi/cOUS47/aDAIXnb9lp921jxhoHRxzn3anCUx
         /d90ZdX7LoqvQ/ZRktjoUMIhZ5lgOlOd54pOLrTV0CtI3Cwm79azw+6mQ/AlhtfxON
         CwKkEH70CyS4f57ucX5DjjkmSJ12KSfjoX4t0BKEbgIPO1SoOb+gxQ1YS4jNGK9FGE
         I6v2Qmap3W0oeaxtREe7anhf/YOWTXugA2ZPxmwlF1vJxh2iD9tOwUGB8tvA7ipTaO
         2SDh03uxyjhsk0gsbXdb947sSTinbMMftv9b9aJgS5zpTwL9rpRgelHb0dsZ9SVXWV
         l/olKeAsIGc/Q==
Date:   Wed, 20 Jul 2022 17:49:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: fu740: Remove unnecessary include files
Message-ID: <20220720224953.GA1667223@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719173321.1545451-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 12:33:21PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> fu740 uses no syscon or regman interfaces, so it doesn't need to include
> mfs/syscon.h.  It uses no regulator interfaces, so it doesn't need to
> include regulator/consumer.h either.
> 
> Remove both unnecessary includes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/ctrl/fu740 for v5.20.  Let me know if you object.

> ---
>  drivers/pci/controller/dwc/pcie-fu740.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
> index 02cc70d8cc06..e8b008f73f34 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -16,11 +16,9 @@
>  #include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
> -#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> -#include <linux/regulator/consumer.h>
>  #include <linux/resource.h>
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
> -- 
> 2.25.1
> 
