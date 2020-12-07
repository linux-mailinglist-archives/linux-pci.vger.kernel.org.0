Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA202D08E1
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 02:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgLGBcF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Dec 2020 20:32:05 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31463 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgLGBcE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Dec 2020 20:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607305349; x=1638841349;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bu6jxmEeOwMrgO5yXsEdvXni/XDqEbcu7FHinQy6SJA=;
  b=TsZ4rMXTU0fzPXPnUm9t0nw6RGl5Ftws1heQsyS35WF8o7mZ/cjhonXK
   kOjg3mLXljBCgVTIzR2E/tfjDBGj4lzBuxpR0DOyPe8AAhwijoccvkfLf
   Gn+gz4ztnxr0/3SVkT36mDU+D20WCDQ1Q2BcrLEG4WrydQ6/DlXRv/h2k
   wtWce87UPJeb9B38BTigBdZ4eHfeCqDKEQ/2dt+c/HGrrYHZUHg/9kz4B
   HXgmmRWgx0zbfpNREqdQHhKQ2WsX4h13pGxF8PHozF9YXauQiMOyWl5ox
   vVI8ZM/k+fMheY8R5sgWjgLweHlSQfcfRgEMk44UsozHYqn0+WpzemptY
   A==;
IronPort-SDR: 3y1cmHjHumv9HhyoolTtUqsOZ1xKpb9fN4ICqdX0Dzkb9Rvo/7sR9rIuEyBLy/UD7/e8IaR++D
 oZ3/CCUGjYh33uxusChnu8PQ0rpYnjt8dsqoFCz+LVOf9DCpJ8604hhVIoTV6sOoZmQngeDBeR
 Zq+z8HwGFFdCm7iBC/rxzOgW1wBhpLdJwnJ+JdrNULIYGIum4CfeSVO9snC4sLIuOgnqqHP6bP
 1YumZsKCe6UvtffwzgOD13qOwJSPVzAen27bqBU4D5w1SmJaCy4lWxYj9TTPzrSGVEfRFy8a3f
 2gA=
X-IronPort-AV: E=Sophos;i="5.78,398,1599494400"; 
   d="scan'208";a="258273037"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2020 09:40:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrFG0Pbp/dX+B7ao2l00TG2Gp7AACmuF/3NWr5hHi1CvLADRFNEA0rOwGgpbOBektvAzqcP6Qkun3w2Qy8CptFkgy0L07st5PkkV+mvgUM4YquPz1AsV2e0Q+HQ5FvUiSOhQ97n6+caMm/Huamz5AzMP0g9o3eWhZ5MFL4JQWe+cMmBQsgse4oyqpk9gQxeSyNGv3An4Jk1k/yYJe2i9MUyiVWXuPmenOd6yvu/z7FOO8/OfcDgjH3yvBScJjLTbZQoMZPHL8bNSNHru9DiJD8bahBATkNGy+flb97LyYDcN04+pvsuGZXQ4Oz9ftpRlDIV0ON7NWUaN2NFkPzdUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89H0gZ2cPYvJzYBHeffRnyzMJCgW0e6US4IwbwqelU0=;
 b=X2nAfbh02GqAgYrn/xpjbkxTsjTq8TOluauid4VDO4WFNSBbckeO/44BtEIh83g/sZ5AOsuNy5UdxS2ROXkw+ey6FmU6FonBOA0R5826++mjYyxej/nQ1AC9bGWbugBb7lhqCJDsERDUeFUAnQDq2tG3uw13IvDai9bxynsyiJEHMxs4J6RHnyjlTmEbbGy0OwRpWOEfTkdUlumgYKMtLyHcs/pzG0/zTOCTislYBDs8EImbmDCRNwLYtxowFCx26s5Fw+CnxkkmV79cgN3wjdEoI4b+sHI/NmFWLvVurpBLfUXytvbIkvfU25dvo8BoeoL1Y/7Inza4kV7d2vjSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89H0gZ2cPYvJzYBHeffRnyzMJCgW0e6US4IwbwqelU0=;
 b=rErnNCzq96/ZVymxU3I+QOjxsz87pGinhDrr5YKVlBbqPKd2EBjCCqpeQAU03L94Law4aFixDdaitvsXeuvB0qYlS98IVJfgnjXgPtT9gO0jnbfKWlj2AxUFCRU9aklP2744h0e2Cfg/i81n7fVPrpD0YwBvFWzAC9y2Fd+4NkI=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6556.namprd04.prod.outlook.com (2603:10b6:610:6b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 01:30:56 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 01:30:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
CC:     Puranjay Mohan <puranjay12@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
Thread-Topic: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
Thread-Index: AQHWzAgLm3ME/cQOmkKYlxTZoYgM2w==
Date:   Mon, 7 Dec 2020 01:30:56 +0000
Message-ID: <CH2PR04MB65228D22105F039C046096A6E7CE0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201207012600.GA2238381@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd614fce-a8aa-4002-69fc-08d89a4fbeb2
x-ms-traffictypediagnostic: CH2PR04MB6556:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB655644E9602CF2A9100F24DCE7CE0@CH2PR04MB6556.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a2YYxYQIePe8xel2clMDSwjPOvnNf4lEa7ReZmQk1EU1xVX/e8wM5AtUAeHmRmeDJtzWjuB+oRohcdq9NGk4uIMC4qW2Fqpi/hNloj6KOMkI7CGDOrQSOT5QHY8xHih4X6jqQmF0dEubPTIKj50lxwpgqFpGWDdSHh9OggyZWJKy2xgmM4dV27RlhI+OI3cHA9XNQ15CZMImk3LLe4M+PjyeIh8Vrko757V0Jpr5nQZkqcVxMQxtq6O/FEZaEnjfs0REN+Cq5sCGC/pwtzR9Rzq7NKNdo1AYXsKMlFRg83xEuF2kFkQqFHN42utornJmRLgUBf8QRMz6oxu55FNp0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(316002)(83380400001)(6506007)(55016002)(54906003)(478600001)(33656002)(86362001)(26005)(53546011)(66476007)(71200400001)(186003)(52536014)(110136005)(76116006)(8676002)(7696005)(8936002)(64756008)(9686003)(5660300002)(2906002)(4326008)(66446008)(6636002)(91956017)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Zzpv7JCm/mB+hHHynKTxVtEd+zhHkuVpNUgrX2rXl54DwYuAsZJSnlhD4sKK?=
 =?us-ascii?Q?CPtoLCx81i/ZxNRA4qoXaRZqWtwANSZnq3KJ7Xjhz+QXt590tngBtelwy8NN?=
 =?us-ascii?Q?l/Mym1eiC8rP4tWLy/6rFRaOKFLA+Y+F9m1sjRTeXVSvsHxUxC6h9dJSzYdX?=
 =?us-ascii?Q?WSyQVsYrSSWRxmL3Pba2nxXsigHV0uolD23s8Q7bmpd9LRI6g4lXLaN39kpT?=
 =?us-ascii?Q?GBMOW/I/k+bRKP6WUFnkA0ZCYNjoas03dw0SQDQXO40MMvK3Ex59jqhHQ0V4?=
 =?us-ascii?Q?kRBKRROOKPZIpKuk2Lxaisy4f50+Z9w+8L90K5FJ+MtxYJkFOP5qJSDBAfAO?=
 =?us-ascii?Q?Na74U7Oy9+L8tQsvW9/FdP/tWyAIAfk6Am+FayXki3+CFQja0JkvoApD6l6Q?=
 =?us-ascii?Q?tDQJAZEGYY56qTd/FDwxhgWrnccbo1djDAtXLUZYMaC+dViqeBoz69Ov5GBN?=
 =?us-ascii?Q?Vrmw96TEywOInhsgd6mI6StB5Yo1QqUlhAfAuUBTYGLNwcJGoHOv6Nh6952C?=
 =?us-ascii?Q?8XcqY90AlTBr9gxRZU1YeAUcVYRck/dQlqEy98eZyJz+cz/kdjceG4XP3gXy?=
 =?us-ascii?Q?qTe9XC7iOnMNVSqwN+BOgMVxGjlqLcjFTfuH8FXbmAmTxmpgrIQwdU5f/CMv?=
 =?us-ascii?Q?imKA8Uo93a6LPG3FY85eJHGi7omjyey8irlGo6L+pCpF/hxblt7EYNExp2fB?=
 =?us-ascii?Q?DgeQxqqpAM63AucLB3WRtlRWxUGySjDvXkTa2ZFJCMtJDJNbKsUHM6IBdchm?=
 =?us-ascii?Q?RPc4SQgv3OBDosTz8ER+upvUpwZGSKdaCGfPelToLlls7okmDVcO3+y9w58p?=
 =?us-ascii?Q?y5W0d6HG84liX8+8k7XYOKRVYN/7T/3k2/twyiHy0zPC4NsZTbf8x/A6Opfm?=
 =?us-ascii?Q?dsSnGZ6TvycS3HKRDFzCDn1R74S0yI8w36EQvGjwWnw4kPwhtWrfhbX2eYAH?=
 =?us-ascii?Q?jLjKYY5V7NpwrxsFXokASM2hniixt8CJ3kror7Qz1lDDOcHZGgA8RlDeiPoF?=
 =?us-ascii?Q?J47P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd614fce-a8aa-4002-69fc-08d89a4fbeb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 01:30:56.4416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTULFDcdNWxnL2UoF0jDoM0+diUdF+Bw+qxohUDz622gXE0Jfv7au/d1shB54shL5/pzWjBBDtIshyei703hmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6556
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/12/07 10:26, Bjorn Helgaas wrote:=0A=
> On Sun, Dec 06, 2020 at 11:08:14PM +0000, Chaitanya Kulkarni wrote:=0A=
>> On 12/6/20 11:45, Puranjay Mohan wrote:=0A=
>>> Callers of pci_find_capability should save the return value in u8.=0A=
>>> change type of variables from int to u8 to match the specification.=0A=
>>=0A=
>> I did not understand this, pci_find_capability() does not return u8. =0A=
>>=0A=
>> what is it that we are achieving by changing the variable type ?=0A=
>>=0A=
>> This patch will probably also generate type mismatch warning with=0A=
>>=0A=
>> certain static analyzers.=0A=
> =0A=
> There's a patch pending via the PCI tree to change the return type to=0A=
> u8.  We can do one of:=0A=
> =0A=
>   - Ignore this.  It only changes something on the stack, so no real=0A=
>     space saving and there's no problem assigning the u8 return value=0A=
>     to the "int".=0A=
> =0A=
>   - The maintainer could ack it and I could merge it via the PCI tree=0A=
>     so it happens in the correct order (after the interface change).=0A=
=0A=
That works for me. But this driver changes generally go through Jens block =
tree.=0A=
=0A=
Jens,=0A=
=0A=
Is this OK with you if Bjorn takes the patch through the PCI tree ?=0A=
=0A=
> =0A=
>   - The PCI core interface change will be merged for v5.11, so we=0A=
>     could hold this until v5.12.=0A=
> =0A=
> I don't really have a preference.  The only place there would really=0A=
> be a benefit would be if we store the return value in a struct, where=0A=
> we could potentially save three bytes.=0A=
> =0A=
> Bjorn=0A=
> =0A=
>>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>=0A=
>>> ---=0A=
>>>  drivers/block/mtip32xx/mtip32xx.c | 2 +-=0A=
>>>  drivers/block/skd_main.c          | 2 +-=0A=
>>>  2 files changed, 2 insertions(+), 2 deletions(-)=0A=
>>>=0A=
>>> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx=
/mtip32xx.c=0A=
>>> index 153e2cdecb4d..da57d37c6d20 100644=0A=
>>> --- a/drivers/block/mtip32xx/mtip32xx.c=0A=
>>> +++ b/drivers/block/mtip32xx/mtip32xx.c=0A=
>>> @@ -3936,7 +3936,7 @@ static DEFINE_HANDLER(7);=0A=
>>>  =0A=
>>>  static void mtip_disable_link_opts(struct driver_data *dd, struct pci_=
dev *pdev)=0A=
>>>  {=0A=
>>> -	int pos;=0A=
>>> +	u8 pos;=0A=
>>>  	unsigned short pcie_dev_ctrl;=0A=
>>>  =0A=
>>>  	pos =3D pci_find_capability(pdev, PCI_CAP_ID_EXP);=0A=
>>> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c=0A=
>>> index a962b4551bed..16d59569129b 100644=0A=
>>> --- a/drivers/block/skd_main.c=0A=
>>> +++ b/drivers/block/skd_main.c=0A=
>>> @@ -3136,7 +3136,7 @@ MODULE_DEVICE_TABLE(pci, skd_pci_tbl);=0A=
>>>  =0A=
>>>  static char *skd_pci_info(struct skd_device *skdev, char *str)=0A=
>>>  {=0A=
>>> -	int pcie_reg;=0A=
>>> +	u8 pcie_reg;=0A=
>>>  =0A=
>>>  	strcpy(str, "PCIe (");=0A=
>>>  	pcie_reg =3D pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);=0A=
>>=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
