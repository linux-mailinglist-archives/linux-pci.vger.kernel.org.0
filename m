Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0A76A52BC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 06:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjB1F4E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 00:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjB1F4D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 00:56:03 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E5125B85;
        Mon, 27 Feb 2023 21:55:58 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A45C82801161B;
        Tue, 28 Feb 2023 06:55:56 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 92DF940F8A; Tue, 28 Feb 2023 06:55:56 +0100 (CET)
Date:   Tue, 28 Feb 2023 06:55:56 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 16/16] cxl/pci: Rightsize CDAT response allocation
Message-ID: <20230228055556.GB32202@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
 <49c5299afc660ac33fee9a116ea37df0de938432.1676043318.git.lukas@wunner.de>
 <10f9baf4-7fdf-b105-9222-5a1df59e2993@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10f9baf4-7fdf-b105-9222-5a1df59e2993@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 28, 2023 at 12:45:33PM +1100, Alexey Kardashevskiy wrote:
> Almost no change from this patchset applied cleanly to
> drivers/cxl/core/pci.c, what is the patchset based on? Thanks,

This series is based on pci/next, i.e. v6.2-rc1 plus PCI changes for v6.3:

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=next

It should apply cleanly to cxl/next as well, save for a trivial merge
conflict in patch [13/16] due to a context change.  Here's a branch
containing v3 of this series based on cxl/next:

https://github.com/l1k/linux/commits/doe_rework_v3_cxl_next

That said, you're probably better off just using the development branch
for CMA/SPDM, it incorporates all the changes requested during review
of v3 and will form the basis for v4 (slated for submission in a few
days):

https://github.com/l1k/linux/commits/doe

Thanks,

Lukas
