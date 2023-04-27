Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE70C6F0B71
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbjD0Rws (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 13:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbjD0Rws (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 13:52:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6688B35BD;
        Thu, 27 Apr 2023 10:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC54B63EDC;
        Thu, 27 Apr 2023 17:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7CDC433EF;
        Thu, 27 Apr 2023 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682617966;
        bh=xkU2AxBp2cbLfWG1K4LLB2Ca1SteiY+51uE8jz1bWrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kKcDZn/T+nclBpGkLojCKhUXmmsC1cLCya0LHePqG3NifX0AER6TEP4W0p4XXljMB
         mpIyNM/P9rgu63Hnp+rdVLv2HhWGRGSqdQICFSgeFRy/3jstP09jFDiIbdkKz+LyIG
         zyWjnXdq6Csu1oXhTM/8kd3dxLeAr6bP1xBjZgc6MDzsVAv0MoGCyRJbpCVE62JKrN
         6mXyx5UN84bPPXmqeHtsInENRxLJePawXrkjBLojzPVJGv0z5tVa83xt9mx23Ax/6S
         thPo4fiOlWzrdjXlItb+A8Pfh/zbaCoDEY56z8LqCAu3XhdBASlyfgHjXnOVF1yb1s
         ya3JEpBPvzoXA==
Date:   Thu, 27 Apr 2023 12:52:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Ren Zhijie <renzhijie2@huawei.com>,
        Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH v2 0/3] Introduce a PCIe endpoint virtio console
Message-ID: <20230427175244.GA261197@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427104428.862643-1-mie@igel.co.jp>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 27, 2023 at 07:44:25PM +0900, Shunsuke Mie wrote:
> ...
>   PCI: endpoint: introduce a helper to implement pci ep virtio function
>   virtio_pci: add a definition of queue flag in ISR
>   PCI: endpoint: Add EP function driver to provide virtio-console
>     functionality

Capitalize the first word consistently to match history ("Introduce",
"Add").

Capitalize "PCI" in English text.

Capitalize "EP" since it's sort of an acronym (you did once, but do it
both places :))

Bjorn
