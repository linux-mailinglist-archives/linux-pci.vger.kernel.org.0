Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06A7687A5
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jul 2023 21:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjG3TqW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jul 2023 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjG3TqS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jul 2023 15:46:18 -0400
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Jul 2023 12:45:55 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFC119BB;
        Sun, 30 Jul 2023 12:45:55 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 00F7D100D5860;
        Sun, 30 Jul 2023 21:40:27 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B5CD2120C49; Sun, 30 Jul 2023 21:40:26 +0200 (CEST)
Date:   Sun, 30 Jul 2023 21:40:26 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, alex.williamson@redhat.com,
        treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        vsethi@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: pciehp: Disable ACS Source Validation during
 hot-remove
Message-ID: <20230730194026.GA19962@wunner.de>
References: <20230111190533.29979-1-vidyas@nvidia.com>
 <20230730191519.3124390-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730191519.3124390-1-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 31, 2023 at 12:45:19AM +0530, Vidya Sagar wrote:
> PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted to
> send upstream messages before they have been assigned a bus number and
> such messages have a Requester ID with Bus number set to 00h.
> If the Downstream port has ACS Source Validation enabled, these messages
> will be detected as ACS violation error.
> 
> Hence, disable ACS Source Validation in the bridge device during
> hot-remove operation and re-enable it after enumeration of the
> downstream hierarchy but before binding the respective device drivers.

What are these messages that are sent before assignment of a bus number?

What's the user-visible issue that occurs when they're blocked?

Doesn't disabling Source Validation introduce a security hole because the
device may spoof messages before Source Validation is re-enabled?

PCIe r6.1 sec 6.12.1.1 does indeed point out that the downstream device
is *permitted* to send these messages but the Implementation Note
does *not* prescribe that Source Validation shall be disabled to let them
through.  It merely points out that the messages may be filtered if
Source Validation is enabled.

Thanks,

Lukas
