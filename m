Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E308563938
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 20:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGASf7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 14:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGASf7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 14:35:59 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3065D33A18;
        Fri,  1 Jul 2022 11:35:58 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id p128so3096379iof.1;
        Fri, 01 Jul 2022 11:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AtVtVe4VlG3h44sz92HfYZHWHKM93NOvuNInqjd7pr4=;
        b=AACKDHzVnUlmvWgRNIyqJ1t0xyHoYQXcles1Mz+wvDfGyTVEkCNVOn6/IxMm17R+/L
         N7lw+YYnkuFSS1RBua/sfmFs1jByTB1QFRmdy+LAfMov/wbSg5yjtENQBD4LtpX7h3oy
         hthgi1Vnadb83gSwYu0YEJ7HAs/y9xIu1EzqUh2BQnEZd7y7lxTYMWlBKhDHavnyZF5K
         1sCwseO3EYNzr21tfwOIjIXZPivIEY4d7h5eIY9LBYv76rdYeBKQJKtQpHZehOAWZwvp
         yYjMHq4ni0vaizjj8T6TcEa8R3Ajc1tqItXknym3tW6a6TYmn+xJYONUqUVugGX8GcCD
         T7uw==
X-Gm-Message-State: AJIora+BiYCFIkXLg0hYydFJ+ROEULXtlxt01DWkNZrhb568wzTMyDN+
        EIP92z7T0a72zIlpvTHnXQ==
X-Google-Smtp-Source: AGRyM1sJOOFB5Clyjs50qW3h8PGdbkdd1BjXbZlQkj3gJZWFQm7FbD2hs57sx7FCG7EZQrG9zbLY+Q==
X-Received: by 2002:a05:6638:34a0:b0:33c:aa2d:a88b with SMTP id t32-20020a05663834a000b0033caa2da88bmr9875093jal.296.1656700557407;
        Fri, 01 Jul 2022 11:35:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i16-20020a92c950000000b002d9151bb4fdsm9206176ilq.88.2022.07.01.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:35:57 -0700 (PDT)
Received: (nullmailer pid 1285313 invoked by uid 1000);
        Fri, 01 Jul 2022 18:35:55 -0000
Date:   Fri, 1 Jul 2022 12:35:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] PCI: qcom: Clean up IP configurations
Message-ID: <20220701183555.GA1284915-robh@kernel.org>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-10-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629141000.18111-10-johan+linaro@kernel.org>
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

On Wed, Jun 29, 2022 at 04:09:59PM +0200, Johan Hovold wrote:
> The various IP versions have different configurations that are encoded
> in separate sets of operation callbacks. Currently, there is no need for
> also maintaining corresponding sets of data parameters, but it is
> conceivable that these may again be found useful (e.g. to implement
> minor variations of the operation callbacks).
> 
> Rename the default configuration structures after the IP version they
> apply to so that they can more easily be reused by different SoCs.
> 
> Note that SoC specific configurations can be added later if need arises
> (e.g. cfg_sc8280xp).
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 85 ++++++++------------------
>  1 file changed, 27 insertions(+), 58 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
