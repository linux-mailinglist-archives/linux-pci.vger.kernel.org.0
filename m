Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC30A1087E9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 05:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKYEeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Nov 2019 23:34:14 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1239 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKYEeO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Nov 2019 23:34:14 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddb59c90000>; Sun, 24 Nov 2019 20:34:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 24 Nov 2019 20:34:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 24 Nov 2019 20:34:13 -0800
Received: from [10.25.75.126] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Nov
 2019 04:34:09 +0000
Subject: Re: [PATCH 0/4] Add support to defer core initialization
To:     "kishon@ti.com" <kishon@ti.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <108c9f42-a595-515e-5ed6-e745a55efe70@nvidia.com>
 <SL2P216MB0105D49E39194C827D60B032AA4D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <550dd734-acd9-802a-f650-44c32b56b58a@nvidia.com>
Date:   Mon, 25 Nov 2019 10:03:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <SL2P216MB0105D49E39194C827D60B032AA4D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574656457; bh=BfDu0Gwt9ZesOr6ba1xsruGLFgOUT7v/gEah2QuX0Xo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mgSsVVRaXXlVb3lQ7dfibXFuo9n7PAR4P5eQ7llheJRBW2O3K1k6GftCp/c9Thalh
         P5NBzz+9wBnn1GcLwe0778sXWS8PmQFAYDk7HgYSFGOUcEsviaWjDE3genCCZ24D4o
         tY22kplJKWH4ViVyXa0VA1JCsD6Q68YdJMc+y2s6iRGjz44Lpr8yRfUVl5TJFd/WXv
         FpySLrhO/eCKubSLinQdt7Bz1CwaSJ9lA4mJ37ZI1O47ZIbWN8hF6RJHBFQKeSPL7t
         wlgmIo48bxyZS0CeplWxX4E+gOFJVsuy5wqIWDexZkYerGpSJXl7dDrn1ToXisgyiB
         M+ehyM+cM2I3w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/18/2019 10:13 PM, Jingoo Han wrote:
>=20
>=20
> =EF=BB=BFOn 11/18/19, 1:55 AM, Vidya Sagar wrote:
>>
>> On 11/13/2019 2:38 PM, Vidya Sagar wrote:
>>> EPC/DesignWare core endpoint subsystems assume that the core registers =
are
>>> available always for SW to initialize. But, that may not be the case al=
ways.
>>> For example, Tegra194 hardware has the core running on a clock that is =
derived
>>> from reference clock that is coming into the endpoint system from host.
>>> Hence core is made available asynchronously based on when host system i=
s going
>>> for enumeration of devices. To accommodate this kind of hardwares, supp=
ort is
>>> required to defer the core initialization until the respective platform=
 driver
>>> informs the EPC/DWC endpoint sub-systems that the core is indeed availa=
ble for
>>> initiaization. This patch series is attempting to add precisely that.
>>> This series is based on Kishon's patch that adds notification mechanism
>>> support from EPC to EPF @ http://patchwork.ozlabs.org/patch/1109884/
>>>
>>> Vidya Sagar (4):
>>>     PCI: dwc: Add new feature to skip core initialization
>>>     PCI: endpoint: Add notification for core init completion
>>>     PCI: dwc: Add API to notify core initialization completion
>>>     PCI: pci-epf-test: Add support to defer core initialization
>>>
>>>    .../pci/controller/dwc/pcie-designware-ep.c   |  79 +++++++-----
>>>    drivers/pci/controller/dwc/pcie-designware.h  |  11 ++
>>>    drivers/pci/endpoint/functions/pci-epf-test.c | 114 ++++++++++++----=
--
>>>    drivers/pci/endpoint/pci-epc-core.c           |  19 ++-
>>>    include/linux/pci-epc.h                       |   2 +
>>>    include/linux/pci-epf.h                       |   5 +
>>>    6 files changed, 164 insertions(+), 66 deletions(-)
>>>
>>
>> Hi Kishon / Gustavo / Jingoo,
>> Could you please take a look at this patch series?
>=20
> You need a Ack from Kishon, because he made EP code.
Hi Kishon,
Could you please find time to review this series?

- Vidya Sagar
>=20
>=20
>> - Vidya Sagar

