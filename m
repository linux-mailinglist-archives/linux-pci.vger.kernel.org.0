Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2731563102E
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 19:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKSSD2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Nov 2022 13:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKSSD1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Nov 2022 13:03:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9302B7
        for <linux-pci@vger.kernel.org>; Sat, 19 Nov 2022 10:03:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33FB960B88
        for <linux-pci@vger.kernel.org>; Sat, 19 Nov 2022 18:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D87C433D6;
        Sat, 19 Nov 2022 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668881004;
        bh=cXv37yIUBYIFAgYaSvho3/2yQndusmpsYN7runh9qOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V8PLHdiaIGYmJEp6XgUvggH/Tq5lOY5WwonVLQTzRE8HSBbf1boktvF+B23Wl56ue
         oH3caXlLZmE3WIZDER5ULWz/Tm1uvBiidG3QQLamaxvPezQuCGqwyoJR8EjNAUvJHU
         ThHchJKt2UOR2xGvWjvOY4/etuDisFtafW7hJKlarAIREyTqHAplgpQDT3GKwT+2xh
         6XLCkKiYRx1o7NASQTucs9I7Kr2LBKA45+/v1NN9rFUsQXevC2qvZjZOEQpi340yQa
         xezyQjjnHUD/mqBC+LaO9yYyeHVggKn0AQPHhtfuhePP9zUlTkez+50mQpkLvUc9uM
         9XmdkJunlvUPQ==
Date:   Sat, 19 Nov 2022 12:03:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, kw@linux.com, robh@kernel.org,
        lpieralisi@kernel.org
Subject: Re: [PATCH] PCI: mt7621: increase PERST_DELAY_MS
Message-ID: <20221119180322.GA1366676@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119110837.2419466-1-sergio.paracuellos@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sergio,

s/increase/Increase/ in subject, to match history.

On Sat, Nov 19, 2022 at 12:08:37PM +0100, Sergio Paracuellos wrote:
> Some devices using this SoC and PCI's like ZBT WE1326 and Netgear R6220 need
> more time to get the PCI ports properly working after reset. Hence, increase
> PERST_DELAY_MS definition used for this purpose from 100 ms to 500 ms to get
> into confiable boots and working PCI for these devices.

confiable?

It looks like we sleep for PERST_DELAY_MS twice during probe:

  mt7621_pcie_probe
    mt7621_pcie_init_ports
      mt7621_pcie_reset_assert
        list_for_each_entry(port, &pcie->ports, list)
          mt7621_control_assert
          mt7621_rst_gpio_pcie_assert
        msleep(PERST_DELAY_MS)                      #1
      mt7621_pcie_reset_rc_deassert
        list_for_each_entry(port, &pcie->ports, list)
          mt7621_control_deassert

      mt7621_pcie_reset_ep_deassert
        list_for_each_entry(port, &pcie->ports, list)
          mt7621_rst_gpio_pcie_deassert
        msleep(PERST_DELAY_MS)                      #2

so this increases the minimum probe time from 200 ms to 1000 ms.  It
looks like these delays have different purposes and might not need to
be the same.

I assume mt7621_pcie_reset_assert() asserts PERST#, and the sleep #1
is enforcing T_PVPERL, i.e., the minimum time between power becoming
stable and PERST# being inactive, which PCIe CEM r2.0, sec 2.6.2, says
is at least 100 ms.  We probably don't know how long it takes for
power to become stable, and the previous PERST_DELAY_MS of 100 ms
didn't include any time for that, so it makes sense to me to increase
it.

But what about sleep #2?  That happens *after* PERST# is deasserted,
so it seems like that must be for a different purpose, and if so,
deserves its own separate #define.  PCIe r6.0, sec 6.6.1 specifies a
minimum 100 ms after exiting Conventional Reset before sending config
requests.  Is that what this delay is for?  If so, maybe it doesn't
need to be increased?  Or maybe not as much?

Bjorn

> Fixes: 475fe234bdfd ("staging: mt7621-pci: change value for 'PERST_DELAY_MS'")
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index 4bd1abf26008..438889045fa6 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -60,7 +60,7 @@
>  #define PCIE_PORT_LINKUP		BIT(0)
>  #define PCIE_PORT_CNT			3
>  
> -#define PERST_DELAY_MS			100
> +#define PERST_DELAY_MS			500
>  
>  /**
>   * struct mt7621_pcie_port - PCIe port information
> -- 
> 2.25.1
> 
