Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F50570A4E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 21:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiGKTFu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 15:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGKTFt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 15:05:49 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB5537193;
        Mon, 11 Jul 2022 12:05:49 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id r76so5804647iod.10;
        Mon, 11 Jul 2022 12:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=daTp8DrWOTc3Y2/zEGA+bkGfWvKRCA7S9N0xPemD+rY=;
        b=AouZS/KhReKQmZI/iYmvix3f7bHFJP9sA+blnJrV9TpIpg/0JQ5r7knNvXsxo/nG9a
         aHXRPiWToxhKzxHdECwA2Js6fQ8qjji1DJ0f9RZidMPOlqkzZtbo+HGofGcHFFlhJk2m
         8lYGmUg8A3lMquOlf2hcHSmKap8A7UZ7cEr6dhHCpfukqD+BXN8JDqAAmZE+Hu2m7Z4T
         PiVXgScjxd8iDTJhg22JeiItSOxD58OrqNs5cvI5+SwipTqtD0JJ73wbsiuUeWkHmKZa
         legxYBFcyJMmokAIZ1COEYbyFbrMgC+aUR085s2IFuAzK5NnL7GaWq3fNOJjvfoaEhkg
         D4MQ==
X-Gm-Message-State: AJIora/vwblvg64Q8sBYtPorvZHWLNwQtuWgtuBV6VF57Xvu/EZWEZgD
        sKTwnRXp42aRbyLEaT0z2w==
X-Google-Smtp-Source: AGRyM1tzOkDKA5jv/MkQujrm+hRyQ+6iDK/nry0q5aN7NtLk5d5cZxlslYQIsiz+kdGGCs9/gUL3NQ==
X-Received: by 2002:a05:6638:371e:b0:33c:cb5f:2116 with SMTP id k30-20020a056638371e00b0033ccb5f2116mr10805986jav.178.1657566348386;
        Mon, 11 Jul 2022 12:05:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x6-20020a056638034600b00339f193b8ddsm3199708jap.130.2022.07.11.12.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 12:05:47 -0700 (PDT)
Received: (nullmailer pid 101857 invoked by uid 1000);
        Mon, 11 Jul 2022 19:05:46 -0000
Date:   Mon, 11 Jul 2022 13:05:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     marek.vasut+renesas@gmail.com, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, lpieralisi@kernel.org,
        geert+renesas@glider.be, krzk+dt@kernel.org,
        linux-pci@vger.kernel.org, kw@linux.com, robh+dt@kernel.org,
        bhelgaas@google.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 07/13] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Message-ID: <20220711190546.GA101795-robh@kernel.org>
References: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com>
 <20220701085420.870306-8-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701085420.870306-8-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 01 Jul 2022 17:54:14 +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe host module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
