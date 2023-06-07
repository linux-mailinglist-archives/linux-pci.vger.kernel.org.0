Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A42F7256EF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 10:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239345AbjFGIGy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 04:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239484AbjFGIGp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 04:06:45 -0400
X-Greylist: delayed 618 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 01:06:24 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C4A1982;
        Wed,  7 Jun 2023 01:06:23 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id DC138100D9410;
        Wed,  7 Jun 2023 09:49:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AEEB0313937; Wed,  7 Jun 2023 09:49:39 +0200 (CEST)
Date:   Wed, 7 Jun 2023 09:49:39 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] PCI/PM: enable runtime PM later during device scanning
Message-ID: <20230607074939.GA17700@wunner.de>
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
> @@ -3139,6 +3139,7 @@ void pci_pm_init(struct pci_dev *dev)
>  	u16 pmc;
>  
>  	pm_runtime_forbid(&dev->dev);
> +	pm_runtime_get_noresume(&dev->dev);
>  	pm_runtime_set_active(&dev->dev);
>  	pm_runtime_enable(&dev->dev);
>  	device_enable_async_suspend(&dev->dev);
> @@ -335,9 +336,12 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	int retval;
>  
>  	/*
> -	 * Can not put in pci_device_add yet because resources
> -	 * are not assigned yet for some devices.
> +	 * Allow runtime PM only here, since otherwise we may
> +	 * try to suspend a device that isn't fully configured
> +	 * yet, which causes problems.
>  	 */
> +	pm_runtime_put_noidle(&dev->dev);
> +
>  	pcibios_bus_add_device(dev);
>  	pci_fixup_device(pci_fixup_final, dev);
>  	pci_create_sysfs_dev_files(dev);

There seem to be many different callers that end up in pci_pm_init()
and pci_bus_add_device().

Is it guaranteed that the two functions are always called in order?
Do callers exist which only invoke the former but not the latter or
vice-versa?  Can it happen that a caller of the former errors out,
so the latter is never called, leading to a runtime PM ref imbalance?

It would be easier to ascertain correctness if you could find a
function at a higher level which (indirectly) calls both pci_pm_init()
and pci_bus_add_device() so that you can acquire and release the
runtimw PM ref in that single function.

Thanks,

Lukas
