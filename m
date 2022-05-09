Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5051F81E
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 11:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiEIJbo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiEIJJz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 05:09:55 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A9A15FE25
        for <linux-pci@vger.kernel.org>; Mon,  9 May 2022 02:06:01 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id e17so9968026qvj.11
        for <linux-pci@vger.kernel.org>; Mon, 09 May 2022 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ZEKTenIZ2FZGbVvXbK6R3bSGQKZjKfnDEXc7amdyUIY=;
        b=jhsdta3KvmD1HAGJl85dA1GIx2fCrYnNNpaf91dYo2hfzFo6CMEMQRuOidZUF+ctDE
         nUbou77ALrDT89FlAddgvAVRupHX/ndntB+sbPm2mXCwTu0cl2CLGAn8ihLTNJ2FLtAM
         a7yI+NpbtqnCUfqq1a4Ai6opNjDvGU5VqkYHn7SHZx5LIcZHR9M7LDIxPiicQVi6H5hc
         4A5VA2ZnZ/PSycK+l32IwomL0juco5Q1eLh9R7QjmTKn1xUKAeQosOedXsMojt/bzXlW
         ZVv9W5rbBPbtW0r+6LfaF6d/Xo6QKmyM9GrOsH+aDwitIwaLW1ELM6OHzR6lSHBIk6hl
         vT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ZEKTenIZ2FZGbVvXbK6R3bSGQKZjKfnDEXc7amdyUIY=;
        b=p2naXp004cpQx8e0Ejeb2q16aQO1RVH7bwlbuQDXjwh3cVeOHm/6++1NmRJfOUlBFd
         0oBG6ppjE9vgVR5PuU5upoRzPndVwTT+g+PehNCqFz9R2ZQzrIVINPknUI9yO9k3W/uP
         QyYq8Y/UQfYgndAn3DgdfesiA5wOIs1a5pP8arSskFqvF9xG/xWnO+uRwDL/0g+PeOUO
         FNFFcOH0SRN58X+sP78HtUq0Urr79v+ES1kdcCP/wCFWRBLGfl1CxgdTF7Z3+0J33RTE
         NDY1ABkeEDrPpdv9ZFt04qE/w93ksjfNzhJW40E8MNL7y6HgFFwyjCz3Rp9wselrRhme
         sYvw==
X-Gm-Message-State: AOAM532fbHBbaHxvqU8j3zxaWIXPu84iwbpUbJLcYXzQA+h86p0jIbNP
        Jmz3oha4n/mP8v63yiZRl7y/GXs+RIY7D296xP4=
X-Google-Smtp-Source: ABdhPJwU96AhfE8L11TJjVM+90LjFs7iubNl4kwuOsuJEYaexpM52PaaVQyK9OsT4nyvusOWzDWajchfDmoVIFbdBsY=
X-Received: by 2002:a0c:d80e:0:b0:456:31a1:fa52 with SMTP id
 h14-20020a0cd80e000000b0045631a1fa52mr12268715qvj.109.1652087148427; Mon, 09
 May 2022 02:05:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:b6f:0:0:0:0 with HTTP; Mon, 9 May 2022 02:05:48
 -0700 (PDT)
Reply-To: mamastar33m@gmail.com
From:   "Mrs. LENNY" <mrs.hellen.oudragou001@gmail.com>
Date:   Mon, 9 May 2022 09:05:48 +0000
Message-ID: <CAPAQ3b+CfJp=sUTQ1b4rY15BwoaYU+HSiub9Ed2j50JxGgw3oQ@mail.gmail.com>
Subject: Let Us Work
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.hellen.oudragou001[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrs.hellen.oudragou001[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Good Day


With due respect and trust, please exercise a little patience and read
through my letter. I feel quite safe dealing with you in this
important business, you have to believe me and let us work together. I
have a business to discuss with you,  just let me know you received it
and I will tell you more about this 10.6 million business which will
benefit the both of us.

Reply and send this information to me at: mamastar33m@gmail.com

Your full Name.................
Age.......................
Country....................

Thanks and I look forward to reading from you soon.
Warm Regard
