Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED3D113EE8
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2019 10:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfLEJ7d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Dec 2019 04:59:33 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4870 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfLEJ7d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2019 04:59:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de8d5000000>; Thu, 05 Dec 2019 01:59:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Dec 2019 01:59:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Dec 2019 01:59:32 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Dec
 2019 09:59:32 +0000
Received: from [10.25.73.84] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Dec 2019
 09:59:28 +0000
Subject: Re: [PATCH 1/4] PCI: dwc: Add new feature to skip core initialization
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>,
        <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <20191113090851.26345-2-vidyas@nvidia.com>
 <20191127094844.GA21122@infradead.org>
 <80d610bf-71d8-d2c1-9c75-b0a58cb5c8ed@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <2c9a860f-4700-87e9-2538-9b0d40c9ce34@nvidia.com>
Date:   Thu, 5 Dec 2019 15:29:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <80d610bf-71d8-d2c1-9c75-b0a58cb5c8ed@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575539968; bh=FJ/ufq3DMyMB0SdrVKvJq04CRyn8GvLD1QOEQGmYUVM=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mkbAxR4g0hk2Q+9IdZlfW6hicVtQJHxaOhbcLYd8ernWZL5+AFEEMKQRBQIDMKw0q
         vm/2MhIpgh/8G7Bw1FocEEChDX1cMUTk9S0DDpgBrgzQL0G7TQej8O95zg3xVH4qSO
         X6OVNtXCfwX8DV2qVNKr79vAHyesnOqAjCnoprTpigsDjhplLidYDip/Q0adnvFoAa
         3SY1gYaFp1eZygJsB4z9L/ANJ0n2e6iknGMRS+JR12zdHaNJwsYjNjjqzxYkgzP8KC
         GU/xIBVP+OHM0eMnIzgE6waf0a4n3De5KUN4MDumB0f6iWnWP5Iqk+LC22IM/D8o09
         n5OFF9D0URCNw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/29/2019 8:10 PM, Vidya Sagar wrote:

Hi Christoph,
Could you please let me know what am I missing here?

Thanks,
Vidya Sagar

> On 11/27/2019 3:18 PM, Christoph Hellwig wrote:
>> On Wed, Nov 13, 2019 at 02:38:48PM +0530, Vidya Sagar wrote:
>>> +=C2=A0=C2=A0=C2=A0 if (ep->ops->get_features) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 epc_features =3D ep->ops->g=
et_features(ep);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (epc_features->skip_core=
_init)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return dw_pcie_ep_init_complete(ep);
>>
>> This calling convention is strange.=C2=A0 Just split the early part of
>> dw_pcie_ep_init into an dw_pcie_ep_early and either add a tiny
>> wrapper like:
>>
>> int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0int error;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0error =3D dw_pcie_ep_init_early(ep);
>> =C2=A0=C2=A0=C2=A0=C2=A0if (error)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
>> =C2=A0=C2=A0=C2=A0=C2=A0return dw_pcie_ep_init_late(ep);
>> }
>>
>> or just open code that in the few callers.=C2=A0 That keeps the calling
>> conventions much simpler and avoids relying on a callback and flag.
> I'm not sure if I got this right. I think in any case, code that is going=
 to be
> part of dw_pcie_ep_init_late() needs to depend on callback and flag right=
?
> I mean, unless it is confirmed (by calling the get_features() callback an=
d
> checking whether or not the core is available for programming) dw_pcie_ep=
_init_late()
> can't be called right?
> Please let me know if I'm missing something here.
>=20
> - Vidya Sagar
>>
>=20

