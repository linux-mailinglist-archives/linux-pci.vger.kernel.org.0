Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB5441A70
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 12:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhKALJT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 07:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKALJT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 07:09:19 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2659C061714;
        Mon,  1 Nov 2021 04:06:45 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id b125so6995677vkb.9;
        Mon, 01 Nov 2021 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9lEWYw0ODM1CY9TwJxkbfjlxmTuIfq2TV/XYiIwAR8=;
        b=Nv9COaWmfclDyZUdfO1OBmVklZorlT1iH+h+/PZVG7fd5gTVOKVw5s5srOtRt0Weiv
         74jKgU1aUxhdyiEB5JEwAgiF6m/1eRsPuC6/O0aOcXfJXAIs9haB6SuANbKwQpLxvNNq
         QHfZvOUDgXjQUT6gZlyKd14CDXgNno5fHR5HOWp0ZGJGtQDGe2vEiYGoTBMqvCHcLknU
         aYPe/zVpK5B8Tpp37l73jvrfXQ7pAB3Ku0jA1FEWuB982No/jbnElCQ4UKWHT1VgWAdt
         +izFugwrLwSHN9ilJL7203mI7P1sc++D74OWkMm1k7sfdyEVhrxuNqTzwBUnMOJYeLxD
         dWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9lEWYw0ODM1CY9TwJxkbfjlxmTuIfq2TV/XYiIwAR8=;
        b=ElW/vtycf1aCmgWzWWVuBhpjK+iUG9RMgBpwqjVyfd+8A5hqjTZ4Am/vUNVlH9UhhY
         fiL5uUeVJ2i9eUV4uRsUXvlwjkSIQZGHiem5twgYXewduEPvzyjC21uq6fhbbentR16r
         M+PUWHbmaW3ARRtRPDtSpY7jtKdMZLw4+mF/HRRFBBFGD9b+sdggSm1opX9oIZaQnr/B
         KoIynNI1CnkuqKDIDy/SnZ+jvuIJuZ2YxKUaIJkd5WTYh3932UdEPzjXhGRL1CCFPhzv
         Uqn1ffARBi6Wd6r+Un1zqN0ouT+e/HARvcSPtirZzUHjmNihEECZ42AJLZJ1su+CU3uD
         8MpA==
X-Gm-Message-State: AOAM531pzTkj6yadTL/PgDvTTYnKJdaJvChnHzR98XcpwTXEH2urcsoq
        l3Y99gNkU5H6v1P8Wsglj8DmcTQuUCH4tZYGpNDBn8s=
X-Google-Smtp-Source: ABdhPJyLpTVg+jIUTmLU+va9EzLPaqYonLHJRHLennaysumGFFSIagF0ifwGiwH1hbg+66ViAzips7KWFMv07w9e7h0=
X-Received: by 2002:a05:6122:98a:: with SMTP id g10mr26797675vkd.17.1635764805154;
 Mon, 01 Nov 2021 04:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <1374495046.4164334.1635737050153@localhost>
In-Reply-To: <1374495046.4164334.1635737050153@localhost>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Mon, 1 Nov 2021 11:06:34 +0000
Message-ID: <CALjTZvaddYDMqHgsnxd29EZodbXTiq8i3nycPp4KmrPv+kMvJg@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
To:     Josef Per Johansson <josef@oderland.se>
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Josef,

On Mon, 1 Nov 2021 at 03:24, Josef Per Johansson <josef@oderland.se> wrote:
>
> To be clear, which patch are you carrying? The latest by thomas is https://lore.kernel.org/linux-pci/89d6c2f4-4d00-972f-e434-cb1839e78598@oderland.se/

Please keep the discussion public.

The patch I'm carrying is the one Marc authored, in order to fix the
MCP79 regression I've bisected.

Thanks,
Rui
