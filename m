Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA084BE671
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 19:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379795AbiBUQB0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 11:01:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379778AbiBUQBZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 11:01:25 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2CE29C96
        for <linux-pci@vger.kernel.org>; Mon, 21 Feb 2022 08:01:02 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id z7so8316315oid.4
        for <linux-pci@vger.kernel.org>; Mon, 21 Feb 2022 08:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=y64+VC8Mgc+7xLtQx8Vjk6DPzLFEm/vLhk2ICQjTjkI=;
        b=JuvUdzCXSDq4oyF2Q6JB6G+3wi2PeRY/j6rCLWhHQx6W9ZpOlXx7s4dqDqpZpadtWP
         J1grBg2k7XQudciKQj0Afn0mq6VORFFPP1wyf5wcuPRBzehJdgg+AKr+inborsLnYlVP
         M8XlZgS7NN0HLZVoGKs/IpXUa8rs3lXnwWhSW1IA6Ha1dEAkDX9r6vCqYMNmawv391AJ
         aYcdBDwmOEZfq5JRdU7qcj8G6SURvbzQfuJHupIjhfQlFxZJ93QSf/qNFW+Cp+IVfLJ2
         XLMcw2FdsDdMNqzS+cJPNo1Y1Pm8YgZNra9Dsq1V1M2LdgFVJ+gCP0NNux53mLYQlbvj
         VoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=y64+VC8Mgc+7xLtQx8Vjk6DPzLFEm/vLhk2ICQjTjkI=;
        b=dzuA3JY5t0E16Rk5nIzM7DRHICK9ZFpHFQyI2PgEWJxPO0LACJcsWC5502nSmJ4r9o
         UGoj1W5wkVlfnSEZbb7ooeSPhH/YiIjx9FMYcFbSNZs0zInJgqEoTJIbCo9lDFkiLnm6
         zfX+voM8Kai9ojZDerEGQnApNwlaufs+zPyMYrMS2g/mo0n+ez63SWTZFTUE43fXyQlA
         N5TxY6Qnxa4Si2Tpvy85DYaAzW1+3eJbNucnMEMUTCoPpOGthngRVUeV2kYqOwILS6xC
         Co0/kwHf5s92WXgCoJqU3AwaOP+rXtsEFBaDcFzLEkAs0H6N9LJR41OCD8bIc/0YGX2N
         8ZYg==
X-Gm-Message-State: AOAM530o9wbsxKfaA74FRRdvmGcwLz0w+x0h+EJNoJOfWb8+IlXl8j3F
        AZ44Fzr7IaqXSPcyKqOyyQk6LOfD37gXPmARKfY=
X-Google-Smtp-Source: ABdhPJydcclHj+wwX2IPJ3kcZlIi20OJ4JJUR6wkVRV3elRWBmoDY0N4XK03W01EWR9BmigA3jGnGBRbemKKjlRE+qc=
X-Received: by 2002:a05:6808:d4e:b0:2ce:1168:bdf9 with SMTP id
 w14-20020a0568080d4e00b002ce1168bdf9mr10697202oik.131.1645459262115; Mon, 21
 Feb 2022 08:01:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:ca17:0:0:0:0:0 with HTTP; Mon, 21 Feb 2022 08:01:01
 -0800 (PST)
Reply-To: cj262515@gmail.com
From:   Emmanuel PATRICK <joyamara34@gmail.com>
Date:   Mon, 21 Feb 2022 09:01:01 -0700
Message-ID: <CADcb7F4DCm=sJtLMi2rzeJ8cEvxzPrRNM7-_5PBDwYgCqBfGXw@mail.gmail.com>
Subject: SPENDE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UPPERCASE_75_100 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:230 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [joyamara34[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [cj262515[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [joyamara34[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Guten Tag Herr/Frau

IHR E-MAIL-KONTO WURDE F=C3=9CR EINE SPENDE IN H=C3=96HE VON 3.500.000,00 $=
 F=C3=9CR
WOHLT=C3=84TIGKEIT AUSGEW=C3=84HLT. BITTE KONTAKTIEREN SIE UNS F=C3=9CR WEI=
TERE
INFORMATIONEN UNTER: cj262515@gmail.com

DANKE

CHARLES JACSKON
