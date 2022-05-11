Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911E5523D4B
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 21:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiEKTTv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 15:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiEKTTt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 15:19:49 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838A08AE40;
        Wed, 11 May 2022 12:19:48 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id CC918103201C7;
        Wed, 11 May 2022 21:19:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A2FE6156C32; Wed, 11 May 2022 21:19:43 +0200 (CEST)
Date:   Wed, 11 May 2022 21:19:43 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Gavin Hindman <gavin.hindman@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Message-ID: <20220511191943.GB26623@wunner.de>
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de>
 <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511191345.GA26623@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 09:13:45PM +0200, Lukas Wunner wrote:
> When an IDE-capable device is runtime suspended to D3hot and later
> runtime resumed to D0, it may not preserve its internal state.
> (The No_Soft_Reset bit in the Power Management Control/Status Register
> tells us whether the device is capable of preserving internal state
> over a transition to D3hot, see PCIe r6.0, sec. 7.5.2.2.)
> 
> Likewise, when an IDE-capable device is reset (e.g. due to Downstream
> Port Containment, AER or a bus reset initiated by user space),
> internal state is lost and must be reconstructed by pci_restore_state().
> That state includes the SPDM session or IDE encryption.

Digging a little further, sec. 6.33.8 says that "The No_Soft_Reset bit
must be Set", so at least IDE will always survive a D3hot transition.

But the reset argument still stands:  That same section says that all
IDE streams transition to Insecure and all keys are invalidated upon
reset.

Thanks,

Lukas
