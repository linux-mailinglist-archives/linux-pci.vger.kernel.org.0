Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABAC38AD4D
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 14:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbhETMCm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 08:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242232AbhETMCU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 May 2021 08:02:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1F4E610A1;
        Thu, 20 May 2021 12:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621512058;
        bh=prar2rBH142PrkdxhYZD4TusZ6jznHF0Nu4EwNz/rGE=;
        h=Date:From:To:Subject:From;
        b=qWBJT4i+qYwYND96ATM9k+kNSSmtyy6h8EV6goslkmV7l086vgYxAZOHuambhCqCi
         YXEQNbEfXs8Y28ptGgh3lrJjJ3B+P+wXVaNSKQstM6bJDSWdDFszRQY/vs8r5rS4e8
         VHmSbQgQ1bmyf3Nhl+DCmgNs6OS+ZG3JrHK3xOBPMIeUGX9VBrEZ5gjaQisnZhe3YS
         1tPMki5UFOeB6J7Uw9I9fSgiJUopjDpg3pO2FvL7cSq9lLhqbODiXBQre8ytdy7xLc
         ZiAIEWIdz8LqEDlG4k12F2VipmraJbzbnBWdyYguxbf0WatKWU44jg3EUrMBF6x7zZ
         C5As4sI/rT/aw==
Received: by pali.im (Postfix)
        id 0774A9D1; Thu, 20 May 2021 14:00:55 +0200 (CEST)
Date:   Thu, 20 May 2021 14:00:55 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: pcie-iproc-msi.c: Bug in Multi-MSI support?
Message-ID: <20210520120055.jl7vkqanv7wzeipq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

I think there is a bug in pcie-iproc-msi.c driver. It declares
Multi MSI support via MSI_FLAG_MULTI_PCI_MSI flag, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-iproc-msi.c?h=v5.12#n174

but its iproc_msi_irq_domain_alloc() function completely ignores nr_irqs
argument when allocating interrupt numbers from bitmap, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-iproc-msi.c?h=v5.12#n246

I think this this is incorrect as alloc callback should allocate nr_irqs
multi interrupts as caller requested. All other drivers with Multi MSI
support are doing it.

Could you look at it?
