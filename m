Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E737256B4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbjFGICH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 04:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbjFGIB7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 04:01:59 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E625BE79;
        Wed,  7 Jun 2023 01:01:57 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1A9CD2800C960;
        Wed,  7 Jun 2023 10:01:54 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0E6724378E; Wed,  7 Jun 2023 10:01:54 +0200 (CEST)
Date:   Wed, 7 Jun 2023 10:01:54 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5 2/2] PCI: Don't assume root ports are power manageable
Message-ID: <20230607080154.GA7545@wunner.de>
References: <20230530163947.230418-1-mario.limonciello@amd.com>
 <20230530163947.230418-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530163947.230418-2-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 30, 2023 at 11:39:47AM -0500, Mario Limonciello wrote:
> +	/*
> +	 * It's not safe to put root ports that don't support power
> +	 * management into D3.
> +	 */
> +	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
> +	    !platform_pci_power_manageable(bridge))
> +		return false;
> +
>  	/*
>  	 * It should be safe to put PCIe ports from 2015 or newer
>  	 * to D3.

My recollection is that we began suspending Root Ports to D3hot because
otherwise low power states of the whole CPU package could not be reached
on certain Intel CPUs from the 2015+ era.

Do we know if the DSDT of all those systems contains the required ACPI
objects to continue runtime suspending their Root Ports after this change?
Otherwise these systems would experience a power regression.

Thanks,

Lukas
