Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7F27771C7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 09:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjHJHos (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 03:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHJHor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 03:44:47 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4477AC3;
        Thu, 10 Aug 2023 00:44:47 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id CDB03100D586D;
        Thu, 10 Aug 2023 09:44:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A2EB21CDF35; Thu, 10 Aug 2023 09:44:44 +0200 (CEST)
Date:   Thu, 10 Aug 2023 09:44:44 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <20230810074444.GA11861@wunner.de>
References: <20230809232851.1004023-1-alistair.francis@wdc.com>
 <2023081005-ground-muster-63c8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081005-ground-muster-63c8@gregkh>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 10, 2023 at 07:05:12AM +0200, Greg KH wrote:
> On Wed, Aug 09, 2023 at 07:28:51PM -0400, Alistair Francis wrote:
> > v3:
> >  - Expose each DOE feature as a separate file
> 
> But you don't actually have anything in the sysfs files, why not?

He wants to expose a list of supported protocols.

He first exposed the list in a single attribute, separated by newlines.
Which made sense because it allows users to grep for a specific protocol.

You told him not to expose multiple values in a single attribute.
So he's exposing the available protocols each in an empty file.
The file name contains the protocol.

You got what you asked for. ;)


> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -56,6 +56,10 @@ struct pci_doe_mb {
> >  	wait_queue_head_t wq;
> >  	struct workqueue_struct *work_queue;
> >  	unsigned long flags;
> > +
> > +#ifdef CONFIG_SYSFS
> > +	struct device_attribute *sysfs_attrs;
> > +#endif
> 
> Please don't put #ifdefs in .c files if you can prevent it.  I think
> this will work just fine if you don't have the #ifdef.  And who would be
> using pci without sysfs?

People with space-constrained devices such as routers.

It is perfectly legal to compile a kernel with CONFIG_PCI=y and
CONFIG_SYSFS=n.

And it is reasonable not to include code in the kernel which has
specifically been deselected in the kernel config.

Thanks,

Lukas
