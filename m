Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D2F7B46DD
	for <lists+linux-pci@lfdr.de>; Sun,  1 Oct 2023 12:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjJAKbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Oct 2023 06:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjJAKbv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Oct 2023 06:31:51 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395BD8;
        Sun,  1 Oct 2023 03:31:46 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0CD1B30000F33;
        Sun,  1 Oct 2023 12:31:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 00557267E4E; Sun,  1 Oct 2023 12:31:44 +0200 (CEST)
Date:   Sun, 1 Oct 2023 12:31:44 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
        christian.koenig@amd.com, kch@nvidia.com,
        gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v8 1/3] PCI/DOE: Rename DOE protocol to feature
Message-ID: <20231001103144.GA8318@wunner.de>
References: <20230921055531.2028834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921055531.2028834-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 21, 2023 at 03:55:29PM +1000, Alistair Francis wrote:
> DOE r1.1 replaced all occurrences of "protocol" with the term "feature"
> or "Data Object Type".
> 
> PCIe r6.1 (which was published July 24) incorporated that change.
> 
> This patch renames the existing terms protocol with feature.

Imperative mood is generally preferred instead of "This patch", i.e.:
"Rename the exising..."

Could you also rename PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL
to PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE (per PCIe r6.1 Table 6-31,
both in drivers/pci/doe.c and include/uapi/linux/pci_regs.h).

Likewise PCI_DOE_PROTOCOL_DISCOVERY to PCI_DOE_FEATURE_DISCOVERY
(per PCIe r6.1 sec 6.30.1.1, only in drivers/pci/doe.c)?

With that addressed,
Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks!

Lukas
