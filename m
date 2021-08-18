Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189AC3F0302
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 13:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhHRLsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Aug 2021 07:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229876AbhHRLss (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Aug 2021 07:48:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E86A56108B;
        Wed, 18 Aug 2021 11:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629287266;
        bh=RlaP+cG3Z/HkPFEREGD+JelXFQgaEMzLMLcN+XqtmcA=;
        h=Date:From:To:Cc:Subject:From;
        b=q+apjJroIU2BV8zQ5bxY+qkBNXAfL5sDRn+yUJ3W2I4wJ9RNlW8sZMgxkwgNgkDwp
         wQDN741ipnsbBRLWBjR0ICq60krA/uhdkIakgyb2VSC/BCjxYHH5QJZeDb5rgKPvJB
         gligbanHqs0jfIBMXodGPfzaZWc+rBl9IDteadvVEsRVJUOeGhkRk46IEd51cYBo0B
         VOa3U4nv8wQaE3Li0GWfZoCik6vK6wkgCsJDtsyJFrikP+XmViXr3cC8AuZ2fNSocZ
         XDbSChdofPvVVwSaJPuKPfe+DzYK43EVE4zD8wqpIzQul+Yi9VbdNqDZMfLO6WwroP
         XwediYb/tCbWg==
Received: by pali.im (Postfix)
        id 6749868A; Wed, 18 Aug 2021 13:47:43 +0200 (CEST)
Date:   Wed, 18 Aug 2021 13:47:43 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: pci-ftpci100: race condition in masking/unmasking interrupts
Message-ID: <20210818114743.kksb7tydqjkww67h@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

I do not see any entry in MAINTAINERS file for pci-ftpci100.c driver, so
I'm not sure to whom should I address this issue...

During pci-aardvark review, Marc pointed one issue which is currently
available also in pci-ftpci100.c driver.

When masking or unmasking interrupts there is read-modify-write sequence
for FARADAY_PCI_CTRL2 register without any locking and is not atomic:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-ftpci100.c?h=v5.13#n270

So there is race condition when masking/unmasking more interrupts at the
same time.
