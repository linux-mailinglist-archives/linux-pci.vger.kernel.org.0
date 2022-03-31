Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547D04EDBD6
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 16:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiCaOlm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 10:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbiCaOll (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 10:41:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC36947059
        for <linux-pci@vger.kernel.org>; Thu, 31 Mar 2022 07:39:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f3so21002250pfe.2
        for <linux-pci@vger.kernel.org>; Thu, 31 Mar 2022 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=iTaeiawKEZk0/eFi9bBuWQeUbtjwvfwa5sqi0dA4LBw=;
        b=TTQgqzqxmtpWrf4mi8nY3qoJbYUxIS9STYAUUdnhuzffqhkUgnz6WxEsPytqQ5UVJy
         3e8tCXaJ+ZQkG6U+tzJzoycDftzTZybv0KlDq+Qh0Bu7oEEUzoaXhMILt4+U/C1t1LW4
         tzzLG5rAxthL+bxxN3yGGCItYnZvBWWa2IpeZJB1KxjCzK5WA6vzO4Ct1/bSxTdkuEuc
         EBP3B9UDo4rZx+NE8yed7DNIye70AruK7Ygt2bYJESK3ll7j39ME5mLBHqJw8NXrnMuN
         Hbi32x7eRMb5QU52BZTg+g02U6ImVTcQwuceY4gsAYFZp6MrjB/Qr1KOhZNFEs+VhqMQ
         Cn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=iTaeiawKEZk0/eFi9bBuWQeUbtjwvfwa5sqi0dA4LBw=;
        b=d/U0MIIGG54QGFUrM9MOWEAgL4Eg5A1ul/oZyBnzRx5wU6knMpObLsF+iMvrKGA1Bg
         Hi56KD1jh8Q9W1N6InbKKsWQZDWqLqUHDRgM7rOhmhWOIDuggIk2bvIpr/Lu3McoQ8/w
         CqIImA9cqlSSHfPV9DPZ8yP5k09IXFcwWuEmRL59E45TAOJFC8xLks9uq/huZZ1eyMe+
         gQyiKOJQUH4wQd/HyMPVSxh5GYsGMJxLq2DIuuZMS7v6/hYmc5aUoI7188mzmzUgJ0mO
         ze7Vzu5erZxWJqaEi6f46olAEZvTvnESKd+YsbTJlINvWei26faAdB4qSOpDGbtvnVxb
         3Ynw==
X-Gm-Message-State: AOAM530VKw5b+ORx38Id3hqJQ4x33J3EsW388JR6FyIGa95e6sKKDpGJ
        NvWHwTLioGtKoMur3T+qjv3W/NAVRiWhexL7wkU=
X-Google-Smtp-Source: ABdhPJzAH3mjuqRqP0ZLZK1YJrhVa1tb5IlqfRydRtOlgzUXWTQ6gXMxYTrcDSLpLNBPts93nQO6AhUVoTcT+b5gsOo=
X-Received: by 2002:a63:28c:0:b0:380:9751:8135 with SMTP id
 134-20020a63028c000000b0038097518135mr10841904pgc.576.1648737593974; Thu, 31
 Mar 2022 07:39:53 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: mouhamadoudiagana123@gmail.com
Received: by 2002:a05:6a10:281f:0:0:0:0 with HTTP; Thu, 31 Mar 2022 07:39:53
 -0700 (PDT)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Thu, 31 Mar 2022 16:39:53 +0200
X-Google-Sender-Auth: ESlhvUX-1zM1qgZRWaQXow_FejY
Message-ID: <CAEzroUQJs7JhLX2PijiuxRsqGVsWmsUcwRX9U9W4pg3FaY2WvQ@mail.gmail.com>
Subject: URGENT.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mouhamadoudiagana123[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mouhamadoudiagana123[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
