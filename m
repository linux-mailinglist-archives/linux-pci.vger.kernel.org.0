Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB4E62B6CE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 10:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiKPJoE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 04:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiKPJoE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 04:44:04 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC4DBD3
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 01:44:02 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 06D5A100E5F26;
        Wed, 16 Nov 2022 10:44:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D53BE2C94F; Wed, 16 Nov 2022 10:44:00 +0100 (CET)
Date:   Wed, 16 Nov 2022 10:44:00 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Li Ming <ming4.li@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/1] PCI/DOE: Fix maximum data object length
 miscalculation
Message-ID: <20221116094400.GA18061@wunner.de>
References: <20221116015637.3299664-1-ming4.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116015637.3299664-1-ming4.li@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 09:56:37AM +0800, Li Ming wrote:
> The value of data object length 0x0 indicates 2^18 dwords being
> transferred.

A spec reference would be nice, e.g.:

"According to PCIe r6.0.1 sec 6.30.1 table 6-29, the value of ..."


> This patch adjusts the value of data object length for the
> above case on both sending side and receiving side.

Nit:  Generally phrases like "This patch ..." should be avoided.
Use imperative mood instead, e.g.: "Adjust the value ..."


> Signed-off-by: Li Ming <ming4.li@intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas
