Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8501D4F0442
	for <lists+linux-pci@lfdr.de>; Sat,  2 Apr 2022 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356849AbiDBOur (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Apr 2022 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356843AbiDBOuq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Apr 2022 10:50:46 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B5013CD8;
        Sat,  2 Apr 2022 07:48:53 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5AB8D100E2006;
        Sat,  2 Apr 2022 16:48:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3965C4E024; Sat,  2 Apr 2022 16:48:45 +0200 (CEST)
Date:   Sat, 2 Apr 2022 16:48:45 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 03/10] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <20220402144845.GA7822@wunner.de>
References: <20220330235920.2800929-1-ira.weiny@intel.com>
 <20220330235920.2800929-4-ira.weiny@intel.com>
 <YkVBJ+nRA2g/WDxa@infradead.org>
 <YkXGnKsTEUAe29io@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkXGnKsTEUAe29io@iweiny-desk3>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 31, 2022 at 08:19:56AM -0700, Ira Weiny wrote:
> On Wed, Mar 30, 2022 at 10:50:31PM -0700, Christoph Hellwig wrote:
> > On Wed, Mar 30, 2022 at 04:59:13PM -0700, ira.weiny@intel.com wrote:
> > > Introduced in a PCI v6.0[1], DOE provides a config space based mailbox
> > > with standard protocol discovery.  Each mailbox is accessed through a
> > > DOE Extended Capability.
> > 
> > I really don't think this should be built unconditionally and bloat
> > every single kernel built with PCI support.
> 
> I can add a Kconfig.

Ideally, that config option should live in the pcie/ subdirectory,
i.e. in drivers/pci/pcie/Kconfig, alongside drivers/pci/pcie/doe.c,
as we try to consolidate PCIe-specific features there and reserve
core code in drivers/pci/*.c for functionality that also applies
to Conventional PCI.

Thanks,

Lukas
