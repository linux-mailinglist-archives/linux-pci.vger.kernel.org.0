Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BA44253C3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 15:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241180AbhJGNN7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhJGNN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 09:13:58 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45071C061570;
        Thu,  7 Oct 2021 06:12:05 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id p2so6662067vst.10;
        Thu, 07 Oct 2021 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uog13Y0nxNSntLqFwQzDK1WsEsK6sCbRFGV7b22RtpA=;
        b=h14Y3+WgcjryBj+wi/oa7fXDTLYMX6uUw9C9suUVobnKHnRetQQqAO2Hx7D2A/ssdn
         lNEuuaorla4KgR7jzz1DLrSgsMq4VgbkMyZsnFoX4xAXMBLcl5KErl4H3BedOwTqRc5n
         3G2Ciu+e6qbrGE/Le26bNeWKiPixaEKaAhibv8t52BYhFafQ9BxaV78bYMq2uDWuW9pE
         7aEAR6069C6QPq2RDwvU2LIguBrrWoJ9/ZZTNwrQaXmCHblQ4mlzgs31xfr5RutoNYg1
         RMiGT5OMXYFZlpBNWbjvT4dNyjZpi29ao0rZTkp348KCcnU2P0hj1u+p1CS4G2qmIBhJ
         W5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uog13Y0nxNSntLqFwQzDK1WsEsK6sCbRFGV7b22RtpA=;
        b=o8zEkaJ7+x3dEShzkCyL0TcyE6JmlZkVn0CeQKowArnzMfcTQtEMoshnfvj6RSmu+7
         dyNSXODr164CQFeQcPRC07pSGY5V2r+03V6NOtvLru9Zvm24/V9cel38WJ7dINI96Im0
         Uixn4YXO2Aw8P2bJjZGbKwIa7aCvfndT+y/UqTD3gc12T9njExss7C35T1NzPhqsFycl
         cpP+0h8sATGfWBeUHIXgpmkwnHicVQVApnEhsyOz7BQrHsSunT6bjldjJZnPaaUfani2
         LYxqFJqNwV5QQnYzyb6HaZWh9Yay+mCTWH1XW5Xz5JaRNiZBPpPIp3d0g284HbnO1/Wc
         aPgw==
X-Gm-Message-State: AOAM530nJSlK0aAt0pKnuKQczRvmKMle9qPEdk38TOMDF7geZxQSMb1N
        H16P+IYlo+T+euLl/IYKirPgaQIzlbC1xX5yqw==
X-Google-Smtp-Source: ABdhPJwUo2KdAbb9C5BHv85wimBbKc/zI4J9GVcMH3XJIg5D3Uz0B+LTFtK3EtqWmXfFtmLOE6+UuNQOuFN5TpisLW0=
X-Received: by 2002:a67:31d8:: with SMTP id x207mr3536363vsx.11.1633612322799;
 Thu, 07 Oct 2021 06:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
 <87ee8yquyi.wl-maz@kernel.org> <CALjTZvakX8Hz+ow3UeAuQiicVXtbkXEDFnHU-+n8Ts6i1LRyHQ@mail.gmail.com>
 <87bl41qkrh.wl-maz@kernel.org> <CALjTZvbsvsD6abpw0H5D4ngUXPrgM2mDV0DX5BQi0z8cd-yxzA@mail.gmail.com>
 <878rz5qbee.wl-maz@kernel.org>
In-Reply-To: <878rz5qbee.wl-maz@kernel.org>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 7 Oct 2021 14:11:51 +0100
Message-ID: <CALjTZvZZf25tqoQWM_HsBb84JgKpMKAxqfhUdpD_e5M-Bc_yzA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi again, Marc,

On Thu, 7 Oct 2021 at 13:15, Marc Zyngier <maz@kernel.org> wrote:
>
> 'Believe' is not a word I'd use. I know for a fact that all HW,
> whether it is present, past or future is only a pile of hacks.
>
> Given that your report tends to indicate that we fail to enable the
> interrupt for this device, this would be a possibility.

Heh. Guess what? The AHCI controller is lying throught its teeth. Your
hack fixes boot for me. Everything seems to be working, even with such
a big hammer.

Thanks,
Rui
