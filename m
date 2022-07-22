Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068C357D7BA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 02:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiGVA1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 20:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGVA1q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 20:27:46 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E15C89E84;
        Thu, 21 Jul 2022 17:27:44 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id l24so2616238ion.13;
        Thu, 21 Jul 2022 17:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A9LvynJxe0rCoPzcWA/a2z9MnHe9fzfAmnZLQao5YE4=;
        b=5Sg8yG6FctNga7dzguT02WpfwDlLPoM/nR1XfXDYI4ct1+DQHu96OB6UZmtBwieeex
         AHhqd/u3meZc/tH5TwjG33HTOvlUjndNL0XeBa8vjgO1RzqVwrs/kYVvnERjq5hTpe8t
         xBrdLyo1gU4YuKpr2MrEOz41d+ioxhRjDAHe+1tIkmRIUYCBKeVathyXvW7Fp4QDfyww
         V97JQVbUBhGB0QfN1jUTN0cOzpToZcDCWIAhek7K+ohXoitb4V0xlQJBvEK5tWDFFeAq
         yNxI5TwCW28nD5lXrEvwkmry9N8z++3EsQ97G2AHLcgdcl5jIZ+CAvnzMWHS/CA5rYCC
         Dwdw==
X-Gm-Message-State: AJIora+JEkMDATPfWcUcHp+Fpieulm3YSnPSszZ6kiyJEjIVT7ZfW1Ub
        TaAXeRdXgPHcyA/lpD1YKw==
X-Google-Smtp-Source: AGRyM1uKEwGqiQ/Z9aZ83MzaBv/qqZB45fvT+eCioKSO8RtevK4Osdshp0UwcAy+wcfB8VcdIGXIaQ==
X-Received: by 2002:a05:6638:160c:b0:33f:54c7:ee69 with SMTP id x12-20020a056638160c00b0033f54c7ee69mr470125jas.65.1658449663359;
        Thu, 21 Jul 2022 17:27:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c6-20020a056e020cc600b002dd143ee62esm1105139ilj.14.2022.07.21.17.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 17:27:42 -0700 (PDT)
Received: (nullmailer pid 2243073 invoked by uid 1000);
        Fri, 22 Jul 2022 00:27:41 -0000
Date:   Thu, 21 Jul 2022 18:27:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     pali@kernel.org, thomas.petazzoni@bootlin.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, gregory.clement@bootlin.com, kw@linux.com,
        andrew@lunn.ch, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, linux@armlinux.org.uk,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: PCI: mvebu: Add orion5x compatible
Message-ID: <20220722002741.GA2243040-robh@kernel.org>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220718202843.6766-2-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718202843.6766-2-maukka@ext.kapsi.fi>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 18 Jul 2022 23:28:41 +0300, Mauri Sandberg wrote:
> Add a compatible string to bindings to indicate that orion5x PCIe is
> supported too.
> 
> Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
> ---
>  Documentation/devicetree/bindings/pci/mvebu-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
