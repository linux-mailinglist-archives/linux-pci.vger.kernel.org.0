Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D183A9BB8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhFPNM3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 09:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbhFPNM2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 09:12:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1267C061574
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 06:10:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p17so4267040lfc.6
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGNuwZQqRaOoausFxnv/XUMccIKGMZGdfBPVc0+mfAE=;
        b=AD7/QnHISwpahHLbqrgSc+m4r7+D4iiE4Gn1olI4GyQtjp5FnbrpAPZsEdihkqhwJa
         xznQFxtdBgbWUnZ9pTfjJM7hli7Hn+IMDU12MWGj7FachMGx+GXpsXSl9ysuYwRLJEOr
         Nfdv8udkbUW9rN3wuZHavmKI2fzwr/qhINVRqo9caTLSDZ5mtAwHsUgqpsB8xa/JhrAa
         +iiiGiugljQpkUBHv7RzAW3vDOlzPSum3jkDa5Ze8qsyx1OtErDykw2VPsICUePw0djo
         KAYlZ7Dhq0+e9v4HwQcnUK4Wl6TCBEx845Y8VgiN8ILO23vMZWmRIxFC+uvtQRJhYNUI
         XRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGNuwZQqRaOoausFxnv/XUMccIKGMZGdfBPVc0+mfAE=;
        b=NSbRKZuFYGCoApqpvcc5UU1wX+y8RupO09bhxUFlKM2j2gP/9oLB5R5YE1h2LVvBtX
         KiCFlSanuf/5bzafRi9dRyDTtUKz+eFdSekQ9kz698YzOd1yvxdY69bsuMe4Nzbhpc/l
         o6v3ZjvI436zCR0wUqTGaKMIyOp4zPLvbKqBZH39iJfhVMAL5C2XwDlub8HTQeKiU5ol
         phUjstIznZ54iuqcsLuOikImdYYOKxyEmReB+0XxJXbU2b5lJHm5lq+ZanBjvAlLt2rh
         om0h1dyIGygYoPDhH7NTJysgq/7SB02imPX3tJYRnzBxshTBeV4fGCyVGhvTDPIEO1Xo
         VFQA==
X-Gm-Message-State: AOAM532VeOzB8vKoypxFqdD2f0a1PZLsxgQkkgKSfYGrRDa92Rt4plqq
        Usmx5mxBGWYD9sAO/H1sD8YD5TCQUxkQOxN/aaG2MA==
X-Google-Smtp-Source: ABdhPJyqZ4mRzNU+rFmgXfGsB7ysikDQ+RJWkL1jiJl3KEib882noFcSfMvbJUgyP4Z0Ckx+ijgvRpvW240VUBq2y2Y=
X-Received: by 2002:a19:c753:: with SMTP id x80mr3742877lff.586.1623849020081;
 Wed, 16 Jun 2021 06:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210615232425.1253281-1-linus.walleij@linaro.org>
In-Reply-To: <20210615232425.1253281-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Jun 2021 15:10:08 +0200
Message-ID: <CACRpkdZjr=Rakdga6RpyWu6Amf0UFkpTtQ=rZ3-7T4xua8ziJA@mail.gmail.com>
Subject: Re: [PATCH v6] PCI: ixp4xx: Add a new driver for IXP4xx
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 16, 2021 at 1:26 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> - Bjorn I understand you have a lot to do but could you give
>   this driver a quick look and ACK? Arnd and Lorenzo have
>   reviewed it already.

I realized that this should be enough for the host driver, sorry
for stressing. I will merge this through ARM SoC now.

Yours,
Linus Walleij
