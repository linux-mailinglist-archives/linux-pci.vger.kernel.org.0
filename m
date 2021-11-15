Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073C2450452
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 13:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhKOMYe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 07:24:34 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:43710 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhKOMYc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 07:24:32 -0500
Received: by mail-pg1-f179.google.com with SMTP id b4so14363695pgh.10;
        Mon, 15 Nov 2021 04:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wCfilGs3tbPGlsfeUD9hcaFP1etCLTIi9LFqoYSjO1g=;
        b=lra5lgYcgbar6azaOEz7VyUUhinNX09HuY/pLq/Qcl+GKqeCJsuNOBEN+XpTFHKEtA
         +fwsz+jwcIHSDV0WGSK7lGzcMGKq3kWvRbascyIC3NDpve2qM29C9m0L+xB5qfEPkwt8
         74ltMj+ZKtgYkNaWozx84ooZVhYY5KGMk08ljuXA47mgT2ofSyDpnOKM7Q0J7FnQRyfS
         AyAc2w9YvvyRELU+RrwCpBrkKzS+LPboZBmCWUhOUEkamTj2Ns9m3wFVF2FgJ6Pd0B1m
         od8VdFm0Pb58G1Kek5g83onr1WOZ8wYGWJlfZKg9I0G1LjY2UqG7FHFiCxZDna6FVvRX
         p1+A==
X-Gm-Message-State: AOAM532l2fEbHkujfmZIA66dFYGRN3fvZdIa8xz+cuEMjHGMcpMLG2Gp
        A9zfOailkXV/TkRzDrcQLCU=
X-Google-Smtp-Source: ABdhPJwCMLdC2B78wQz32Craa5Pu76Qkexor7qPIbEPWQLPnzRVk7/Wugc907LXxfyKBLdN5gvTBlw==
X-Received: by 2002:a63:6a09:: with SMTP id f9mr15767258pgc.279.1636978896796;
        Mon, 15 Nov 2021 04:21:36 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id lx15sm13834992pjb.44.2021.11.15.04.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 04:21:36 -0800 (PST)
Date:   Mon, 15 Nov 2021 13:21:24 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] PCI: brcmstb: Use GENMASK() as __GENMASK() is for
 internal use only
Message-ID: <YZJQxLkXgvZGkZYl@rocinante>
References: <20211027093433.4832-1-andriy.shevchenko@linux.intel.com>
 <YXkjMO0ULRGqZPbr@rocinante>
 <YXkphydcdD9giKqs@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXkphydcdD9giKqs@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

> On Wed, Oct 27, 2021 at 12:00:16PM +0200, Krzysztof Wilczyński wrote:
> > > Use GENMASK() as __GENMASK() is for internal use only.
> >
> > To add, for posterity, that using __GENMASK() bypasses the
> > GENMASK_INPUT_CHECK() macro that adds extra validation.
>
> In general, yes, but here we have a variable...
>
> > > - u32 val = __GENMASK(31, msi->legacy_shift);
> > > + u32 val = GENMASK(31, msi->legacy_shift);
>
> ...which make me thing that the whole construction is ugly
> (and I truly believe the code is very ugly here, because
>  the idea behind GENMASK() is to be used with constants).
>
> So, what about
>
>       u32 val = ~(BIT(msi->legacy_shift) - 1);
>
> instead?

Sorry for late reply!  Thankfully, you've sent a v2 using the BIT() macro
already.  Thank you!

	Krzysztof
