Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7173864C10A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 01:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbiLNAKL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 19:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbiLNAJq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 19:09:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F2D27CD7
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 16:08:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF5D8B8161C
        for <linux-pci@vger.kernel.org>; Wed, 14 Dec 2022 00:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60887C433D2;
        Wed, 14 Dec 2022 00:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670976530;
        bh=S5xdl8ZAfBCjV+HN2e2hpCPrLm6Lu9QedLOb1rL+608=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UopKoRFgJuHFK+tGqklcCxgcH9FfQ6FX/O/Tm9yp3KhM8kuhfKY68lREeyQ+vXbmc
         1LUNcaiw68zujyZZVVujiPz7BAEZ+mhCAd7RXWeZklLJREjzQF8zbDLt7mwoBeWsgx
         sRsVuOiXCVaznw8NH1DJ2NkpvYME2MMp0WNCTFX1AMAN7N0g0Zgs+xSuSV28HKNKVQ
         rzlvT6/Tg5rmrAn8yaLs9COh/DsG9maPGaU1eHr4Er2bo7hIJ+PS0CVNZpXbTbNjRq
         aR2mHPjr7xTOKRo5NkVFwsUQBWISLfyY9xmuoSsaCFyKXi4bbFztWUUInttQkjFrt/
         uWM+FNtODYSfg==
Date:   Tue, 13 Dec 2022 18:08:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     kishon@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lznuaa@gmail.com, hongxing.zhu@nxp.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com,
        linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI: endpoint: Support NTB transfer between RC
 and EP
Message-ID: <20221214000848.GA221546@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222162355.32369-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 10:23:54AM -0600, Frank Li wrote:

> + * +--------------------------------------------------+ Base
> + * |                                                  |
> + * |                                                  |
> + * |                                                  |
> + * |          Common Control Register                 |
> + * |                                                  |
> + * |                                                  |
> + * |                                                  |
> + * +-----------------------+--------------------------+ Base+span_offset
> + * |                       |                          |
> + * |    Peer Span Space    |    Span Space            |
> + * |                       |                          |
> + * |                       |                          |
> + * +-----------------------+--------------------------+ Base+span_offset
> + * |                       |                          |     +span_count * 4
> + * |                       |                          |
> + * |     Span Space        |   Peer Span Space        |
> + * |                       |                          |
> + * +-----------------------+--------------------------+

Are these comments supposed to say *spad*, i.e., scratchpad space,
instead of "span", to correspond with spad_offset and spad_count
below?

> +struct epf_ntb_ctrl {
> +	u32     command;
> +	u32     argument;
> +	u16     command_status;
> +	u16     link_status;
> +	u32     topology;
> +	u64     addr;
> +	u64     size;
> +	u32     num_mws;
> +	u32	reserved;
> +	u32     spad_offset;
> +	u32     spad_count;
> +	u32	db_entry_size;
> +	u32     db_data[MAX_DB_COUNT];
> +	u32     db_offset[MAX_DB_COUNT];
> +} __packed;
