Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926F85533CB
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 15:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiFUNig (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 09:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350525AbiFUNiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 09:38:21 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E12C640
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 06:37:25 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i15so19655220ybp.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 06:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=L3g+rVsnzdNdQ4LV0YGmUUhA/xDt3he3cQVnKB6HYGVEAlzrru4amN8F167Xkx4Aj1
         pw6svDNdKx7N/yb2rkfBMX5Fz+RNPjkXbREeU9UhXRc5VHEOgLAFxazkzWJY0VoJbVOp
         xl1LzYtM8xT4xPGJGT+sanuhNNs/FNZlzTStHFEYh3EOQil8uKhKaAzBDurnVmbAHUNm
         hsTQVatHMRjFS8h4rKLQ9yCjGek1tdJ6qEtTObKOA+uJifOs8xauGx3tPmsBYjhxJgsc
         rLrm6C8Eew+sQ7rkJMa+YY6YONErAf+kWGuqT7PhAXkWZoafb4wu25dLAa7kf1bphVeJ
         +ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=mpdvgIsfuJ1nnASELCLKkjGuZIMKRltYwQ6Hc9aLRt3JfXQJzozM6zQTdR+rBNwBFN
         P/vDdfazjQFg34LkhVjOs8gtAY8/5M2QfCc1tN6Y7TumoL6jOA5101w5MuAyMii5I1nv
         pPGf9Rp/gsBE6ad6L88edDqNHPWN846FG/6cPCfMU6hoZj3MCUtTdaJvyvz3TbUVhshw
         Kq730p5SLISqSHOlSm+Xo5zPnDGxynROOkF2WAe7VuVxnTYWgqs/m8XP1s8p3+TJ3ZuO
         fWme5gpfjBY5TYRF7dFBGOU7+1CV9TVfrnlqCS+eqoBzpIivdeB8TX6qy+YSEwWlGSVx
         dDuw==
X-Gm-Message-State: AJIora89GJVdegQRZAAl4IKWhZZgWD7eRgQQR1BnRfvOE9Iv25e2WWY/
        G9qB90MvLLVTJTS/stZFiox0M2t6Hx7hxcILUB8=
X-Google-Smtp-Source: AGRyM1sI+duyYQWEIVC3ZTEopSg+JSglyw0c6oGqPlMj4yuTIk61f1w8Nqk3M8NVaqcg2+hoWtGfX9xpc08VAGK14Fc=
X-Received: by 2002:a05:6902:1085:b0:669:1652:9f23 with SMTP id
 v5-20020a056902108500b0066916529f23mr10993257ybu.465.1655818644394; Tue, 21
 Jun 2022 06:37:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:3ac1:0:0:0:0 with HTTP; Tue, 21 Jun 2022 06:37:24
 -0700 (PDT)
Reply-To: wen305147@gmail.com
From:   Tony Wen <ezzhejianghuayan@gmail.com>
Date:   Tue, 21 Jun 2022 21:37:24 +0800
Message-ID: <CAH7Y+CmBWmZHj0QGiy8iR5FCVgY-UMXMDpPw2cYzZ7iKT=DAdQ@mail.gmail.com>
Subject: services
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

Can I engage your services?
