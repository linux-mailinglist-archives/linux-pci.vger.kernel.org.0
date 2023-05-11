Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3210C6FFAFD
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 22:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbjEKUCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 16:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbjEKUCs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 16:02:48 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B578A72;
        Thu, 11 May 2023 13:02:46 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id DAC4E300002CB;
        Thu, 11 May 2023 22:02:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CD6831D8B48; Thu, 11 May 2023 22:02:44 +0200 (CEST)
Date:   Thu, 11 May 2023 22:02:44 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy??ski <kw@linux.com>, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/17] r8169: Use pcie_lnkctl_clear_and_set() for
 changing LNKCTL
Message-ID: <20230511200244.GA31598@wunner.de>
References: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
 <20230511131441.45704-15-ilpo.jarvinen@linux.intel.com>
 <98b3b70a-86c0-78c0-b734-0764bb5a21fc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98b3b70a-86c0-78c0-b734-0764bb5a21fc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 11, 2023 at 09:49:52PM +0200, Heiner Kallweit wrote:
> On 11.05.2023 15:14, Ilpo Järvinen wrote:
> > Don't assume that only the driver would be accessing LNKCTL. ASPM
> > policy changes can trigger write to LNKCTL outside of driver's control.
> > 
> > Use pcie_lnkctl_clear_and_set() which does proper locking to avoid
> > losing concurrent updates to the register value.
> 
> Wouldn't it be more appropriate to add proper locking to the
> underlying pcie_capability_clear_and_set_word()?

PCI config space accessors such as this one are also used in hot paths
(e.g. interrupt handlers).  They should be kept lean (and lockless)
by default.  We only need locking for specific PCIe Extended Capabilities
which are concurrently accessed by PCI core code and drivers.

Thanks,

Lukas
