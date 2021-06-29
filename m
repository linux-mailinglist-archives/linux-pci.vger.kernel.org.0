Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294C93B70C9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 12:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhF2Khs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 06:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhF2Khs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 06:37:48 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F173C061574
        for <linux-pci@vger.kernel.org>; Tue, 29 Jun 2021 03:35:20 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id s19so20402239ilj.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Jun 2021 03:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7pqd1Gy9mXbqe/+ndtEdp2Pq005cIy4ParQJkTo5zc=;
        b=cq/hFaQR++XZ6dPkVc9Kt0oRwkjfVX7i9TwSiCUxaMMHVi+8VmaS/ZuBFWNrkrmmby
         T4S6byyYzci1UWM069U7w23c2Tye0wz5rVmLvoqqvi5H5yAXtmvlfzGdSHDFhJcHDy2G
         mG5/2EH4n0isR8zyJFJahqOaYhpYmpgoUFWD1pGvfsOW284j5KIlY/Dyx9JjDc+bVbKF
         RRYFG+HGOXijx5KnaYNOtCgucupvOO8pSdQdUG0LMC+Xm3mqr9UNDQiAK9OybevD7Fiv
         wO+ynx2AV8jHZe0zBz0srwgUX5XEqmCa+G2ueF/GjKrZpgXM1n8ojXRsIcNM+xBFnMp9
         cfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7pqd1Gy9mXbqe/+ndtEdp2Pq005cIy4ParQJkTo5zc=;
        b=OuCcQbm15K/UT5JqWlFytroiQIJNRrkHrfimcm7GtyQPi6QrxRn0BSknTYZD7BCMkT
         sUTrJOOgEMrL8HC8EKZ4EKLBngzMzMLJ6QJoKwuX9QK+h5qE3Kog5FiUbls+JsAiXh0B
         V65pw7+RuqTIRiKIRJfjLDgjAFwBVHSDpcuO253cWL/7/m+wAx4uHfRtePTQV1cyY1si
         /iwKmHiHnv0zKhTDrFxworKiQiCY/IWLhsp+1FH5iy7WqcrlYXg2a1qwulnL0Yv5HS+V
         8z9970cSNgalRtKUQlI+0nFEkExMQUZ1NVyee9ddrd2erqoz2MUD2SdslKDU6x4ab72u
         VCtQ==
X-Gm-Message-State: AOAM533mqgJhb3Vrh0iODXyf2QmVGlNh+KUnaUNAbZ3/U6tEl4v8hpv5
        RYOjkCmzJux50mZNWaLDZK79bepTj/y0vI+zlJk=
X-Google-Smtp-Source: ABdhPJyKbFoQJAWxOv0qSjPERU/Gf3ybeDSsDbDmgPwDfL+jiFWCUR5q4JhpMDj9Y6g0KEwLShHCQXPhcJvbiQM98qc=
X-Received: by 2002:a92:6509:: with SMTP id z9mr21520143ilb.184.1624962919686;
 Tue, 29 Jun 2021 03:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210629085521.2976352-1-chenhuacai@loongson.cn>
 <20210629085521.2976352-2-chenhuacai@loongson.cn> <980b31f6-d9ad-802b-1b9d-4c882f75fa50@kernel.org>
In-Reply-To: <980b31f6-d9ad-802b-1b9d-4c882f75fa50@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 29 Jun 2021 18:35:07 +0800
Message-ID: <CAAhV-H637pWg03KLUz4-CKLweqLmM+RH1DbfidT2pq=eVhO9OA@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] PCI/portdrv: Don't disable device during shutdown
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Sinan,

On Tue, Jun 29, 2021 at 5:19 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 6/29/2021 11:55 AM, Huacai Chen wrote:
> > he root cause on Loongson platform is that CPU is
> > still accessing PCIe devices while poweroff/reboot, and if we disable
> > the Bus Master Bit at this time, the PCIe controller doesn't forward
> > requests to downstream devices, and also doesn't send TIMEOUT to CPU,
> > which causes CPU wait forever (hardware deadlock). This behavior is a
> > PCIe protocol violation, and will be fixed in new revisions of hardware
> > (add timeout mechanism for CPU read request, whether or not Bus Master
> > bit is cleared).
>
> Your word above says this is a quirk and it needs to be handled as such
> in the code rather than impacting all platforms.

Yes, this is more or less a quirk, and we have already found the root
cause in hardware. However, as I said before, there are other
platforms that also have similar problems.

Huacai
>
