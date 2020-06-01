Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4CA1EA07F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 11:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgFAJFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 05:05:48 -0400
Received: from foss.arm.com ([217.140.110.172]:35120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFAJFr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jun 2020 05:05:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B9321FB;
        Mon,  1 Jun 2020 02:05:47 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0398E3F305;
        Mon,  1 Jun 2020 02:05:45 -0700 (PDT)
Date:   Mon, 1 Jun 2020 10:05:36 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] PCI: tegra: Fix runtime PM imbalance on error
Message-ID: <20200601090536.GA4226@e121166-lin.cambridge.arm.com>
References: <20200521024709.2368-1-dinghao.liu@zju.edu.cn>
 <20200529180518.GA3078281@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529180518.GA3078281@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 29, 2020 at 08:05:18PM +0200, Thierry Reding wrote:
> On Thu, May 21, 2020 at 10:47:09AM +0800, Dinghao Liu wrote:
> > pm_runtime_get_sync() increments the runtime PM usage counter even
> > when it returns an error code. Thus a pairing decrement is needed on
> > the error handling path to keep the counter balanced.
> > 
> > Also, call pm_runtime_disable() when pm_runtime_get_sync() returns
> > an error code.
> > 
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > ---
> >  drivers/pci/controller/pci-tegra.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

Applied to pci/tegra, thanks !

Lorenzo
