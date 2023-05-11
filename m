Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5BC6FFB0C
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 22:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbjEKUHP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 16:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbjEKUHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 16:07:13 -0400
X-Greylist: delayed 17024 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 13:07:12 PDT
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD2410EC;
        Thu, 11 May 2023 13:07:12 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 034D2300002CB;
        Thu, 11 May 2023 22:07:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E8B9C57CF0; Thu, 11 May 2023 22:07:10 +0200 (CEST)
Date:   Thu, 11 May 2023 22:07:10 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy?ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
Message-ID: <20230511200710.GB31598@wunner.de>
References: <ZF1AjOKDVlbNFJPK@bhelgaas>
 <1d5aaff-c7b5-39f6-92ca-319fad6c7fc5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d5aaff-c7b5-39f6-92ca-319fad6c7fc5@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 11, 2023 at 10:58:40PM +0300, Ilpo Järvinen wrote:
> On Thu, 11 May 2023, Bjorn Helgaas wrote:
> > Many of these are ASPM-related updates that IMHO should not be in
> > drivers at all.  Drivers should use PCI core interfaces so the core
> > doesn't get confused.
> 
> Ah, yes. I forgot to mention it in the cover letter but I noticed that 
> some of those seem to be workarounds for the cases where core refuses to 
> disable ASPM. Some sites even explicit have a comment about that after 
> the call to pci_disable_link_state():
[...]
> That kinda feels something that would want a force disable quirk that is 
> reliable. There are quirks for some devices which try to disable it but 
> could fail for reasons mentioned in that comment. (But I'd prefer to make 
> another series out of it rather than putting it into this one.)

I'm wondering if it's worth cleaning up ASPM handling in drivers first
as the locking issue may then largely solve itself.  The locking could
probably be kept internal to ASPM core code then.

Thanks,

Lukas
