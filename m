Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8906ECB4B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 13:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDXL1v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 07:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjDXL1u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 07:27:50 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E75A3598
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682335665; x=1713871665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dMoq3zlSvN871DkucBQg6OnIq4strhZHohZq66NsnHU=;
  b=SIio33PrFsKixTssIVZECemJi2NETa874Ap7n4sRbE7IFCRbl/yxbbnu
   iBuFvt4kndHju+Czrx3HgTSF+hUjfD6Le+XiMzfCrQa4VNGBqClD4jQLf
   ebh4pk7vx3PcZRE/7U7lH9BQ580PbVCAUQ+uu1TUoTAacp2NnxzurJmZ6
   ubidrcB9/TUuJUKcdbcfTCr3QoNP83Kzsz4Dkl1Orl4gcvnOl9T1FIbWx
   Sabpr8XEbFc67lE2MyiaKI8ddEzC89ndhQeSzasMN6KcEcz0X11kca4cZ
   DgUHAlcRqluoqkMRGjBtB4nhRAjNgTp+ssrsAvJq9UJ2TmvRhgSN5IkQ/
   g==;
X-IronPort-AV: E=Sophos;i="5.99,222,1677513600"; 
   d="scan'208";a="229048878"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2023 19:27:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVIKv/dQuBzTwXAdq4OWfg+ZK6BJkC+k0k5dQFVUGuAh4qdb5yKuBxNCE/Mq513uDTlP43HNU3JIUXKH6d1lW/QAHXCb1ABH+izaGiT+hPIMCOf/NR7VWaEuvOwGIiOEQiDG9QrHCSoEh6JqyFZzOmET2kE5wkrdFibDCcQqBYjU9/ysOTxYcCQikALEvRwtE7nIfuIWUKSYwiewn9xif4ycKGXZ+TykO1bbsxdiX071w3wiTIpOu50UK04NomGOPTBz2J+PF0h3LAnZ9gEKl7kdyd+1mGDufTKEu1ave5MzQngUYfP3aSHs2qhnsK2oe5Md/sDRROqXVgg5Va+GRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcWJjAYwpIf2H0PBoUbbwFJn1EcN5fxFZsXTjLUa4wU=;
 b=jKYkZn/zDV6x0iXZYOo5TjiIZ+kFwUxq+VdRnDlqz6He6dVoc5HKP5URP90O4okWmA1apWrkfkXr4tQBlYkrMVgy/ZGLUC4OxXRpOfifJ+jzMNdSKm7r82NRh+ps+cyJhlVuH9LlJ6NdQktkT3wLGdPXhBf+x8+51gIYkcErCHrtye07D68J8r1d3EQH/JTerTECCngxjEEDSNHlhf9YCuYiGPKjwLgn6v8O1H+D5zYBwisy05HaQv27Y6tWX1ror5YdNQSGd8YMvgHksWOk+BBM+b/NWvMu3wKuMcj4XLk9hcTQsQDLpwQmgKYau+nutUeTaMMvvu4BLSEee1B0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcWJjAYwpIf2H0PBoUbbwFJn1EcN5fxFZsXTjLUa4wU=;
 b=be9oFCZ0icrWeh873hchJDV51zlJ6S/6Ojd4OIN3BXGx6VdOLwrhq50NNB3V2VTFoz/lx5iEGo6MXw0RF56Jll9bJIOp+1XWOqbOZswIJ1SBl0FPXyawcjhUJNz6TzhvWojjG7m0MsVdJjY/ZvIIz7Sv8xXKZ+D3TcQxO1G2DbY=
Received: from DM6PR04MB6473.namprd04.prod.outlook.com (2603:10b6:5:1ef::23)
 by BN0PR04MB8080.namprd04.prod.outlook.com (2603:10b6:408:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 11:27:43 +0000
Received: from DM6PR04MB6473.namprd04.prod.outlook.com
 ([fe80::1266:7025:2e4e:e4ea]) by DM6PR04MB6473.namprd04.prod.outlook.com
 ([fe80::1266:7025:2e4e:e4ea%7]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 11:27:43 +0000
From:   Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Keith Busch <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Grant Grundler <grundler@chromium.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: RE: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730
 WD SSD
Thread-Topic: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN730
 WD SSD
Thread-Index: AQHZKdjydF/vmoLqekqeVIf5E6S3m66ixGcAgAAlMGCAhEjYAIATtMrg
Date:   Mon, 24 Apr 2023 11:27:43 +0000
Message-ID: <DM6PR04MB64739F4EE26DB3E95BA8D1788B679@DM6PR04MB6473.namprd04.prod.outlook.com>
References: <DM6PR04MB647368572FC2A56C2869B1758BC69@DM6PR04MB6473.namprd04.prod.outlook.com>
 <20230411221504.GA4180865@bhelgaas>
In-Reply-To: <20230411221504.GA4180865@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6473:EE_|BN0PR04MB8080:EE_
x-ms-office365-filtering-correlation-id: 8def8c00-2c0a-487f-a296-08db44b6ebc1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6McT4OH0F0bbh5K/xwNw9Bex2ENA9e1ha7zh6mZq+5aUtxvy30RfEK9RrrEA9AFfy4tOAXwSjY4ibfMyDpRaZOfF9knXe6G/1fdgYeejZoPsy/nsnfZhBkOr9xCHmzW9qPCYIlvs++TjbH0AsHTU7kL7xKx7xeN2TMyRlw/HfnqsuKuymojYa8sOxANc6LIOT8yZRpY6q/+XeJcIDSNlbXhwz3Lz0HP5UW5RQ0froOdjUtb+snNZfU3gBfgORDgcJpXyEZ9/Jm5g9ZkD0x2aeiBcsr4lKBBuWzgxYqkgrbSbSVrfPu71AqxIonfx0U4xd/V+hxXbYzf7odOBGLtrVDqfdnUI0MYSRIfEc/FQE+rq7A3ProxLNDh9Qlj+0c7aN1IYnWCl7M4q/X85ZW2AJejM33n1sJ1bR5QUWIK/5+D7VL+/HfbdBOAxsA94CDFN6VvwlTtIV4R7M8CrwVrSjrmv0etg6F36B6EhqysRrYdDGiaCmjPtQ9wP2QnfWc3PmpIDLb89uHHdCk+LakslDaFKZB+OWOGsl2USEGl1Jl3xMXXAzXfu3PQvHFRdOs7VV8RLKENvX/s8oFBzgBNtX1E5mspsXystRW4m5R4F7Oo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6473.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(2906002)(7696005)(71200400001)(966005)(55016003)(9686003)(6506007)(26005)(53546011)(186003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(316002)(41300700001)(6916009)(4326008)(478600001)(5660300002)(52536014)(54906003)(38070700005)(82960400001)(38100700002)(122000001)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U3CICymsPDAMBY8lha3+/3kQZ6IludIoEDEyOLJ15VypCGbAOEyvkJBoclGZ?=
 =?us-ascii?Q?WRtznhcLFJmJErCIZ1siKWq1q+SgQSEhHUj+i7KsJTBDTIOvy3lLlg/W9Bx9?=
 =?us-ascii?Q?evQnrljCXQEbSHdtLiILRGiHrlvJBK8R/0Vu/IQ3NtlqoQ8KGdcow61GKOdA?=
 =?us-ascii?Q?g0iz3aB8YEzAgemHg6sYibN2Nxzq1sMkXjP6QJi4Ks2nMQ2hqt4AzKZrRyCw?=
 =?us-ascii?Q?htX/SEOQfZpFjiKJFbs0OxcwHeVfGKZzmR17tXFpbEfqJQQz7FpCnYi4N8hj?=
 =?us-ascii?Q?StTBVKT5jkVdPdjhKclei3vnPlb1ICFUvFFT3uqRd/7I95F8bqM7uoUGHtfS?=
 =?us-ascii?Q?th3rI1pqGzlEyIgs1sDY61Vkd7IkDKJ5dqL6TtTxCfVDlpW91kUXNvw9SHNa?=
 =?us-ascii?Q?Xo5b/G95cyUY4KeTc67y0jZuC6OpOPt6SpnJRKdlcBfcEWsgETyifM35yE4X?=
 =?us-ascii?Q?qlAqvAVTC0nP3i9oKeWeyklwcL0gNKJWIA2y3/hFxXYbj+aFqDLaaFro+KBH?=
 =?us-ascii?Q?GCeR0zWYqnEtynpibHyBg5ZZLpfVQLde18RG8SmuHm4JDkhPds5gf59glnOV?=
 =?us-ascii?Q?won397IAAwtCPSfsjqt1UNrshWGtJCRWFltZvSfBEJ1HykHdtrshbDg0SCxv?=
 =?us-ascii?Q?agC+WK8R2gOX7YM5/019N6RJwjCUNOCuwsnMdznsCWSU/D5VHsvN2LNtYgPS?=
 =?us-ascii?Q?1a8jxh1UNgTsKjnF8SEzCtn/E+OBS7Z+XYXL/gLrnwYTOTclF6+b9ughUQ++?=
 =?us-ascii?Q?54zvGAx/fnwqbh+zjmjI4u+MHVum3TZR4mnIiMZ8aqHLmBcapacdiSOi3QJi?=
 =?us-ascii?Q?tWTRCyjIdn1bP7K9kr6KTlHCab5Kw67+7lel6C1LNxZxyaKZcqAq2GXXpqhX?=
 =?us-ascii?Q?XTico4FBj4Eqj8OiLVsNtAtVplCamZxRQnQ7TFGDNErNhnxVKWHmVNJP83+T?=
 =?us-ascii?Q?1K8AN+tfjW771CAij3/RrtfqFrliijHRVy/WFr0/w4REw5+Pp8FB0vZYczq0?=
 =?us-ascii?Q?HovOgt78d1pVqyFLqFjMJZDB7EUGyiFDq0flcR7M8xg0vDFAQzqNjtz3mFCO?=
 =?us-ascii?Q?qI3fSlwYWChMerTDNMSylxBvv4/1SylB0JqLSNLbRA2gMxr7+wTnhgNCzPuU?=
 =?us-ascii?Q?tg3oVEaoXD5eMl63+5jbc0NomrzLKTENVYqdFvRy8IvGqEtWSf36bo6yKk2J?=
 =?us-ascii?Q?dkAadYL/pLzAmfKe9K0dv2rSO9Itm6NWi4UuxpQJjqoJ81kBWrWwvKOrM8YS?=
 =?us-ascii?Q?GYdaUKSTJEtR8I2jLLC1ZXC1oFzPg9bOy7vcD6j0QfGYLGoqBzz5JkXeK+np?=
 =?us-ascii?Q?uRqJWwGUUdrb//CiDIYmy25w08W4f2ryLwN2kukDj9JxtyqQyg35Di64dAfy?=
 =?us-ascii?Q?8w+fSCc8pBvpbXnbj++2RPdARydjh40yZyBZfQU8Vz1N5CPu9xyQtgM8VfzT?=
 =?us-ascii?Q?ZZV5WidmIT/OQRYheYSSSZll/UnCIXNEHptHdndUdOwvTe4MnZMySZVYllvf?=
 =?us-ascii?Q?Sl+9e/69P1puAksfE2tAvf5ft2fqiXM59HKX1tuTRFVI9i7adHHYLOGQfJuX?=
 =?us-ascii?Q?0lcPNg3vR+uwdSCBEhqxX1Ub62KhCOyWPGdFiZVv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?c4s3G4B6OAo6XlhiZp0/ucs1zVUfBUtTWxmFY0MNyJDLBED6fNFNEarKUS+b?=
 =?us-ascii?Q?6IYAzgxJICeCVeThsXOaxyT4J6avonesOLBUzHsFq2ozEtn6g3L3Ga7W/Dnc?=
 =?us-ascii?Q?GU0hz3B4OuvDwpc35z3ps9a/6gVu53s2Ln9bFqSuTMvfFP42dlw+k6aWAZge?=
 =?us-ascii?Q?WHmCYam7ZOevUHXu37gmc+cF0HYFxdRxVwgNCs0G34a7nsluiAFOfdoF/cFN?=
 =?us-ascii?Q?H4lcUMAdfuxCIUmJtYUU+W7Nzx3oB0V+ocI+fMFi9mmanZkgmSKnksNE/oAp?=
 =?us-ascii?Q?WzKVmDCknbC3RWQq/O68bBzfiZ4IQyzZLxqFMcMZjJS10fNOwO4HhT46lyoV?=
 =?us-ascii?Q?7RbCB2CP9gewaF6NqpyHAVcP+/x5rYlnQES/iJThCc3pSwMvx+VtXZ2KOJuS?=
 =?us-ascii?Q?iD9TPz87St0bV7pJkl7Kl9qy+0IYDseFclRpv1HKWNKoJKB5dad+HbHZzRNd?=
 =?us-ascii?Q?yxmyO36ktMCXkjR5jNFLVxQqSi2uvWCVk7XrYreeygEaeHwVhV3PgS7z4PHe?=
 =?us-ascii?Q?9VaEN7qPnWE7CCHAbEm4KBYlKwEMy5iwSyWuxQqdxxLju79pkBrEAtTDpZPr?=
 =?us-ascii?Q?xiJyh79iSoNEk0PirwIn3tqzwaWrLUjZ7vUZumV7OzSfYRUZNJAe9qjmQ0CO?=
 =?us-ascii?Q?+LjAHiwelX+s6xaBkm8Ts8SKltqL/U5Ki2dgmXyYkK1IlJeXQK098Dd1senB?=
 =?us-ascii?Q?UwvNX/9QrhITRE8JwXgzMn3c4GpMoHWpG9COb8X8E9J+TAm4fOS5Rs/x584x?=
 =?us-ascii?Q?FTh1qn/1VA7tLLlFQb9i763SESDmfoRf3GT+L6TdYtGMaJqA7oBPh+aCVqsf?=
 =?us-ascii?Q?KTHy0GceqADL+bFRWvLMEhvO7yAJh9MPm24362yu5XKEPaZ0A6rnazU2Sth/?=
 =?us-ascii?Q?4jKxnTbGQmtqh5CA2Nsf+2PgATyKDmO5IO3FV78+EXOrQOLLYNDz6dFxYSi+?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6473.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8def8c00-2c0a-487f-a296-08db44b6ebc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 11:27:43.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRmA5dK/INA+Uj5fASndEwY+6CQnqlYdc6I7UdboKfsvph88U9ReBCgcdzjdsV3CI/J9/G1EM3I6s/epVefEYVmpV7dbbLXtfZUdrJ39xsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8080
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

Sorry for not addressing your questions earlier. As you may have heard, WD =
experienced
a hacking attack which left us with no access to the company e-mail for wee=
ks.
As for the patch, no FW change was an option as the product causing the iss=
ue was
basically at the end of life. So, I prepared a workaround that took into ac=
count
all the comments from the community.

Yet, at this point it seems like the company has lost interest in promoting=
 this patch altogether.
So we could just drop it. Please let me know if there's anything I need to =
do to request that
officially.

Thank you,
Alexey

-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org>=20
Sent: Wednesday, April 12, 2023 1:15 AM
To: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>; linux-pci@vger.kernel.org; Bjorn Helga=
s <bhelgaas@google.com>; Christoph Hellwig <hch@lst.de>; Grant Grundler <gr=
undler@chromium.org>; Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI/AER: Ignore correctable error reports for SN73=
0 WD SSD

CAUTION: This email originated from outside of Western Digital. Do not clic=
k on links or open attachments unless you recognize the sender and know tha=
t the content is safe.


[+cc Grant, Rajat]

On Tue, Jan 17, 2023 at 06:15:28PM +0000, Alexey Bogoslavsky wrote:
> >From: Keith Busch <kbusch@kernel.org>
> >Sent: Tuesday, January 17, 2023 5:55 PM
> >To: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
> >Cc: linux-pci@vger.kernel.org; bhelgaas@google.com; 'hch@lst.de' <hch@ls=
t.de>
> >Subject: Re: [PATCH 1/1] PCI/AER: Ignore correctable error reports for S=
N730 WD SSD
>
> >On Mon, Jan 16, 2023 at 06:32:54PM +0000, Alexey Bogoslavsky wrote:
> >> From: Alexey Bogoslavsky <mailto:Alexey.Bogoslavsky@wdc.com>
> >>
> >> A bug was found in SN730 WD SSD that causes occasional false AER repor=
ting
> >> of correctable errors. While functionally harmless, this causes error
> >> messages to appear in the system log (dmesg) which, in turn, causes
> >> problems in automated platform validation tests. Since the issue can n=
ot
> >> be fixed by FW, customers asked for correctable error reporting to be
> >> quirked out in the kernel for this particular device.
> >
> >> The patch was manually verified. It was checked that correctable error=
s
> >> are still detected but ignored for the target device (SN730), and are =
both
> >> detected and reported for devices not affected by this quirk.
>
> >If you're just going to have the kernel ignore these, are you not able
> >to suppress the ERR_COR message at the source? Have the following
> >options been tried?
>
> > a. Disabling Correctable Error Reporting Enable in Device Control
> >    Register; i.e. mask out PCI_EXP_DEVCTL_CERE.
> > b. Setting AER Correctable Error Mask Register to all 1's
>
> >I think it's usually possible for firmware to hardwire these. If the
>
> I believe these options were discussed but deemed non-viable. I'll
> double check anyway
>
> >If firmware can't do that, quirking the kernel to always disable
> >reporting sounds like a better option. If either of the above fail
> >to suppress the error messages, then I guess having the kernel
> >ignore it is the only option.
>
> This could probably work. I'll discuss this with our FW team to make
> sure the issue can be resolved this way. Thank you

Any resolution on this FW possibility?

We have patches in progress to rate-limit correctable error messages
and make them KERN_INFO instead of KERN_WARN [1], but I don't think
that's going to be a good enough solution for you because nobody wants
to see even an informational message every 5 seconds if the message is
useless.

If firmware on the device can turn off these errors, that would be the
best solution.  If not, I think your quirk is a reasonable approach
and just needs a litle polishing per the previous comments.

Bjorn

[1] https://lore.kernel.org/r/20230317175109.3859943-1-grundler@chromium.or=
g
