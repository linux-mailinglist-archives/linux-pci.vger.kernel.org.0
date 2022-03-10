Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEA34D528E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 20:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244004AbiCJTvb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 14:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243919AbiCJTv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 14:51:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AC21390DD;
        Thu, 10 Mar 2022 11:50:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01ABDB8276F;
        Thu, 10 Mar 2022 19:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6ADC340E9;
        Thu, 10 Mar 2022 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646941825;
        bh=hw2Lwu8uiGlVaaRZU6xCEXkOOb6VGkkDy0670anUTD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Kh3KjQIKFqV/UT649PJd/Gf+X+4Oj073YPak/CQ8NMX/jJ8s+OOAAXMI7IUCUtIGE
         NVd9c0QwEKmhrS4w35LvSxVjY3ZgD0YSx9phON4bF92iD/ZJ4i8bIH7cHqn/haWBJB
         soVKrDlOtZV5ZblBlobBQ5j7Utjhjdq1gZRPhJsBsEkAFJyvOBiAOWC5MCz/KhI+zc
         y0BuqmRz6+1xX2DAKBc9Bt4CYt9e4JX9j+jqtsjIa2sjBocs+cG48FyJWAx/Z19mWY
         U7a6b/AJw3gkovbMmCynKdDo0j20GVcaitqyjcrvUIgqFsvLDsozWTQTG7RIsaCQGZ
         NL7i3N4gZBjlw==
Date:   Thu, 10 Mar 2022 13:50:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-pci@vger.kernel.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI: fu740: Force Gen1 to fix initial device probing on
 some boards
Message-ID: <20220310195023.GA177539@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53bccf99-c183-78f9-f6cb-2921228ced48@codethink.co.uk>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 10, 2022 at 09:06:08AM +0000, Ben Dooks wrote:
> On 10/03/2022 00:15, Bjorn Helgaas wrote:

> > Seems like this isn't quite baked yet.  Lorenzo has the v4 of this on
> > his pci/fu740 branch, but I'm going to drop that for now because (a)
> > this one is better and (b) it'd be nice to have an ack from a FU740
> > maintainer (Paul or Greentime).
> 
> Yes. I'll fix the comments up and try and get this out later in the
> week. I hope the GPIO patch is easier and can be merged on its own.

Yes, it's in -next now.
