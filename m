Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF6C1F6BBC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 18:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgFKP7d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 11:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbgFKP7d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 11:59:33 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89205206A4;
        Thu, 11 Jun 2020 15:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591891172;
        bh=962xtKWgTDEusfx1PTcBEzMlO7DbuFNlASZTgPgTJTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hp7Wf3F9DcxzLsY1qM9fAmS0se0BjdmR22syK8qjVzgNs1mhp0NFx5ae/VnO06G9b
         XhA/V5PBd9bijIb2HlzE8a4DxF99OBmLlB1JMdLPGU+2lEufytOzGk3tXwg+CeNrID
         PSoJNDYTuIRysfEtk8+5iuKfPtgfLP2IxEPNHduc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jjPc3-0029nu-6W; Thu, 11 Jun 2020 16:59:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 11 Jun 2020 16:59:31 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org
Subject: Re: [PATCH v8 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
In-Reply-To: <BYAPR02MB5559D2F57E35F8881F5B608CA5800@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1591622338-22652-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1591622338-22652-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <c2e4b1288ce454c6ae2b2c02946d084f@kernel.org>
 <BYAPR02MB5559D2F57E35F8881F5B608CA5800@BYAPR02MB5559.namprd02.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <777c4abbbfcc99ddf968d2040bc86835@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: bharatku@xilinx.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-06-11 16:51, Bharat Kumar Gogada wrote:

[...]

>> > +/**
>> > + * xilinx_cpm_pcie_init_port - Initialize hardware
>> > + * @port: PCIe port information
>> > + */
>> > +static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port
>> > *port)
>> > +{
>> > +	if (cpm_pcie_link_up(port))
>> > +		dev_info(port->dev, "PCIe Link is UP\n");
>> > +	else
>> > +		dev_info(port->dev, "PCIe Link is DOWN\n");
>> > +
>> > +	/* Disable all interrupts */
>> > +	pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
>> > +		   XILINX_CPM_PCIE_REG_IMR);
>> > +
>> > +	/* Clear pending interrupts */
>> > +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
>> > +		   XILINX_CPM_PCIE_IMR_ALL_MASK,
>> > +		   XILINX_CPM_PCIE_REG_IDR);
>> > +
>> > +	/* Enable all interrupts */
>> > +	pcie_write(port, XILINX_CPM_PCIE_IMR_ALL_MASK,
>> > +		   XILINX_CPM_PCIE_REG_IMR);
>> > +	pcie_write(port, XILINX_CPM_PCIE_IDRN_MASK,
>> > +		   XILINX_CPM_PCIE_REG_IDRN_MASK);
>> 
>> No. I've explained in the previous review why this was a terrible 
>> thing to do,
>> and my patch got rid of it for a good reason.
>> 
>> If the mask/unmask calls do not work, please explain what is wrong, 
>> and let's
>> fix them. But we DO NOT enable interrupts outside of an irqchip 
>> callback, full
>> stop.
> The issue here is, we do not have any other register to enable
> interrupts for above
> events, in order to see an interrupt assert for these events, the
> respective mask bits
> shall be set to 1.

I still disagree, because you're not explaining anything.

We enable the interrupts as they are requested already (that's why we 
write
to the these register in the respective mask/unmask callbacks). Why do 
you
need to enable them ahead of the request?

         M.
-- 
Jazz is not dead. It just smells funny...
