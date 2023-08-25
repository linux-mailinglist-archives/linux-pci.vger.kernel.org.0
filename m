Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCDB788D39
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 18:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbjHYQgn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 12:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344014AbjHYQgS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 12:36:18 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E3F2121;
        Fri, 25 Aug 2023 09:36:16 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso8951605ad.0;
        Fri, 25 Aug 2023 09:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692981376; x=1693586176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q3zmNdeBYU0C+cn+U90T8zczbvHLoaw/bLJUP/2Bw4=;
        b=Jp6jloXEtRQ/28mX6cuVPQYI89oSdWciLKfiqZ72Gpb5gXDbGfBzDRw6vpIRycZFsb
         2zzjUj9BfSghHXxD+We7RVaZHmwD2+O6ctZwtITm63lgyKMukzBHQZxZVYbQ8Zg9fzBz
         GPNlcGPVXYrT69v3MQmYmyvemm9EEVPFoaUgkDARthHJzsNggpeSFtgLL7AlJXhH2lu9
         +gSQFLSKlP2JGNcbcQefV2BfttrFLJifyx0kxY66BBzIF1c2mvPmmEXEWxdQ4d0lD/Uf
         EARzXmC+r6Na9QnnVXFzzbLFr2pYbMJ2bC1iJAbkXa1y0pedCBYT5fPoRprfKkTBCn9l
         AUiw==
X-Gm-Message-State: AOJu0YyQ0Utn4fCjklMwCJHeIqAtwpQNL8ahpEICyuzJ9vtj3Nv82g4P
        b2hhHVKjAPkDpPCaJ1/X84U33AEd/rw=
X-Google-Smtp-Source: AGHT+IGM7lz5+p3L2vXDg3lwlOlTvtkkYPz0TqMY3ox17rkD4g/9AyfWRh25CnVSbF0EDztjYgHNLA==
X-Received: by 2002:a17:902:cec9:b0:1be:c879:6e71 with SMTP id d9-20020a170902cec900b001bec8796e71mr20123337plg.63.1692981376048;
        Fri, 25 Aug 2023 09:36:16 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id ik5-20020a170902ab0500b001bbfa86ca3bsm1970766plb.78.2023.08.25.09.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 09:36:15 -0700 (PDT)
Date:   Sat, 26 Aug 2023 01:36:13 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Treat unknown irq events as an error
Message-ID: <20230825163613.GA131548@rocinante>
References: <20230726152931.18134-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726152931.18134-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> Sometimes, the Qcom PCIe EP controller can receive some interrupts that are
> not known to the driver like safety interrupts in newer SoCs. In those
> cases, if the driver doesn't clear the interrupts, then it will end up in
> interrupt storm. But the users won't have any idea about it due to the log
> being treated as a debug message.
> 
> So let's treat the unknown event log as an error, so that it at least makes
> the user aware, thereby getting fixed eventually.

Applied to controller/qcom-ep, thank you!

[1/1] PCI: qcom-ep: Treat unknown IRQ events as an error
      https://git.kernel.org/pci/pci/c/4f4371b9617b

	Krzysztof
