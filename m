Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DD6447857
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 02:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhKHBhL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 20:37:11 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:33583 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbhKHBhK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 20:37:10 -0500
Received: by mail-pf1-f169.google.com with SMTP id c126so6045648pfb.0;
        Sun, 07 Nov 2021 17:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mWr9Mi5YMHTa3T07Gk34FemQhAzXo7wj/0HuBoS0oBY=;
        b=Pt8Z4Lf10GJMEjgBmaRbSNZKR8/o8qH8TsW0Ah4iPRuFj77QPewiDIlMspj7Rk8Rh/
         INHjTpDsNin1fj7L6iQbV9/3oOD03LCzbhJN3FXbGUxolGMPOeWpYWHrZn4UZhG+eWH5
         P+NP4X7lqiqmigAcj+nBOfbBUqse7aqBg9Esvxbj2YEKade+FpIyQEzz5LDse3AUVtRs
         S++jkvcVOP6G7h9eOOcR41YH+0E/0IsJR42PmfmrOL9hoUV9v/5Js9O4+ZVK0XQPvhQ8
         wik9c7Qp4ZYnIja/N1p4QPR1I2mkAx43yqa9KKJr2EidGFiy0UIOkWjUe0aaPeHPE3NL
         LYFw==
X-Gm-Message-State: AOAM533OokXp+eXoH6d19XTR4DxjSNFkcCOqB4Emm6R0iLTC2olNbc8p
        OPU9K4ZRaY0y2URRBjkP6z8=
X-Google-Smtp-Source: ABdhPJyvrldzJctNqWP3qBig1k4nT4bAAzfVHptACo0tnM9HY/IvC+DM5RmBWCI0a12eDwKJDoZ1KQ==
X-Received: by 2002:a62:7f4a:0:b0:44d:292f:cc24 with SMTP id a71-20020a627f4a000000b0044d292fcc24mr77899278pfd.58.1636335266915;
        Sun, 07 Nov 2021 17:34:26 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id k20sm14217369pfc.83.2021.11.07.17.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 17:34:26 -0800 (PST)
Date:   Mon, 8 Nov 2021 02:34:13 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     nsaenz@kernel.org, jim2101024@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: brcmstb: Declare a bitmap as a bitmap, not as a
 plain 'unsigned long'
Message-ID: <YYh+ldT5wU2s0sWY@rocinante>
References: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christophe!

[...]
> This bitmap can be BRCM_INT_PCI_MSI_LEGACY_NR or BRCM_INT_PCI_MSI_NR long.

Ahh.  OK.  Given this an option would be to: do nothing (keep current
status quo); allocate memory dynamically passing the "msi->nr" after it
has been set accordingly; use BRCM_INT_PCI_MSI_NR and waste a little bit
of space.

Perhaps moving to using the DECLARE_BITMAP() would be fine in this case
too, at least to match style of other drivers more closely.

Jim, Florian and Lorenzo - is this something that would be OK with you,
or you would rather keep things as they were?

> Addresses-Coverity: "Out-of-bounds access (ARRAY_VS_SINGLETON)"

This tag would have to be written as:

  Addresses-Coverity: ("Out-of-bounds access (ARRAY_VS_SINGLETON)")

[...]
> +	DECLARE_BITMAP		(used, BRCM_INT_PCI_MSI_NR);

Probably not the most elegant solution, but I would keep it as:

  DECLARE_BITMAP(used, BRCM_INT_PCI_MSI_NR);

Otherwise aligning either before or after the open bracket will cause
either an error or a warning issued by checkpatch.pl accordingly about
the style.  Other users of this (a vast majoirty) macro don't do any
specific alignment at large

[...]
> +	/*
> +	 * Sanity check to make sure that the 'used' bitmap in struct brcm_msi
> +	 * is large enough.
> +	 */
> +	BUILD_BUG_ON(BRCM_INT_PCI_MSI_LEGACY_NR > BRCM_INT_PCI_MSI_NR);

A healthy paranoia, I see. :-)

	Krzysztof
