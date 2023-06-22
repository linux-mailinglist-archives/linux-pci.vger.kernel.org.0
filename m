Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002A4739DFE
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 12:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjFVKE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 06:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjFVKEZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 06:04:25 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB71A2;
        Thu, 22 Jun 2023 03:04:23 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id F1EF4300097AF;
        Thu, 22 Jun 2023 12:04:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DC00A1CDF3D; Thu, 22 Jun 2023 12:04:21 +0200 (CEST)
Date:   Thu, 22 Jun 2023 12:04:21 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v3 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Message-ID: <20230622100421.GA31781@wunner.de>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230622063105.GA624@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622063105.GA624@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 22, 2023 at 08:31:05AM +0200, Lukas Wunner wrote:
> On Wed, Jun 21, 2023 at 06:51:52PM +0000, Smita Koralahalli wrote:
> The commit message doesn't point out that PCI_EXP_DEVCTL2_ARI is
> already being taken care of on enumeration of future subordinate
> devices in pci_configure_ari() and is only cleared here for good
> measure.  If you intend to configure 10 bit tags and atomic ops
> on enumeration in future patches, I'd recommend omitting
> PCI_EXP_DEVCTL2_ARI here and clearing each of the other two bits
                               ^^^^^^^^

Sorry, I meant to say "dropping".  I.e. once you enable or disable
the feature on enumeration and there's no longer a need to
unconditionally disable it on de-enumeration, drop clearing the bit
here.

Thanks,

Lukas
