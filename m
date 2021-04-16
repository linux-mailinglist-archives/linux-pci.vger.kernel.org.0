Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C771362885
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 21:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbhDPTV1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 15:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235122AbhDPTV0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Apr 2021 15:21:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E6BD613B4;
        Fri, 16 Apr 2021 19:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618600861;
        bh=Mb8WXSaI6EQEdDBcj/7Sx7GoSOZzNFRqwbZ1cijvPu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A6JRsw0Na4PjV2z20RN2EJfOyGhbsRQmXbpAx3dSrY1370mvl+suHWBCeU/AFeXyB
         zjdlnjTNSjyg4S8R39c01y+sfQ5dNTAOVwTAvA9dcVVJC40Mv79PcuHCkXPqc8h8Or
         koVpyJlD9krHGu6WNIg8IbXsUkWNrcxQBrSb5jIneWCOKHrZl+I78yQs/JgYxFvLar
         XMXpZHG5TD2TxgNIYfEFa9JuUG0L5mu+huHASe3guq1luIS1w/HlQcc8l5Lv0ty7RX
         RAe1rPITv5IGiy/5TPEIiMmG4RqZd0IXgI0/Fu95eeOVKKeff8ilU4yFtDAAkzoUIL
         GWuy8b5E6Ke7A==
Date:   Fri, 16 Apr 2021 14:21:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com,
        Krzysztof Wilczyski <kw@linux.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [v9,0/7] PCI: mediatek: Add new generation controller support
Message-ID: <20210416192100.GA2745484@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324030510.29177-1-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 24, 2021 at 11:05:03AM +0800, Jianjun Wang wrote:
> These series patches add pcie-mediatek-gen3.c and dt-bindings file to
> support new generation PCIe controller.

Incidental: b4 doesn't work on this thread, I suspect because the
usual subject line format is:

  [PATCH v9 9/7]

instead of:

  [v9,0/7]

For b4 info, see https://git.kernel.org/pub/scm/utils/b4/b4.git/tree/README.rst
