Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B4B4A91F5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 02:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiBDBSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 20:18:25 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:43979 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiBDBSZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 20:18:25 -0500
Received: from xps-7390.lan (50-233-66-25-static.hfc.comcastbusiness.net [50.233.66.25])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4Jqd2l0MCDz14j2;
        Thu,  3 Feb 2022 20:18:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1643937504; bh=0qSjb57vhCpcs7a1tYd3FAFBq9x66ySjnwUDc45qp4c=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=oFD6/tv7fEmiSr2LA6C/RZXXig06qv76DzTC0TlQUJE3bm8IA0oTTlKj0F9xKfzAT
         p95GF1mMV008D0MZPjWOf+QB3sLZ14ns3lX2lqqL0TE+8NQPtVDy1gt4ivsS3k3190
         GJhm6sSofgK3I5fLifDH6OsjK1CyI1GIA0jI7R4E=
Date:   Thu, 3 Feb 2022 17:18:22 -0800 (PST)
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
In-Reply-To: <708b746c-1715-9d64-5a59-55c9ad81bd0a@nvidia.com>
Message-ID: <f449b4a-a13-d32d-b7c3-da226aebd30@panix.com>
References: <20220201123536.12962-1-vidyas@nvidia.com> <8aa96f79-402-4897-424f-64a2c6893de8@panix.com> <2ab59f0d-3ae7-ca5e-6bfc-12bed18813b2@nvidia.com> <38a02915-906f-c53-7e13-6c8710315e7@panix.com> <708b746c-1715-9d64-5a59-55c9ad81bd0a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 2 Feb 2022, Vidya Sagar wrote:

> but could you please confirm that you are using the same system as before?

Yeah, the same Dell XPS 7390 2-in-1 as last year.

I've merged this change into Linus' master and it's been
suspending/resuming/hibernating with no issues so far. Is there anything else
you'd like me to test?

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
