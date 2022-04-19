Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5D1507311
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354669AbiDSQik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 12:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345034AbiDSQih (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 12:38:37 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E785E13DED;
        Tue, 19 Apr 2022 09:35:54 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id s16so6708526oie.0;
        Tue, 19 Apr 2022 09:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bx1ulSC01YemGk9c9Yc6xd4QH5nY3xNI+NoHQ3XOQDo=;
        b=k2SFyvpc26cVoYu2zlY6sYy2NjMECZSENBZsF/pStlybYzVsF0kbzX1BnStNLdYrdg
         VNW+cb+SM3xUTspz5QXZvDXrrCfLY0ppxyKblG25kIZpYBKGbwIWe5Ki1TBIQIxNFF4L
         a5sWZN591ggPm+T1BUjKNMcNOn/gRSW5iPXHYPqj+JirR751o4dJ/cpTxW+PSWQUzrsz
         GutmOo4UjFyTzzN1RA3//aY7l8xW8r2QCVgyNxaPk7buGFm/rG2vLwuBj01AziUUdwAh
         auyHFsYEupMfJVt6rdZzerV8uJ2fjPPRyIrDscK2JohudisTpMMH+7rNkQu2TK4HYm5z
         DVJQ==
X-Gm-Message-State: AOAM530GUft+eTbd83mDaMcKTcr+WgNasCvX9t9smnwIOf0yfDrGXNQZ
        GsL0+WI0vbiD8OpgKVAtuw==
X-Google-Smtp-Source: ABdhPJwQdh1hh7JOKO7KmqcuZGROx++PGmjp51LbjNQBETXKkVYndi+PqMxf9cWoVYHtEITyqY6sfw==
X-Received: by 2002:a05:6808:2223:b0:2d9:ca75:8ee8 with SMTP id bd35-20020a056808222300b002d9ca758ee8mr8252625oib.110.1650386154230;
        Tue, 19 Apr 2022 09:35:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ay5-20020a056820150500b00320f8a179d0sm5784194oob.30.2022.04.19.09.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:35:53 -0700 (PDT)
Received: (nullmailer pid 2918588 invoked by uid 1000);
        Tue, 19 Apr 2022 16:35:52 -0000
Date:   Tue, 19 Apr 2022 11:35:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: PCI: uniphier-ep: Clean up reg,
 clocks, resets, and their names using compatible string
Message-ID: <Yl7k6Jb/q2wuJw0Y@robh.at.kernel.org>
References: <1650241100-3606-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1650241100-3606-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650241100-3606-3-git-send-email-hayashi.kunihiko@socionext.com>
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

On Mon, 18 Apr 2022 09:18:20 +0900, Kunihiko Hayashi wrote:
> Instead of "oneOf:" choices, use "allOf:" and "if:" to define reg, clocks,
> resets, and their names that can be taken by the compatible string.
> 
> The order of their names doesn't change here.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../pci/socionext,uniphier-pcie-ep.yaml       | 76 ++++++++++++-------
>  1 file changed, 49 insertions(+), 27 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
