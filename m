Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2600F316C3B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 18:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhBJRN3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 12:13:29 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:45928 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhBJRNS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 12:13:18 -0500
Received: by mail-wr1-f45.google.com with SMTP id m13so3378470wro.12;
        Wed, 10 Feb 2021 09:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zRGrC1gvxYUUpwYb7w7anX6wHYzZJGOo9ioM3U9cZD4=;
        b=RI8LvvWbXhrlpIuJBMCz+ufVVezIvuoc+A9P+so+NzhQJQssbX5CXZyxbZzbLeyLRU
         ECKa/o5646YFL0oArktHvZgoYwQNtQcC00195IVY2BtjcVAtJKn8j7NnxCe06q63WRuY
         LVfSBmMGxLEQBzd8ISRkYsdYCRFNErZzJgPXC7dzQN8r9zFkMZfgMmzEy9TGLVP0qngc
         NUYgotTkisF9ZQxUtfCk/GhQ2JHDgaoSKmVnCYi23gUNrcHfA1++fLVKScTFTnlwIDQ1
         RSCENvix6L5SvqGm2PfVCfMJJvpxbyTnEspmnO4eZDVstIEj55mFpEgtdKfi8w8wQVMt
         TXkg==
X-Gm-Message-State: AOAM530KrEjzBpWE8/9P4AxSjeadUTjNqzWFuxhgttpgWHHVXz1COQcf
        7ngS/Y1/W0z8s87Rnjt2khPWaQ7Oo7l3jA==
X-Google-Smtp-Source: ABdhPJyDh/sb3wRP+npXApBWIfDMyxmgmc83NJmulVKPGIS94vdAmi7rxtxwUoVe9V58vZdKfhA1bw==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr4612293wrp.175.1612977158025;
        Wed, 10 Feb 2021 09:12:38 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id s10sm3787674wrm.5.2021.02.10.09.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:12:37 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:12:36 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/RCEC: Fix failure to inject errors to some RCiEP
 devices
Message-ID: <YCQT90mK1kacZ7ZA@rocinante>
References: <20210210020516.95292-1-qiuxu.zhuo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210020516.95292-1-qiuxu.zhuo@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Qiuxu,

Nice catch!  Thank you for sending the fix over!

[...]
> On a Sapphire Rapids server, it failed to inject correctable errors
> to the RCiEP device e8:02.0 which was associated with the RCEC device
> e8:00.4. See the following error log before applying the patch:
> 
> aer-inject -s e8:02.0 examples/correctable
> Error: Failed to write, No such device
> 
> This was because rcec_assoc_rciep() mistakenly used "rciep->devfn" as
> device number to check whether the corresponding bit was set in
> the RCiEPBitmap of the RCEC. So that the RCiEP device e8:02.0 wasn't
> linked to the RCEC and resulted in the above error.
> 
> Fix it by using PCI_SLOT() to convert rciep->devfn to device number.
> Ensure that the RCiEP devices associated with the RCEC are linked to
> the RCEC as the RCEC is enumerated. After applying the patch, correctable
> errors can be injected to the RCiEP successfully.

Would this only affect error injection or would this be also a generic
problem with the driver itself causing issues regardless of whether it
was an error injection or not for this particular device?  I am asking,
as there is a lot going on in the commit message.

I wonder if simplifying this commit message so that it clearly explains
what was broken, why, and how this patch is fixing it, would perhaps be
an option?  The backstory of how you found the issue while doing some
testing and error injection is nice, but not sure if needed.

What do you think?

Krzysztof
