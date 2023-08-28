Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D717A78A695
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjH1HgB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 03:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjH1Hft (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 03:35:49 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42753126;
        Mon, 28 Aug 2023 00:35:44 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 59433300002CB;
        Mon, 28 Aug 2023 09:35:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4BF6E2F90C9; Mon, 28 Aug 2023 09:35:42 +0200 (CEST)
Date:   Mon, 28 Aug 2023 09:35:42 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 1/3] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
Message-ID: <20230828073542.GA12658@wunner.de>
References: <20230815212043.114913-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230815212043.114913-2-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815212043.114913-2-Smita.KoralahalliChannabasappa@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 15, 2023 at 09:20:41PM +0000, Smita Koralahalli wrote:
> According to PCIe r6.0 sec 6.7.6 [1], async removal with DPC may result in
> surprise down error. This error is expected and is just a side-effect of
> async remove.
> 
> Add support to handle the surprise down error generated as a side-effect
> of async remove. Typically, this error is benign as the pciehp handler
> invoked by PDC or/and DLLSC alongside DPC, de-enumerates and brings down
> the device appropriately. But the error messages might confuse users. Get
> rid of these irritating log messages with a 1s delay while pciehp waits
> for dpc recovery.
[...]
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

The subject is slightly inaccurate as this doesn't touch pciehp source
files, although it is *related* to pciehp.

As an example, a perhaps more accurate subject might be something like...

  PCI/DPC: Ignore Surprise Down errors on hot removal

...but I don't think it's necessary to respin just for that as Bjorn is
probably able to adjust the subject to his liking when applying the patch.

Thanks a lot for patiently pursuing this issue, good to see it fixed.

Five years ago there was an attempt to solve it through masking Surprise
Down errors, which you've verified to not be a viable approach:

https://patchwork.kernel.org/project/linux-pci/patch/20180818065126.77912-2-okaya@kernel.org/

Lukas
