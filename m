Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609CF6B7381
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 11:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCMKNj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 06:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCMKNi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 06:13:38 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97D421955
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 03:13:37 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id y10so12551571qtj.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 03:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678702417;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZVkFn3YwdxEdThkVHM6Q9Cxc1dE09qwtEAvH/ySM1g=;
        b=eaKNeLSFMRuWsiHW2JAI8/x4gKVWhYH02r96+6xblH5Ge/4cvP8e299yGrio8fNeci
         grDvE4w+bcVOgYal2EjB9rYXTCe6rph93vxEwNjGG2ykKlSbTsLChVYmAoHyfT6K07uU
         LHKdjg5MEaDYxmcWT+cxqjnwtc/p8JC8zbUHnAr9a+frn3oBIzhzJrstAOPMVLND5b5f
         UgpA027Zp2Nzj1zv/rmZsJl1EvWvacP6LWf7hdjhXhAvaYk2aBampi0RrwtbSEqMne0L
         bDG2IZOi+T2F1jl9wV68oY0ENl3nqU22O0w2dcwS2e7wFDWOjjVggirFy7/l45/9QxUa
         doRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678702417;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZVkFn3YwdxEdThkVHM6Q9Cxc1dE09qwtEAvH/ySM1g=;
        b=EtCdV0j/1JWXfzw4r2n01/U+wrIDVMWPt/rwg164SKiyqbrcMcPx/7rBQiifZsTELp
         PBW+0ZLW1M5sVd44G9y76Rf0VMzKz9606KX1PQXfgoyLOZuuzwdvkTkCfBl0E4z8YEtN
         6H902vN4icej4jh/rDIikJZOQAeeHOBLQwkRFouWCMgzsc7rbL2/LFwyXKazZHM6aQ2a
         YAN1FtBQxHrpBbXhoEnMEE3vdF70IpkxZi2DcnF2yJoxz+AIlHoI/C+yzdGWlOryyNXI
         yPHLvmEgmkAzfFwhtHngFE3i5wto/uN8rrQ1nSRN8raA1XstaU0kVMdv0Q8egRNUSzhG
         f3Zw==
X-Gm-Message-State: AO0yUKUSeipxqXRxp9tH4Lh7xXx5hhMXWc8QsOrcFR6GuN30ekEHgSK/
        fxS7gSftfr6JDhHvI4QMFCqpa2hFiSiglXjuQ44=
X-Google-Smtp-Source: AK7set/Is7pkoxgF0LoYPaSBK74XTDNuGMqKid4zzELkMB5LarsED9Mc/bJoKi25gurxOb9nGEAGOAX81m0SawgsF2E=
X-Received: by 2002:ac8:40c3:0:b0:3c0:3c09:a4a4 with SMTP id
 f3-20020ac840c3000000b003c03c09a4a4mr5740093qtm.0.1678702417018; Mon, 13 Mar
 2023 03:13:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:420c:b0:597:e9b8:1226 with HTTP; Mon, 13 Mar 2023
 03:13:36 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <mamancherif2018@gmail.com>
Date:   Mon, 13 Mar 2023 10:13:36 +0000
Message-ID: <CAHTj9E7syt-9AGsRKB6BVi9o9Mm4uSDDYdixjQtMtk=PwmjnWQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:834 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6908]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mamancherif2018[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mamancherif2018[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylam28[at]gmail.com]
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

-- 
Hello,
Please did you receive my previous letter? write me back
