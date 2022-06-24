Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A5D559B44
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiFXOQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFXOQZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:16:25 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2E85DC3C;
        Fri, 24 Jun 2022 07:16:07 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A7D8F102A8019;
        Fri, 24 Jun 2022 16:15:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8503D458E61; Fri, 24 Jun 2022 16:15:31 +0200 (CEST)
Date:   Fri, 24 Jun 2022 16:15:31 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "ben@bwidawsk.net" <ben@bwidawsk.net>, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, "Box, David E" <david.e.box@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: (SPDM) Device attestation, secure channels from host to device
 etc: Discuss at Plumbers?
Message-ID: <20220624141531.GA32171@wunner.de>
References: <20220609124702.000037b0@Huawei.com>
 <YqICCSd/6Vxidu+v@iweiny-desk3>
 <20220617112124.00002296@Huawei.com>
 <20220620165217.GA18451@wunner.de>
 <20220622124638.00004456@Huawei.com>
 <20220624120830.00002eef@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624120830.00002eef@Huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 12:08:30PM +0100, Jonathan Cameron wrote:
> I've put this in for now:

Perfect!  For me as a non-native English speaker, it would have been
a lot more difficult to write up such an excellent description,
so thanks for doing this.

> Hence this proposal for a BoF rather than session in 
> either PCI or CXL uconf.

I think this has overlap with the Confidential Computing uconf as well,
so that might be another potentially interested audience.

(Link encryption is by its very nature "confidential computing",
and attestation is explicitly mentioned on the CC uconf page:
https://lpc.events/event/16/contributions/1143/ )

Thanks,

Lukas
