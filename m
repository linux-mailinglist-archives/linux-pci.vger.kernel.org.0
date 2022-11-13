Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7F2626FB2
	for <lists+linux-pci@lfdr.de>; Sun, 13 Nov 2022 14:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiKMNZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 08:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiKMNZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 08:25:58 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459C0F021
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 05:25:58 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13bd19c3b68so10010465fac.7
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 05:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+PAI4rgqgu8lkz8iluiDX4+RYG6mJwQ4g48BRbmTMI=;
        b=SAyPmAn226k9aGHA5xqcKLPu6K5IzJd+MGB7z2RcLWURtkbA4hQz/ZON4lnJ7tF462
         jt3/5J9mfu2EV7rwjOvpPkZoe59FTkdDf/K+naxDEX7J0LOuetih5b6L4aRoIIapkQt3
         oG8xJ3XbRPrvR2Pt9iN83ekIP17e55vSwFpuLokHYmk/inh3ifltPA7jJ3Jh2cG65kM5
         CWVpwB46MgOfZndq9JKa7BvGusflWDvqJzkwH0OU/NfXP6pwRHwuedXOSp+nNK3A+tv3
         LX+4+TOSoL9vhkKc+QQQAtM0pU619tue2kKDaY+HkckY94TNH/ioGfHDjzO+zfPG58Y+
         WfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+PAI4rgqgu8lkz8iluiDX4+RYG6mJwQ4g48BRbmTMI=;
        b=1DsbVyeGeZ/ZUemC1IHxTFgKDHLr+2yCAbVcuCa2/+CGQutxeqs0R5wtqSxJXKTajr
         Gfj5T/xK0nqqLIWzDrV6jMCGPmMjgU9xRy3qgNhajFSxTzw4jseX72Hmy0lPX6mxq3Lr
         PIPb3EJfDgMW7VVRspu+CT86cLvysIqtIdw2Mbq9RnXyO9Hzi001USRLbxGDvVbbjaHR
         WeDB+5AVWLzea0UfUeKbH96/PVQ5Zd7paVHX4ykPjoG9CCGyj+nYFqKYb0jgncJKFRSm
         WR6sOAWiwac1wr2tCGPf2SX0i2Ycihoktmsxraou3nCRZvyD2C3XQs4yh9iHDyrmMuQs
         ZCsw==
X-Gm-Message-State: ANoB5pnqadD6CZ0vX6bdAGDKbDpmqdc66tDlIldCQGDqZEa2+pcEYK02
        tIYDd10sBCU3ZlaCLsKS/VcLqn0ExsNjzm88Dvg=
X-Google-Smtp-Source: AA0mqf40QsY/+eBkbpZnc7320YXp8qgSZJIyS5L82NdBcdUoyAGpYOSRJZCzsHh2R3oZPPBbmGed+Vl+1/8Spn2Hd0M=
X-Received: by 2002:a05:6870:1e87:b0:137:5188:e062 with SMTP id
 pb7-20020a0568701e8700b001375188e062mr4901800oab.297.1668345957565; Sun, 13
 Nov 2022 05:25:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:41c1:0:0:0:0:0 with HTTP; Sun, 13 Nov 2022 05:25:57
 -0800 (PST)
Reply-To: illuminatiinitiationcenter8@gmail.com
From:   Garry Lee <ssekittojoseph48@gmail.com>
Date:   Sun, 13 Nov 2022 16:25:57 +0300
Message-ID: <CAHuu0JiFE6P=LMbxEhGixNTzR=sVWOTMFz6Nv7fe0AFnzQ7MgQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        UNDISC_FREEM,UPPERCASE_75_100 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [illuminatiinitiationcenter8[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ssekittojoseph48[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ssekittojoseph48[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
DO YOU WANT TO BE RICH AND FAMOUS? JOIN THE GREAT ILLUMINATI ORDER OF
RICHES, POWER/FAME  NOW AND ACHIEVE ALL YOUR DREAMS? IF YES EMAIL US :
MAIL: illuminatiinitiationcenter8@gmail.com

YOUR FULL NAME:
PHONE NUMBER :
COUNTRY :
GENDER:
