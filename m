Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2842052E527
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 08:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiETGlz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 02:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbiETGlw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 02:41:52 -0400
X-Greylist: delayed 3574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 23:41:50 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D287A46B
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 23:41:50 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A9EF8100E416C;
        Fri, 20 May 2022 08:41:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8C1B0127487; Fri, 20 May 2022 08:41:48 +0200 (CEST)
Date:   Fri, 20 May 2022 08:41:48 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sheng Bi <windy.bi.enflame@gmail.com>
Cc:     helgaas@kernel.org, alex.williamson@redhat.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fix no-op wait after secondary bus reset
Message-ID: <20220520064148.GA20418@wunner.de>
References: <20220516165740.6256af51.alex.williamson@redhat.com>
 <20220518115432.76183-1-windy.bi.enflame@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518115432.76183-1-windy.bi.enflame@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 18, 2022 at 07:54:32PM +0800, Sheng Bi wrote:
> +static int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
> +{
> +	struct pci_dev *dev;
> +	int delay = 0;
> +
> +	if (!bridge->subordinate || list_empty(&bridge->subordinate->devices))
> +		return 0;
> +
> +	list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
> +		while (!pci_device_is_present(dev)) {
> +			if (delay > timeout) {
> +				pci_warn(dev, "not ready %dms after secondary bus reset; giving up\n",
> +					delay);
> +				return -ENOTTY;
> +			}
> +
> +			msleep(20);
> +			delay += 20;
> +		}
> +
> +		if (delay > 1000)
> +			pci_info(dev, "ready %dms after secondary bus reset\n",
> +				delay);
> +	}
> +
> +	return 0;
> +}

An alternative approach you may want to consider is to call
pci_dev_wait() in the list_for_each_entry loop, but instead of
passing it a constant timeout you'd pass the remaining time.

Get the current time before and after each pci_dev_wait() call
from "jiffies", calculate the difference, convert to msecs with
jiffies_to_msecs() and subtract from the "timeout" parameter
passed in by the caller, then simply pass "timeout" to each
pci_dev_wait() call.

As a side note, traversing the bus list normally requires
holding the pci_bus_sem for reading.  But it's probably unlikely
that devices are added/removed concurrently to a bus reset
and we're doing it wrong pretty much everywhere in the
PCI reset code, so...

(I fixed up one of the reset functions with 10791141a6cf,
but plenty of others remain...)

Thanks,

Lukas
