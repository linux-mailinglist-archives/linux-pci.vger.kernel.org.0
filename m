Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A016863C8CD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 20:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbiK2TxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 14:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbiK2TxB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 14:53:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D4817E38;
        Tue, 29 Nov 2022 11:53:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43650618CF;
        Tue, 29 Nov 2022 19:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F50C4347C;
        Tue, 29 Nov 2022 19:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669751579;
        bh=OcROACIvrb3LiNJuXbTdCona28iOYGS64nqNq44dgWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZDG9rV6PHI0J1/ftJBGz7DpzeSMkRNt9WynhIHksSsK35T9UZJh3KbEoav9XcaQ2
         kFkcItn1ZfL48NR6Pv4PEBiZqbgb7IACsQ3llg2IMLvaMkZTTl1xZUc3vgtXSq+aVF
         F6sMmoQmV6zk75pmuHhM5tAVqJmc2wud1jUM+E9ClLAeqVFNg3t+kN6ENucNV/yOsn
         9umvOZYOPRk4belQh/b6d7BHnCoiWfeUgHdpaGex2P7EaUN4zMpXvxmtUDvLyluKYz
         8R7kQIU31rVWaqE71TR+oxLHXFZEzw4lCD62Ktjifao0U3Er4Z4x0ZM8xi/6J7uChV
         2Bg3TGdbbF3Ag==
From:   Will Deacon <will@kernel.org>
To:     jonathan.cameron@huawei.com,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jonathan Corbet <corbet@lwn.net>, liuqi6124@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Yicong Yang <yangyicong@huawei.com>, bagasdotme@gmail.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        prime.zeng@huawei.com, f.fangjian@huawei.com,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        shenyang39@huawei.com
Subject: Re: [PATCH v3 0/4] Add TLP filter support and some fixes for HiSilicon PCIe PMU
Date:   Tue, 29 Nov 2022 19:52:46 +0000
Message-Id: <166973225546.3127880.2609206485650719654.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221117084136.53572-1-yangyicong@huawei.com>
References: <20221117084136.53572-1-yangyicong@huawei.com>
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

On Thu, 17 Nov 2022 16:41:32 +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> HiSilicon PCIe PMU support count the bandwidth of TLP headers, TLP payloads
> or both. Add support for it. User can set this through perf tool's
> 'len_mode' like:
> 
>   $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=0x1/ sleep 5
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/4] drivers/perf: hisi: Fix some event id for hisi-pcie-pmu
      https://git.kernel.org/will/c/6b4bb4f38dbf
[2/4] docs: perf: Fix PMU instance name of hisi-pcie-pmu
      https://git.kernel.org/will/c/eb79f12b4c41
[3/4] Documentation: perf: Indent filter options list of hisi-pcie-pmu
      https://git.kernel.org/will/c/c8dff677e6d4
[4/4] drivers/perf: hisi: Add TLP filter support
      https://git.kernel.org/will/c/17d573984d4d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
