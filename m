Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF9635BFB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 12:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbiKWLlj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 06:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbiKWLlc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 06:41:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1329C1095AA;
        Wed, 23 Nov 2022 03:41:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669203686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kc21O6wY4Q6r+mTnObxfs2KOMyS/UVcJmynZXV3Alfo=;
        b=fJiPVVKvGmb3Z6MlKrSoOE572tB3jWNzQMJM2ZsLFdhyLEI3dHpVghflAbJGIGkivhVX0v
        EcgfZViiax0lJTf3gYuumHZo3ioTTtSoTctDYt3ZKJE30lFj3EhRMozgeeZMFlRMsNb+i3
        FfIV+VT0RdvY/Sy/29hY3d8XXxot7GcUE3ItMpDnNNJRy+qJGgOH5bBx2oqLZmVSxmyvfv
        XXqvMr/7wIpT3Z6Xig4Xv1BBBZ6F3m3LPbKXmNvSO5KyAFJnO4DRkvxKkvT5j83W4tnb5c
        SFIsySN5GyQImHWDMr9HfcNnSkD/ssADIkY3IXCJZfyPgAS+0Vz6AUjkyaeglQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669203686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kc21O6wY4Q6r+mTnObxfs2KOMyS/UVcJmynZXV3Alfo=;
        b=qd4XW1N6UovQIjWlGHprPa+Nv/Om0cvvHmA4Oj16C7YLu7d+3dJoaWLpkMfTCE5V6n0gxK
        ByXCq0cvkV1AMNAA==
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
        Allen Hubbe <allenbh@gmail.com>
Subject: RE: [patch V2 19/33] genirq/msi: Provide msi_desc::msi_data
In-Reply-To: <BN9PR11MB5276C788BFDBC254CE5912278C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.546352933@linutronix.de>
 <BN9PR11MB5276C788BFDBC254CE5912278C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Wed, 23 Nov 2022 12:41:26 +0100
Message-ID: <87wn7lew49.ffs@tglx>
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

On Wed, Nov 23 2022 at 08:27, Kevin Tian wrote:

>> From: Thomas Gleixner <tglx@linutronix.de>
>> Sent: Monday, November 21, 2022 10:38 PM
>> 
>> The upcoming support for PCI/IMS requires to store some information
>> related
>> to the message handling in the MSI descriptor, e.g. PASID or a pointer to a
>> queue.
>> 
>> Provide a generic storage struct which maps over the existing PCI specific
>> storage which means the size of struct msi_desc is not getting bigger.
>> 
>> It contains a iomem pointer for device memory based IMS and a union of a
>> u64 and a void pointer which allows the device specific IMS implementations
>> to store the necessary information.
>
> stale comment.
>
>> 
>> The iomem pointer is set up by the domain allocation functions.
>> 
>> The data union msi_dev_cookie is going to be handed in when allocating an
>
> no msi_dev_cookie now.

Ooops.
