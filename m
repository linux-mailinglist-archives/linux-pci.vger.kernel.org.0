Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7BA6924D4
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 18:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjBJRvE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 12:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjBJRug (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 12:50:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC651C7CE;
        Fri, 10 Feb 2023 09:50:35 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AHi0j0028173;
        Fri, 10 Feb 2023 17:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=1nFD90H56Prcw4fsmUXAbCFMnoUHLNx+v63tLxNhAcc=;
 b=AUipF+TJ5KcV3htVutQEuBPwTmNszNrzR26pUK2GosC7Hx/Bb6BVFtU3dRSpGTLruMRc
 WYUFI7Uy6IDWwn/UewsmYhIwKN2bOttJAfqgdh0bNUltpjG9ylMoiDMhXBiE/BLb3z14
 fXE+5BTZGu6/H/A+Nw0V8lQOXFiW0nP6bk5JWYOOGcu0o9IvYc8/TqudQcrRCZ8J3br1
 bMMkHmPCmgVn8Nz2rA+LUILk6O3DtVl/EN6jy0JSzneJ46s0C9kC/tHFV0ud6jXi+TXW
 uRoV6JuOTEgdrwla+HPH//tDalqkz2OpCRPOvaAow+fl61URf2y3+grW0g7BQbOXTIok og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfdcny4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:50:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AGFCVb025720;
        Fri, 10 Feb 2023 17:50:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdthn1gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:50:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9o1B+gXpJpnmeBKHP8LkGsE8Ms9MHC9/dbbcBIXHvaqGPs9MMnYmjm+S3QqAkHuQ/1Nf9TBRYWrZ/QDX1Jk/QUqnBIb6czGdMp0LtpQf/TCP8tqWuMA3M3dRd3CvtTTNn36yN0EV6z5F1zrXP96Aif47BzP07xThiZ8H/c0B4FCAfeYl4JeFpt4cjXeY20VSHjOdhuGgC7i4FyOGq7goTD32kysY9eworfk34rEXDvfWcFzAHzm07B+knOCCo2Uj/pRBbWATiq+wBLu3YZwxXoGPGMQxryUVZaoNMEUh4grCi3a/2B6lcd/d9b7zKvqtL0NNOITdGfx9fuIHdJ0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nFD90H56Prcw4fsmUXAbCFMnoUHLNx+v63tLxNhAcc=;
 b=gIPLNB0oKA1x/TS6a7nefjMumzhksAy7Ia8uGj35Eqw1+QlmiDEPVODLeNNJs5IfUL4bhwuIIoEph8GOdQ65XwledOT2huSw9jeDn+RaXBiLNewXabiq0rfN+q70EUEbhfiiZmxS5bt4pL0/O8ktW6JV035I9Ik+h+ooIvYV6jlMHtfqjUeioxUp8mN8DvRYNtMycxahDTgjRgcev/4pJmXf3Ykr/BPxRnHzDtqQqr0JmtYAulMK2DLrpx8o4xZtuhmU8swUn9RdOm8Ouvuqhtfhfz7fXs3oxYcHcTuRX52HLtTvE/Ia2xh+xOLSmVXiuCvM+WRQ6NuNeXahqCM5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nFD90H56Prcw4fsmUXAbCFMnoUHLNx+v63tLxNhAcc=;
 b=owe5pygbPw30Yiw2e4R9rZcuiT91WScWw3k4NhwhrhlqGSBMTFqb+zwW7cOj6YZr0CWbw2m0Dtmy0jPFTwVVHGwplel7fbIo1F7VlqRuK08JJzVIyJU57FDJzqhhk0NCMU7jV0xuA2f92hUC3VHnKT4uCCL7MqAKQRLQ7kmeOT0=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM4PR10MB6256.namprd10.prod.outlook.com (2603:10b6:8:b5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.7; Fri, 10 Feb 2023 17:50:30 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 17:50:30 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 5/8] kbuild, PCI: hip: comment out MODULE_LICENSE in non-modules
Date:   Fri, 10 Feb 2023 16:47:46 +0000
Message-Id: <20230210164749.368998-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230210164749.368998-1-nick.alcock@oracle.com>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0483.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::20) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM4PR10MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: f90b7bed-dc87-4d70-cbac-08db0b8f4cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GirUxlxdGjSGWVlYYpTXTIEEBtW2Mx5oNtPhS1bhNZh7idZ/m+glyim6cB6JMSBl3lvQo/t3GwBzLiHUXwwUHPUnHyB/XoNuz0F4/Beou//aGuYfT/aiVTuseXpQyOfipOmVlWhF3fzJKS8WMeztkq8e4tretf4L609SUOxRG2JbGHVSdEDhgQnworew2kmIYOx32igXgtejYUlAf3cGxHPxJ/SxVryvMsslHticxKu4BE7h2YZpnjLPItejOy8iK7WxziA+fi6Fp0kUdPfp5FD1Al/yW961AQOOrRt4tFIQFvyuG9DQdUP66aAGKzihXu/Of0bXt2NFqJJseTxVYuiZqKj/AVm467xMhFAnS5K215XuxVUicz/WPepImNVYUT1qcho81MBtgWhch53ip2gCQUO5sPjSWyh/yPdaHzqj9s2SxSl593Ieb+3kSgGzRBU4MEP0gyw03MLUH5PAkPxvL0JF4lqjCsNkpbrPBZZ4einlpsktX5glIcsBAdwGZnxxPbdO78wsm5noyGMtsnun+HOXveMJYpg+WikeuU9Ojh9offK1Wf7AWP9cD83+AtLI5P1mA4j7FME8gCguE+MjZ0Ie+a1g3dxqnF4A+tyWe533ig8whNs941EoxWWBCQqNdT/0pImdfh7OBwb2Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199018)(2906002)(44832011)(36756003)(8676002)(41300700001)(4326008)(5660300002)(66946007)(66556008)(6916009)(86362001)(66476007)(316002)(478600001)(6486002)(8936002)(6506007)(6666004)(26005)(186003)(38100700002)(2616005)(6512007)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gXhp4GGff6Obs77jT0w7L9kuZeaQce/owXQOyu+J9O99iL14trjTaZYTTUJu?=
 =?us-ascii?Q?YrJntCtDLF6quhGDz/Jq2QkNou8gBErDijn2YuJQ8wdtk3V5rFFtZQiFA8uT?=
 =?us-ascii?Q?cgYZqI2VVnVTSYV+rVrt6HFfQmNhSTF2h7Ut8YB5jIcIo1kKIUXOiP9ixC6o?=
 =?us-ascii?Q?OibbEioF+dyPKNlV7XDG0by9tg+nUtGSQQO2u8mOPadiLdrKvQR5dJ26Bq2m?=
 =?us-ascii?Q?WbR27GmelfjUvlCjVhkq28G/ZGQB8vOM2I50+JQZvjkvwHGnbvG2FCQRqgNU?=
 =?us-ascii?Q?gNRkCXHL66sL1nej53hMHr9QpYyCBUl/ZpYpJJX1WpPB/n1lqTj81qsjk30z?=
 =?us-ascii?Q?u604MAPya7nZayhRwUTftvExfaL7XzJt1H5nn8TIJszd8lJYlBImufSWyb27?=
 =?us-ascii?Q?lxqRV/wX7N2oIcVl9DH7bCkDPUfkFh6tyBZIY9QE+WBH3kF9yyRRGyD7lbqd?=
 =?us-ascii?Q?WewQFArbsfOMkg9Gu/UoZDyM0w0m5hddNkOs0Y0SED1xdFR7GLy0p3cox6Mp?=
 =?us-ascii?Q?h99RLhrg96ajazCw94MYIGBLVPbNS1xqz2zSbONhKyYrLTVDu6KyIr3D0UiF?=
 =?us-ascii?Q?cE9RmMNMJiedFsYU3B1W/vcJuLhYYx6gsEvx57z6+lpNqBt75qFpcYbDRmwP?=
 =?us-ascii?Q?St9RHk5dhlS3O1nOXvxzpfGPmdObvwyTcP7ytNfuqHOMP0O5vBgjfgFfWSc5?=
 =?us-ascii?Q?HqcVMDZS4TXoNQoUpEwgQVY66gQJWrzVuPH5reSQW6co7FVQHUmEGkfG8fte?=
 =?us-ascii?Q?oMW5xwPfgRAD90qUxOIdK8AegumkExOgHUZtgpI93MDJOoIbaoyfoRArMk++?=
 =?us-ascii?Q?a/eOKswQl5jT+/AjvvhAk528FCHUSD7F+erB7cPWT0Qp7XK5GFNssu+FreGW?=
 =?us-ascii?Q?Lw6rFCZHNElsHt5wkeYaBv1k63LGzgYzcfmvvIBlcurvt8318ATIMyTZpWIx?=
 =?us-ascii?Q?H5m4vQxkD4jAblmm4ZUtuOWYj+okMVCpfnvzXl1Trc4jlz488vCh9462TPEt?=
 =?us-ascii?Q?NzDK1a/at9fCPTY23yy6D9nPU55BHe5bGcgoYNYyIOL4fuGu1kEg/ACOEitW?=
 =?us-ascii?Q?OfQQZQyf3vbEx/1tKgNyDbdShv4UO3i80rdkf4CJsWGUOFLVgOrss5LpikYD?=
 =?us-ascii?Q?FhAbqZev2uXBddJmGuBmwQiru4C7nHY6mrVraUfJiD4At+ee0CRxRHgIrBoJ?=
 =?us-ascii?Q?a/1VIr7CBvA+iNuUBBBYrD60LTpq9NJL4Rv9HMV4okVj5oigEv7C6rIiP1XX?=
 =?us-ascii?Q?TXvbM+TIsKF4UOH4zHVFAt9Q6sSmX4xyvyM4DDo01s6XzTVfSHe121zPcOLU?=
 =?us-ascii?Q?a7+8/olRHbAVdXcjgi96yqQFdY2vbNVJr6s2ZT+UGql/cbNMRs3fKrdtDUCf?=
 =?us-ascii?Q?sHYlgvmu3+6kt9GqUHlhzW7srv/yUV8ur4EmqVw068/w49/xAkdx9etmGVei?=
 =?us-ascii?Q?Ae1V8SOShmxD1oK9qKh5u4Y0tfnu4a777KBYSHd1ZBGa6r9YeESMJn/dix3t?=
 =?us-ascii?Q?GU8VzxKRHstVfRyEokqBT+W+OCmjALuxKRaTBg58O61e2oHm5461EFqXiD5Z?=
 =?us-ascii?Q?0tvzGWc5AcMdxPQv2d3j8z1cRnKNQZlpqrojk5yeCIrsHfDprLzF+YCQOqWt?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: srzofP6K/hkyC7RWc+EZRmoKWLrPxs8B2j4zAqc7et50Gp/qSSL2paSXW0kAkE1U3o6oEAAYkPe1M030XG8D5VNwmr7fKOzdychJ3HU6ns8Pd08HAxmEj2v8L1h7TlPrt2/tfozcN+PUSMxX8DXx3Rgh0d1k5JrrXdUzC0wj/eY+2bgDv8pmFqBIdcqynKJmk85Ba7DcEsVtEttWC4qjAbghPkVEaDKkUu1T5iMMB5Bwx1FL7zgVwJk9K4zs/DVlgM6vgT9fSeymYLynpSR9QW/rLkERNTGk5ID7GIKfKhAY0ImLBdHWm77WCbhS3id+GiBwHaiTmAPp0IW+T44MGZvvix/HksiKBllr68xSz9vAIb87JAWO/5NG1eZ03F3pX8G4X2EZfjDkre9ma86UdqGBcEqw980GOuxa2rHexmM0COPDF67qHcHGLnhL2cVL9Gq+76/VETBM4vFOscTLDvFC+kovyIDjzMWtXJhFIUKgQnsFiEl1LPIbKtNyt7fCay6lYVj6k/bRdmHJHpSG0iod1jenEx/LLWA8vyxAOCC7USNzB/5syjllfZ/V+PjJcioONwGTv6L4S7ae+Ha7BFr8hIgqD+Fo40J7MLsRHIlsnQkdZaq4Xav+PCvbyycc5+RNjDYqdcnRvhj7GCotdhSbiSeclYHpoH62XGhLeivtJX3Dwdyp11eWynEfCzfxh5iPuEs0NKcvmRo+rEF01TroGJgc04CEKCoB3mUg9FDEdcs85wpNuibi1T384poZl3fV64o9EWk9+NdGaTXObzD6WCvpEtuIt5S9xxCX8f0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90b7bed-dc87-4d70-cbac-08db0b8f4cc7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 17:50:30.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Q5i5pSlwRBA3lz+kI8wm288EJnW4o8ZfgbKaLn8fZN3griWzwEkkA+Ead3NykY4hdCBdABob9azdG6P/8q70A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_12,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100148
X-Proofpoint-GUID: JckLdBNk2fK5t7gQIokLJl1j04yW10AG
X-Proofpoint-ORIG-GUID: JckLdBNk2fK5t7gQIokLJl1j04yW10AG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So comment out all uses of MODULE_LICENSE that are not in real modules
(the license declaration is left in as documentation).

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/pcie-hisi-error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
index 7959c9c8d2bc..ef8f3121ed82 100644
--- a/drivers/pci/controller/pcie-hisi-error.c
+++ b/drivers/pci/controller/pcie-hisi-error.c
@@ -324,4 +324,4 @@ static struct platform_driver hisi_pcie_error_handler_driver = {
 module_platform_driver(hisi_pcie_error_handler_driver);
 
 MODULE_DESCRIPTION("HiSilicon HIP PCIe controller error handling driver");
-MODULE_LICENSE("GPL v2");
+/* MODULE_LICENSE("GPL v2"); */
-- 
2.39.1.268.g9de2f9a303

