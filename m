Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BDA6E4191
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDQHqi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 03:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDQHqh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 03:46:37 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2652A8;
        Mon, 17 Apr 2023 00:46:35 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id E6437300002CD;
        Mon, 17 Apr 2023 09:46:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D4A1D3CB3B; Mon, 17 Apr 2023 09:46:33 +0200 (CEST)
Date:   Mon, 17 Apr 2023 09:46:33 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: s390: Fix use-after-free of PCI resources
 with per-function hotplug
Message-ID: <20230417074633.GA12881@wunner.de>
References: <20230306151014.60913-1-schnelle@linux.ibm.com>
 <20230306151014.60913-2-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306151014.60913-2-schnelle@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 06, 2023 at 04:10:11PM +0100, Niklas Schnelle wrote:
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -76,6 +76,27 @@ struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n)
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_resource_n);
>  
> +void pci_bus_remove_resource(struct pci_bus *bus, struct resource *res)
> +{
> +	struct pci_bus_resource *bus_res, *tmp;
> +	int i;
> +
> +	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
> +		if (bus->resource[i] == res) {
> +			bus->resource[i] = NULL;
> +			return;
> +		}
> +	}
> +
> +	list_for_each_entry_safe(bus_res, tmp, &bus->resources, list) {
> +		if (bus_res->res == res) {
> +			list_del(&bus_res->list);
> +			kfree(bus_res);
> +			return;
> +		}
> +	}
> +}

I realize this has already been applied so s390.git/master,
but nevertheless would like to point out there's a handy
pci_bus_for_each_resource() helper which could have been
used here instead of the for-loop.

Sorry for chiming in late, I just spotted this while flushing out
my inbox.

Adding Andy to cc: who's been active in this area recently.

Thanks,

Lukas
