Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD97D53B87F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 14:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiFBMBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 08:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiFBMBE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 08:01:04 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624186C0D6
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 05:01:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r71so4614137pgr.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Jun 2022 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=4IWjHL/5Vo6JeFN3XdXq446L6FUUmY7SjaH1cuJ3kmM=;
        b=Z0GNLGOQlQiVCTn0GSzIMExA6LQSF964HsiNo0/GkCcgyoVikpFVgb3SgNI6IocpoK
         18QirK0BMjGIPFByKBkJpk9YYl3o5GKcvvu37zWBDiIrEbPiUigOnBBRfhFAFZlogr0Z
         q24uOPLTo4hgWQS580Sc+lKFapzmj7HG0W6Zn/PMGzWM2+H+7A9QwUG9V8O4K3LC8NCM
         Du/oS4Ix9agXfU5hMcQcnfZaWNK2rfBZvkCmQalC3Gcqj59VVg9DJbgGdf/sEWDy/Ykh
         Tklnz9RB2rIMl/hMxN9Y0c1ulH3rEy+lCMyfzHOYMmKcrBUjFlmI/wzDGFp23mVxofLt
         Ic6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=4IWjHL/5Vo6JeFN3XdXq446L6FUUmY7SjaH1cuJ3kmM=;
        b=dFSzHXu75hVaGGqA7C9xAnIehdhqZgilhAZuyoGrtjAPk62jjP/nl2jdpr/byliquH
         3OE5Tc7c6KlxhmdphoHvO8MKEZfaMa7xX7+ih9DWiJYeqYmuJ/rkXO8Wv1N3Wkez0Kxp
         x2Aw1pNKT/x+kYGklDsCqBkKaV9JpN7hUkfEYnI2GwJGu4SpS6rHQ3LNsCBuhtWB/yXz
         kVTRqTsn2UCoFBZ6JTgNssS/m8KFMqORewiaCwvTTyaoGBuPaWTXzrh2Fj6gCdLBfm9p
         nqnecWHFpedzRTMD/jBhx4ix8OMOq8T3ZRHmHyBvV5wmC6b9Hxx8NXl5Wp1asEX8vHLz
         Du7Q==
X-Gm-Message-State: AOAM5309LL+GZog44cDLSSAZyzx/TugOpLMZG0SZ0lChy5Uch1u4gjhW
        sngaW7I4sMFeWV416u8UoeLpJt2P1dr7qXUQ0ro=
X-Google-Smtp-Source: ABdhPJwdSQDf750AkGLNra4aP67+c78Cn7v5xBdGA8WYFq1b7NwHKp+APY5aD6SUMxYKyqPhE11PGhanDJn5K5gjdQI=
X-Received: by 2002:a05:6a00:a01:b0:51b:51d8:3c2a with SMTP id
 p1-20020a056a000a0100b0051b51d83c2amr4886763pfh.68.1654171260883; Thu, 02 Jun
 2022 05:01:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:be1d:b0:82:5e75:b37c with HTTP; Thu, 2 Jun 2022
 05:00:59 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikram <kodjoadannou123@gmail.com>
Date:   Thu, 2 Jun 2022 05:00:59 -0700
Message-ID: <CAOtKoZ8bsyr6zRMfTHWmV5RcLTrD82WEbCWgfdNaiQDTV4fhdA@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear ,

  Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
