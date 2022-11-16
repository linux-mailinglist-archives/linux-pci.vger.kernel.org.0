Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F73E62CDEA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 23:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKPWnM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 17:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPWnL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 17:43:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1032F383;
        Wed, 16 Nov 2022 14:43:11 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668638589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vPSE1zxmc/IwudjWCvDHg6aAGi01k3cdB+P74QBZLDM=;
        b=dba5Y2X5c+0ZmGPPmIMKFNVnJbo65NEEDAjQukHhUdPm1+HtuMJPjOJeva1g7s4wOMxqBy
        krWlUtC/o+JnFv7qut2vDRPW5fg6bofOMjSYSsGiPP7A0cJBIP8VS1hYtS98kPAKbpQU5B
        aTmcssOCs3wvHNOyedej9K/klT6vikxehxOsaOOu8PQP8s/klZofjKUY3XKo050ZowN8u+
        OR5dzD9SBRM7NLANSkLe/OWiGiRoV6IEUADuHFrO+Cog3rjpxgdCcygch+oGymMmKWua2X
        x137xwxBZwalBjnCuwNM6tV5fvRLq6+ozlBipl94HL3+IX9MJcJdz/1JVdElfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668638589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vPSE1zxmc/IwudjWCvDHg6aAGi01k3cdB+P74QBZLDM=;
        b=vKB/9yZWyOJx94NJSod/PO5h9H9iwPAtCxesQxjY7ARdCvHr0BTknQ8Os0uHbs8+Jp32SS
        IyTlCmStLryqwkAg==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 25/33] PCI/MSI: Provide post-enable dynamic allocation
 interfaces for MSI-X
In-Reply-To: <20221116201926.GA1133983@bhelgaas>
References: <20221116201926.GA1133983@bhelgaas>
Date:   Wed, 16 Nov 2022 23:43:09 +0100
Message-ID: <87o7t6o70i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16 2022 at 14:19, Bjorn Helgaas wrote:
>> Also for the use cases Jason Gunthorpe pointed a single index allocation
>> is sufficient.
>
> Maybe a URL or outline the use cases so this means something in a few
> years?  I haven't followed this discussion, so it doesn't even mean
> anything to me now :)

Fair enough. Will add.
