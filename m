Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639F46C819B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Mar 2023 16:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjCXPmM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Mar 2023 11:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjCXPl7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Mar 2023 11:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E567020040;
        Fri, 24 Mar 2023 08:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D182B62BA9;
        Fri, 24 Mar 2023 15:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9421FC4339B;
        Fri, 24 Mar 2023 15:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679672474;
        bh=CgiIRLzQ+z4tp4z+nOSRuFDvN2xUID42/oyVEAfB++8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kj642AJSwItxShKbJptGDK+dSv/oiyzEeAQ33xojEWlTL9pc3Z3ZkTCF2fjy2LKIr
         DGUT4yhou6f53Ef2knM04diGyG0XGnKQ5qSOOrJCHDdHw6NvTkl36FCAi2LfGa0yXw
         sroOqPSKKLJg4Ey0f1JMnlOx+OfZLL3Hopn+MG82+RjWvdBWvFRxWQwPArhWBZ/kLZ
         kDxPWXklYHknq9fGzxQAZWu43M6OQFm5FaI6O8EBdLyVJlOrqBIpADH+Z3vHhURxnz
         En7HzWhvQ3ntPBNLQAhqJXUc0tgRohzVBNMaMDtCbhKbNxkU2Tl/JZL8Epjt2Em7CP
         vab6OA+Qkjc3g==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-pci@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, bhelgaas@google.com,
        robh@kernel.org, matthias.bgg@gmail.com, kw@linux.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mt7621: Use dev_info for PCIe no card plugged on port trace
Date:   Fri, 24 Mar 2023 16:41:07 +0100
Message-Id: <167967244960.22956.2019560168018857203.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324073733.1596231-1-sergio.paracuellos@gmail.com>
References: <20230324073733.1596231-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 24 Mar 2023 08:37:33 +0100, Sergio Paracuellos wrote:
> When there is no card plugged on PCIe port a trace that says the port will
> be disabled appears. This is expected behaviour but currently is using
> 'dev_err' for doing that. Since this is not an error at all, change the
> trace to use 'dev_info' instead.
> 
> 

Applied to controller/mt7621, thanks!

[1/1] PCI: mt7621: Use dev_info for PCIe no card plugged on port trace
      https://git.kernel.org/pci/pci/c/50233e105a03

Thanks,
Lorenzo
