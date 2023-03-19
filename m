Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726CA6BFFA2
	for <lists+linux-pci@lfdr.de>; Sun, 19 Mar 2023 07:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCSGyf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Mar 2023 02:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCSGyd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Mar 2023 02:54:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3D314221
        for <linux-pci@vger.kernel.org>; Sat, 18 Mar 2023 23:54:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s8so11021720lfr.8
        for <linux-pci@vger.kernel.org>; Sat, 18 Mar 2023 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679208870;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Am4l6xMhb1vP5dilYwx3GXsl0GLDDzlZh+2OHdXw3E=;
        b=jHwLr3d3tfSfSY5brG9FEb6LXckikCO/w0wknkisEy66EI41JLKjD/R5/6bsVw74pV
         k+EuA/L6HfLhbgvNWht2qbeo6TwbjIg96YXUF2g0yUVK0zXn9PziYNg2cO1OuAlETGGm
         pVHXYfIMXrNkyHlYCzbSeN6XlRQLbvTHsI3YWUXn00LkTB9KPhlQjdnNqjFz/SNbpzR1
         e/bGjCYKUv88WjKKAZV9Rb4h0kw9qpnU3jWQHwd/rhz+9hwHGfUILNTKl/X0BUW2IuUv
         rDp0WQ17NC6KhHkMLHCuvaJSbYX+Yur13+74Wm1Lo6fLGUhK3PYT4mZ4zZCV8BCLMGqQ
         qP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679208870;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Am4l6xMhb1vP5dilYwx3GXsl0GLDDzlZh+2OHdXw3E=;
        b=IKEMKmWb1SoO1OTVQbWRtIpEiyE54VkZeisAImWljiG2SkWdKpVsMrcAzgOSW22ZiC
         kKD43ulQC0it80qaqUdrR3Ce9jrlFMPfziqL3xDwifBtDVB8HVjgnCW/OgMo+TNp9SbH
         24WJNMVBpX5UvLStz+KOkDUqbM3iR1im2/CdhKzidqv2+a/lfDM5/Dih79ndLIVy8KnT
         jytSZQ6SzdkoHeJovpSh6GWf6+01THQwntIVR0Ww3VZeGYeOVPMfvQ67QsYcpwl9fOhx
         QohzVEov05pq/CZ0kf82ZSByuEoMsF6CnC6jP21A4L5YUrzUDBUI7Kkpw+2ScryTL7Rp
         DAew==
X-Gm-Message-State: AO0yUKXD/iACM79jp4WFfSmlpqRg1NZl2QYLNJYs4LSUchUL9iLISBvN
        KADjjYl9EKmCtLqPNttop6BR0WUd0v/VNBjNYSc=
X-Google-Smtp-Source: AK7set/Z8+uGutwHfmytrf0928c3GZs67x3+psLhYrCwN/mO0Ba+DaCvejQtCzb8k6I7MiMoZukfdCahmX1sibVkSV4=
X-Received: by 2002:ac2:46fb:0:b0:4e9:74fe:91b8 with SMTP id
 q27-20020ac246fb000000b004e974fe91b8mr2003021lfo.6.1679208870366; Sat, 18 Mar
 2023 23:54:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:3847:b0:24f:6912:1b1f with HTTP; Sat, 18 Mar 2023
 23:54:29 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <maguettebadiane93@gmail.com>
Date:   Sun, 19 Mar 2023 06:54:29 +0000
Message-ID: <CA+YZjr7saB3M9YAwve7U4yJF8u2mrO+hNFAqPFc=bj3x7gv7TQ@mail.gmail.com>
Subject: HOW ARE YOU?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:136 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [maguettebadiane93[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [maguettebadiane93[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please are you capable for investment in your country. i
need serious investment project with good background, kindly connect
me to discuss details immediately. i will appreciate you to contact me
on this email address Thanks and awaiting your quick response,

Yours
Amos,
