Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADF746941A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 11:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbhLFKs5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 05:48:57 -0500
Received: from foss.arm.com ([217.140.110.172]:53814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238305AbhLFKs5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 05:48:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79FEC11FB;
        Mon,  6 Dec 2021 02:45:28 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.33.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8389E3F73D;
        Mon,  6 Dec 2021 02:45:26 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: apple: Fix REFCLK1 enable/poll logic
Date:   Mon,  6 Dec 2021 10:45:20 +0000
Message-Id: <163878750604.22621.11946198866111857544.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211117140044.193865-1-marcan@marcan.st>
References: <20211117140044.193865-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Nov 2021 23:00:44 +0900, Hector Martin wrote:
> REFCLK1 has req/ack bits just like REFCLK0
> 
> 

Applied to pci/apple, thanks!

[1/1] PCI: apple: Fix REFCLK1 enable/poll logic
      https://git.kernel.org/lpieralisi/pci/c/75d36df680

Thanks,
Lorenzo
