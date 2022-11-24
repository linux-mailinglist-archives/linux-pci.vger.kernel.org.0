Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE04637A1E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 14:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiKXNo2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 08:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKXNo1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 08:44:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39515D0DD6;
        Thu, 24 Nov 2022 05:44:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAA1C62111;
        Thu, 24 Nov 2022 13:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DB5C433C1;
        Thu, 24 Nov 2022 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669297466;
        bh=Zi0kEz1Ne1gqJRwmMX3ATe1hl8Poj2hXWpS/SdHGtag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L22S/rAIuW8X+WR7BvMRIxjjj3idOWjskMS13/IZ5aNySPBBTfUimc1a6hw4ROtIH
         +UnPdflrTcUAHtakruhIFbIbZ6Bev7DquScuDXEvIGYvEyGVgn+u5fKRMPBzcLxRnI
         WhaEqdWu2BMFyag4zbqJURgMrz+ishDlsAY9blseO0qFhyFDaG56hldgOm1W56gsZP
         FGmwU0RFgcl2AoAELPOW1GaSOg/ry9T333QXjWt8JtFgnhRJBUE9Y8iL2VniOI44NE
         vu6nbr7T/cKiDejinn2NIHB5yIx2EBsanSzFW9ziyGEs3Y5SqaHdvb8QUXpTYC5Vp6
         6XIYQZIjEcRMA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oyCWd-008NxM-UG;
        Thu, 24 Nov 2022 13:44:24 +0000
Date:   Thu, 24 Nov 2022 13:44:23 +0000
Message-ID: <86y1s0mpqg.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch V2 01/21] genirq/msi: Move IRQ_DOMAIN_MSI_NOMASK_QUIRK to MSI flags
In-Reply-To: <20221121083325.573428885@linutronix.de>
References: <20221121083210.309161925@linutronix.de>
        <20221121083325.573428885@linutronix.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org, joro@8bytes.org, will@kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org, jgg@mellanox.com, dave.jiang@intel.com, alex.williamson@redhat.com, kevin.tian@intel.com, dan.j.williams@intel.com, logang@deltatee.com, ashok.raj@intel.com, jdmason@kudzu.us, allenbh@gmail.com, jgg@nvidia.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Nov 2022 14:36:19 +0000,
Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> It's truly a MSI only flag and for the upcoming per device MSI domains this
> must be in the MSI flags so it can be set during domain setup without
> exposing this quirk outside of x86.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/x86/kernel/apic/msi.c |    5 ++---
>  include/linux/irqdomain.h  |    9 +--------
>  include/linux/msi.h        |    6 ++++++
>  kernel/irq/msi.c           |    2 +-
>  4 files changed, 10 insertions(+), 12 deletions(-)

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.
