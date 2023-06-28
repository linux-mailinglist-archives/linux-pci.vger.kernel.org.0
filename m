Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0AD74125E
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 15:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjF1N15 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 09:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjF1N1C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jun 2023 09:27:02 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5083582;
        Wed, 28 Jun 2023 06:25:28 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id DB72B2800B3CD;
        Wed, 28 Jun 2023 15:25:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C3BA343F1C9; Wed, 28 Jun 2023 15:25:26 +0200 (CEST)
Date:   Wed, 28 Jun 2023 15:25:26 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Message-ID: <20230628132526.GA14276@wunner.de>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230622063105.GA624@wunner.de>
 <d64f8de4-cac1-ccca-33fe-1fda418837e2@amd.com>
 <20230622214247.GB11993@wunner.de>
 <4599d885-219f-3ee0-f425-62746f31cc67@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4599d885-219f-3ee0-f425-62746f31cc67@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 10:38:54AM -0700, Smita Koralahalli wrote:
> Okay, I see there are no objections except for Bjorn/Jay's comments on
> 
> "But there could be devices where AtomicOps are nominally supported but
> untested or broken.."
> 
> Would this be an issue?

I think you said that BIOS enables AtomicOps on certain AMD machines?
Or did that observation only apply to 10 Bit tags?

If BIOS does enable AtomicOps, it would be interesting to know which
logic BIOS follows, i.e. how does it determine whether to set
AtomicOp Requester Enable on Endpoints?

It would also be interesting to know how far that BIOS has proliferated,
i.e. how much experience with various Endpoint devices exists in the
real world.  If it turns out that BIOS has enabled the feature for
years on a wide range of Endpoints without any issues, I think
that would render concerns mute that enabling it in the kernel
might cause regressions.

I don't know why the spec says that "discovery of AtomicOp Requester
capabilities is outside the scope of this specification".  I imagine
it would be possible to set AtomicOp Requester Enable, then read it
to determine whether the bit is now indeed 1 or hard-wired to 0.
In the latter case, AtomicOp Requester capabilities can be assumed
to be absent.  So that would be a way to make do without any other
specific discovery of AtomicOp Requester capabilities.

Thanks,

Lukas
