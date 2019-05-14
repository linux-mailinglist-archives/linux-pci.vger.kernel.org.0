Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A20351C0E4
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 05:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfENDa3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 23:30:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4821 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfENDa3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 23:30:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cda365a0001>; Mon, 13 May 2019 20:30:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 20:30:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 20:30:28 -0700
Received: from [10.24.47.172] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 03:30:22 +0000
Subject: Re: [PATCH V6 02/15] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
To:     Christoph Hellwig <hch@infradead.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-3-vidyas@nvidia.com>
 <20190513072539.GA27708@infradead.org>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <3a8cea93-2aeb-e5e2-4d56-f0c6449073c3@nvidia.com>
Date:   Tue, 14 May 2019 09:00:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513072539.GA27708@infradead.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557804635; bh=WF0v0tqItCQpPYntKi+aRXw99fOxbVxnrACwlglFS0M=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CG/hepeT0PKprItd4aVLx0siRKGoqBQsVPtZB9n0+z3wKU/rBtSo7sUzqyrb5q6iw
         20TBFHmDxZX/RK8u8iUDNYLnfx74+YmrrQ/gCL4EkiTDdaaVFSHjqNhR0leppyUeTB
         ChSatjDwvyeWU/kZOVfMBXjsWOUXESuOmghAzkEPZoBNkTBaF1iQpV0Kj10V2cZA2I
         EtXRmv/zTm2fa5APR7T2TPAQnDgfaV5lPPj9tI6Jeb8dHWbVTRgHGAIDWSdUP051FE
         W+WvGWMI4/xdAWzkTHiS5Ftamt2ooSjaPGDD8W6OdZSzbkXID0FlK8AnD/mtizScL8
         cwz8vpu2Aoprw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/13/2019 12:55 PM, Christoph Hellwig wrote:
> On Mon, May 13, 2019 at 10:36:13AM +0530, Vidya Sagar wrote:
>> Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs to enable drivers
>> using these APIs be able to build as loadable modules.
> 
> But this is a global setting.  If you root port is broken you need
> a per-rootport quirk instead.
> 
There is nothing broken in Tegra194 root port as such, rather,  this is more
of software configuration choice and we are going with legacy interrupts than
MSI interrupts (as Tegra194 doesn't support raising PME interrupts through MSI
and please note that this doesn't mean root port is broken). Since Tegra194 has
only Synopsys DesignWare core based host controllers and not any other hosts, I
think it is fine to call this API in driver. Also, since this is a global setting,
calling this APIs from anywhere (be it from quirk or from driver) would have the
same effect, or did I miss anything here?
