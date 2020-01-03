Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DACBF12F635
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 10:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgACJkt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 04:40:49 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1404 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgACJks (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2020 04:40:48 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0f0bf30000>; Fri, 03 Jan 2020 01:40:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 01:40:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 01:40:46 -0800
Received: from [10.25.72.211] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 09:40:42 +0000
Subject: Re: [PATCH 4/4] PCI: pci-epf-test: Add support to defer core
 initialization
To:     Kishon Vijay Abraham I <kishon@ti.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
 <20191113090851.26345-5-vidyas@nvidia.com>
 <e8e3b8b6-d115-b4d4-19c5-1eae1d8abd0f@ti.com>
 <958fcc14-6794-0328-5c31-0dcc845ee646@nvidia.com>
 <c7877f72-97e0-ac48-06c3-8e3ecec87cd5@ti.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <d3c88451-4bf5-61f6-1a13-7176d587e36a@nvidia.com>
Date:   Fri, 3 Jan 2020 15:10:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <c7877f72-97e0-ac48-06c3-8e3ecec87cd5@ti.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578044403; bh=lxSlJ41iIbh4uJmeFdkz6lZkjWHAJbs7nZBmnCeGiys=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HrEuUPilcCFPqsx+GXKKQufqJ4ICbkKRgH5SKrGjsMub0f3k1h+b21ft/C7ikvWZh
         dvYDmYhe5U8coA60KzGEm3J+95L9dRuBvLXxm1wMCagURebpi81YGHzg9Z5MNdFnLi
         KTJ00JKIHzt2lGBIWIzwRVhjR6vYQvBDBGCW+bLJz8Nhd+yYvDQbEdubp/Fg0g6izJ
         J8OMY3hi88MPn0MT/nxx+jFIpSa/IV23qE4X8MYbjUTvPuAUNSO6Y/keeN8Bm/0Xst
         xhbqXZ0kz/DH1OqY+/Y+QZPz1jOHJf/ygLWw9X9oTqaCZyRVf/tMDy0kNOXny7JHXq
         TxGOVk0DlsDGQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/5/2019 4:52 PM, Kishon Vijay Abraham I wrote:
> Hi,
>=20
> On 01/12/19 7:59 pm, Vidya Sagar wrote:
>> On 11/27/2019 2:50 PM, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On 13/11/19 2:38 PM, Vidya Sagar wrote:
>>>> Add support to defer core initialization and to receive a notifier
>>>> when core is ready to accommodate platforms where core is not for
>>>> initialization untile reference clock from host is available.
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
>>>> =C2=A0 drivers/pci/endpoint/functions/pci-epf-test.c | 114 +++++++++++=
+------
>>>> =C2=A0 1 file changed, 77 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/p=
ci/endpoint/functions/pci-epf-test.c
>>>> index bddff15052cc..068024fab544 100644
>>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>>> @@ -360,18 +360,6 @@ static void pci_epf_test_cmd_handler(struct work_=
struct *work)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 msecs_to_jiffies(1));
>>>> =C2=A0 }
>>>> -static int pci_epf_test_notifier(struct notifier_block *nb, unsigned =
long val,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *data)
>>>> -{
>>>> -=C2=A0=C2=A0=C2=A0 struct pci_epf *epf =3D container_of(nb, struct pc=
i_epf, nb);
>>>> -=C2=A0=C2=A0=C2=A0 struct pci_epf_test *epf_test =3D epf_get_drvdata(=
epf);
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 queue_delayed_work(kpcitest_workqueue, &epf_test->=
cmd_handler,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 msecs_to_jiffies(1));
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 return NOTIFY_OK;
>>>> -}
>>>> -
>>>> =C2=A0 static void pci_epf_test_unbind(struct pci_epf *epf)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_epf_test *epf_test =3D epf_g=
et_drvdata(epf);
>>>> @@ -428,6 +416,78 @@ static int pci_epf_test_set_bar(struct pci_epf *e=
pf)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> =C2=A0 }
>>>> +static int pci_epf_test_core_init(struct pci_epf *epf)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct pci_epf_header *header =3D epf->header;
>>>> +=C2=A0=C2=A0=C2=A0 const struct pci_epc_features *epc_features;
>>>> +=C2=A0=C2=A0=C2=A0 struct pci_epc *epc =3D epf->epc;
>>>> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D &epf->dev;
>>>> +=C2=A0=C2=A0=C2=A0 bool msix_capable =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 bool msi_capable =3D true;
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 epc_features =3D pci_epc_get_features(epc, epf->fu=
nc_no);
>>>> +=C2=A0=C2=A0=C2=A0 if (epc_features) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msix_capable =3D epc_featu=
res->msix_capable;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msi_capable =3D epc_featur=
es->msi_capable;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D pci_epc_write_header(epc, epf->func_no, he=
ader);
>>>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Configuratio=
n header write failed\n");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D pci_epf_test_set_bar(epf);
>>>> +=C2=A0=C2=A0=C2=A0 if (ret)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (msi_capable) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pci_epc_set_msi(ep=
c, epf->func_no, epf->msi_interrupts);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_err(dev, "MSI configuration failed\n");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (msix_capable) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pci_epc_set_msix(e=
pc, epf->func_no, epf->msix_interrupts);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_err(dev, "MSI-X configuration failed\n");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +
>>>> +static int pci_epf_test_notifier(struct notifier_block *nb, unsigned =
long val,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *data)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct pci_epf *epf =3D container_of(nb, struct pc=
i_epf, nb);
>>>> +=C2=A0=C2=A0=C2=A0 struct pci_epf_test *epf_test =3D epf_get_drvdata(=
epf);
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 switch (val) {
>>>> +=C2=A0=C2=A0=C2=A0 case CORE_INIT:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pci_epf_test_core_=
init(epf);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn NOTIFY_BAD;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 case LINK_UP:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_delayed_work(kpcites=
t_workqueue, &epf_test->cmd_handler,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msecs_to_jiffies(1));
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 default:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&epf->dev, "Invali=
d EPF test notifier event\n");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NOTIFY_BAD;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return NOTIFY_OK;
>>>> +}
>>>> +
>>>> =C2=A0 static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_epf_test *epf_test =3D epf_g=
et_drvdata(epf);
>>>> @@ -496,12 +556,11 @@ static int pci_epf_test_bind(struct pci_epf *epf=
)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_epf_test *epf_test =3D epf_g=
et_drvdata(epf);
>>>> -=C2=A0=C2=A0=C2=A0 struct pci_epf_header *header =3D epf->header;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct pci_epc_features *epc_feat=
ures;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum pci_barno test_reg_bar =3D BAR_0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_epc *epc =3D epf->epc;
>>>> -=C2=A0=C2=A0=C2=A0 struct device *dev =3D &epf->dev;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool linkup_notifier =3D false;
>>>> +=C2=A0=C2=A0=C2=A0 bool skip_core_init =3D false;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool msix_capable =3D false;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool msi_capable =3D true;
>>>> @@ -511,6 +570,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 epc_features =3D pci_epc_get_features(e=
pc, epf->func_no);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (epc_features) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linkup_notifier=
 =3D epc_features->linkup_notifier;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skip_core_init =3D epc_fea=
tures->skip_core_init;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msix_capable =
=3D epc_features->msix_capable;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msi_capable =3D=
 epc_features->msi_capable;
>>>
>>> Are these used anywhere in this function?
>> Nope. I'll remove them.
>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_reg_bar =
=3D pci_epc_get_first_free_bar(epc_features);
>>>> @@ -520,34 +580,14 @@ static int pci_epf_test_bind(struct pci_epf *epf=
)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 epf_test->test_reg_bar =3D test_reg_bar=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 epf_test->epc_features =3D epc_features=
;
>>>> -=C2=A0=C2=A0=C2=A0 ret =3D pci_epc_write_header(epc, epf->func_no, he=
ader);
>>>> -=C2=A0=C2=A0=C2=A0 if (ret) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Configuratio=
n header write failed\n");
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> -=C2=A0=C2=A0=C2=A0 }
>>>> -
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pci_epf_test_alloc_space(epf);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> -=C2=A0=C2=A0=C2=A0 ret =3D pci_epf_test_set_bar(epf);
>>>> -=C2=A0=C2=A0=C2=A0 if (ret)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 if (msi_capable) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pci_epc_set_msi(ep=
c, epf->func_no, epf->msi_interrupts);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_err(dev, "MSI configuration failed\n");
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 }
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 if (msix_capable) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pci_epc_set_msix(e=
pc, epf->func_no, epf->msix_interrupts);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_err(dev, "MSI-X configuration failed\n");
>>>> +=C2=A0=C2=A0=C2=A0 if (!skip_core_init) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pci_epf_test_core_=
init(epf);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ret;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (linkup_notifier) {
>>>
>>> This could as well be moved to pci_epf_test_core_init().
>> Yes, but I would like to keep only the code that touches hardware in pci=
_epf_test_core_init()
>> to minimize the time it takes to execute it. Is there any strong reason =
to move it? if not,
>> I would prefer to leave it here in this function itself.
>=20
> There is no point in scheduling a work to check for commands from host wh=
en the EP itself is not initialized.
True. But, since this is more of preparatory work, I thought we should just=
 have it done here itself.
Main reason being, once PERST is perceived, endpoint can't take too much in=
itializing its core. So, I want to
keep that part as minimalistic as possible.

- Vidya Sagar

>=20
> Thanks
> Kishon

