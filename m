Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BA77928AF
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 18:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbjIEQXu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 12:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346864AbjIEEXG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 00:23:06 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9529E1B6;
        Mon,  4 Sep 2023 21:23:02 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-53482b44007so833111a12.2;
        Mon, 04 Sep 2023 21:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693887782; x=1694492582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE7wOb4f3tQJ0IpYRUrURtk1HHBKDBeRdhJ1pSca2yY=;
        b=OajjDja1Exlrml+zLtAlEQwTIANfGeXxM+jXzxEPCdnQrTOtoBzj+p99zYG+j53UQi
         gHfNgzem2H+v2OJuAIRnC69iaxT8WqQuWU1wefvd3kM3o0XemUvQNg2AdgkuiKTSZKuX
         oVs8e2lL1VwEq34HaJjn1VeJv5heF1Fft2fEd3VUeMpmKobt/n4uiin0VHkR9nNG1Td6
         1J8/9JmAvRjDU5w1hQhfOukdUgmsrdpFtUrjPD2rzMLA3DlSU4jaEL7ee1tyAHhyQfX+
         JUe2neIjDi2spiTZh24lJxmv78fimcIwFEw5D9TmfRGgfxzKqoYZaPWD4g0ElBLSEXPY
         /TGA==
X-Gm-Message-State: AOJu0YzK2Jl8TOappD95WzvY8776gWNT3pDYWoXLS5Yzc1yVv3rGcQrh
        m/TvDfCm/nVLOipMmiqQR1c=
X-Google-Smtp-Source: AGHT+IFc03AUpiWiy/oRZskvvaA5OqpDqcG8THI2I2F1zX9fnD1bics6NjU8YxO+SVhTfR8334u5bg==
X-Received: by 2002:a17:90a:66c7:b0:26d:4ab3:fe11 with SMTP id z7-20020a17090a66c700b0026d4ab3fe11mr8299685pjl.24.1693887781945;
        Mon, 04 Sep 2023 21:23:01 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090a7f8d00b002609cadc56esm8153904pjl.11.2023.09.04.21.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 21:23:01 -0700 (PDT)
Date:   Tue, 5 Sep 2023 13:22:59 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mani@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: PCI: Revise dwc and rcar-gen4-pcie
Message-ID: <20230905042259.GB1102453@rocinante>
References: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> This patch series is based on pci.git / controller/rcar branch
> to fix dt-bindings doc patches. Krzysztof mentioned that the paches
> will be squashed everything later [1].

Applied and squashed against prior patches:

  - https://git.kernel.org/pci/pci/c/554931ed3795
  - https://git.kernel.org/pci/pci/c/d828097a0bef
  - https://git.kernel.org/pci/pci/c/c1ff8c2d1a8c

Thank you, Shimoda-san!

	Krzysztof
