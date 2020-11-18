Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637342B7B4F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 11:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgKRK34 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 05:29:56 -0500
Received: from foss.arm.com ([217.140.110.172]:50778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbgKRK34 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 05:29:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2DBED6E;
        Wed, 18 Nov 2020 02:29:55 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 431763F719;
        Wed, 18 Nov 2020 02:29:54 -0800 (PST)
Date:   Wed, 18 Nov 2020 10:29:48 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH 0/3] Add support to handle prefetchable memory
Message-ID: <20201118102948.GA27765@e121166-lin.cambridge.arm.com>
References: <20201023195655.11242-1-vidyas@nvidia.com>
 <SLXP216MB04777D651A59246A60D036A8AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
 <20201026123012.GA356750@ulmo>
 <53277a71-13e5-3e7e-7c51-aca367b99d31@nvidia.com>
 <92d5ead4-a3d2-42ba-a542-3e305f3d5523@nvidia.com>
 <20201117121011.GA6050@e121166-lin.cambridge.arm.com>
 <f4d87b99-5a5b-e7de-e72a-18407a875aeb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4d87b99-5a5b-e7de-e72a-18407a875aeb@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17, 2020 at 11:04:57PM +0530, Vidya Sagar wrote:

[...]

> > IIUC we should:
> > 
> > (1) apply https://patchwork.kernel.org/project/linux-pci/patch/20201026181652.418729-1-robh@kernel.org
> > (2) apply [1,2] from this series
> > 
> > For (2), are they rebased against v5.10-rc3 with (1) applied ? I need to
> > check but I will probably have to use v5.10-rc3 as baseline owing to
> > commit:
> > 
> > 9fff3256f93d
> > 
> > (1) depends on it.
> > 
> > Lorenzo
> My patches [1,2] from this series apply cleanly on v5.10-rc3. But with (1)
> applied first, there is a trivial rebase required. Let me know if you want
> me to send the trivial rebased version (of patch-2 particularly).

Please do - I shall apply (1) first (on top of v5.10-rc3).

Lorenzo
