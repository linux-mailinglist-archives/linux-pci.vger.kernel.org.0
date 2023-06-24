Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4120873CC61
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jun 2023 20:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjFXSed (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jun 2023 14:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjFXSec (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Jun 2023 14:34:32 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A511BD
        for <linux-pci@vger.kernel.org>; Sat, 24 Jun 2023 11:34:32 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-543b17343baso862986a12.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Jun 2023 11:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687631671; x=1690223671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50y7QuRKBodc8YNaSDdNunw0doa5v8GtHWwRWDHFDKk=;
        b=bXt+hKlLPMpMCwhn59atXKHGCZ6cETb3pPV2nuSwZqnHHMax0zLQDkYe2YEFmBSqOv
         XCsFnr5T0JSn9kSmXZxnCqGDioH1u3oMxlcbtS+0Fduq9LqmiAc9OxRusfw5I0H6R3c/
         8Fx81RtHkQEr2pYPlt7IjavVz3AO5wwK0otJGrZuthfp4+7g81RWafVsKQ+CItC4oJgO
         RvvKvdOOGMjCpfmVOpgnKax6xevPsiYQdujUgbGmYCNE+haDzir9+YLrLev8xT3jr/6/
         FXvoagVvN8756l7zwqsii9Q/eF//+BV2lA1MHbjH7HlU1X/FazTc5nha5z4SS51/jT85
         WGhw==
X-Gm-Message-State: AC+VfDx3goAH+JP/J0X8/QDktDm9Bt/layO1P/6wSK29zsHORBbVrSoM
        6b9I+aS9RlDQpxIwhY5F1ooRnRInrbnrGwR/
X-Google-Smtp-Source: ACHHUZ5uMVGqMJ7Rd2OWArZh6D8bOZhrUrh4w3CU31H7VC3deHLqQehtXsqUxGcOUXznlRQkuorMUQ==
X-Received: by 2002:a17:902:f611:b0:1a6:46f2:4365 with SMTP id n17-20020a170902f61100b001a646f24365mr1242488plg.30.1687631671195;
        Sat, 24 Jun 2023 11:34:31 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902bc4100b001b7e63cfa08sm1142312plz.293.2023.06.24.11.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 11:34:30 -0700 (PDT)
Date:   Sun, 25 Jun 2023 03:34:28 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, lpieralisi@kernel.org, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v1 2/8] PCI: microchip: Remove cast warning for
 devm_add_action_or_reset() arg
Message-ID: <20230624183428.GF2636347@rocinante>
References: <20230614155556.4095526-1-daire.mcnamara@microchip.com>
 <20230614155556.4095526-3-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614155556.4095526-3-daire.mcnamara@microchip.com>
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

[+CC Simon]

Hello,

> The kernel test robot reported that the ugly cast from
> void(*)(struct clk *) to void (*)(void *) converts to incompatible
> function type.  This commit adopts the common convention of creating a
> trivial stub function that takes a void * and passes it to the
> underlying function that expects the more specific type.

This is a nice change, but it seems it has been carried along a few other
series and through their different revisions.  Simon also found the problem
and addressed it independently per:

  https://lore.kernel.org/linux-pci/20230511-pci-microchip-clk-cast-v1-1-7674f4d4e218@kernel.org

However, we have a few other drivers where we could take care of this, per:

drivers/pci/controller/pcie-microchip-host.c
864-		return ERR_PTR(ret);
865-
866:	devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare,
867-				 clk);
868-

drivers/pci/controller/dwc/pcie-keembay.c
170-
171-	ret = devm_add_action_or_reset(dev,
172:				       (void(*)(void *))clk_disable_unprepare,
173-				       clk);
174-	if (ret)

drivers/pci/controller/dwc/pci-meson.c
189-
190-	devm_add_action_or_reset(dev,
191:				 (void (*) (void *))clk_disable_unprepare,
192-				 clk);
193-

If neither you nor Simon has objections, I can send a small series to
address these in a single take.  You could then drop this particular patch
from v2 of this series, should you send a second revision at some point.

Thoughts?

	Krzysztof
