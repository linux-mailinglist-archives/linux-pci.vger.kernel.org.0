Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E58F73FF76
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjF0PQv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjF0PQu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 11:16:50 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D8139;
        Tue, 27 Jun 2023 08:16:49 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so2541374b3a.3;
        Tue, 27 Jun 2023 08:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687879009; x=1690471009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fyw7Pb1Ah0fzuStf16Tgu33vm1EEKh6Q2kQ4z3Ksyw8=;
        b=Nqex2kLr3sgeJnlZnR2JJ1aG8No1/dNuuRahoMJ+1KvwOpNTsKbS6soJ8A/Hbxd63x
         wXuu6LHqAME6XYplw1KukA5OpR50an2CMB1w0UtGFDjTVGcmBbAEXZ5HnRc/8s/9REhI
         +Mth+mimNB9uOjjpJy3gAMUVDOEio6zGBJiRvChYnGghq6naEGD5dgQkGmSM0UARSer3
         ASwrwhnP+dpNS5OybnMBrGuIeL0d98bTLsEr2/04jB+uQtCdvxRaX5cTce4YBZwi8cE9
         E0mNy2hIXJXnUpYlgldI9PUT4x9x1EkNo1YrqCCpAkcABsJA5V4pM6b9KWNz5ASABDgb
         DaaA==
X-Gm-Message-State: AC+VfDwRiaGZ0EJ8qHfyxn+RVH57q2Bhe2sEhR47+95ovqc+c5XdeI7N
        qFL/Su1nVaye1T+O0PCmngY3eFdhC0cR/Q==
X-Google-Smtp-Source: ACHHUZ4PHkIt+75TN7hHnViJ3Oa2m9CKZAqsEvf2aL4I6w10GaLLzAdWeuanGx+JFaIb2g+3q+Q0RQ==
X-Received: by 2002:a17:903:2283:b0:1b5:64a4:bea0 with SMTP id b3-20020a170903228300b001b564a4bea0mr7344573plh.10.1687879009164;
        Tue, 27 Jun 2023 08:16:49 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00192aa53a7d5sm6166075plr.8.2023.06.27.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:16:48 -0700 (PDT)
Date:   Wed, 28 Jun 2023 00:16:45 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Fix the write to PARF_MHI_CLOCK_RESET_CTRL
 register
Message-ID: <20230627151645.GA869118@rocinante>
References: <20230627141036.11600-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627141036.11600-1-manivannan.sadhasivam@linaro.org>
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

> Instead of writing the updated "val" that clears PARF_MSTR_AXI_CLK_EN,
> "val" is read again. Fix it!

Applied to controller/qcom, thank you!

[1/1] PCI: qcom-ep: Fix the write to PARF_MHI_CLOCK_RESET_CTRL register
      https://git.kernel.org/pci/pci/c/58cfae52a877

	Krzysztof
