Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6471300955
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 18:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbhAVRLj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 12:11:39 -0500
Received: from foss.arm.com ([217.140.110.172]:57598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729809AbhAVRIn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jan 2021 12:08:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E046B11B3;
        Fri, 22 Jan 2021 09:07:54 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.57.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D4A43F719;
        Fri, 22 Jan 2021 09:07:53 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mans Rullgard <mans@mansr.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] pci: remove tango host controller driver
Date:   Fri, 22 Jan 2021 17:07:47 +0000
Message-Id: <161133473342.31409.11357898848405202939.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210120150800.1650898-1-arnd@kernel.org>
References: <20210120150800.1650898-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 20 Jan 2021 16:07:29 +0100, Arnd Bergmann wrote:
> The tango platform is getting removed, so the driver is no
> longer needed.

Applied to pci/tango, thanks!

[1/1] PCI: Remove tango host controller driver
      https://git.kernel.org/lpieralisi/pci/c/de9427ca87

Thanks,
Lorenzo
