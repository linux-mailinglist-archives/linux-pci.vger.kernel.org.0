Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96586D5B5E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 11:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjDDJBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 05:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjDDJBG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 05:01:06 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E98C10F8;
        Tue,  4 Apr 2023 02:01:02 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9E6E12800C981;
        Tue,  4 Apr 2023 11:01:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 84DA7292B2; Tue,  4 Apr 2023 11:01:00 +0200 (CEST)
Date:   Tue, 4 Apr 2023 11:01:00 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com
Subject: Re: [PATCH v4 05/17] PCI/DOE: Silence WARN splat with
 CONFIG_DEBUG_OBJECTS=y
Message-ID: <20230404090100.GA21129@wunner.de>
References: <cover.1678543498.git.lukas@wunner.de>
 <67a9117f463ecdb38a2dbca6a20391ce2f1e7a06.1678543498.git.lukas@wunner.de>
 <b3d2d326-8736-09e4-0886-68c6d69aa404@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d2d326-8736-09e4-0886-68c6d69aa404@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 21, 2023 at 02:42:01PM +1100, Alexey Kardashevskiy wrote:
> On 12/3/23 01:40, Lukas Wunner wrote:
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
>                                                   ^^^^^
> 
> huwei? :)

Thanks for spotting this Alexey.

Dan fixed it up when he applied the patch to cxl/fixes yesterday:
https://git.kernel.org/cxl/cxl/c/92dc899c3b49
