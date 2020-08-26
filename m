Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D8225350A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Aug 2020 18:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHZQhd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Aug 2020 12:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgHZQhd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Aug 2020 12:37:33 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D666206FA;
        Wed, 26 Aug 2020 16:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598459852;
        bh=pBc8gM5KOX/QRk7tf+c7+MrN051X6wSwRL8XjLMwkpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZFZ8/xASQAxvIcEud6yRT7vUyq4aWJI1IWNLpTVMDlYbIMy6fjnvfBTeXUdx//xYw
         V2YdkX+e4/z0cYtfxi5MXYXFYyWfVsAecZgNKOVo0AIyKG7Dldiu6GcpX4kvJA4pu6
         JAGJW1Ier1tVZvfblXe2e3pC60/5zBEt6idCvOl4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kAyQU-006uP9-GY; Wed, 26 Aug 2020 17:37:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Aug 2020 17:37:30 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/9] fsl-msi: Provide default retrigger callback
In-Reply-To: <jhj7dtlejxc.mognet@arm.com>
References: <20200824102317.1038259-1-maz@kernel.org>
 <20200824102317.1038259-6-maz@kernel.org> <jhj7dtlejxc.mognet@arm.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <70107b944534c6a0eeff83e43b05865e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: valentin.schneider@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, gregory.clement@bootlin.com, jason@lakedaemon.net, laurentiu.tudor@nxp.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Valentin,

On 2020-08-26 12:16, Valentin Schneider wrote:
> Hi Marc,
> 
> Many thanks for picking this up!
> Below's the only comment I have, the rest LGTM.
> 
> On 24/08/20 11:23, Marc Zyngier wrote:
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  drivers/bus/fsl-mc/fsl-mc-msi.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c 
>> b/drivers/bus/fsl-mc/fsl-mc-msi.c
>> index 8edadf05cbb7..5306ba7dea3e 100644
>> --- a/drivers/bus/fsl-mc/fsl-mc-msi.c
>> +++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
>> @@ -144,6 +144,8 @@ static void fsl_mc_msi_update_chip_ops(struct 
>> msi_domain_info *info)
>>        */
>>       if (!chip->irq_write_msi_msg)
>>               chip->irq_write_msi_msg = fsl_mc_msi_write_msg;
>> +	if (!chip->irq_retrigger)
>> +		chip->irq_retrigger = irq_chip_retrigger_hierarchy;
> 
> AFAICT the closest generic hook we could use here is
> 
>   msi_create_irq_domain() -> msi_domain_update_chip_ops()
> 
> which happens just below the fsl-specific ops update.
> 
> 
> However, placing a default .irq_retrigger callback in there would 
> affect any
> and all MSI domain. IOW that would cover PCI and platform MSIs (covered 
> by
> separate patches in this series), but also some x86 ("dmar" & "hpet") 
> and
> TI thingies.
> 
> I can't tell right now how bad of an idea it is, but I figured I'd 
> throw
> this out there.

The problem with this approach is that it requires the resend path to be
cooperative and actually check for more than the top-level irq_data.
Otherwise you'd never actually trigger the HW resend if it is below
the top level.

But I like the idea though. Something like this should do the trick, and
is admittedly a bug fix:

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index c48ce19a257f..d11c729f9679 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -86,6 +86,18 @@ static int irq_sw_resend(struct irq_desc *desc)
  }
  #endif

+static int try_retrigger(struct irq_desc *desc)
+{
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	return irq_chip_retrigger_hierarchy(&desc->irq_data);
+#else
+	if (desc->irq_data.chip->irq_retrigger)
+		return desc->irq_data.chip->irq_retrigger(&desc->irq_data);
+
+	return 0;
+#endif
+}
+
  /*
   * IRQ resend
   *
@@ -113,8 +125,7 @@ int check_irq_resend(struct irq_desc *desc, bool 
inject)

  	desc->istate &= ~IRQS_PENDING;

-	if (!desc->irq_data.chip->irq_retrigger ||
-	    !desc->irq_data.chip->irq_retrigger(&desc->irq_data))
+	if (!try_retrigger(desc))
  		err = irq_sw_resend(desc);

  	/* If the retrigger was successfull, mark it with the REPLAY bit */

In general, introducing a irq_chip_retrigger_hierarchy() call
shouldn't be problematic as long as we don't overwrite an existing
callback.

I'll have a look at respining the series with that in mind.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
