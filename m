Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2619293D3E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 15:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406945AbgJTNXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406939AbgJTNXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Oct 2020 09:23:13 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197D6C061755
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2020 06:23:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l2so2086511lfk.0
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2020 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOStyH/7LuatejjFDX2j2ehpEVwT4LckE9LJLX9gUUQ=;
        b=uB/FJSNOYhS3S8jPYL+7qgt2xhtyebbRsTieLjA3ZpFVNj5QvWgcYpE23lbGdj5YUu
         xi5Tye6w8MY5qq4xss3oy53fDj9NdTOaq+K+vyGy+qC4XN22/2shDP1uWJIIQn8jeNmR
         F67LVO4zmM+UCOwXGQtPLVLc17oEJcQYxPQPTWCT2rlaUmbGQJMAQeNFZ6Tks0k23coR
         uXPdvCwo3iOeWBNcUIjcWRhRR+vxRgLrhMooW3XrTkODH26F4VReK6jdn7vAJMGaqx1J
         UszwA+rzC0gyC064jfmy1+Um3u+ylyvFye1Vyefbm2W0M2h0ADkYVGSuFyfHSfzqrWJq
         0NIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOStyH/7LuatejjFDX2j2ehpEVwT4LckE9LJLX9gUUQ=;
        b=iEwDUWuHgVePNGmD96MqvlwCdkAMAF6DAJ0YPtb5gNN5CPXMQJWeKYIk3+B+ACwLEM
         qtBVu+zn3RTJdaphaPPslF10/rte7rQznxpsbINi9D8Z1qRn2+ZSQNwg98C3eTdk2cHM
         fHQa5BxbSH4kKLiZKeTOSf/gC31x5rAyUmWK+qGJBNp1zW01CXsdL1GSffbEjtfr1Ssq
         cJec8blamJkLOzdLU0wNJskefu1x+rkMJ6aCiYhcwzjk/2vPjXrXkjcyfqmVgABvJTDe
         i9RW8Ftt3Z+E4qbl10d3u1m6KE6ZGQKuvf89X3ncea+cC4eejjGlp+6MVvfzUJ3sO2T5
         yMJw==
X-Gm-Message-State: AOAM531QWGE4d6LzD51hxgfW4SnEoCjwPzDXO4YnQabMdwEoh9Nh62pC
        BG4yFZ+xWW8jFv6M/usZEkxF2VabWMJ2wYkcBc/dag==
X-Google-Smtp-Source: ABdhPJzPznNapkqemojFnILkXX7OUt5oTt6d2sBb3JZu/G5I1LLzfHt8+HHjGDSLE4PWGLbE/3TBZ8Va7tqZImbCJC0=
X-Received: by 2002:a19:191:: with SMTP id 139mr870209lfb.502.1603200191514;
 Tue, 20 Oct 2020 06:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201019190249.7825-1-trix@redhat.com>
In-Reply-To: <20201019190249.7825-1-trix@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Oct 2020 15:23:00 +0200
Message-ID: <CACRpkdb73_05OYb8Wu68+uw=p1edbnCfCSXOYL0fvDB2F=zL-Q@mail.gmail.com>
Subject: Re: [PATCH] pci: remove unneeded break
To:     trix@redhat.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 9:03 PM <trix@redhat.com> wrote:

> From: Tom Rix <trix@redhat.com>
>
> A break is not needed if it is preceded by a return
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
