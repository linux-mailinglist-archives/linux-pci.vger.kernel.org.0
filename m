Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA6366318D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 21:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjAIUcx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 15:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbjAIUcs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 15:32:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2180F631AB;
        Mon,  9 Jan 2023 12:32:46 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673296365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hw/0oH2C5TyrGWJ+96YUv3zgISrx89bAQtHhU0yW/ZM=;
        b=EW+zDZJxz6OyVBYpxCaTTXZUDErFa/CkZ+y26x2qjn8WH9XJWFxmamEGtbncmZM0WtEfwk
        fFsAuXFc8QgX62JXMJrPaoiNJvkcPMCVNKpz1fUhtl0MqYagSvGAplx9FzTU34gwia5AvK
        Me+9LwI5rfmd6bcWPw/YPRb3OGU41/ZXBzBSxvsxysRQcQo0sN3y8D0ziOyTNvJn9MvuaN
        hUpGJXMqvacPjdrKCadQduw6Nw/JnBeqWkwGGWGqxa/P9DKqrXxnFW6ihW8VyKHpucFdT3
        OWFVR7wqY+aomarSFTfy+d60TPCpLqVu/CgFcOT5VFiP/wbQHEtbTHLUCKuaTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673296365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hw/0oH2C5TyrGWJ+96YUv3zgISrx89bAQtHhU0yW/ZM=;
        b=ZB+xeomHEhsnoDEu+u5PqFuIsB0Btz5LE2GeBQhczTdLYJxsa/sb9q1mFrh9Ce/tvgW326
        E8X7RWdkiHuh/YCw==
To:     Jason Gunthorpe <jgg@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V3 13/33] x86/apic/vector: Provide MSI parent domain
In-Reply-To: <Y7VyXNbWMdWWAC6d@nvidia.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232326.034672592@linutronix.de> <Y7VyXNbWMdWWAC6d@nvidia.com>
Date:   Mon, 09 Jan 2023 21:32:44 +0100
Message-ID: <87v8lfjvo3.ffs@tglx>
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

Jason!

On Wed, Jan 04 2023 at 08:34, Jason Gunthorpe wrote:
>
> Our test team has discovered some kmem leak complaints on rc1 and
> bisected it to this patch.
>
> I don't see an obvious way that fwnode gets destroyed here. So maybe
> it should be like this?

I'm back from vacation now. Will have a look tomorrow.

Thanks,

        tglx
