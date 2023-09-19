Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2817A6779
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjISO7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 10:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjISO7d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 10:59:33 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231F4185
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 07:59:23 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 681E0103201BB;
        Tue, 19 Sep 2023 16:59:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3A4AD517D5; Tue, 19 Sep 2023 16:59:21 +0200 (CEST)
Date:   Tue, 19 Sep 2023 16:59:21 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Schroeder, Chad" <CSchroeder@sonifi.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCIe device issue since v6.1.16
Message-ID: <20230919145921.GA8609@wunner.de>
References: <DM6PR16MB2844903E34CAB910082DF019B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR16MB2844903E34CAB910082DF019B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Chad,

On Tue, Sep 19, 2023 at 02:17:29PM +0000, Schroeder, Chad wrote:
> 	After researching the issue, I found the commit that lead system error:
> 
> 	https://lore.kernel.org/all/da77c92796b99ec568bd070cbe4725074a117038.1673769517.git.lukas@wunner.de/
> 
> 	Specifically, this removal:
> 
> 	- Drop an unnecessary 1 sec delay from pci_reset_secondary_bus() which
> 	is now performed by pci_bridge_wait_for_secondary_bus().  A static
> 	delay this long is only necessary for Conventional PCI, so modern
> 	PCIe systems benefit from shorter reset times as a side effect.

Thanks for the report and sorry for the breakage.

This endpoint device only supports Gen1 speed (2.5GT/s) and does not support
Data Link Layer Link Active Reporting.  I have a suspicion that I neglected
to take this case into account in pci_bridge_wait_for_secondary_bus().

To better understand what's going on, could you also provide "lspci -vvv"
output of the parent bridge above 0000:65:00.0 (i.e. of the bridge whose
secondary bus is 65)?

Thanks!

Lukas
