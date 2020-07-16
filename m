Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB9221DBA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 09:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgGPH5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 03:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgGPH5J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jul 2020 03:57:09 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3472120657;
        Thu, 16 Jul 2020 07:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594886228;
        bh=lF6V4pThpgd1ETqa/+C0kE0OsT7SQmJj3FXX4kf+cNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VsJgQucNe+tORSuGENCHPNa2BMvAsbolf2wFejeM2VFlX2cbvvZUjPeT2UhxohJQv
         u4qIHJNBHt7wYmWQnDf9Ow829zQsoMD8NiqTe1Ebs+tmttdHnQMVmV+OuwzzjBm5S5
         T/6aNfgNS271UBnzQ227W+foVJvVP2lSFXLJEcIs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jvylO-00CEd7-OZ; Thu, 16 Jul 2020 08:57:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Jul 2020 08:57:06 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Makarand Pawagi <makarand.pawagi@nxp.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Diana Madalina Craciun (OSS)" <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
In-Reply-To: <DB7PR04MB498603933E805C0E4053D4B7EB7F0@DB7PR04MB4986.eurprd04.prod.outlook.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-13-lorenzo.pieralisi@arm.com>
 <a7845603-9bc9-9099-dfc4-19b7bc4f4e44@nxp.com>
 <20200709091950.GA18149@e121166-lin.cambridge.arm.com>
 <DB7PR04MB4986D1A0BB7B685911DF4831EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
 <203372be-144c-54ba-d011-30d0746dd615@nxp.com>
 <DB7PR04MB4986C63772CB47A2A827D028EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
 <d41589da-c2f9-a750-f57a-25dccf51e69f@oss.nxp.com>
 <DB7PR04MB4986A56021750A3D104CA244EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
 <20200715100636.GA31330@e121166-lin.cambridge.arm.com>
 <DB7PR04MB498603933E805C0E4053D4B7EB7F0@DB7PR04MB4986.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <20ac0bcf43a621e7b51d9badb91d2a71@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: makarand.pawagi@nxp.com, lorenzo.pieralisi@arm.com, diana.craciun@oss.nxp.com, laurentiu.tudor@nxp.com, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh+dt@kernel.org, rjw@rjwysocki.net, joro@8bytes.org, guohanjun@huawei.com, bhelgaas@google.com, sudeep.holla@arm.com, robin.murphy@arm.com, catalin.marinas@arm.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-07-16 04:23, Makarand Pawagi wrote:
>> -----Original Message-----
>> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[...]

>> Anyway - you need to seek feedback from Marc on whether patches
>> 11 and 12 are OK from an irqchip perspective, it is possible we can 
>> take the rest
>> of the series independently if everyone agrees but I don't necessarily 
>> see a
>> reason for that.
>> 
>> Long story short: you need Marc's ACK on [11-12], it is your code.
>> 
> Hi Marc, can you please review/ack this patch?

https://lore.kernel.org/linux-acpi/bd07f44dad1d029e0d023202cbf5fc94@kernel.org/

         M.
-- 
Jazz is not dead. It just smells funny...
