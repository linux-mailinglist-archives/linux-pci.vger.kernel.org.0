Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26869485718
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 18:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242163AbiAERLw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 12:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242157AbiAERLt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 12:11:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58805C061245;
        Wed,  5 Jan 2022 09:11:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15528B81CBD;
        Wed,  5 Jan 2022 17:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9981EC36AE3;
        Wed,  5 Jan 2022 17:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641402706;
        bh=XelkwW5OUqz8/dQEcGWcTKmadHuQZJIhT1SZ0Bvd8wE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UG55RpahQrFNvsc5WgBdOwEkmpMynavXkOZzFrNQgNjSY2lWMkYFKCCnXud/dvgSQ
         p2Q2xvWQbr9wCzQnzEHu+BmDCQKvEJ+djqRZw+zj2v6SdPJXF5YJckZzFmS1UVfTDM
         sa3BShayjCpmEU3+Fg6Mf4SQKbj8tgMrTDM6Qf5YyuQqkzvddq0kn/csC2oQPmtpFs
         Enq1rd44uUq/2k71PkpyKUGWVJr6r0nZArFHDHmxn722nlI1iBcgmq1ka9CTZwHVl3
         SAlVY2Lblx+sIsDw8+a60/CFmGHPPhgCUFJquZRVD3dyeWLodNJQAuJ/V6S4f8NR2g
         YgkOKhdRFNLwA==
Date:   Wed, 5 Jan 2022 18:11:40 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add
 'slot-power-limit-milliwatt' PCIe port property
Message-ID: <20220105181140.220428aa@thinkpad>
In-Reply-To: <CAL_JsqL0mfRb7k4V-wjyGgjpB3pu88yPNT38k8zs-HoiVYaekQ@mail.gmail.com>
References: <20211031150706.27873-1-kabel@kernel.org>
        <YY6HYM4T+A+tm85P@robh.at.kernel.org>
        <20220105151444.7b0b216e@thinkpad>
        <CAL_Jsq+HjnDfDb+V6dctNZy78Lbz92ULGzCvkTWwSyop_BKFtA@mail.gmail.com>
        <20220105151410.wm5ti6kbjmvm5dwf@pali>
        <CAL_JsqL0mfRb7k4V-wjyGgjpB3pu88yPNT38k8zs-HoiVYaekQ@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 5 Jan 2022 09:26:22 -0600
Rob Herring <robh@kernel.org> wrote:

> The only issue I see is the property would be allowed in host bridge
> nodes rather than only root port or PCIe-PCIe bridge nodes because the
> current file is a mixture of all of those. I think a note that the
> property is not valid in host bridge nodes would be sufficient. It's
> still better than documenting in pci.txt.
> 
> Rob

Created PR
  https://github.com/devicetree-org/dt-schema/pull/66

Marek
