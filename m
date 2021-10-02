Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B267141FA56
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhJBHvu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 03:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbhJBHvu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Oct 2021 03:51:50 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14673C061775
        for <linux-pci@vger.kernel.org>; Sat,  2 Oct 2021 00:50:05 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id q16so14472700oiw.10
        for <linux-pci@vger.kernel.org>; Sat, 02 Oct 2021 00:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmhvzM+9q8Hsg6g8ZOvHSolVs0w3D3OtvwsSGnhbiWw=;
        b=IgKflHq8ppi0B/W+mP7o0rOAHh2TmOWdNJzxcqMvHhRxjHiispRlsJDgRJJJzch7kc
         w45UpZQmUkrahVomd7IWj4HH9WiyMRmwsEqqyk7FqaqmrHhzdKYJQHNb4Ufte6ZZPq08
         9G4JVBYLCyn9UhN5s4X04nCWPfXhhz36edJOyO2PBBZtSGDBuJwxJyyaHQ+6/UUbBQw3
         cA5U5jr4mlKFf5Hp2zOZuiZPyjRZETRgens7krerX3gfz0CfwTPwOs6rmsRGta+dUj1k
         +rbBmcbFg3wevffAfLvunNxrHe5MdN0sMEV3yO4n8rIPUk1+bIPTUNnUG2zPxegYEjD3
         Fr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmhvzM+9q8Hsg6g8ZOvHSolVs0w3D3OtvwsSGnhbiWw=;
        b=8ST0YcCsujTUVUAaI1C5OlAlZw/hXtFkVsHpLzZCd0JzbrnWXqB1O2ctiQpsIzbWWb
         D/1OchTR1eZgJXVAEMJRlRhJgCuJCGdWZYfP8odHPo1qFDxvtzs73E9MkHP8DnTeZHES
         c6yK6OU5Gen/JqpdbywJTB6sG7GJ3l84/+FBGRexkm/fe5P6A1/PrpaOIY2ZuZLrfh3G
         5kg15uHce4iZzavsSSUIOfSEex76kGzdGff2OvEVjzb5jNfuEkbfHUBR1HGPEohWU20B
         fj7Gixg8iQ+1ELWSA5tI+7mLGLD5M0hV9lRBkCHISZ0CyKnzhIjq1OhbshvN6hTpgqqZ
         6k5Q==
X-Gm-Message-State: AOAM530WqbPoqWDrIp0ozJRAT4CF9Dj/QSd7yJc5SNSi/2mzRxxq2BBo
        RpkZTJ84zvoPEVOO6KZr3jbgzCe5tcLpRNMrcxREJFef
X-Google-Smtp-Source: ABdhPJzvgLsIR46GNXvMO2Oeu0VUXkTdelNWr4CDPRC3aSL6KdWTZqpjheFoly9BZ+elICJudMSf2YGtAIpFaWf05n4=
X-Received: by 2002:aca:6009:: with SMTP id u9mr123309oib.71.1633161004421;
 Sat, 02 Oct 2021 00:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHP4M8UqzA4ET2bDVuucQYMJk9Lk4WqRr-9xX8=6YWXFOBBNzw@mail.gmail.com>
 <20211001151322.GA408729@dhcp-10-100-145-180.wdc.com> <CAHP4M8U-uGwZqqGk5Z9KP7w_hESgTtrAsSrwxFfCiLZOht1uYw@mail.gmail.com>
In-Reply-To: <CAHP4M8U-uGwZqqGk5Z9KP7w_hESgTtrAsSrwxFfCiLZOht1uYw@mail.gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sat, 2 Oct 2021 13:19:52 +0530
Message-ID: <CAHP4M8WQMK59-Arg4rhusvT7f9870ymkc8OoMuWRuitRadzGVw@mail.gmail.com>
Subject: Re: None of the virtual/physical/bus address matches the (base) BAR-0 register
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Forgot to mention one thing, the environment/machine has "intel_iommu=off".

On Sat, Oct 2, 2021 at 9:36 AM Ajay Garg <ajaygargnsit@gmail.com> wrote:
>
> Thanks Keith.
>
> Let's take a x86 world as of now, and let's say the physical address
> (returned by virt_to_phys()) is 0661a070.
> The pci address (as stated) is e2c20000.
>
>
> Since the BAR0-region is of size 256 bytes, so the system-agent (as
> per x86-terminology) will monitor the highest 24 bits of
> address-lines, to sense a MMIO read/write, and then forward the
> transaction to the corresponding pci bridge/device.
>
> So, in the present case, would
>
> a)
> The system-agent sense address-lines A31-A8 value as 0661a07? If yes,
> is it the system-agent that does the translation from 0661a070 =>
> e2c20000, before finally forwarding the transaction to pci
> bridge/device?
>
> b)
> The system-agent sense address-lines A31-A8 value as e2c2000 (and
> simply forwards the transaction to pci bridge/device)? If yes,
> who/what does the translation from 0661a070 =? e2c20000?
>
>
> Meanwhile, I am also trying to learn how to do kernel-development for
> statically linked modules (like pci).
> That would help in a much better understanding of the things-flow :P
>
>
> Thanks for the help.
>
>
> Thanks and Regards,
> Ajay
>
