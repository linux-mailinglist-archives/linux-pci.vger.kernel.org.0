Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60967F3CA
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jan 2023 02:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjA1Bj4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Jan 2023 20:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjA1Bjz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2023 20:39:55 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F9E4DCF6
        for <linux-pci@vger.kernel.org>; Fri, 27 Jan 2023 17:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674869994; x=1706405994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BpkqsIICFNNM4+dMwCBIL9FWTYTT2Hz2zqkCioy05LA=;
  b=ix0Z6x2VIiIrrCOCmdGF2t0sifbLaVvkFrz5/KCFut8v1A+It204xQca
   IJz2qHmOfUijjHYyUG1YrMWSCGzugw9T2CI58Lyvja4OD654nxwkmB4e7
   Dv9jEHlX66ChlRgdXt9t9XuKzah8sheWNYJ/fp0NswC/xGdkMg4jHPoYG
   MfMyggSqPMDlGXe40b1MDmT/hk9G4iotudF54WYhr+RzQQe8cM3tQH2WR
   6MX/8LWe6QWKfxWamaEQzKmgDRTMVIYRGI/UfbZ4FuNtQO9wlzf/jcFPS
   4NKuY9qMfm74OFsS/yemxMonLY7YBTnVFnTYcSieRswKg3ibyZRMktTzz
   g==;
X-IronPort-AV: E=Sophos;i="5.97,252,1669046400"; 
   d="scan'208";a="220267145"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2023 09:39:54 +0800
IronPort-SDR: 4Ub8j5z15F9JMQsgT9Thtiw7hHNY4xzInJLHImaLNYzLh0DtpMuDovlIEgbkPvMhz72yr2YgVS
 UDSpyZ9jx6W0Hau0VivkJ6B/N/f3nmkzrYJOw77as/z5cf1WpxxzyzPSsUWVOnZkDjZOqo5BXv
 ruFpLv3N6rG4xRUtKwcOYnT3ruVX0glI/KCkTBJs2EK2tZHKHxpPc9uqHe8nK3ljTI7i7ooWym
 kLvxJlsxT47JTaBrQdbERqMjQ06UrkJWR8NmcOJ4FmLC0kiDi555YvoYqVN8ZQK0nqri4W67fG
 OgY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2023 16:51:38 -0800
IronPort-SDR: kovFrdne1eHuGF3yKKMOFiVuYvj2fd7fNHBbY7m5w9ktJxXqxP9sOBgb5cnzycfaibqdA3+DCQ
 CWoEDVe80HO6rUD6KLxd1easjY1laLcBIQQhzELdoPuKXOINkd93oJIzPoHUtFxK5G0WCGd1s/
 ax7wsu4nT4BbrvxB0TmbRZxMFKT5qm1glzO3JUT5mfp/t1wIMWx2x4nP6BQvHE9MrukwPNU7ad
 UX253H28ww3kVB/DU4WOIngDke8cxd8td7hHzB4dvOhPwkQAwFjB2369RDPl1xdwKf04d3FsWS
 vIE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2023 17:39:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P3cZL1mDzz1RvTp
        for <linux-pci@vger.kernel.org>; Fri, 27 Jan 2023 17:39:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1674869993;
         x=1677461994; bh=BpkqsIICFNNM4+dMwCBIL9FWTYTT2Hz2zqkCioy05LA=; b=
        bCLF6ifPphzJIlzoSkyi5VZjtcQhyu1F/Rs1QumEXWiH2HXUHpP3S4aiKz2i17Du
        ycMbcged6hf6xhGCs4BwPl8DEQw8AUeTq8rjdyPWmfwW6BMPtmC45RMcZjhkWs4w
        klG0GUYf6zKGJvcoParvpNMMfNFcaf32ad0amDwV8PYjiILFDPsEDgkZJ6nL0crb
        1E5h7SnNx8eKpAnLFf3mspXjZzAKvba+ON8T1ydXVfpPTyrTSQOvpvh+hoGnV0eb
        GGPklIJxEV5DJVeAH8ZUcpuC9YSr60aD4e8reGUFUD8ky+EmLAd7vC2lwymWIzo3
        2Rfl2PGND/gLeDY4TJ9EQg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dU1eHULahTQC for <linux-pci@vger.kernel.org>;
        Fri, 27 Jan 2023 17:39:53 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P3cZK2TYjz1RvLy;
        Fri, 27 Jan 2023 17:39:53 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH] pci: Avoid FLR for AMD FCH AHCI adapters
Date:   Sat, 28 Jan 2023 10:39:51 +0900
Message-Id: <20230128013951.523247-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI passthrough to VMs does not work with AMD FCH AHCI adapters: the
guest OS fails to correctly probe devices attached to the controller due
to FIS communication failures. Forcing the "bus" reset method before
unbinding & binding the adapter to the vfio-pci driver solves this
issue. I.e.:

echo "bus" > /sys/bus/pci/devices/<ID>/reset_method

gives a working guest OS, thus indicating that the default flr reset
method is defective, resulting in the adapter not being reset correctly.

This patch applies the no_flr quirk to AMD FCH AHCI devices to
permanently solve this issue.

Reported-by: Niklas Cassel <niklas.cassel@wdc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 285acc4aaccc..20ac67d59034 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5340,6 +5340,7 @@ static void quirk_no_flr(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
=20
--=20
2.39.1

