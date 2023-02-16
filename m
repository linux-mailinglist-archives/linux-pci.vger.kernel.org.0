Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879BA698E3D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 09:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBPIDs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 03:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBPIDr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 03:03:47 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9621E1ED;
        Thu, 16 Feb 2023 00:03:45 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id AF8BB280137D4;
        Thu, 16 Feb 2023 09:03:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 61EE12703E; Thu, 16 Feb 2023 09:03:43 +0100 (CET)
Date:   Thu, 16 Feb 2023 09:03:43 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 16/16] cxl/pci: Rightsize CDAT response allocation
Message-ID: <20230216080343.GA23125@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
 <49c5299afc660ac33fee9a116ea37df0de938432.1676043318.git.lukas@wunner.de>
 <63ed7f50ed22b_19cbb72946d@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ed7f50ed22b_19cbb72946d@iweiny-mobl.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 04:56:48PM -0800, Ira Weiny wrote:
> Lukas Wunner wrote:
> > Jonathan notes that cxl_cdat_get_length() and cxl_cdat_read_table()
> > allocate 32 dwords for the DOE response even though it may be smaller.
> > 
> > In the case of cxl_cdat_get_length(), only the second dword of the
> > response is of interest (it contains the length).  So reduce the
> > allocation to 2 dwords and let DOE discard the remainder.
> > 
> > In the case of cxl_cdat_read_table(), a correctly sized allocation for
> > the full CDAT already exists.  Let DOE write each table entry directly
> > into that allocation.  There's a snag in that the table entry is
> > preceded by a Table Access Response Header (1 dword).
> 
> Where is this 'Table Access Response Header' defined?

CXL r3.0 table 8-14 (sec 8.1.11.1, page 399).

I'll amend the commit message with a reference to the spec.

Thanks,

Lukas
