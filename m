Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056785A463E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 11:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiH2Jke (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 05:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiH2Jkc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 05:40:32 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C252B27E
        for <linux-pci@vger.kernel.org>; Mon, 29 Aug 2022 02:40:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j14so6058lfu.4
        for <linux-pci@vger.kernel.org>; Mon, 29 Aug 2022 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=oPmA7RrQI5HlB/lsJpZ0ac2cM/Nq9dE/nN035HMAcpEerosptPl8/CXDYA0uDm5J+r
         9Zx/UYP+L8q2yCjb0rX0ATn8TELs8qUDGPTzDpDcoVKM4ZuuEgio7bqBM4xeQKPIAVEq
         j/3P45vSUyOnFvX1PeLPRHaHL6Hx/YoigVLLKVgKpB+oIXuJr62F0cCjVD1hXxrr4p0E
         8EFsKi+Q1FWrOgSXhvMYJt76pfVnZLRFR7cikxYzlD1U6AbbUUarjmzQgRKv5GD8HY3B
         7q3LLyYP6fO38Fftqw9oKIek5KRynYMLqQC6+bEWzn15rioFEs14d1fu27TjQi1GuW2f
         EiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=dq3LssOeKwF2Kc2DGHFB3BK4U33XGg3KFgG9s3S7ltVx842TbYWM6yEpmY8fg0WCPa
         danC1MM4ZtlRJi2wis0LsQ8BJpRa/U7k3vrQ1savDOYV194cy8hn/Qg8yeF+bVW+9Bu7
         mZTRnaMHvxjjQXGxT82EgEEHYPejxG+rZJDpLb6bGfBFKeaKTJG6oigRJSzzP9NYgAtN
         /lS22eaIddNKjsX+AvyWhOs9mBWb2juKprSibRs24oNZMc0LH59QPS5aoh0GUUm2HuzZ
         aZs9YgRBtp0FW+4XKlOwF6o7w+s9ER5QJvHL2ALO1Y86533yv57I5ZGaS9xWyQUNRxAe
         ro8A==
X-Gm-Message-State: ACgBeo0pAJaB6lYOlHkOdUv02NSBLvhgaiYeX8hYPTbycj+x1yc9gWGq
        8B/vHpz4ce3qe5/jtDyx4B9XtO876ivtggdpYA==
X-Google-Smtp-Source: AA6agR4xMfXwaAmOyqlfkdmlA6HmGvKkz7ijh2sAy7wyHmldppe9JaFIwwnoGOfyFHtidouq7r6aAE935EbH693MM7I=
X-Received: by 2002:a05:6512:3a84:b0:48c:f59e:3bff with SMTP id
 q4-20020a0565123a8400b0048cf59e3bffmr6805072lfu.516.1661766029265; Mon, 29
 Aug 2022 02:40:29 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: aliwattara1961@gmail.com
Received: by 2002:ab2:5e02:0:b0:155:3ad:499b with HTTP; Mon, 29 Aug 2022
 02:40:27 -0700 (PDT)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Mon, 29 Aug 2022 11:40:27 +0200
X-Google-Sender-Auth: 1QKqw5koKF8zswjXPEwMUO98K3Y
Message-ID: <CAFX=yDMEVN8n+Ngfscy_Pb98QTRTH6CJgQUzVdsQZmk23YLTSA@mail.gmail.com>
Subject: I am waiting to hear from you urgently.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:143 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aliwattara1961[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aliwattara1961[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
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
