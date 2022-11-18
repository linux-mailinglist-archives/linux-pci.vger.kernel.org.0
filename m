Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F232562F696
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 14:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiKRNwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 08:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRNwp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 08:52:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3191BE96;
        Fri, 18 Nov 2022 05:52:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668779563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XP6sK7QWwJa+DZ5im8IhUJV+NTI8HH+a7y081FK5inE=;
        b=rz5TY2iXIURtnZN6RLG86Ut+NytnCN6JIPhOg1Z1LqN/7Rv4nAWNdf0dt84LUPml88BbPS
        qLd6O1IQ+/3ZP6O+zcZwPlsc1gmqYZJjT7Tm79pW0t3gU3jjGidJIwT2gQR4j2bWFRReAm
        O6Uyg9OATJAl2BJ3x1EtTUjijNIiriZgVVi5kf40qtwmN0s9rX3T9iIs/qdjivKR18kLY+
        o0D3E1fc++XDCAPM6tm8sX6XOFHtymguJlzlt018rB4gYWZWxaoJckdjGvn6JdcB67BdNI
        n1sm5E9UnzObOVSanbIcu/qtE0ZM76+219py+N8KkPgo8NPiTOIc6XKw14m9VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668779563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XP6sK7QWwJa+DZ5im8IhUJV+NTI8HH+a7y081FK5inE=;
        b=AL2wBG2eLtBOd2rbp2WH8Q/HM2N7tsBU7D5eUnGTy0EQ2haYMmh/Y2R7eVsdH+V6AY4d9h
        +smSeKkzxLPlhYBQ==
To:     Jason Gunthorpe <jgg@nvidia.com>
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
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 02/33] genirq/msi: Provide struct msi_parent_ops
In-Reply-To: <8735ahmv2l.ffs@tglx>
References: <20221111133158.196269823@linutronix.de>
 <20221111135205.368911521@linutronix.de> <Y3Uynk6brtNVFUH7@nvidia.com>
 <8735ahmv2l.ffs@tglx>
Date:   Fri, 18 Nov 2022 14:52:43 +0100
Message-ID: <878rk8jro4.ffs@tglx>
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

On Thu, Nov 17 2022 at 16:58, Thomas Gleixner wrote:
> On Wed, Nov 16 2022 at 14:57, Jason Gunthorpe wrote:
>
>> And perhaps it would be a bit clearer to put the parent_domain inside
>> the msi_domain_info, which is basically acting as an argument bundle
>> for a future allocation call?
>
> Maybe. Let me try.

No. That's redundant storage because the domain creation stores the
parent domain in irqdomain::parent which is what the hierarchy code
uses. That code does not know about msi_domain_info.

Thanks,

        tglx
