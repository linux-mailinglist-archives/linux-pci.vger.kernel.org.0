Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE503048B1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbhAZFle (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 00:41:34 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18115 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731746AbhAYTbQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 14:31:16 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600f1c530005>; Mon, 25 Jan 2021 11:30:27 -0800
Received: from [10.26.73.116] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Jan
 2021 19:30:17 +0000
Subject: Re: [PATCH] PCI: dwc: fix reference leak in
 pex_ep_event_pex_rst_deassert
To:     Vidya Sagar <vidyas@nvidia.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20201102143045.142121-1-zhangqilong3@huawei.com>
 <f09c0801-d584-3c27-d3e7-ca59a64a30d1@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <fa858756-8fe4-5049-b280-410d225a58a8@nvidia.com>
Date:   Mon, 25 Jan 2021 19:30:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f09c0801-d584-3c27-d3e7-ca59a64a30d1@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611603027; bh=WpUz2Dkx5q+D8axysE0ISfQBF5J+PN/exCgUw/FMgBs=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=fs9ankxZk9Q/+HBQ5EfqVADGMSFbam9v6xkW0SLScOg2mtAOjOcdfqC6Rm9xxIgHE
         XcjoVycuRcmY6v4Y/NFGOA7dhHx2uUDso4Iu/sumN1J2WZGas9zoSbE86poqF1ckpZ
         Hs5B4N1W4u/BIKZQMoROVZu2UFnW7wt43XNAffwAbIuj8XSg5LGciful2aCviVCzvU
         rkz5dmLafV0zoNaX8Kuyi1KnYN45A0MtabON+kbQMTLVjQ2Cd5hFiuAtempMPzoIVp
         DDCaSfHjXBYanJJm8jx16fjvF+WCXcjlQDiZiy2bq4wbrjqGDM0S5cNL3NmLIZXLnH
         Wb0OeikfvJU6A==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 03/11/2020 02:52, Vidya Sagar wrote:
>=20
>=20
> On 11/2/2020 8:00 PM, Zhang Qilong wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> pm_runtime_get_sync will increment pm usage counter even it
>> failed. Forgetting to pm_runtime_put_noidle will result in
>> reference leak in pex_ep_event_pex_rst_deassert, so we should
>> fix it.
>>
>> Fixes: c57247f940e8e ("PCI: tegra: Add support for PCIe endpoint mode
>> in Tegra194")
>> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
>> ---
>> =C2=A0 drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
>> b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index f920e7efe118..936510b5c649 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1662,6 +1662,7 @@ static void pex_ep_event_pex_rst_deassert(struct
>> tegra_pcie_dw *pcie)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pm_runtime_get_=
sync(dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pm_runtime_put_noidle(dev);
> Why can't we call pm_runtime_put_sync(dev) as that is what is being
> called in failure cases anyway further down in this API?


Simply because this is a failure case where the get_sync did not
complete. So this change is correct, however, now we have
pm_runtime_resume_and_get(), it is better/simpler just to replace the
pm_runtime_get_sync with pm_runtime_resume_and_get.

Cheers
Jon

--=20
nvpublic
