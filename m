Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54145B0C95
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 20:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiIGShQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIGShP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 14:37:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970B1240A7;
        Wed,  7 Sep 2022 11:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41034B81E0B;
        Wed,  7 Sep 2022 18:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96067C433D6;
        Wed,  7 Sep 2022 18:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662575831;
        bh=yw5tnjCIg9cU1IHKjQaN3CQznJuLfIIzqEokj4ejUFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sZqzpIu7bsZtRoOc6VkKjhyu696HXrcN+7AvIZrtIrE9EfJJKToDZb66Qi9Ukhiac
         Tto7arLXfcH8Wy2XfkvHsegZ9ojFU6vN8MUC4ZDJTR7N/EJohyxjIxJi8w0Lu1bAgY
         HE/OhimksViawt/NtkzCN6IQwwsuS8JvY7EcvjQ7cxwOFGMxza8TYgMkPOX0LwrAPT
         flaycBSIdonb5vjUYdOTVbcuuV536GT0I1Yt711FGE0DKYzlXMGd0qo7565oi6u/zM
         o7iJMn1npPThOLXvlW1Z3PIcSzPJBHTCSd+dqQ+Cmqjp6zpPYFM+On2LGAEP8+u0g0
         OEytENdyztAJQ==
Date:   Wed, 7 Sep 2022 13:37:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 06/15] PCI/ACPI: Link host bridge to its ACPI fw node
Message-ID: <20220907183709.GA136851@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-7-rrichter@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 10:15:54AM +0200, Robert Richter wrote:
> A lookup of a host bridge's corresponding acpi device (struct
> acpi_device) is not possible, for example:
> 
> 	adev = ACPI_COMPANION(&host_bridge->dev);
> 
> This could be useful to find a host bridge's fwnode handle and to
> determine and call additional host bridge ACPI parameters and methods
> such as HID/CID or _UID.
> 
> Make this work by linking the host bridge to its ACPI fw node.

s/acpi device/ACPI device/ to match other "ACPI" usage
s/fw node/fwnode/ (if it should match "fwnode handle" above)

I guess this patch makes ACPI_COMPANION() work where it didn't before,
right?  E.g., the two ACPI_COMPANION() uses added by this series
(cxl_find_next_rch() and cxl_restricted_host_probe()).

I'm not really clear on the strategy of when we should use acpi_device
vs acpi_handle, but does this mean there's code in places like
pci_root.c that should be reworked to take advantage of this?  That
code evaluates _DSM and _OSC, but I think it currently uses
acpi_handle for that.

Bjorn
