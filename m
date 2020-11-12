Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036722B0764
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 15:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKLOPX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 09:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLOPX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 09:15:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E67C0613D1;
        Thu, 12 Nov 2020 06:15:23 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605190521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDqpKAUrItpHlbE5XWwW32ZAnSVkMvadrlti6qz8qYg=;
        b=VoYtF8BI7RLcnvT3P0hzVSJo32ng+9NyUF+JXWg9Pn+C/ZBbgYLROeCmx7sFdyFUT46rJ8
        CMgvz9C2LahmdePRNxCLbS0p64AoaEaNgwcwXHWd1keRONGI8MFHJ3BTtaKmpHo4I0TWZ2
        vAwHFQ7z9N2nz7aWk4kT7ClUADpdz1eCBBAilOODAeqO0AZvlmYSQAnqlKbuHY09FRhMD2
        leUg6Jii4k/Ama8r+Y8t9/x03N3KxlA/ZHF/uovVa8YZaKOZmppCgQROOI9hCdwFYpcd5N
        /gbLBb+JfH8XDmNEGF6gpfuInPulOkmBNtKHQDfQhVyp4CGcjfioiM8ZPO62Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605190521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDqpKAUrItpHlbE5XWwW32ZAnSVkMvadrlti6qz8qYg=;
        b=rHy7YOjnh3ZoFKx73oTAYHW5ZZpTYL59dAo5H0GGx5XK+D91l/tZPlDTpXltpPSMTfhgqa
        5GykZaJPuBPhNnCQ==
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: REGRESSION: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
In-Reply-To: <20201112125531.GA873287@nvidia.com>
References: <20200826111628.794979401@linutronix.de> <20201112125531.GA873287@nvidia.com>
Date:   Thu, 12 Nov 2020 15:15:21 +0100
Message-ID: <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason,

(trimmed CC list a bit)

On Thu, Nov 12 2020 at 08:55, Jason Gunthorpe wrote:
> On Wed, Aug 26, 2020 at 01:16:28PM +0200, Thomas Gleixner wrote:
> They were unable to bisect further into the series because some of the
> interior commits don't boot :(
>
> When we try to load the mlx5 driver on a bare metal VF it gets this:
>
> [Thu Oct 22 08:54:51 2020] DMAR: DRHD: handling fault status reg 2
> [Thu Oct 22 08:54:51 2020] DMAR: [INTR-REMAP] Request device [42:00.2] fa=
ult index 1600 [fault reason 37] Blocked a compatibility format interrupt r=
equest
> [Thu Oct 22 08:55:04 2020] mlx5_core 0000:42:00.1 eth4: Link down
> [Thu Oct 22 08:55:11 2020] mlx5_core 0000:42:00.1 eth4: Link up
> [Thu Oct 22 08:55:54 2020] mlx5_core 0000:42:00.2: mlx5_cmd_eq_recover:26=
4:(pid 3390): Recovered 1 EQEs on cmd_eq
> [Thu Oct 22 08:55:54 2020] mlx5_core 0000:42:00.2: wait_func_handle_exec_=
timeout:1051:(pid 3390): cmd0: CREATE_EQ(0=C3=83=C2=97301) recovered after =
timeout
> [Thu Oct 22 08:55:54 2020] DMAR: DRHD: handling fault status reg 102
> [Thu Oct 22 08:55:54 2020] DMAR: [INTR-REMAP] Request device [42:00.2] fa=
ult index 1600 [fault reason 37] Blocked a compatibility format interrupt r=
equest
>
> If you have any idea Ziyad and Itay can run any debugging you like.
>
> I suppose it is because this series is handing out compatability
> addr/data pairs while the IOMMU is setup to only accept remap ones
> from SRIOV VFs?

So the issue seems to be that the VF device has the default irq domain
assigned and not the remapping domain. Let me stare into the code to see
how these VF devices are set up and registered with the IOMMU/remap
unit.

Thanks,

        tglx

