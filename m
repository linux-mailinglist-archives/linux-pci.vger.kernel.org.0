Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA1E4EAB87
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiC2KpL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiC2KpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 06:45:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F4B1066DF;
        Tue, 29 Mar 2022 03:43:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p189so10013681wmp.3;
        Tue, 29 Mar 2022 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=PDWWz2FvYsmPPpMQfWtqRe/F5339QYlPvsOFYtUGTi0=;
        b=URVPWEjpkYRMzHEI1XW0hNYSLDOtK5jAMS/LWrZ9aTf8gnxJkH7LYHQgWKvnogqdEN
         xRV7AlJ5+U0BG2MkHQlr0nUuoBYv6dJlcMg7YXOSzRQct7ayJYs0K+D0ovGi44v2s7be
         /X81ZkvfCgJKCm4zcUSs33GC//oyWO7JZ95ba9D/LnXGTjQ5S5TewV5DdefIYOEP/MYX
         7jZqx0+clMzX5Rvj5SMMyWWm+jIZYU2E4mouHwVOROxfWlfBiVRSRv5vVvYIEXFUgdIv
         f0FIRgbCnhk3lo6QD/hbEO89/6fpBOdtdAcUozTGdLkrVAfWWG8zg0JEIdUdAGxZm9R5
         HZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PDWWz2FvYsmPPpMQfWtqRe/F5339QYlPvsOFYtUGTi0=;
        b=L3Y+rfkDOOnJ5oI8q5v/wcXMXvTvN5uBTFE9oTePPkLwpbGbksyuKxPvbfUUcM8OrM
         Iw9sqrLUWTGe4ATa/Yq8U9PCnyl3sIM7JbA1p+yUXt5V2lzPL/Dqx9MosgA1TwstOT9l
         oTX9O2Kpotpuw34OY/05GMlYITpWW/LYNU98o7IP5f4O/iDbyupk9Z3ojZrmKzCt+DBQ
         MvdCnOhyCzHgYnofD/Woc7SnrpZzkNQyDtWI48XjmtI0u9X8GKjh7JSRtw92ERIscT7N
         zpOlpf4sYkTj0LKoXWme4pItuFOfmZerltf2GF9UgFhettHHbkGkcS25jOQtw9Y6h0NY
         u2bg==
X-Gm-Message-State: AOAM533+arDEieqeCpyQftZyFGyW47Qm1jctMYWj2BdgFoHaH8xOmWRf
        yIrUWaLLBGoM7I7E7aWksXRqs/vIFKiPOw==
X-Google-Smtp-Source: ABdhPJy5HIONP88/nvafukkq6kzzwJlzqCfaKjkcLt4QxeO5u+OjvEvclZBh/TscByaonyE+I6FLew==
X-Received: by 2002:a05:600c:3016:b0:38c:8786:d3b6 with SMTP id j22-20020a05600c301600b0038c8786d3b6mr6032209wmh.135.1648550605848;
        Tue, 29 Mar 2022 03:43:25 -0700 (PDT)
Received: from Dev-shlomop.pliops.ent (bzq-219-32-62.isdn.bezeqint.net. [62.219.32.62])
        by smtp.googlemail.com with ESMTPSA id 3-20020a5d47a3000000b0020412ba45f6sm16919344wrb.8.2022.03.29.03.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:43:25 -0700 (PDT)
From:   Shlomo Pongratz <shlomopongratz@gmail.com>
X-Google-Original-From: Shlomo Pongratz <shlomop@pliops.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.maier@eideticom.com,
        logang@deltatee.com, bhelgaas@google.com, jgg@nvidia.com,
        Shlomo Pongratz <shlomop@pliops.com>
Subject: [PATCH V3 0/1]  Intel Sky Lake-E host root ports check. 
Date:   Tue, 29 Mar 2022 13:43:20 +0300
Message-Id: <20220329104321.4712-1-shlomop@pliops.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes in v3:

Use Jason Gunthorpe suggestion, that is add a flag 'IS_ROOT_PORT'
instead of 'port' and then just ignore the slot number entirely for root ports. 

Changes in v2:

Change comment and description based on Logan Gunthorpe comments.

Shlomo Pongratz (1):
  Intel Sky Lake-E host root ports check.

 drivers/pci/p2pdma.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

-- 
2.17.1

