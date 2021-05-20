Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE39538B7A0
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 21:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhETTcp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 15:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhETTco (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 15:32:44 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3216C061574
        for <linux-pci@vger.kernel.org>; Thu, 20 May 2021 12:31:22 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id n4so5888315ybf.5
        for <linux-pci@vger.kernel.org>; Thu, 20 May 2021 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+Ms1Mdlgc6f1WHOMy0i1zHe/I7TBCodtqRLYgj8C68=;
        b=CtfeQLYWqpRMy+hl9P9sA6sEApjkM8awaf4IiUjEyspw9QYiW0L2IDztMm0u9U1zRw
         WndBjDg0bNcyDNz7N4f9HF6hn38lMvR++fhP3MUZO23vrB/Ze7RIwuiveSBtiG2ilZH+
         Fk3EYsu42yRCaB2eqlWqoQS/xR0C1S3UkD92vX8s172Xl8MU1bsb/NtaT33oGM8bLtoj
         nRhKomUOXpoBbmCZKa86Gxpubjty2JVTpsbu3jLcvMxeNOnRFR//vdj3rUch0BqQgncd
         cbl5ZHmJLWXJTFyzO+Buni5W8AzSTIvNt+IFKApMmopSeOVHNPGcSpIRGs6gRpxfVl8q
         mgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+Ms1Mdlgc6f1WHOMy0i1zHe/I7TBCodtqRLYgj8C68=;
        b=pNHyMiA0qUffX07NyF7CUV8dgGaDdIkklt8eneDXEJoyQQudLEcj1tzxZbsmehqYmO
         eG5g7pzzXL9uEBv1PsDxR/mmoi1wrXODUWyYS+YrhxzjUsQYPhQoBz2vbyw95VfMCd3F
         B5M5tojrqnnCiy/rNLtivHN6fQDkg+hKO5cVVW69L5PyPMoEfhpMm2bU9Qf9mHI9jzbq
         Tm34H7UG+hfmxPqVlK1dXPBV9YvgMVYcIInt3ytEMl8yWbNpt9aPatalShmT8dtGBcAA
         lHTveEy8tetQvxnHYz161bHZqYLvWMXKkLsO23P/VoDvSF0ptV2RwDpJrUSu2++1FxxN
         GvhQ==
X-Gm-Message-State: AOAM530scB4tJrA7CPZtLVg46J6ZajDgjjiOsFVKmN5Va6rtbXlK9g0+
        HFTKr4/1UXVv47SaEpveo62nHjOjgEMoJFGXULQ=
X-Google-Smtp-Source: ABdhPJw2cjh13upcD9dU0ifgavhm1Mw2nnHExs7JnTxAssU3znMih1HjLLD6vPCItYfSvKXMTOPBHo6ToJu67px5XtQ=
X-Received: by 2002:a25:b84f:: with SMTP id b15mr10002086ybm.319.1621539082283;
 Thu, 20 May 2021 12:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120055.jl7vkqanv7wzeipq@pali> <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
 <20210520140529.rczoz3npjoadzfqc@pali> <CABLWAfSct8Kn1etyJtZhFc5A33thE-s6=Cz-Gd6+j04S4pfD_A@mail.gmail.com>
 <4e972ecb-43df-639f-052d-8d1518bae9c0@broadcom.com>
In-Reply-To: <4e972ecb-43df-639f-052d-8d1518bae9c0@broadcom.com>
From:   Sandor Bodo-Merle <sbodomerle@gmail.com>
Date:   Thu, 20 May 2021 21:31:10 +0200
Message-ID: <CABLWAfTNPpGghbcgf3pzaOgC_Ep-fKyhFONyKkWXzb3dgrAmUw@mail.gmail.com>
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 20, 2021 at 7:11 PM Ray Jui <ray.jui@broadcom.com> wrote:
>
> May I ask which platforms are you guys running this driver on? Cygnus or
> Northstar? Not that it matters, but just out of curiosity.
>
Initial support was added for the XGS platform - initially the single
core Saber2,
then also dual core Katana2. The XGS is not upstreamed but uses the
same in-kernel
MSI implementation.
