Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EB76FFB20
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 22:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbjEKUQv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 16:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKUQv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 16:16:51 -0400
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 13:16:48 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CD9E76;
        Thu, 11 May 2023 13:16:47 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id C65682800B3CA;
        Thu, 11 May 2023 22:10:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B8BDE23C8; Thu, 11 May 2023 22:10:25 +0200 (CEST)
Date:   Thu, 11 May 2023 22:10:25 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy?ski <kw@linux.com>, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/17] r8169: Use pcie_lnkctl_clear_and_set() for
 changing LNKCTL
Message-ID: <20230511201025.GC31598@wunner.de>
References: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
 <20230511131441.45704-15-ilpo.jarvinen@linux.intel.com>
 <98b3b70a-86c0-78c0-b734-0764bb5a21fc@gmail.com>
 <985b617-c5d7-dce3-318b-f2f8412beed3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <985b617-c5d7-dce3-318b-f2f8412beed3@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 11, 2023 at 11:00:02PM +0300, Ilpo Järvinen wrote:
> On Thu, 11 May 2023, Heiner Kallweit wrote:
> > On 11.05.2023 15:14, Ilpo Järvinen wrote:
> > > Don't assume that only the driver would be accessing LNKCTL. ASPM
> > > policy changes can trigger write to LNKCTL outside of driver's control.
> > > 
> > > Use pcie_lnkctl_clear_and_set() which does proper locking to avoid
> > > losing concurrent updates to the register value.
> > > 
> > 
> > Wouldn't it be more appropriate to add proper locking to the
> > underlying pcie_capability_clear_and_set_word()?
> 
> As per discussion for the other patch, that's where this series is now 
> aiming to in v2.

That discussion wasn't cc'ed to Heiner.  For reference, this is the
message Ilpo is referring to:

https://lore.kernel.org/linux-pci/ZF1AjOKDVlbNFJPK@bhelgaas/
