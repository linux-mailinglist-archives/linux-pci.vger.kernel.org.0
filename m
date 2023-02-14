Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E60696DCE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 20:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBNTZ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 14:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBNTZZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 14:25:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5101C5B3;
        Tue, 14 Feb 2023 11:25:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26D8361892;
        Tue, 14 Feb 2023 19:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44639C433EF;
        Tue, 14 Feb 2023 19:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676402723;
        bh=9ZMjMBNpDQvO06G0fs755Z9hNiyQHDgs1Wcu4/Kltm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Lu0EoP318VYWy6qiw++sYu5HjCu9taQ+GqikLuC/IzStwjMZ6hdWwBaCCsftLYUl9
         u/Pd9PekILl087C/+9vCbce6oC4ldegiinVP8hNmbKJ4n7kVT3CicnHqACMbDzcTah
         CmZc16UvhEh92jkDyK7xvyavRnOt6ebaLTv3JanXuHSpwp1rdpr3f31TKBO0Gtjehv
         iI5XOMlgKWpc/SAItxNXkLFh1hPQiER5KNKeHnbFn2etKf2t6i9Uk2jr6DIzkYZuNS
         W+MBe/SfxxQUP9sBnAdD6hi+fxlED2ZNDa798WrBlVAzdr01/Lo1/pB00EpnCcxiN4
         sRS0uxInXXZAg==
Date:   Tue, 14 Feb 2023 13:25:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: (subset) [PATCH 1/4] dt-bindings: PCI: qcom: add MSM8998
 specific compatible
Message-ID: <20230214192521.GA3049353@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e02f098-c3b6-1a0b-68b4-d5e2b8cb6045@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 14, 2023 at 10:29:17AM +0100, Krzysztof Kozlowski wrote:
> On 30/12/2022 12:08, Lorenzo Pieralisi wrote:
> > On Tue, 15 Nov 2022 13:53:07 +0100, Krzysztof Kozlowski wrote:
> >> Add new compatible for MSM8998 (compatible with MSM8996) to allow
> >> further customizing if needed and to accurately describe the hardware.
> > 
> > Applied to pci/dt, thanks!
> > 
> > [1/4] dt-bindings: PCI: qcom: add MSM8998 specific compatible
> >       https://git.kernel.org/lpieralisi/pci/c/c427f45c1e99
> 
> Hi Lorenzo and Bjorn,
> 
> This commit was applied with a change:
> [bhelgaas: sort msm8996 before msm8998]
> 
> This is a list ("items"), thus the order is important. Reversing order
> broke it.

Sorry, I blew it.  It should be fixed now.

Bjorn
