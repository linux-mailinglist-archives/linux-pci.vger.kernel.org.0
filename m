Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9057F39A5C6
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 18:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFCQeC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 12:34:02 -0400
Received: from foss.arm.com ([217.140.110.172]:45358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhFCQeC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 12:34:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B0D711B3;
        Thu,  3 Jun 2021 09:32:17 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F11303F73D;
        Thu,  3 Jun 2021 09:32:15 -0700 (PDT)
Date:   Thu, 3 Jun 2021 17:32:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 0/4] PCI: brcmstb: Add panic handler and shutdown func
Message-ID: <20210603163213.GB19835@lpieralisi>
References: <20210427175140.17800-1-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427175140.17800-1-jim2101024@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 27, 2021 at 01:51:35PM -0400, Jim Quinlan wrote:
> v1 -- These commits were part of a previous pullreq but have
>       been split off because they are unrelated to said pullreq's
>       other more complex commits.

Can I drop this series ?

https://patchwork.kernel.org/user/todo/linux-pci/?series=459871

Thanks,
Lorenzo

> Jim Quinlan (4):
>   PCI: brcmstb: Check return value of clk_prepare_enable()
>   PCI: brcmstb: Give 7216 SOCs their own config type
>   PCI: brcmstb: Add panic/die handler to RC driver
>   PCI: brcmstb: add shutdown call to driver
> 
>  drivers/pci/controller/pcie-brcmstb.c | 145 +++++++++++++++++++++++++-
>  1 file changed, 143 insertions(+), 2 deletions(-)
> 
> -- 
> 2.17.1
> 
