Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E839B4ECBD8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 20:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349895AbiC3SZG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 14:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350650AbiC3SXX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 14:23:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E73241324
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 11:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40A74B81D51
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 18:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91956C340F0;
        Wed, 30 Mar 2022 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648664451;
        bh=51VHQiL7gyxW17tPC+dmqwWwi6f/KewxGXRjWEhwkZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Huq/NMtyJC01DsVshC+QMLCeyDBM2uWAOU4+VSe+lz26bbk7QEXCYK8edvGriivyD
         HbpLltlCTVxxAiLDce4LIiqGxI3b3X+W5b7gQeIo+oXYngkEyxSeO540SdbS4Z5m/k
         yJyUoxN8U8AylnpE42POooygvjrWkEI0YbqHuBjptwWAsddtZhksu/YkoOoGlOAhxX
         czTmY35xbSSon/nCu33fbCPsIFvX1or/FJUfDrPXUT6ejMsJn7WeMO7T0ybdUx0oX6
         zjPRDN2EPv5nndF08A4px4RDIY8L995EvetD2lB2YZQ1msd4PB+cMCsyuJ7rNeVzu1
         jBzyC7ehzGCLQ==
Date:   Wed, 30 Mar 2022 13:20:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@linux.dev>
Subject: Re: [PATCH v2 1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
Message-ID: <20220330182048.GA1697467@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c964fc-6392-c42a-fd85-7238da07ecfc@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 30, 2022 at 11:06:43AM -0700, Patel, Nirmal wrote:
> On 3/30/2022 10:54 AM, Bjorn Helgaas wrote:
> ...

> > This claims to be a v2, but I missed the v1, and the lore archives [1]
> > seem incomplete.  Maybe the v1 (and maybe the cover letter?) were HTML
> > or got lost for some other reason?
> >
> > Bjorn
> >
> > [1] https://lore.kernel.org/all/?q=f%3Anirmal.patel
> 
> Initially I created one patch [1] and I was advised to create two separate patches.
> 
> [1] https://lore.kernel.org/all/358b0673-f90f-78ca-be66-51d5f76cc42b@linux.intel.com/

The point is that
https://lore.kernel.org/all/358b0673-f90f-78ca-be66-51d5f76cc42b@linux.intel.com/
is a reply to something that didn't make it into the archives.

It says:

  In-Reply-To: <20220223075245.17744-1-nirmal.patel@linux.intel.com>

but 20220223075245.17744-1-nirmal.patel@linux.intel.com is unknown to
lore.

You can't fix this now; I'm just pointing it out in case there's some
problem with the way you're sending patches.

Bjorn
