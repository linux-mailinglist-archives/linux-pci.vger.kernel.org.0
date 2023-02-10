Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3716929DE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 23:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjBJWLA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 17:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjBJWK7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 17:10:59 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE21863591;
        Fri, 10 Feb 2023 14:10:58 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 3E4773004D11E;
        Fri, 10 Feb 2023 23:10:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1EFE9D39B8; Fri, 10 Feb 2023 23:10:57 +0100 (CET)
Date:   Fri, 10 Feb 2023 23:10:57 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI/DOE: Relax restrictions on request and
 response size
Message-ID: <20230210221057.GA9868@wunner.de>
References: <20230124124315.00000a5c@Huawei.com>
 <20230124235155.GA1114594@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124235155.GA1114594@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 24, 2023 at 05:51:55PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 24, 2023 at 12:43:15PM +0000, Jonathan Cameron wrote:
> > On Mon, 23 Jan 2023 11:20:00 +0100 Lukas Wunner <lukas@wunner.de> wrote:
> > > An upcoming user of DOE is CMA (Component Measurement and Authentication,
> > > PCIe r6.0 sec 6.31).
> > > 
> > > It builds on SPDM (Security Protocol and Data Model):
> > > https://www.dmtf.org/dsp/DSP0274
> > > 
> > > SPDM message sizes are not always a multiple of dwords.  To transport
> > > them over DOE without using bounce buffers, allow sending requests and
> > > receiving responses whose final dword is only partially populated.
[...]
> > IIRC, at the time feedback was strongly in favour of making
> > the handling of non dword payloads a problem for the caller (e.g. PCI/CMA)
> > not the DOE core, mainly so that we could keep the layering simple.
> > DOE part of PCI spec says DWORD multiples only, CMA has non dword
> > entries.
> 
> I can't remember, but I might have been the voice in favor of making
> it the caller's problem.  Your argument about dealing with it here
> makes a lot of sense, and I'm OK with it, but I *would* like to add
> some text to the commit log and comments in the code about what is
> happening here.  Otherwise there's an unexplained disconnect between
> the DWORD spec language and the byte-oriented code.

In v3 I amended both the commit message and the kerneldoc for pci_doe()
to make it clear that support for arbitrary-sized request and response
buffers is not stipulated by the spec, but merely for the convenience
of the caller.

Thanks,

Lukas
