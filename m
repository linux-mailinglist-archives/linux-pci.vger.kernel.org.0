Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268D0423D19
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 13:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbhJFLqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 07:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbhJFLqf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Oct 2021 07:46:35 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF212C061749;
        Wed,  6 Oct 2021 04:44:43 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id 66so2527363vsd.11;
        Wed, 06 Oct 2021 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3juZIQZX9GCwI+vuBcZtPyTvOv/zI5cPebq0aQINMck=;
        b=iR19eqT+qQlN2QaO7EN/0Ycr41m4CosSkJJyr5eW4oPSmnsetGPIYf7I/EtAHpiz/i
         OBHfEqf0vMCsLRVeS2viJAn8O7/NLQIyUTiXVNwVa+Na5i39bQYeZcE8rTzk4BJpmA0F
         0pT3NxDLVKD/BLnjlyAZ7TjwdWlDrLbQ4pSMH3JonuFIzxJJDQiJqgdhNZ8b507NaU8h
         wPbiuUNr1zLqcG+iICWuN7F0nKpEiRUfY/8mtF/1USFbykfo2yxg52nEDs8fZSRCI/Lw
         W+Jm66zWJqd4jPkcMI8eq32eAMvUxXs/W1s61Cu1cfLM0qTQihlXllp2IxREBu8n76gx
         4qAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3juZIQZX9GCwI+vuBcZtPyTvOv/zI5cPebq0aQINMck=;
        b=WABRC9sZhE2Xkc/frZUOcMFABPCSV4d8V9Ra5CriAWc4SbiYCcBw52LIGcxG/setHg
         ayBi/J9BToJd0NQTUuyLuLiuxNC1OawUjH6H44xAyPlj5S8X+z41FzlF4YYLZJYIJBtK
         y2xv/HW15KJ18ovSUScjgJ7jTEp9XnwPYnYpm8A4cK/axERL0G9E+eTk7F2ZIXShoUpB
         zQ0S5SkmxJO2gLNmkGkiSqJIBkBfoeGH5Lpfj2TdRDoAoIEqwD+vvvsIx6bNuieOiWkF
         EKOnzecuJ3Q17zqwVpfl/x5Ol6urld3c5SXb7xSkrv6n2LbrawznA397ruBbVR7W3cH5
         wrAA==
X-Gm-Message-State: AOAM5314mfCCmB+TTIumGMrrFevnl3UmauBfzvcliXkO8hWKAFLVB52k
        05eHbrM5LPwm6siuqoGEgRfFjEvoCWWoEohB8g==
X-Google-Smtp-Source: ABdhPJw7QKNr67fS3gDhO+zKe/hJi1YFElz1zNvFHtceZtniL65xH7Elblb7qv59vtKafH50+xiGf03ZvH4G2TYVtAY=
X-Received: by 2002:a67:f317:: with SMTP id p23mr24113816vsf.0.1633520683136;
 Wed, 06 Oct 2021 04:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
In-Reply-To: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 6 Oct 2021 12:44:32 +0100
Message-ID: <CALjTZvbQr+rDUCct1fH-xgLP1jKvDRW6cMxCk6UVZ6h4dTsH6w@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
To:     tglx@linutronix.de
Cc:     maz@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, again,

On Wed, 6 Oct 2021 at 09:50, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> "PCI/MSI: Use new mask/unmask functions" broke boot for my ION/Atom
> 330 system

Just for the record (and probably stating the obvious), reverting the
aforementioned commit fixes this system. Running Linux 5.15-rc4, at
the moment.

Thanks,
Rui
