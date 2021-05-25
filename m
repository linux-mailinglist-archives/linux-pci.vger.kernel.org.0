Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB57390512
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 17:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhEYPTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 11:19:41 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:34608 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhEYPS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 11:18:59 -0400
Received: by mail-lf1-f51.google.com with SMTP id f30so9640099lfj.1;
        Tue, 25 May 2021 08:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8E0fK30YxyVuaWMTGyqCwE5nIsqZO3mhIIR2qTIDgSs=;
        b=YcolOxdqv8j6yLcGhNloVQVogddLjW92yEkVdFVHqMxcm23+FqmIY/kgFwW4q7p00d
         8BUssnXOPZNDHCpL9Laix8c2yI+rZvpF6nu/wJoWxJfA7t4TNGmNTPejw5t0z1iOB9r0
         DAS+UnaeVwwsfXZ4knaqAJ5rnYmMEcNlZEQ7qce/JIRZ/mqubqTUHH3l58fbfS/VHZ6k
         PYQdNhxupeED+dgMsRiiijyeT2yGBGVtHH/GaflWMyGFlE3Z4GkfF9FergMKel9K9FCs
         8vjUx45z0nCRx5ImrvJMvFmiAFClxcXYsE2efcFUsDh9rEYDI1pL9NjrjPi1nxWB5PqF
         BcvQ==
X-Gm-Message-State: AOAM530xuu2qohus+i2+ENITDbEBLnFCCX/1eqdYAEhMldSmBSxn2sNI
        ARc9ZOUrfMFCiqpN0GxHZrQ=
X-Google-Smtp-Source: ABdhPJwsKBoQWP01j+NQfRLiIo4iQfCTmn+GQRNhffehlX6xOjpL9PbfKJbYkPNl71sI88LfCps+QA==
X-Received: by 2002:a05:6512:39ca:: with SMTP id k10mr14052925lfu.96.1621955847781;
        Tue, 25 May 2021 08:17:27 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c9sm2103699ljb.22.2021.05.25.08.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 08:17:27 -0700 (PDT)
Date:   Tue, 25 May 2021 17:17:25 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/7] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210525151725.GA80163@rocinante.localdomain>
References: <20210519235426.99728-1-ameynarkhede03@gmail.com>
 <20210519235426.99728-3-ameynarkhede03@gmail.com>
 <20210520150526.GB641812@rocinante.localdomain>
 <20210524144814.rqgvbaawdxbdwio4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210524144814.rqgvbaawdxbdwio4@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Amey,

Sorry for late reply!

[...]
> > Similarly to my suggestion in the first patch in the series, perhaps
> > using a boolean here would be an option.
> >
> > Having said that, the following existing functions aren't doing it, so
> > for the sake of keeping things consistent it might not be the best
> > option, as per:
> >
> >  static int pci_af_flr(struct pci_dev *dev, int probe)
> >  int nvme_disable_and_flr(struct pci_dev *dev, int probe)
> >
> > Krzysztof
>
> All the functions which implement different types of resets including
> quirks have ...reset(struct pci_dev *dev, int probe) signature.
> Should I modify all of them?

Might not be worth it to change anything then, especially if the other
functions there already use an integer argument to enable or disable the
problem or something else.  At least no in this series.

	Krzysztof
