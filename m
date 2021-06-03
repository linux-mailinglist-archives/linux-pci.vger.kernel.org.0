Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FF739A57E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 18:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCQOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 12:14:33 -0400
Received: from foss.arm.com ([217.140.110.172]:44982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhFCQOc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 12:14:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C897411B3;
        Thu,  3 Jun 2021 09:12:47 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 270AA3F73D;
        Thu,  3 Jun 2021 09:12:45 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>
Subject: Re: [PATCH] PCI: microchip: Make the struct event_descs static
Date:   Thu,  3 Jun 2021 17:12:39 +0100
Message-Id: <162273673895.19397.5684393026527063246.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210509041932.560340-1-kw@linux.com>
References: <20210509041932.560340-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 9 May 2021 04:19:32 +0000, Krzysztof Wilczyński wrote:
> The struct event_descs does not have any users outside the
> pcie-microchip-host.c file, and has no previous declaration,
> thus it can be made static.
> 
> This resolves the following sparse warning:
> 
>   drivers/pci/controller/pcie-microchip-host.c:352:3: warning: symbol 'event_descs' was not declared. Should it be static?

Applied to pci/microchip, thanks!

[1/1] PCI: microchip: Make the struct event_descs static
      https://git.kernel.org/lpieralisi/pci/c/1243106474

Thanks,
Lorenzo
