Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5617F12716
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 07:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfECFZi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 01:25:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38455 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfECFZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 01:25:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id f2so217653wmj.3
        for <linux-pci@vger.kernel.org>; Thu, 02 May 2019 22:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fiP1dSzJDSxcySo13/x6XymhVx+VfpZdcVooeC5gJFk=;
        b=AqEzJvbCcfFDntnYU56JtRgeHQPMo0DRo1hQXaws3BJPWPvHxNhO8a2xRjRGbI8P0i
         v4umZt28CK37wTrPQa76i7I4LArx4l90zW0ZIF8ZstoAYirVGXeXmOrFAQPN+nStz0oX
         LkpA/JwpT2+81wqkz/gqGKw6oHFqgRgNEI+zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fiP1dSzJDSxcySo13/x6XymhVx+VfpZdcVooeC5gJFk=;
        b=s26zHCMaRkxFoPscciCKOxwD4UcTsOhZjE1th7qwgNcwfgZbE9doKKb5yYKGzHCwrw
         vYzPkdjSMzRR0XWZ0lCsaZhVZWBdLi9iq5NA1KIuy1EG5lFcWR0ui02/IXrjaN9y+74a
         Ub64YZnK5LqEyw1zkJ4kkY2reJZukM3OXEqfljzkEvJq8f4FjGFaiKjZdBk0jk7+mche
         fWjvZPmXBCCQ6GpccfNzlvdD0mi1cg2b+HwVodCYt9NpmkI7MbCnO4DWzxqKz4mfR6xq
         7w3IefhWgaI9NfvW2xeW0+1TL9IoWOmOq7P//XVTY2QZGM1h3QScO/EpJGV7g2wsc60k
         DaAQ==
X-Gm-Message-State: APjAAAXeT/qW9yVH4X/rphQDx30izdrnwIapejiuO47fwuIZUdzgfMFh
        xs3xWb6/N6Ziz3X7n1KCfwD8CWdnoyo1y0fwm0RYjQ==
X-Google-Smtp-Source: APXvYqyISYH7nKcdjdVCeeugv6IoT9S8/ObRtKGQv/5SEzsVgM1UETN2cuGzb4GZ/x3EBExgqyhrzlVjaHU1k+1xLF4=
X-Received: by 2002:a1c:a843:: with SMTP id r64mr4976939wme.45.1556861135435;
 Thu, 02 May 2019 22:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <20190501113038.GA7961@e121166-lin.cambridge.arm.com> <20190501125530.GA15590@google.com>
 <CABe79T5w4hb572KHUhyrwAN7+Xxnz2jF9OGLpfTmAdHuLuO2Fw@mail.gmail.com> <7c44526aebb6403890bab8e252c16375@AcuMS.aculab.com>
In-Reply-To: <7c44526aebb6403890bab8e252c16375@AcuMS.aculab.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 3 May 2019 10:55:24 +0530
Message-ID: <CABe79T5h3N3VZd12a51gGzOpw3-vrvNcQxS88q8xMi8=HWr6Tw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
To:     David Laight <David.Laight@aculab.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi David,

Thanks for review, I will fix in next version of this patch set.

Regards,
Srinath.

On Thu, May 2, 2019 at 3:24 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Srinath Mannam
> > Sent: 01 May 2019 16:23
> ...
> > > > On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> > > > > Few SOCs have limitation that their PCIe host can't allow few inbound
> > > > > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > > > > DT property and this address ranges are required to do IOVA mapping.
> > > > > Remaining address ranges have to be reserved in IOVA mapping.
>
> You probably want to fix the english in the first sentence.
> The sense is reversed.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
