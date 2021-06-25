Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCDC3B4B66
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 01:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFYX6v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 19:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhFYX6v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 19:58:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6FC061574
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 16:56:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x16so8663929pfa.13
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 16:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x5yY4R0N1hPILAW6lmFgD/XJSlqTFqEw7HB3AKkIi1g=;
        b=ZTR4Ux6GX6RW6C6ELtWVkBCSgn7vzxgwgfke63rzKD1U3R5j9gGLNU0WcY17efXWWF
         L8S41EUYEQPwn1330v7tU9e3Vm0V5al1BEV/oGDAIpmWlJcv2Vg8/cZOq6aXTZ5+aSsq
         6Ao69n+vZ50l8PysJVfp5ax3IqtLLXCUFLCXnLOxH6NNXe7Ucto91Gq/PHvpJTBGXTIr
         u0WcJiChm1johYPns3QYGRy6X5nIZxmOSC4CafO+r1gqFDbXPhyimmrgEuZ3AAyvpKtB
         2yeeWuTf0RZCpm8C2eEwWRoGUDrerBKr2eLRpba82ny7mRPPROoWv8aJdjSQAlvA2991
         zwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x5yY4R0N1hPILAW6lmFgD/XJSlqTFqEw7HB3AKkIi1g=;
        b=HnN1m9C8DqUZCzjX75pxsYmXTRmWHugEUQejyj6rW/jCWyoJy+BwqlfnotMSGavK0P
         Ayi648RX52YUU64EqDKpoiRJuh5Rre97hrNQk7qIW7aR0C8LZ1VM++z/csnterfqyT4v
         LEDIklbiK0I5Ra6LKO9dsNmG6zZRCEx95d4/7nWhuo7lU32VLZdEB8O1WpuDcAtzrnwZ
         7C9d8zgvA0kuAhkgAHOviel3mxvBwAtZSKpfXzdN5CvFrQgwe4/uMEcC5azC1BXuMbah
         yKwR4zo6lJROGhWDmkl4n5pHWqnqlbsToIlogyInBLAzndrZDrLt/BtiY3NZvokND1rV
         mnPQ==
X-Gm-Message-State: AOAM530eh2M6zbz/DjzQ2haDGy3O+9vphKyHQJa1V1h6CX63D63D56yA
        EKYVIa5mG3evN45bkUz0GnmR+pVYGwMNbE+EJpEWnA==
X-Google-Smtp-Source: ABdhPJzNYtg4IA4YEUbZMFoPhdXRzg8WekzmnLkXNRqSiT6Ihg8/OlE50Kft/pALdHLAUwa98KUzrxF7F5ZuDYPhuww=
X-Received: by 2002:aa7:9729:0:b029:2ff:1e52:e284 with SMTP id
 k9-20020aa797290000b02902ff1e52e284mr12801501pfg.71.1624665389661; Fri, 25
 Jun 2021 16:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210625233118.2814915-1-kw@linux.com> <20210625233118.2814915-3-kw@linux.com>
In-Reply-To: <20210625233118.2814915-3-kw@linux.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Jun 2021 16:56:18 -0700
Message-ID: <CAPcyv4i-2QkpXbX_Uh7=ArbLgs1PtUdk5+wQ6fQPYaOPdBiVDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/sysfs: Pass iomem_get_mapping() as a function pointer
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 25, 2021 at 4:31 PM Krzysztof Wilczy=C5=84ski <kw@linux.com> wr=
ote:
>
> The struct bin_attribute requires the "mapping" member to be a function
> pointer with a signature requiring the return type to be a pointer to
> the struct address_space.
>
> Thus, convert every invocation of iomem_get_mapping() into a function
> pointer assignment, therefore allowing for the iomem_get_mapping()
> invocation to be deferred to when the sysfs open callback runs.
>

Looks good. Since I did not write any of the below go ahead and change
the "Co-authored-by"  to:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks for picking this up and carrying it through.
