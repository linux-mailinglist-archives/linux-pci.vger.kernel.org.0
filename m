Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98D9642B8D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 16:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiLEPX0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 10:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiLEPXD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 10:23:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6311FF88;
        Mon,  5 Dec 2022 07:20:53 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670253632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l21gIdgMYZaabZsaA1IPHJrlxOXwuiJTen3Q2rbgl+E=;
        b=D027ajbWQhryQtqS80uG1eTCEnjySa229Wb7kM74xNp3wv0Hfu5Uqit8JOMQzawg1QeMGr
        fGukKeJPbCttxKq8UHEc/Dr/4DEa3X2K/d3VfdO5kd4LWHuBvVYREyCP8TU/q6vi1aEkcz
        OPXx+sF4cPNEL+RReCSpG9ZOb1r+IumMkVmKz2RfjNympHBljwJMKAIy7/o5DCKprYD6h4
        60fQbfZrRARdiKjQn+c34GJvPs8tKNh5iUCzPe2jOAxWkF5vUeiqmNcZi4uAqouTxdtRnP
        oHI+copJWlNHP12rog/5D9+IdwXS3nNW8+JgHS5i6COszehLOIcySejJPwD6EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670253632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l21gIdgMYZaabZsaA1IPHJrlxOXwuiJTen3Q2rbgl+E=;
        b=nEhlWcbwHl/mj7qOKF6aHnm5gxYpSiQ2+GA7cZ/OIFzi5xuuDXpI/bEMNmK4cRE9aVvhGN
        qcSyogEUKtiTigDA==
To:     Reinette Chatre <reinette.chatre@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: Re: [patch 33/33] irqchip: Add IDXD Interrupt Message Store driver
In-Reply-To: <87sfhxoa7i.ffs@tglx>
References: <20221111133158.196269823@linutronix.de>
 <20221111135207.141746268@linutronix.de>
 <4a15c569-0545-20ac-e74c-ae17f7eb067d@intel.com> <87sfhxoa7i.ffs@tglx>
Date:   Mon, 05 Dec 2022 16:20:31 +0100
Message-ID: <87v8mpg9mo.ffs@tglx>
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

On Fri, Dec 02 2022 at 20:51, Thomas Gleixner wrote:
> On Fri, Dec 02 2022 at 09:55, Reinette Chatre wrote:
>> With the first change I am able to test IMS on the host using devmsi-v2-part3
>> of the development branch. I did try to update to the most recent development
>> to confirm all is well but version devmsi-v3.1-part3 behaves differently
>> in that pci_ims_alloc_irq() returns successfully but the returned
>> virq is 0. This triggers a problem when request_threaded_irq() runs and
>> reports:
>> genirq: Flags mismatch irq 0. 00000000 (idxd-portal) vs. 00015a00 (timer)
>
> Bah. Let me figure out what I fat-fingered there.

tag devmsi-v3.2-part3 works again.
