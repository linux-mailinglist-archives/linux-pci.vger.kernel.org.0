Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2FA758508
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjGRStD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGRStD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 14:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A88B6;
        Tue, 18 Jul 2023 11:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5956616A3;
        Tue, 18 Jul 2023 18:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68CBC433C8;
        Tue, 18 Jul 2023 18:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689706141;
        bh=6Pm13pdoNNOokeW2c30WTWZWDf0+nx0N6C7q7saN0WY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CZNi9h8MJ2Cov6VWwL6EeDIM7pgooquk29fkn6jzqdIKdz+he44ODVIKThU3yWBv3
         j/ptmWnJf27vXmuTfooiCOVZw80WH07zPWwQlwfHNj+W2qDQGAL4mrRlMJxiZYCI36
         wVvG27HXfJIFL/EFL7aK+IvVjfsjaPHeqmav0443xYYwjeg7suPq2cs6Ah41vZrgzZ
         Cj1I5KdgsIKPjZ28XfQF2yjvOa8dIiNsMkSuKIBnmbQr/39i57sa6x0qjm7BqJBfHc
         RytpVcHXfY/1Jxa/Tn0cUbc891pmLPvdqUW7iRxYMxDwNXCNHARL/L5PFmJaKA9ft1
         kIf0rH8cya6eQ==
Date:   Tue, 18 Jul 2023 13:48:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] can: ems_pci: move ASIX AX99100 ids to pci_ids.h
Message-ID: <20230718184858.GA489178@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718174200.2862849-3-jiaqing.zhao@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 05:41:58PM +0000, Jiaqing Zhao wrote:
> Move PCI Vendor and Device ID of ASIX AX99100 PCIe to Multi I/O
> Controller to pci_ids.h for its serial and parallel port driver
> support in subsequent patches.
> 
> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/net/can/sja1000/ems_pci.c | 6 +-----
>  include/linux/pci_ids.h           | 4 ++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
> index 3e18c63a982c..1aaedaf866f1 100644
> --- a/drivers/net/can/sja1000/ems_pci.c
> +++ b/drivers/net/can/sja1000/ems_pci.c
> @@ -108,10 +108,6 @@ struct ems_pci_card {
>  
>  #define EMS_PCI_BASE_SIZE  4096 /* size of controller area */
>  
> -#ifndef PCI_VENDOR_ID_ASIX
> -#define PCI_VENDOR_ID_ASIX 0x125b
> -#define PCI_DEVICE_ID_ASIX_9110 0x9110
> -#endif
>  #define PCI_SUBDEVICE_ID_EMS 0x4010
>  
>  static const struct pci_device_id ems_pci_tbl[] = {
> @@ -122,7 +118,7 @@ static const struct pci_device_id ems_pci_tbl[] = {
>  	/* CPC-104P v2 */
>  	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_PLX, 0x4002},
>  	/* CPC-PCIe v3 */
> -	{PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_9110, 0xa000, PCI_SUBDEVICE_ID_EMS},
> +	{PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100_LB, 0xa000, PCI_SUBDEVICE_ID_EMS},
>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, ems_pci_tbl);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 2dc75df1437f..16608ce4fd0f 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1760,6 +1760,10 @@
>  #define PCI_SUBDEVICE_ID_AT_2700FX	0x2701
>  #define PCI_SUBDEVICE_ID_AT_2701FX	0x2703
>  
> +#define PCI_VENDOR_ID_ASIX		0x125b
> +#define PCI_DEVICE_ID_ASIX_AX99100	0x9100
> +#define PCI_DEVICE_ID_ASIX_AX99100_LB	0x9110
> +
>  #define PCI_VENDOR_ID_ESS		0x125d
>  #define PCI_DEVICE_ID_ESS_ESS1968	0x1968
>  #define PCI_DEVICE_ID_ESS_ESS1978	0x1978
> -- 
> 2.39.2
> 
