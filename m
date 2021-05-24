Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4338EAF6
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 16:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhEXO7D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 10:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhEXO47 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 10:56:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC4DC061248;
        Mon, 24 May 2021 07:48:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so11271561pjb.2;
        Mon, 24 May 2021 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/E/GBFdOj5M6LsY2db/Ym7zO7WOVjl/+cOln0wcJzT4=;
        b=l0Ijf3GN8zzspFB/KjYUO1CbD5kmnXPNH/rU1F3wRmOvMo7hwu/wusEipB/hGn8oPy
         8/tp3WJ2aRiyENiNvREV/0LMtp9DAcPVhyclEGS5kHHkW8w2AeXd24X+8PBgk8qP8Jax
         17+NUx0ARBwfjz0e5SUpn65TyM0zgTyEqvYXXrBAV5bwz4QaWoSQoW5gDsQFTtLiy4en
         s6sY3lZCUqbpjaUhymlMszvQSO49/5fi6rm65Mw/L+DmO1RGYR6n5kWTILbvNbfLEyJs
         h7vZD/WtydR4oHpLFxfH0l4RQFXQyZ49AoAWMeqJMzRlaRnjvT5tHnVJRn/3t6Z3W4Ms
         ZoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/E/GBFdOj5M6LsY2db/Ym7zO7WOVjl/+cOln0wcJzT4=;
        b=RZ0JLC3iRptrR8E3SLFLQJprnUzm35qCEw8PLeVWa7cjsVqf+8Fj6B6w9UgkMEYKCj
         c9reo9We6F6VUvR3Z/eOvDkVD+COtGG13fM4f9AfRzbKxLfGH8C1mM/3tg2SlNd2ZOZL
         GNpdjbUUgW9MrF1ekuVOe38vVutdNJBd81WhT/ZlWh3ju5goEWT/SrWTydELn0C6VSGw
         4s/0boneHLRsk8AoN1QtsX58SoMDCm7H7cxhb6yHv0vqZ/oHF8d7sk/M2X/4Q9VRCuaD
         6pMpvdXo7aVZ+Z3E1NygBXdSgrfriXQJZpUM5fcARKdKDv+hpqHn4dRcDaNjMzCRbIid
         M48A==
X-Gm-Message-State: AOAM53160hU0Cm5ZX+FXmdsGaIhyPyTW2xnYe7sSpFR3g/KaRFFg0nQI
        cj67BWY+wG825QyA5l9iyF4CZP8GkxqWwpJY
X-Google-Smtp-Source: ABdhPJwGZbqaQqjFdK+2r5hBrX8jT3al1xVDK24K12DtXJ+z+JzQLfYhDiQiJ2JEHwuJ8/UbwfaY2A==
X-Received: by 2002:a17:90a:dc82:: with SMTP id j2mr25686023pjv.138.1621867696948;
        Mon, 24 May 2021 07:48:16 -0700 (PDT)
Received: from localhost ([103.248.31.164])
        by smtp.gmail.com with ESMTPSA id j16sm11953309pfi.92.2021.05.24.07.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 07:48:16 -0700 (PDT)
Date:   Mon, 24 May 2021 20:18:14 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/7] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210524144814.rqgvbaawdxbdwio4@archlinux>
References: <20210519235426.99728-1-ameynarkhede03@gmail.com>
 <20210519235426.99728-3-ameynarkhede03@gmail.com>
 <20210520150526.GB641812@rocinante.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520150526.GB641812@rocinante.localdomain>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/05/20 05:05PM, Krzysztof Wilczyński wrote:
> Hi Amey,
>
> [...]
> > +int pcie_reset_flr(struct pci_dev *dev, int probe)
> > +{
> > +	u32 cap;
> > +
> > +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> > +		return -ENOTTY;
> > +
> > +	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> > +	if (!(cap & PCI_EXP_DEVCAP_FLR))
> > +		return -ENOTTY;
> > +
> > +	if (probe)
> > +		return 0;
> > +
> > +	return pcie_flr(dev);
> > +}
>
> Similarly to my suggestion in the first patch in the series, perhaps
> using a boolean here would be an option.
>
> Having said that, the following existing functions aren't doing it, so
> for the sake of keeping things consistent it might not be the best
> option, as per:
>
>  static int pci_af_flr(struct pci_dev *dev, int probe)
>  int nvme_disable_and_flr(struct pci_dev *dev, int probe)
>
> Krzysztof
All the functions which implement different types of resets including
quirks have ...reset(struct pci_dev *dev, int probe) signature.
Should I modify all of them?

Thanks,
Amey
