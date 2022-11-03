Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA09618628
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 18:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiKCR2c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 13:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiKCR2b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 13:28:31 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468D913EA4;
        Thu,  3 Nov 2022 10:28:30 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id EACA0201349;
        Thu,  3 Nov 2022 17:03:34 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 7BB42801C7; Thu,  3 Nov 2022 18:03:24 +0100 (CET)
Date:   Thu, 3 Nov 2022 18:03:24 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH v2 4/4] pcmcia: Convert to use
 pci_bus_for_each_resource_p()
Message-ID: <Y2P0XCNJvTVuziO7@owl.dominikbrodowski.net>
References: <20221103164644.70554-1-andriy.shevchenko@linux.intel.com>
 <20221103164644.70554-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103164644.70554-5-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Thu, Nov 03, 2022 at 06:46:44PM +0200 schrieb Andy Shevchenko:
> The pci_bus_for_each_resource_p() hides the iterator loop since
> it may be not used otherwise. With this, we may drop that iterator
> variable definition.

Thanks for your patch!

> diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
> index ad1141fddb4c..9d92d4bb6239 100644
> --- a/drivers/pcmcia/rsrc_nonstatic.c
> +++ b/drivers/pcmcia/rsrc_nonstatic.c
> @@ -934,7 +934,7 @@ static int adjust_io(struct pcmcia_socket *s, unsigned int action, unsigned long
>  static int nonstatic_autoadd_resources(struct pcmcia_socket *s)
>  {
>  	struct resource *res;
> -	int i, done = 0;
> +	int done = 0;
>  
>  	if (!s->cb_dev || !s->cb_dev->bus)
>  		return -ENODEV;
> @@ -960,12 +960,9 @@ static int nonstatic_autoadd_resources(struct pcmcia_socket *s)
>  	 */
>  	if (s->cb_dev->bus->number == 0)
>  		return -EINVAL;
> -
> -	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
> -		res = s->cb_dev->bus->resource[i];
> -#else
> -	pci_bus_for_each_resource(s->cb_dev->bus, res, i) {
>  #endif
> +
> +	pci_bus_for_each_resource_p(s->cb_dev->bus, res) {
>  		if (!res)
>  			continue;

Doesn't this remove the proper iterator for X86? Even if that is the right
thing to do, it needs an explict explanation.

>  
> diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
> index 3966a6ceb1ac..b200f2b99a7a 100644
> --- a/drivers/pcmcia/yenta_socket.c
> +++ b/drivers/pcmcia/yenta_socket.c
> @@ -673,9 +673,8 @@ static int yenta_search_res(struct yenta_socket *socket, struct resource *res,
>  			    u32 min)
>  {
>  	struct resource *root;
> -	int i;
>  
> -	pci_bus_for_each_resource(socket->dev->bus, root, i) {
> +	pci_bus_for_each_resource_p(socket->dev->bus, root) {
>  		if (!root)
>  			continue;
>  

That looks fine!

Thanks,
	Dominik
