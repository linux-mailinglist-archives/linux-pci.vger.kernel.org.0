Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A43B3464
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhFXRLy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 13:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhFXRLw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 13:11:52 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F080C061766
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 10:09:31 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d9so9173097ioo.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=p95plxgcKdT8+TUJCmcKdAyJL6L8C+j3muAeTI6tbvEOMwKUFZvBH22Z3GEGxdnUZH
         d9XkDasjcz/bUj2n1PkWxPPQL/Sxtf1a7ckN43IkWwU4a9v6DYeOi9Tg8DPYHl700hH/
         xlmv54Ir2NUVB8zwaX1UsxTzP5GUW3mdywmszCeflzWKbXzDgkMNhx+qVsi3FklHnD5x
         fSDWvxz3POXOJ/0yZM+F2G99rPMTFJK+bPA5TWYu0VJpvpEjmQwRSgXLB6dx+kXpC0Uz
         JX+JhI0lSB7VkwJTdkbApCrUx6TGzp99N5mAm/d0lil4hmexz93RFAPSpMzmwkjNchKB
         rXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=b6pbFGMq3GZogQrOYrE7ouch5Ll2C2olMN0r1QdjlbstkdZT8SPxqthUwvGHJZjSLP
         ey6htMDCwnULIJ9dmPM1Rvr1e//1tfvJrocZ+oDDXnC9DpfnBqjYRZndIRNp2bphfdMn
         oyG7xg2K3KHTOC0pjOEuyI9TQyV1QGP5GqCkXbmVksQMX0LmJnJyPsKcGeeGK/wBaHhs
         TFB4qNropyh5IR15RRFLWcndJ1OhBYSs8sRrl+OqlDeC0HZja9lLTQEa6FmJmPDmBTEQ
         PHOQd8kOaIcaYOuuhcll9FG2RBviXRyVU5pNTeSGkpriGjbnkmfNYCamAgrsbFmuYPzz
         z9cA==
X-Gm-Message-State: AOAM530sy3Sr4CWzh1ozmBCsA2qbNe4S4pIoGAI01xu/14ztkIoIdfoZ
        6TLXBkVXHB7w01wcy9hyBFqcbpz/S9T5+QRQD6cTYCl8I5MbAw==
X-Google-Smtp-Source: ABdhPJzkYUuO368jts0QgMQyJe9SHzg0U698qd8KdfojEfYsXnHtwMfPGxVHmw7fwQ64+IhHRhAEJH5nusdeW4BWzcA=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr4098121ils.255.1624554560853;
 Thu, 24 Jun 2021 10:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3aa:0:0:0:0 with HTTP; Thu, 24 Jun 2021 10:09:20
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
References: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
From:   tuty woolgar <faridaamadoubas@gmail.com>
Date:   Thu, 24 Jun 2021 17:09:20 +0000
Message-ID: <CADB47+607zNBfYFb4bj0nUhuuYgAdwT=G_wJ9-EeV0ESHe56Jg@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,
