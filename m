Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4371673DCBC
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 13:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjFZLCw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 07:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjFZLCi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 07:02:38 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2822B1;
        Mon, 26 Jun 2023 04:02:28 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1acf5ccf3baso3269494fac.3;
        Mon, 26 Jun 2023 04:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687777348; x=1690369348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo55k0SMHkpFGe7XNrjZEsrn1U/Ef0qRgQ9OTkkGS3Q=;
        b=MpoNU5TMyTPvcTPfYIwrfXlL1NfcNjWLHfx5BJMmA7euUrMudOJke0jxirOunIpcQJ
         RmFDK9vgmZhIBEwFX2ma4d0msgdERWIpahlYL+Co9gPpEJCMNOxqdqtA/RqzYsH62/r2
         0qH14jW/rVaeAhgyU3fRPFEzsOASCTu/GZYpsy8XN0fLaY114OrALAmcBPwMYwJeAnbf
         7Q4Km+NakUlgbmPBMLI9vG+wylZaop0WpVXd+f4JEvRsJV6P4CKmnrTzi2wMQs8vTkxk
         TUNWk9BrG+PMd02euOPl45GLQFxE1xL5axuKKO6rSSQq6xeRk7tNKVvebkNH6HqO4azn
         DkvQ==
X-Gm-Message-State: AC+VfDyyNUS30I0XglKyPevIp2e3MGOPbSJCjCFZpQjutBt6JZxTk/Ep
        Ho8TDDYvzkD51YPzmj5V/ek=
X-Google-Smtp-Source: ACHHUZ4NUr+76C+eqcdtic/nym3avSqY0y7Xr34NaRoffLKuFivw7WauvQ3veQuDbigKmchNrPNYAQ==
X-Received: by 2002:a05:6870:4312:b0:19e:fd18:a6e7 with SMTP id w18-20020a056870431200b0019efd18a6e7mr20751109oah.17.1687777347953;
        Mon, 26 Jun 2023 04:02:27 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id y73-20020a638a4c000000b0053491d92b65sm3945024pgd.84.2023.06.26.04.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 04:02:27 -0700 (PDT)
Date:   Mon, 26 Jun 2023 20:02:26 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: rcar-gen2: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230626110226.GA569947@rocinante>
References: <20230323091644.91981-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323091644.91981-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.

I took each separate patch:

  https://lore.kernel.org/linux-pci/20230323091644.91981-1-yang.lee@linux.alibaba.com
  https://lore.kernel.org/linux-pci/20230323090431.73526-1-yang.lee@linux.alibaba.com
  https://lore.kernel.org/linux-pci/20230323090011.66754-1-yang.lee@linux.alibaba.com
  https://lore.kernel.org/linux-pci/20230323074553.90372-1-yang.lee@linux.alibaba.com

Turned into a series and applied against a single branch.

Applied to controller/resources, thank you!

[01/04] PCI: rcar-gen2: Use devm_platform_get_and_ioremap_resource()
        https://git.kernel.org/pci/pci/c/8b88299ef429
[02/04] PCI: v3: Use devm_platform_get_and_ioremap_resource()
        https://git.kernel.org/pci/pci/c/cc456373aa57
[03/04] PCI: xgene-msi: Use devm_platform_get_and_ioremap_resource()
        https://git.kernel.org/pci/pci/c/7a081062046f
[04/04] PCI: imx6: Use devm_platform_get_and_ioremap_resource()
	https://git.kernel.org/pci/pci/c/860955d0db7d

	Krzysztof
