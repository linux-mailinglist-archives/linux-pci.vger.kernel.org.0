Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409BE7231BC
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 22:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjFEUuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 16:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjFEUuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 16:50:22 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785D4FD;
        Mon,  5 Jun 2023 13:50:19 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9D300300000BE;
        Mon,  5 Jun 2023 22:50:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 93CF3350DC0; Mon,  5 Jun 2023 22:50:17 +0200 (CEST)
Date:   Mon, 5 Jun 2023 22:50:17 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] PCI/PM: enable runtime PM later during device scanning
Message-ID: <20230605205017.GA23596@wunner.de>
References: <20230605121621.4259f1be6cd2.Idbaa55b93f780838af44ebccb84c36f60716df04@changeid>
 <20230605203519.bc4232207449.Idbaa55b93f780838af44ebccb84c36f60716df04@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605203519.bc4232207449.Idbaa55b93f780838af44ebccb84c36f60716df04@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 05, 2023 at 08:35:45PM +0200, Johannes Berg wrote:
> v2: use pm_runtime_get_noresume()/pm_runtime_put_noidle()
>     instead as advised by Rafael

You've changed the code but seemingly did not update the commit
message and code comment.  Technically you're not "allowing"
runtime PM, you just stop keeping the device runtime active.

A more fitting subject might thus be:

PCI/PM: Keep devices runtime active during enumeration


> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1278,6 +1278,9 @@ static int pci_pm_runtime_suspend(struct device *dev)
>  	pci_power_t prev = pci_dev->current_state;
>  	int error;
>  
> +	if (WARN_ON(!pci_dev_is_added(pci_dev)))
> +		return -EBUSY;
> +

If this can't happen (as the commit message says), why warn?

Thanks,

Lukas
