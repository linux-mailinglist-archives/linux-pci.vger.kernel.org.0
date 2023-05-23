Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ADE70D40F
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 08:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjEWGhJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 02:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEWGhJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 02:37:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3E9100
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2023 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gDUysVOVsaPyDTtVUoUqBYPUK0ngxjXHLWGMN3f8LyM=; b=QgrDA6u1rZ2kjiqWSMp4YbdVpj
        MpQQDF+cfg7KqyZ9UzFSPXIy3mvdkvGifqxVUelJnF4KwqqrExYj+ZUHtCy6/W22Er5drPNyhHOzH
        KtX0etTH7nf9KpQT6GRhuT/Lq7AUu5cdpezTVkYhQbfvrEG59bINTLE3OVVmqG1DlPepiwKonGpLL
        1Cv0Vyy42SXPaMGFLoPR8SF9GiQuhlZfbN2NbE+QfWmdYmTpFTBejV3d/OtYZdZ4tPDRkQwBRd1Hb
        oacVKKQ1h7FJV5Azmo0y3vCFrZNcml/9V+3ihXYoCZuMMpVWBWlYzsiFdyO8F7PeY4sOIKktC/GH+
        aIYcQFlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Ldq-0095i5-05;
        Tue, 23 May 2023 06:37:06 +0000
Date:   Mon, 22 May 2023 23:37:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiwu Zhang <shiwu.zhang@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH] drm/amdgpu: add the accelerator pcie class
Message-ID: <ZGxfEklioAu6orvo@infradead.org>
References: <20230523040232.21756-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523040232.21756-1-shiwu.zhang@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 23, 2023 at 12:02:32PM +0800, Shiwu Zhang wrote:
> +	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
> +	  .class = PCI_CLASS_ACCELERATOR_PROCESSING << 8,
> +	  .class_mask = 0xffffff,
> +	  .driver_data = CHIP_IP_DISCOVERY },

Probing for every single device of a given class for a single vendor
to a driver is just fundamentaly wrong.  Please list the actual IDs
that the driver can handle.

