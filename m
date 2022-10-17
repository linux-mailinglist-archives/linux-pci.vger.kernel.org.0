Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC5B6007E9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJQHnP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 03:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJQHnO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 03:43:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB6049B5A;
        Mon, 17 Oct 2022 00:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 849B560F1B;
        Mon, 17 Oct 2022 07:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7F0C433D6;
        Mon, 17 Oct 2022 07:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665992592;
        bh=LpCHj5POGOs1i1IsuHAhizGhj5VD1XDAFw32FbMt01I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezLG9YjS8kTFVAJ/BtSYQjaFM8nNLbAfs0Iplhc41qUTPPKUidyX/fCclNUHT6Xhl
         hSkkRi8LxYnuzdk/hBiEvQa6i13ZQsFVPqw4MRAglIi87kfeHDqPglPhV3TgJmyoPi
         bqUBEBLP3eKkAyOOHHN6VZB3U/1R0aFDK02bgqIrlmLZ1dOCCfOPaYvLMxgYKlt2nG
         zppyoMAHGwalESvFSi+HRYSNonoShCJBQXD0YiSiNVtsbCOED8sbBtVOMP6koUKJKV
         vqRkMfwXlqpu7LURBe7/hYYmwY/uTDsGOgjW16XpPD1lrFxsQAhJnLqpIdzg6EXeOb
         NYPrvlCn5RHaw==
Date:   Mon, 17 Oct 2022 09:43:05 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro
Message-ID: <Y00HiWT+N6Fo9KVD@lpieralisi>
References: <20220928121911.14994-1-pali@kernel.org>
 <220b0fe7-8b7b-cf9b-e28d-d9d81647fb80@nvidia.com>
 <20221011161638.ycxpg3ox2wv63vym@pali>
 <18a48407-9fd7-175d-0c7f-5702b077f13d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18a48407-9fd7-175d-0c7f-5702b077f13d@nvidia.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 11, 2022 at 05:47:50PM +0100, Jon Hunter wrote:
> 
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

Hi Jon,

it is unfortunate but I think we should proceed with a revert, please
send it and I shall ask Bjorn to send it for one of the upcoming -rcX.

Thanks,
Lorenzo
