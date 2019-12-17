Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB31225B1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 08:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfLQHku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 02:40:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42763 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQHkt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Dec 2019 02:40:49 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so6210564lfl.9
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2019 23:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X5f5iaIkroAR2Srdn5VLeaGAxX4bVlkBzmWbFqfuMhU=;
        b=tBIlNurYD84Rxn7nyFUuAu2iCRRqHPZExv5Jt8Ed5aA0KcvnnK4jSDW5l7l/7/ZpN3
         A8qki+sakMAuPSl7AGvYMb9XJx0q/JchrMUAKXYOzlgSBvvcWcNNUov+rzdpDzUqhMnL
         gkTxfpsX7g5kl44fFaw02PlFFSYoo5X9yZFp9VSxY3paF0CKPVkZCyxB8xJEsCPwSrTh
         IWaKfjy8wdzKlAlDlpXX6+rGAjXp+z4IufrP97Cm3MF6ufMd2kNWNtRdgQkFrEt+XgSr
         rlmv67plHBP0ujWLatwIBsMm7Ij74p4qJpJm21ncBBIJgshlZFI2FuGDrXror1eqXewL
         KHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5f5iaIkroAR2Srdn5VLeaGAxX4bVlkBzmWbFqfuMhU=;
        b=bcDeZA/idgKTVrz4zUVx3u8VXZFQNtEdPFTZrjwxisM4ltEPLYN6NPAXM8NgL+6/dA
         2/jQgfc3B3z2OF/pOpRjztud5ziYpVS5XfJq8i54qXYbNQeyDsrkYnl3VH8D1JHJA5uN
         w5+omF0w3W1SsZzEqZJoSPM/5sgXO7jb1gGw5t3OybRq+TpewVYwJjexQ6qr1Cegxl2H
         IaV+ng33i874cSQ2Vd8SPoMZzm9KPm6KIxx5WqEtjFOSk16iB7bgQUg5k4lzGDICXEVv
         2wUAl7hCLW6gaioryGVX4f6SwC2d8MqnYS2sbcw/D4NNvRLehNE/KzKylMoBGlk9Dgyx
         Auxw==
X-Gm-Message-State: APjAAAVWExxM11l9jRXsn6iaYPH3kMiR2yOgWEw6OMA2xzYcYyp/Wr0g
        uWJfd6rsAOxkHdDSk4hA6Bk=
X-Google-Smtp-Source: APXvYqwfgOJbTQBTy4bVAp369f5JAxpv2g4YdoW1p+3Vmbx573yHeHUvzAxa8Xy2gaYwkGfESzLA3w==
X-Received: by 2002:ac2:508e:: with SMTP id f14mr1742759lfm.72.1576568447679;
        Mon, 16 Dec 2019 23:40:47 -0800 (PST)
Received: from monakov-y.office.kontur-niirs.ru ([81.222.243.34])
        by smtp.gmail.com with ESMTPSA id f24sm11924182ljm.12.2019.12.16.23.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Dec 2019 23:40:47 -0800 (PST)
Date:   Tue, 17 Dec 2019 10:40:42 +0300
From:   Yurii Monakov <monakov.y@gmail.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     linux-pci@vger.kernel.org, m-karicheri2@ti.com
Subject: Re: [PATCH] PCI: keystone: Link training retries initiation
Message-ID: <20191217103742.32072f52@monakov-y.office.kontur-niirs.ru>
In-Reply-To: <20191216110821.GR24359@e119886-lin.cambridge.arm.com>
References: <20191007114159.61ad83ea@monakov-y.office.kontur-niirs.ru>
        <20191216110821.GR24359@e119886-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 16 Dec 2019 11:08:22 +0000, Andrew Murray <andrew.murray@arm.com> wrote:

> On Mon, Oct 07, 2019 at 11:41:59AM +0300, Yurii Monakov wrote:
> > ks_pcie_stop_link function never cleared LTSSM_EN_VAL bit so
> > link training was never triggered more than once after startup.
> > In configurations where link can be unstable during early boot,
> > for example, under low temperature, it will never be established.
> > 
> > Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pci-keystone.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c
> > b/drivers/pci/controller/dwc/pci-keystone.c index
> > f19de60ac991..ea8e7ebd8c4f 100644 ---
> > a/drivers/pci/controller/dwc/pci-keystone.c +++
> > b/drivers/pci/controller/dwc/pci-keystone.c @@ -510,7 +510,7 @@
> > static void ks_pcie_stop_link(struct dw_pcie *pci) /* Disable Link
> > training */ val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
> >  	val &= ~LTSSM_EN_VAL;
> > -	ks_pcie_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL |
> > val);  
> 
> Oh yeah, that doesn't look right to me. Good spot. Thanks for this!
> 
> > +	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);  
> 
> As far as I can work out, this bug existed from the beginning - can
> you please resend with this tag?
> 
> Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
I have to add this line prior to 'Signed-off-by' tag?

> Can you also update the commit subject to emphasise it's a bug fix,
> e.g. PCI: keystone: Fix ... or similar.
Do you mean that I have to create new patch from scratch and send it again?

Best Regards,
Yurii Monakov

PS. I'm new to LKLM, so sorry for dumb questions.

> 
> Thanks,
> 
> Andrew Murray
> 
> >  }
> >  
> >  static int ks_pcie_start_link(struct dw_pcie *pci)
> > -- 
> > 2.17.1
> >   

