Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0733EB960
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 17:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbhHMPqZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 11:46:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24806 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241141AbhHMPqY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 11:46:24 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DFjbB5020913;
        Fri, 13 Aug 2021 15:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=XuaVzbHqvAGpGq4L2CIxHIs19ouPuQ9UI7WsAQNf2Ag=;
 b=R2PY4QD1KPaztG2JtCg+hhqPRKMScaj3OlXbNBSZA12muB45yYHirePpJ8+aNzsdA1/o
 OoXD9lPcpFUuB7kSn/G4sUPxMhbD5LlDIDtqzch8LCdUB4YsRh44HVQk0v5pENktzAxf
 s+mbnYnxwYNWr2HnpWBZGJ66sGBTyOQvZuPuhkbUlkd0MG/RrOdtNMQLe8RhJX0bP4IU
 8P1OHkLPN4K85/akJJXCImoXPgra6yPGjH7RY4nw5SnHJUYrSfYlA39AU4pT2kiBUdm+
 lHH7qQnYGMvJAUuxyiZu3I/6BV5ZFVxbA4KKcTkaNXC1aPG78zABbiXSwzU6wj0EI7XY Ug== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=XuaVzbHqvAGpGq4L2CIxHIs19ouPuQ9UI7WsAQNf2Ag=;
 b=YVHcKKyNS/UYSBZhTIzR1CyQcJW5UztypkVUcOcbnx/DHaUUkv52WwsOt4ffsQfi6TVt
 5mszS8ePsURm2/VTvuRTbRVoSB3pjseE3SLJXjOgquBfyqLUReXeQJHZ8eOenO1HYmpp
 UPvdBhciv/ssQPfa8z03V8otRW4GqfHLohVJNs4fJDObPGvbB2HD3476p+HwtZbTWYZa
 Yra+Uwn28cF/7qqT1ocDYb6DSLfyeQbtopqXo8WMtqV301i57tVSkUx5zK+MxiWCOqx1
 F/ks28Li7quPuwQjlnj3Z5h5l6l6/Y/phMbbo3i3mJn7uX8c1h6wV7veEgaLJxpsKLzW VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ad13vba9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 15:45:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17DFaKwT166728;
        Fri, 13 Aug 2021 15:45:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 3abjwaub8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 15:45:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/GpiH+AE8dAYpenLMypXCOe0zfXDrwMhm4XnTBj63GAqzOMPA2Dh+CJcvd5sVNjF/2lzibjYqu2kJjKsCCxMs4fvbhEgwIoIlOJ73BlTFeh6eRekFgFtopgV/3L24S3Vloa5eDm1lwesGsLD0o0PgeapZIPjqBWtgHbns0hNF0WwOdrFwZRphz38r6ooYs/pN/qcAmHzKeCkfayaA+FJ92xy6bfkjxWfGhsX1DNOwnV16ycJP2tiO/DrFS5e+IOnE/i4WUPNLYUz7V78MIInOmcXjRRSrfJUUn3bRKAFupiXyBjn4PwqPdfGnKzQwaTK77Q63gY0v/q40F8qLGQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuaVzbHqvAGpGq4L2CIxHIs19ouPuQ9UI7WsAQNf2Ag=;
 b=dakLdeg/pgkGxYiNJukGhiMChfFpZ/uGm7zFdI1a1OixllCRB//OzL2ehTQCNUJkfWKLlDO2xkRoJQKUg40R8X1x1OGQng+DYaCKGYr6xEXmf10f0XFBzz1Z3vcqhpWxTRajrQ+78QOzGH9FCOvhGXv/Me0AG0gCulq8ASTroW7Zj650WEPAZGzS2i2XFbGooBd8jc9jYTnvdawuc/5VHIrch6ItTuvJ7YKx8ZNSPftlP1MAsuO3ESWClZrmM0TQiX/PA0VhGMfqLKN91nzGQ8bn3Bi1I2vzmkKA37JjGIoa8xbyywOXIV6+24g8U775JFTF7xnY2PD6zHrj9XOSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuaVzbHqvAGpGq4L2CIxHIs19ouPuQ9UI7WsAQNf2Ag=;
 b=GvQh8w48/1VstkJqtgR7NppAAq10kHg3O3OUbboYEIw3LDDt9JzopDjYjpsnL2hYgeDatN0yTHNbZYMevG4EYGtv9tweSGBFDmkqL8Bi7Z9jPYMnOqa3ljQagz4ddXTyfXdnAofLDooQMQPw4J8XvOQWoUmlMhk10LL2HRzfDtA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2207.namprd10.prod.outlook.com
 (2603:10b6:301:36::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 15:45:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 15:45:24 +0000
Date:   Fri, 13 Aug 2021 18:45:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference
 in probe
Message-ID: <20210813154505.GC7722@kadam>
References: <20210813113338.GA30697@kili>
 <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
 <20210813135412.GA7722@kadam>
 <2917a1c8-d59b-43b1-1650-228d20dfc070@arm.com>
 <20210813143250.GA5209@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813143250.GA5209@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Fri, 13 Aug 2021 15:45:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43758e46-9ad7-4349-deb8-08d95e715d53
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB220776FB2AE190EA7110CDED8EFA9@MWHPR1001MB2207.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYaM+20MDnlGU1Y2fjzOa8yci3h2fEtlpASSHNEu5iJnpXOKdvWs3/WAGMgEGHCJUwCDTGZYlkmKPMDU9wC/duAX6nRKz1NyqfKEymMu6+Krd0IvR0H6DM8xIDGP01AanN/qZtQZ7c3qrefI1u6wrPC8KbD8iPg9T7JTB8ZRy09S4SMQGZ9cMAeWhdeYn5dsy+mS25tke19YMGa6asUojThVgj40TEbieuPVujF6lYDXKZlPtbN+wmPT4/9nmVUatdo9p+Dqc08twgtZ+hRt3mlJuU5QomAHiT4ozUZoB+XlJzjpUcTXOqknQWW7MZggSnD2oR9rJJkOfQ67F7P3tZfwRJFFsrTswPD1GgPYeBmmnrPDrSJmHdqeDIzldN/6pBN27nCWmhrpjAgoM2Iy/wXRuAWM9ibvhCoKlvCHlHYmCcoI8nHiL0D/9NN2xIWQDgdkcoK/pQsQkxC/WxEPGOPXQL72G6GGQoqL8DoIwl5AWs2d0GmNr3slhuPZi8AokWWYjUuQhI0rRWO2ypFC2RZ8jWDgNQP391Re95H376WOztnS+x2C3M7pvLvczcNiXbRbm2cozSlFnS9oFVBpM6fFtlb704rAN3BozP9C//8/PSZOsXGCdky5Ms/KXZM8TtH4O9I9BqUkKqAvNt6Hh4PRjKSlFOVVEkmLicLvO6fNvklXqk6cQs9qnwDXmjgLmERazofMBO0ki3hJsTZEAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39850400004)(136003)(366004)(66476007)(8676002)(33716001)(7416002)(66556008)(86362001)(1076003)(2906002)(26005)(52116002)(55016002)(6496006)(33656002)(4326008)(4744005)(186003)(9576002)(8936002)(9686003)(66946007)(478600001)(38100700002)(38350700002)(5660300002)(6916009)(6666004)(316002)(44832011)(54906003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8PRBIRoUkqs7vJzjGsGMtFZ+VOWc0W+sgXj+AD1D5JRfZy6m4Uems7/+xmbc?=
 =?us-ascii?Q?AbJLTkvGotinmro3bQA5PVHLpOavcFY3g9jOyu+RfpVTdN6d48OqZs2Y6dxV?=
 =?us-ascii?Q?osQU+WbNmO5RZg0ZKdYGTcrQuLBZp0EOzGZRVZ6oQuxLG+lLICdYqOgo7pk5?=
 =?us-ascii?Q?AMz9SzscdCG6y4qKmbOgnABmaCrEpi7x/I99UP2dcaf9Ch5pLnNUCK3NqHk/?=
 =?us-ascii?Q?fCsrKmippKll48Jr4fJ2UB+RVcwQiYmemQLpcWdyBFms0wTW43FFJnm+eSAk?=
 =?us-ascii?Q?xZAzgyPteJndmlnrW/9sgtMwEkpb6YqWaclAenT+h9Ni+5EO/cIgfbK72Ena?=
 =?us-ascii?Q?RzOfepPRg7uxcZm+qSyN9kr+zGGN583lPoKAZDD9ioWBduj3kvaZVP826xxS?=
 =?us-ascii?Q?l9sukZDFSZBn15nZ6R75OLa1rDjNXGA2mxpRQOTdmkysy4eAdf9in91FnPOa?=
 =?us-ascii?Q?L5R6uA3fDuNyT+fZdV2hOgkwO0ad8VxaedtWKZthPB3LFZCHbstkvTU1AuCP?=
 =?us-ascii?Q?7Hf3LGrR48Q86e4RbyZeaHUiBvYuQlRBuSxn1LycAVe5DbCNAIVbOwwY2U+r?=
 =?us-ascii?Q?7phOZOL7pJTmhQXcXDARe1ntVFWK49yI6vC84YtsAVKTiVVELF/hry03df17?=
 =?us-ascii?Q?9B5PSvk8USvFUVTeVOAiv7XspxGfwi9pvAj0SEeiUiiydRvFs3ymx7/R590B?=
 =?us-ascii?Q?I1cBiDLbMCRfpP/s2keSEG769wmmVXhOSkty1rj+GDGZi2GWPsre3CHJ/36p?=
 =?us-ascii?Q?A/nl7xX+D+x0/WSiASgBhIDvfM/ygVgS7NRVFlmBt4ESa9r7l40srpkUuZ1m?=
 =?us-ascii?Q?W6a3K4mTaP8+nriUsOZrS7X40Ztc2v5nDg6+9AkCpo9fqOW+cQ05F41XbQRG?=
 =?us-ascii?Q?+e8YsEJV+wZKIVIYkeYV/LNpL280I6lC4GUQoCb3sX3tA4jPlPfttHc//2+A?=
 =?us-ascii?Q?FevlvRWZhm8tDHw+RxZe7/cFWl3XHrVdcs1cW+SWWWi3N8bF0Al/NDx146Am?=
 =?us-ascii?Q?+AWkZR3ZRYX+s8UwRB9bnr2YBNPajmGxVDilI1VOHGjztIim7AmAucTkN+1o?=
 =?us-ascii?Q?FzF/bgcwbHObnV/johQTDpc0okvUdP7KIM1KWe88BsSbtikPi35Npr1RdFWi?=
 =?us-ascii?Q?V/sTMBglPEvxfc21l5bJ5EarecSkwNtw4OngnJwra9i1kSPfdNVS/OSr7z2i?=
 =?us-ascii?Q?EUt8tMAeYmOAy37NAzHhFNQITs4Cf4tg/euhrHrruieLA5l2cUuEkXiaXBwJ?=
 =?us-ascii?Q?mozR5iveBX+aXkO2AC8VLlF0ktx2CS69CDIgkQgX8oKbSnuOwASbvmwl6YO3?=
 =?us-ascii?Q?UrHnlxdblG+m5T6xDP0evDI4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43758e46-9ad7-4349-deb8-08d95e715d53
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 15:45:24.1507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Y6vgeeMJeuV9VSOhskHc5iPoHHnMHNcmfMd0CmAa9r/dtnwZlHDDR2U2cUuZ5QtJT4EJdOOLSJ/h0uKzktaDE/AKBjKWniO6eQSewu6r2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2207
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10075 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=846
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130093
X-Proofpoint-ORIG-GUID: e-Zv5rCgByIZ9CGRVEjncKkZtHc87IMH
X-Proofpoint-GUID: e-Zv5rCgByIZ9CGRVEjncKkZtHc87IMH
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 03:32:50PM +0100, Mark Brown wrote:
> On Fri, Aug 13, 2021 at 03:01:10PM +0100, Robin Murphy wrote:
> 
> > Indeed I've thought before that it would be nice if regulators worked like
> > GPIOs, where the absence of an optional one does give you NULL, and most of
> > the API is also NULL-safe. Probably a pretty big job though...
> 
> It also encourages *really* bad practice with error handling

I'm not necessarily 100% positive what you mean by this.  I think you
mean you don't like when people pass invalid pointers to free functions?
But making regulator code NULL-safe wouldn't affect error handling
because NULL wouldn't be an error.

	p = get_optional();
	if (IS_ERR(p))
		return PTR_ERR(p);
	enable(p);
	...
	disable(p);

It all works nicely.

regards,
dan carpenter

