Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270FC2D4D15
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 22:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbgLIVow (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 16:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388024AbgLIVoo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 16:44:44 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CFFC0613CF
        for <linux-pci@vger.kernel.org>; Wed,  9 Dec 2020 13:44:03 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a16so4336304ejj.5
        for <linux-pci@vger.kernel.org>; Wed, 09 Dec 2020 13:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TYfiACm4P9e4Q3UXzVvxYYSBgj6W7482KDX0U+gqWbs=;
        b=dZmtXaLDGCUswwrzjS8ONF2OhQRmKYjl1nzSnc3mmiJsqNbVqL3manL5sjzglo7CCY
         1wc497+Sbhlix2kE2CrMvplc808zgbRKSC03CDIRVaXDRwMrqK+7SWFQDwil2NB2dPTg
         pDdUrg0oWsnoDkoNZpHgxWJgDl8njos5JD/PPNU/lEER943nhqRrpxItMT8/mKCOrlgb
         Oh/rLXbDyZJOr6qzKQ8ogKqLAKm540ml5BK9bltrYai3mshwQvG5mLxWAumPqnD8CKSz
         YtOSQPzHKU0JffPiybQFEFyydZIsbEvTbikLd3is5hvLpi4gEcLCpdGVPZCKuwOt5yl5
         YnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TYfiACm4P9e4Q3UXzVvxYYSBgj6W7482KDX0U+gqWbs=;
        b=COyWBMi4JVFkKG0U8AI8+yEOE8SElp3/76dTIhUlQa42AFMCQ/nBAmh+KBeRL0fSiE
         HPKWtYvAp559IRVqI9euuV9WQNO27vhk6AfG49tOFF+ksDq9IiiyaFpMrwul0HDLeqw1
         V6YdiMqTpd/9B64/I/WygyvMODxqixu+Se/Wkr8kG+eztTjiSmqSlri93dUiRSF8iCT7
         YSzQ3VQbUcX7+7SG1lrRLqFux2T/cNUpU92zzeLXLG8E0Uk2zTt38jDBY78vc8cchLGj
         Yd5/24p21yfadyUxs3RxNjoX0btJwxjphyOX6JdH9MJ9w42O4UFhIWlEpH9/Yn5D758+
         Vddg==
X-Gm-Message-State: AOAM530ywzwa4gNgNgoRAxxgurJDpXma2D5MApFEor9OOOsPqjjQf4bv
        rmE5APNINiQbbhNNm2YdLQ8=
X-Google-Smtp-Source: ABdhPJw8Oidd7MiYim2KDHlebjhNwIYc6G5UNWFqv7rjerwne/emDzLWDDd6gsqRcg/RCqRAXT5FGQ==
X-Received: by 2002:a17:906:4994:: with SMTP id p20mr3748565eju.391.1607550242169;
        Wed, 09 Dec 2020 13:44:02 -0800 (PST)
Received: from skbuf ([188.25.2.120])
        by smtp.gmail.com with ESMTPSA id lc18sm2600554ejb.77.2020.12.09.13.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 13:44:01 -0800 (PST)
Date:   Wed, 9 Dec 2020 23:43:59 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Michael Walle <michael@walle.cc>, lorenzo.pieralisi@arm.com,
        kw@linux.com, heiko@sntech.de, benh@kernel.crashing.org,
        shawn.lin@rock-chips.com, paulus@samba.org,
        thomas.petazzoni@bootlin.com, jonnyc@amazon.com,
        toan@os.amperecomputing.com, will@kernel.org, robh@kernel.org,
        f.fainelli@gmail.com, mpe@ellerman.id.au, michal.simek@xilinx.com,
        linux-rockchip@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@intel.com,
        linux-pci@vger.kernel.org, rjui@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        sbranden@broadcom.com, wangzhou1@hisilicon.com,
        rrichter@marvell.com, linuxppc-dev@lists.ozlabs.org,
        nsaenzjulienne@suse.de,
        Alexandru Marginean <alexm.osslist@gmail.com>
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201209214359.gt4wisqh65oscd4i@skbuf>
References: <20201209212017.vx7dps3jasjcwg6j@skbuf>
 <20201209213449.GA2546712@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209213449.GA2546712@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 09, 2020 at 03:34:49PM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 09, 2020 at 11:20:17PM +0200, Vladimir Oltean wrote:
> > On Wed, Dec 09, 2020 at 02:59:13PM -0600, Bjorn Helgaas wrote:
> > > Yep, that's the theory.  Thanks for testing it!
> >
> > Testing what? I'm not following.
>
> You posted a patch that you said fixed the bug for you.  The fix is
> exactly the theory we've been discussing, so you have already verified
> that the theory is correct.
>
> I'm sure Krzysztof will update his patch, and we'll get this tidied up
> in -next again.

If you were discussing this already, I missed it. I was copied to this
thread out of the blue two emails ago. I also looked at the full thread
on patchwork, I don't see anything being said about the culprit being
the size of the config space mapping.
