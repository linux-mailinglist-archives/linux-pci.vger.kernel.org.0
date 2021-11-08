Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A12449F03
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 00:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbhKHXdL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 18:33:11 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:43536 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbhKHXdJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 18:33:09 -0500
Received: by mail-ed1-f49.google.com with SMTP id w1so69562396edd.10;
        Mon, 08 Nov 2021 15:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4c9jRVTiEOAT2G+TczrZz0JB2x25zxtUp6Iq9kweQdk=;
        b=XmnaINPhvFwQe0hdIzoMH5JuVuPLEN3oN1qoAPQcfUzRnBMWr6wMiFVaSBr/BC2ovE
         lgfnTR+RyXnfaivM1ppGPHTujCsU4TAWifwRQMj8r+gNNQj4sPOIdtq8eS6TSGl32ZLc
         MG4Tguo5Kf1eRojD55/5mUwe1kDVFdgjynJSadhrBvNCSJs7xJOr0b10s2w18DdKISiU
         OvHPtxY6+jCrDnXQJ6ord0pRRtggTC/NUHQxR1wGjbLu52XP6+QV1m21sthdAJXTG1y5
         Z2zA2MW0F2BXMDB+ndXstJetld8YBVqvMo3FFMSQcS/ghesysvckOh7NeatW6EvQJKLE
         rDlw==
X-Gm-Message-State: AOAM533GKlr15oWE4+GXWVZZWOuivv06vHB89MrxptRiPNWNHDPKgkYI
        ADsmm2lGbKUA2x2XMJE+7v8=
X-Google-Smtp-Source: ABdhPJys8NT5dfq5Lddj/S7xPCmtxJrgTHYB2WWsp3uqzbIbw1reXNcrnC9CFA6c4kiJhWpEA+oZzg==
X-Received: by 2002:a17:906:12d0:: with SMTP id l16mr3561291ejb.415.1636414223297;
        Mon, 08 Nov 2021 15:30:23 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id hq37sm9073999ejc.116.2021.11.08.15.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 15:30:22 -0800 (PST)
Date:   Tue, 9 Nov 2021 00:30:21 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, nsaenz@kernel.org,
        jim2101024@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: brcmstb: Declare a bitmap as a bitmap, not as a
 plain 'unsigned long'
Message-ID: <YYmzDSjLgmx9bQQs@rocinante>
References: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
 <YYh+ldT5wU2s0sWY@rocinante>
 <4d556ac3-b936-b99c-5a50-9add8607047d@gmail.com>
 <4997ef3c-5867-7ce0-73a2-f4381cf0879b@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4997ef3c-5867-7ce0-73a2-f4381cf0879b@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> > > Jim, Florian and Lorenzo - is this something that would be OK with you,
> > > or you would rather keep things as they were?
> > 
> > I would be tempted to leave the code as-is, but if we do we are probably
> > bound to seeing patches like Christophe's in the future to address the
> 
> Even if I don't find this report in the Coverity database, it should from
> around April 2018.
> So, if you have not already received several patches for that, I doubt that
> you will receive many in the future.
> 
> 
> My own feeling is that using a long (and not a long *) as a bitmap, and
> accessing it with &long may look spurious to a reader.
> That said, it works.
> 
> So, I let you decide if the patch is of any use. Should I need to tweak or
> resend it, let me know.

I would be pro taking it, not only to addresses the Coverity complaint, but
also to align the code with other drivers a little bit more.  Only if
the driver maintainers have no objection, that is.

	Krzysztof
