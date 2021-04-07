Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775FC3565C3
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244484AbhDGHtV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 03:49:21 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33460 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346927AbhDGHtO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Apr 2021 03:49:14 -0400
Received: by mail-lf1-f45.google.com with SMTP id o126so27056877lfa.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Apr 2021 00:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6SRP8OeTcR/KgJdJa5t6aXet7f/ljpH7kyaw3+fz1SI=;
        b=ZjPHTuyPF1KCH8e+kimou43MTWLLz2vVhsR8sgGBEhFcQAubkNe04pFgMuGW4h9BH3
         N5bHL+kg9UXOgO+qftCa2dBIGn+ZUHWDi7opIIeRdFeVwINGwPauBt83L732A51BCQqD
         5MwDXPub42pzu7hHSkPtLb8EGnocMsdvB+ssp1Mn38Dcf/I9XI0a71GvDekm5c8JBWLA
         /ZWWPkil7iOo+8Y1mTHTJELZ5wcz4yEKGRS8BManeigLBKL8ks5NPHjU82oG5+ffAYrl
         hqt2giciGycpFyGnJSnU73TZ3dLOFYtALwH+QwD4vCzMbP5XXez4V/d4xLWdx2XCitel
         bR0g==
X-Gm-Message-State: AOAM5324AG91+RvyQe2UJ44bDhN4pC0Zz5LA/RgooEuQ+d5MYB1ZF4RN
        llgj4vczKukW5k3Q5Wf/v5M=
X-Google-Smtp-Source: ABdhPJze95lD+ibky5DrOYDFpHGuORdTtTwu7fbrqdXWBpVsJHUL6Kaxt2rK5PY0XO9lJGK3jo71LA==
X-Received: by 2002:a05:6512:3692:: with SMTP id d18mr1726496lfs.128.1617781744922;
        Wed, 07 Apr 2021 00:49:04 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id i15sm2401134lfv.192.2021.04.07.00.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 00:49:04 -0700 (PDT)
Date:   Wed, 7 Apr 2021 09:49:03 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: merge slot and bus reset implementations
Message-ID: <YG1j7+Mj4IiparPe@rocinante>
References: <20210401053656.16065-1-raphael.norwitz@nutanix.com>
 <YGW8Oe9jn+n9sVsw@unreal>
 <20210401105616.71156d08@omen>
 <YGlzEA5HL6ZvNsB8@unreal>
 <20210406081626.31f19c0f@x1.home.shazbot.org>
 <YG1eBUY0vCTV+Za/@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YG1eBUY0vCTV+Za/@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Greg for visibility]

Hello,

[...]
> > > > > The previous coding style is preferable one in the Linux kernel.
> > > > > int rc = pci_dev_reset_slot_function(dev, probe);
> > > > > if (rc != -ENOTTY)
> > > > >   return rc;
> > > > > return pci_parent_bus_reset(dev, probe);  
> > > > 
> > > > 
> > > > That'd be news to me, do you have a reference?  I've never seen
> > > > complaints for ternaries previously.  Thanks,  
> > > 
> > > The complaint is not to ternaries, but to the function call as one of
> > > the parameters, that makes it harder to read.
> > 
> > Sorry, I don't find a function call as a parameter to a ternary to be
> > extraordinary, nor do I find it to be a discouraged usage model within
> > the kernel.  This seems like a pretty low bar for hard to read code.
> 
> It is up to us where this bar is set.

The only person who ever pulled my ear, so to speak, over using ternary
was Greg as a bad style where, especially where it does not need to be
used.

But, I digress.  I humbly think that we should move back on track and
finish review of Raphael's patch.  Would use a ternary here be
a show-stopper?

Krzysztof
