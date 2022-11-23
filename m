Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18B1636C96
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 22:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbiKWVuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 16:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbiKWVuP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 16:50:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E867E391DC;
        Wed, 23 Nov 2022 13:50:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669240211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OYGZ+OQ5qxelo1vLefYAbKPSOBIaPb9bSn17c3dzbNo=;
        b=SV035AWEgb1QckLYvmuG9aGLSJp+M6x5TJFdtTm7HhLaLkbr08vOdIu+DPT3rPZzYZnXjK
        uc4LxuPUjoR9tlEa/jbRrGyiaci5sX/SjSbb9w6SILoe90HhvOwnle8dXgpt94MtSQkQHv
        74ar/HW+1iH8ByymXFJwRIvslRG3/dOUYXDC3MXSG8q0F3M9AcVPd3sNAAch5j0CJkmvPS
        YUTHrwTzPzNo9WK0D5NSvMHURicMpgXpDuPoTV0+S6mx+exuWoH1VoKDgtQZkk9bwkBoX/
        dHA/r1fZF51YbbhQyQPnDQU3Z/nczSKu7B+dzvhCO0LRFNNbw7qMMJTYYlQsfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669240211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OYGZ+OQ5qxelo1vLefYAbKPSOBIaPb9bSn17c3dzbNo=;
        b=J0IXugY9QKlxaIwsaZKJcdEZEB0+z095g/yyzRyf0nF5lMr73k+q6IHCuIZn0mCGlb2Mx5
        eHRp80j/DHuDe+Dw==
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: RE: [patch V2 12/33] PCI/MSI: Add support for per device MSI[X]
 domains
In-Reply-To: <87zgchew4u.ffs@tglx>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.163146917@linutronix.de>
 <BN9PR11MB5276E9AD0F86A27A23ED8CFB8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87zgchew4u.ffs@tglx>
Date:   Wed, 23 Nov 2022 22:50:11 +0100
Message-ID: <8735a9e3xo.ffs@tglx>
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

On Wed, Nov 23 2022 at 12:41, Thomas Gleixner wrote:
> On Wed, Nov 23 2022 at 08:08, Kevin Tian wrote:
>>> +bool pci_setup_msi_device_domain(struct pci_dev *pdev)
>>> +{
>>> +	if (WARN_ON_ONCE(pdev->msix_enabled))
>>> +		return false;
>>
>> the check already exists in __pci_enable_msi_range()
>>
>>> +bool pci_setup_msix_device_domain(struct pci_dev *pdev, unsigned int
>>> hwsize)
>>> +{
>>> +	if (WARN_ON_ONCE(pdev->msix_enabled))
>>> +		return false;
>>
>> ditto.
>>
>> btw according to the comment this should check pdev->msi_enabled.
>
> Yeah, those are probably redundant.

I fixed the MSIX check and kept them for paranoia reasons, so changes in
the calling code get caught.

>> This is general PCI MSI logic. So an open related to my rely to patch02,
>> is it correct for PCI core to assume that the real parent imposes all the
>> restrictions and there is no need to further go down the hierarchy?
>
> That was my working assumption and it turned out to be correct with both
> x86 and ARM.

As a follow up, I went through some of the other architectures,
especially the places which have extra limitations and it turns out that
the restriction comes always from the direct parent.

If that ever changes then we need a callback which lets us evaluate the
resulting capabilities through the hierarchy. That's nothing which can
be evaluated directly.

Just look at the x86 hierarchy with IR. IR allows multi PCI-MSI, but the
vector domain does not. Who is right? That's a decision which is made in
the particular hierarchy.

For now it's valid that the direct MSI parent has the proper set
available.

Thanks,

        tglx
