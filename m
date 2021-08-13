Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D423EB697
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 16:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbhHMOOD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 10:14:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9198 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236081AbhHMOOD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 10:14:03 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DE6Dvt018563;
        Fri, 13 Aug 2021 14:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Nw2dSLUFcEFKl6hPz9ufZns4hOuytLhNmDyh8lfk39s=;
 b=D8288bh4QCzBo1T6cpouuseJMIS4u1Wddpqti5K5y9uh2xQcfzO20lJ5g0dag9JReht4
 Rl4K34l2jQ82IwgiHLRuZqIZkqNeYYOdJ1x9C1edGPVWOBKc/sQpeo8+V4BhM+dd4S92
 zJHZwGF4YS9ldgChNYXS0p1H7yWJiaqMSmtCYCgSalLuOOslbbnvwHBp6Bd5cTcczVE+
 QcnnrNZSmB32t5JlRUS5wvlQTZ8eVzb8zT9hlZ1XS8b40HFgx0IzagkhU3xB9z5Zk/RB
 i+5+YtqsRV/9KeK1n2YkCsPq4BuHvTzq/aJVOgO3jp8TifjBEL7XEcwbp6g49GxvwI5A Rw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=Nw2dSLUFcEFKl6hPz9ufZns4hOuytLhNmDyh8lfk39s=;
 b=PaF0HusMLRuv0xRICsOmsM/HvitBQ1hJogYrYNj2G/Bf3O7FFxUBvTnFsfCaHI5Kg+aW
 AE+QSarh4Cp5xNTx/Kk/ZECW6lK76xdfQcKBOPVZhXCr4uUsgBmx1CZnwWefkb0d4+HR
 RoIw5S/xCxmgY1hkZqWfIT6KVVGf7gKP2Rg4IwSko0scgumFtCIdfJ64QzviKjZsYvDb
 AFyr3EaX6qrJvX8bdD8pRyZV9lnpkh1ci2snbVTTF9k/1YGW9VyynyBIDPvYPKRw2PZC
 qwOFygOEl02dc+ULulPsYEhBXb+IS5YeMbB3ePbEH5+sNxY01Is/a+7hGXYeVI2/OmD8 Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ad2ajjym2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 14:13:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17DE6TCH074356;
        Fri, 13 Aug 2021 14:13:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3020.oracle.com with ESMTP id 3adrmd5uk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 14:13:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnsiZV14Zh+VnRcJEdu/qyzTvvqPNjx2t2iezh7eUcMrHQc++o0PyszCSs+UZUKe6EiV9eGB8qDidesiAXH7NAWaarZdIzB53RORCM/T+vLmV4V7VDV4JGeToFjk6UDkfs1uAIGnSTo1rOp9hbD8LkLyBNLKGr1d/B5/JOnZBfh5sWqcNwFsfSFtJSeku4MW86XpqFLXI78cwOLGm1lYJ5YQU3wsKb56poLkSvMJB2Frg4+6WOEto4Xgl6s0gEGnVf/NjGS2O79n5ebLGbJHBGe7XNDJqMzrIn0Dvz/MPJxFVnICnHuJne1ns3xKjp1U7y4SkeNM5UyazYUTmPlRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nw2dSLUFcEFKl6hPz9ufZns4hOuytLhNmDyh8lfk39s=;
 b=EsT2nGBG2gAkZ7lXGYROOMfLjxkUW4v6WdKM5TqY+BzzQAPv6t7yZywhey66RiYG153u/hQ1yhJ98q7kRTFIEf/8MAjX2PKwjLhZ+Li/a7lxrqnLs2QNy/7BaVoPePu22DBxmXBpiVV1eA5LCXjnB1mzLSBuR3WsSFWGDMIHh26jZwt8Y5NdUEgmeVoCzzD7krlxKXuOLnbS3kfTsHcLdp0eUUvi/uRJ2R7ZJ3eiXukItXYi9WwwQ7Fed6N00+XKe4VCC00Nlv2AjxQnPsTCM46yB05+yNEJZ3SFaBy8uYqwwsfadkB9bR24+atlaVeBjeLP12eRIwAmJFy2UAYl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nw2dSLUFcEFKl6hPz9ufZns4hOuytLhNmDyh8lfk39s=;
 b=SLZxQZ6PEkgBz7lfrLCHG/hoC98YvVtnuqZIyijWZC/0+ZHGY+fUAQ/4/frsKQcHqFNrz+4pERYtvbd71mEBc53iSX2KQtZK06YljAowGWPvIfihhvLiuVGR7179FXp89+b1fBUvZPp3NgDdorxLhNa80gvMPHLklPZ/XH9tO1Q=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5570.namprd10.prod.outlook.com
 (2603:10b6:303:145::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 13 Aug
 2021 14:13:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 14:13:14 +0000
Date:   Fri, 13 Aug 2021 17:12:57 +0300
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
Message-ID: <20210813141257.GB7722@kadam>
References: <20210813113338.GA30697@kili>
 <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
 <20210813135412.GA7722@kadam>
 <2917a1c8-d59b-43b1-1650-228d20dfc070@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2917a1c8-d59b-43b1-1650-228d20dfc070@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 14:13:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afc7eef5-f5d1-4104-7a5e-08d95e647d0d
X-MS-TrafficTypeDiagnostic: CO6PR10MB5570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB557077971FBA20B73FFB1A308EFA9@CO6PR10MB5570.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlosogfDow+Xj17XmB0ub9eiYAuh8+sw0ggXdAwj9IWVwv9YjQ0NOv0SGcsIr3/fecn7aIp0cksp3CljQ5x/NbRH9fkNLNgzMgmHq/z/9HhQMObU7BEhsAR1uVnZXnQqL/u8p2l6HpvVVu9IbYpjuQzc7cZiXLaafJ3lMGiz/4qXu6fa4zsnkcDKL3Ajpa3LcgRw6jngdQMnyrZ9JcmVcRugh/lYC9H0Ef/n3r+9UXEwJy69WPcs2Q7j36SdQwocoyMc7cjRs2Vhouuqds3/dpbahNsYVhMScTLE6tJu/2LIudiNv/+XEoKXS4ULDeEYZV4LEXZT3S3iJuXmW/vWlOcVRo/WNYTYNFJB4xNK6Vg+5pPvSdyC8C1Xdk5s+PXqDC8/fn5icXpN+LX9yRyWIFhuKhOidAtomBGSDxZN9nWr6znDZFPAnCNT1q53nks4NytBNfNEtXYrnJKFf4gk8NCHUMWqQeD6pB7SOsFsWIutmVkDQhf9UtmK1xuuMyEM3hLEGlKvUUdroDD9WSvXNrXhAX5F0A5t0cORQUIjEygotW63H3+xQFtxl1pLBplnzL1jv3mgoQoxUE/A0ALjoYjNFhiwxKxNHGFGaJJvpWqBBmzOpbmQOo6oQAvH+4ltJJmAANbA1Psy0bCenLsOSAO8WLc9iC0HEJc39TTjGgmneSJCf9XG22Z8+4vMuzTt8Hcd+diw1Xqg52kKe0FFjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39860400002)(366004)(956004)(33716001)(44832011)(6496006)(33656002)(186003)(66476007)(66946007)(9686003)(55016002)(2906002)(4326008)(478600001)(54906003)(4744005)(7416002)(26005)(83380400001)(5660300002)(66556008)(9576002)(8676002)(8936002)(86362001)(6666004)(6916009)(316002)(52116002)(1076003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cQN0sJON1SdktvU50t9jdeIXTQ9qum0VG3L1L5r+nKL5kPb6D/05Aj7NC7T3?=
 =?us-ascii?Q?W6Rjb9XRQu0unqYpB6EBJhl84hRIumIrAE8+QKQ/QJDhGHNnC4aXUPS6W1XQ?=
 =?us-ascii?Q?7I5TcyiR9ufPSLpgaBSPWVXC7LKm5W6LSOvVvNYzaJwk1m1nhn7Mif9ieM4E?=
 =?us-ascii?Q?n8slvTlX4HtCCiiVjmjFO3mG0o/6TUy0ZOWkA9fcq6JVdDhaSsHM85w5XrGy?=
 =?us-ascii?Q?UR26EwkiMa5QwW5gRHU53YBlZUih5liv9PqxtaVJjP7A86pyt3QJDMWlM7fp?=
 =?us-ascii?Q?WbAX5uftJp4zAcdAAOfl2JKsT9qk7DwQJ3k+xgBZ+NBFVbO2a0oXTqZCfLyy?=
 =?us-ascii?Q?ufK3pkpilEiRKZ+wzehnmvSn7XH004zxOlteDuE9zKhqZ9E5jjaO/UPVFO6t?=
 =?us-ascii?Q?z9Oh4qM8oiaokelaHRnLx8dTTlH32uNZk9Mz0I7mrCblXyp1KTtixkz6/+F2?=
 =?us-ascii?Q?GVaxqoNqeOmqDReBJfzatjRs3cfjuBpOuF4/4N88ktIPcpgHVIKK+PfHMvLj?=
 =?us-ascii?Q?Z+ECwxD0J/lpQa184WUW+DvagnQlJgg1BGsK2C4p5zAUiStRTJlUWpca9K1u?=
 =?us-ascii?Q?sX0Q6bD2dTK9ijqFrtpLIEEC6Xqqwk0qf/UO7qFjCG0xtibyJabohnSTd0kQ?=
 =?us-ascii?Q?9Y+nHzZZ5OSlDVKS7IbdWyiUSsHDD8/YWeRwn9Ax1kq8gTnGiVwJR0shIBoD?=
 =?us-ascii?Q?0gM50PTmLbgiMgLHkVpJMDxkIkIm9BYRByrsARdxaOtmSbn4GwPEm2B+6cuJ?=
 =?us-ascii?Q?zEDJ/GJwn1P3YzW5B3kc6vCphUqHpXW5gStxTZFRpaGEAKD7tSnrgdocrysH?=
 =?us-ascii?Q?Xfa5MYFWW1MKH43uGiUmbU9JH9AKDe+vqaL2XFTRZRvpmiDMmlO/o6qPcXzt?=
 =?us-ascii?Q?ky11nJeEYOIUfu3JBrEN55KovHf1ccjK/KBTAnncSMs5gt3DKXaJ9ullRCqG?=
 =?us-ascii?Q?PtmTkOt+GW0flIGlX3Gg27XHg9wMdVhUI35FseE9Sd3lNPjsoGRue8TXL4pZ?=
 =?us-ascii?Q?MlscD3t/St2Rbk4QNrxrINn/s+81Yo8wYl+yJO9aHQZ4s9YMNszS4iFwYPwM?=
 =?us-ascii?Q?WhKy9tMwsU9xXII02tT8LH0Zze2yIPTmx3JiM8U5+mngQt6tHTV5ns5EhmnS?=
 =?us-ascii?Q?HMt1w7hIkl1e4dnvlvNko6OUZDofI+8pbDHybfxzW7/wuE2B/swoT9Yi9Vev?=
 =?us-ascii?Q?txiXSLg6NZ2nJhsLZEXPEzzmr3Rll4Lc2+ZZwNqQz9MclLETvSbw9OnNNSa4?=
 =?us-ascii?Q?oHupv47QM+ovjaUWOmt10y0qIo40N/oIXXbpiLvYZi+iVQa4TbImhMcJ9ZfF?=
 =?us-ascii?Q?KkzT9nJy/ejz6MLFhZelAFXG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc7eef5-f5d1-4104-7a5e-08d95e647d0d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 14:13:14.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yLaQaQ14L+lqo0Z6nt6zCD7tV3XuA5UPaVFdKwhNcsS2tX/oscaSZ5vexN9MRDs0ic8efo3jawj/0Mz9hz2qvHmkvoq8R6lX0OorAc9BGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10075 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130086
X-Proofpoint-ORIG-GUID: r_9l5bSAYzaB1xTAeOd6mJVYrCEQXOCA
X-Proofpoint-GUID: r_9l5bSAYzaB1xTAeOd6mJVYrCEQXOCA
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 03:01:10PM +0100, Robin Murphy wrote:
> Indeed I've thought before that it would be nice if regulators worked like
> GPIOs, where the absence of an optional one does give you NULL, and most of
> the API is also NULL-safe. Probably a pretty big job though...

Yeah.  You have to write a NULL-safe API with optional feature.  And,
yeah, it's a lot of work to do it in retroactively...  Too much.  I'll
just redo my patch.

regards,
dan carpenter
