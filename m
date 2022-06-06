Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DBC53EBAA
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbiFFOQw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 10:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbiFFOQM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 10:16:12 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F732CDE7
        for <linux-pci@vger.kernel.org>; Mon,  6 Jun 2022 07:16:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id m20so29189204ejj.10
        for <linux-pci@vger.kernel.org>; Mon, 06 Jun 2022 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=pmbA1iWqCTPqL3PK3DU70I3lA83FW+vwJfzPPYwicLJuQIGRMc1NkqK8+EEpCd1ZnJ
         ZscKy70tnqYmadB0ed1W/FVbWhBpcdQxBjxHzWz5s3cKisawRE0hpcoN8wO+cXw25Sgq
         a+dbs3+l2LQnryOeqn4pDohmL00N8cDDoM8NG+t/2Z3GSuKZY/yyqMAOJ/+8Ia58Qnuf
         7pKWTrpDb7WwKBJtMeolT6e3wcdCw9nzmXbiWM+6ZD05nGmLHXRGq8/d619A97iq+fQW
         WxUXnJHWWrjYE8aM4kw0REiK9Rnj5FbAwKLQwfWdba5ksJEoQW3CFwhqA3KD/2ECksB3
         FwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=WeL7KxUPwiSwYsYR+vTknFb8TDhHsp/P6xO904B0T5z9lNBjZqp1uU4arQFQMC8qcZ
         uUNm9oqI+KhH6NIjdoEzimSB7fKz1nuswwyWBci+VRjlbsEcyS2g+l9XIdwJ4lYtQhYQ
         /Be6LYGtVjmv5PuB918tEIH55ySfnxEpu7r5TMKcaBmjZ7gTEnL24i7GFr/Dkt6qbHJq
         F7Ikv7Fv9wfpzOpH0Z9U4jzfJyFzkQbaCQSxQWeUs2wCKPZ6H6q0MIQfb+YamI7A/ey4
         l2oAIU4xXWw2MYNDtKMAe6WuRIDiRvG/MKJZxPac1Zup1FqwucIjCe9fOsY+KCG/wKvG
         +Yfw==
X-Gm-Message-State: AOAM530GCSN/oByJ1njTFj0nwDyzxF6tPG/Iwo1keI0466uoVCWnpN7O
        /s7di3MbbyC0uBG0At3O6dldH8t4gZ/YBFy3E/0=
X-Google-Smtp-Source: ABdhPJyVMFpciOb+JfeWb6J2LETUlOW28N8PdSS9jZrKCuorau16vUo/s/fH2FYdQafdl2mqtJbE1h1C+jEwczRy3eo=
X-Received: by 2002:a17:906:f8c3:b0:711:1be9:9e0b with SMTP id
 lh3-20020a170906f8c300b007111be99e0bmr10067778ejb.632.1654524967559; Mon, 06
 Jun 2022 07:16:07 -0700 (PDT)
MIME-Version: 1.0
Sender: barr.chrisdickson@gmail.com
Received: by 2002:a54:2448:0:0:0:0:0 with HTTP; Mon, 6 Jun 2022 07:16:06 -0700 (PDT)
From:   Chevronoil Corporation <corporationchevronoil@gmail.com>
Date:   Mon, 6 Jun 2022 15:16:06 +0100
X-Google-Sender-Auth: fQJpYF5uiVxsPuHc0oiqAi81-fQ
Message-ID: <CAKzjU5YRT5fSUzWOHe9fL5qe_hkLAcY0_cAbZC3j=gxpHcx_vw@mail.gmail.com>
Subject: update me if interested
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BEWARE, Real company doesn't ask for money, Chevron Oil and Gas United
States is employing now free flight ticket, if you are interested
reply with your Resume/CV.

Regards,
Mr Jack McDonald.
Chevron Corporation United USA.
