Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009A16006AF
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 08:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJQG0w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 02:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJQG0w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 02:26:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE872E69B;
        Sun, 16 Oct 2022 23:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bMvF5Nhdo+jnm47wBDRGsad0a/S1qc9SVkdHSXSEiAc=; b=RG1DTM3Yne7/F9AIu+aH5R1SaE
        ahv2TsuEeSe6ETKaosVTsnBQD/+ytEtQWC14ffCHOmEcAkK4MYExkuQ/qjKxNUN72/5hyvLI+XlAT
        GTB4RrX6TSkE/UqvetGBgeKBsRCdl9nnVqq/1ELWDk8tFiBvVpPjPcSXJuHIXtk3IIdyELqkXlE8U
        hYVTTodbZwWwgfCaRvInFknnhKlC5b6MsVbpgbOAKBTPZ9Hh2rCWlmYLPZNTsCdcPbXHurGrmGSu+
        Q+kFpMpc3E53HAjF1lFyttOYDy+CMblSOBZfpcvziLwCM2HxVYFBzCo+o0bOyoWdq5vZoDMbT/nee
        aFeyWPYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okJaK-007uUt-7G; Mon, 17 Oct 2022 06:26:48 +0000
Date:   Sun, 16 Oct 2022 23:26:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rui Ma <Rui.Ma@amd.com>
Cc:     helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Alexander.Deucher@amd.com,
        bhelgaas@google.com
Subject: Re: [PATCH] PCI/IOV: Decrease VF memory BAR size to save host memory
 occupied by PTEs
Message-ID: <Y0z1qIG3i3+CZRiX@infradead.org>
References: <20221011112325.992317-1-Rui.Ma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011112325.992317-1-Rui.Ma@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Besides the various style issues:  I don't think we can just
hardcode specific devices in the PCIe core.  If we want to do this
we'll need something like PCIe extended capabilities or ACPI tables
to describe the behavior in a standardized way.
