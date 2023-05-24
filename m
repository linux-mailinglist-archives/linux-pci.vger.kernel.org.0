Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB7470FAE7
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 17:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbjEXPzb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 11:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbjEXPzU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 11:55:20 -0400
X-Greylist: delayed 559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 May 2023 08:55:02 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5F21A4;
        Wed, 24 May 2023 08:55:01 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6DD7F28010365;
        Wed, 24 May 2023 17:44:54 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 63A39261ABF; Wed, 24 May 2023 17:44:54 +0200 (CEST)
Date:   Wed, 24 May 2023 17:44:54 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        linux-pm@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>
Subject: Re: [PATCH v3] PCI: Don't assume root ports from > 2015 are power
 manageable
Message-ID: <20230524154454.GA28455@wunner.de>
References: <20230524152136.1033-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524152136.1033-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 24, 2023 at 10:21:36AM -0500, Mario Limonciello wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2976,6 +2976,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  
>  	switch (pci_pcie_type(bridge)) {
>  	case PCI_EXP_TYPE_ROOT_PORT:
> +		if (!platform_pci_power_manageable(bridge))
> +			return false;
> +		fallthrough;
>  	case PCI_EXP_TYPE_UPSTREAM:
>  	case PCI_EXP_TYPE_DOWNSTREAM:
>  		if (pci_bridge_d3_disable)

This will exempt the Root Ports from pcie_port_pm=force.
Not sure if that's desirable.

Thanks,

Lukas
