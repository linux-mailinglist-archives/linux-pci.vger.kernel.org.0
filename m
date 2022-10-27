Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20C760F95E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 15:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiJ0Nkc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 09:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbiJ0Nka (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 09:40:30 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05F564D1
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 06:40:27 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id y72so1993899yby.13
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=Ay8hBsxixTPgwpFvFws1Ul5kmArQl50SRuT9wHgYtj1JpuzxAF6xYRucKI+lmSvtof
         kGkjPpMNS4rOFWBvereEWTQcgAA0nKBw1mqIpTjj7H75Yle4BAB0WzhwQ1IsnnKWm+eo
         EkFbR/eR8tMqIrSVRiuuY9V/iYUE5G5LZFkn1qFEPSBx0FTz05N3AerT83P4guT9ytRM
         xKjg/xbqbAIn81UxzRv15c1tltZyaIP29ydx/xDLmqEQ7UbraN6Z2rQEjqDZ4PpkP2gQ
         nEpAap0lYS4S/Q6cLctCqvNvFBYumXd7QlbOCzWAv9kQfwcHnnD1apQptywJMnqbZ834
         GJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=rNzUmq9dCfypwpiZhFP2FXIGJug/s/2c9rJFlrIohZLxrfwzkBtUfh6B4Ye4vQ4LGq
         6n+Yd6KMQzONv5/+NIF7CcL4kUrClf2j5ij/CCtx49CDCJX32kLaPBtQWt6oz28zpuX0
         i3L0a0BGTigfij6s/GkLhh1U4bqG9AMe8OGaPiW8d8sq5vBlB51QxCUvoDbBOu0gSWEV
         KVJtDZUm/xHkrwDldNGny40quxktoXZU3eu9WcFMRnz5f3xQF+ZeqVMcG3PP6nRj1n5D
         TkPziTYJZn/2QVUx/lWdvzy+wbTHz4k1AJPsfWFuM56/OZ/d29h2ytFjodBJanESbzKj
         yxrQ==
X-Gm-Message-State: ACrzQf3OEmqdg4wugxW+JHeUQteGmBnbhfPuw0u8zaNJPm4wMifC2AqX
        NXLzbca8LhaSc7y1uBm+Qvr5ADwj8GuHmeKKSes=
X-Google-Smtp-Source: AMsMyM7gPdhZAT2NJhUzo4dJWjwyVXZhVTcAr/p2DEut+C8Tprv9ROZ9rl/8ZJc8yLj/C36qScsMhzJ2Nvqib4Fl61A=
X-Received: by 2002:a5b:84a:0:b0:67c:1db1:2069 with SMTP id
 v10-20020a5b084a000000b0067c1db12069mr43175448ybq.507.1666878026327; Thu, 27
 Oct 2022 06:40:26 -0700 (PDT)
MIME-Version: 1.0
Sender: chrisdickson3030@gmail.com
Received: by 2002:a05:6918:b290:b0:ef:f22f:8736 with HTTP; Thu, 27 Oct 2022
 06:40:25 -0700 (PDT)
From:   Chevronoil Corporation <corporationchevronoil@gmail.com>
Date:   Thu, 27 Oct 2022 14:40:25 +0100
X-Google-Sender-Auth: d_Qdi1Zvtdw5LRRaSQYQwthoKJQ
Message-ID: <CAJ3gWOAMJ7__jnkWXk0gBg8GxfRCKwJCsgCwP8BeX6dmWPSgvw@mail.gmail.com>
Subject: reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
