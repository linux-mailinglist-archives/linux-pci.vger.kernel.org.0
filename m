Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04032178477
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 22:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgCCVBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 16:01:18 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45168 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbgCCVBR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 16:01:17 -0500
Received: by mail-io1-f67.google.com with SMTP id w9so5199158iob.12;
        Tue, 03 Mar 2020 13:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Inwyixh/Xliqd570k8wVQbSetvAGQIzEHwC5SASHA5I=;
        b=dSCmO0gjO6N6Ep7LHrxh+zXrLbsdS2opusnGKvBzMO3qlt47Bu43mQqlgXpuEJXfX9
         xO/AHiFd2YDEw/jDVx6M0htzF1p57qgWPHUH9WReVeEDYMqIIEb3y7d+fBBJcvN2qPXF
         6/5bi4FiRucesnNOfYkHB0WnLhpRFL5apuuogE/0DixF+dYGyYpyVa7Ap8fB2eHPMRHG
         8J01udvAw2EUpUHlNLMWlYSLs0/8JAnJ5ZgfaaswREzRjCjMMTbqwH2XL+hXmxnIx4Pl
         PqwU/WmcVq09M+wzSpmrYRfZN8E7xH1UV3TnyUv4kp4TBTT6AOOlHrzdz/b6pJkeJRrf
         FTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Inwyixh/Xliqd570k8wVQbSetvAGQIzEHwC5SASHA5I=;
        b=Yiyu/hYEizuHCTu3d5SA7GcAsI/mxDTEYEcRPde7Yr4xbeJ4nKxffCh3bcwpz+yXLp
         4GKOkCsPn5FVkfg29YdzzlIowP+enil37rwKTyJOiUnebuuLz/RNZkZxY2ZhpMxx9Dbr
         WmJKDtGrqv8lGEp2w5afc88C35I40JtIj9RAR2geYOMX3gxQT+ofc0mTYHCsOdRSztiO
         2ck8yjdoRcCYYLnFSmQ+8l0yOSBeRaxRKJOdni0pRtV5fwdM490RHmpXfmfkuj6ysKu+
         t2jMpdGHvct3bAW9Vi6z7Hp4VoORQ6bekAU3EJ1nIOea/1VQWFNOEgHxCP6msfuACPXH
         q/4Q==
X-Gm-Message-State: ANhLgQ1P0d71ruqhiA8wDrr1IoB/Ijk+K9MwgZKsuFey0vhib/OrS/7Z
        KopyYy4PU5Fr6QSkJZdIhOpZZofr003zU2xRyao=
X-Google-Smtp-Source: ADFU+vtbkYWtBm/HrVENxCPKK0eVn5EKnhXHq5pDUwR6Q53DQW/c7/4/OU0/6ovo/ftmDbmJ0Gn1Ux28zNMQ3zNobwY=
X-Received: by 2002:a5d:9c93:: with SMTP id p19mr5792564iop.81.1583269275868;
 Tue, 03 Mar 2020 13:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20191225192118.283637-1-kasong@redhat.com> <20200222165631.GA213225@google.com>
 <CACPcB9dv1YPhRmyWvtdt2U4g=XXU7dK4bV4HB1dvCVMTpPFdzA@mail.gmail.com> <CABeXuvqm1iUGt1GWC9eujuoaACdPiZ2X=3LjKJ5JXKZcXD_z_g@mail.gmail.com>
In-Reply-To: <CABeXuvqm1iUGt1GWC9eujuoaACdPiZ2X=3LjKJ5JXKZcXD_z_g@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 3 Mar 2020 13:01:04 -0800
Message-ID: <CABeXuvonZpwWfcUef4PeihTJkgH2ZC_RCKuLR3rH3Re4hx36Aw@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Kairui Song <kasong@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Baoquan He <bhe@redhat.com>, Randy Wright <rwright@hpe.com>,
        Dave Young <dyoung@redhat.com>,
        Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I looked at this some more. Looks like we do not clear irqs when we do
a kexec reboot. And, the bootup code maintains the same table for the
kexec-ed kernel. I'm looking at the following code in
intel_irq_remapping.c:

        if (ir_pre_enabled(iommu)) {
                if (!is_kdump_kernel()) {
                        pr_warn("IRQ remapping was enabled on %s but
we are not in kdump mode\n",
                                iommu->name);
                        clear_ir_pre_enabled(iommu);
                        iommu_disable_irq_remapping(iommu);
                } else if (iommu_load_old_irte(iommu))
                        pr_err("Failed to copy IR table for %s from
previous kernel\n",
                               iommu->name);
                else
                        pr_info("Copied IR table for %s from previous kernel\n",
                                iommu->name);
        }

Would cleaning the interrupts(like in the non kdump path above) just
before shutdown help here? This should clear the interrupts enabled
for all the devices in the current kernel. So when kdump kernel
starts, it starts clean. This should probably help block out the
interrupts from a device that does not have a driver.

-Deepa
