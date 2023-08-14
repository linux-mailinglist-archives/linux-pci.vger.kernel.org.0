Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A9077BE2C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 18:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjHNQff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjHNQfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 12:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7563BE0;
        Mon, 14 Aug 2023 09:35:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1324C6171C;
        Mon, 14 Aug 2023 16:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433BCC433C8;
        Mon, 14 Aug 2023 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692030930;
        bh=5rqGMhzjNA2uxOwCAkvro64W6zVd58aje4qxMuDi/sE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a1Bu6NHwKJ7TamWenDpHupeJDBxC2HGPPagp5H//vVCjSfakH5Dp4KBFP4EsTqdsB
         QXUQok8ckzKtSWSkWeFaqmjXXkWQy9ojJ2wWWODCcu8EPaLOf+X4RBoBOGsPKoyWsr
         zLug+GKtopOp0Q0SNX+7Tr3a53GjkJmMa9IEcsJEXuMR7AaCRSSiFdt2VLq9q/lZXB
         R1jJmeypfVF9Ook6wrRiL4jYtOOHLcEN7UJPp4ckdt9Uyia9jRhWNIIksnCrHmS8S5
         qj5HDfJHXz3jujFiF5+GB3iT6WU2FU3SQn0GytLjOushdSCh0C4PVBXhrjB376BaC6
         Ifm9mpgcsmhzg==
Date:   Mon, 14 Aug 2023 11:35:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "usa@junocomputers.com" <usa@junocomputers.com>,
        linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-pm@vger.kernel.org
Subject: Re: firmware-iwlwifi: Wireless AC 7265 lacks D3cold support
Message-ID: <20230814163528.GA177266@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29c5e32631abc368e7272fd193b0289ff8da0f95.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mario, linux-pm]

On Sun, Aug 13, 2023 at 03:33:21PM +0000, Greenman, Gregory wrote:
> On Fri, 2023-08-11 at 15:34 -0400, Juno Computers USA wrote:
> > Any updates on this?

D3cold support has been a problem area, and there are some changes in
progress [1] that could be related.

Could you possibly collect the complete dmesg logs (with a recent
upstream kernel, e.g., v6.4, if possible)?  And the output of
"sudo lspci -vv"?  And the contents of /sys/firmware/acpi/tables/?
You can attach them to the Debian bug report if that's convenient for
you.

Bjorn

[1] https://lore.kernel.org/r/20230809185453.40916-1-mario.limonciello@amd.com

> > On Aug 3 2023, at 8:01 am, Juno Computers USA <usa@junocomputers.com> wrote:
> > > Dear Maintainer,
> > > 
> > > If D3Cold is enabled from BIOS the tablet boots without Wifi.
> > > The only two ways to enable wifi support is either by disabling
> > > D3Cold from BIOS (not ideal) or adding pcie_port_pm=off to grub
> > > 
> > > [   12.681303] iwlwifi 0000:01:00.0: Detected Intel(R) Dual Band Wireless AC 7265, REV=0x210
> > > 
> > > This is needed for our new Juno Tab 2
> > > 
> > > https://junocomputers.com/us/product/juno-tab-2/
> > > 
> > > I also filed this under Debian bug-tracker.
> > > 
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1036633
> > > Thanks,
> > > 
> > > Giovanni Caligaris
> > > Juno Computers USA
> > > P: (215) 509-5472
> > > W: https://junocomputers.com/us
> 
> This device is very old and actually already EOL, so I'll not be
> able to get any support for this internally. D3 works fine with this
> NIC on standard, off the shelf laptops, so I'd guess that the probem
> could be rooted in the tablets' PCIe hardware or maybe the BIOS
> itself.
