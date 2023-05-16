Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6346704A34
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 12:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjEPKOG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 06:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjEPKOG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 06:14:06 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AB2E6A;
        Tue, 16 May 2023 03:14:05 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id AB0B930000347;
        Tue, 16 May 2023 12:14:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9FFB3260B59; Tue, 16 May 2023 12:14:03 +0200 (CEST)
Date:   Tue, 16 May 2023 12:14:03 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH 1/2] PCI: pciehp: Add support for OS-First Hotplug and
 AER/DPC
Message-ID: <20230516101403.GA3398@wunner.de>
References: <20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com>
 <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
 <20221104101536.GA11363@wunner.de>
 <fba22d6b-c225-4b44-674b-2c62306135ed@amd.com>
 <20230510201937.GA11550@wunner.de>
 <20230511152326.GA16215@wunner.de>
 <579cb233-4827-2d03-56ad-1b807a189ba8@amd.com>
 <20230515193835.GA17526@wunner.de>
 <14ac1391-9ab9-d352-d3b1-ba6caae3d9df@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ac1391-9ab9-d352-d3b1-ba6caae3d9df@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 15, 2023 at 01:56:25PM -0700, Smita Koralahalli wrote:
> Could I please know, why do you think masking surprise down during
> initialization would be a better approach than reading surprise down error
> status on a DPC event? Because in both approaches we should be however
> clearing status registers right?

Masking seemed much simpler, more elegant, less code.

I wasn't aware that masking the error merely suppresses the message to
the Root Complex plus the resulting interrupt, but still logs the error.
That's kind of a bummer, so I think your approach is fine and I've just
sent you some review feedback on your patch.

Thanks,

Lukas
