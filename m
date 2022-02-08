Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9AB4AE58A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 00:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiBHXk3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 18:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbiBHXk2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 18:40:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1668C061577;
        Tue,  8 Feb 2022 15:40:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8822CB81DAE;
        Tue,  8 Feb 2022 23:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D523C004E1;
        Tue,  8 Feb 2022 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644363625;
        bh=tTPrvW+Dj9qlw2hawH8KNeZdwB7ywT5DEp3AnZQYYas=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r2ZYtAp5LY9NOVd2QTojCHSKJyHaCFJAHN134jhrTbUWahI6A68xI7guspXyv7w7o
         cG+Wuo8HmRRMLqSQBbusqueYWr04h/MQzEZaB06LO1ZCD1z95WO80iALgKTH8aTR+b
         DjIAOIhK1jLscZ9Zp4mnzYqmNxeoEZY9IZ6EsHWmVlXmLje1nszSjyjkpN2V0Xslif
         1XUTnWixsC9RKRCJOQac0eF5uUOzkDl3hA2N7b8Sd0WopLstcpJ20VC6Lwk+zQDcLa
         HxkLjNE7GYKLjAE6RxiJbUC7+w3QoxCJ9jeou6OS4VYoA0spDnbkGB8rh+VDsD+z1/
         Cfy1fhref5yWw==
Date:   Tue, 8 Feb 2022 17:40:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Koen Vandeputte <koen.vandeputte@citymesh.com>,
        Dexuan Cui <dexuan.linux@gmail.com>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files (can't boot)
Message-ID: <20220208234023.GA505306@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m38ruwxgnx.fsf@t19.piap.pl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Koen, Dexuan from this old thread:
https://lore.kernel.org/all/20200716110423.xtfyb3n6tn5ixedh@pali/]

On Mon, Jan 31, 2022 at 12:56:18PM +0100, Krzysztof Hałasa wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > Thanks.  e1d3f3268b0e and related patches converted individual files
> > ("config", "rom", "vpd", etc) to static attributes, but since the
> > problem you're seeing is with a directory, it's likely different.
> >
> > I opened this bugzilla report to try to keep this from getting lost:
> > https://bugzilla.kernel.org/show_bug.cgi?id=215515
> 
> Ok, thanks.

Koen collected some interesting logs at
https://lore.kernel.org/all/cd4812f0-1de3-0582-936c-ba30906595af@citymesh.com/
They're from v5.10, which was before all of Krzysztof W's nice work
converting to static attributes, but Koen's log shows the error
happening in the pci_sysfs_init() initcall, which is *after*
imx6_pcie_probe():

  imx6_pcie_probe                # probably device initcall (level 6)
    ...
      pci_create_sysfs_dev_files

  pci_sysfs_init                 # late initcall (level 7)
    pci_create_sysfs_dev_files
      "sysfs: cannot create duplicate filename"

Krzysztof, you're running v5.14, which includes Krzysztof W's work,
but that shouldn't affect the imx6_pcie_probe()/pci_sysfs_init()
ordering.  Your log shows the error in imx6_pcie_probe().

Would you mind adding the patch below and attaching a complete dmesg
log to the bugzilla?

Bjorn

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7bbf2673c7f2..6a2b62fe7704 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1200,6 +1200,9 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 	res_attr->attr.mode = 0600;
 	res_attr->size = pci_resource_len(pdev, num);
 	res_attr->private = (void *)(unsigned long)num;
+	pci_info(pdev, "pci_create_attr:");
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
+			res_attr, 64, true);
 	retval = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
 	if (retval)
 		kfree(res_attr);
@@ -1380,6 +1383,9 @@ static const struct attribute_group pci_dev_reset_attr_group = {
 
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
+	pci_info(pdev, "pci_create_sysfs_dev_files\n");
+	dump_stack();
+
 	if (!sysfs_initialized)
 		return -EACCES;
 

