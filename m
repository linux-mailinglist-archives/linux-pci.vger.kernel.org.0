Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD5D390621
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhEYQEo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 12:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhEYQEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 12:04:44 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F9BC061574;
        Tue, 25 May 2021 09:03:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f22so22161651pgb.9;
        Tue, 25 May 2021 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GGJlw63A6hNFKItDJtxBDw0DwnZQp/w6Mj4wPb2Ro/c=;
        b=PEJIpxDxEGT1dvjN5B8GPfy2VR7NtbY30LFlf7hAf65Mb/x19wBeAIu+1OOKwJwAT8
         dpYAzCzr+1xj+2sM1eigENpbsvXTN5onKvE6epoouwKhCTdUmq72M/601FaWBJCOhIUh
         xEYMvxoYZ2J7QpKFr+ehaqpmbuHOVyyFXGX/DZWqQ8VaGfUBMdfWfH41+K/yzaPclPHJ
         CO1RRYSbUVjWg1GrC6b+fzl1EnI3OW+QXgBzY+VOnAPMcFe4QdOggg0rd3Ic3MY8VRME
         mRqaTyBEit+YuJeHUeu8ubVY18COBc0BWq8Q1Zjiv6x1erCUg3px/dcWQvCIDNreZiEN
         12nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GGJlw63A6hNFKItDJtxBDw0DwnZQp/w6Mj4wPb2Ro/c=;
        b=ptSyERNvJN1o9+wncK2fHC1LL/wvKgYjggPloEhswjYOMwqEwtITLOMo6S6mNVO1gA
         qjU+3cQuunDh5H5YfdJZbcDa6KV2W6Zs/7hJ6qJCzVq5wqBxBkVEnmNPYD3V2HdIWPkw
         gApeds0dOdgeBhzVDJc9qNTb7GDsvVIaHLjA+haJ3zcEl65tmOUu7w9iwi8qjiVF9Tnt
         LVjoM/1L41GTeLtqqU2XNnHNdGsPRXupvFovUTx9TipBymYroXcPnrqM7+7VZPUYm4nY
         V0KlU4ceDHvVY77Hv5j6ZH5Z43Tee47PNrRg3MgW0RxdM/eb+A/NEboG/uHN3QT1gP1a
         ilwA==
X-Gm-Message-State: AOAM532bSDhbG80dHGxE9XYWqhNxkZdHAUbgEZ1CE3gwz0zaWtq+pdR9
        4csVJ4b77Se8saXKODpXzKY=
X-Google-Smtp-Source: ABdhPJxUJRZREtCNacVtj+HbUPEclwy+fFE0oysQqgYrwiRkNKVa5dIaDDRptzHu5PPKsJUQSLiXuQ==
X-Received: by 2002:a63:64c6:: with SMTP id y189mr19623061pgb.333.1621958593049;
        Tue, 25 May 2021 09:03:13 -0700 (PDT)
Received: from localhost ([103.248.31.164])
        by smtp.gmail.com with ESMTPSA id t133sm15394534pgb.0.2021.05.25.09.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:03:12 -0700 (PDT)
Date:   Tue, 25 May 2021 21:33:09 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/7] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210525160309.trpo2cvzpkpkkidx@archlinux>
References: <20210519235426.99728-1-ameynarkhede03@gmail.com>
 <20210519235426.99728-3-ameynarkhede03@gmail.com>
 <20210520150526.GB641812@rocinante.localdomain>
 <20210524144814.rqgvbaawdxbdwio4@archlinux>
 <20210525151725.GA80163@rocinante.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210525151725.GA80163@rocinante.localdomain>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/05/25 05:17PM, Krzysztof Wilczyński wrote:
> Hi Amey,
>
> Sorry for late reply!
>
> [...]
> > > Similarly to my suggestion in the first patch in the series, perhaps
> > > using a boolean here would be an option.
> > >
> > > Having said that, the following existing functions aren't doing it, so
> > > for the sake of keeping things consistent it might not be the best
> > > option, as per:
> > >
> > >  static int pci_af_flr(struct pci_dev *dev, int probe)
> > >  int nvme_disable_and_flr(struct pci_dev *dev, int probe)
> > >
> > > Krzysztof
> >
> > All the functions which implement different types of resets including
> > quirks have ...reset(struct pci_dev *dev, int probe) signature.
> > Should I modify all of them?
>
> Might not be worth it to change anything then, especially if the other
> functions there already use an integer argument to enable or disable the
> problem or something else.  At least no in this series.
>
> 	Krzysztof
Actually I made a new separate patch at the end to implement this change.
I'll send v3 soon.

Thanks,
Amey
