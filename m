Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7862DC48
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 14:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiKQNHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 08:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiKQNHi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 08:07:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C059177;
        Thu, 17 Nov 2022 05:07:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668690453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttz1/GMaTk8h4TD14aPsbGIxMJv2rHjmwjhSDqhucs0=;
        b=WDZLbEqveG5PJjvIG4M84A7mMytlGNV61Gw/YoP/QDOLetHLKNzxZ+trhb1EyoXlHMRPCY
        uleqRqzLb6qyJafV7I1Gqw77uQ+CL7yRAXYYLJtPbH+CRgOFjb6Vq/SxWxmOk6937uf5ef
        9VwJBtcPyyC7HCh0bYgycC5xCmA/8sST/2E8pOe4E148IEPGtXVFI6q6qZGeNE+j3OY1jo
        QjDBfDC8AF5fbQ+neAWN6pyXgjBX6V6HJ2Yp2YSDLioOXVmnS934gU1wvrFYyMqwWKZSbM
        O90UyTmYC2HHKEnS9SLVobc7Fm3sQmMNZL1LdzKmSNuNEMLk02Fmth8gzQXnZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668690453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttz1/GMaTk8h4TD14aPsbGIxMJv2rHjmwjhSDqhucs0=;
        b=L9t4AwQosUgasEO8gwRfKjPJm0d6kdrZ24AvdpYKQri4d72MF1pCCaBP2DVDgm+HALY4kc
        v0LLaVo5cdrzG7Dw==
To:     Ashok Raj <ashok.raj@intel.com>
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
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 01/39] PCI/MSI: Check for MSI enabled in
 __pci_msix_enable()
In-Reply-To: <Y3UEFBJW1toFJZGn@a4bf019067fa.jf.intel.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122013.653556720@linutronix.de>
 <Y3UEFBJW1toFJZGn@a4bf019067fa.jf.intel.com>
Date:   Thu, 17 Nov 2022 14:07:33 +0100
Message-ID: <87cz9ln2zu.ffs@tglx>
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

On Wed, Nov 16 2022 at 07:39, Ashok Raj wrote:
> On Fri, Nov 11, 2022 at 02:54:15PM +0100, Thomas Gleixner wrote:
>
> Can the pre-enabled checks for msi and msix be moved up before any vector
> range check?
>
> not that it matters for how it fails, does EBUSY sound better?

Does any caller care about the error code or about the ordering in which
the caller stupity is detected?
