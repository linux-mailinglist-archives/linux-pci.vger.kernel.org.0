Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EF262CDE6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 23:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiKPWmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 17:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPWmo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 17:42:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDF34874C;
        Wed, 16 Nov 2022 14:42:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668638562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ituL+5ajtqHTp/rRBNd8Uu/Ztgs6oDEu52WFsyF1Bk=;
        b=Z3Pv8ANvvsb4EGGUVTHJRrtmypVSSMlrlf2puTdMsAbgSuoJlxXYF95MwYlnPfmFY6DBJh
        5aQOsZQuYbsw+hZjbk1vOOQrZtpJuJoH6+mULZnN3H4/b9SjSNrsWEwc56HZgIsamTtwD/
        1w/v877HWvUDoeCuCDQvXWbK3htJiPkvdTosf0qU+qsKA4Ou7wREIGc4iCyszeBGL1s7iP
        bsJ5qO6bl+fQOQpMfPxMaBz9DvTutlb694sHx5K4rf/+yLuflrXg3glR8Yla3QwPeLre+W
        U/fPYK/1S2GJhI+QR7M6bzeTEMTsLck+UXVyzMfBepgc+ckUArptHYkoBEvs2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668638562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ituL+5ajtqHTp/rRBNd8Uu/Ztgs6oDEu52WFsyF1Bk=;
        b=J/DvfLHrv5avf1d+YK3c734FMMYpjBGEnUaIR8mt3DnyYnDyuXwbRnI9Au6JwCjJucwIas
        uC7J0XwuTFj8O2Cw==
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
Subject: Re: [patch 24/33] PCI/MSI: Provide prepare_desc() MSI domain op
In-Reply-To: <20221116202619.GA1134246@bhelgaas>
References: <20221116202619.GA1134246@bhelgaas>
Date:   Wed, 16 Nov 2022 23:42:42 +0100
Message-ID: <87r0y2o719.ffs@tglx>
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

On Wed, Nov 16 2022 at 14:26, Bjorn Helgaas wrote:
> On Fri, Nov 11, 2022 at 02:58:49PM +0100, Thomas Gleixner wrote:
>> Dynamic MSI-X vector allocation post MSI-X allows to allocate vectors at a
>> given index or at any free index in the available table range.
>
> Is "post MSI-X" missing something?  "post MSI-X enablement" or
> something?

Yes. That was the plan.

>> The latter
>> requires that the core code selects the index at descriptor allocation time.
>> 
>> This requires that the PCI/MSI-X specific setup of the MSI-X descriptor,
>> which is partially depending on the chosen index happens after allocation.
>
> Is there a comma missing after "index"?  I.e., setup of the descriptor
> partially depends on the chosen index?  And the above requires that
> setup happens after allocation?

Yes.

Thanks,

        tglx
