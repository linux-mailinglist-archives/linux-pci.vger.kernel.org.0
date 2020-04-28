Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655601BBF93
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgD1NbX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 09:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgD1NbX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Apr 2020 09:31:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56C90206D6;
        Tue, 28 Apr 2020 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588080682;
        bh=4IjMN/3nSMM2CXswAlECOTw3UvL1UdbgXql3tahnnIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U8hgL19C4C/65u6AvzzNc2gAU07onDsuhSvKBUnFsyc8jis0wBbvVyvRZ3Gu3K8/W
         BjEzYoj6UAgRg9E3imbQQgq8J3IKqFg2S92i/njMoITh1GZPTlNl14wjK1DI4rpXZj
         DXfkv3RdTn+ULjbdewpr8eBIPOeNtkA7tUneGiHo=
Date:   Tue, 28 Apr 2020 14:31:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mans Rullgard <mans@mansr.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Robert Richter <rrichter@marvell.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Toan Le <toan@os.amperecomputing.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Chocron <jonnyc@amazon.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: host-generic: Support building as modules
Message-ID: <20200428133116.GG6791@willie-the-truck>
References: <20200409234923.21598-1-robh@kernel.org>
 <20200409234923.21598-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409234923.21598-3-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 09, 2020 at 05:49:22PM -0600, Rob Herring wrote:
> Enable building host-generic and its host-common dependency as a
> module.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/Kconfig            | 4 ++--
>  drivers/pci/controller/pci-host-common.c  | 5 +++++
>  drivers/pci/controller/pci-host-generic.c | 7 +++++--
>  drivers/pci/ecam.c                        | 4 ++++
>  drivers/pci/setup-bus.c                   | 1 +
>  include/linux/pci-ecam.h                  | 2 +-
>  6 files changed, 18 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
