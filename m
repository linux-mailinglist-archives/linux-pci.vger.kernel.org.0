Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69274E99C6
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 16:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiC1OhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 10:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbiC1OhV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 10:37:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6044CD67;
        Mon, 28 Mar 2022 07:35:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so8708780wme.0;
        Mon, 28 Mar 2022 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=328x0xP62Tm4C/j9QOIhfOPeltnC1X+TTrn/OvLPN1E=;
        b=JESc/sCCocgPCuvsg016sk3FLd0aPbxUs2B3M5qmjNX53/rTJygDQRUxFtGjNzA+Ih
         FFvcTzCG6FhKJj1uNJOneHbSAvgy3HQgfGPtaPFK9hTzqElfj0Dq0KSOrmyNeU+33aIS
         ibE6khgJuo7D5n1xK+/3HrflU049OrYuOHxyZdWTmt9PMHG4S9gTGIsv2zh7pXfUySrv
         sKnld/Rva8r2NI5KrQOTs8Kj/t9I5/7guiG/R7tp9mSTp6N+VH/i9eUQC9/gEjn5Ykdh
         rS8eD7ZaI/BshPmak18wZLkVZ+zcKN9OmEJXrGs+dhOgIhLaYMrLbgfE01YoqO2K4mEa
         0HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=328x0xP62Tm4C/j9QOIhfOPeltnC1X+TTrn/OvLPN1E=;
        b=WqbbUGNajDoUHzRVgKCl50PFrEnOOCgs7wwKzEV2uz98Yj7QE7Zwdw8RQJQ2EpJqeV
         jLNK/Y+xuNwWADXrmCKOCL7+Ib7aviRtzmv9aH9JiFMmEwLTTGJbjqqdOcnS9XPJCLY9
         FPr+/URAHN4bTQ3vgQG/ZUdBB+8pDY1WcuMfTVo42PVh2U2LzzhF4u/WEUKNyJq+qxLR
         DSsqQSF7GwLTTx7xtTDpfO3h579CVQ+aVHJdcJhO7koDNEVRbIM8QnQqExBsQsOhdG7r
         gsjL9N3uLmgNm0EMNj1bPevohSKQoRh9Empz4zxvywvOUaow5FkOSFuKzxt/yRCQRte7
         avgg==
X-Gm-Message-State: AOAM533mCisk96RGdpKZgwe/c7EcOK1B0mD5O7XZA5/Ev40s/NtSW9Os
        uIaih+eO1UYY+2MX6GaSSm21vN3JbS0I8A==
X-Google-Smtp-Source: ABdhPJzMUJWsEZAlM1V/ydplBTxkvZDhiLPBjSw8ljpLv5176bAmYtFOOZJKT32vucPANPe55H/8rQ==
X-Received: by 2002:a05:600c:1c82:b0:38c:a750:56e7 with SMTP id k2-20020a05600c1c8200b0038ca75056e7mr26805950wms.188.1648478138821;
        Mon, 28 Mar 2022 07:35:38 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm14269090wmq.35.2022.03.28.07.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:35:37 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     jgg@nvidia.com, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com
Subject: Re: [PATCH V2 1/1] Intel Sky Lake-E host root ports check.
Date:   Mon, 28 Mar 2022 17:35:36 +0300
Message-Id: <20220328143536.20761-1-shlomop@pliops.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220328113728.GA1693573@nvidia.com>
References: <20220328113728.GA1693573@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jason,

Thank you for your comments I'll fix the spelling mistakes.

You suggested to remove the port field and to ignore the slot number for root ports,
and I understand the reasoning, but, from safety reasons, if we know that device 2030
will always be found on slot 0 and 2032 for example will always be found on slot 2
wouldn't it be prudent to compare the device number vs the port number,
unless you believe that the BIOS/ACPI issue will be fixed.

Shlomo.
