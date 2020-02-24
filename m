Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52FAE16ACAA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 18:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgBXRIF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 12:08:05 -0500
Received: from foss.arm.com ([217.140.110.172]:40086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbgBXRIF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 12:08:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DC901FB;
        Mon, 24 Feb 2020 09:08:04 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7F293F703;
        Mon, 24 Feb 2020 09:08:02 -0800 (PST)
Date:   Mon, 24 Feb 2020 17:07:47 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, bhelgaas@google.com, kishon@ti.com,
        thierry.reding@gmail.com, Jisheng.Zhang@synaptics.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 4/5] PCI: dwc: Add API to notify core initialization
 completion
Message-ID: <20200224170648.GA20144@e121166-lin.cambridge.arm.com>
References: <20200217121036.3057-1-vidyas@nvidia.com>
 <20200217121036.3057-5-vidyas@nvidia.com>
 <20200224113217.GA11120@e121166-lin.cambridge.arm.com>
 <77748536-4f9a-1357-8180-91c1da2e912e@nvidia.com>
 <20200224143218.GC15614@e121166-lin.cambridge.arm.com>
 <8ed75fb3-e5d8-7f7b-3c1b-4fd4d1de348d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed75fb3-e5d8-7f7b-3c1b-4fd4d1de348d@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 10:27:12PM +0530, Vidya Sagar wrote:

[...]

> > No worries - I just want to merge code that is actually used, I assume
> > the series above should be reposted right ? You need an ACK from Thierry
> > for it and we can merge the whole thing on top of Kishon's patches.
> I'll get the Ack from Thierry.
> BTW, my Tegra change series applies cleanly on top of this series. Do I
> still need to repost them?

No, no need then, I will take a look at it shortly.

Lorenzo
