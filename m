Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4774E634FCC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 06:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiKWFwU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 00:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiKWFwT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 00:52:19 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6354F2406
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 21:52:17 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AN5q8mi097038;
        Tue, 22 Nov 2022 23:52:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669182728;
        bh=jr/Z5Wq4EQtiD2Hqpx+t6fBDxsve1rUSHqB5U8i6Pk4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SRN5d7JlC5K88fwMvn6wrYU3BM3Pec5ZbwZdj5IpzxsYbPWzFqsZNC7yQ06Cg8v33
         B29qxqqja4SwIUMHZxzcMFliGK9i5e6n8JUmp/BY3hsyP/04pQZm4HS1BKajcADFyd
         ckR6An0ZvP5GlufbSEwI0A2D+qbcsExgN4bKaFm0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AN5q80k018448
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Nov 2022 23:52:08 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 22
 Nov 2022 23:52:07 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 22 Nov 2022 23:52:07 -0600
Received: from ubuntu (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with SMTP id 2AN5pxWh001440;
        Tue, 22 Nov 2022 23:52:01 -0600
Date:   Tue, 22 Nov 2022 21:51:58 -0800
From:   Matt Ranostay <mranostay@ti.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <vigneshr@ti.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 0/5] PCI: add 4x lane support for pci-j721e controllers
Message-ID: <Y320/qN0B6i6fY7f@ubuntu>
References: <20221115150335.501502-1-mranostay@ti.com>
 <20221115153735.GA993634@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221115153735.GA993634@bhelgaas>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 09:37:35AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 15, 2022 at 07:03:30AM -0800, Matt Ranostay wrote:
> > Adding of dditional support to Cadence PCIe controller (i.e. pci-j721e.c)
> > for up to 4x lanes, and reworking of driver to define maximum lanes per
> > board configuration.
> > 
> > Changes from v1:
> > * Reworked 'PCI: j721e: Add PCIe 4x lane selection support' to not cause
> >   regressions on 1-2x lane platforms
> > 
> > Changes from v2:
> > * Correct dev_warn format string from %d to %u since lane count is a unsigned
> >   integer
> > * Update CC list
> > 
> > Changes from v3:
> > * Use the max_lanes setting per chip for the mask size required since bootloader
> >   could have set num_lanes to a higher value that the device tree which would leave
> >   in an undefined state
> > * Reorder patches do the previous change to not break bisect
> > * Remove line breaking for dev_warn to allow better grepping and since no strict
> >   80 columns anymore
> > 
> > Changes from v4:
> > * Correct invalid settings for j7200 PCIe RC + EP
> > * Add j784s4 configuration for selection of 4x lanes
> > 
> > Changes from v5:
> > * Dropped 'PCI: j721e: Add warnings on num-lanes misconfiguration' patch from series  
> > * Reworded 'PCI: j721e: Add per platform maximum lane settings' commit message
> > * Added yaml documentation and schema checks for ti,j721e-pci-* lane checking
> > 
> > Matt Ranostay (5):
> >   dt-bindings: PCI: ti,j721e-pci-*: add checks for num-lanes
> >   PCI: j721e: Add per platform maximum lane settings
> >   PCI: j721e: Add PCIe 4x lane selection support
> >   dt-bindings: PCI: ti,j721e-pci-*: add j784s4-pci-* compatible strings
> >   PCI: j721e: add j784s4 PCIe configuration
> 
> Hi Matt,
> 
> Don't repost just for this, but if you have occasion to post this
> again, capitalize this subject line to match the others, i.e.,
> "Add j784s4 configuration".
> 
> Also looks like some commit logs are wrapped at about 65 columns; it's
> nice if they're consistently 75.

Noted... I know this rule, and someone missed wrapping it 75 columns :-/

- Matt
