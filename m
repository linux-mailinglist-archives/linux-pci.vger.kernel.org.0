Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFE0673B98
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 15:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjASOWy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 09:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjASOWp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 09:22:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271A375A30;
        Thu, 19 Jan 2023 06:22:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B437A6170E;
        Thu, 19 Jan 2023 14:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F0BC433EF;
        Thu, 19 Jan 2023 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674138160;
        bh=mDh1LDHRJOGkqTlnK3QxHsjTBRyPM7cJRW+pfnInBI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IyxHAJF9pl/t/6vUxnb085JR8Fse9frezRoj62Ci+GTte2karxrFQjXRCGnI2n5QB
         cfRl/Wylx74MNTHCVcwBKeudh25jvj5I6Cw+bBUOtxER6LCNKhshzmu603O/Y10cSG
         cxjaeRvjs5woG6NCYfNUnPwVXmERdpUxdQQt1/DAoKX1tRF+FNQSNOl4l6R4ImBkMU
         p+nO/iSozt4VVbEe5QfHRWCBhwrfgNIGfUvk4DSsA6wwb7t+3tLwol1YQec/VVA3dH
         RSwzr05WSYF6Ab3JCjGAOtsQtdmI8PGUvZMyXOwXjzJ2wpOdxHwNGJGsbNckwLhn18
         zSU5OCLO7LqUg==
Date:   Thu, 19 Jan 2023 14:22:30 +0000
From:   Lee Jones <lee@kernel.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, lukas@wunner.de, kabel@kernel.org,
        mani@kernel.org, pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        gregkh@linuxfoundation.org, matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v1 11/12] fpga: m10bmc-sec: add m10bmc_sec_retimer_load
 callback
Message-ID: <Y8lSJsuLQ9DyXZ4U@google.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
 <20230119013602.607466-12-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119013602.607466-12-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 18 Jan 2023, Tianfei Zhang wrote:

> Create m10bmc_sec_retimer_load() callback function to provide
> a trigger to update a new retimer (Intel C827 Ethernet
> transceiver) firmware on Intel PAC N3000 Card.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 136 ++++++++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h       |  31 ++++++

Looks mostly fine - no need to send this to me again, thanks:

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
