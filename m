Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A946DB5F1
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 23:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjDGVxY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 17:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjDGVxW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 17:53:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD7CC0D;
        Fri,  7 Apr 2023 14:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B55ED654F3;
        Fri,  7 Apr 2023 21:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB645C4339B;
        Fri,  7 Apr 2023 21:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680904381;
        bh=rSsjmWYwOBEqstZvp/v9pM+ciRSYs/fYC833FUvb4ug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uiiKJp0BBcKnkllwTC3uda6E0UTZb2osrluRmD8KENyGXpU6GRgymTSndGLDTuTBK
         IpPrT+Uh/sJvhC8wuYlozq+A2kAWtbfW6cNmVSWuS0Eqclr5FQCn9GDzgQYASbF3Az
         dVtdZdeGE/L6YbEbTQ/1tPt562aAw1tK3m/R3bEOb8e9YY8xhxvHN/hPqHwaJaD/nO
         H92Q0pmQ0t2UwZkp4TvGVjtt8Ihr2kgT4UfVDAyz10CjYcsu1YBeykgT7ddzUFA8XC
         bbnmhWscrNsAk0Iq64NABZIcE5kzzhIaniKk4x9qaPTLjoyT+zwHphBykfssfIRON+
         hzq5Kvk84V2Eg==
Date:   Fri, 7 Apr 2023 16:52:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
Message-ID: <20230407215259.GA3825733@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407215142.GA3825302@bhelgaas>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 07, 2023 at 04:51:44PM -0500, Bjorn Helgaas wrote:
> I'll post a follow-up patch to add a couple comments there,
> too.

Comments I propose:


    PCI/EDR: Add edr_handle_event() comments
    
    EDR documentation is a bit sketchy.  Add a couple comments to
    edr_handle_event() about the devices involved.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index 87734e4c3c20..135ddb53661c 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -151,9 +151,17 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	if (event != ACPI_NOTIFY_DISCONNECT_RECOVER)
 		return;
 
+	/*
+	 * pdev itself is still present, but one or more of its child
+	 * devices have been disconnected (ACPI v6.3, sec 5.6.6).
+	 */
 	pci_info(pdev, "EDR event received\n");
 
-	/* Locate the port which issued EDR event */
+	/*
+	 * Locate the port that experienced the containment event.  pdev
+	 * may be that port or a parent of it (PCI Firmware r3.3, sec
+	 * 4.6.13).
+	 */
 	edev = acpi_dpc_port_get(pdev);
 	if (!edev) {
 		pci_err(pdev, "Firmware failed to locate DPC port\n");
