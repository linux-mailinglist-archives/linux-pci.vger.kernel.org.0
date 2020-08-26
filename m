Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FAF252CD0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Aug 2020 13:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgHZLQ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Aug 2020 07:16:58 -0400
Received: from foss.arm.com ([217.140.110.172]:44394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgHZLQx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Aug 2020 07:16:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2ADE1FB;
        Wed, 26 Aug 2020 04:16:50 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BE143F71F;
        Wed, 26 Aug 2020 04:16:49 -0700 (PDT)
References: <20200824102317.1038259-1-maz@kernel.org> <20200824102317.1038259-6-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/9] fsl-msi: Provide default retrigger callback
In-reply-to: <20200824102317.1038259-6-maz@kernel.org>
Date:   Wed, 26 Aug 2020 12:16:47 +0100
Message-ID: <jhj7dtlejxc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Marc,

Many thanks for picking this up!
Below's the only comment I have, the rest LGTM.

On 24/08/20 11:23, Marc Zyngier wrote:
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/bus/fsl-mc/fsl-mc-msi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
> index 8edadf05cbb7..5306ba7dea3e 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-msi.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
> @@ -144,6 +144,8 @@ static void fsl_mc_msi_update_chip_ops(struct msi_domain_info *info)
>        */
>       if (!chip->irq_write_msi_msg)
>               chip->irq_write_msi_msg = fsl_mc_msi_write_msg;
> +	if (!chip->irq_retrigger)
> +		chip->irq_retrigger = irq_chip_retrigger_hierarchy;

AFAICT the closest generic hook we could use here is

  msi_create_irq_domain() -> msi_domain_update_chip_ops()

which happens just below the fsl-specific ops update.


However, placing a default .irq_retrigger callback in there would affect any
and all MSI domain. IOW that would cover PCI and platform MSIs (covered by
separate patches in this series), but also some x86 ("dmar" & "hpet") and
TI thingies.

I can't tell right now how bad of an idea it is, but I figured I'd throw
this out there.


>  }
>
>  /**
