Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10302CD593
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 13:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbgLCMh1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 07:37:27 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14390 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLCMh0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2020 07:37:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc8dbdd0002>; Thu, 03 Dec 2020 04:36:45 -0800
Received: from [10.25.75.116] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 12:36:37 +0000
Subject: Re: [PATCH V4 1/6] PCI: tegra: Fix ASPM-L1SS advertisement disable
 code
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "amanharitsh123@gmail.com" <amanharitsh123@gmail.com>,
        "dinghao.liu@zju.edu.cn" <dinghao.liu@zju.edu.cn>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201109171937.28326-2-vidyas@nvidia.com> <X7+Sc5Mtp4OvrO4P@ulmo>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <595c4616-71b9-e8bc-3300-c1c04503b850@nvidia.com>
Date:   Thu, 3 Dec 2020 18:06:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <X7+Sc5Mtp4OvrO4P@ulmo>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606999005; bh=Ghno+0cw8VXLyR9YQiz+AJ5XgUJGy4a+e880bHMHFfc=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Qlpx4OVoWkjIieVyxRsOLiyKJ6yry2N4poCWtoYDtPmp2LZVvqCiZARKJbGLwzUTq
         TQRx8ocQe3YxH/aUxY1Jzvpxi1QsT1DjAUagqCi8PPoly5P05QzU39ONESEIOEwPeq
         /uejJMxNciNEM/l2elVBJyBKNlp0cKpAroXrSr8vo5qpkdgZ2mHw/rgLUW2p7mQpWC
         qHa+x/HzmdTO7Ba+kEIpwtvSzDIKnXp4lMT15+RdwOmJAvNsHLT/W1CyaKGuL3IJKh
         JHbLoqdGYxRiZjrz/RHU40P5te31f8cKyaEdXCWZMDTv8CNO72d4mWVxhHOmz0Y8Mr
         4Rs/D0K0WGzHg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Thursday, November 26, 2020 5:03 PM
> To: Vidya Sagar <vidyas@nvidia.com>
> Cc: lorenzo.pieralisi@arm.com; robh+dt@kernel.org; bhelgaas@google.com;
> Jonathan Hunter <jonathanh@nvidia.com>; amanharitsh123@gmail.com;
> dinghao.liu@zju.edu.cn; kw@linux.com; linux-pci@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Krishna Thota
> <kthota@nvidia.com>; Manikanta Maddireddy <mmaddireddy@nvidia.com>;
> sagar.tv@gmail.com
> Subject: Re: [PATCH V4 1/6] PCI: tegra: Fix ASPM-L1SS advertisement disable
> code
> 
> On Mon, Nov 09, 2020 at 10:49:32PM +0530, Vidya Sagar wrote:
> > If the absence of CLKREQ# signal is indicated by the absence of
> > "supports-clkreq" in the device-tree node, current driver is disabling
> > the advertisement of ASPM-L1 Sub-States *before* the ASPM-L1
> > Sub-States offset is correctly initialized. Since default value of the
> > ASPM-L1SS offset is zero, this is causing the Vendor-ID wrongly
> > programmed to 0x10d2 instead of Nvidia's 0x10de thereby the quirks
> > applicable for Tegra194 are not being applied. This patch fixes this
> > issue by refactoring the code that disables the ASPM-L1SS advertisement.
> >
> > Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> > V4:
> > * None
> >
> > V3:
> > * None
> >
> > V2:
> > * None
> >
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Looks like this no longer applies cleanly after that other fix that you sent earlier.
> But looking more closely, that's because that other fix already incorporates an
> equivalent change, so I think this can be dropped from this series.
Yes. This is no longer applies cleanly and I'll fix it in the next 
series, but, the current patch is still required.
The other change I pushed is taking care of getting a valid 'dbi' 
address before accessing the dbi region, but, this current change would 
make sure that 'pcie->cfg_link_cap_l1sub' would have a valid value 
before calling disable_aspm_l1/2() APIs.

Thanks,
Vidya Sagar
> 
> Thierry
