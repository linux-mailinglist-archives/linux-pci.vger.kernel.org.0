Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5F423210
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 22:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhJEUdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 16:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232250AbhJEUdl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 16:33:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E334610C8;
        Tue,  5 Oct 2021 20:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633465910;
        bh=MN5imo+iWVErP17wA9QUhh10puPbldN1+XKGpwMNrIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dS/wZC9zNi3HMu7DXMyyBrQfI61oyu4hGxn8cSipAX0+/MqxCvXKxbWTOAyzonF1g
         NacVFm/zjgzn25KnKVaaU1pkvtXjSA8KWtDbN5UUcbr0Uqk05XA/6PN/RQ92C8n8ip
         mCTuvpamPtgJr/pLsw3qqEx6go8yL0sDGRIsGvjtLEorEbQXkK+tOLOLsUBMoydl1R
         BHj4TXRPdMmoOzhMI/rsVFy+BawJZFDXbqECMCwuY0g47+AhYFuHo/m0S6mogS3qET
         CmnQGlHrubTt3VkCadUJkXb37S7LjpUurCUpP4GSCInJoHA5DFKk9LgYzfzjD+4cq5
         gzDlQmnNTEhrQ==
Received: by pali.im (Postfix)
        id 2E3B4812; Tue,  5 Oct 2021 22:31:48 +0200 (CEST)
Date:   Tue, 5 Oct 2021 22:31:48 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v12 03/11] PCI: kirin: Add support for a PHY layer
Message-ID: <20211005203148.gn2f34pfvm62w6ca@pali>
References: <cover.1632814194.git.mchehab+huawei@kernel.org>
 <8a6d353145c0ec169d212094f5d534f93e2597f8.1632814194.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a6d353145c0ec169d212094f5d534f93e2597f8.1632814194.git.mchehab+huawei@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Tuesday 28 September 2021 09:34:13 Mauro Carvalho Chehab wrote:
> The pcie-kirin driver contains both PHY and generic PCI driver
> on it.
> 
> The best would be, instead, to support a PCI PHY driver, making
> the driver more generic.
> 
> However, it is too late to remove the Kirin 960 PHY, as a change
> like that would make the DT schema incompatible with past versions.

I have not looked deeply at it. But is not it really possible to declare
PHY node in DTS file with backward compatible manner? Or cannot Rob help
with it (maybe there was similar issue in past with other driver)?

I was fixing something similar, address space defined in DTS was used by
two HW blocks: clock and UART. And I was able to make both DTS file and
driver backward compatible.
