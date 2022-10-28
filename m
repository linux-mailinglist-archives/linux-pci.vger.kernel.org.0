Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A3D611714
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 18:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJ1QIt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiJ1QHF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 12:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E43DFB6;
        Fri, 28 Oct 2022 09:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76F756294B;
        Fri, 28 Oct 2022 16:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68C7C433D6;
        Fri, 28 Oct 2022 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666973182;
        bh=AvE4K79k2Jd4cse5cXKljbcr2tgCzWv/Xo3UPKYz1zk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W7rizIooL9XO1d8G/SyX0QkpWWxwYNGVWpDOLC+rakFjWiMPbMRK9GzhamJ0pvidL
         M2taZ0aT1QLzc1+i3vgyQqrgLnKEg4msOdkG4xh6W1apKRDC82W3NQqJzBHTbjIoL9
         4U7aImMj5b08zi70ifAJQ6ljFFDPi+qtwbjg+DTh47HM35EvA70RRwVewlY84KjPKg
         Q6itNMGfRHzFsy4125xzKSNNOwfJou2ij9mbTYfVNgkF87hz+r1PgCRciXVQFqBq7a
         CycALh7gGDzQei6dmuIBXHJf3nCLoDrihHOpIn42LKR/cEHSaWeCYucDovbZXuqEmY
         D3R4bu1RXDYkQ==
Date:   Fri, 28 Oct 2022 11:06:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add vendor ID for Quectel and Cinterion
Message-ID: <20221028160621.GA892468@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028023711.4196-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 28, 2022 at 10:37:11AM +0800, Slark Xiao wrote:
> In MHI driver, there are some companies product still do not have their
>  own PCI vendor macro. So we add it here to make the code neat. Ref ID
>  could be found in link https://pcisig.com/membership/member-companies
>  and https://pciids.sourceforge.net/pci.ids . Thales use Cinterion as
> their IOT modem card's trademark. So you will find 0x1269 belongs to
> Thales. Actually, Cinterion belongs to Gemalto, and Gemalto belongs to
>  Thales.

There should not be spaces at the beginning of these lines.

Don't bother with the sourceforge URL; I don't think that's really
useful here.

> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  include/linux/pci_ids.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index b362d90eb9b0..9e2b6286f53f 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1765,6 +1765,8 @@
>  #define PCI_VENDOR_ID_SATSAGEM		0x1267
>  #define PCI_DEVICE_ID_SATSAGEM_NICCY	0x1016
>  
> +#define PCI_VENDOR_ID_CINTERION		0x1269	/* Celluar Modules*/

This should identify the *vendor*, not a trademark for a specific
product line.  And it should correspond somehow with the PCI-SIG
registration.  So I think PCI_VENDOR_ID_THALES would be more
appropriate here.

I think the best thing here would be two patches.  One patch would add
PCI_VENDOR_ID_THALES to pci_ids.h and also add a use of it in the MHI
driver.  The second patch would do the same for PCI_VENDOR_ID_QUECTEL.

Then each one is logically self-contained.

>  #define PCI_VENDOR_ID_ENSONIQ		0x1274
>  #define PCI_DEVICE_ID_ENSONIQ_CT5880	0x5880
>  #define PCI_DEVICE_ID_ENSONIQ_ES1370	0x5000
> @@ -2585,6 +2587,8 @@
>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
>  
> +#define PCI_VENDOR_ID_QUECTEL		0x1eac
> +
>  #define PCI_VENDOR_ID_TEHUTI		0x1fc9
>  #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
>  #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
> -- 
> 2.34.1
> 
