Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424D6534502
	for <lists+linux-pci@lfdr.de>; Wed, 25 May 2022 22:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345084AbiEYUg1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 16:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244637AbiEYUg0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 16:36:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C8018B31
        for <linux-pci@vger.kernel.org>; Wed, 25 May 2022 13:36:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id rs12so32191609ejb.13
        for <linux-pci@vger.kernel.org>; Wed, 25 May 2022 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jF4MxsPSKKSAh34A0y7fWqFeFSCCDQ9NCjS0um7aELU=;
        b=Go2lvrc9m32tOzCZybYeZlninKGkjlKPFCs4o3KvlBPV9ktV/ambG1PdliAVJSmxjm
         lx90jlelZ5BWCdKoap1zwMllIM2bW+BEBxHQNAiCM4aauI7lwDB4mOQJhKnjY3C5UjqQ
         5ojPH6m5jfcis0lwvm8U54B4ECPKBPbZLN+lPown9147egvnJ45uzGQujZwO12fn5NgF
         HSYpYba50F4VnGPw2apFrqhbopWX1Z3/dPPyMwzpBa1MMy/UZhEAznEHft3viPn7pEx3
         gGd2/IpOCuWmMQE69YgLJsEIWTfmbyIvnVl1Z1y85Zp7uSRY5pNL/rPtmNCPZ5ZxEqlA
         7Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jF4MxsPSKKSAh34A0y7fWqFeFSCCDQ9NCjS0um7aELU=;
        b=n8VPueuRToapn8hrMlPJwCXeGs2B71ERvve8PsjrMDzTwlY+8fX5Oacz2loKuLJv+K
         kYFSNtKuz9Wm2AuPXsI/k17XuOZjJIxuBpiiFwmU/JyQ2P1fzvBqn1vsmzO7cVUPyAZl
         xG8OFbR0o81+D8DZbCRGC/aUVjXX/fUEWcmONB3GeW2HIT+5+Gu28O2z6XRTziTGjy4S
         8cga7N40uVQ1RcAwRz3oxCeVJIkhFF6I32EOxPmqiRg+qyWZIWsS+q+s/FOwi3QUB9RM
         gUZI+kcPIJFGS1EBAIt7QAgHqeqZoCfVWbiaXxishNbeQKAVNfCUYXnpVZlQpc5s17R8
         afdg==
X-Gm-Message-State: AOAM532FS4ciQZa+mUJ4TMsSjpNtivQv0SbObVTL6IqdeXKdaiNzkT9D
        +EEoUnj74x8/NMdvQVEB0Qvm2U39Dp31cXmDH+s=
X-Google-Smtp-Source: ABdhPJxV8JcgHBRVCuZUtyiFEMUlo0/h++X44FtW2qB2tCICTzKUSkYLLhBJC1CobZF0GHS5kQiJ33VJWT9rFfULY+4=
X-Received: by 2002:a17:907:1629:b0:6fe:bfe2:5289 with SMTP id
 hb41-20020a170907162900b006febfe25289mr20427003ejc.723.1653510983236; Wed, 25
 May 2022 13:36:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a26b:0:0:0:0:0 with HTTP; Wed, 25 May 2022 13:36:22
 -0700 (PDT)
From:   Luisa Donstin <luisadonstin@gmail.com>
Date:   Wed, 25 May 2022 22:36:22 +0200
Message-ID: <CA+QBM2rV_0fKNiDG=fEY8SfdVPQSsqbcXQ4=Up56bumJMU+eOQ@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Luisa Donstin

luisadonstin@gmail.com









----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Luisa Donstin

luisadonstin@gmail.com
