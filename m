Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82C64A5DFE
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 15:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiBAONe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 09:13:34 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:52128 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239107AbiBAONd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 09:13:33 -0500
X-Greylist: delayed 1121 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Feb 2022 09:13:33 EST
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4Jp5z00Th1zDR0;
        Tue,  1 Feb 2022 08:54:52 -0500 (EST)
Received: from xps-7390 (ip98-164-213-246.oc.oc.cox.net [98.164.213.246])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4Jp5yw1XQqzmlV;
        Tue,  1 Feb 2022 08:54:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1643723690; bh=E6issl2zyMCOgqYdmjLT0TYwLzTN0iwu0A+iPAEXxVE=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=ToZrUXNF6DquvMp8zWq/E7GtURIH7fSRVtU9z6LpWYPLTxKH2lAi4j8SKn9CJXhk1
         VPB4hS+LSqWG+UpBK7TqTFZb3vFUj9QkzCW4z4f176gsQgLhutmhrKw/JzrHRXfDBB
         ck63UTL50kq1Jgj0GijIW3cl8ermjvkAPF0WqCs8=
Date:   Tue, 1 Feb 2022 05:54:47 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Vidya Sagar <vidyas@nvidia.com>
cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        hkallweit1@gmail.com, wangxiongfeng2@huawei.com,
        mika.westerberg@linux.intel.com, kai.heng.feng@canonical.com,
        chris.packham@alliedtelesis.co.nz, yangyicong@hisilicon.com,
        treding@nvidia.com, jonathanh@nvidia.com, abhsahu@nvidia.com,
        sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
In-Reply-To: <20220201123536.12962-1-vidyas@nvidia.com>
Message-ID: <71496f4d-fdd0-d24e-97e3-8739332471f0@panix.com>
References: <20220201123536.12962-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Tue, 1 Feb 2022, Vidya Sagar wrote:

> So,
> Could you please try this patch on top of linux-next and collect more info?

Sure! Give me a day or so (traveling) and I'll report back.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
