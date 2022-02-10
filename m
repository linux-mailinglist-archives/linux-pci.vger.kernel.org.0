Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558784B077B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 08:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiBJHrv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 02:47:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbiBJHrt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 02:47:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7AEDAE;
        Wed,  9 Feb 2022 23:47:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7B5A60B49;
        Thu, 10 Feb 2022 07:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEB7C004E1;
        Thu, 10 Feb 2022 07:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644479268;
        bh=OTUS2plVg6f1zIM/zoZB86CKP0+qe6czXlSwH93Fi9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnnZiYjd5dlayL7uCJ5LZU6bn4SM6kxeDIGbWdXeudngmjIz48v0lrJS3EDAM7Mz4
         R7ORO5FHVrwa1TvKN40Hz4hHE7ilbjfC1vU3I+1PGAU/foJT7rJ11dPReByKLEF0n1
         sVFnDFbQH612vFADpUX82VMtLz+GzZuMpNKWHbW8=
Date:   Thu, 10 Feb 2022 08:47:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [EXT] [RFC PATCH 0/5] PCIe EPF support for internal DMAC
 handling and driver update for R-Car PCIe EP to support DMAC
Message-ID: <YgTDIVCQZ3hT9ofX@kroah.com>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <PH7PR19MB5562AC3C5E7BBB7730086CC1A02E9@PH7PR19MB5562.namprd19.prod.outlook.com>
 <CA+V-a8tEwOR-r=+KDe2DhpTMwhXPTgbZYgOWepST3mnhBL_Hag@mail.gmail.com>
 <PH7PR19MB5562CE44BBDF09B2ECD30BEDA02F9@PH7PR19MB5562.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR19MB5562CE44BBDF09B2ECD30BEDA02F9@PH7PR19MB5562.namprd19.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 10, 2022 at 05:54:26AM +0000, Li Chen wrote:
> **********************************************************************
> This email and attachments contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.

This email footer is not compatible with Linux kernel development,
sorry.  Please get your company to remove it so that you can continue to
participate.
