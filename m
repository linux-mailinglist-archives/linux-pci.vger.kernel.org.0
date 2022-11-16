Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702C762C888
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbiKPS5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239389AbiKPS44 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:56:56 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D7663FA
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 10:56:14 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id EB2342800C969;
        Wed, 16 Nov 2022 19:56:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E0400C73A; Wed, 16 Nov 2022 19:56:10 +0100 (CET)
Date:   Wed, 16 Nov 2022 19:56:10 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Li Ming <ming4.li@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/1] PCI/DOE: Fix maximum data object length
 miscalculation
Message-ID: <20221116185610.GA4563@wunner.de>
References: <20221116015637.3299664-1-ming4.li@intel.com>
 <20221116180250.GA1125709@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116180250.GA1125709@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 12:02:50PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 16, 2022 at 09:56:37AM +0800, Li Ming wrote:
> > The value of data object length 0x0 indicates 2^18 dwords being
> > transferred. This patch adjusts the value of data object length for the
> > above case on both sending side and receiving side.
> > 
> > Besides, it is unnecessary to check whether length is greater than
> > SZ_1M while receiving a response data object, because length from LENGTH
> > field of data object header, max value is 2^18.
> > 
> > Signed-off-by: Li Ming <ming4.li@intel.com>
> 
> Applied with Reviewed-by from Jonathan and Lukas, thank you very much
> to all of you!
> 
> I touched up the commit log; let me know if I made anything worse:

Jonathan mentioned that a Fixes tag might make sense.  If you agree:

Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
Cc: stable@vger.kernel.org # v6.0+

Thanks!

Lukas
