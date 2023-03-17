Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2866BF09F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 19:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCQSX2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 14:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCQSX1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 14:23:27 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C8A3E614;
        Fri, 17 Mar 2023 11:23:25 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id o14so2685008ioa.3;
        Fri, 17 Mar 2023 11:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679077405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YY5kvROBmAIjw6Dx4gFwNzn0Rq7UyRKCnLAFPdvlxE0=;
        b=dDGoaoFwmTq41tC5TFqUEw+UDNKosV4AI/gcMzzlcmYQGIqrsqIq4V+PHeaHRheX/d
         wgoHnksF5IgeE0Wi5UjUwIOTdvOkWk2q9e4TUaKc8Ey6EMZKUkDDBVI6FhsWo/6QDO9c
         kd6wAaepFwKAb9FR2TbEEhmS/j+v5OlhW0A4nVpR+H3dCiwvd81WegSdUUdBdOqqnIXk
         xYkiXY6uJqx3FKRMsGG+ZGAN6CwUq9Wuo6/FsuakABw2F+2lZYjczHnm9PP6L9IWubkC
         91ljKfOIHAFp/FIiSQZ2BIbwPNBOB0g2i3hY+DyUm6uIRaxY4omnuA9EHHCBjpMFQju5
         teYg==
X-Gm-Message-State: AO0yUKXJYnJU1v5eBV18EsfiIpcChsiNH7HcEDcQHybjb+D/Ih/+/RnG
        lJWEJCavrAZXaeaLhuUsL1NOq9wYWg==
X-Google-Smtp-Source: AK7set+NBOhE/BlrvZHskphjTYZF6T6DcdgvpFdLKzZVNY9P5Z4F1Ye4FXKATFWy0j0uztmzyjmHFA==
X-Received: by 2002:a5e:8b03:0:b0:6ea:6c79:d21d with SMTP id g3-20020a5e8b03000000b006ea6c79d21dmr289758iok.20.1679077404945;
        Fri, 17 Mar 2023 11:23:24 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id y10-20020a6be50a000000b007453a11bdf5sm756667ioc.13.2023.03.17.11.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 11:23:24 -0700 (PDT)
Received: (nullmailer pid 2575814 invoked by uid 1000);
        Fri, 17 Mar 2023 18:23:23 -0000
Date:   Fri, 17 Mar 2023 13:23:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 7/8] PCI: dwc: Introduce configurable DMA mask
Message-ID: <20230317182323.GA2445959-robh@kernel.org>
References: <20230313124016.17102-1-enachman@marvell.com>
 <20230313124016.17102-8-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313124016.17102-8-enachman@marvell.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Robin

On Mon, Mar 13, 2023 at 02:40:15PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Some devices, such as AC5 and AC5X have their physical DDR memory
> start at address 0x2_0000_0000. In order to have the DMA coherent
> allocation succeed later, a different DMA mask is required, as
> defined in the DT file for such SOCs, using dma-ranges.

I'm afraid this is not right. 'dma-ranges' in the PCI host bridge node 
applies to PCI devices (i.e. child node), not the host bridge itself. 
It's 'dma-ranges' in the parent node of the host bridge that applies 
here. The core code will set masks (ranges really now) based on bus 
restrictions. The mask for the device should only be based on the 
device's limits (i.e. the device is 32-bit only). 

I think you will need whatever solution comes out of this thread[1].

Rob

[1] https://lore.kernel.org/all/c014b074-6d7f-773b-533a-c0500e239ab8@arm.com/
