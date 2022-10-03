Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97565F3545
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 20:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJCSKH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 14:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJCSKE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 14:10:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8471209E;
        Mon,  3 Oct 2022 11:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87825B81203;
        Mon,  3 Oct 2022 18:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD545C433D6;
        Mon,  3 Oct 2022 18:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664820596;
        bh=ANqFI6xslOGdcFDVAOiICDsxXBMTCaKi13Ycp8pVIR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KPHRzHlWh1OPUagG4uwrYFJlVJRRNFCam8EqLQCMYmXat2XL0n5epL0Z7L4NJu0iI
         n32bD1rCeEqJ7ipwWNDJojRYW+NdpqCbvD2jjHaJO3e5bz8XtlsDYhrqLGOh2vZ0QQ
         If/q3ezlan3MHHGsWQnEK+xAqbI0STq9CrWerzRI9U986HYrCU3aVRZg2AI5HKCArO
         1EM0nQBRUp8VQZodOmWDn/gfeuqBRc2v4Amr0Lm/8xb+hWlppeD10CvHuW2L4DKEWz
         Ng1hr9DbIKH+53tfitlwZZ2oZT1T1zOlO8Hq1NjPIVQcXkCV8gGSfoXPmwNLfWXtKF
         a7ozlM0JggbYA==
Date:   Mon, 3 Oct 2022 13:09:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, jszhang@kernel.org,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH V1 0/4] GPIO based PCIe Hot-Plug support
Message-ID: <20221003180949.GA2104321@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a465222-342a-418b-95af-9948f6ce9065@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 01, 2022 at 05:50:07PM -0600, Jonathan Derrick wrote:
> On 10/1/2022 10:20 AM, Pali Rohár wrote:
> ...

> > Would not it better to rather synthesise PCIe Slot Capabilities support
> > in your PCIe Root Port device (e.g. via pci-bridge-emul.c) and then let
> > existing PCI hotplug code to take care for hotplugging? Because it
> > already implements all required stuff for re-scanning, registering and
> > unregistering PCIe devices for Root Ports with Slot Capabilities. And I
> > think that there is no need to have just another (GPIO based)
> > implementation of PCI hotplug.
>
> I did that a few years ago (rejected), but can attest to the robustness of
> the pcie hotplug code on non-hotplug slots.
> https://lwn.net/Articles/811988/

I think the thread is here:
https://lore.kernel.org/linux-pci/1581120007-5280-1-git-send-email-jonathan.derrick@intel.com/
and I'm sorry that my response came across as "rejected".  I intended
it as "this is good ideas and good work and we should keep going".

Bjorn
