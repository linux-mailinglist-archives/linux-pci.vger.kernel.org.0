Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5759890A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 18:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbiHRQiD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 12:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244557AbiHRQiB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 12:38:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C908BD1FE;
        Thu, 18 Aug 2022 09:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE01D615E6;
        Thu, 18 Aug 2022 16:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2553C433C1;
        Thu, 18 Aug 2022 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660840680;
        bh=VW8K1mvPZ7SyPQLEyZKedWfXCdz3ufIQB1jTJflM0Qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U2S9UobrcB5GYkBgLGRacrpNp5tPyIHF9asfLL+g1hAEqvD+vbFK5UsHaoBN6qaBw
         P3VISmCIi4seWDg+ACUG7tWs4dEACj6yzRuco9XCPT4U1xdKBP0npdSyumuq4y7PNG
         1U9EX7wXu5jeydv7ind2ova39+xGBMT0VCRfkKOxwExe4OJBgXLcrqLUaEihSZe4Ft
         WZEgHjbuG/SngIga+tBHLXCGcI7PcNx7JNDrWiOS7XMhJ1ClktiAeBcUbisGLcgQwl
         D9C6/vcptywUyzqCZ+c0VBQ2NkzeyftJ3FoYuBonDJ99L1L/30PFKze/kKUeFNmv4R
         PFEAXfG9mqMOQ==
Received: by pali.im (Postfix)
        id 00D04622; Thu, 18 Aug 2022 18:37:56 +0200 (CEST)
Date:   Thu, 18 Aug 2022 18:37:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
Message-ID: <20220818163756.qmyopspdn5xywe5s@pali>
References: <20220702204737.7719-1-pali@kernel.org>
 <20220714184130.5436-1-pali@kernel.org>
 <20220818135009.zlivavgw6547hh4s@pali>
 <Yv5T1dcIIOPy3KvB@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yv5T1dcIIOPy3KvB@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 18 August 2022 16:59:33 Andrew Lunn wrote:
> On Thu, Aug 18, 2022 at 03:50:09PM +0200, Pali Rohár wrote:
> > PING?
> 
> Pretty much anything sent during the merge window, and just before the
> merge window gets thrown away. Please rebase onto the current pci tree
> and repost.
> 
>     Andrew
>  

Please write it pretty clear that you are not interested in those
patches, and not hiding this info behind asking me after month of
waiting for another work of rebase with sending them at eight o'clock
during full moon. It is pretty ridiculous how to say "go away". Thanks.
