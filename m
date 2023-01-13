Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E7A66994A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 15:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbjAMOCN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 09:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjAMOBZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 09:01:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEE613F60;
        Fri, 13 Jan 2023 05:58:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 507D0B8206B;
        Fri, 13 Jan 2023 13:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AC4C433D2;
        Fri, 13 Jan 2023 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673618313;
        bh=kGpMQxjI+fFQs+jBsaQNT3ZJMiDOZkdLszEE2sQFRCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a0b6N8+JbeS5RVqc3A1GvhT8qfZBs89IP5y30W79s44rrUaFmN3Iq/PcmfbvWCAoi
         bAg9+/vRi63twHuw8/t6EHBLUg3+UZlGkTs21MAHBQKj0HKI7Ssl2mhqEuupAZQPQL
         h3OGSbIfl0jxx+15dwHn4do/GIf3rJmnUmXWv6puOkr5eCjOTFd5nxomLf0Ksg2FP4
         cLH4ZXIB2pGCv7QsWo3FqHokcDi07JWBv7OYJdGkRgcO3us2Uxgj3bvVBTMRAmX+n6
         j9sX9nyefXIie0kj4z3qTGzyxqaoEoWKey7+ki1E79d6ogiLEId1FzhuISpcywY4XP
         MowxazhYPP+aA==
Date:   Fri, 13 Jan 2023 07:58:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: avoid defines prefixed with CONFIG
Message-ID: <20230113135830.GA1835786@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113084516.31888-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On Fri, Jan 13, 2023 at 09:45:16AM +0100, Lukas Bulwahn wrote:
> Defines prefixed with "CONFIG" should be limited to proper Kconfig options,
> that are introduced in a Kconfig file.
> 
> Here, a definition for a bitmask to configure the SEND_ENABLE mode is named
> CONFIG_SEND_ENABLE.
> 
> Rename this local definition to CONFIGURE_SEND_ENABLE to avoid defines
> prefixed with "CONFIG".
> 
> No functional change.

If you update this patch, please capitalize the subject to match:

  $ git log --oneline drivers/pci/controller/pcie-rcar-host.c
  6e36203bc14c ("PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read which triggered an exception")
  84b576146294 ("PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()")
  d2a14b54989e ("PCI: rcar: Check if device is runtime suspended instead of __clk_is_enabled()")
  a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
  83ed8d4fa656 ("PCI: rcar: Convert to MSI domains")

Bjorn
