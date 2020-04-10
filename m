Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 577551A4642
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 14:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgDJMad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 08:30:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47047 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDJMad (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 08:30:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id m19so1226324lfq.13;
        Fri, 10 Apr 2020 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wxc7mReIW0I/9bGXTr0ixTFqsRHmu5x96+RkLeeN6c=;
        b=UhdOUThDXUsEVxm+BcFPoLrZbBISCqLbMnOIO/+ksl/iwGQHXK3T1IW0amcnMn/D7o
         b7WR7IVdaR1vh0IEOCs7T3aESfBr8WerWgHuOqOfwflaChJolVe2Q+1zMXQW3mwqvbkN
         hpa9JCs3OxbAtaB9qBquyWPyGIapVOVmhE5VzYsmd21eAqaHIXeZMlZ06TfMD/CMsKU5
         brdw62stUhFRn2sTkPcSf76O5ane6G7uKY+5oDpe/vwLH0R6CITKNsFX0iJL2PTjk6b5
         GZtH4lbj1RCvXIdLUmj70Y55HAF2B1rI6d4fJN459gL1mfBMRaXAq0AhE09Ux8rxpvBx
         VFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wxc7mReIW0I/9bGXTr0ixTFqsRHmu5x96+RkLeeN6c=;
        b=Y32xGH1IuMy/QAhLQGuQ9BKJsyuuumVoWcyAuuF3rr0o2xIIUczZSP1bilF9l/A2IY
         PjFmRn2zAV41mTblR29YLuLLJQdO6ky4iU7/zEq7r9/ctVJznRZqWuzoe9pxIugCbbZU
         Utv8ObYrsc+iJIukj3DJ5JAIKEZNNUr7QQpbx0eTUieldQQho/nUcrcTCZs1uTYG1QtE
         8gyy93DOEZDvTTgl1Svw6MjnIbptOwdmdaZ/TdMvxZi4bqgSM4wnS4b+TDvz9sSEif6B
         y37OeOoCagKTRhcoaEZfJEdqfGICASIsJlbW14oEE6xm7CTnrP/hn3U4fupOwuBTKtA2
         MFVg==
X-Gm-Message-State: AGi0PuaR9jU4mbrhrjcMd2pnETxpJcsEOvEHIFosbi4tpuibWc4Kw++y
        Lva1+3tDeq5jN9ieSqRjUN3IULzEeVX8CxwIDh8IjKGp
X-Google-Smtp-Source: APiQypKbT1f0FIBVJXC+bXz14yNA1I+1UT6w/M7bmkAigetfHQuvslFLulfIjNzdwy6W3aAIolbWZMQR+WwhVNs5wLc=
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr2456508lfo.69.1586521831805;
 Fri, 10 Apr 2020 05:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200410004738.19668-1-ansuelsmth@gmail.com> <20200410004738.19668-3-ansuelsmth@gmail.com>
 <CAOMZO5AKYO3xLsp4k6_fJCV9qW=rAtRKEGWnxksixU794dOw8A@mail.gmail.com> <003401d60f28$3d045190$b70cf4b0$@gmail.com>
In-Reply-To: <003401d60f28$3d045190$b70cf4b0$@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 10 Apr 2020 09:31:00 -0300
Message-ID: <CAOMZO5B+rEoQD_ujt9cx9VXO-i2oqfW2UN2cVeB5hZB3aVpGeQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drivers: pci: dwc: pci-imx6: update binding to
 generic name
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

On Fri, Apr 10, 2020 at 8:07 AM <ansuelsmth@gmail.com> wrote:

> so no chance of changing this?

Reading the commit log I don't see any explanation as to why you need
to change the current bindings.

What is the motivation for doing this? Is this really worth it?
