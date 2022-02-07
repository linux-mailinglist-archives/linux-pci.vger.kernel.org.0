Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B434AC46E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 16:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344322AbiBGPy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 10:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377047AbiBGPr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 10:47:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFA1C0401CF;
        Mon,  7 Feb 2022 07:47:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9DE9614A4;
        Mon,  7 Feb 2022 15:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A471C004E1;
        Mon,  7 Feb 2022 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644248877;
        bh=r3O5vPOqEXIGQuLUP/3+nhxeyLn9O0QAOBfSkctOgR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEQXxdTh6uyA7VHExtd5pSL8vwEeVmr2yXDo4YCD/O/BGKy5TyzOYDwZkQfoaeptN
         OXC9y8u0qa6Tj9Q3Nx3f1XxLLIAJr8KOOSxDatiPLP/hPfixFniSUUrjdOV0sUfQLh
         Qc1rEuLqWeSBG1CzNfHwSFfjktBSAZ7tpn/uJ0Vhcd5zeC2MCeU9CfZfhYlxZLsw+o
         d+fSS4B5w+8dBNcq36blfrP2u7bxCzqE6l/3oxtksKBlbqBq0S4uAXEJm4jbZzJWt1
         d+Dq8jYz0i1AOjPMKxvY38jDrSJt30+Ix4gXr/XtoR6WUXZGLrugBLRtC/leUHKDsd
         itYhwXDgcMNpg==
Date:   Mon, 7 Feb 2022 07:47:54 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     nitirawa@codeaurora.org
Cc:     Vidya Sagar <vidyas@nvidia.com>, rafael.j.wysocki@intel.com,
        hch@lst.de, bhelgaas@google.com, mmaddireddy@nvidia.com,
        kthota@nvidia.com, sagar.tv@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Query related to shutting down NVMe during system suspend
Message-ID: <20220207154754.GA635727@dhcp-10-100-145-180.wdc.com>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
 <20220201163054.GA2838889@dhcp-10-100-145-180.wdc.com>
 <0bd9fdc1-99d4-1c59-7343-3708b331b2b5@nvidia.com>
 <24710253b2e34dfdd81ebe1f46b84652@codeaurora.org>
 <cc0b6768-5722-2277-6e51-75baf3311dc5@nvidia.com>
 <c2255367927729ee00c42ae4148c1301@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2255367927729ee00c42ae4148c1301@codeaurora.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 07, 2022 at 09:14:49PM +0530, nitirawa@codeaurora.org wrote:
> Thanks Vidya for pointing out the patch . This patch worked for us as well.
> @keith - Please can we get this merged .

I'm working on it, but I don't think the proposed patch was acceptable.
I'm going to look at another option today.
