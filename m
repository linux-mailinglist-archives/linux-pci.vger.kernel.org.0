Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CA96647D6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 18:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjAJR4u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 12:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbjAJR4B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 12:56:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3DE84612
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 09:55:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DE16B818FC
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 17:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D487DC433D2;
        Tue, 10 Jan 2023 17:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673373330;
        bh=T+mZoOtNJWgx0Awh9KhMOV3tHjuU8TCQCS00NAQ7V5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BSVp/MnDHnTlaIdi5NaFd3DAt4mB1YztUBEgTNSfp5fLXtuR97Dz4Qk5JgAETwvIO
         sBOrxzZ7FpYzzD3Uu/maNeEb/qHn6OT3/4vHD5/aSmWaA3VuDpOhpGWLwlqKjfGf2x
         i/qXs2PACKyTa/nK+6RNiR0sz0QKqnludFTv0JElmUiqZWYetIAVvsuBNxeubUj38w
         iXHXqxPrjAN5w4e+qEhg8uUNoFBxz2RzJqCt8PS2oOslgYHm/LFIW8aGhISi9jdhzR
         XnN1TDpTevxEJ3HYjYxD2nfSZ6SEqd929xxqcChCWx6lq2rc2I+x/SpEx7QBd2z0c+
         w9N+Qvh+8Eb5w==
Date:   Tue, 10 Jan 2023 11:55:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com
Subject: Re: [PATCH v9 0/3] virtio: vdpa: new SolidNET DPU driver
Message-ID: <20230110175528.GA1589047@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110165638.123745-1-alvaro.karsz@solid-run.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 06:56:35PM +0200, Alvaro Karsz wrote:
> This series adds a vDPA driver for SolidNET DPU.
> ...

> v9:
> 	- Indent PCI id in pci_ids.h with tabs - Patch 1.
> 	- Wrap patch comment log to fill 75 columns - Patch 1 + 2.

Beautiful, nice threading, thanks! :)
