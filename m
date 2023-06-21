Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E233737C3A
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 09:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjFUHNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 03:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjFUHND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 03:13:03 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5725110D2;
        Wed, 21 Jun 2023 00:13:01 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 62097100FC16D;
        Wed, 21 Jun 2023 09:12:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2ECED110A0; Wed, 21 Jun 2023 09:12:59 +0200 (CEST)
Date:   Wed, 21 Jun 2023 09:12:59 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Message-ID: <20230621071259.GA2028@wunner.de>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230418210526.36514-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230511111902.GA10720@wunner.de>
 <cc36bb5b-6a4a-258b-6707-4d019154e019@amd.com>
 <20230616182409.GA8894@wunner.de>
 <d9cf3451-c0c1-ab86-0528-2c05982e7872@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9cf3451-c0c1-ab86-0528-2c05982e7872@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 16, 2023 at 04:34:27PM -0700, Smita Koralahalli wrote:
> On 6/16/2023 11:24 AM, Lukas Wunner wrote:
> > On Mon, May 22, 2023 at 03:23:31PM -0700, Smita Koralahalli wrote:
> > > On 5/11/2023 4:19 AM, Lukas Wunner wrote:
> > > > On Tue, Apr 18, 2023 at 09:05:26PM +0000, Smita Koralahalli wrote:
> > > Some couple of ways we think could be:
> > > [1] Check if these bits are enabled by Platform at boot time, clear them
> > > only it is set during hotplug flow.
> > > [2] Clear them unconditionally as I did..
> > > [3] Enable 10-bits tags in Linux when a device is probed just like how
> > > we do for ARI..
> > > 
> > > Similarly call pci_enable_atomic_ops_to_root() during a hot add..
> > 
> > Personally I'm fine with option [2].  If you or Bjorn prefer option [3],
> > I'm fine with that as well.
> 
> Looking forward for Bjorn comments!

You may want to consider first doing [2], i.e. clear the DevCtl2 bits
on hot removal, and then in a separate step do [3], i.e. add support
for enabling 10 bit tags and atomic ops in the kernel.  Having that
would certainly be useful, but it's more complex than just clearing
the DevCtl2 bits on unplug.  So you may want to do the latter as a
stop-gap.

Thanks,

Lukas
