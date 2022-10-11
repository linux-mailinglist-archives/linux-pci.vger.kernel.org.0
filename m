Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB5F5FB8AB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJKQzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 12:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJKQzS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 12:55:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC2222B3;
        Tue, 11 Oct 2022 09:55:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B5BCB81636;
        Tue, 11 Oct 2022 16:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D53C433C1;
        Tue, 11 Oct 2022 16:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665507311;
        bh=XhAZyckRCPAFshg1YwE1cWtM5ptq2V0EJ1cI4a3T4lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eyZNjF9l9nEHnymnGoqS9M5gQlP0iK8MgO7fbz4RABuHtVDGxZaeAJ0L0dO01LqRu
         vDo1//wYKRhP22Saxjkt3NRzR5jVsKcseMrst8wKP0wEtaWg9d3YoHdvQiUMHztYES
         z/RKDsM0gxlNIvesdFrrfsTz6PeOZd0dVReGcceCd39wBORuoPM+dBmfOwi+4eG0Hf
         YFWF4oNC+vTt3Vpv7+dr4K6rM7yxl8DUwOFsfEgWj5BHtndMo3W0ERAJ/VRvq/NMwq
         5cowW8DisOULOy0O0+nE9JlUGOTbijZti0U0VtgeKFf+L9D7YRuCcr86e/6QdcZk1S
         aTCJPtGxFPqfA==
Received: by pali.im (Postfix)
        id 1F1CF7B3; Tue, 11 Oct 2022 18:55:08 +0200 (CEST)
Date:   Tue, 11 Oct 2022 18:55:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro
Message-ID: <20221011165508.ezpwvmzmxywqoj4u@pali>
References: <20220928121911.14994-1-pali@kernel.org>
 <220b0fe7-8b7b-cf9b-e28d-d9d81647fb80@nvidia.com>
 <20221011161638.ycxpg3ox2wv63vym@pali>
 <18a48407-9fd7-175d-0c7f-5702b077f13d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18a48407-9fd7-175d-0c7f-5702b077f13d@nvidia.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 11 October 2022 17:47:50 Jon Hunter wrote:
> On 11/10/2022 17:16, Pali Rohár wrote:
> 
> ...
> 
> > I see, this is stupid mistake. PCIe config read and write operations
> > needs to be 4-byte aligned, so normally it is done by calculating 4-byte
> > aligned base address and then using appropriate cpu load/store
> > instruction to access just defined size/offset of 4-byte config space
> > register.
> > 
> > pci-tegra.c is using common helper functions pci_generic_config_read()
> > and pci_generic_config_write(), which expects final address with offset,
> > and not 4-byte aligned address.
> > 
> > I'm not sure what should be the proper fix, but for me it looks like
> > that pci_generic_config_read() and pci_generic_config_write() could be
> > adjusted to handle it.
> > 
> > In any case, above patch is a regressions and I see there two options
> > for now:
> > 
> > 1) Reverting that patch
> > 
> > 2) Adding "offset |= where & 0x3;" after the PCI_CONF1_EXT_ADDRESS()
> >     macro to set also lower 2 bits of accessed register.
> > 
> > Jon, Lorenzo, what do you think? Could you test if 2) is working fine?
> 
> 
> I tested 'offset |= where & 0xff' which is essentially the same as the above
> and that is working and so I am sure that the above works too. However, I do
> wonder if reverting is simpler because we already have a '&
> ~PCI_CONF1_ENABLE' and now adding '| where & 0x3' seems to diminish the
> value of this change.
> 
> Cheers
> Jon
> 
> -- 
> nvpublic

Well, if decision would be that pci_generic_config_read() could be
modified in the future to handle aligning, then '|= where & 0x3' block
would be moved from driver to generic function...

I'm really not sure which option to choose.
