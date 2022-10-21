Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7364A60808C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJUVI0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 17:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiJUVIZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 17:08:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD282A1D9E;
        Fri, 21 Oct 2022 14:08:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4299DB82D5F;
        Fri, 21 Oct 2022 21:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCAEC433C1;
        Fri, 21 Oct 2022 21:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666386502;
        bh=vGtm8cDaRMwbpuCX+Ll3kMjwJy8sUPoYx9jzNG/dA7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R4lfENKOZxZtb7xmjLqJ0RfIvxmDmHOMOyPV4823rIDTVpQyzqPfVsTkupi+u4Pes
         sPGDOkjtQne929pDHD8Zx9+9yy04AakG4WR7/4evF7JMpfimC2CUBd3+fWF7Y9dnLx
         yskqC5DTwxc8JSkysz1+SAItbtwNSvvVjLTj+uvaYYZzxfu9rdGxToJZmm7YMwRRqd
         MKOKAQUoD3qTUEXqu4ZBs5CKj+bB73a6V1bhaeD/rpGqsOg/sUVCBS9DFnCOW7v7w6
         Qskag7X1mg3sWeIK/XviqzJQA3PtEW76/UlNkjYwrUKDpugWkArd34hRtrBNyJ3+dA
         ObTNZHjqaT69Q==
Date:   Fri, 21 Oct 2022 16:08:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     bhelgaas@google.com, Rajat Jain <rajatja@google.com>,
        Vidya Sagar <vidyas@nvidia.com>, upstream@semihalf.com,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?B?UmFkb3PFgmF3?= Biernacki <rad@semihalf.com>
Subject: Re: [BUG] Intel Apollolake: PCIe bridge "loses" capabilities after
 entering D3Cold state
Message-ID: <20221021210820.GA308037@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFJ_xbq0cxcH-cgpXLU4Mjk30+muWyWm1aUZGK7iG53yaLBaQg@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Radosław]

On Fri, Oct 21, 2022 at 12:17:35PM +0200, Lukasz Majczak wrote:
> Hi,
> 
> This a follow-up from a discussion from “[PATCH V2] PCI/ASPM:
> Save/restore L1SS Capability for suspend/resume”
> (https://lore.kernel.org/lkml/d3228b1f-8d12-bfab-4cba-6d93a6869f20@nvidia.com/t/)
> 
> While working with Vidya’s patch I have noticed that after
> suspend/resume cycle on my Chromebook (Apollolake) PCIe bridge loses
> its capabilities - the missing part is:
> 
> Capabilities: [200 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>   PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
> L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>    T_CommonMode=40us LTR1.2_Threshold=98304ns
> L1SubCtl2: T_PwrOn=60us
> 
> Digging more I’ve found out that entering D3Cold state causes this
> issue (D3Hot seems to work fine).
> 
> With Vidya’s patch (all versions form V1 to V3) on upstream kernels
> 5.10/5.15  it was causing underlying device unavailable (in my case -
> WiFi card) - the V4 (which was accepted and merged) works fine (I
> guess thanks to “PCI/ASPM: Refactor L1 PM Substates Control Register
> programming”) but the issue is still there - I mean now after
> suspend/resume the underlying deceive works fine but mentioned
> capabilities are still gone when using lspci -vvv.
> 
> I think with current code it does no harm to anyone, but just doing a
> heads up about this.

Thanks a lot for following up on this!  Tell me if I have this right:

  - After a fresh boot, the Root Port at 00:14.0 [8086:5ad6] has an L1
    PM Substates Capability [per 1,2].

  - You suspend and resume the system.

  - After resume, 00:14.0 no longer has an L1 PM Substates Capability,
    as in [2].

  - The 00:14.0 Root Port leads to an iwlwifi device at 01:00.0, and
    the wifi device works fine after resume.

  - On the 01:00.0 iwlwifi device, lspci -vv still shows L1.1 and L1.2
    enabled after resume, as it did in [2].

If substates are enabled at iwlwifi but not at the Root Port, that
would not be a valid scenario per spec.  Per PCIe r6.0, sec 5.5.4:

  An L1 PM Substate enable bit must only be Set in the Upstream and
  Downstream Ports on a Link when the corresponding supported
  capability bit is Set by both the Upstream and Downstream Ports on
  that Link, otherwise the behavior is undefined.

So I don't know whether the L1.s states would still actually work.
(Is there any way to tell whether the iwlwifi power consumption
changes after the suspend/resume?  Maybe powertop?)

And ASPM configuration, e.g., disabling/enabling substates via the
sysfs "l1_1_aspm" and "l1_2_aspm" files probably won't work right.

Bjorn

[1] https://lore.kernel.org/lkml/20220722174212.GA1911979@bhelgaas/
[2] https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3
