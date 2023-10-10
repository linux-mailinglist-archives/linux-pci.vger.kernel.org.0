Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D597C0095
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjJJPoe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 11:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjJJPod (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 11:44:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D84B6;
        Tue, 10 Oct 2023 08:44:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F010CC433C7;
        Tue, 10 Oct 2023 15:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696952671;
        bh=Ysfj3tASnZsm0LsPvesZ/F3r/9kf+qCznBqcA1tmt0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teHIhOEADPw4Mu/kF5qYr134rDmns9sAynWZn4m6LlcWTj1XaJBPCvRuk+8Xe4uAO
         F3/DgVQKJ+aQmVBmel5AUlK3C3LWsLae/ATnIt7l3rJLNbhf7otdcOYZITPBWoU55j
         7LCDyqJ03imKInjGjZJayKH+7nvVHX36kB8/tKbXv+tG6aIkCVdDDYBMjofHJT9nfT
         Wf0XY55TllvBBhebpzw8S7mYpBkthznN9e+MmLEXIU/ppT6ACmuC6kGxjDTgmOztwf
         5V8+lzH0U/Vy+Yaf9cifVyjVojkWlkzblK88hTiWcXwmaBcZ7T7eLlvOGvFr+sCrOT
         nDImDWEhQXZyA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     hch@infradead.org, Frank Li <Frank.Li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, bhelgaas@google.com,
        christophe.jaillet@wanadoo.fr, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, robh@kernel.org,
        roy.zang@nxp.com
Subject: Re: [PATCH v3 1/1] PCI: layerscape-ep: set 64-bit DMA mask
Date:   Tue, 10 Oct 2023 17:44:23 +0200
Message-Id: <169695244699.95067.12901655371819245761.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926140445.3855365-1-Frank.Li@nxp.com>
References: <20230926140445.3855365-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 Sep 2023 10:04:45 -0400, Frank Li wrote:
> Set DMA mask and coherent DMA mask to enable 64-bit addressing.
> 
> 

Read this:
https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

Find the issue with the commit log (that I fixed).

This does not apply to v6.6-rc1 so I tweaked it,
check that everything is OK please.

Applied to controller/layerscape, thanks!

[1/1] PCI: layerscape-ep: set 64-bit DMA mask
      https://git.kernel.org/pci/pci/c/81ef01bc5934

Thanks,
Lorenzo
