Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56B961D882
	for <lists+linux-pci@lfdr.de>; Sat,  5 Nov 2022 08:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKEHbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Nov 2022 03:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEHbk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Nov 2022 03:31:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5190063F3;
        Sat,  5 Nov 2022 00:31:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CED9B80E8E;
        Sat,  5 Nov 2022 07:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40265C433D6;
        Sat,  5 Nov 2022 07:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667633496;
        bh=+e82QwnlQfSIsUJDjMJySUyMNXUabk+lGetzUjH2/bU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLkEs9ppKFjVxwCh1LIIULE/4g2VkqNadV5dzy3Kw2FC+Tj6CycZpmvRuCD2gvgTd
         PAYFatyZ1ip/KXUsA5P6ngc81eJVbDp947/4OcuG6PhfY+NlqK3Xpr/FEsyXaWUX2p
         asUNDQBqhSrC3d8zunfsfRsXUB8UHVW6spxJ0qESjcg8WFOPalHT6uTkMxNLXmY+5J
         J2JtVatseguai4EmOh2ja+PpJYL2AV/NlbCAIKVIeIyQZ32fVF7xBXd/614/tYTn+e
         YUzAfEmBq7c3wlnLSwqqrSzGBut8OM9mU9RwVwr2iveXBpFPl3QxNZsdCgoDfNPdeF
         rs9SfSESxoRIQ==
Date:   Sat, 5 Nov 2022 13:01:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     John Thomson <git@johnthomson.fastmail.com.au>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] phy: ralink: mt7621-pci: add sentinel to quirks table
Message-ID: <Y2YRVBMqtSVDum8l@matsya>
References: <20221104205242.3440388-1-git@johnthomson.fastmail.com.au>
 <20221104205242.3440388-2-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104205242.3440388-2-git@johnthomson.fastmail.com.au>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05-11-22, 06:52, John Thomson wrote:
> With mt7621 soc_dev_attr fixed to register the soc as a device,
> kernel will experience an oops in soc_device_match_attr
> 
> This quirk test was introduced in the staging driver in
> commit 9445ccb3714c ("staging: mt7621-pci-phy: add quirks for 'E2'
> revision using 'soc_device_attribute'"). The staging driver was removed,
> and later re-added in commit d87da32372a0 ("phy: ralink: Add PHY driver
> for MT7621 PCIe PHY") for kernel 5.11

Applied, thanks

-- 
~Vinod
