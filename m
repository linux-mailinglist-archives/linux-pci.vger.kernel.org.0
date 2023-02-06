Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065BE68C93C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 23:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBFWRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 17:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBFWRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 17:17:47 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D6713530;
        Mon,  6 Feb 2023 14:17:42 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 76C3D100D940E;
        Mon,  6 Feb 2023 23:17:38 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3E3222EE138; Mon,  6 Feb 2023 23:17:38 +0100 (CET)
Date:   Mon, 6 Feb 2023 23:17:38 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
Subject: Re: [PATCH 16/18] cxl: Move reading of CDAT data from device to
 after media is ready
Message-ID: <20230206221738.GB21823@wunner.de>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571670516.587790.14112456054041985666.stgit@djiang5-mobl3.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167571670516.587790.14112456054041985666.stgit@djiang5-mobl3.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 01:51:46PM -0700, Dave Jiang wrote:
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -109,6 +106,8 @@ static int cxl_port_probe(struct device *dev)
>  			return rc;
>  		}
>  
> +		/* Cache the data early to ensure is_visible() works */
> +		read_cdat_data(port);
>  		if (port->cdat.table) {
>  			rc = cdat_table_parse_dsmas(port->cdat.table,
>  						    cxl_dsmas_parse_entry,

Which branch is this patch based on?  I'm not seeing a function
called cdat_table_parse_dsmas() in cxl/next.

cxl_cdat_read_table() could be amended with a switch/case ladder
which compares entry->type to acpi_cdat_type values and stores
a pointer to an entry of interest e.g. in port->cdat->dsmas.
Then you can use that pointer directly to find the dsmas in the
CDAT and parse it.

Note however that cxl_cdat_read_table() is refactored heavily by
my DOE rework series (will submit v3 later this week):

https://github.com/l1k/linux/commits/doe

Thanks,

Lukas
