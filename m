Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546B7E78EB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 20:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfJ1TGU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 15:06:20 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:33194 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfJ1TGU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 15:06:20 -0400
Received: by mail-yb1-f174.google.com with SMTP id e14so4000103ybk.0
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=beVWuOkeiY32I/o3JpuupSsozFTmuWYZW7DbSuh5C48=;
        b=stERljPwXnavTfjych+fungEGmOQa0Qyxvm003COVJfNnE0p/bnUgMOhTxS8tQhwmr
         ybzX8Y9+LwWH9s2wIY7WLLROP0rKV6ZNOgoCg4SdG2EEvvpa2oG3Pwekd6lsJ51w+/JX
         1b/N3+U2AM7ENs63YBGpL+whYEELBU/smJ7LeXCjeMaLg4/3IV8lhxJSgFTgtvOoqPHx
         epUAULEctSy9i6ajFYa5niVJhGoQID6CZzLAcD2eWdVLobFeXRiEQxs+t8GBCOhviTZr
         /KmXJFcWF0ag4+ze1JnPWwLOrMwGJDpRk9WLsI2V2JhtbL5kqqS8YblVlVQP977TLSQR
         ziQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=beVWuOkeiY32I/o3JpuupSsozFTmuWYZW7DbSuh5C48=;
        b=J5ms5OL0iMNqv3WBschG2eVtXMHvMz9tLo9Bhs/AX/Fc379LWlZlFvbYpcekuHlbmu
         6KaMbCu38rn5X2bvl1Q7gldBF2nR2QKhDK6jDxLZt9MKBEKRmc1BRX93OkGQxIOOEZsu
         lTCRnL7iGc795nrU8sQDOCLgbBXwpQZRb4YTvUDFUJhiBHLYjAEWFxZJ9msd1QoOI4S5
         Tf5vMOsYsEOduBkgGocXyUdURi9hmnLwviqYzLZjUUB0P4Qckx093TB36m+pVzHgN5Ed
         xqifR7BzfkNdVDiOlE7bwPWN4WyGUmwUts/fH1XTJG9OTq7hFCfNQzs4Jr14AqcreHt1
         qlJA==
X-Gm-Message-State: APjAAAWrTJh/wBKa47Ujcg/JwFhh19ykFqsq4/Z+OvaQ/SzxxcYGK/ej
        /8HjxF6h7maIrZUl7SDvRSpn9Wn943vfZvR7O8a60ZwU
X-Google-Smtp-Source: APXvYqw2JINJ/lN27t8j2ucX3Won+Pau0P4LqytyJ9SfbRTqndjgRghytnc8qKrE6vKIFqEP8fLasOBaXO8YceCom80=
X-Received: by 2002:a25:d98d:: with SMTP id q135mr14905166ybg.360.1572289579776;
 Mon, 28 Oct 2019 12:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QBN9C_o8HanAzXpDUN410g2o5+xfx64pbX3_VHVDKcj5N3kA@mail.gmail.com>
 <20191028171329.GA104845@google.com> <CA+QBN9DZyFynoUt+7sS_AcC-Wio-McJKCz8-RYfDWV0jv8iCzw@mail.gmail.com>
 <CABhMZUXADeHV+iUgFyDF+3BcQRFKDkMbwdkDAvBuYLd2XY=HCw@mail.gmail.com>
In-Reply-To: <CABhMZUXADeHV+iUgFyDF+3BcQRFKDkMbwdkDAvBuYLd2XY=HCw@mail.gmail.com>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Mon, 28 Oct 2019 19:06:00 +0100
Message-ID: <CA+QBN9Aj2he3RQMGaz21HD24gPk0R=bSX0cqVLj5PU4jK5Qrcg@mail.gmail.com>
Subject: Re: Oxford Semiconductor Ltd OX16PCI954 - weird dmesg
To:     bjorn@helgaas.com
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> What's your .config file?  The knowledge about the host bridge windows
> must be compiled in somewhere.

here it is

http://www.downthebunker.com/chunk_of/stuff/public/projects/sonoko-x11/router-board/kernel/k4.4.197-rb532.config

too long to be attached to this email

> The UARTs do not have DMA enabled (BusMaster-) in the lspci output, so
> they shouldn't be able to corrupt memory.  The NICs *do* have DMA
> enabled.  Does the problem still happen if you turn off the NIC
> drivers (via-rhine and ath9k, it looks like)?

I will recompile the kernel and re-test the router. It's a 48 hours burn-in test
