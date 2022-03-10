Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E8B4D442B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 11:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbiCJKEX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 05:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiCJKEW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 05:04:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B279D31ED;
        Thu, 10 Mar 2022 02:03:20 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A79xrb002635;
        Thu, 10 Mar 2022 10:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=3w3LzEDLsZtzGyBLl6Xu5SOAEPTNoU2k688dwbHvc+A=;
 b=1N/V0wyF/bPCRufdBKJv6vgs8TF9BXUXrgejj2ab7icKTDYLvUMzAw9Is53+sGIwwT+B
 aJfG1hEIMTQhcLzmKS65x33IDQCcov3S/RqoBR/pGbJjEafH+udsyNR/4jLB8BHNmwRn
 p2/MN3X/8rLTgcuPG8eSzZ913jZRKts+Janm4ef8mW8RR3YQ7mDd2icOa+xvfrXGLZKy
 7T18QYkTuw9VEa0O54mjSD+hPxCYviZVN0PYTLz7ZjM0WSAxpxaFOHxeTkkGRUwI5tZk
 lxUIvkaCgznSnNNZN1rpGK4NAF8RYtqp9/6nzgWrmcrXepayadiP7ZiO1sbEkvusyGSV HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cmj0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 10:03:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22AA0QS4055481;
        Thu, 10 Mar 2022 10:03:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 3ekvywkwcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 10:03:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn06a+27prlryaD9DO6K1Y9gqW4Fwq++7H6mbGQdtLx1bEpHdqGNrrR7Ya/0PfKYO2w06uSeTI5/1byaC0bCHaIAh12sLbEhIUGcxL88Op7qXdYcu63vGazu+SB7tHAiT0hRWmjBp2l9YUkN7UWdg4q7GOcG84gPbsxtzurm9midAPlm2b6KNOwEEQzhN9vtSICfZ8e5VQjzPBBxKYPi9Ov6+21qL70QyCmfZsBjJDIVGY6y8qq5nMrlrRb5o9AK8qcwtWgz4Wif8J+P5omZCE1Bs5+z/cqSncrKw4krU/3N9pUmDOo1IOlve6RlJc7BT9vOGwpKzrJYd5l6JGvOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w3LzEDLsZtzGyBLl6Xu5SOAEPTNoU2k688dwbHvc+A=;
 b=H3CtFQ+UIY9I+9/bLbeHx3tfc8mJRiZ1WR60VPXR08Yct+X/oxqdls8Zmuc47rgnem5gQUzx5YOow9HajEQJXXwngyKu+4B+Z9Et0Cbf8jDV0sjeJjmJq/ZYhlnUrvicQVyje+cdsxEQ59AhBZyrTIpI8ip/bmaDSuI4XExcdeIUf6bjejnNr52QEjUoTMgSpJHhmkq5AQrAc/jQAd5ErpJwzYt7h4mJEFCvVyBCQ50C3rFSph1PP84cDYHgJ739z1Y1o3tgPj4V/APviChXxBhQZzPyFEG11j/xRc1/mwnxBRvz7tYLxNzYeVzeeVzgBSbG7kAJnAzTGoHuh92V7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w3LzEDLsZtzGyBLl6Xu5SOAEPTNoU2k688dwbHvc+A=;
 b=d5rejkFZmPPOr4zQp3djNPGuVPvcXg3gKM/Hg0jgHO7/q2QK93A45ooEHahqGboEoGhGeGagHaq9l7kXBEiXkWxsYiFJMKP512PZ0czBYHgCMOtoqokuBrmJo6D6EXlM2cGf7WYsZx+Vc74dWzOE4BimAJMecEnvNh3GTaorDMU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3689.namprd10.prod.outlook.com
 (2603:10b6:5:154::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 10:03:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 10:03:05 +0000
Date:   Thu, 10 Mar 2022 13:02:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Lizhi Hou <lizhi.hou@xilinx.com>, yilun.xu@intel.com,
        maxz@xilinx.com, sonal.santan@xilinx.com, yliu@xilinx.com,
        michal.simek@xilinx.com, stefanos@xilinx.com, trix@redhat.com,
        mdf@kernel.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V1 RESEND 1/4] pci: add interface to create pci-ep device
 tree node
Message-ID: <202203100338.8jox1rCr-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305052304.726050-2-lizhi.hou@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 547d96de-4906-4370-c644-08da027d2b5f
X-MS-TrafficTypeDiagnostic: DM6PR10MB3689:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB368909F77F622928B20ABFEA8E0B9@DM6PR10MB3689.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3l/yEj2yyDlzsJJSMq5WPv7MxAJh4UTmIcR0Q6/TCKwlmQ2zdK0rSTW/eSLk+DA3b7UVGZXCKqju4jqaR0cNVCAtLmVEu2Bt2p0djO8k46/qN15QGuJNKcZD+zkSPoJDmcQUcSVt6invYG4ekovBdYWRqMt8YmTJlwK1OEVGijTjCJfISvMRNGAnxUrDMoIoHtZtBRzWWYvYELkJud1q5nEmbY6FIrFM9iuIy5zIO0qmldpUlfRRId+cvonPdQvjWEovB1xvSMAg8lz5FU8pkI/3gh6jCwFYEYudlauv1aTGGm5gpV2yJ789iqvhxsj5dcMs8BuAITUNQ9Bk0Tbu1zJGn5J80Q8Rd7w6qauhygr7mswu6Kon2HEWDK+VL1JbvGtKJgmU/qwAtpw3coczwb+iC46jPs8aNIp1xhn5xzeN2Ldn3+8AGuAC0sD4gLswmzcsD6shhsGmp5lyJXYRqJRDydwoM+VHwoyQopl7EKBtzcraduBOj5i16zsY/dN3LY6/YYZ/iNbtEfSUF12v/wa+EFPktcTGUudu7yi8rk9lxB6JI4gwFuVgzL/rudRcKg5GKZB+oN4QXp3kMoE7zif6aWQWunUIhJU/8r/sojYrtrVnRnHSZiQoG09sJWdP0JqpstlPZHLT65Ce32Zpa4SY2zEaQHOW9vkemsOZdJTOwouFWegmuMtBWWDFBKr1wBgMs3RVJ4zYuQPjOOVkA5KAZaEixfo3SnIX8anwEBcWoHnuPKswbVv2TZJjSkoD59BlEzAW+CH1C9n3v4Fo7PG25J15JDBTyXK6NebtdmD/BSHCtVKDuaJOajWZ3BvxLiuP2IvwgGp+H7K1yMtc0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(9686003)(8936002)(5660300002)(38350700002)(86362001)(54906003)(7416002)(52116002)(6512007)(6666004)(6506007)(44832011)(4326008)(8676002)(36756003)(26005)(66556008)(66476007)(186003)(83380400001)(1076003)(66946007)(508600001)(966005)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vNR+qSojtP3y8QpEc5OAq1JTwqswL+9SIQEHUMPyxk+fzFg4snsGjzHOYRle?=
 =?us-ascii?Q?/AJpAtL8PIoEzMmKGNt+lVzfBsaYGJzO8Lnpg6CauZvjLc8UW5cb354I0vLr?=
 =?us-ascii?Q?X/ylnnJf3hJJx1I7nogD+QpqOGBDbRenqfzXaatLsolAo0gCWSioHL2Af5wX?=
 =?us-ascii?Q?7eOIUtUXf3fW5Hx5W4kEgbTjfdS84cQDDPq+0Z43qiADATaejpTEhpEEt5Ms?=
 =?us-ascii?Q?SetzJUoapVx3/6xYM0uxSgZMPvOoizRxkypH+XMlPvjFV0wls1xKhA4lbe0Z?=
 =?us-ascii?Q?lEs0mNV6V2RZmEXexHjomp2jnlkLSVnE5TkbWWMRtXcDzzVRIek3A3zlN2Vp?=
 =?us-ascii?Q?6iYOE8GLPzxoLbdWN6zJv4VB4Onn6yYy0UBV8onkGIxsQLHcDwf69HcF6Mai?=
 =?us-ascii?Q?Fg59JrsYQ+zT2vt340gd/NkcbvHfmsGS8SEixpA8G1xfbxV/d8fQEVVDVNof?=
 =?us-ascii?Q?gpFUiEB6ClMJx6WYriiFJetqa4kP9aBREIOlUf0MCfUjCP9XNQ+cni/QWkX2?=
 =?us-ascii?Q?a3R9bLmWiYnfU9LJeiEoMxqUXBLxQyxVHjxq/n+Y6GdYdfuBNvR+RKZmSkYH?=
 =?us-ascii?Q?cWYhCGMyp9dpPEixkt0P9UEA+Lqjt6w3Tbzq0wnZ3JyUBKVCAfP4nXB+I7n2?=
 =?us-ascii?Q?ez6AowJxmSsXPIEs85vgUQ8Z8kporBB6AUaXdsUNUB/OVWnL6gts5nGVCu6W?=
 =?us-ascii?Q?jaYwcPVBl4pWqg92/3v258ZuMQk54ceWofAzwNQ7adJsegS3oW/mAvHvTrFs?=
 =?us-ascii?Q?N2IGnnHfv3Qe6wknxzycgrmNwoq4044XD8wEPY+zOuQvib2QJKFTd8bCM2XF?=
 =?us-ascii?Q?DEgt3vc1B1oOfuHbo943oXQuSdf4fL1Nl1SZhhbiEXhlh+rZ8nMBe6qFRhqZ?=
 =?us-ascii?Q?iX8wGynyT7+3FPvlE1OU8QD4+iEW0qlZWTkFBUI6dPeUzyMzT6d+IQqIgYAN?=
 =?us-ascii?Q?5Upmfq88TjzhBd9N7OHQuUHiDoin5Jt35UaGrkhSLqfajnemIs65wQGQHvIO?=
 =?us-ascii?Q?qxNBZTbIVGW1h9JtqdoJnjfU26isfARjoE0Dw5AZqlm5QFzXK0EWc4YlDnw0?=
 =?us-ascii?Q?PJboLlmHUipV6leiSbDsGfiDxW//n6HZ3UmFI7TFTvESaizvpq76Qpir23bz?=
 =?us-ascii?Q?PTt1tn8UefZNFqUp52FjvkZ+pD1gutgU4dTki4/BF4rqb9RJMpzAWlFSEgQU?=
 =?us-ascii?Q?jY4FSEmEwSeCGNMvHopDyLxs6wGmgI5eYArhEpEbVFRiHT7MZcOFCRtV0Zrz?=
 =?us-ascii?Q?BwClqhAlmgPXkE4cY0jUiOFXZUkwtfTR5CBmsYMbxPnSbahqacrhhlYV2Mce?=
 =?us-ascii?Q?sB53YRPcYcQUI12Hgzfm2j8m19BjkyOEf/r3dh45jBW0m/6IKhR9Ss77nPx3?=
 =?us-ascii?Q?bay24S6FfvaIpDqaacjgJ+rnJLigRZx9Tk+FBbYZ8u6TTZEJH+3Iv/7Smx4W?=
 =?us-ascii?Q?UBnsPkvqiAFt+T5tvNmju77xefDLopv848EG0yXVLjBIdBIVLx75dHTwnboV?=
 =?us-ascii?Q?dc6L+HYVRVWdLyQ2ga2dpzrWeEgkNA76EsIl7bOdzPoLBCxEftZv/RxAc7vm?=
 =?us-ascii?Q?2e57FG60W7SLKyXt61iPOB3ZoT59t4ehFhD6e0dUNKvPlElRGQs5b5dZu3Pi?=
 =?us-ascii?Q?tn5SeNDrijCCwnpG62HkZzKMZTo/HG0JSjckYxn4oJ4ILDxa4VtBKCWSwuOg?=
 =?us-ascii?Q?lhsaLg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547d96de-4906-4370-c644-08da027d2b5f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 10:03:04.9929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJ4YYbYzQXMMAtAJGGz3//KEDTMJVUnrUM9Ko7Sstgqq1nN3nDlSXX2ItZP4Zh6DapTWc/H2NGfns2WPKpNcVIEfiZmwr0EHhLwV2onKA1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100053
X-Proofpoint-ORIG-GUID: ijonzfI-6uMPzPkMZ_1JdJLjwgTmM0BQ
X-Proofpoint-GUID: ijonzfI-6uMPzPkMZ_1JdJLjwgTmM0BQ
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lizhi,

url:    https://github.com/0day-ci/linux/commits/Lizhi-Hou/Infrastructure-to-define-apertures-in-a-PCIe-device-with-a-flattened-device-tree/20220307-141939
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: i386-randconfig-m021-20220307 (https://download.01.org/0day-ci/archive/20220310/202203100338.8jox1rCr-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/pci/of.c:762 devm_of_pci_create_bus_endpoint() error: double free of 'prop'

vim +/prop +762 drivers/pci/of.c

3a2c08c0f0ef77 Lizhi Hou 2022-03-04  677  int devm_of_pci_create_bus_endpoint(struct pci_dev *pdev)
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  678  {
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  679  	struct property *proplist = NULL;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  680  	struct device *dev = &pdev->dev;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  681  	int range_ncells, addr_ncells;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  682  	struct device_node *node;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  683  	void *prop = NULL;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  684  	u32 *range_cell;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  685  	__be32 val;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  686  	int i, ret;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  687  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  688  	node = of_ep_alloc_node(pdev, "pci-ep-bus");
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  689  	if (!node)
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  690  		return -ENOMEM;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  691  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  692  	/* the endpoint node works as 'simple-bus' to translate aperture addresses. */
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  693  	prop = "simple-bus";
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  694  	ret = of_ep_add_property(dev, &proplist, "compatible", strlen(prop) + 1, prop);
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  695  	if (ret)
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  696  		goto cleanup;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  697  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  698  	/* The address and size cells of nodes underneath are 2 */
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  699  	val = cpu_to_be32(2);
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  700  	ret = of_ep_add_property(dev, &proplist, "#address-cells", sizeof(u32), &val);
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  701  	if (ret)
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  702  		goto cleanup;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  703  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  704  	ret = of_ep_add_property(dev, &proplist, "#size-cells", sizeof(u32), &val);
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  705  	if (ret)
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  706  		goto cleanup;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  707  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  708  	/* child address format: 0xIooooooo oooooooo, I = bar index, o = offset on bar */
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  709  	addr_ncells = of_n_addr_cells(node);
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  710  	if (addr_ncells > 2) {
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  711  		/* does not support number of address cells greater than 2 */
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  712  		ret = -EINVAL;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  713  		goto cleanup;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  714  	}
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  715  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  716  	/* range cells include <node addr cells> <child addr cells> <child size cells> */
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  717  	range_ncells = addr_ncells + 4;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  718  	prop = kzalloc(range_ncells * sizeof(u32) * PCI_STD_NUM_BARS, GFP_KERNEL);
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  719  	if (!prop) {
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  720  		ret = -ENOMEM;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  721  		goto cleanup;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  722  	}
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  723  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  724  	range_cell = prop;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  725  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  726  		if (!pci_resource_len(pdev, i))
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  727  			continue;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  728  		/* highest 4 bits of address are bar index */
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  729  		*(__be64 *)range_cell = cpu_to_be64((u64)i << 60);
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  730  		range_cell += 2;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  731  		if (addr_ncells == 2)
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  732  			*(__be64 *)range_cell = cpu_to_be64((u64)pci_resource_start(pdev, i));
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  733  		else
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  734  			*(__be32 *)range_cell = cpu_to_be32((u32)pci_resource_start(pdev, i));
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  735  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  736  		range_cell += addr_ncells;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  737  		*(__be64 *)range_cell = cpu_to_be64((u64)pci_resource_len(pdev, i));
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  738  		range_cell += 2;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  739  	}
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  740  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  741  	/* error out if there is not PCI BAR been found */
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  742  	if ((void *)range_cell == prop) {
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  743  		ret = -EINVAL;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  744  		goto cleanup;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  745  	}
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  746  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  747  	ret = of_ep_add_property(dev, &proplist, "ranges", (void *)range_cell - prop, prop);
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  748  	kfree(prop);
                                                ^^^^^^^^^^^^
Free

3a2c08c0f0ef77 Lizhi Hou 2022-03-04  749  	if (ret)
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  750  		goto cleanup;
                                                        ^^^^^^^^^^^^^
Double free after goto.


3a2c08c0f0ef77 Lizhi Hou 2022-03-04  751  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  752  	node->properties = proplist;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  753  	ret = of_attach_node(node);
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  754  	if (ret)
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  755  		goto cleanup;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  756  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  757  	devres_add(dev, node);
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  758  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  759  	return 0;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  760  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  761  cleanup:
3a2c08c0f0ef77 Lizhi Hou 2022-03-04 @762  	kfree(prop);
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  763  	if (node)
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  764  		devres_free(node);
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  765  
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  766  	return ret;
3a2c08c0f0ef77 Lizhi Hou 2022-03-04  767  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

