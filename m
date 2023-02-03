Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0722A6893BA
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 10:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjBCJaC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 04:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjBCJ34 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 04:29:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EAF448D;
        Fri,  3 Feb 2023 01:29:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13D91B829EB;
        Fri,  3 Feb 2023 09:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0199C433EF;
        Fri,  3 Feb 2023 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675416592;
        bh=+3+dPyZN6Z64S5pQlIbDDr9Ty7nBf/sU7HaKFhHB+bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1HyoA1qOdxEdIHZXFVdj1LkUEiuTqNdpUG6O4ocPh0WzaV/BK2NXkD5UW8Zzcrt6
         LVHAcusXEPcNxbLuEE9h4Cg5KMtBE1Cgjbv7clnSB2BJJZcf+FCtJ8aQdxScwdKpk7
         MzWQcQJDCPmCFscbzrJyxFmoIlt8eq1rjVQUT86y2TAJj3W+YVC367g1rJ7CFOg08n
         CotMqKsMsZAq/XO1TahBUfRbkJlLzNqoAQLGCP+xa+rMd32se/RndBk5kX8kyRA5IF
         2x19WEHFmSZsAIbFn3kS/KNARpu6kqFbMjNe40fS6123YovueX8dJyvnYMSpHIJmXF
         jWJQi6MsEMMGg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-pci@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, bhelgaas@google.com,
        kw@linux.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        matthias.bgg@gmail.com
Subject: Re: [PATCH v2] PCI: mt7621: Sleep a bit after power on the PCIs phy ports
Date:   Fri,  3 Feb 2023 10:29:45 +0100
Message-Id: <167541647472.1154578.14891717976450626734.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20221231074041.264738-1-sergio.paracuellos@gmail.com>
References: <20221231074041.264738-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 31 Dec 2022 08:40:41 +0100, Sergio Paracuellos wrote:
> Some devices like ZBT WE1326 and ZBT WF3526-P and some Netgear models need
> to sleep a bit after call to mt7621_pcie_init_port() driver function to get
> into reliable boots for both warm and hard resets. The needed time for these
> devices to always detect the ports seems to be from 75 to 100 milliseconds.
> There is no datasheet or something similar to really understand why this
> extra time is needed in these devices but not in most of the boards which
> use mt7621 SoC. This issue has been reported by openWRT community and the
> complete discussion is in [0]. The selected time of 100 milliseconds has
> been also tested in these devices ending up in an always working platform.
> Hence, properly add the extra 100 milliseconds msleep() function call to make
> also these devices work.
> 
> [...]

Applied to pci/controller/mt7621, thanks!

[1/1] PCI: mt7621: Sleep a bit after power on the PCIs phy ports
      https://git.kernel.org/pci/pci/c/0cb2a8f3456f

Thanks,
Lorenzo
