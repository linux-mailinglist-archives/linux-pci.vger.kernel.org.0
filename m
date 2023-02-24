Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64786A16C8
	for <lists+linux-pci@lfdr.de>; Fri, 24 Feb 2023 07:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjBXG4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Feb 2023 01:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBXG4e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2023 01:56:34 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A8D57D09;
        Thu, 23 Feb 2023 22:56:33 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 395CD28055542;
        Fri, 24 Feb 2023 07:56:29 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1C0723EC36; Fri, 24 Feb 2023 07:56:29 +0100 (CET)
Date:   Fri, 24 Feb 2023 07:56:29 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Brian van der Beek <bbeek@marvell.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Christophe Therene <ctherene@marvell.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: Question on DOE requirements for CXL/CDAT and CMA/SPDM
Message-ID: <20230224065629.GA15827@wunner.de>
References: <SJ0PR18MB496423534AC55973B92E3913B3AB9@SJ0PR18MB4964.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR18MB496423534AC55973B92E3913B3AB9@SJ0PR18MB4964.namprd18.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 23, 2023 at 01:06:47PM +0000, Brian van der Beek wrote:
> For a CXL device that support both CMA/SPDM and CXL Table Access DOE
> (CDAT) data objects, is it mandatory to have a dedicated DOE instance
> for the CMA/SPMA protocol data objects?

Yes, that follows from the requirements you quoted from the PCIe spec.


> Or is it permitted for the CMA/SPDM and CXL protocols to share a
> single DOE instance?

You'd violate the PCIe spec and depend on software to handle such
non-standard behavior gracefully.


> I am reaching out to you, as I am hoping you could provide some
> insight on the Linux CMA/SPDM implementation and whether it allows
> for a DOE instance to be shared with CXL/CDAT data objects.

The code as it currently is will allow that.


> PCI-SIG replied that the requirement of a dedicated DOE instance for
> CMA/SPDM was an intentional choice based on the idea that the software
> attached to the DOE instances would be different.

The PCISIG has published the DOE 1.1 ECN in the meantime and it
allows for concurrent use of a mailbox by different software
entities (kernel, BIOS, ...) through the use of a unique
Connection ID.  You could ask the PCISIG to revisit the spec's
protocol restriction for CMA/SPDM in light of DOE 1.1.
There's an ECR for CMA/SPDM currently under development.

Thanks,

Lukas
