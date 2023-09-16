Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B747A2DF7
	for <lists+linux-pci@lfdr.de>; Sat, 16 Sep 2023 06:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbjIPEtY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Sep 2023 00:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjIPEs6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Sep 2023 00:48:58 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C93173C
        for <linux-pci@vger.kernel.org>; Fri, 15 Sep 2023 21:48:53 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2D4662800B4AA;
        Sat, 16 Sep 2023 06:48:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 14D22522453; Sat, 16 Sep 2023 06:48:51 +0200 (CEST)
Date:   Sat, 16 Sep 2023 06:48:51 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v19 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <20230916044851.GA8280@wunner.de>
References: <20230915023354.939-1-mario.limonciello@amd.com>
 <20230915023354.939-3-mario.limonciello@amd.com>
 <20230915070802.GA5934@wunner.de>
 <5a562f6b-6e4d-42a1-bbc1-08f7f3279dfd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a562f6b-6e4d-42a1-bbc1-08f7f3279dfd@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 15, 2023 at 07:04:11AM -0500, Mario Limonciello wrote:
> On 9/15/2023 02:08, Lukas Wunner wrote:
> > On Thu, Sep 14, 2023 at 09:33:54PM -0500, Mario Limonciello wrote:
> > > +static bool child_has_amd_usb4(struct pci_dev *pdev)
> > > +{
> > > +	struct pci_dev *child = NULL;
> > > +
> > > +	while ((child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child))) {
> > > +		if (child->vendor != PCI_VENDOR_ID_AMD)
> > > +			continue;
> > > +		if (pcie_find_root_port(child) != pdev)
> > > +			continue;
> > > +		return true;
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > 
> > What's the purpose of the pcie_find_root_port() check?  PCI is a hierarchy,
> > not a graph, so a device cannot have any other Root Port but the one below
> > which you're searching.
> > 
> > If the purpose is to check that the port is a Root Port (if the PCI IDs
> > you're using in the DECLARE_PCI_FIXUP_* clauses match non-Root Ports),
> > check for pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT.  (No need to
> > check for that in every loop iteration obviously, just check once in
> > the fixup.)
> > 
> > Thanks,
> > 
> > Lukas
> 
> The reason to look for it the way that I did was that there are multiple
> root ports with the exact same PCI ID.
> 
> The problem only occurs on the root port that happens to have an AMD USB4
> controller connected.

Yes but what's the purpose of the pcie_find_root_port(child) check
quoted above?

Thanks,

Lukas
