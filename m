Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CCC74126F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 15:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjF1Nal (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 09:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjF1N3r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jun 2023 09:29:47 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47CC129;
        Wed, 28 Jun 2023 06:29:46 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 040DE30004510;
        Wed, 28 Jun 2023 15:29:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EBCC743C12D; Wed, 28 Jun 2023 15:29:44 +0200 (CEST)
Date:   Wed, 28 Jun 2023 15:29:44 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v3 1/2] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
Message-ID: <20230628132944.GB14276@wunner.de>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-2-Smita.KoralahalliChannabasappa@amd.com>
 <e7aa803b-2b43-dc43-1d92-38bcca636e62@linux.intel.com>
 <a79c82bb-e1fe-891c-87f9-6231a30e5ef2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79c82bb-e1fe-891c-87f9-6231a30e5ef2@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 10:48:37AM -0700, Smita Koralahalli wrote:
> On 6/22/2023 4:22 PM, Sathyanarayanan Kuppuswamy wrote:
> > On 6/21/23 11:51 AM, Smita Koralahalli wrote:
> > > +static void dpc_handle_surprise_removal(struct pci_dev *pdev)
> > > +{
> > > +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev)) {
> > > +		pci_err(pdev, "failed to retrieve DPC root port on async remove\n");
> > > +		goto out;
> > > +	}
> > > +
> > > +	pci_aer_raw_clear_status(pdev);
> > > +	pci_clear_surpdn_errors(pdev);
> > > +
> > > +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
> > > +			      PCI_EXP_DPC_STATUS_TRIGGER);
> > 
> > Don't you need to wait for the link to go down?
> 
> Yes will include, pcie_wait_for_link()..
> 
> Should this check be here or at the beginning of the function before we
> check pdev->dpc_rp_extensions?

I'd just use the same order as dpc_reset_link(), i.e. checking for
!pcie_wait_for_link() happens before the check for pdev->dpc_rp_extensions.

Thanks,

Lukas
