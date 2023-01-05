Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A052A65F7EB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 00:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbjAEXxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 18:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjAEXxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 18:53:24 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF353C0C9
        for <linux-pci@vger.kernel.org>; Thu,  5 Jan 2023 15:53:23 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r72so16947iod.5
        for <linux-pci@vger.kernel.org>; Thu, 05 Jan 2023 15:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dUGG4xNbmHxqZEWk1QIkj1J4BmjM8dGcX1VYzdsWsY=;
        b=AkF8e5fzAZ2VeUWgeccokzgmGMkI/xbhVuZWko5E+WUCvTbBhrEKmFzqLouhvH+mff
         qSqo5/ZV3earTqKSCp3SucQw6ZEGAkuyiK3Va6Q3oXWSho1ztU5OiVZ3KGLnymu6SJyF
         yJYorrv3G2fCSumBtEidADBhZh5crz739IbFEP5+7NCyC5U+LgwrtBXkkrYFbt2jOXWq
         Y449etWueBSN1zELXIYwdt5uyRHikVqeb51i58uQwmdHeqEo3o44FSBxNW34TTRgo/m9
         jJH9mwbhak1aC6v/2dJ4HHsUFY3j5uoPORWHh05YdVfKLqkVjjUuMV7nkiWOtRDGTt9L
         MeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dUGG4xNbmHxqZEWk1QIkj1J4BmjM8dGcX1VYzdsWsY=;
        b=ePKSaKtCKjXe3+fF2HUTO/lCUn/sTnW9CCb+NT4sx7gFYsIZvWFBxBMV56kPOpboyT
         uJJ/o8yEVkB6Zjl07CSak4FSEXEIKGq+aPzWJivU3oMWlKRMnYofaQECp4XMDYbaG+5R
         MALC3VB+LTH8UKVidZ7363KzJTGF1IVRLyPPL8XVhbsfM1IdI2NqGtk3SyNU8GBhu/R8
         ePu4lvrR6dky/NNHouCwo5Ed4gyKgz0IWQKans2acj3HV+PuOLcsP+Uh+WQ8wjFXviGd
         u4WlL2NbvSpFCOm8BwGy1LH2WpRBEbIewWhYioLrrl5+OK/hPduGa+zVjyqMWM3O0sbH
         VS1w==
X-Gm-Message-State: AFqh2koLNoDQaEg/vvkol6UCmh+6WhYsCtjbeI747Q47x28Feuvgs/Ku
        rMCAqJmU/cHRYAJ6FhRa5FbiVg4U/hLkZLP6GYf13b3Lvvj5Leh/YmUqGg==
X-Google-Smtp-Source: AMrXdXvnfYaDhVS8foEMYOEQlITVPNRz/fxf/qtKT1wYa+88dUuBCAVEBsDcBAahaCKU6vtleoo7q7KppsH16zgzEeY=
X-Received: by 2002:a05:6602:110:b0:6e9:a169:c879 with SMTP id
 s16-20020a056602011000b006e9a169c879mr3296848iot.99.1672962309821; Thu, 05
 Jan 2023 15:45:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a92:c147:0:b0:304:bdf2:e728 with HTTP; Thu, 5 Jan 2023
 15:45:09 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <mcaitlin9999@gmail.com>
Date:   Fri, 6 Jan 2023 00:45:09 +0100
Message-ID: <CAPfBHRZD4pVvik6GendF69T3qA4ykoMKDEioXBhGmcT6ACQgxw@mail.gmail.com>
Subject: From Dr Ava Smith in United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-- 
Hello Dear,
My name is Dr Ava Smith.Am an English and French nationalities.
I will be waiting to get a response from you so i can tell you more
about my self and share so some photos too.
Thanks
Ava
