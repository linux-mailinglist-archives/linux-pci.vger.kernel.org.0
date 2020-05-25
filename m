Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD251E0D71
	for <lists+linux-pci@lfdr.de>; Mon, 25 May 2020 13:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390152AbgEYLi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 May 2020 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390142AbgEYLi4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 May 2020 07:38:56 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BA8C061A0E
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2020 04:38:54 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h188so10357199lfd.7
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2020 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBa2LSmYu+IPWGoaF/9O6guywPiZMFZ32Kf+5yLy6GU=;
        b=TgFoBHoLwVPPaGKU6BhV9r1CviGBFvcclk6KZwXVz0HUKDXdISfheqqwBGaG14ujmR
         jXjohpIZ1lqK6WzX42WBvtMoG5LlLcGuv59CkIuk8vozWxnC45/vC82cOvJFpG5WeHmM
         I2Kyw+AnIgoSTo7ShHIAGbcvJbSS6RoovI/X6Ap+agiv3c1SMR5NhaLDLj2puV6MA21t
         Jds0QBLRdNnsDUZM8jQFp+x7oUCtbUgZ9fmn1U7aqnNc7WOV26wwxzZgobMXDyVzDWIT
         GNIvmTMpuyHiqb5fsjQAUcDt1CcigYhZ+p6LsswOM3XHkzFMD3o/zGqja9FaQiARNTYY
         A7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBa2LSmYu+IPWGoaF/9O6guywPiZMFZ32Kf+5yLy6GU=;
        b=oj0ixQ6OJioSALNhcIMEnpvFLO3MKiL0DiV7Tqb1O9g7DJzzd7NCR1YtxsVV7+FRjO
         DeWkwl3LCtLK4C0BPEgn0J3s4imwaB8+U7Xqpj+Qh9AcRAzQgrLOMDjLodGzw4V7tscG
         1FTowyeDpEepIuq5uY0TK2amRjOU7RDT6LM+T0WT2G5VQ60KEkthkX1cQTCXyL7fVlzA
         YXZgpSR/gKP/xXldMRkfTF61pU6M0U8z2Uq55x2bl5mC7T93aNGoi6l22gT9NpoPSQRJ
         2hEPuyePXA/MwWvDribZsrt0zNHCtk4HmJbDXbT3q22v3ScpxNprZgUgfZ0S3XgsDCXQ
         sawg==
X-Gm-Message-State: AOAM533v/QXctGMVlDg2P9MEgF3HAndPTNEwSXYgY8dM3xqz1VKSnsQB
        K05+OlbS3Iz5mGa0vXgIbmF4tXs03+LJpKueRF8TWw==
X-Google-Smtp-Source: ABdhPJz+FkcbPi11VJu3LgfkrTe0cXWtOkBWtTFSrQTStJdpts2GmEXjlF/K+BUQThYfOfPoiwz6DTUyyg0qROlwY+M=
X-Received: by 2002:a19:be87:: with SMTP id o129mr10647413lff.217.1590406733156;
 Mon, 25 May 2020 04:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200522234832.954484-1-robh@kernel.org> <20200522234832.954484-8-robh@kernel.org>
In-Reply-To: <20200522234832.954484-8-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 13:38:42 +0200
Message-ID: <CACRpkdbQv7AOBDtGxzMuT_Y3XFysZLyL5hQVzAxiXgFKbVQnVw@mail.gmail.com>
Subject: Re: [PATCH 07/15] PCI: v3: Use pci_host_probe() to register host
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 23, 2020 at 1:48 AM Rob Herring <robh@kernel.org> wrote:

> The v3 host driver does the same host registration and bus scanning
> calls as pci_host_probe, so let's use it instead.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Sweet!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
