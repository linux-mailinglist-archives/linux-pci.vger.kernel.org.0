Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA13733943
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 21:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjFPTLB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 15:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjFPTLA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 15:11:00 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53B830EB;
        Fri, 16 Jun 2023 12:10:58 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0812E300002D5;
        Fri, 16 Jun 2023 21:10:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EBE2C1DED93; Fri, 16 Jun 2023 21:10:56 +0200 (CEST)
Date:   Fri, 16 Jun 2023 21:10:56 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Stefan =?iso-8859-1?Q?M=E4tje?= <stefan.maetje@esd.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Shaohua Li <shaohua.li@intel.com>,
        Thomas Renninger <trenn@suse.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-kernel@vger.kernel.org,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 3/9] PCI/ASPM: Use RMW accessors for changing LNKCTL
Message-ID: <20230616191056.GA30821@wunner.de>
References: <20230517105235.29176-1-ilpo.jarvinen@linux.intel.com>
 <20230517105235.29176-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517105235.29176-4-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 17, 2023 at 01:52:29PM +0300, Ilpo Järvinen wrote:
> Don't assume that the device is fully under the control of ASPM and use
> RMW capability accessors which do proper locking to avoid losing
> concurrent updates to the register values.
> 
> If configuration fails in pcie_aspm_configure_common_clock(), the
> function attempts to restore the old PCI_EXP_LNKCTL_CCC settings. Store
> only the old PCI_EXP_LNKCTL_CCC bit for the relevant devices rather
> than the content of the whole LNKCTL registers. It aligns better with
> how pcie_lnkctl_clear_and_set() expects its parameter and makes the
> code more obvious to understand.
[...]
> @@ -224,17 +223,14 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
>  	if (!pcie_wait_for_retrain(parent))
>  		return false;
>  
> -	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> -	reg16 |= PCI_EXP_LNKCTL_RL;
> -	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> +	pcie_capability_set_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
>  	if (parent->clear_retrain_link) {

This and several other RMW operations in drivers/pci/pcie/aspm.c
are touched by commit b1689799772a ("PCI/ASPM: Use distinct local
vars in pcie_retrain_link()") which got applied to pci/enumeration
this week:

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=enumeration&id=b1689799772a6f4180f918b0ff66e264a3db9796

As a result the $SUBJECT_PATCH no longer applies cleanly and needs
to be respun.

Thanks,

Lukas
