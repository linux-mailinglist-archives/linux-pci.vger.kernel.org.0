Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00E7363FC0
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 12:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhDSKpP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 06:45:15 -0400
Received: from foss.arm.com ([217.140.110.172]:40068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhDSKpN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Apr 2021 06:45:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB1581FB;
        Mon, 19 Apr 2021 03:44:43 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37ACA3F85F;
        Mon, 19 Apr 2021 03:44:41 -0700 (PDT)
Date:   Mon, 19 Apr 2021 11:44:32 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
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
Message-ID: <20210419104432.GA2427@lpieralisi>
References: <20210324030510.29177-1-jianjun.wang@mediatek.com>
 <20210416192100.GA2745484@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416192100.GA2745484@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 16, 2021 at 02:21:00PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 24, 2021 at 11:05:03AM +0800, Jianjun Wang wrote:
> > These series patches add pcie-mediatek-gen3.c and dt-bindings file to
> > support new generation PCIe controller.
> 
> Incidental: b4 doesn't work on this thread, I suspect because the
> usual subject line format is:
> 
>   [PATCH v9 9/7]
> 
> instead of:
> 
>   [v9,0/7]
> 
> For b4 info, see https://git.kernel.org/pub/scm/utils/b4/b4.git/tree/README.rst

Jianjun will update the series accordingly (and please add to v10 the
review tags you received.

Lorenzo
