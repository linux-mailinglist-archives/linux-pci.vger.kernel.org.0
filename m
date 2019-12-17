Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF58123281
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 17:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfLQQbg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 11:31:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33403 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfLQQbg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Dec 2019 11:31:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so7438626lfl.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2019 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9EegNCE760gkNB7fbdhTt+nN8Pyj1MuF76V2hDSQ5So=;
        b=QTSmVuKPPBV58aa4KhLFDuFg51YfC/p+yXYOw35x1xiknOuj4AisCqb42R9bwpnKkJ
         xC6euyifMhtKVIcKGilLYSa1esUvTgtOOxkC/vxpR94fu8JakCwyJeVg8mRNEampRoCH
         BUBmPCNlqmizB1D0cgiLCuJz90rDvFRMemY0vAx77nWoF8T/FmllznKUwhigJeSwyplc
         3D0GFfRmIYjiwol6r+a+uACo9QBzK8yfA/yyMwaoGx5EmmM+Ikiw4Lr07bFcuO+T/JNd
         vCkgt0fpZDwtpGIqlHIuFdZcxWCFtETO7MLMsGJgojdsK9o+0LpPRnT4gZ18t//U+Z+l
         6mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9EegNCE760gkNB7fbdhTt+nN8Pyj1MuF76V2hDSQ5So=;
        b=mDVFKiy7rERzyaFyslt0zvRP/4Q6SsukrBoIv+W1w/c98mkQtzHUuYg1PHXfH+YdJt
         6n2IAPrz/0GCRiaNqDVfM+r2rzphFuJH5mKX57uLHazUwnYwUi62TXNPMhcukb1k57zj
         tw1YzQZEh53GCJicd7ikNwcVrDPebT6kHz4dgZZ1d1/563imslYpoUFSyGSiD6uDoOBP
         Q1B1+jeCe2/s97uv8G3umThJrgCoRx1t0FOb76B1pB1sVPz4T+xPj/ZoRs2McVMX/84e
         7+6B1PLr8hgrAtfrSFsFxT6MkHxE7b4XkFLa02oNGYnf2GRBUq1dJIEd3EmmNWXOtP+l
         8tFw==
X-Gm-Message-State: APjAAAVJEVG/Q+UEiMXy8+t+yvn6hfyuHofnO//hAAhy1dpiCQqL2JR+
        4azYP6ujsZIFsPbKOso2pps2MKEzur4=
X-Google-Smtp-Source: APXvYqyD8SAlS4HzbVg5kqGIGSk/Hyt8quOYrPH8Bu+v0CMTkQaVwhw0TAlyqd3HZVixLjyNr/KISA==
X-Received: by 2002:ac2:51a4:: with SMTP id f4mr3471468lfk.76.1576600294014;
        Tue, 17 Dec 2019 08:31:34 -0800 (PST)
Received: from monakov-y.xu ([81.222.243.34])
        by smtp.gmail.com with ESMTPSA id d9sm12684137lja.73.2019.12.17.08.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Dec 2019 08:31:33 -0800 (PST)
Date:   Tue, 17 Dec 2019 19:31:31 +0300
From:   Yurii Monakov <monakov.y@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] PCI: keystone: Fix outbound region mapping
Message-ID: <20191217193131.2dc1c53c@monakov-y.xu>
In-Reply-To: <20191217143113.GA157932@google.com>
References: <20191004154811.GA31397@monakov-y.office.kontur-niirs.ru>
        <20191217143113.GA157932@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 17 Dec 2019 08:31:13 -0600, Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Kishon]
> 
> On Fri, Oct 04, 2019 at 06:48:11PM +0300, Yurii Monakov wrote:
> > PCIe window memory start address should be incremented by OB_WIN_SIZE
> > megabytes (8 MB) instead of plain OB_WIN_SIZE (8).
> > 
> > Signed-off-by: Yurii Monakov <monakov.y@gmail.com>  
> 
> I added:
> 
>   Fixes: e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")
>   Acked-by: Andrew Murray <andrew.murray@arm.com>
>   Cc: stable@vger.kernel.org      # v4.20+
> 
> and cc'd Kishon (author of  e75043ad9792) and put this on my
> pci/host-keystone branch for v5.6.  Lorenzo may pick this up when he
> returns.
> 
> I'd like the commit message to say what this fixes.  Currently it just
> restates the code change, which I can see from the diff.
This was my first patch sent to LKML, I'm sorry for inconvenience.
Should I take any actions to fix this?

> My *guess* is that previously, we could only access 8MB of MMIO space
> and this patch increases that to 8MB * num_viewport.
Technically you are right. It seems that without this patch all outbound
regions were mapped to first 8 MB. But this is obviously a bug, because
comment above the loop states that the intent was to map num_ob_windows
to linear MMIO space. And prior to e75043ad9792 'start' variable was
incremented by 'tr_size = (1 << 3) * SZ_1M'.

Best Regards,
Yurii Monakov

> > ---
> >  drivers/pci/controller/dwc/pci-keystone.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index af677254a072..f19de60ac991 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -422,7 +422,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
> >  				   lower_32_bits(start) | OB_ENABLEN);
> >  		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
> >  				   upper_32_bits(start));
> > -		start += OB_WIN_SIZE;
> > +		start += OB_WIN_SIZE * SZ_1M;
> >  	}
> >  
> >  	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
> > -- 
> > 2.17.1
> >   

