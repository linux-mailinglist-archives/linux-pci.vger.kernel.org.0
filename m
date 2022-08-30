Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6145A5F85
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 11:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiH3Jdw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 05:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiH3Jct (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 05:32:49 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258AE097C
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 02:32:30 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11eb44f520dso11115417fac.10
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=e/OUCbpppOCXkEP0VccElu5zr3Hk/CBS9pP79HrpXVw=;
        b=cCmtq8G4ZzuuyGvIRd+OZjTfd4ttDfmOwDnDDnKgaOuymoSsdHfXq9LmaLnLz8gkuL
         1mpHnZViW57orNpXev+zMqXxnY/Xzk4TbiOcg4T7RpIG18EK1m8J0fYAlGp80ubFbobB
         Y4m2x8b1iiy1IP1oboFO6NTzQrCDc4BjFlL9PBu2fYZQbLuVMePjKSSiUlnKtoToD0MU
         c/FG3ac1wfbcB/qut5BmYoRDpkVNJW1H+YqEr2FRTbcg1SeN9WoCnFPQYODMkH+diht1
         iFcTSyFp7t1pdjdahfPC0UFfxQQgXKqB06ha++Mx8Phh1MVPiGQhy3k3cXlJ5PyZ2NBP
         bneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=e/OUCbpppOCXkEP0VccElu5zr3Hk/CBS9pP79HrpXVw=;
        b=QzBzNoi7gghCI5U1cnpE9oX6zeBUOXR8PppdHxvxr3zCOQblTIqkJYJXEfN5v7wLRe
         P8+LsTv6G1ouKCQTJFnV+Ve87nXAZwcNCn4qESGZuaGR+qesf1QnApgoYg9/5SopuwCu
         jcS3nHbiQtFqljSOpvnF04OdKzD8K9So4oDAPs2i6kT3LE1/1wEsf6ZfPBnMKfwFI4bL
         T8aavESW8hm5fD8jAedNXXQNHF8wSh4jmdXfxpvAlrpHGChNf9/wP3z5ZTKibduA2fnM
         WIN1U/N8sjgBdjQPTncX18Q0K8AmsGLSbypV4/aeIi8cJvoeS9UqXDJXwNZ0EnmG8ygT
         1jkw==
X-Gm-Message-State: ACgBeo1VadyGYP0MqBxHd4nB6Bv4ZycYkisgzKdYRwOAiQo8ZVdex4Ob
        yT5NplUuGhRIhRXDtdkDOsTQP1shoh4NIUV4370=
X-Google-Smtp-Source: AA6agR6lcnUGeqsgFH+rdDeKay9dAeFaN2lFTKSLuIrgPQOCgpYlv9O7Ze6IwVb2TD8a7AlyvkZq5dxlptPDN3LqHkk=
X-Received: by 2002:a05:6870:2402:b0:11c:eb96:77be with SMTP id
 n2-20020a056870240200b0011ceb9677bemr10058357oap.67.1661851946240; Tue, 30
 Aug 2022 02:32:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:6584:b0:b2:b333:2bf8 with HTTP; Tue, 30 Aug 2022
 02:32:25 -0700 (PDT)
Reply-To: mariandavies488@gmail.com
From:   Marian Davies <abigailbamidele18@gmail.com>
Date:   Tue, 30 Aug 2022 09:32:25 +0000
Message-ID: <CANp45DtbYisP=hFVD27f4sLknV4hH=DgSgSS+n-xEHAkQBuAdQ@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:30 listed in]
        [list.dnswl.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abigailbamidele18[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mariandavies488[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [abigailbamidele18[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
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

-- 
Hello did you got my email
