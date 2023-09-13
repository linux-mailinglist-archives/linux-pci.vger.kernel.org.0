Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E179DEE2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 06:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjIMEH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 00:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIMEH4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 00:07:56 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47091E4B;
        Tue, 12 Sep 2023 21:07:52 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 251C3300002A0;
        Wed, 13 Sep 2023 06:07:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 12E466F3DF; Wed, 13 Sep 2023 06:07:50 +0200 (CEST)
Date:   Wed, 13 Sep 2023 06:07:50 +0200
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
Message-ID: <20230913040750.GA1359@wunner.de>
References: <20230815212043.114913-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230815212043.114913-2-Smita.KoralahalliChannabasappa@amd.com>
 <20230828073542.GA12658@wunner.de>
 <440ad7c8-35f7-5b15-5de6-f220cae2cde0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440ad7c8-35f7-5b15-5de6-f220cae2cde0@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 12, 2023 at 03:45:34PM -0700, Smita Koralahalli wrote:
> Thanks for the review. Would it be possible to consider this patch as a
> standalone while I work on 10-bit tags enumeration? I can do v5 for this
> patch with $SUBJECT changes and also include clearing Atomic Ops and 10-bit
> tags unconditionally on hot-remove if that works..

Right, this patch is still in state "New" in patchwork:

https://patchwork.kernel.org/project/linux-pci/patch/20230815212043.114913-2-Smita.KoralahalliChannabasappa@amd.com/

Which means Bjorn probably hasn't gotten a chance to look at it.
Indeed it can be applied standalone if Bjorn gets to it this cycle
and doesn't have any objections.

Feel free to include my Reviewed-by tag if/when resending.

Thanks,

Lukas
