Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8C634486
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 20:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiKVT3C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 14:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiKVT3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 14:29:01 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081E564A3B;
        Tue, 22 Nov 2022 11:29:01 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id B2BB72800C96C;
        Tue, 22 Nov 2022 20:28:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A3725875C0; Tue, 22 Nov 2022 20:28:59 +0100 (CET)
Date:   Tue, 22 Nov 2022 20:28:59 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/DOE: Remove asynchronous task support
Message-ID: <20221122192859.GA20515@wunner.de>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
 <20221121111925.00003eed@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121111925.00003eed@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 11:19:25AM +0000, Jonathan Cameron wrote:
> On Sat, 19 Nov 2022 14:25:27 -0800 ira.weiny@intel.com wrote:
> > Initially, it was anticipated that DOE tasks were going to need to be
> > submitted asynchronously and the code was designed thusly.  Many
> > alternatives were discussed to fix the work initialization issue.[2]
> > 
> > However, all current users submit tasks synchronously and this has
> > therefore become an unneeded maintenance burden.  Remove the extra
> > maintenance burden by replacing asynchronous task submission with
> > a synchronous wait function.[3]
[...]
> @Lukas, I assume we don't care about the async support for SPDM going forwards?

We don't.  However:

While I wouldn't have put in the asynchronous support in the first place,
now that it exists, it wouldn't delete it either.

I would just keep it internal to doe.c and only expose a synchronous
API call, which does the pci_doe_task allocation internally on the
stack, uses the appropriate INIT_WORK variant and waits for completion.

Actually I was going to do just that... I'm working on the DOE code
but the ongoing patch submissions make things difficult for me
because I have to shoot at a moving target.

The simplest solution would probably just be the object_is_on_stack()
check and the second simplest would be the synchronous API call outlined
above.

Thanks,

Lukas
