Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D4273E45B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 18:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjFZQNx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 12:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFZQNq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 12:13:46 -0400
X-Greylist: delayed 2147 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Jun 2023 09:13:44 PDT
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103F12A
        for <linux-pci@vger.kernel.org>; Mon, 26 Jun 2023 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:To:
        MIME-Version:Date:Message-ID:cc:content-disposition;
        bh=rs1VdpLvoww5s8ZfEwPD+th0v+6ysNz41twwOh5VYog=; b=ix3DoD+BAF36mSF1bbWTcUTb6/
        dWrzM9dovHRuE2ru86vti7cx0IqWGLef0rBB5LnHZvwpVqw92+23ErEjAAHHJOQUBw+xSzQWO82S8
        5sDmToR6zSxltwBhHsJN47u7snlxdSx0Vci5cL6taJXnL7dP4nPvEfv5qgkPT6Qhe8WYxlZgpUQbK
        i3eovpRKjatD1z4wRfx9SBvhWzKJ3tTa17DSxiZYcYPYIxaItZfVSlduYM2lefIVMaqSDR0+tbYjS
        k/EYmZbEJjmDZeLtw8SPm1nv1f07bWWUTEo8d6Nr7N0bjJnKj009yFoHsNo+Abby71sjmwWXFNJgD
        y3n9FX3Q==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1qDoHk-002qwq-Po; Mon, 26 Jun 2023 09:37:49 -0600
Message-ID: <cd5ed21c-04f3-2c9c-4b56-225d3f20e016@deltatee.com>
Date:   Mon, 26 Jun 2023 09:37:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-CA
To:     kelvin.cao@microchip.com, kurt.schwemmer@microsemi.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230624000003.2315364-1-kelvin.cao@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230624000003.2315364-1-kelvin.cao@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kelvin.cao@microchip.com, kurt.schwemmer@microsemi.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH 0/2] PCI: switchtec: Add support for PCIe Gen5 devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-06-23 18:00, kelvin.cao@microchip.com wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
> 
> Hi,
> 
> This patchset adds support for Switchtec PCIe Gen5 devices by adding
> device IDs to the driver and PCI quirks. There's also minor code change
> to accommodate those devices.
> 
> The patchset is based off of v6.4-rc7.
> 
> Thanks,
> Kelvin
> 
> Kelvin Cao (2):
>   PCI: switchtec: Use normal comment style
>   PCI: switchtec: Add support for PCIe Gen5 devices

Both patches look good to me, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
