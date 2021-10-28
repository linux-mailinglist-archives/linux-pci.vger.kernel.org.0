Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B6543D9DD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 05:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJ1Db6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 23:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJ1Db5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 23:31:57 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59526C061570
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 20:29:31 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id t127so11621775ybf.13
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 20:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=n18UDQOz07tSaVkEnRUDBfl4H/zMfQiliwKUZY/Ey8Y=;
        b=PMZpEn6oZwv2+FHy7bBz1ltV+OkABwfoT7nUAjqxW+hhT9INBeMWJS//NP73d82BtY
         H6tutZDfIdCpfg1FEojxNVrSYcEebS9zlp9etElDvOryCmbxCrnR5UvoIhyU1t8FPK+m
         yG9aF1P2R4IFvVvNrjV0g83TUbXUWyAJg00BGGv4dTK8XkY0U7tC9FEnL+X22zcjkMKW
         4mrm2K3BBf7j4XdXLwekQCinJNs8S82mWjGCVFZr1beWV/oFM8Eh3woJVTWOINHBCSsO
         tuy3vqdCwp496NKHwnggCuy1R5cCinKqamcjTsy4zO8lf74ZZhhG2acfoCxKltAiVPsl
         +vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=n18UDQOz07tSaVkEnRUDBfl4H/zMfQiliwKUZY/Ey8Y=;
        b=ty7QaLEMg73Jum4kQOCtOcZfVrKsGzIVhVEujvhHVqRu5GEVZidRlej6Quu7hK5uZb
         ArutlAIGqsmLgwYf6VxvZFohlfG5JHXslYLQoNi2UTwC1Fim3Ph4AMXKp3APIaY1NQV/
         gG1FUo2ut7FukZH39sirsha6vitfv5LA9wfGK/hMr69LiHoKPFNFJrnYz2fswvYMgUoz
         gzxnBhJMQ/hd+q/nEFqwdxvAKU0/t2nZDq5Nh70cwvgyyOCF3DbR24iLQ8PBUpszwji+
         AeGMEZNJChQIEw/cJMpiLFKM5hBRIRAraEZcA0vknGiguzhfXWS5ZYYoumbA/zco1U/T
         7Ckg==
X-Gm-Message-State: AOAM533oU4aD/GZ1Cc2Os2K7RpG3ZS7Tos8v0m4nFu6CsE04OzrzsPLa
        f5zTKejojeuv2R0LrTqzpTBFqmTD2zsCntaAcRlU2IEpjAU=
X-Google-Smtp-Source: ABdhPJzdaWUmaAXv5gzfGNU4XUWsTdCKTWExdpiZ3yI6U9u4PA59RYps6drCV/1yK1E26jWGiJdgF2/dA0W+uqU9fVA=
X-Received: by 2002:a25:aa0f:: with SMTP id s15mr1792572ybi.51.1635391770494;
 Wed, 27 Oct 2021 20:29:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:97cb:0:0:0:0 with HTTP; Wed, 27 Oct 2021 20:29:30
 -0700 (PDT)
In-Reply-To: <CA+nuEB9ZyD-uX3GFV=9LDWXibqekwvNDV+UEu8EwyL7NG6YjsA@mail.gmail.com>
References: <CA+nuEB9ZyD-uX3GFV=9LDWXibqekwvNDV+UEu8EwyL7NG6YjsA@mail.gmail.com>
From:   Amol <suratiamol@gmail.com>
Date:   Thu, 28 Oct 2021 08:59:30 +0530
Message-ID: <CA+nuEB8MTEksJDdC7C8x_Ag3RRe=u4KDz4qPMpo20MtLTPK-JQ@mail.gmail.com>
Subject: Re: pci_check_and_set_intx_mask(dev, true)
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/10/2021, Amol <suratiamol@gmail.com> wrote:
> Hello,
>
> If pci_check_and_set_intx_mask is called with the intention of masking,
> and if there indeed is an IRQ pending, then the comparison
> "mask != irq_pending" evaluates to false: the 'mask' variable is 1, and

Correction: Evaluates to true. Causes the function to return without masking.

> 'irq_pending' is 0x80, in that case.
>
> This state causes the function to return without masking, contrary to the
> behaviour expected of it as given by a comment:
>
> "Check if the device dev has its INTx line asserted, mask it and return
> true
> in that case. False is returned if no interrupt was pending."
>
> My vfio/pcipassthrough setup sees INTx line asserted as the VM is being
> shutdown, but the line is not masked; the host kernel panics saying
> "nobody cared" - there's no handler.
>
> Is the inconsistency with the pci intx masking really a problem, or just a
> misunderstanding on my part?
>
> Thanks,
> Amol
>
