Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C42A773FD6
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjHHQyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjHHQxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199C4FB06
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 08:58:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE10A614F9
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 15:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04381C433C7;
        Tue,  8 Aug 2023 15:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691510296;
        bh=dsivP5QK/puytThT6Z/o/BL2ZSnYkylTLjGfbpcLdi8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d17bUPYC0qX1htLiPTAVikoi1UP+fA2yaPvY21PsAQSw0ijWbq0pjyxE/ftgcOnO8
         +5+AATNiD0HGS1G3eTlJ+pir22Qsd7VJfQmN2yuaKQ5umSTU9A5QY6nOH2TqpZEclT
         /awiJwvHAeB1JL3Y2IDDaZmbeT9DGUVBCbTOxvgLhqx0Z9CKCQobd4NSid9TCvoV2R
         1cWGhjSsK04Pn3ROuChrr9YujNXmderX6Ph2zwBAMiExbnMLaZdUKjYmZJHrEi4ciD
         Pw1El4upEKm94OHpcZNQXkPlGA+Db9npE3jqi9vE1OB7kRjSC9YGFyNpRgo2v3zFgh
         n4siK90AThEcQ==
Date:   Tue, 8 Aug 2023 10:58:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     bhelgaas@google.com, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, gregkh@linuxfoundation.org, ben.widawsky@intel.com,
        linux-pci@vger.kernel.org, yangyingliang@huawei.com,
        david.e.box@linux.intel.com, jonathan.cameron@huawei.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] PCI: Add pci_find_next_dvsec_capability to find
 next Designated VSEC
Message-ID: <20230808155814.GA313884@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808040858.183568-2-wangxiongfeng2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't re-post just for this, but if you do repost, add "()" after the
function name in the subject line, as you did for the 2/2 patch.

On Tue, Aug 08, 2023 at 12:08:57PM +0800, Xiongfeng Wang wrote:
> Some devices may have several DVSEC (Designated Vendor-Specific Extended
> Capability) entries with the same DVSEC ID. Add
> pci_find_next_dvsec_capability() to find them all.
