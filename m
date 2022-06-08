Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD84543767
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 17:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244289AbiFHP1n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 11:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244379AbiFHP1c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 11:27:32 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C94F46B1B;
        Wed,  8 Jun 2022 08:23:46 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id E59AD10045BFB;
        Wed,  8 Jun 2022 17:23:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AE3DF2ED3A3; Wed,  8 Jun 2022 17:23:44 +0200 (CEST)
Date:   Wed, 8 Jun 2022 17:23:44 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sheng Bi <windy.bi.enflame@gmail.com>
Cc:     helgaas@kernel.org, bhelgaas@google.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Fix no-op wait after secondary bus reset
Message-ID: <20220608152344.GA17064@wunner.de>
References: <CAGdb+H0qnC4noBa_=N3oQW88+dgXYtA7gqJ5qiD2g7Ywd+2K=Q@mail.gmail.com>
 <20220523171517.32407-1-windy.bi.enflame@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523171517.32407-1-windy.bi.enflame@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 24, 2022 at 01:15:17AM +0800, Sheng Bi wrote:
> pci_bridge_secondary_bus_reset() triggers SBR followed by 1 second sleep,
> and then uses pci_dev_wait() for waiting device ready. The dev parameter
> passes to the wait function is currently the bridge itself, but not the
> device been reset.
> 
> If we call pci_bridge_secondary_bus_reset() to trigger SBR to a device,
> there is 1 second sleep but not waiting device ready, since the bridge
> is always ready while resetting downstream devices. pci_dev_wait() here
> is a no-op actually. This would be risky in the case which the device
> becomes ready after more than 1 second, especially while hotplug enabled.
> The late coming hotplug event after 1 second will trigger hotplug module
> to remove/re-insert the device.
> 
> Instead of waiting ready of bridge itself, changing to wait all the
> downstream devices become ready with timeout PCIE_RESET_READY_POLL_MS
> after SBR, considering all downstream devices are affected during SBR.
> Once one of the devices doesn't reappear within the timeout, return
> -ENOTTY to indicate SBR doesn't complete successfully.
> 
> Fixes: 6b2f1351af56 ("PCI: Wait for device to become ready after secondary bus reset")
> Signed-off-by: Sheng Bi <windy.bi.enflame@gmail.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.17+

Code-wise, this LGTM.  There are a few things that could be
improved in the commit message, e.g. in the last paragraph,
"changing" (gerund form) is not proper English and the
imperative form "change" would be correct here.  However,
these details are difficult to get right for anyone who is
not an English native speaker and often Bjorn will wordsmith
the commit message to perfect it.

See here for some of the things Bjorn looks for:
https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

Bjorn may not find the time to look over your patch immediately,
so please be patient.

Thanks!

Lukas
