Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E7F62C5ED
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiKPRIM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiKPRHb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:07:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A55D5B876;
        Wed, 16 Nov 2022 09:07:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668618436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hd/gKUYapNrdh0ZSm6QrYC6PPTCYxxulgG3RsV/ATaE=;
        b=YN9ryDJCC/rOCCbUcPXfjcQGAvLVHqYeD4VnXnvWk0GnhtJH/a8+axdLw1R7si8Asq7Wtm
        xmSPam/lkVBttAXhtYtNGErBXryQdJHhgSucQY5CQEAG5RjRF00VVJ7cGkoRrVPE0aTrOu
        z7rh0tYPNEfJkGWPbtVwM0gD4WU7Pj0nWFhvE5qltB+eq/UVeKZH3R+PIMuS4/5RSDHjDa
        1Cnp80V6+SGCEn3sb/SqF77dytylYbVDJGNkbSzhelSAv+xU/1SvdHsoD+1KGNrhPdueZQ
        r8D2HyQex1F7qKBhwnSmWPHO3TmAGkylb782rxLSci6kR9aYLUuK1rsViUdG8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668618436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hd/gKUYapNrdh0ZSm6QrYC6PPTCYxxulgG3RsV/ATaE=;
        b=GAWP5kCC/f3/bXYJQ5IC8uOvwVhkdzvAb+untfep11uuS3PQT/MILH+iHWpVSwHDg1cMck
        GHc81CL3JRB22pAQ==
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
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 23/39] PCI/MSI: Move pci_alloc_irq_vectors_affinity() to
 api.c
In-Reply-To: <20221116162322.GA1115421@bhelgaas>
References: <20221116162322.GA1115421@bhelgaas>
Date:   Wed, 16 Nov 2022 18:07:16 +0100
Message-ID: <87h6yyq14r.ffs@tglx>
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

On Wed, Nov 16 2022 at 10:23, Bjorn Helgaas wrote:
> On Fri, Nov 11, 2022 at 02:54:51PM +0100, Thomas Gleixner wrote:
>> + * Same as pci_alloc_irq_vectors(), but with the extra @affd parameter.
>> + * Check that function docs, and &struct irq_affinity, for more details.
>
> Is "&struct irq_affinity" some kernel-doc syntax, or is the "&"
> superfluous?

The latter.
