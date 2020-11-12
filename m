Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD782B0840
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 16:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgKLPS0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 10:18:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45340 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgKLPS0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 10:18:26 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605194304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agGytP2/PxrD6HdXqGAuy03iJZcEBb4+WEPn1OkpUoY=;
        b=3aM4IilkkU0xEOJEYSQd1hmEqdFkHn8jAsqqH43Gr2WYbPm4EWg8o6PnKPPYpWEUfg5em0
        CrkMxX0rtOoTBHSqOiS2bIDUN2mfDYu9vQSuX8gdjJJXhGx06iMc2CXPjL9jCv9FjTifxt
        uVtlDKcPFT/T5uSztIULaMiZqJpldD7SxYssbR15JZcci/S9I16YmRTqpaUUFY5IRXgdd2
        J3HzX4lP/qOz+GCof+DpjC8ykxuUYg19zcChLVnUKx78WjuuX1A4kqYlgh9T9lobWluOvs
        GCKNp4wn92XIbkfPX/+eE7Ps0D48mtngYiTtUac5467oBGdXU/fE78Wgq17bHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605194304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agGytP2/PxrD6HdXqGAuy03iJZcEBb4+WEPn1OkpUoY=;
        b=Lv2IqEdi1qkvj7YNIX4gttzR6NFKXNORHb79P1h95gfmxiqgR3L9Asy2Nvhxp41LIcpRna
        Q0sdEygGMl1vmBCw==
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
In-Reply-To: <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
References: <20200826111628.794979401@linutronix.de> <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
Date:   Thu, 12 Nov 2020 16:18:23 +0100
Message-ID: <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 12 2020 at 15:15, Thomas Gleixner wrote:
> On Thu, Nov 12 2020 at 08:55, Jason Gunthorpe wrote:
>> On Wed, Aug 26, 2020 at 01:16:28PM +0200, Thomas Gleixner wrote:
>> They were unable to bisect further into the series because some of the
>> interior commits don't boot :(
>>
>> When we try to load the mlx5 driver on a bare metal VF it gets this:
>>
>> [Thu Oct 22 08:54:51 2020] DMAR: DRHD: handling fault status reg 2
>> [Thu Oct 22 08:54:51 2020] DMAR: [INTR-REMAP] Request device [42:00.2] f=
ault index 1600 [fault reason 37] Blocked a compatibility format interrupt =
request
>> [Thu Oct 22 08:55:04 2020] mlx5_core 0000:42:00.1 eth4: Link down
>> [Thu Oct 22 08:55:11 2020] mlx5_core 0000:42:00.1 eth4: Link up
>> [Thu Oct 22 08:55:54 2020] mlx5_core 0000:42:00.2: mlx5_cmd_eq_recover:2=
64:(pid 3390): Recovered 1 EQEs on cmd_eq
>> [Thu Oct 22 08:55:54 2020] mlx5_core 0000:42:00.2: wait_func_handle_exec=
_timeout:1051:(pid 3390): cmd0: CREATE_EQ(0=C3=83=C2=97301) recovered after=
 timeout
>> [Thu Oct 22 08:55:54 2020] DMAR: DRHD: handling fault status reg 102
>> [Thu Oct 22 08:55:54 2020] DMAR: [INTR-REMAP] Request device [42:00.2] f=
ault index 1600 [fault reason 37] Blocked a compatibility format interrupt =
request
>>
>> If you have any idea Ziyad and Itay can run any debugging you like.
>>
>> I suppose it is because this series is handing out compatability
>> addr/data pairs while the IOMMU is setup to only accept remap ones
>> from SRIOV VFs?
>
> So the issue seems to be that the VF device has the default irq domain
> assigned and not the remapping domain. Let me stare into the code to see
> how these VF devices are set up and registered with the IOMMU/remap
> unit.

Found the reason. Will fix it after walking the dogs. Brain needs some
fresh air.

Thanks,

        tglx
