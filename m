Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7C180512
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 18:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgCJRmo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Mar 2020 13:42:44 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5074 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCJRmo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2020 13:42:44 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e67d1850001>; Tue, 10 Mar 2020 10:42:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 10 Mar 2020 10:42:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 10 Mar 2020 10:42:42 -0700
Received: from [10.25.76.193] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Mar
 2020 17:42:38 +0000
Subject: Re: [PATCH V4 0/5] Add support for PCIe endpoint mode in Tegra194
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <andrew.murray@arm.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200303105418.2840-1-vidyas@nvidia.com>
 <20200303170103.GA9641@e121166-lin.cambridge.arm.com>
 <d1e3a42f-c179-fd03-fac0-7cd449580e5b@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b47de9cd-be18-1672-d72c-de4169fb90e5@nvidia.com>
Date:   Tue, 10 Mar 2020 23:12:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d1e3a42f-c179-fd03-fac0-7cd449580e5b@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583862149; bh=bLPWb514eTiRguIqWyQUJ1EnhXyKcsE4Sh+k6DY+ers=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RlQB+FTkNz5F0SXLEO/yTQ8SMNanL+AgnZSs7APnpGPD29aFVrHIu7/2XdsBXpfTN
         oLmGHZzILdBpuK71YToaVxj4tF747++R+ZmplE7JyzZwVhKrTbynerz3VG5rp82e/X
         c0l8Cr06UY7c9sW2J0t1f7Q+dd+h52mMjaqvNlWoAPCJmtgL/P5gMzl+dxzgo2AXYx
         p8/XbyH9QzmEUPllXQaaxazA9iz0FJEoYpuLDqP4B52pMUKU+3kDPSj/1CJLxYxGOz
         y8ybSF/dpuI6NGQPoJ80bSJyw+f1s08p8sYy5CzQ+Lw8MJGZ5vXIqPFa807Y5Lm9+v
         2Ri/w9PRKuehA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/3/2020 11:43 PM, Vidya Sagar wrote:
>=20
>=20
> On 3/3/2020 10:31 PM, Lorenzo Pieralisi wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Tue, Mar 03, 2020 at 04:24:13PM +0530, Vidya Sagar wrote:
>>> Tegra194 has three (C0, C4 & C5) dual mode PCIe controllers that can=20
>>> operate
>>> either in root port mode or in end point mode but only in one mode at=20
>>> a time.
>>> Platform P2972-0000 supports enabling endpoint mode for C5=20
>>> controller. This
>>> patch series adds support for PCIe endpoint mode in both the driver=20
>>> as well as
>>> in DT.
>>> This patch series depends on the changes made for Synopsys DesignWare=20
>>> endpoint
>>> mode subsystem that are recently accepted.
>>> @ https://patchwork.kernel.org/project/linux-pci/list/?series=3D202211
>>> which in turn depends on the patch made by Kishon
>>> @ https://patchwork.kernel.org/patch/10975123/
>>> which is also under review.
>>>
>>> V4:
>>> * Started using threaded irqs instead of kthreads
>>
>> Hi Vidya,
>>
>> sorry for the bother, may I ask you to rebase the series (after
>> answering Thierry's query) on top of my pci/endpoint branch please ?
>>
>> Please resend it and I will merge patches {1,2,5} then.
> Sure.
> I just sent V5 series rebasing patches on top of your pci/endpoint branch=
.
Hi,
Sorry to bother you again.
Could you please take a look at V5 series?

Thanks,
Vidya Sagar
>=20
> Thanks,
> Vidya Sagar
>>
>> Thanks,
>> Lorenzo
>>
>>> V3:
>>> * Re-ordered patches in the series to make the driver change as the=20
>>> last patch
>>> * Took care of Thierry's review comments
>>>
>>> V2:
>>> * Addressed Thierry & Bjorn's review comments
>>> * Added EP mode specific binding documentation to already existing=20
>>> binding documentation file
>>> * Removed patch that enables GPIO controller nodes explicitly as they=20
>>> are enabled already
>>>
>>> Vidya Sagar (5):
>>> =C2=A0=C2=A0 soc/tegra: bpmp: Update ABI header
>>> =C2=A0=C2=A0 dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes =
in Tegra194
>>> =C2=A0=C2=A0 arm64: tegra: Add PCIe endpoint controllers nodes for Tegr=
a194
>>> =C2=A0=C2=A0 arm64: tegra: Add support for PCIe endpoint mode in P2972-=
0000
>>> =C2=A0=C2=A0=C2=A0=C2=A0 platform
>>> =C2=A0=C2=A0 PCI: tegra: Add support for PCIe endpoint mode in Tegra194
>>>
>>> =C2=A0 .../bindings/pci/nvidia,tegra194-pcie.txt=C2=A0=C2=A0=C2=A0=C2=
=A0 | 125 +++-
>>> =C2=A0 .../boot/dts/nvidia/tegra194-p2972-0000.dts=C2=A0=C2=A0 |=C2=A0 =
18 +
>>> =C2=A0 arch/arm64/boot/dts/nvidia/tegra194.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 99 +++
>>> =C2=A0 drivers/pci/controller/dwc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 30 +-
>>> =C2=A0 drivers/pci/controller/dwc/pcie-tegra194.c=C2=A0=C2=A0=C2=A0 | 6=
81 +++++++++++++++++-
>>> =C2=A0 include/soc/tegra/bpmp-abi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
10 +-
>>> =C2=A0 6 files changed, 918 insertions(+), 45 deletions(-)
>>>
>>> --=20
>>> 2.17.1
>>>
