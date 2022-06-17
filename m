Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3455254F66A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 13:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382148AbiFQLJx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 07:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382181AbiFQLJv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 07:09:51 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E566CA87
        for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2022 04:09:50 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t25so6412081lfg.7
        for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2022 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=EsSqKI1SMSLuenvGcu7WTL3V7zFTGmjUsljSLgtVwAHqlLErA5xxmBy2JmMaFxtxeX
         u2znEqr5Id9yXIy65CeL2zDYYkXd+7OH7tXB6MSECLWix0wwJclUqK/T3laLowK3jTwK
         u51+r1p6BgxAEzgsBqjmgUREPoVWrTDeqBBOyQGyVUzPxo1LeU+SXn5VLzhTuh2ZzYXS
         i/nd1xzfCcfKnrSlaGbTLNZe7t3ZDUTkow24oui9dblNY2w/aB61eq8G3FPsu2+aM81U
         IWClR+QxexYx2l3uwJyqdCqUolou7LtJ13pi/hqqz0CyFs93zGIKLXx3UgGWaPEEXUpW
         /9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=Sa51Atnt96d8oiP2ClB8yaA4SXWrwpKIEj9rgLF3Vvx6w7+gvPpn1cu33d0gFOpsa+
         d1/eNjKI8oDgoaZXojazTJAr4O7HT4zgCT1NoP0U+fu3WbvwmO+DIqEMGI9U7oGSwFHo
         QlpA1srUzl5e8DUAoTynFXqV6WflabypNtNLKwySUkV4xwQgq0pejyhZsra7vrgZlZmM
         AXLPxoT3+xOL5bFOKGBTOsgWb6KniRQxGyr9sM7iiF+mEI9uw7UgSPNmovvFlYQDU3f6
         DGpxz7XOxRnhgnPIUPW3Ik8neLpcW1lKAQXkbGYXlFiFs20U7CUPd93V7+9hmXrj+lG9
         976A==
X-Gm-Message-State: AJIora9lf6dv4BzO4VLaLuTBBV6Qy60uGSPSi3X8Y9pNqLJ2Um6L44fD
        d/9g+aHISG/UZr2i2Zrw4VP71W/ZW20RGbf/8tI=
X-Google-Smtp-Source: AGRyM1vLzwF4FCaudnvd5ad3/nPHQ4t1msEdIFVsz7XwgUhRC0T/B1APVaOIMfuMW9/Dnyg7I4ZnkRf9phgujEwZYBg=
X-Received: by 2002:a05:6512:791:b0:479:3fc7:e91a with SMTP id
 x17-20020a056512079100b004793fc7e91amr5186313lfr.388.1655464188537; Fri, 17
 Jun 2022 04:09:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:680f:0:0:0:0:0 with HTTP; Fri, 17 Jun 2022 04:09:47
 -0700 (PDT)
Reply-To: sj7209917@gmail.com
From:   Joseph smith <maelyskpeta@gmail.com>
Date:   Fri, 17 Jun 2022 04:09:47 -0700
Message-ID: <CACKGxpwNntSiDYpo4jDZAURubmoyC63t47YzZ=2dVK24mhgW2g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi   are you available to  speak now
Thanks
