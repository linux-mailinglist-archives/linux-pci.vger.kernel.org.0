Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6720D2D16AB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 17:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgLGQnj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 11:43:39 -0500
Received: from foss.arm.com ([217.140.110.172]:55358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgLGQnj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 11:43:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DAF9101E;
        Mon,  7 Dec 2020 08:42:53 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.35.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 597773F68F;
        Mon,  7 Dec 2020 08:42:52 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Update comment about disabling link training
Date:   Mon,  7 Dec 2020 16:42:40 +0000
Message-Id: <160735932845.19628.8346560834427451866.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201202184659.3795-1-pali@kernel.org>
References: <20200924084618.12442-1-pali@kernel.org> <20201202184659.3795-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2 Dec 2020 19:46:59 +0100, Pali Rohár wrote:
> It is not HW bug or workaround for some cards but it is requirement by PCI
> Express spec. After fundamental reset is needed 100ms delay prior enabling
> link training. So update comment in code to reflect this requirement.

Applied to pci/aardvark, thanks!

[1/1] PCI: aardvark: Update comment about disabling link training
      https://git.kernel.org/lpieralisi/pci/c/1d1cd163d0

Thanks,
Lorenzo
