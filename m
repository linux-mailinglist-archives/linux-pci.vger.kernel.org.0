Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C6E220D9B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 15:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbgGONFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 09:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbgGONFK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 09:05:10 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 659CC20657;
        Wed, 15 Jul 2020 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594818309;
        bh=/JbnkKca9isth2Byqb4RT/WZLJphSaAVAFp0XT01uu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=11WLdv3zamDVHmM6A7sD3vIrgCjWwh2+roNC+ngAh1r1bKzwRyZN5Hv+dK7odXwI5
         Z96N6IXf1vw98heHULxcTXjVl85NZfzyR30Aywy25KKdwDK5SlEJumKgoTpN0pRPd3
         3TcKkQHsxLcEAqtcWXhh1ufg29KGZjgEkTtjUSf0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jvh5v-00BzoN-VJ; Wed, 15 Jul 2020 14:05:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 15 Jul 2020 14:05:07 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Diana Craciun <diana.craciun@oss.nxp.com>,
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
        Will Deacon <will@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v2 11/12] bus/fsl-mc: Refactor the MSI domain creation in
 the DPRC driver
In-Reply-To: <20200619082013.13661-12-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-12-lorenzo.pieralisi@arm.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <bd07f44dad1d029e0d023202cbf5fc94@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org, diana.craciun@oss.nxp.com, iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh+dt@kernel.org, rjw@rjwysocki.net, joro@8bytes.org, guohanjun@huawei.com, bhelgaas@google.com, sudeep.holla@arm.com, robin.murphy@arm.com, catalin.marinas@arm.com, will@kernel.org, makarand.pawagi@nxp.com, laurentiu.tudor@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-06-19 09:20, Lorenzo Pieralisi wrote:
> From: Diana Craciun <diana.craciun@oss.nxp.com>
> 
> The DPRC driver is not taking into account the msi-map property
> and assumes that the icid is the same as the stream ID. Although
> this assumption is correct, generalize the code to include a
> translation between icid and streamID.
> 
> Furthermore do not just copy the MSI domain from parent (for child
> containers), but use the information provided by the msi-map property.
> 
> If the msi-map property is missing from the device tree retain the old
> behaviour for backward compatibility ie the child DPRC objects
> inherit the MSI domain from the parent.
> 
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> ---
>  drivers/bus/fsl-mc/dprc-driver.c            | 31 ++++++---------------
>  drivers/bus/fsl-mc/fsl-mc-bus.c             |  4 +--
>  drivers/bus/fsl-mc/fsl-mc-msi.c             | 31 +++++++++++++--------
>  drivers/bus/fsl-mc/fsl-mc-private.h         |  6 ++--
>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 15 +++++++++-
>  5 files changed, 47 insertions(+), 40 deletions(-)

For this patch and the following one:

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
