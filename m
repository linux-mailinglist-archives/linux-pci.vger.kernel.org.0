Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF3E4C8B39
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 13:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiCAMFq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 07:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiCAMFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 07:05:46 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBBA8A6F9
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 04:05:05 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id c1so14235433pgk.11
        for <linux-pci@vger.kernel.org>; Tue, 01 Mar 2022 04:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=Tg0u1BcMkcrQ5oCWdVLlVtKu6n/dJivEtpc6Ue4+Jyw4ir2qtSN2EFSPlFVFd7SdRl
         jnkov5ikRhpS6SAVd6dDCcp8eP0rCQgEVgNWB19egrPyeZoIq8yB4MU/P598SN0m6+S7
         HHNv5f1LFKrUuhelYrMBcpMidG8yApaIVKlqToNQwBbiskBmpnciA0FOT0385xykJKsa
         ODgz2rRztKrwiGQcEBg7/zW40GMYb/iNSfA6p4Ax1ukpOeddQocSA2vOe3SmFmvZm3Uj
         WCwHAm+4lcPqqNk2ZRGysgMv4jScRP2J/2jnLLol/MbElYAZt5vXVWSNutcjTtN3NuyG
         /xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=UwyrkOhW5HX9WZnEH6wcUz870c9BXPuoepDxu0mppyd5PVsEB6slFtOBAal7ZesY3X
         Ay/ewjBElkil63hEVYcr2mi0rmnIIZRU1YRNdil7S2wAs43fXMG/7sOuu4je3YhdT08m
         GBV/voy4j9UzzQrRy2wdHeC4+EfZQMcC8tCljsSvbb1PI9D/VDpzLrj/18z0b6zAnU8f
         L1C+Wf+1M9TTUwt9V5IiqbNqkKm1Jazp0D+7SmHqcoc7DzLDyVu+eI3wmIItB+vTEJas
         oPvSiuhja1H9ogQV9rQBt0U8aPTi2HJLcU4dS0+jiVIzSEsSP/8RwUgRNxHI9gY3LPYG
         QbCQ==
X-Gm-Message-State: AOAM533QOKkjBaKXWvDi3joTyzMH1Yw4EVPu9iq63h6yPwbGJ5iRPLOm
        cZ4QyPydXo1eKsLk09UIUCEL90inrJGdwgzzFv0=
X-Google-Smtp-Source: ABdhPJzvsG8+SM4sh/25GWnzLzL15pKuPWAYKa2aP9gmBzBW6Y1AXgbzbreCO9U22ZeTCWIbXhy6lAY2X0AWt7Ghw68=
X-Received: by 2002:a63:be0e:0:b0:363:e0be:613f with SMTP id
 l14-20020a63be0e000000b00363e0be613fmr21309057pgf.448.1646136304480; Tue, 01
 Mar 2022 04:05:04 -0800 (PST)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: sabu7439@gmail.com
Received: by 2002:a17:90b:3749:0:0:0:0 with HTTP; Tue, 1 Mar 2022 04:05:03
 -0800 (PST)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Tue, 1 Mar 2022 13:05:03 +0100
X-Google-Sender-Auth: HHNN5At7GSe_XTKAVQanmHrMpcE
Message-ID: <CAOJFtj1XwynksDFy-yXdjp1tg83AfaQfNX8WdJfAij7DBjLd4w@mail.gmail.com>
Subject: Greetings to you.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
