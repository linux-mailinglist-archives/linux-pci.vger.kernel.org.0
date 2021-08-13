Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF23EB65C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 15:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbhHMNzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 09:55:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7762 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240740AbhHMNzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 09:55:24 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DDqHQ9014494;
        Fri, 13 Aug 2021 13:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=dbgbHy154TZYdsLU/e9DOX4zBwJzoBOVhtKn0GyIeo0=;
 b=mF7IHBYKGrCO2sroMZ9VruH67zfnFhcAG60nPKXq5oyKz78artbl7oPYzT2o7BMMuqur
 nXdng0qn9qnbmkFjcL+boK6qj/M1Jbz2cfk8o8razVRm8uWMk+LSoZy7LTzSqqzHlG75
 ISjmmxuq4leqkhOu1pmNVW8edh8paPq1S9w9MSlcbgc0sJCJ+bCF3oblAe1xib1oBtN4
 3P0VugIQGy1+kFr19I+XEmrBzx4HZFu6rFXJcb1fZcNRIY4d0a6sHtTDzDF1RdBZ3dOO
 a3KTPlM1yGjiBrqkX7I+dAjc9BkLjSmSo1C6KzEmGiwvQi/BV9+Pwz2Bkj63fIttLMCi 6w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=dbgbHy154TZYdsLU/e9DOX4zBwJzoBOVhtKn0GyIeo0=;
 b=X96V9Ql098Z+MpGIUbn516LaBYySE204dmTED/hNUtCBxRPSTvNWnXGtLNrHXoVebSew
 W3ZLAJ5YuYwI1qoPvA1H5HzYtTX2zsGRMpmZ///Yp68Dt4xhWfTslcHeVX0CN9EISa47
 vilYUFww9tATxpnpxdP+OgWl2yKiwb0gShx8glRYWe3zdqPfKqNo/MizE/1iE+mEQmoN
 ril0AvG2Wimx6NRTYMruQNfg5qxK4IZyNev0GNngAzcF8YFy0X1KLZ91yZjYJ+hTpS3C
 wcCLtWEi5jhzQyqI/Rys2HuGQbTcqLBB21Vv60d7V6iWSyiD7b6xD3Q3/73sdTeVuMuX mA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3adsja82yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 13:54:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17DDoPms187510;
        Fri, 13 Aug 2021 13:54:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 3abjwanp52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 13:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9ZXOBTgw0aol9pcQdRHwmDA4h2ZOCNAEs6rkV7uLfa+bEob1XqdJXD3rI23i9Zom+Pt23HERGcLm5zm/7fv3wqlZwIs+3F1zBus/meQ27BQaj6fATzNYy2hwGL3lp2CQ+gEvSkMZQNVfEN1d08EkEtl65G7KWHPCLugFsZ4+B4eYjXlaCkKaJ04459tpHooKBetO0mmk2SO5v77juLEfEbdOx2/a0RnUbNhPEjmG8KwfOvVOmuZRCT80JahX9BfegFugxNJyu/Wb+xx2HeeNZEMdStDrrU/mBm0k2XZD2w52IY4FtHgPNLnpDpg5q/fRURqJC/3hR8Ul4UD6Beq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbgbHy154TZYdsLU/e9DOX4zBwJzoBOVhtKn0GyIeo0=;
 b=Ex9V5ye16t7rGa3plCxc83zFaRAMzd55FmpKSwlP1qFZcc/SvK3d2/ok6uDtBTXVCMnNLZuXUSUTVdH6ZRb6vEGYY+9I132JcotdHjY/9SHByq7VPfM3VzxGkJ+dIP+VAkicjaiPyvbwj9SN+1zU3ZQuuuj7S4pLosrhvHPDdj5cVLEl8rAHSUsZVnGsB/E0vblbEXLvamMF/BR5CJFy/vVjaI2mS3ipM5PuRY5om7NJtR4emFig5KbM/JCQg0OP2q0XBgqbCxML3hHSE6tY9TDJCVHL0sbsFWrw8JhD6PB1dnGZW+mk+VpWZzhe8bfE6AB/fSCg7mz410neTRDsYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbgbHy154TZYdsLU/e9DOX4zBwJzoBOVhtKn0GyIeo0=;
 b=cEVqOoOB/i75FwXzUs1CtHPJ3+rBGfQmRBJOwaWwvl94XPZHppZFxAE7cv3KhtYKdabfNBdz9LTFIDjtBYhSWvE2jl7vo9cItoDAEpdp3BFrNmSoomNsAKTnhJXLqbcGWTkoBXVFVZww1VHwoNrC66WimwKI7VIa/PXArnEIKLg=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4692.namprd10.prod.outlook.com
 (2603:10b6:303:99::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 13:54:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 13:54:32 +0000
Date:   Fri, 13 Aug 2021 16:54:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference
 in probe
Message-ID: <20210813135412.GA7722@kadam>
References: <20210813113338.GA30697@kili>
 <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 13:54:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f11eb036-f8c9-491d-45a5-08d95e61e0d5
X-MS-TrafficTypeDiagnostic: CO1PR10MB4692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4692C9CB42F0E6BC3D3CD9A58EFA9@CO1PR10MB4692.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EcnMydx2dKDHG6R7xpkFEVKgAbFLOm3F/5p/TCjd2Feq91qRvToZUmG9fRvv2AZmuweXIgrKb2csnT5ajtrNx3VAJozHAm9CwuT/IIYGiJG7vtO/bTaia58lC6y7x3W5o5bAsiStsU2K6o+KwaXhErKGUt9otU6IqPXTvALJpaw5HGet8xx0aBJCiw7NuiAEqFwDjfp2Utr5T0uSPTqQhRiznAfMyvAi2EuzEVZRNgdZlXXyr6x2tenEx9CQ4Fi1LMIGFHvzUagQpU8wVf5p933gxYy16XM1yWI4h0chYsjCTJPg991tqVACyNhtBAxJZk2jOKxFeoU90SJcaTETmX/I2LWitTpiK71XLg6reUNM3bstVjT1i1xxGljnjNMKSM95iWyg87LzLO5lbVDSPmy7RlQ1MPTxl/NhNTcWa5u7sQ/9zR1QVHSxoC0sJTnipeSveTUTtYdWFMilusIjknm3hVEUUcGHmaw2Na+Ed/EVI2FbkyBoZk+syCoZAMyV4cjrQWMlicp1FwIbEX3nmTIgSd/dEx9ovksjulgiIBwyScDaghfpraRxetCaKTFhHRX6JddEFFYsDN4NfjF4I3JIsfciLLk5jbbPfR9DURJAm5OTj+yy+69hUbiG312IIXGS/Ys7/svGy3bH9YRVXmVQQyUoNDSlEZoJ0iirhVvDH5J4DQhvj5G+aoDBdub/k4G4BOwpl0e/v0dcBkFwww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(366004)(396003)(136003)(6666004)(26005)(4326008)(956004)(316002)(54906003)(66476007)(1076003)(2906002)(66556008)(66946007)(5660300002)(83380400001)(7416002)(6916009)(44832011)(9576002)(33656002)(33716001)(38100700002)(478600001)(8936002)(6496006)(186003)(38350700002)(55016002)(9686003)(8676002)(53546011)(86362001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5kwbeNpfufY7gLEmTlMF7k6nvHBa8tmWSIaB30p1gQ6F46QAdP6aU5p/OGw?=
 =?us-ascii?Q?DiLDK7322k2PPEnPrhHgAZii2q9xt17w8FyehgSPUJBjsXKf3bwDcVw2tQ5l?=
 =?us-ascii?Q?b8BDtEVvneYuO+xZCBQhDmeILPOUnq51/gFSJtjFmJbpkRx9jsPEBJ43UdD5?=
 =?us-ascii?Q?Ku4aeZb9+A+d5MLg/K4vc8EWyTvYU7o6C5OUMp8+DsnWrnv9HpL0eC2eTys0?=
 =?us-ascii?Q?ZhE5HCAiQcDDnnF7EqWJLgAGb/SRIrgmyWGYooy65BmS/5SQ4Nu1fA4GSUpl?=
 =?us-ascii?Q?udt8QYrf+a3pEYeKwJb7KWCF0LfHA7YtaeknwaiWLL7CAZeEV0PN47qX0pYc?=
 =?us-ascii?Q?Py3iA3AR3xbGo855kwUe9Lh5UR5HXP7tNyTYRe3RCDaxwHwqOYGpKbrk2B1s?=
 =?us-ascii?Q?mFzE+Zxc1HBxyIXWtuTTHREwnvs9mvNP9sbReq3zItHqlVWXZKvhMeEcQwh6?=
 =?us-ascii?Q?ThXBQGu7NV7v1d0EVuPaH72MnU2gm3y2Q2RF8F8lpwvTJkHUso8esfoXtjzH?=
 =?us-ascii?Q?68y9xWs8A/7oTImw0R5cXg89Y7NxMqnnIPqIpurZBpHqeFZQDmhn89DlTL18?=
 =?us-ascii?Q?EbJIqBd/bo+SqxNQh44Acuw3yY0/yu9diq0ck01n/LUhaMB6yLo+1pCdhTiu?=
 =?us-ascii?Q?eFwbkJ/hK0jZPObVr8beAj4XXUbT358mtT8hEGbfxokiPyxMj3XV3ppCd5sf?=
 =?us-ascii?Q?UY83GoBi9Eq0vNyt59u75EIQtn0350e/KC/IddICEdrAo75JwfFHSrAv/vT4?=
 =?us-ascii?Q?3xiQUuz9MmR2ebK+5GkENEEYm7FnJjp4PZiHnGipPYM6DyeZkk6caigcNi4p?=
 =?us-ascii?Q?MlhiOg4MdbIlaOsM6tCniG4tvCXcL9KTFdSYoPeAqlztAjZ78WjbRXr5GZv7?=
 =?us-ascii?Q?UN8rlMF8KafaJGCKhQr0P4JN1iwejENsRXbIj7Dqir6eNsCmZnWCigLT2vLV?=
 =?us-ascii?Q?6iqLVHOTt2HCLqCyyIxXGvpIhoSwOCfJKEfdcanjNiiTUo4A34IAjqk8IzIQ?=
 =?us-ascii?Q?vhReeVN7mNcn+0eRTFa8QWs0DSYRn7Ud4ZEaQ700DFRhyhbt9a+z8hE4gzlN?=
 =?us-ascii?Q?/1cWODtKQ70nZGbg4lJAWqHEXurmNlq/SJC3gO7mPWq8LGz56m0TKi6oPxf7?=
 =?us-ascii?Q?YLbnKa75t4XQbIB9FDKpatBhTcE3pTNNMERlz94gglg/SZX4QnRw0TgYV4xc?=
 =?us-ascii?Q?yj2Iefewo6XFdRAEePTvrVTbBsrUEMRV4QVEQAiJ7a4N3AKt3pDBCVzltPXC?=
 =?us-ascii?Q?HOFmOAC58Fz1XrtyU/pe8KrN+qogs/Rnk8PaHjfS1aPvzzZ0VTtKaiyb15dT?=
 =?us-ascii?Q?InpP42mGF8XdkFlBiukV4ygl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11eb036-f8c9-491d-45a5-08d95e61e0d5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 13:54:32.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PA+KGrqZuiNLFYm5hz/IHzYVBwUF/Jd/kIecQ6UBRuWeAc/kjEmvHWaG8B84rw7f7i7v0sWjq6VvU8MThNEnkz60UPEPqMKWRyV9E7e1IMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4692
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10075 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=661
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130083
X-Proofpoint-GUID: xoC5Koz6J8Lok4CuNP02rr3nM0QkUr_D
X-Proofpoint-ORIG-GUID: xoC5Koz6J8Lok4CuNP02rr3nM0QkUr_D
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 01:55:38PM +0100, Robin Murphy wrote:
> On 2021-08-13 12:33, Dan Carpenter wrote:
> > If devm_regulator_get_optional() returns an error pointer, then we
> > should return it to the user.  The current code makes an exception
> > for -ENODEV that will result in an error pointer dereference on the
> > next line when it calls regulator_enable().  Remove the exception.
> 
> Doesn't this break the apparent intent of the regulator being optional,
> though?

Argh...  Crap.  My patch is wrong, but the bug is real.

This code should follow the standard kernel idiom of returning error
pointers when there are errors and returning NULL when an optional
feature is disabled.  The problem with returning a Special Error code
to mean "disabled" is that someone will use the Special Error code to
mean an error.

And that has already sort of happened, because _regulator_get() returns
-ENODEV which would will cause the Oops I described in my patch.

Ugh...  The correct thing is to convert it to NULL/error pointers.  I
have not looked at how hard that is though...

regards,
dan carpenter


