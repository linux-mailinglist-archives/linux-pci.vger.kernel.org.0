Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1E76EFFCC
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 05:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbjD0D2X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 23:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjD0D2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 23:28:22 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2ED3A81
        for <linux-pci@vger.kernel.org>; Wed, 26 Apr 2023 20:28:20 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6CB762800C962;
        Thu, 27 Apr 2023 05:28:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 48DDF1FB8C; Thu, 27 Apr 2023 05:28:16 +0200 (CEST)
Date:   Thu, 27 Apr 2023 05:28:16 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Damien Le Moal <dlemoal@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [GIT PULL] PCI changes for v6.4
Message-ID: <20230427032816.GA18461@wunner.de>
References: <20230425200936.GA66754@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425200936.GA66754@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Tue, Apr 25, 2023 at 03:09:36PM -0500, Bjorn Helgaas wrote:
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> 
>   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.4-changes
> 
> for you to fetch changes up to 09a8e5f01dfb30667a8f05e35c1cc073cb4fd134:
> 
>   Merge branch 'pci/controller/kconfig' (2023-04-20 16:19:37 -0500)

Just a heads-up that this pull request doesn't include the following
topic branches in pci.git:

    controller/endpoint
    controller/cadence
    controller/vmd

... as well as the following commit on the controller/dt branch:

    661a7e9aa551 ("dt-bindings: PCI: qcom: Add SDX65 SoC")

Perhaps you intend to submit them in a second pull request this
merge window, but I just wanted to make sure they're not forgotten.
The patches applied to those topic branches are marked "Accepted"
in patchwork, so if the topic branches are deleted when the 6.5
cycle begins, the patches would seem to have been merged even though
they're not.

Thanks,

Lukas
