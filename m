Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FF337526A
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 12:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhEFKfR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 06:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhEFKfR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 May 2021 06:35:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F46EC061574
        for <linux-pci@vger.kernel.org>; Thu,  6 May 2021 03:34:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s25so6447986lji.0
        for <linux-pci@vger.kernel.org>; Thu, 06 May 2021 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3KLkYBFsofChn+lS15nN2i5bg+8i29iwMp/4rAWHzQ=;
        b=K8s9RIT5uZ0IYcNbNpYltbFW1zrnBLdH/nVFQtyMvvGj4N3XDa7hGb3tuTDMchCnWS
         16t6jqOV69l8yZnZXlmbzCU8AsTcf6lmwRIUKtohOI0QqbEqwuKYxUvKier0WLY9I3wk
         yFUuulYTpXWHouOUjMRI/2q2+9WoLUirUmgdP5FbKroFXsBRmsyvUrFT7iEtv3bRbTbu
         QmRDK9QaUKgH6S3FT1Zci83VZCiiUoA7MY5Y/7oxD0X1m7jGAMK341iAr8cv6/KEgFkU
         NuqQT7k1TppGG4uPubdVXk7djqbw00JBJ4+X5LZBlE8hnL7CYYGtMtEymCkmBegjBusV
         UgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3KLkYBFsofChn+lS15nN2i5bg+8i29iwMp/4rAWHzQ=;
        b=t23oqCZxPLAaS9S+2RqZHYIuSqtxIlL9Utym9zRij/fkpXAcQ+SYHmEC3aAdy5VFxm
         ncGWQ+oxYCC4nHVbrTRKVFFUqZ5FGYQdqMZsMZklUPEc6uup32PSeKM8cEFRZYt8IupQ
         RaxF3nIRqHmjeTt7dRNlgQex1CmE1f7SGLlymXqqLf/nW2cD6dP1QCG8FSLLX/r946Cn
         plRsAoJNczyWkw2yZKNYLdw3qiVKeLt0VPBy3oKfr+Sv6VEn8IRM+kx1mc4rF+mLpJ5D
         qBUZR6EueLDkjJGj7jjiqVgQXGHXwuBr5QeYETE69aoDAlyIIBrwvIwjV6toIW9IuKO1
         zCZw==
X-Gm-Message-State: AOAM533Sr3hf3DE8WqUPp00GEwR6/KO6oZSUAY/93kphVzIBxs/s9vDR
        tJJRSrh40fVQu2M21L+08G+qkiIWbxAKrZtSbWFdqg==
X-Google-Smtp-Source: ABdhPJzvHV7/TpZtQYGF6Ts1NjriQprD04BKXjy+KZ0xnfbcTqAF9RfKrT0CWX5+dXyz7rl7ak9NRMi5cvsfl32PpAA=
X-Received: by 2002:a2e:a54c:: with SMTP id e12mr2849488ljn.326.1620297257402;
 Thu, 06 May 2021 03:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210503185228.1518131-1-clabbe@baylibre.com> <20210503185228.1518131-2-clabbe@baylibre.com>
In-Reply-To: <20210503185228.1518131-2-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 12:34:06 +0200
Message-ID: <CACRpkdYZQcbJju_t-tVv2+uGQaf9MUCoAE4YXPNoLW1R2mMWQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: gemini: add device_type on pci
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 3, 2021 at 8:52 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> Fixes DT warning on pci node by adding the missing device_type.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Thanks, patch applied!

This is even required for port-mapped IO-space to work
I think, but nothing uses that so that's why I didn't notice.

Yours,
Linus Walleij
