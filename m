Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF87852BC08
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbiERNoC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 09:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbiERNoA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 09:44:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D35919CEE4;
        Wed, 18 May 2022 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ev3tPtzlYMQf8tLGdACd44jMIDv9Fh/Rr/emg2hh5uA=; b=P8KAPphVTpNM7ibcjB0zCxCAAc
        /pKUNIeIKhRVF/WoU4WxzyGEGQ2H5/mhcMn4lWud9j8Y8XnJ6+iWc6W3cBC4ay+dq4mspkGM4CIpE
        lJMPAeitQvXOpqGijyzSBwibbKde8yX2kqzEX/zsOz3j9qaIa5pjW1ZVJDZy+S686rciinjp09Nmf
        F0GwNoetfoCQBWe+VWL5j4ZYOjaN3sFuhccs1M/J+QsfLFZG1VDojNocXRcgQbmuJPD2pTJ3LPG5b
        XQeP8NbSdCjCSCUdL9rSOEPzF6N2NoO0zquXmzqxO4nH3s4cPSXYqN+wQgqBnGP1/tny1XK7EnGqZ
        UKE0ABrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrJxj-002Lef-Dp; Wed, 18 May 2022 13:43:39 +0000
Date:   Wed, 18 May 2022 06:43:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Message-ID: <YoT4C77Yem37NUUR@infradead.org>
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de>
 <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de>
 <20220511191943.GB26623@wunner.de>
 <CAPcyv4hUKjt7QrA__wQ0KowfaxyQuMjHB5V-=rZBm=UbV4OvSg@mail.gmail.com>
 <20220514135521.GB14833@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514135521.GB14833@wunner.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 14, 2022 at 03:55:21PM +0200, Lukas Wunner wrote:
> Circling back to the SPDM/IDE topic, while NVMe is now capable of
> reliably recovering from errors, it does expect the kernel to handle
> recovery within a few seconds.  I'm not sure we can continue to
> guarantee that if the kernel depends on user space to perform
> re-authentication with SPDM after reset.  That's another headache
> that we could avoid with in-kernel SPDM authentication.

I wonder if we need kernel bundled and tightly controlled userspace
code for these kinds of things (also for NVMe/NFS TLS).  That is,
bundle a userspace ELF file or files with a module which is unpacked
to or accessible by a ramfs-style file systems.  Then allow executing
it without any interaction with the normal userspace, and non-pagable
memory.  That way we can reuse existing userspace code, have really
nice address space isolation but avoid all the deadlock potential
of normal userspace code.  And I don't think it would be too hard to
implement either.
