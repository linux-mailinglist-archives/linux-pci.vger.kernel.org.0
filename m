Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15FED18F63
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 19:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfEIRjl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 13:39:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37601 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfEIRjk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 13:39:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id g3so1687947pfi.4;
        Thu, 09 May 2019 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G488tD19TVWHIOWsjCdbHdhwCsIhFZLwFL+fr08o8yY=;
        b=DWc7+YOLeKjZcWm01IV8h1YnJP1hiMBzcwboBwpZtqdZ8Kum8i1u9sl2nzvG8XWtMw
         pQRcvpvWkVfRnHmysa7W0d3lo1e7K6LVn3HhmblUHAe2rJrWCx3aoeJrlwMiPC7EfDS1
         1ehLLzz5lhswSLpPn/+XVz4o52FoAGPCBCIH/52E+Av+0I6BB+vqnexXsbqw5gT1fGO/
         yf/+a020oHz6vNDJvNXjJ++BSruR/u8sCaVx0IaqjSypiVimilzFLX5uthqx6norQGjI
         p50FqRt+aMJpAK1wFzEHWnhljXaXq6xZmqKgME7w7MYbWar8FodFXzx+R6/Hp+e8nP8L
         hwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G488tD19TVWHIOWsjCdbHdhwCsIhFZLwFL+fr08o8yY=;
        b=VzzcXL+KyJ1X4H2/U7pohtaRjSWUMZlWwO/CY1P1Dv94qOecTv+UFvkjqENHiSE8Et
         S40J1JezgWphgMs2ENdZ5ZljgG9uEasDJhkdAty+MqOOw6f/kGhDmC/z5PXT2eOy74xZ
         eRtO+d/eNxmAOTjX0fet6uFth0jb4tDUDZDHxxsRrAYne0dqYTc2CDzfNVETDQvXxbxg
         8TkgVAjBajQgFq6xj0nPUIoLzwkxtlVAnggLO2o9hq47RI9AsbcmSRpkltcdizavBE6m
         DLhtgeBLyMUyi09rjc8Tkw75RdqJ4gBchFUhTk9aRgffOC6xwaM3Vba/dTZTskDRI6e9
         nlVA==
X-Gm-Message-State: APjAAAVMDmI0RR581AdX8LwHjBUPUvzF69kpQ9wFVhG3o9r0YLbC/mB0
        L1aB5513aSpR/LLoFun7s7eaTVXBmcqnlXnzdydWReHv
X-Google-Smtp-Source: APXvYqybBsI5M5pIlHneeTgkKElb1tKBLhckJ3TJ+ZTU0oRNNydY760+OhWLcqcERf/d8hA3KxMjmxek5UUh3jRRY74=
X-Received: by 2002:a62:ee04:: with SMTP id e4mr7018095pfi.232.1557423579900;
 Thu, 09 May 2019 10:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190509141456.223614-1-helgaas@kernel.org> <20190509141456.223614-4-helgaas@kernel.org>
In-Reply-To: <20190509141456.223614-4-helgaas@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 May 2019 20:39:28 +0300
Message-ID: <CAHp75Vd=fm4Sdc_ymiPgXnrCsU_9gBF16TsP0VX=ghDrbvk1Yw@mail.gmail.com>
Subject: Re: [PATCH 03/10] PCI/DPC: Log messages with pci_dev, not pcie_device
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 9, 2019 at 5:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> Log messages with pci_dev, not pcie_device.  Factor out common message
> prefixes with dev_fmt().
>
> Example output change:
>
>   - dpc 0000:00:01.1:pcie008: DPC error containment capabilities...
>   + pcieport 0000:00:01.1: DPC: error containment capabilities...

Overall same question about Capitalizing sentences.

> +       pci_err(pdev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",

And here perhaps RP PIO status: ... mask: ... ?
See below I left examples from this patch.

>                 status, mask);

> +       pci_err(pdev, "RP PIO severity=%#010x, syserror=%#010x, exception=%#010x\n",
>                 sev, syserr, exc);

> +       pci_err(pdev, "RP PIO ImpSpec Log %#010x\n", log);

> +                       pci_err(pdev, "RP PIO log size %u is invalid\n",
>                                 dpc->rp_log_size);

-- 
With Best Regards,
Andy Shevchenko
