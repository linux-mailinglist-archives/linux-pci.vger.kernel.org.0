Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF4604F9C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJSSaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 14:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJSSaM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 14:30:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686D61162E1
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2022 11:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4FE961985
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2022 18:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4A5C433C1;
        Wed, 19 Oct 2022 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666204208;
        bh=AjO2Pxm5zSTuoN6VcriVQBrTibpZErHrDtjcJODKIL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KW7ddf+woiyIrvEN9i6zxOzCNrurigYsrUpuMUsiH567CwIvSmrPF+iR61A1Q3RLU
         PAfCaBoJYZG7IqVflr6WDfa2aasJ7auFXU7m2IpYUA3XVIWhz6QQz5EeFh1unKEGFZ
         Ss7r+bq7b90WD1RXxT3/RtrOdSD5ql5MXDbFay720om8S5rGjG8cST2m5mOabtAxVO
         HHFAff5x7XsAnoq1Cxu4soctbWCoXeRFtR26EWcL94q0Qb/zkTNQcoTkF4KZVRXxL3
         IG7eLIUT1tUY1OuGpc0jecm7GI5YcX7TlS5uymZpIr9nCpHtBQTmkI2bXIEx3/9dOx
         nT2XNwJ8aJZcA==
Date:   Wed, 19 Oct 2022 12:30:04 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI: Align MPS to upstream bridge for SAFE and
 PERFORMANCE mode
Message-ID: <Y1BCLA4Zi+QJcWRl@kbusch-mbp.dhcp.thefacebook.com>
References: <20220610150131.6256-1-Zhiqiang.Hou@nxp.com>
 <20221019182559.yjnd2z6lhbvptwr3@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019182559.yjnd2z6lhbvptwr3@sequoia>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 01:25:59PM -0500, Tyler Hicks wrote:
> On 2022-06-10 23:01:31, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > 
> > The commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge")
> 
> Adding Keith, as the author of that commit.
> 
> > made the device's MPS matches upstream bridge for PCIE_BUS_DEFAULT
> > mode, so that it's more likely that a hot-added device will work in
> > a system with an optimized MPS configuration.
> > 
> > Obviously, the Linux itself optimizes the MPS settings in the
> > PCIE_BUS_SAFE and PCIE_BUS_PERFORMANCE mode, so let's do this also
> > for these modes.
> > 
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> 
> I wanted to give a little more information about the issue we're seeing.
> We're having trouble retaining the optimized Max Payload Size (MPS)
> value of a PCIe endpoint after hotplug/rescan. In this case,
> `pcie_ports=native` and `pci=pcie_bus_safe` are set on the cmdline and
> we expect the Linux kernel to retain the MPS value. Commit 27d868b5e6cf
> preserved the MPS value when using the default PCIe bus mode
> (PCIE_BUS_DEFAULT) and we're hopeful that this can be extended to other
> modes, as well.

As I recall, the PCIE_BUS_DEFAULT mode was created specifically because
we didn't want to change the behavior of PCIE_BUS_SAFE. What reason do
you have for using that mode, anyway? That's specifically saying not to
retune bridges after the initial scan.
