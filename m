Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95054248E62
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 21:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHRTDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 15:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHRTDC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 15:03:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 447DE2076E;
        Tue, 18 Aug 2020 19:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597777381;
        bh=7H5ZWWY6YLYiTiWY7a+UJBAlG+UhyF+KVtyPoiI+3DY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lG6c7XfmiFTjSYHYrfxKb5hhYD6nIpqiB/Rpqaq0tdFteoQGT8DqDJlQ6shK6MgTI
         VpZFrJ//JYY431uMKgbwb/ByRcOPRzHDb0PYobp0Jm56cMrpp2LwSlpQ4TzZKVyT2A
         mLQU/svuX6rlC8PEFLK3Mjoj9w6cRfaxJwpgL4D0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k86st-00406W-Q2; Tue, 18 Aug 2020 20:02:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Aug 2020 20:02:59 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] PCI: rockchip: Work around missing device_type
 property in DT
In-Reply-To: <CAGETcx-hkz8fyAHuhRi=JhBFu4YUmL2UpHfgs7doLHK-RdKA0A@mail.gmail.com>
References: <20200815125112.462652-2-maz@kernel.org>
 <20200815232228.GA1325245@bjorn-Precision-5520>
 <87pn7qnabq.wl-maz@kernel.org>
 <CAL_Jsq+fDNa60+6+s9MwVjUFUPAuc43+uMx4Fm2nZhUgrV7LEg@mail.gmail.com>
 <e2cde177e82fbdf158732ad73ccdc6c5@kernel.org>
 <CAL_JsqL1_d2grS3Pz6NNeVAOMPbx_hAe+MrseQeQp=bHRQ7rfQ@mail.gmail.com>
 <72c10e43023289b9a4c36226fe3fd5d9@kernel.org>
 <CAGETcx-hkz8fyAHuhRi=JhBFu4YUmL2UpHfgs7doLHK-RdKA0A@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <d6f0894a81c645d66480310cd741a44e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: saravanak@google.com, robh@kernel.org, helgaas@kernel.org, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, heiko@sntech.de, shawn.lin@rock-chips.com, bhelgaas@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-08-18 18:48, Saravana Kannan wrote:
> On Tue, Aug 18, 2020 at 10:34 AM Marc Zyngier <maz@kernel.org> wrote:

[...]

>> OK. So how about something like this?
>> 
>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>> index 590493e04b01..a7a6ee599b14 100644
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
>> @@ -134,9 +134,13 @@ static int of_bus_pci_match(struct device_node 
>> *np)
>>          * "pciex" is PCI Express
>>          * "vci" is for the /chaos bridge on 1st-gen PCI powermacs
>>          * "ht" is hypertransport
>> +        *
>> +        * If none of the device_type match, and that the node name is
>> +        * "pcie", accept the device as PCI (with a warning).
>>          */
>>         return of_node_is_type(np, "pci") || of_node_is_type(np, 
>> "pciex") ||
>> -               of_node_is_type(np, "vci") || of_node_is_type(np, 
>> "ht");
>> +               of_node_is_type(np, "vci") || of_node_is_type(np, 
>> "ht") ||
>> +               WARN_ON_ONCE(of_node_name_eq(np, "pcie"));
> 
> I don't think we need the _ONCE. Otherwise, it'd warn only for the
> first device that has this problem.

Because probing devices doesn't necessarily occur once. Case in point,
it takes *10 to 15* attempts for a rk3399 system such as mine to finally
probe its PCIe device, thanks to the wonderful -EPROBE_DEFER.

Do I want to see the same stack trace 10 (or more) times? No.

> How about?
> WARN(of_node_name_eq(np, "pcie"), "Missing device type in %pOF", np)
> 
> That'll even tell them which node is bad.

I explained my objections above. Spitting out the device node is
useful, but there is no need to be exhaustive (if you're in a
position to fix the DT, you can track all the broken instances
for your device easily).

I'm actually minded to tone it down even more, because the stack
trace is meaningless to most users. See below for a revised patch.

         M.

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 590493e04b01..b37bd9cc2810 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -128,15 +128,29 @@ static unsigned int of_bus_pci_get_flags(const 
__be32 *addr)
   * PCI bus specific translator
   */

+static bool of_node_is_pcie(struct device_node *np)
+{
+	bool is_pcie = of_node_name_eq(np, "pcie");
+
+	if (is_pcie)
+		pr_warn_once("%pOF: Missing device_type\n", np);
+
+	return is_pcie;
+}
+
  static int of_bus_pci_match(struct device_node *np)
  {
  	/*
   	 * "pciex" is PCI Express
  	 * "vci" is for the /chaos bridge on 1st-gen PCI powermacs
  	 * "ht" is hypertransport
+	 *
+	 * If none of the device_type match, and that the node name is
+	 * "pcie", accept the device as PCI (with a warning).
  	 */
  	return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
-		of_node_is_type(np, "vci") || of_node_is_type(np, "ht");
+		of_node_is_type(np, "vci") || of_node_is_type(np, "ht") ||
+		of_node_is_pcie(np);
  }

  static void of_bus_pci_count_cells(struct device_node *np,

-- 
Jazz is not dead. It just smells funny...
