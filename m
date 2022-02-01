Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26A04A67F3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 23:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiBAWZp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 17:25:45 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:35559 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiBAWZo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 17:25:44 -0500
Received: from xps-7390.lan (unknown [184.169.45.4])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4JpKHx4PSMzPFw;
        Tue,  1 Feb 2022 17:25:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1643754343; bh=ECZSp4TbWwljAHiS5Gy/n9HhrRjmzi2Y8jQbybJxlHw=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=UDNwggrdh8lC/j1Huy9Y3EKQQS9b5r7PfFNpGr5/y1P1dnQanI51nPTT+iC9OB8hF
         KfAyNVLjV9Mdy4jMS+i7iiwvi6arYfLI2/DJTXmpdWh//CXbQFzbXGb3WpGefTEW1t
         OQAUh0vwgH/ESAjnvjqpdxFPOXrub74ue9cf8/TA=
Date:   Tue, 1 Feb 2022 14:25:10 -0800 (PST)
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
In-Reply-To: <2ab59f0d-3ae7-ca5e-6bfc-12bed18813b2@nvidia.com>
Message-ID: <38a02915-906f-c53-7e13-6c8710315e7@panix.com>
References: <20220201123536.12962-1-vidyas@nvidia.com> <8aa96f79-402-4897-424f-64a2c6893de8@panix.com> <2ab59f0d-3ae7-ca5e-6bfc-12bed18813b2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 2 Feb 2022, Vidya Sagar wrote:

> BTW, I see that the ASPM L1SS capability is supported by only two endpoints
> viz. KIOXIA's NVMe drive and Realtek's Card reader. None of the root ports
> seem to have the support. So, I'm wondering how was it even getting enabled in
> the first place earlier?

> (OR)

> was it the case that L1SS sub-states were never enabled earlier also and the
> issue was occurring without having ASPM L1SS enabled? (but with only L0s and
> L1 enabled??)

I'm not proficient enough in PCIe to be able to be sure of the answers to those-
what can/could I do to determine this?

> Also, I see that from 'before' and 'after' logs that for both NVMe and Card
> reader and their corresponding root ports, none of the ASPM states are enabled
> (not even L0s or L1).
> Did you set the policy to 'powersupersave' before hibernating the system?

Yeah:

CONFIG_PCIEASPM_POWER_SUPERSAVE=y

My laptop loses ~1.5%/hr in S3; I was trying anything I could to reduce that,
if possible.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
