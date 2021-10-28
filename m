Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3B343DA03
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 05:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhJ1D5b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 23:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhJ1D5b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 23:57:31 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F02C061570
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 20:55:04 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 131so288609ybc.7
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 20:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=AEx5242DUOrQIu4AE2b3yDQzUe5Y4ooMVP+teipdFSA=;
        b=gCD/WXThtTevsHjbdEDdRygDwT0WwkK5y701wwcwyWjFbc/K4wVn0PEvj/WqY5ClXL
         fHGST/4XHIh4/A1Co2Ma1ocj4sA+rGOpZ+nJW8Ld9BfDGWwrEHoH8JjuHCfVneqVHMep
         WSu1fu3mBe+qVYsfDdLUqfPgS26Zr+7gUpVM9IJ+nMmidxTGX4AyHZBHuW9iPbrotoRd
         X+19e1jLAYuXkza06lY7/Fcis4RcafNfHazWxkDPHoJGK+JvgtsNwKyW/fJCcqle+YTI
         Br9CDrPvIz4FElxSwaigXTKpzYL6vofhjOhkyTh5y51UP3/ChV2bsTx6Sqb+RacTg/hO
         4ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=AEx5242DUOrQIu4AE2b3yDQzUe5Y4ooMVP+teipdFSA=;
        b=dpuDqUW6ctlS0nuFabiGFbhhds/ivMFQ4cCQUwW78fLmQBLarD9Ee6lzk2ePDXJYDg
         9mTm+xeb7FYKwtrZrXj3N+OQryfdaA4N0kem/6JKmbPd+eXpOr4Hz70BHZPrhBIn5y7y
         h3Y+DuADg1VUQmgVayZIFn9eFZYNAs1D5+fhxHOmGqLX42DWBWp1tJkZ73pBrnR6mshf
         xD+OjlhpzLKrpvMRG9zFPoymaAHBlqeZNKfmmDDMX78a2M8ENVy+dGpFvNsN1NbK4poy
         ip/ZqoxNX0qIDLlDf3wisUkCbHQ3ZWBJzCpDlkI/SgL5hId40OdoahgKDCj/sOL4xmLf
         Ganw==
X-Gm-Message-State: AOAM531cR+hpvxHzuzzY+528yyM0AZeCm2F89NyeTxqQSKLEhghDxlwD
        1sc+qGogokCKogW3i2di0GXHq213FvQfV98zlgJPFctaVMQ=
X-Google-Smtp-Source: ABdhPJxulSnT48XmSpuFiNvgphSm9+k/L7KJul6/6r8L7m2/Vg+gVTiGSQ/DAq/qhUhrJXdCCKfYUeLJPEk1oQJdWVA=
X-Received: by 2002:a25:7c42:: with SMTP id x63mr1834706ybc.477.1635393303913;
 Wed, 27 Oct 2021 20:55:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:97cb:0:0:0:0 with HTTP; Wed, 27 Oct 2021 20:55:03
 -0700 (PDT)
In-Reply-To: <CA+nuEB8MTEksJDdC7C8x_Ag3RRe=u4KDz4qPMpo20MtLTPK-JQ@mail.gmail.com>
References: <CA+nuEB9ZyD-uX3GFV=9LDWXibqekwvNDV+UEu8EwyL7NG6YjsA@mail.gmail.com>
 <CA+nuEB8MTEksJDdC7C8x_Ag3RRe=u4KDz4qPMpo20MtLTPK-JQ@mail.gmail.com>
From:   Amol <suratiamol@gmail.com>
Date:   Thu, 28 Oct 2021 09:25:03 +0530
Message-ID: <CA+nuEB8aQkayQR70goE_R0x4nDJRzdg=+e_DxonHsdAspEXuSQ@mail.gmail.com>
Subject: Re: pci_check_and_set_intx_mask(dev, true)
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/10/2021, Amol <suratiamol@gmail.com> wrote:
> On 28/10/2021, Amol <suratiamol@gmail.com> wrote:
>> Hello,
>>
>> If pci_check_and_set_intx_mask is called with the intention of masking,
>> and if there indeed is an IRQ pending, then the comparison
>> "mask != irq_pending" evaluates to false: the 'mask' variable is 1, and
>
> Correction: Evaluates to true. Causes the function to return without
> masking.
>
>> 'irq_pending' is 0x80, in that case.
>>
>> This state causes the function to return without masking, contrary to the
>> behaviour expected of it as given by a comment:
>>
>> "Check if the device dev has its INTx line asserted, mask it and return
>> true
>> in that case. False is returned if no interrupt was pending."
>>
>> My vfio/pcipassthrough setup sees INTx line asserted as the VM is being
>> shutdown, but the line is not masked; the host kernel panics saying
>> "nobody cared" - there's no handler.
>>
>> Is the inconsistency with the pci intx masking really a problem, or just
>> a
>> misunderstanding on my part?

It is indeed a misunderstanding on my part. I missed the fact that the
datatype involved here is _Bool; the compiler must be emitting extra
instructions to convert non-zero values to 1.

Apologies for the spam.

>>
>> Thanks,
>> Amol
>>
>
