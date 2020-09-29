Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391B727CE9D
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 15:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgI2NKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 09:10:18 -0400
Received: from mail-vi1eur05on2047.outbound.protection.outlook.com ([40.107.21.47]:2912
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgI2NKQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 09:10:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNRLLgJSewdnK9UH1YZQu9++h6WxYfwtAYG83IN/a3X4kEPsIawgio30N2EwMdl5z/6RtD+rGVmDzaYqjSW65hnmmEALlLcVJ6lMRWvH2nucsRbeAbNn7WEGORKueBuHk7Vj77BXzif7vj9hKrrbbleHtjYkCJJhxq/dMk7nsp1VEwbH3XN+35POhg78G4RDS94Z9G241eb2CB+bM6O2yUZ9w+wA6a4yB1DJYU3j3/2SvBHrUzNLfKke/1W6seytzJm1dnSTeM1uYAiICyItC7RdUf+ZflzwuKE9R1bk2O6ouRMqJimMXN9MJhMNHtvuqUlmQDlKmlqKl19qB96p4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpmea/4IME4+s4xy/0C8l/LHYgDucfLQbgbMZbb75+Y=;
 b=W+JusnnoWTNe4KUMYWoomH0dCyLWKPFrz0OXClmb0HNkXArmNd7ZocvZNlgMHVhxOlgd5VUhIWvMFLtuke3CYa9CnVLKTF1+7Y0lat/0JkCcrQL5YfdOygqF8yDBA1H/4NfuGXUnJ4ErY+kFyQPjb9StCloj4WK5HXSIFPWnGs7exq2+o1JvrZWLKz0t37mtuvcL36tPRJDHwB+wWt4fXjD1hSsO84cSzPIKt0hntyVSUQMSejVL+VWzZ2gy3qtTAw29kbLXgc/nl53yxjGTwtVmUyWjjE/VHRc0oBl0ROWuAbeMJiNpk9piLFuy2t8G4pyi5ATxdVUMfOy2fvsCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpmea/4IME4+s4xy/0C8l/LHYgDucfLQbgbMZbb75+Y=;
 b=k6TV2AEhhYIp9dVd9dbSXaurcccPWiJMPbiwOvTasQQg4KMIIK1elqOXSh/hjQv273qMo203t76qOIMISjLNU/P08I3IuH8XPclt0hXbFUjwgmcwTfj0DsCOL/0gWZb91Nzf2o95zNlOahvvFFrIMisec2Z0cs9AqX7njxZmNFk=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR0401MB2381.eurprd04.prod.outlook.com (2603:10a6:800:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 13:10:12 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 13:10:12 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 3/4] misc: vop: simply return the saved dma address
 instead of virt_to_phys
Thread-Topic: [PATCH V2 3/4] misc: vop: simply return the saved dma address
 instead of virt_to_phys
Thread-Index: AQHWljz3j2hLyZbXKkSFG46wUuvQYal/aZOAgAArmQA=
Date:   Tue, 29 Sep 2020 13:10:12 +0000
Message-ID: <VI1PR04MB4960A4E7D6A72C2CDEAC47CE92320@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-4-sherry.sun@nxp.com>
 <20200929102643.GC7784@infradead.org>
In-Reply-To: <20200929102643.GC7784@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [114.219.66.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21f1c057-2b0d-4801-976b-08d86479000f
x-ms-traffictypediagnostic: VI1PR0401MB2381:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB23817CA3C770EDB2A23326AE92320@VI1PR0401MB2381.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Lf0G7wXiyIA+eJKh6tWhHhve5nCO17/F+2qxy28cSmnyT6zgxgic1n4OP9IjYmFRozzgFZhfrH6nB/epwaB/BK/rt8BgK7OlznjqNYS0t9vwUTc11hqnAACT1FOpSJawxzAMgWa9HjzxJMC59h/aPz0NYDwU/5FNBsw9B4GxpXY3LMMkcPyCSL4OdsZwNhNBLWACF7CjEM9JugtpUvDJy5Qa6d7IP6KJ7NjeHFeSBFIWJcugxBcwnXtUgt700+I9+wo8qMS+6+QDCSpiP51SMbuOcW9MR3B+ZiQUyBeoSMvktYhFqQE/8+2TQ2UKzFK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(396003)(136003)(366004)(4326008)(9686003)(55016002)(86362001)(6916009)(52536014)(66446008)(64756008)(66556008)(66476007)(66946007)(5660300002)(8676002)(8936002)(26005)(186003)(54906003)(316002)(44832011)(71200400001)(478600001)(76116006)(33656002)(7696005)(6506007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iLfmcw7XltXDikUMkyJFhClnx5Hu4ORtVj6pm8rvFar/jkY6+zzMx3LxnTK4wa/mDF6kYWDjW3fwxh8hdMJ5pfJ22UTvXD2Qnx7Ftp8LP/8h2ONgF2H5rFCaPzrVOfKlEo+O9nPDIf9lpjSCyjDS7qhHoJ2dZAxP4nbMhlowu0Ftq0/5kA/IFpxG1onRU85KC3ZuMe8temC1+hJ2rAZ60yxuYLOcOzIGuvd3O9ZAVj1Owtz6jCmUWVIW8iDqfEdvonFQvxd9Dix6fwOAPJbNEh821EnHfQ1PmUsMbWsRLUakzeqDMNOYJQCQ9FvgcV1Xv4pXL/DNN7/Xa5cQhsJKLIFjlmrY01ibFV6/xAaUT+nCKHsLskq5zvworE3m5PX3ysmurjDOSP67uTCb809Pa7tqIyGJzoz2D+vyMG5K3PMotXIP44Gl6N0ywPIa/5cuYAsF40hOh0DT/8kHWQQ1ZLLfQjIyxVQnQXwiGmDW0vWTVb/DP+kIGABfQOIdt6MKr1871qB6aslzsj5GuPAhDKIYZ0I+1XZPv6M3s3wJVAu+RAtdpDzWz0hD2YDuDjh/LUxowFGTl564+DrbBzy4lqJOr+wFhEEaE/+b6CqZy2P9MeSdk3nanJPbS8nLsBi3SURRHAl3HwW18hrXlpKKeg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f1c057-2b0d-4801-976b-08d86479000f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 13:10:12.6648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Omwl+fInuEIAmkwFYko8D3NP/zm8D6LWRmyaMkdjt114Ne8zfTvBAiE1ARzhF8aCoaSLoXbVkXb5gm6npWB2vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2381
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

> On Tue, Sep 29, 2020 at 04:44:24PM +0800, Sherry Sun wrote:
> > The device page and vring should use consistent memory which are
> > allocated by dma_alloc_coherent api, when user space wants to get its
> > physical address, virt_to_phys cannot be used, should simply return
> > the saved device page dma address by get_dp_dma callback and the vring
> > dma address saved in mic_vqconfig.
>=20
> More importantly you can't just all virt_to_phys on a return value from
> dma_alloc_coherent, so this needs to be folded into patch 1.

Okay, will move this change into patch 1.
>=20
> >  	if (!offset) {
> > -		*pa =3D virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
> > +		if (vpdev->hw_ops->get_dp_dma)
> > +			*pa =3D vpdev->hw_ops->get_dp_dma(vpdev);
> > +		else {
> > +			dev_err(vop_dev(vdev), "can't get device page
> physical address\n");
> > +			return -EINVAL;
> > +		}
>=20
> I don't think we need the NULL check here.  Wouldn't it also make sense t=
o
> return the virtual and DMA address from ->get_dp instead of adding anothe=
r
> method?

Do you mean that we should only change the original ->get_dp callback to re=
turn virtual
and DMA address at the same time, instead of adding the ->get_dp_dma callba=
ck?

Regards
Sherry

