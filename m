Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDAA3EB176
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 09:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbhHMH2y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 03:28:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51506 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238816AbhHMH2x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 03:28:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17D7MSeo015911;
        Fri, 13 Aug 2021 07:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=rZ97Rv2DRII7G51TWZDShyFcZsy0JmRmfSggIk9eluU=;
 b=o2HPym+snqTKBiyPxXXnqL0iEcwzWM/q+YPpNiQVZDKseCLaphwqx+AjQl47RYFqXTlk
 e8DY2pcNh13wGc/kAa85h5O9xGYvBt30ju5sOTw9P6zp/PcWjVvClxEag139Py/1t4EP
 rDna0CdtJ1CAapKxijO1douBKAs8E10hrCagZRY5UD+syTKQWZsCQqXeYF9JQQDCpFOu
 37RcY52cg9YXP81ik7vIKndW/AJfXrBxqKouWef9VWl9yLc/6nlqsp0I4zszZquaxFWn
 V7L7C+EHmjXTnQ4B8jdjpCVhGKCZM/9dH8jBbMutTHbvrrttPTEgLPQB7M07nKfN3NLp eg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=rZ97Rv2DRII7G51TWZDShyFcZsy0JmRmfSggIk9eluU=;
 b=SiHlmFBdFBwOrJvnmXj7TraePHbtfdhAlYeGNa8aDN+wDLB8Zk60mxe0W3KOSk8+BgYj
 t5cq42+A4RGD55SMDoPUjgI1JXjghLXZRnmJAzmVZIxDdoz7P+z9mREvJ8KLx2qq/2a1
 an0SkLEliha0eTr7GuPA28P70Acr0iLmTs0jxRqEpyUjweiuu6DIVzZQ15vnThElcbj9
 /fyVusD0BdSZBwUxLrSQLhdv0kRhDO5sp/QymKk/6AA+8wC96Z+Le6b7MkZ66so6P/eF
 n7BAb6VLfmxfJe8ISDV22R+5xyldpjJc6iF8fFmXkzqHDmES7aTSXOHzhhmeXsKlsk8c VA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acw9p2q1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 07:28:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17D7QXsq008089;
        Fri, 13 Aug 2021 07:28:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3accrdjbn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 07:28:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmxyODho8ZsMN7btRnQfU7AzIrwm1tuwXqi3B9oWEvPpHeTkwtSdQHgVneq6Ohz2pdJPgJWjiFyLu4/c3j13YkxMTpW/whDD4QOdnau+Wk+OR+LmayUIxBTjwpTNq5Xj2PFOIX6eN7qix1u29Uq24/rkToMJLgllUFymdHXk0Jtup7ziqO6PAs5JMEGlszfSWXJeZRhROt1IIroOe1QMy8+JQcp+Sm6BZPwJkcntmpwJl7topg5IGhBQvoMbR/mIox2oyoRzFesMnw+VTtAZBKOV8YbMWlA0ApiIGS4xSZKwN3plRyhFEW+D2jphNI6Mn0gAONfTR5x+CHOAO5xakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZ97Rv2DRII7G51TWZDShyFcZsy0JmRmfSggIk9eluU=;
 b=lqc8qQYemh5er9xbbBKxrTvVGU5eciYFWYEnefBq8wx3ETZR5ECJDPJ2kfDc62FHTgY+E4U6KSaUAcQkcmhk7G/yHhGhQeJwSRnYKM36ithkQ3vco//OkJ97m64K0xT3oYPsYE5iAolMeEv1HZwHbNZmu+kUvc1amwei0fULTrqQq0i/4gr7nUNAKw7l55Sfju/Iq3DuCGlr7S6dIVXVS4tTykY3NnX8jxNOWfYylDgRjBYqQoQljwREmqrExgMcYGbOm+rkAEm57rLMZ0TGe45Bi/6ZP1xvtk9t2UEQ3MZPP2dVjAcv2tOWxWE4lSHj0CRakoA91MF8fF2c32BqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZ97Rv2DRII7G51TWZDShyFcZsy0JmRmfSggIk9eluU=;
 b=leJdyyqBnup/oxbmCgXcHQWUUizc0oFCAO85L1bA5L9em6NMLfTR/Zy0W5h+HRi3CDlsNWxz7qcM32vtIMX1m6tRNU4J60NvlVm5NFIvYoov50uaBqXvm9xLUzaN17vLDzw/0uSh/4xXZVEZ1rxTT9MAotZWYimMpUpVNAoTGyI=
Authentication-Results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1373.namprd10.prod.outlook.com
 (2603:10b6:300:20::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Fri, 13 Aug
 2021 07:28:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 07:28:10 +0000
Date:   Fri, 13 Aug 2021 10:27:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Stephen Bates <sbates@raithlin.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: fix a scheduling in atomic bug
Message-ID: <20210813072750.GB1931@kadam>
References: <20210812070004.GC31863@kili>
 <065519bd-d73c-0d0e-182d-6431914d0e8d@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065519bd-d73c-0d0e-182d-6431914d0e8d@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17 via Frontend Transport; Fri, 13 Aug 2021 07:28:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6be376db-8cdc-4b63-a355-08d95e2be665
X-MS-TrafficTypeDiagnostic: MWHPR10MB1373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1373573E35F31C2C06E17D0A8EFA9@MWHPR10MB1373.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZRJI+z00sE/BNJGLkKdZ8JMsRF2gpnIxX7tx0am1z0zk9oeCMB/yRYCytnWMwa+NGqxTi3Kjwj6/fKN7V+Zd8uEkb8FVmXX0KtjTv0OwNl2sLyVPpHNjYNCqiZF7h8kzDZ3sz1L+0GvJpbGxSfwKNn4HOwr3mAKv/Qo7SiTWlive3QiPYO8iem9w4iYxRa7lhfMEx0WcDzhDPYcaK+l836wehMbXMv0Sygp+wr4PUkMxiY5SZlOwjnG+o6MOu5gg8oqaucxpYxnCevoSj4aQQunuQTcFN9GBRBdd/+BzK2/euTFpqbuBkAM0KNVTdF+96N4fvcAlPJ1pJ4uebGYN8c3VF1f18WOZ/NXeI7zhC10U4OlG0DouGdSFJPj02KVnKASDkK1IW8NMH7GtlbRV9Ld2DbX6iMSG/HBzMZxZcRrSzu92xdunlFxGQFGP1Mq5BFQKVRW0LLuxttRDM0k11oml/iy3FuaCf6pYbjDIYHUkVvXjQ0svLQ6WuTpjoBl/ceDjImaebfoupwOzSggjOByiss4PzcxRHLCYmEu2bOQrGxvSXICkTo/cTgN0FwEWar2U9vRfjFrX7KgzKQYhInKJlAE5i6W6GR0G0Qe3127gHxYbRxwvap/37lCWSuw+/sj1X/X2lTFn+GZLh27NrmbuqdTyRXSVpqhJvDHpHiIxBj82Sduk1UhrB9aeJ4Nt2uzbwfhBHr3aEdnBY+EDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(376002)(396003)(6666004)(9686003)(83380400001)(4326008)(33656002)(5660300002)(4744005)(186003)(52116002)(316002)(38100700002)(38350700002)(44832011)(1076003)(66476007)(956004)(33716001)(66946007)(54906003)(9576002)(53546011)(8936002)(66556008)(6916009)(478600001)(86362001)(26005)(6496006)(55016002)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HcWwsaW9a0wf/QFowIwxpdiphpryowOwXv6+IxDMA7aO3637dopMoYvtvbQr?=
 =?us-ascii?Q?Uj7uXsG+n129XTkqhLqlupt8iBJROARmoUbjUFTx3Ii72TyyJ0yOlcaRW/fo?=
 =?us-ascii?Q?f/DA2feoagxd0Lu6s6Ie1ulgdlqkK1naClW3Z6hNz3YCNg/SnaM0yJyM6zu0?=
 =?us-ascii?Q?NfwpSTLx/Uz0uAjBFCsOhLRYn27mBKb7DY7nYk688C80Nfule5lJhRikJ0PX?=
 =?us-ascii?Q?tevkw4aQIvGyyAIQ0VSZAUXO3tl2u1mrUmHpIVPrw4ywRVplFxIJEDFOu6tj?=
 =?us-ascii?Q?K0+EVNOeIi22Utx8clgwfSIlBmk5ZqVYaP7cvNQAteeiEayUkH9D0RcED16A?=
 =?us-ascii?Q?3W8PsR/v4M1DHfD3KjMhCep8nJe/yMiujo9HDYj4kMtvpthQIOM3lh+UMWla?=
 =?us-ascii?Q?Giq4LLu6gpszcm01+sK/2LxL+3P3wYlAw3iBFxkzBL+0glVQsJibo+kcilKl?=
 =?us-ascii?Q?DFER70cR7sqT5YCjOTki0ScgWQdiET3iOuXNIdRztAQm5EClV8J/WTu97ubP?=
 =?us-ascii?Q?jXjFH0reVkRkmDfzAH+hEcZYeZPPabkrft2zi4iY2EF/yTWlqK83jcCE6cS4?=
 =?us-ascii?Q?27HGeuwLRp3jWWVrD3iLp9WEHViVhbaP53xF6eGqb2M49/ncujRcfBt00XqL?=
 =?us-ascii?Q?JWEYbOKmQzC2M3cdEZ6QXbfZlmCJrJFAbHAO8fUDav19q/UiuXWVk5CcKkj1?=
 =?us-ascii?Q?xmG55014VkZeC1Cqi+jzsj38j2b3lMvSxcErlP30nw1dqcxJvLG6vM28ycrL?=
 =?us-ascii?Q?HFVONR5suPAVFg0azdcARjXmGrlyS6uYb4oF0ucfwRFGR/lpnN6zdx2XSG9u?=
 =?us-ascii?Q?wVZzG5EtLvAHA22kENSPi1JU52JBp68kyI80TXS1+rRcjxOF8WGLZniXgPs2?=
 =?us-ascii?Q?iUp46B5lVDz359cP1BMHvGhaY3qKCXVFYaQ2oCliTWZsv6SfIkjVIMDL06Ve?=
 =?us-ascii?Q?82Ivod0eO0kJRi0vkwo2X+zO+r5AMlgcUKlgZIRQrNl4sjnoHgm9ijp7bu+l?=
 =?us-ascii?Q?TBm5X+nJ0I8jBuazSceWAXong5RB+bakiHe8+g9se1w9yd5I/ej/ojAWsOHv?=
 =?us-ascii?Q?oAyR07uNAmzTBoX0Za9UJ1HfmfL2b9r1Wq2qInruYbY7zEoXjJoTH9npj4pw?=
 =?us-ascii?Q?zzJOeQArCbkEpI77tRcarRZEuuk9BKGCV9G1CR+jTc8TENi97w5rAWmOWxB+?=
 =?us-ascii?Q?B399m/FNdH9AAcgughUG6cP0R1np60KF26OFUxiw/8WsikfmlhUnTlZnUKf+?=
 =?us-ascii?Q?mQZgVKNeSVM/Ae/XHWvZL2XzYcbgBWjkciWPVM/d6wlU8ERhbdkZOj5V55eQ?=
 =?us-ascii?Q?/I6u0fNRgsn4hsK7roQs1re4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be376db-8cdc-4b63-a355-08d95e2be665
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 07:28:09.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Gj/JuFD6e6rXmvhK4jvdVuS1rTn8T6ljb1rhjTiD28kzOGur86DGzAgc3q0BCk0kj9AvjAu7gumP5QtCwLKokSPXEdXLuQm5+WydO5/Oo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1373
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130044
X-Proofpoint-GUID: mgrOTIRjoCVEDvm7WT2VPr-fQdDZnZOZ
X-Proofpoint-ORIG-GUID: mgrOTIRjoCVEDvm7WT2VPr-fQdDZnZOZ
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 12, 2021 at 09:19:42AM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2021-08-12 1:00 a.m., Dan Carpenter wrote:
> > This function is often called with a spinlock held so the allocation has
> > to be atomic.  The call tree is:
> > 
> > pci_specified_resource_alignment() <-- takes spin_lock();
> >  -> pci_dev_str_match()
> >     -> pci_dev_str_match_path()
> > 
> > Fixes: 07d8d7e57c28 ("PCI: Make specifying PCI devices in kernel parameters reusable")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> This looks good to me, but I think the fixes tag is wrong.
> pci_dev_str_match_path() was introduced in this patch:
> 
> Fixes: 45db33709ccc ("PCI: Allow specifying devices using a base bus and
> path of devfns")

Yeah.  You're right.  Thanks.  Thanks, Bjorn for fixing this.

regards,
dan carpenter

