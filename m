Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43754756535
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 15:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjGQNjX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 09:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjGQNjW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 09:39:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7668F;
        Mon, 17 Jul 2023 06:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D47661074;
        Mon, 17 Jul 2023 13:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60506C433CA;
        Mon, 17 Jul 2023 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689601160;
        bh=JhtExtpwcPs3DxfwEaqMV3K5TXPPLv9dLOoieoSvxvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=moSB2eBTRpkbZwMwx1IrLVoxXyRXUJlwnXMATxcfF5UNvsEr+aPOWjX6PM+hpvXlV
         tUodaRaaG7fr095r9igvNANB6S4unuUipNCM5T96exHjt3NY61Rd2yKkngHqIW922t
         ly5cVz+NccAR+oe6QgvwZsg5LsL4sxFXwnSEYzvw=
Date:   Mon, 17 Jul 2023 15:39:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh@kernel.org, mani@kernel.org, lpieralisi@kernel.org,
        bhelgaas@google.com, kw@linux.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V4] PCI: qcom: Fixing broken pcie bring up for 2_3_3
 configs ops
Message-ID: <2023071729-shamrock-evidence-b698@gregkh>
References: <20230717065535.2065582-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717065535.2065582-1-quic_srichara@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 17, 2023 at 12:25:35PM +0530, Sricharan Ramabadhran wrote:
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for IPQ8074
> 2_3_3 post_init ops. PCIe slave addr size was initially set
> to 0x358, but was wrongly changed to 0x168 as a part of
> commit 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from
> register definitions"). Fixing it, by using the right macro
> PARF_SLV_ADDR_SPACE_SIZE and remove the unused
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3.

Note, you do have a full 72 columns to use, no need to make it smaller.

> Without this pcie bring up on IPQ8074 is broken now.

I do not understand, something that used to work now breaks, or this is
preventing a new chip from being "brought up"?

thanks,

greg k-h
